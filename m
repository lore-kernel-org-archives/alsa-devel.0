From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: HDA: Enable SKU quirks for Realtek
Date: Thu, 14 Oct 2010 15:51:45 +0200
Message-ID: <4CB70AF1.9030201@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060604060706050204090703"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 7823424434
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 15:51:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060604060706050204090703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Realtek have ways of specifying external amps and more via a
special nid or via the Codec's subsystem ID, this is called "SKU".
The computer manufacturer sometimes gets this wrong, so we need
to be able to override or ignore the SKU customization value.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------060604060706050204090703
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Enable-SKU-quirks-for-Realtek.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Enable-SKU-quirks-for-Realtek.patch"

>From 762e7227ad0ae3195c2a064c3053acbcd68563e0 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 14 Oct 2010 14:50:18 +0200
Subject: [PATCH 1/2] ALSA: HDA: Enable SKU quirks for Realtek

Realtek have ways of specifying external amps and more via a
special nid or via the Codec's subsystem ID, this is called "SKU".
The computer manufacturer sometimes gets this wrong, so we need
to be able to override or ignore the SKU customization value.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b4e0959..f826bad 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -301,6 +301,7 @@ struct alc_customize_define {
 	unsigned int  platform_type:1;
 	unsigned int  swap:1;
 	unsigned int  override:1;
+	unsigned int  fixup:1; /* Means that this sku is set by driver, not read from hw */
 };
 
 struct alc_spec {
@@ -1464,6 +1465,10 @@ static void alc_init_auto_mic(struct hda_codec *codec)
 	spec->unsol_event = alc_sku_unsol_event;
 }
 
+/* Could be any non-zero and even value. When used as fixup, tells
+   the driver to ignore any present sku defines. */
+#define ALC_FIXUP_SKU_IGNORE (2) 
+
 static int alc_auto_parse_customize_define(struct hda_codec *codec)
 {
 	unsigned int ass, tmp, i;
@@ -1472,6 +1477,13 @@ static int alc_auto_parse_customize_define(struct hda_codec *codec)
 
 	spec->cdefine.enable_pcbeep = 1; /* assume always enabled */
 
+	if (spec->cdefine.fixup) {
+		ass = spec->cdefine.sku_cfg;
+		if (ass == ALC_FIXUP_SKU_IGNORE)
+			return -1;
+		goto do_sku;
+	}
+
 	ass = codec->subsystem_id & 0xffff;
 	if (ass != codec->bus->pci->subsystem_device && (ass & 1))
 		goto do_sku;
@@ -1539,6 +1551,13 @@ static int alc_subsystem_id(struct hda_codec *codec,
 	unsigned nid;
 	struct alc_spec *spec = codec->spec;
 
+	if (spec->cdefine.fixup) {
+		ass = spec->cdefine.sku_cfg;
+		if (ass == ALC_FIXUP_SKU_IGNORE)
+			return 0;
+		goto do_sku;
+	}
+
 	ass = codec->subsystem_id & 0xffff;
 	if ((ass != codec->bus->pci->subsystem_device) && (ass & 1))
 		goto do_sku;
@@ -1658,6 +1677,7 @@ struct alc_pincfg {
 };
 
 struct alc_fixup {
+	unsigned int sku;
 	const struct alc_pincfg *pins;
 	const struct hda_verb *verbs;
 };
@@ -1668,12 +1688,22 @@ static void alc_pick_fixup(struct hda_codec *codec,
 			   int pre_init)
 {
 	const struct alc_pincfg *cfg;
+	struct alc_spec *spec;
 
 	quirk = snd_pci_quirk_lookup(codec->bus->pci, quirk);
 	if (!quirk)
 		return;
 	fix += quirk->value;
 	cfg = fix->pins;
+	if (pre_init && fix->sku) {
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+		snd_printdd(KERN_INFO "hda_codec: %s: Apply sku override for %s\n",
+			    codec->chip_name, quirk->name);
+#endif
+		spec = codec->spec;
+		spec->cdefine.sku_cfg = fix->sku;
+		spec->cdefine.fixup = 1;
+	}
 	if (pre_init && cfg) {
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 		snd_printdd(KERN_INFO "hda_codec: %s: Apply pincfg for %s\n",
@@ -10861,8 +10891,6 @@ static int patch_alc882(struct hda_codec *codec)
 
 	codec->spec = spec;
 
-	alc_auto_parse_customize_define(codec);
-
 	switch (codec->vendor_id) {
 	case 0x10ec0882:
 	case 0x10ec0885:
@@ -10890,6 +10918,8 @@ static int patch_alc882(struct hda_codec *codec)
 	if (board_config == ALC882_AUTO)
 		alc_pick_fixup(codec, alc882_fixup_tbl, alc882_fixups, 1);
 
+	alc_auto_parse_customize_define(codec);
+
 	if (board_config == ALC882_AUTO) {
 		/* automatic parse from the BIOS config */
 		err = alc882_parse_auto_config(codec);
-- 
1.7.1


--------------060604060706050204090703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060604060706050204090703--
