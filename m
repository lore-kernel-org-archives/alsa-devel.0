From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Aplay duration
Date: Wed, 29 Jan 2003 01:05:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301290105.13357.tais.hansen@osd.dk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_L88GL6ZNQU706DR1DXWU"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--------------Boundary-00=_L88GL6ZNQU706DR1DXWU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

There's a minor problem with the duration parameter for aplay. When used =
like=20
this:

aplay -d 10 test.wav

It's supposed to play 10 seconds of the wav-file, but it only plays about=
=20
0.1sec. The problem lies in the function playback() in aplay.c where=20
calc_count() is called before hwparams is updated (by calling test_wave()=
)=20
with the actual wave-parameters.

I've attached a quick and dirty fix for this particular issue.

- --=20
Regards,
Tais M. Hansen
OSD

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQIVAwUBPjcat4IvLOJqwYc4AQKuBQ//da2oy/kWE7SCs86DCE9BERkjG1LZkN/X
enYGlTBmS76qOmx+xZNRRRgEKzemzvEg6ANh4n6EVag1DL7ftTo62KWZMTxDyAps
D8M4xmDKjHPwPr0F8sC+CC0OfSbzjOSVHVYmXSxlFU0JYeinP8/Y0oSxCwLpjYiP
AJGaI9gRHbebWkX/xmQ+FvqdFgHtLn5WCT+1nmcTroA74Kv9nlUgt/LUKzZ+AHSA
gEtjpFUIC2OQayMiLJ08nXdeiClUQLEGNziRK3v6+Yx0q8V8HCLgo71xFqbjmvd9
xhOi5+4XRN4CHEMgcAPWWeuEq50F44dq+BNSDxCQRoCNqsJ58S2usyqtcY4iIkMp
0wceF/90rMFaL4T5ytA3QE4+916enhOJyPh694XJu1o2tnJ2eO3uiw/LRVV8qs/Q
xvm04HVASSMNlu/oR7Gf5vBQdfzBOEY1yUZnzUKku7J9l5cMdHYJDMCfWC4QQ0j7
UGxR2Tg64DTAirs51BlQ7XT2spWWPE/tGigyOMccdwNIpEHJkhSWg8h2Q9mNYkRd
Yd+hC2YjyXZIaCuRR7tI4T/GXMpEWKXkrC2K4DvhwizWx1KF6fUaDWLd95W+lVXi
kdwu0V9qv6F4vdrrFNdPqKEbgyzySt7qC0O/b1K+UK2oBFgglnC8Q66cY4Ukb88M
wik2uv5W4+U=3D
=3DaZey
-----END PGP SIGNATURE-----

--------------Boundary-00=_L88GL6ZNQU706DR1DXWU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alsa-aplay-duration-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="alsa-aplay-duration-patch"

Index: ./alsa-utils/aplay/aplay.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/aplay/aplay.c,v
retrieving revision 1.155
diff -u -4 -p -r1.155 aplay.c
--- ./alsa-utils/aplay/aplay.c	19 Dec 2002 11:26:55 -0000	1.155
+++ ./alsa-utils/aplay/aplay.c	28 Jan 2003 23:55:34 -0000
@@ -1796,8 +1796,9 @@ static void playback(char *name)
 		goto __end;
 	}
 	/* read bytes for WAVE-header */
 	if ((dtawave = test_wavefile(fd, audiobuf, dta)) >= 0) {
+		count = calc_count();
 		playback_go(fd, dtawave, count, FORMAT_WAVE, name);
 	} else {
 		/* should be raw data */
 		init_raw_data();

--------------Boundary-00=_L88GL6ZNQU706DR1DXWU--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
