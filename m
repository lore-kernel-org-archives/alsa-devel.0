From: Simon McVittie <smcv@debian.org>
Subject: [PATCH 2/2] configure.in: don't rely on test -a,
 not all shells support it
Date: Fri, 8 Oct 2010 09:06:58 +0100
Message-ID: <20101008080658.GA11099@reptile.pseudorandom.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9136152838647494577=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from figment.pseudorandom.co.uk (figment.pseudorandom.co.uk
	[195.10.223.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FF1D10381C
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 10:07:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9136152838647494577==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Notably, /bin/sh in Debian and Ubuntu is dash, which doesn't.
---
 configure.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.in b/configure.in
index e904956..c353759 100644
--- a/configure.in
+++ b/configure.in
@@ -119,7 +119,7 @@ if test "$versioned" =3D "yes"; then
   major=3D`echo $xres | cut -d . -f 1`
   minor=3D`echo $xres | cut -d . -f 2`
   pass=3D0
-  if test $major -eq 1 -a $minor -gt 3; then
+  if test $major -eq 1 && test $minor -gt 3; then
     pass=3D1
   else
     if test $major -gt 1; then
--=20
1.7.1


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iQIVAwUBTK7RIk3o/ypjx8yQAQijNxAAjFb3xjfIGmgnwnrXi62zo7z8BT4nQtyC
YnT/P59l3dbjvxr+1f1hsbjnndJxYa/uHFuP6qNAI9kSVBBKH8s1WUTv6n8rb1Km
lNcyQyEhm1vAl8txzVKbIXWRk38d7Ao2Ir9dHeTjNnD7pt8YiaZ0wwMnySqwhYCG
20s8KN6tsaA5gSN0hpzhTtK1uWA3kKPZe4wuvCUFOfRGg9rDTVJNLl8Hj5KLbEDa
8bB8dylkzYgFcT3PUGGqaFm01nyUP232PXn+o160bWA3RAhmezR0e46E0TDuPqCI
WHLtQh+HBrAjZjYudJqmtV/Eksx9cGrSALKwDX8fxN8s28VOlgN1yDPfo3fau5NV
LPfURg7IvOKs71OGaslwP9TX/XCUTV7N6v2hCwz0KxkZ47MPPAke5FqVJ0YsrthL
bzvT4a75wA53Z+0S+32hg9piyTPpdSjNUVm7nKVrxuDqlZMQFT3pcYIGRDIluO4X
nySPx7EvNHV6Pm0v6rXpWvJukUNQWYGi+tdb2p9WMNkC1sAjm4kmpT1iDYwZDpQO
WEVmi6229lRg934J0SSE5vQaApEXC/thGmhT1sqKfHV8ZD74dmBdP49wU1KYAcIE
Fb2GoNSgQWPkaav+f42+ffoEYabBwVYNznfVkD4cSuiHp12elDELBeCWQ/462ADh
CXyS2px8o2M=
=eghh
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

--===============9136152838647494577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9136152838647494577==--
