From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/12] ALSA: hda - Use standard fixup table for
	STAC925x
Date: Tue, 15 Jan 2013 12:09:39 +0100
Message-ID: <1358248189-14166-3-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CD6CA265D73
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 88098A5207
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
In-Reply-To: <1358248189-14166-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Similar like the previous commit, convert patch_stac925x() to use the
standard fixup table.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 226 +++++++++++++++++++++++++----------------
 1 file changed, 141 insertions(+), 85 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index e5dffd2..4c98b30 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -123,7 +123,6 @@ enum {
 };
 
 enum {
-	STAC_925x_AUTO,
 	STAC_925x_REF,
 	STAC_M1,
 	STAC_M1_2,
@@ -1618,70 +1617,159 @@ static const struct snd_pci_quirk stac9200_fixup_tbl[] = {
 	{} /* terminator */
 };
 
-static const unsigned int ref925x_pin_configs[8] = {
-	0x40c003f0, 0x424503f2, 0x01813022, 0x02a19021,
-	0x90a70320, 0x02214210, 0x01019020, 0x9033032e,
+static const struct hda_pintbl ref925x_pin_configs[] = {
+	{ 0x07, 0x40c003f0 },
+	{ 0x08, 0x424503f2 },
+	{ 0x0a, 0x01813022 },
+	{ 0x0b, 0x02a19021 },
+	{ 0x0c, 0x90a70320 },
+	{ 0x0d, 0x02214210 },
+	{ 0x10, 0x01019020 },
+	{ 0x11, 0x9033032e },
+	{}
 };
 
-static const unsigned int stac925xM1_pin_configs[8] = {
-	0x40c003f4, 0x424503f2, 0x400000f3, 0x02a19020,
-	0x40a000f0, 0x90100210, 0x400003f1, 0x9033032e,
+static const struct hda_pintbl stac925xM1_pin_configs[] = {
+	{ 0x07, 0x40c003f4 },
+	{ 0x08, 0x424503f2 },
+	{ 0x0a, 0x400000f3 },
+	{ 0x0b, 0x02a19020 },
+	{ 0x0c, 0x40a000f0 },
+	{ 0x0d, 0x90100210 },
+	{ 0x10, 0x400003f1 },
+	{ 0x11, 0x9033032e },
+	{}
 };
 
-static const unsigned int stac925xM1_2_pin_configs[8] = {
-	0x40c003f4, 0x424503f2, 0x400000f3, 0x02a19020,
-	0x40a000f0, 0x90100210, 0x400003f1, 0x9033032e,
+static const struct hda_pintbl stac925xM1_2_pin_configs[] = {
+	{ 0x07, 0x40c003f4 },
+	{ 0x08, 0x424503f2 },
+	{ 0x0a, 0x400000f3 },
+	{ 0x0b, 0x02a19020 },
+	{ 0x0c, 0x40a000f0 },
+	{ 0x0d, 0x90100210 },
+	{ 0x10, 0x400003f1 },
+	{ 0x11, 0x9033032e },
+	{}
 };
 
-static const unsigned int stac925xM2_pin_configs[8] = {
-	0x40c003f4, 0x424503f2, 0x400000f3, 0x02a19020,
-	0x40a000f0, 0x90100210, 0x400003f1, 0x9033032e,
+static const struct hda_pintbl stac925xM2_pin_configs[] = {
+	{ 0x07, 0x40c003f4 },
+	{ 0x08, 0x424503f2 },
+	{ 0x0a, 0x400000f3 },
+	{ 0x0b, 0x02a19020 },
+	{ 0x0c, 0x40a000f0 },
+	{ 0x0d, 0x90100210 },
+	{ 0x10, 0x400003f1 },
+	{ 0x11, 0x9033032e },
+	{}
 };
 
-static const unsigned int stac925xM2_2_pin_configs[8] = {
-	0x40c003f4, 0x424503f2, 0x400000f3, 0x02a19020,
-	0x40a000f0, 0x90100210, 0x400003f1, 0x9033032e,
+static const struct hda_pintbl stac925xM2_2_pin_configs[] = {
+	{ 0x07, 0x40c003f4 },
+	{ 0x08, 0x424503f2 },
+	{ 0x0a, 0x400000f3 },
+	{ 0x0b, 0x02a19020 },
+	{ 0x0c, 0x40a000f0 },
+	{ 0x0d, 0x90100210 },
+	{ 0x10, 0x400003f1 },
+	{ 0x11, 0x9033032e },
+	{}
 };
 
-static const unsigned int stac925xM3_pin_configs[8] = {
-	0x40c003f4, 0x424503f2, 0x400000f3, 0x02a19020,
-	0x40a000f0, 0x90100210, 0x400003f1, 0x503303f3,
+static const struct hda_pintbl stac925xM3_pin_configs[] = {
+	{ 0x07, 0x40c003f4 },
+	{ 0x08, 0x424503f2 },
+	{ 0x0a, 0x400000f3 },
+	{ 0x0b, 0x02a19020 },
+	{ 0x0c, 0x40a000f0 },
+	{ 0x0d, 0x90100210 },
+	{ 0x10, 0x400003f1 },
+	{ 0x11, 0x503303f3 },
+	{}
 };
 
-static const unsigned int stac925xM5_pin_configs[8] = {
-	0x40c003f4, 0x424503f2, 0x400000f3, 0x02a19020,
-	0x40a000f0, 0x90100210, 0x400003f1, 0x9033032e,
+static const struct hda_pintbl stac925xM5_pin_configs[] = {
+	{ 0x07, 0x40c003f4 },
+	{ 0x08, 0x424503f2 },
+	{ 0x0a, 0x400000f3 },
+	{ 0x0b, 0x02a19020 },
+	{ 0x0c, 0x40a000f0 },
+	{ 0x0d, 0x90100210 },
+	{ 0x10, 0x400003f1 },
+	{ 0x11, 0x9033032e },
+	{}
 };
 
-static const unsigned int stac925xM6_pin_configs[8] = {
-	0x40c003f4, 0x424503f2, 0x400000f3, 0x02a19020,
-	0x40a000f0, 0x90100210, 0x400003f1, 0x90330320,
+static const struct hda_pintbl stac925xM6_pin_configs[] = {
+	{ 0x07, 0x40c003f4 },
+	{ 0x08, 0x424503f2 },
+	{ 0x0a, 0x400000f3 },
+	{ 0x0b, 0x02a19020 },
+	{ 0x0c, 0x40a000f0 },
+	{ 0x0d, 0x90100210 },
+	{ 0x10, 0x400003f1 },
+	{ 0x11, 0x90330320 },
+	{}
 };
 
-static const unsigned int *stac925x_brd_tbl[STAC_925x_MODELS] = {
-	[STAC_REF] = ref925x_pin_configs,
-	[STAC_M1] = stac925xM1_pin_configs,
-	[STAC_M1_2] = stac925xM1_2_pin_configs,
-	[STAC_M2] = stac925xM2_pin_configs,
-	[STAC_M2_2] = stac925xM2_2_pin_configs,
-	[STAC_M3] = stac925xM3_pin_configs,
-	[STAC_M5] = stac925xM5_pin_configs,
-	[STAC_M6] = stac925xM6_pin_configs,
+static const struct hda_fixup stac925x_fixups[] = {
+	[STAC_REF] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = ref925x_pin_configs,
+	},
+	[STAC_M1] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = stac925xM1_pin_configs,
+	},
+	[STAC_M1_2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = stac925xM1_2_pin_configs,
+	},
+	[STAC_M2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = stac925xM2_pin_configs,
+	},
+	[STAC_M2_2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = stac925xM2_2_pin_configs,
+	},
+	[STAC_M3] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = stac925xM3_pin_configs,
+	},
+	[STAC_M5] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = stac925xM5_pin_configs,
+	},
+	[STAC_M6] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = stac925xM6_pin_configs,
+	},
 };
 
-static const char * const stac925x_models[STAC_925x_MODELS] = {
-	[STAC_925x_AUTO] = "auto",
-	[STAC_REF] = "ref",
-	[STAC_M1] = "m1",
-	[STAC_M1_2] = "m1-2",
-	[STAC_M2] = "m2",
-	[STAC_M2_2] = "m2-2",
-	[STAC_M3] = "m3",
-	[STAC_M5] = "m5",
-	[STAC_M6] = "m6",
+static const struct hda_model_fixup stac925x_models[] = {
+	{ .id = STAC_REF, .name = "ref" },
+	{ .id = STAC_M1, .name = "m1" },
+	{ .id = STAC_M1_2, .name = "m1-2" },
+	{ .id = STAC_M2, .name = "m2" },
+	{ .id = STAC_M2_2, .name = "m2-2" },
+	{ .id = STAC_M3, .name = "m3" },
+	{ .id = STAC_M5, .name = "m5" },
+	{ .id = STAC_M6, .name = "m6" },
+	{}
 };
 
-static const struct snd_pci_quirk stac925x_codec_id_cfg_tbl[] = {
+static const struct snd_pci_quirk stac925x_fixup_tbl[] = {
+	/* SigmaTel reference board */
+	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668, "DFI LanParty", STAC_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101, "DFI LanParty", STAC_REF),
+	SND_PCI_QUIRK(0x8384, 0x7632, "Stac9202 Reference Board", STAC_REF),
+
+	/* Default table for unknown ID */
+	SND_PCI_QUIRK(0x1002, 0x437b, "Gateway mobile", STAC_M2_2),
+
+	/* gateway machines are checked via codec ssid */
 	SND_PCI_QUIRK(0x107b, 0x0316, "Gateway M255", STAC_M2),
 	SND_PCI_QUIRK(0x107b, 0x0366, "Gateway MP6954", STAC_M5),
 	SND_PCI_QUIRK(0x107b, 0x0461, "Gateway NX560XL", STAC_M1),
@@ -1695,18 +1783,6 @@ static const struct snd_pci_quirk stac925x_codec_id_cfg_tbl[] = {
 	{} /* terminator */
 };
 
-static const struct snd_pci_quirk stac925x_cfg_tbl[] = {
-	/* SigmaTel reference board */
-	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668, "DFI LanParty", STAC_REF),
-	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101, "DFI LanParty", STAC_REF),
-	SND_PCI_QUIRK(0x8384, 0x7632, "Stac9202 Reference Board", STAC_REF),
-
-	/* Default table for unknown ID */
-	SND_PCI_QUIRK(0x1002, 0x437b, "Gateway mobile", STAC_M2_2),
-
-	{} /* terminator */
-};
-
 static const unsigned int ref92hd73xx_pin_configs[13] = {
 	0x02214030, 0x02a19040, 0x01a19020, 0x02214030,
 	0x0181302e, 0x01014010, 0x01014020, 0x01014030,
@@ -5401,25 +5477,8 @@ static int patch_stac925x(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->linear_tone_beep = 1;
 
-	/* Check first for codec ID */
-	spec->board_config = snd_hda_check_board_codec_sid_config(codec,
-							STAC_925x_MODELS,
-							stac925x_models,
-							stac925x_codec_id_cfg_tbl);
-
-	/* Now checks for PCI ID, if codec ID is not found */
-	if (spec->board_config < 0)
-		spec->board_config = snd_hda_check_board_config(codec,
-							STAC_925x_MODELS,
-							stac925x_models,
-							stac925x_cfg_tbl);
- again:
-	if (spec->board_config < 0)
-		snd_printdd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-			    codec->chip_name);
-	else
-		stac92xx_set_config_regs(codec,
-					 stac925x_brd_tbl[spec->board_config]);
+	snd_hda_pick_fixup(codec, stac925x_models, stac925x_fixup_tbl,
+			   stac925x_fixups);
 
 	spec->multiout.max_channels = 2;
 	spec->multiout.num_dacs = 1;
@@ -5444,22 +5503,17 @@ static int patch_stac925x(struct hda_codec *codec)
 		break;
 	}
 
-	spec->init = stac925x_core_init;
+	snd_hda_add_verbs(codec, stac925x_core_init);
 	spec->mixer = stac925x_mixer;
 	spec->num_caps = 1;
 	spec->capvols = stac925x_capvols;
 	spec->capsws = stac925x_capsws;
 
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
 	err = stac92xx_parse_auto_config(codec);
-	if (!err) {
-		if (spec->board_config < 0) {
-			printk(KERN_WARNING "hda_codec: No auto-config is "
-			       "available, default to model=ref\n");
-			spec->board_config = STAC_925x_REF;
-			goto again;
-		}
+	if (!err)
 		err = -EINVAL;
-	}
 	if (err < 0) {
 		stac92xx_free(codec);
 		return err;
@@ -5467,6 +5521,8 @@ static int patch_stac925x(struct hda_codec *codec)
 
 	codec->patch_ops = stac92xx_patch_ops;
 
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
 	return 0;
 }
 
-- 
1.8.1
