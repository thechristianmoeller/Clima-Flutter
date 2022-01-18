import 'dart:convert';

import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';

// added in the "as" tidbit here
import 'package:http/http.dart' as http;

const apiKey = 'd6fcb25609c107af6351f2c511b41d03';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.toString();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   String myMargin = '15';
//   double myMarginAsADouble;
//   try {
//     double myMarginAsADouble = double.parse(myMargin);
//
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.all(double.parse(myMargin)),
//         color: Colors.red,
//       ),
//     );
//   } catch (e) {
//     print(e);
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.all(myMarginAsADouble ?? 30.0),
//         color: Colors.red,
//       ),
//     );
//   }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Center(
//       child: RaisedButton(
//         onPressed: () {
//           //Get the current location
//           getLocation();
//         },
//         child: Text('Get Location'),
//       ),
//     ),
//   );
// }
