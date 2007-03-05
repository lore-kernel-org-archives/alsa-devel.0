From: Pierre Ossman <ossman@cendio.se>
Subject: [PATCH] Improve parameter constraints in alsa-pulse
Date: Mon, 05 Mar 2007 14:33:18 +0100
Message-ID: <45EC1C1E.101@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1420127700=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 126E1296
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2007 14:33:27 +0100 (MET)
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
--===============1420127700==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3B243D0BF8CFF24BD6AF3440"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3B243D0BF8CFF24BD6AF3440
Content-Type: multipart/mixed; boundary="------------060508050206070003080302"

This is a multi-part message in MIME format.
--------------060508050206070003080302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Remove parameter constraints where we actually have none. Also, restrict
total buffer size to 4 MB as current versions of the PulseAudio server
will refuse streams larger than that.

Signed-off-by: Pierre Ossman <ossman@cendio.se>


--------------060508050206070003080302
Content-Type: text/x-patch;
 name="params.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="params.patch"

diff -r ea810fbf4cd0 pulse/pcm_pulse.c
--- a/pulse/pcm_pulse.c	Mon Feb 26 10:21:21 2007 +0100
+++ b/pulse/pcm_pulse.c	Fri Mar 02 16:41:07 2007 +0100
@@ -643,23 +643,8 @@ static int pulse_hw_constraint(snd_pcm_p
     if (err < 0)
         return err;
=20
-    err =3D snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_RATE,
-        8000, 48000);
-    if (err < 0)
-        return err;
-
-    err =3D snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIOD=
_BYTES,
-        1, 4294967295U);
-    if (err < 0)
-        return err;
-
-    err =3D snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIOD=
S,
-        2, 4294967295U);
-    if (err < 0)
-        return err;
-
     err =3D snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_BUFFER=
_BYTES,
-        1, 4294967295U);
+        1, 4 * 1024 * 1024);
     if (err < 0)
         return err;
=20

--------------060508050206070003080302--

--------------enig3B243D0BF8CFF24BD6AF3440
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFF7Bwh7b8eESbyJLgRAtdHAJ9IFCmL0xd5K+8DC7R184d54l81OwCeMf2Z
XRDT3wxPsX9NR8w6MfIux9M=
=HTQe
-----END PGP SIGNATURE-----

--------------enig3B243D0BF8CFF24BD6AF3440--


--===============1420127700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1420127700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1420127700==--
