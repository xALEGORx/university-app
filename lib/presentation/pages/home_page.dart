import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtu_mirea_app/presentation/bloc/app_cubit/app_cubit.dart';
import 'package:rtu_mirea_app/presentation/colors.dart';
import 'package:rtu_mirea_app/presentation/core/routes/routes.gr.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(builder: (context, state) {
      if (state is AppClean) {
        return AutoTabsRouter(
          routes: const [
            NewsRouter(),
            ScheduleRouter(),
            MapRoute(),
            ProfileRouter()
          ],
          navigatorObservers: () => [HeroController()],
          builder: (context, child, animation) {
            final tabsRouter = AutoTabsRouter.of(context);

            return Scaffold(
              body: child,
              bottomNavigationBar: AppBottomNavigationBar(
                index: tabsRouter.activeIndex,
                onClick: tabsRouter.setActiveIndex,
              ),
            );
          },
        );
      }

      context.read<AppCubit>().checkOnboarding();
      return Container();
    }, listener: (context, state) {
      if (state is AppOnboarding) {
        context.router.replace(const OnBoardingRoute());
      }
    });
  }
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar(
      {Key? key, required this.index, required this.onClick})
      : super(key: key);

  final Function(int) onClick;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkThemeColors.background01,
      child: SalomonBottomBar(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        currentIndex: index,
        onTap: onClick,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.library_books_rounded),
            title: const Text("Новости"),
            selectedColor: DarkThemeColors.primary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.calendar_today_rounded),
            title: const Text("Расписание"),
            selectedColor: DarkThemeColors.primary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.map_rounded),
            title: const Text("Карта"),
            selectedColor: DarkThemeColors.primary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Профиль"),
            selectedColor: DarkThemeColors.primary,
          ),
        ],
      ),
    );
  }
}
