From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix front mic on Dell Precision
	M6500
Date: Mon, 23 Aug 2010 21:03:11 +0200
Message-ID: <4C72C5EF.6090600@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090605010908020304020004"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id AE0F32412E
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 21:03:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: stable@kernel.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090605010908020304020004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The BIOS of Dell Precision M6500 lists both 0x0e and 0x11 as
front mics, and the driver only supports one front mic. This
commit adds a quirk for preferring node 0x11 (internal mic) to
node 0x0e (possibly docking station mic).

Alsa-info reference:
http://launchpadlibrarian.net/54232083/alsa-info.txt.xyFVpIysHt


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090605010908020304020004
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-front-mic-on-Dell-Precision-M6500.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-front-mic-on-Dell-Precision-M6500.patch"

>From df18cee31e85c83667be42d29edb3c9f7fcfa3c1 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 23 Aug 2010 09:09:10 +0200
Subject: [PATCH] ALSA: HDA: Fix front mic on Dell Precision M6500

The BIOS of Dell Precision M6500 lists both 0x0e and 0x11 as
front mics, and the driver only supports one front mic. This
commit adds a quirk for preferring node 0x11 (internal mic) to
node 0x0e (possibly docking station mic).

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 95148e5..656c54b 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -95,6 +95,7 @@ enum {
 	STAC_DELL_S14,
 	STAC_92HD83XXX_HP,
 	STAC_HP_DV7_4000,
+	STAC_DELL_M6500,
 	STAC_92HD83XXX_MODELS
 };
 
@@ -1633,6 +1634,14 @@ static unsigned int dell_s14_pin_configs[10] = {
 	0x40f000f0, 0x40f000f0,
 };
 
+/* Dell Precision M6500, make sure 0x0e is silenced */
+static unsigned int dell_m6500_pin_configs[10] = {
+	0x03a11030, 0x0321101f, 0x400000f0, 0x90170110, 
+	0x400000f0, 0x23011050, 0x400000f0, 0x90a10120,
+	0x014613b0, 0x400000f0,
+};
+
+
 static unsigned int hp_dv7_4000_pin_configs[10] = {
 	0x03a12050, 0x0321201f, 0x40f000f0, 0x90170110,
 	0x40f000f0, 0x40f000f0, 0x90170110, 0xd5a30140,
@@ -1643,6 +1652,7 @@ static unsigned int *stac92hd83xxx_brd_tbl[STAC_92HD83XXX_MODELS] = {
 	[STAC_92HD83XXX_REF] = ref92hd83xxx_pin_configs,
 	[STAC_92HD83XXX_PWR_REF] = ref92hd83xxx_pin_configs,
 	[STAC_DELL_S14] = dell_s14_pin_configs,
+	[STAC_DELL_M6500] = dell_m6500_pin_configs,
 	[STAC_HP_DV7_4000] = hp_dv7_4000_pin_configs,
 };
 
@@ -1651,6 +1661,7 @@ static const char *stac92hd83xxx_models[STAC_92HD83XXX_MODELS] = {
 	[STAC_92HD83XXX_REF] = "ref",
 	[STAC_92HD83XXX_PWR_REF] = "mic-ref",
 	[STAC_DELL_S14] = "dell-s14",
+	[STAC_DELL_M6500] = "dell-m6500",
 	[STAC_92HD83XXX_HP] = "hp",
 	[STAC_HP_DV7_4000] = "hp-dv7-4000",
 };
@@ -1663,6 +1674,8 @@ static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
 		      "DFI LanParty", STAC_92HD83XXX_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02ba,
 		      "unknown Dell", STAC_DELL_S14),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02ef,
+		      "Dell M6500", STAC_DELL_M6500),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xff00, 0x3600,
 		      "HP", STAC_92HD83XXX_HP),
 	{} /* terminator */
-- 
1.7.0.4


--------------090605010908020304020004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090605010908020304020004--
