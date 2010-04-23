From: Solomon Peachy <pizza@shaftnet.org>
Subject: [patch] Fix headphone automute on Asus G50Vt laptops
Date: Fri, 23 Apr 2010 16:08:14 -0400
Message-ID: <20100423200814.GA18620@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0183897538113921128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cdptpa-omtalb.mail.rr.com (cdptpa-omtalb.mail.rr.com
	[75.180.132.122])
	by alsa0.perex.cz (Postfix) with ESMTP id 169F5103800
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 22:08:18 +0200 (CEST)
Received: from stuffed.shaftnet.org (localhost [127.0.0.1])
	by stuffed.shaftnet.org (8.14.3/8.14.3) with ESMTP id o3NK8FN7019069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Fri, 23 Apr 2010 16:08:15 -0400
Received: (from pizza@localhost)
	by stuffed.shaftnet.org (8.14.3/8.14.3/Submit) id o3NK8E2b019063
	for alsa-devel@alsa-project.org; Fri, 23 Apr 2010 16:08:14 -0400
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


--===============0183897538113921128==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline


--p4qYPpj5QlsIQJ0K
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On an Asus G50Vt laptop, plugging in the headphone jack mutes the=20
internal speakers and the headphone jack too.  Unplugging the jack=20
unmutes both.  This is a regression introduced between linux 2.6.27 and=20
2.6.28, and is still present in current alsa git sources.

The root cause is that the g50v hooks in the hda-intel/patch_reaktek=20
driver call an automute function for a different model (m51va).

This patch has been sitting in the ALSA bug tracker for more than a=20
year.  Any chance int can finally be applied?

	https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4468
	https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=3D291=
3&type=3Dbug

Even with this patch applied, there's still a secondary problem of the=20
master 'mute' toggling both headphone and speaker outputs (I'm still=20
poking around with hda_analyzer to figure out why) but even that's a=20
vast improvement over no sound output at all when something's plugged=20
in.

Thanks!

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="asus-g50vt-headphone-2.6.28%2B.patch"
Content-Transfer-Encoding: quoted-printable

--- linux/sound/pci/hda/patch_realtek.c	2009-01-28 03:19:47.000000000 -0800
+++ linux/sound/pci/hda/patch_realtek.c	2009-01-28 03:20:12.000000000 -0800
@@ -15421,6 +15421,19 @@
 				AMP_IN_MUTE(0), bits);
 }
=20
+static void alc663_g50v_speaker_automute(struct hda_codec *codec)
+{
+    unsigned int present;
+    unsigned char bits;
+
+    present =3D snd_hda_codec_read(codec, 0x21, 0,
+                     AC_VERB_GET_PIN_SENSE, 0)
+        & AC_PINSENSE_PRESENCE;
+    bits =3D present ? HDA_AMP_MUTE : 0;
+    snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
+                 HDA_AMP_MUTE, bits);
+}
+
 static void alc663_21jd_two_speaker_automute(struct hda_codec *codec)
 {
 	unsigned int present;
@@ -15723,7 +15736,7 @@
 {
 	switch (res >> 26) {
 	case ALC880_HP_EVENT:
-		alc663_m51va_speaker_automute(codec);
+		alc663_g50v_speaker_automute(codec);
 		break;
 	case ALC880_MIC_EVENT:
 		alc662_eeepc_mic_automute(codec);
@@ -15733,7 +15746,7 @@
=20
 static void alc663_g50v_inithook(struct hda_codec *codec)
 {
-	alc663_m51va_speaker_automute(codec);
+	alc663_g50v_speaker_automute(codec);
 	alc662_eeepc_mic_automute(codec);
 }
=20

--zYM0uCDKw75PZbzx--

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFL0f4uPuLgii2759ARAp7TAJ9jXIvPpGiV3VXYvf/p3D80LB+0SwCfVY3f
kmuY+FEcjd6/ooyKIOgY+xg=
=z8ZF
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--

--===============0183897538113921128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0183897538113921128==--
