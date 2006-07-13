From: Pierre Ossman <ossman@cendio.se>
Subject: Fix capsed name in configure
Date: Thu, 13 Jul 2006 14:36:33 +0200
Message-ID: <44B63E51.3020805@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0715122016=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0DB3912B
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Jul 2006 14:36:37 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0715122016==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig079B5DF4419BA2D969D51920"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig079B5DF4419BA2D969D51920
Content-Type: multipart/mixed; boundary="------------080106060807080601090302"

This is a multi-part message in MIME format.
--------------080106060807080601090302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The name in configure.in used a different capitalisation than the name
in the corresponding Makefile.am. Change it so that both use just lowerca=
se.

Signed-off-by: Pierre Ossman <ossman@cendio.se>

--------------080106060807080601090302
Content-Type: text/x-patch;
 name="fixcaps.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fixcaps.patch"

diff -r 8daac640dc8d configure.in
--- a/configure.in	Wed Jul 12 16:47:20 2006 +0200
+++ b/configure.in	Thu Jul 13 14:33:45 2006 +0200
@@ -16,7 +16,7 @@ PKG_CHECK_MODULES(JACK, jack >=3D 0.98, [H
 PKG_CHECK_MODULES(JACK, jack >=3D 0.98, [HAVE_JACK=3Dyes], [HAVE_JACK=3D=
no])
 AM_CONDITIONAL(HAVE_JACK, test x$HAVE_JACK =3D xyes)
=20
-PKG_CHECK_MODULES(PulseAudio, [libpulse >=3D 0.9.2], [HAVE_PULSE=3Dyes],=
 [HAVE_PULSE=3Dno])
+PKG_CHECK_MODULES(pulseaudio, [libpulse >=3D 0.9.2], [HAVE_PULSE=3Dyes],=
 [HAVE_PULSE=3Dno])
 AM_CONDITIONAL(HAVE_PULSE, test x$HAVE_PULSE =3D xyes)
=20
 PKG_CHECK_MODULES(samplerate, [samplerate], [HAVE_SAMPLERATE=3Dyes], [HA=
VE_SAMPLERATE=3Dno])

--------------080106060807080601090302--

--------------enig079B5DF4419BA2D969D51920
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEtj5T7b8eESbyJLgRAm2jAJ4mgD9cBS4td9/kdAlf7FfIUh9+vgCghiY6
OsuMoiFqCzyf4GjcOrbY3A4=
=oaga
-----END PGP SIGNATURE-----

--------------enig079B5DF4419BA2D969D51920--


--===============0715122016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0715122016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0715122016==--
