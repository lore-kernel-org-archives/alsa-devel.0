From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] ALSA: hdsp: check for iobox and upload
 firmware during ioctl
Date: Sat, 08 Nov 2008 14:42:18 +0100
Message-ID: <1226151738.6872.4.camel@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4928281946038401092=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 19A2D2443E
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 14:42:18 +0100 (CET)
Received: from [10.9.3.234] (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-5) with ESMTP id mA8DgHW3018216
	for <alsa-devel@alsa-project.org>; Sat, 8 Nov 2008 14:42:17 +0100
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


--===============4928281946038401092==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-NGXHNQkWRtIJXVMb766+"


--=-NGXHNQkWRtIJXVMb766+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

currently, the error message when trying to run hdspmixer or hdspconf
if the breakout box is not connected is somehow misleading, since it
asks the user to upload the firmware.

this patch adds a test, whether the breakout box is connected and
tries to upload the firmware in the case, that it is not present, e.g.
because of power failures of the breakout box.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/rme9652/hdsp.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index cf9eb41..5bd0be6 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4548,11 +4548,18 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *h=
w, struct file *file, unsigne
 {
 	struct hdsp *hdsp =3D (struct hdsp *)hw->private_data;=09
 	void __user *argp =3D (void __user *)arg;
+	int err;
=20
 	switch (cmd) {
 	case SNDRV_HDSP_IOCTL_GET_PEAK_RMS: {
 		struct hdsp_peak_rms __user *peak_rms =3D (struct hdsp_peak_rms __user *=
)arg;
=20
+		if ((err =3D hdsp_check_for_iobox (hdsp)) < 0)
+			return err;
+
+		if ((err =3D hdsp_check_for_firmware(hdsp, 1)) < 0)
+			return err;
+
 		if (!(hdsp->state & HDSP_FirmwareLoaded)) {
 			snd_printk(KERN_ERR "Hammerfall-DSP: firmware needs to be uploaded to t=
he card.\n");
 			return -EINVAL;
@@ -4572,10 +4579,12 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *h=
w, struct file *file, unsigne
 		unsigned long flags;
 		int i;
 	=09
-		if (!(hdsp->state & HDSP_FirmwareLoaded)) {
-			snd_printk(KERN_ERR "Hammerfall-DSP: Firmware needs to be uploaded to t=
he card.\n");=09
-			return -EINVAL;
-		}
+		if ((err =3D hdsp_check_for_iobox (hdsp)) < 0)
+			return err;
+
+		if ((err =3D hdsp_check_for_firmware(hdsp, 1)) < 0)
+			return err;
+
 		spin_lock_irqsave(&hdsp->lock, flags);
 		info.pref_sync_ref =3D (unsigned char)hdsp_pref_sync_ref(hdsp);
 		info.wordclock_sync_check =3D (unsigned char)hdsp_wc_sync_check(hdsp);
--=20
1.5.6.3

--=-NGXHNQkWRtIJXVMb766+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkVlzgACgkQFz+XezW6HD65lQCfTMiaxMSEcABgmI4BnMbERcdg
2+UAnA5WTp/sZ9xyB/XQ8/p4k83m7bp9
=fGWD
-----END PGP SIGNATURE-----

--=-NGXHNQkWRtIJXVMb766+--


--===============4928281946038401092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4928281946038401092==--
