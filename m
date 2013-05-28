From: Ben Hutchings <ben@decadent.org.uk>
Subject: usb-audio validation fixes [3.0, 3.2]
Date: Tue, 28 May 2013 02:27:49 +0100
Message-ID: <1369704469.3469.412.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-fpG+MhV14l1D0J6a8d1F"
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: stable@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-fpG+MhV14l1D0J6a8d1F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It looks these fixes are suitable for inclusion in the 3.0.y and 3.2.y
stable branches:

commit 4fa0e81b83503900be277e6273a79651b375e288
Author: Xi Wang <xi.wang@gmail.com>
Date:   Sun Jan 8 09:02:52 2012 -0500

    ALSA: usb-audio: fix possible hang and overflow in parse_uac2_sample_ra=
te_range()

commit 8866f405efd4171f9d9c91901d2dd02f01bacb60
Author: Xi Wang <xi.wang@gmail.com>
Date:   Tue Feb 14 05:18:48 2012 -0500

    ALSA: usb-audio: avoid integer overflow in create_fixed_stream_quirk()

Do you agree?

Ben.

--=20
Ben Hutchings
If at first you don't succeed, you're doing about average.

--=-fpG+MhV14l1D0J6a8d1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUaQIFee/yOyVhhEJAQoIUg/8D5RCK7uxFJvGRpvkRdi8G1y/+ENQM3so
5A2LhuiFP88tYMLxLGe6vn6zP5xG1EsVzY6aIVgQs5JFEEveuIItkIPk3sDaayEh
S1F5I/oTni9CihVKlO5u1zMcAggfa6Ndcb4mbW3fHujDgSXo6EeaQZaiRM9uV6w9
y3wH6fyv2ogRhy9P2WXSLeHheNgH+EYg5ghGNFce60VUILZfOP5IF1hW5Zfd8mTK
/W/Sjf7RyYKYrqMKMdT/RSnWXWPqyOhyA5cuOdlQYs6X8AbcaFXWk8+tADls086B
U9Pd6NIlYkKx+bmvyAji3W9CvJ+PG0g7DqbjgzRJi4xENOGc+OraADYHx8tlktBy
kPBn4V33cP3BffCtgGb665C3zgze6Xk43COcixZWKZr8mgDshMwKUs8AxfJoNB6m
J/b6g6xC/qpM7cTJzZ1AdJfdBkFd56DbSTXEmOYuqM6xR5chG3oSaOuPmd/Lwr8s
GN6CCEiwBFB01meEYn+k1+ju3WZClbMEFx232c1oeYXj5SbjOckv1v3sCw5tXy31
7RHHs3Fl+rySwT3fgMqIYsl4y+aQkPSGk6CtOy6Go6vo+ynpvJg4ZFL/ZOK4MXjq
meXBR8vjdkYtR+BNoUv6TPvE3FlMcTyPann9JsqbbcEtpCzMfK9Qt8gRUvtTVDoC
RU+jgcNoUCk=
=Vi7T
-----END PGP SIGNATURE-----

--=-fpG+MhV14l1D0J6a8d1F--
