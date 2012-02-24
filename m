From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 30/38] ALSA: hda/realtek - Drop all ALC880
	static quirks
Date: Fri, 24 Feb 2012 17:36:23 +0100
Message-ID: <1330101391-8788-31-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 5888A10431C
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 82BDF91B41
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
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

Finally the all static quirks for ALC880 are converted to the
auto-parser.  Since we are never sure whether the BIOS on so many old
machines are really correct, the quirk table entries are copied as
they are, but just providing the proper pin-config values
accordingly.

Since alc880_quirks.c is removed, alc882_quirks.c has to be adjusted
slightly to be built again.  There might be some compile warnings due
to the remaining alc882 quirks, but these shall be killed sooner or
later, I don't care it much at this point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  219 +++++++++++++++++++++++++++++++++--------
 1 files changed, 179 insertions(+), 40 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fce31b0..4ac1e38 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4451,6 +4451,15 @@ enum {
 	ALC880_FIXUP_UNIWILL,
 	ALC880_FIXUP_UNIWILL_DIG,
 	ALC880_FIXUP_Z71V,
+	ALC880_FIXUP_3ST_BASE,
+	ALC880_FIXUP_3ST,
+	ALC880_FIXUP_3ST_DIG,
+	ALC880_FIXUP_5ST_BASE,
+	ALC880_FIXUP_5ST,
+	ALC880_FIXUP_5ST_DIG,
+	ALC880_FIXUP_6ST_BASE,
+	ALC880_FIXUP_6ST,
+	ALC880_FIXUP_6ST_DIG,
 };
 
 /* enable the volume-knob widget support on NID 0x21 */
@@ -4603,6 +4612,114 @@ static const struct alc_fixup alc880_fixups[] = {
 			{ }
 		}
 	},
+	[ALC880_FIXUP_3ST_BASE] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x14, 0x01014010 }, /* line-out */
+			{ 0x15, 0x411111f0 }, /* N/A */
+			{ 0x16, 0x411111f0 }, /* N/A */
+			{ 0x17, 0x411111f0 }, /* N/A */
+			{ 0x18, 0x01a19c30 }, /* mic-in */
+			{ 0x19, 0x0121411f }, /* HP */
+			{ 0x1a, 0x01813031 }, /* line-in */
+			{ 0x1b, 0x02a19c40 }, /* front-mic */
+			{ 0x1c, 0x411111f0 }, /* N/A */
+			{ 0x1d, 0x411111f0 }, /* N/A */
+			/* 0x1e is filled in below */
+			{ 0x1f, 0x411111f0 }, /* N/A */
+			{ }
+		}
+	},
+	[ALC880_FIXUP_3ST] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x1e, 0x411111f0 }, /* N/A */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC880_FIXUP_3ST_BASE,
+	},
+	[ALC880_FIXUP_3ST_DIG] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x1e, 0x0144111e }, /* SPDIF */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC880_FIXUP_3ST_BASE,
+	},
+	[ALC880_FIXUP_5ST_BASE] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x14, 0x01014010 }, /* front */
+			{ 0x15, 0x411111f0 }, /* N/A */
+			{ 0x16, 0x01011411 }, /* CLFE */
+			{ 0x17, 0x01016412 }, /* surr */
+			{ 0x18, 0x01a19c30 }, /* mic-in */
+			{ 0x19, 0x0121411f }, /* HP */
+			{ 0x1a, 0x01813031 }, /* line-in */
+			{ 0x1b, 0x02a19c40 }, /* front-mic */
+			{ 0x1c, 0x411111f0 }, /* N/A */
+			{ 0x1d, 0x411111f0 }, /* N/A */
+			/* 0x1e is filled in below */
+			{ 0x1f, 0x411111f0 }, /* N/A */
+			{ }
+		}
+	},
+	[ALC880_FIXUP_5ST] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x1e, 0x411111f0 }, /* N/A */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC880_FIXUP_5ST_BASE,
+	},
+	[ALC880_FIXUP_5ST_DIG] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x1e, 0x0144111e }, /* SPDIF */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC880_FIXUP_5ST_BASE,
+	},
+	[ALC880_FIXUP_6ST_BASE] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x14, 0x01014010 }, /* front */
+			{ 0x15, 0x01016412 }, /* surr */
+			{ 0x16, 0x01011411 }, /* CLFE */
+			{ 0x17, 0x01012414 }, /* side */
+			{ 0x18, 0x01a19c30 }, /* mic-in */
+			{ 0x19, 0x02a19c40 }, /* front-mic */
+			{ 0x1a, 0x01813031 }, /* line-in */
+			{ 0x1b, 0x0121411f }, /* HP */
+			{ 0x1c, 0x411111f0 }, /* N/A */
+			{ 0x1d, 0x411111f0 }, /* N/A */
+			/* 0x1e is filled in below */
+			{ 0x1f, 0x411111f0 }, /* N/A */
+			{ }
+		}
+	},
+	[ALC880_FIXUP_6ST] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x1e, 0x411111f0 }, /* N/A */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC880_FIXUP_6ST_BASE,
+	},
+	[ALC880_FIXUP_6ST_DIG] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x1e, 0x0144111e }, /* SPDIF */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC880_FIXUP_6ST_BASE,
+	},
 };
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
@@ -4625,6 +4742,60 @@ static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1854, 0x005f, "LG P1 Express", ALC880_FIXUP_LG),
 	SND_PCI_QUIRK(0x1854, 0x0068, "LG w1", ALC880_FIXUP_LG),
 	SND_PCI_QUIRK(0x19db, 0x4188, "TCL S700", ALC880_FIXUP_TCL_S700),
+
+	/* Below is the copied entries from alc880_quirks.c.
+	 * It's not quite sure whether BIOS sets the correct pin-config table
+	 * on these machines, thus they are kept to be compatible with
+	 * the old static quirks.  Once when it's confirmed to work without
+	 * these overrides, it'd be better to remove.
+	 */
+	SND_PCI_QUIRK(0x1019, 0xa880, "ECS", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0x1019, 0xa884, "Acer APFV", ALC880_FIXUP_6ST),
+	SND_PCI_QUIRK(0x1025, 0x0070, "ULI", ALC880_FIXUP_3ST_DIG),
+	SND_PCI_QUIRK(0x1025, 0x0077, "ULI", ALC880_FIXUP_6ST_DIG),
+	SND_PCI_QUIRK(0x1025, 0x0078, "ULI", ALC880_FIXUP_6ST_DIG),
+	SND_PCI_QUIRK(0x1025, 0x0087, "ULI", ALC880_FIXUP_6ST_DIG),
+	SND_PCI_QUIRK(0x1025, 0xe309, "ULI", ALC880_FIXUP_3ST_DIG),
+	SND_PCI_QUIRK(0x1025, 0xe310, "ULI", ALC880_FIXUP_3ST),
+	SND_PCI_QUIRK(0x1039, 0x1234, NULL, ALC880_FIXUP_6ST_DIG),
+	SND_PCI_QUIRK(0x104d, 0x81a0, "Sony", ALC880_FIXUP_3ST),
+	SND_PCI_QUIRK(0x104d, 0x81d6, "Sony", ALC880_FIXUP_3ST),
+	SND_PCI_QUIRK(0x107b, 0x3032, "Gateway", ALC880_FIXUP_5ST),
+	SND_PCI_QUIRK(0x107b, 0x3033, "Gateway", ALC880_FIXUP_5ST),
+	SND_PCI_QUIRK(0x107b, 0x4039, "Gateway", ALC880_FIXUP_5ST),
+	SND_PCI_QUIRK(0x1297, 0xc790, "Shuttle ST20G5", ALC880_FIXUP_6ST_DIG),
+	SND_PCI_QUIRK(0x1458, 0xa102, "Gigabyte K8", ALC880_FIXUP_6ST_DIG),
+	SND_PCI_QUIRK(0x1462, 0x1150, "MSI", ALC880_FIXUP_6ST_DIG),
+	SND_PCI_QUIRK(0x1509, 0x925d, "FIC P4M", ALC880_FIXUP_6ST_DIG),
+	SND_PCI_QUIRK(0x1565, 0x8202, "Biostar", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0x1695, 0x400d, "EPoX", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0x1695, 0x4012, "EPox EP-5LDA", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0x2668, 0x8086, NULL, ALC880_FIXUP_6ST_DIG), /* broken BIOS */
+	SND_PCI_QUIRK(0x8086, 0x2668, NULL, ALC880_FIXUP_6ST_DIG),
+	SND_PCI_QUIRK(0x8086, 0xa100, "Intel mobo", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0x8086, 0xd400, "Intel mobo", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0x8086, 0xd401, "Intel mobo", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0x8086, 0xd402, "Intel mobo", ALC880_FIXUP_3ST_DIG),
+	SND_PCI_QUIRK(0x8086, 0xe224, "Intel mobo", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0x8086, 0xe305, "Intel mobo", ALC880_FIXUP_3ST_DIG),
+	SND_PCI_QUIRK(0x8086, 0xe308, "Intel mobo", ALC880_FIXUP_3ST_DIG),
+	SND_PCI_QUIRK(0x8086, 0xe400, "Intel mobo", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0x8086, 0xe401, "Intel mobo", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0x8086, 0xe402, "Intel mobo", ALC880_FIXUP_5ST_DIG),
+	/* default Intel */
+	SND_PCI_QUIRK_VENDOR(0x8086, "Intel mobo", ALC880_FIXUP_3ST),
+	SND_PCI_QUIRK(0xa0a0, 0x0560, "AOpen i915GMm-HFS", ALC880_FIXUP_5ST_DIG),
+	SND_PCI_QUIRK(0xe803, 0x1019, NULL, ALC880_FIXUP_6ST_DIG),
+	{}
+};
+
+static const struct alc_model_fixup alc880_fixup_models[] = {
+	{.id = ALC880_FIXUP_3ST, .name = "3stack"},
+	{.id = ALC880_FIXUP_3ST_DIG, .name = "3stack-digout"},
+	{.id = ALC880_FIXUP_5ST, .name = "5stack"},
+	{.id = ALC880_FIXUP_5ST_DIG, .name = "5stack-digout"},
+	{.id = ALC880_FIXUP_6ST, .name = "6stack"},
+	{.id = ALC880_FIXUP_6ST_DIG, .name = "6stack-digout"},
 	{}
 };
 
@@ -4647,14 +4818,9 @@ static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 /*
  * OK, here we have finally the patch for ALC880
  */
-#ifdef CONFIG_SND_HDA_ENABLE_REALTEK_QUIRKS
-#include "alc880_quirks.c"
-#endif
-
 static int patch_alc880(struct hda_codec *codec)
 {
 	struct alc_spec *spec;
-	int board_config;
 	int err;
 
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
@@ -4666,38 +4832,14 @@ static int patch_alc880(struct hda_codec *codec)
 	spec->mixer_nid = 0x0b;
 	spec->need_dac_fix = 1;
 
-	board_config = alc_board_config(codec, ALC880_MODEL_LAST,
-					alc880_models, alc880_cfg_tbl);
-	if (board_config < 0) {
-		printk(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-		       codec->chip_name);
-		board_config = ALC_MODEL_AUTO;
-	}
-
-	if (board_config == ALC_MODEL_AUTO) {
-		alc_pick_fixup(codec, NULL, alc880_fixup_tbl, alc880_fixups);
-		alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
-	}
-
-	if (board_config == ALC_MODEL_AUTO) {
-		/* automatic parse from the BIOS config */
-		err = alc880_parse_auto_config(codec);
-		if (err < 0)
-			goto error;
-#ifdef CONFIG_SND_HDA_ENABLE_REALTEK_QUIRKS
-		else if (!err) {
-			printk(KERN_INFO
-			       "hda_codec: Cannot set up configuration "
-			       "from BIOS.  Using 3-stack mode...\n");
-			board_config = ALC880_3ST;
-		}
-#endif
-	}
+	alc_pick_fixup(codec, alc880_fixup_models, alc880_fixup_tbl,
+		       alc880_fixups);
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
 
-	if (board_config != ALC_MODEL_AUTO) {
-		spec->vmaster_nid = 0x0c;
-		setup_preset(codec, &alc880_presets[board_config]);
-	}
+	/* automatic parse from the BIOS config */
+	err = alc880_parse_auto_config(codec);
+	if (err < 0)
+		goto error;
 
 	if (!spec->no_analog && !spec->adc_nids) {
 		alc_auto_fill_adc_caps(codec);
@@ -4716,10 +4858,7 @@ static int patch_alc880(struct hda_codec *codec)
 	}
 
 	codec->patch_ops = alc_patch_ops;
-	if (board_config == ALC_MODEL_AUTO)
-		spec->init_hook = alc_auto_init_std;
-	else
-		codec->patch_ops.build_controls = __alc_build_controls;
+	spec->init_hook = alc_auto_init_std;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	if (!spec->loopback.amplist)
 		spec->loopback.amplist = alc880_loopbacks;
-- 
1.7.9
