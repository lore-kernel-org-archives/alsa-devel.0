From: =?UTF-8?B?SsOpcsOpbXkgTGFs?= <kapouer@melix.org>
Subject: imac27 12,2 (2011) model for patch_cirrus.c
Date: Thu, 29 Dec 2011 13:00:01 +0100
Message-ID: <4EFC5641.9010506@melix.org>
Reply-To: kapouer@melix.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000700090100070002040600"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
	by alsa0.perex.cz (Postfix) with ESMTP id AB56024710
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 13:00:04 +0100 (CET)
Received: from [192.168.0.7] (lns-bzn-47f-81-56-208-91.adsl.proxad.net
	[81.56.208.91]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTPSA id 0694914078D09
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 13:00:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000700090100070002040600
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
it'd be glad to have patch_cirrus.c recognize model=3Dimac27_122,
(i'm adding a model because it's harder to auto-detect it),
please find attached patch, tested on linux 3.2-rc7.
I don't know anything about pin configs, just that it works with
the ones in the patch.
Note that i tried with model=3Dauto (no sound) and model=3Dimac27 (front =
speakers
not muted when headphones are plugged in, and surround speakers not prope=
rly
detected).

Regards,
J=C3=A9r=C3=A9my.

--------------000700090100070002040600
Content-Type: text/x-diff;
 name="cirrus_hda_imac27_122.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cirrus_hda_imac27_122.patch"

--- linux-source-3.2-rc7/sound/pci/hda/patch_cirrus.c.orig	2011-12-24 06:51:06.000000000 +0100
+++ linux-source-3.2-rc7/sound/pci/hda/patch_cirrus.c	2011-12-29 11:00:18.746397224 +0100
@@ -78,6 +78,7 @@
 	CS420X_MBP53,
 	CS420X_MBP55,
 	CS420X_IMAC27,
+	CS420X_IMAC27_122,
 	CS420X_APPLE,
 	CS420X_AUTO,
 	CS420X_MODELS
@@ -1278,6 +1279,7 @@
 	[CS420X_MBP53] = "mbp53",
 	[CS420X_MBP55] = "mbp55",
 	[CS420X_IMAC27] = "imac27",
+	[CS420X_IMAC27_122] = "imac27_122",
 	[CS420X_APPLE] = "apple",
 	[CS420X_AUTO] = "auto",
 };
@@ -1345,10 +1347,55 @@
 	{} /* terminator */
 };
 
+static const struct cs_pincfg imac27_122_pincfgs[] = {
+	{ 0x00, 0x821c9700 },
+	{ 0x01, 0x011d9700 },
+	{ 0x02, 0x101e9700 },
+	{ 0x03, 0x901f9700 },
+	{ 0x04, 0xf01ca700 },
+	{ 0x05, 0x101da700 },
+	{ 0x06, 0x011ea700 },
+	{ 0x07, 0x021fa700 },
+	{ 0x08, 0x801cb700 },
+	{ 0x09, 0x001db700 },
+	{ 0x0a, 0x101eb700 },
+	{ 0x0b, 0x901fb700 },
+	{ 0x0c, 0x5017c700 },
+	{ 0x0d, 0x101dc700 },
+	{ 0x0e, 0x811ec700 },
+	{ 0x0f, 0x021fc700 },
+	{ 0x10, 0x301cd700 },
+	{ 0x11, 0x101dd700 },
+	{ 0x12, 0xa11ed700 },
+	{ 0x13, 0x031fd700 },
+	{ 0x14, 0xf01ce700 },
+	{ 0x15, 0x111de700 },
+	{ 0x16, 0x961ee700 },
+	{ 0x17, 0x771fe700 },
+	{ 0x18, 0xf01cf700 },
+	{ 0x19, 0x111df700 },
+	{ 0x1a, 0xc51ef700 },
+	{ 0x1b, 0x041f0701 },
+	{ 0x1c, 0xf01c0701 },
+	{ 0x1d, 0x101d0701 },
+	{ 0x1e, 0x451e0701 },
+	{ 0x1f, 0x041f0701 },
+	{ 0x20, 0xf01c2701 },
+	{ 0x21, 0x111d2701 },
+	{ 0x22, 0x961e2701 },
+	{ 0x23, 0x771f2701 },
+	{ 0x24, 0xf01c5701 },
+	{ 0x25, 0x001d5701 },
+	{ 0x26, 0x001e5701 },
+	{ 0x27, 0x401f5701 },
+	{} /* terminator */
+};
+
 static const struct cs_pincfg *cs_pincfgs[CS420X_MODELS] = {
 	[CS420X_MBP53] = mbp53_pincfgs,
 	[CS420X_MBP55] = mbp55_pincfgs,
 	[CS420X_IMAC27] = imac27_pincfgs,
+	[CS420X_IMAC27_122] = imac27_122_pincfgs,
 };
 
 static void fix_pincfg(struct hda_codec *codec, int model,
@@ -1392,6 +1439,12 @@
 		spec->gpio_eapd_speaker = 8; /* GPIO3 = speakers */
 		spec->gpio_mask = spec->gpio_dir =
 			spec->gpio_eapd_hp | spec->gpio_eapd_speaker;
+		break;
+	case CS420X_IMAC27_122:
+		spec->gpio_eapd_hp = 4; /* GPIO2 = headphones */
+		spec->gpio_eapd_speaker = 8; /* GPIO3 = speakers */
+		spec->gpio_mask = spec->gpio_dir =
+			spec->gpio_eapd_hp | spec->gpio_eapd_speaker;
 		break;
 	}
 

--------------000700090100070002040600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000700090100070002040600--
