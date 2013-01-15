From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/12] ALSA: hda - Use standard fixup table for
	STAC927x
Date: Tue, 15 Jan 2013 12:09:43 +0100
Message-ID: <1358248189-14166-7-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AB639265D70
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8952EA5211
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

This conversion is a bit tricky.  Since STAC927x may take two
different volume-knob initialization values depending on the model, a
new flag, spec->volknob_init, is introduced to indicate whether it's
the standard volume-knob initialization or not.

Also, Dell BIOS model is now directly mapped onto the fixup table
instead of parsing in the function.  This resulted in a new model ref,
STAC_927X_DELL_BIOS_SPDIF, which is a chained entry.

Also, for reducing the fixups, virtual entries like
STAC_927X_DELL_DMIC and STAC_D965_VERBS are introduced.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 355 +++++++++++++++++++++++++++--------------
 1 file changed, 235 insertions(+), 120 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 60d43dd..796dfd1 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -153,14 +153,16 @@ enum {
 };
 
 enum {
-	STAC_927X_AUTO,
 	STAC_D965_REF_NO_JD, /* no jack-detection */
 	STAC_D965_REF,
 	STAC_D965_3ST,
 	STAC_D965_5ST,
 	STAC_D965_5ST_NO_FP,
+	STAC_D965_VERBS,
 	STAC_DELL_3ST,
 	STAC_DELL_BIOS,
+	STAC_DELL_BIOS_SPDIF,
+	STAC_927X_DELL_DMIC,
 	STAC_927X_VOLKNOB,
 	STAC_927X_MODELS
 };
@@ -194,6 +196,7 @@ struct sigmatel_spec {
 	unsigned int auto_mic:1;
 	unsigned int linear_tone_beep:1;
 	unsigned int headset_jack:1; /* 4-pin headset jack (hp + mono mic) */
+	unsigned int volknob_init:1; /* special volume-knob initialization */
 
 	/* gpio lines */
 	unsigned int eapd_mask;
@@ -930,8 +933,6 @@ static const struct hda_verb stac922x_core_init[] = {
 };
 
 static const struct hda_verb d965_core_init[] = {
-	/* set master volume and direct control */	
-	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* unmute node 0x1b */
 	{ 0x1b, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
 	/* select node 0x03 as DAC */	
@@ -2564,65 +2565,235 @@ static const struct snd_pci_quirk stac922x_fixup_tbl[] = {
 	{} /* terminator */
 };
 
-static const unsigned int ref927x_pin_configs[14] = {
-	0x02214020, 0x02a19080, 0x0181304e, 0x01014010,
-	0x01a19040, 0x01011012, 0x01016011, 0x0101201f, 
-	0x183301f0, 0x18a001f0, 0x18a001f0, 0x01442070,
-	0x01c42190, 0x40000100,
+static const struct hda_pintbl ref927x_pin_configs[] = {
+	{ 0x0a, 0x02214020 },
+	{ 0x0b, 0x02a19080 },
+	{ 0x0c, 0x0181304e },
+	{ 0x0d, 0x01014010 },
+	{ 0x0e, 0x01a19040 },
+	{ 0x0f, 0x01011012 },
+	{ 0x10, 0x01016011 },
+	{ 0x11, 0x0101201f },
+	{ 0x12, 0x183301f0 },
+	{ 0x13, 0x18a001f0 },
+	{ 0x14, 0x18a001f0 },
+	{ 0x21, 0x01442070 },
+	{ 0x22, 0x01c42190 },
+	{ 0x23, 0x40000100 },
+	{}
 };
 
-static const unsigned int d965_3st_pin_configs[14] = {
-	0x0221401f, 0x02a19120, 0x40000100, 0x01014011,
-	0x01a19021, 0x01813024, 0x40000100, 0x40000100,
-	0x40000100, 0x40000100, 0x40000100, 0x40000100,
-	0x40000100, 0x40000100
+static const struct hda_pintbl d965_3st_pin_configs[] = {
+	{ 0x0a, 0x0221401f },
+	{ 0x0b, 0x02a19120 },
+	{ 0x0c, 0x40000100 },
+	{ 0x0d, 0x01014011 },
+	{ 0x0e, 0x01a19021 },
+	{ 0x0f, 0x01813024 },
+	{ 0x10, 0x40000100 },
+	{ 0x11, 0x40000100 },
+	{ 0x12, 0x40000100 },
+	{ 0x13, 0x40000100 },
+	{ 0x14, 0x40000100 },
+	{ 0x21, 0x40000100 },
+	{ 0x22, 0x40000100 },
+	{ 0x23, 0x40000100 },
+	{}
 };
 
-static const unsigned int d965_5st_pin_configs[14] = {
-	0x02214020, 0x02a19080, 0x0181304e, 0x01014010,
-	0x01a19040, 0x01011012, 0x01016011, 0x40000100,
-	0x40000100, 0x40000100, 0x40000100, 0x01442070,
-	0x40000100, 0x40000100
+static const struct hda_pintbl d965_5st_pin_configs[] = {
+	{ 0x0a, 0x02214020 },
+	{ 0x0b, 0x02a19080 },
+	{ 0x0c, 0x0181304e },
+	{ 0x0d, 0x01014010 },
+	{ 0x0e, 0x01a19040 },
+	{ 0x0f, 0x01011012 },
+	{ 0x10, 0x01016011 },
+	{ 0x11, 0x40000100 },
+	{ 0x12, 0x40000100 },
+	{ 0x13, 0x40000100 },
+	{ 0x14, 0x40000100 },
+	{ 0x21, 0x01442070 },
+	{ 0x22, 0x40000100 },
+	{ 0x23, 0x40000100 },
+	{}
 };
 
-static const unsigned int d965_5st_no_fp_pin_configs[14] = {
-	0x40000100, 0x40000100, 0x0181304e, 0x01014010,
-	0x01a19040, 0x01011012, 0x01016011, 0x40000100,
-	0x40000100, 0x40000100, 0x40000100, 0x01442070,
-	0x40000100, 0x40000100
+static const struct hda_pintbl d965_5st_no_fp_pin_configs[] = {
+	{ 0x0a, 0x40000100 },
+	{ 0x0b, 0x40000100 },
+	{ 0x0c, 0x0181304e },
+	{ 0x0d, 0x01014010 },
+	{ 0x0e, 0x01a19040 },
+	{ 0x0f, 0x01011012 },
+	{ 0x10, 0x01016011 },
+	{ 0x11, 0x40000100 },
+	{ 0x12, 0x40000100 },
+	{ 0x13, 0x40000100 },
+	{ 0x14, 0x40000100 },
+	{ 0x21, 0x01442070 },
+	{ 0x22, 0x40000100 },
+	{ 0x23, 0x40000100 },
+	{}
 };
 
-static const unsigned int dell_3st_pin_configs[14] = {
-	0x02211230, 0x02a11220, 0x01a19040, 0x01114210,
-	0x01111212, 0x01116211, 0x01813050, 0x01112214,
-	0x403003fa, 0x90a60040, 0x90a60040, 0x404003fb,
-	0x40c003fc, 0x40000100
+static const struct hda_pintbl dell_3st_pin_configs[] = {
+	{ 0x0a, 0x02211230 },
+	{ 0x0b, 0x02a11220 },
+	{ 0x0c, 0x01a19040 },
+	{ 0x0d, 0x01114210 },
+	{ 0x0e, 0x01111212 },
+	{ 0x0f, 0x01116211 },
+	{ 0x10, 0x01813050 },
+	{ 0x11, 0x01112214 },
+	{ 0x12, 0x403003fa },
+	{ 0x13, 0x90a60040 },
+	{ 0x14, 0x90a60040 },
+	{ 0x21, 0x404003fb },
+	{ 0x22, 0x40c003fc },
+	{ 0x23, 0x40000100 },
+	{}
 };
 
-static const unsigned int *stac927x_brd_tbl[STAC_927X_MODELS] = {
-	[STAC_D965_REF_NO_JD] = ref927x_pin_configs,
-	[STAC_D965_REF]  = ref927x_pin_configs,
-	[STAC_D965_3ST]  = d965_3st_pin_configs,
-	[STAC_D965_5ST]  = d965_5st_pin_configs,
-	[STAC_D965_5ST_NO_FP]  = d965_5st_no_fp_pin_configs,
-	[STAC_DELL_3ST]  = dell_3st_pin_configs,
-	[STAC_DELL_BIOS] = NULL,
-	[STAC_927X_VOLKNOB] = NULL,
+static void stac927x_fixup_ref_no_jd(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	/* no jack detecion for ref-no-jd model */
+	if (action == HDA_FIXUP_ACT_PROBE)
+		spec->hp_detect = 0;
+}
+
+static void stac927x_fixup_ref(struct hda_codec *codec,
+			       const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		snd_hda_apply_pincfgs(codec, ref927x_pin_configs);
+		spec->eapd_mask = spec->gpio_mask = 0;
+		spec->gpio_dir = spec->gpio_data = 0;
+	}
+}
+
+static void stac927x_fixup_dell_dmic(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	if (codec->subsystem_id != 0x1028022f) {
+		/* GPIO2 High = Enable EAPD */
+		spec->eapd_mask = spec->gpio_mask = 0x04;
+		spec->gpio_dir = spec->gpio_data = 0x04;
+	}
+	spec->dmic_nids = stac927x_dmic_nids;
+	spec->num_dmics = STAC927X_NUM_DMICS;
+
+	snd_hda_add_verbs(codec, dell_3st_core_init);
+	spec->volknob_init = 1;
+	spec->dmux_nids = stac927x_dmux_nids;
+	spec->num_dmuxes = ARRAY_SIZE(stac927x_dmux_nids);
+}
+
+static void stac927x_fixup_volknob(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		snd_hda_add_verbs(codec, stac927x_volknob_core_init);
+		spec->volknob_init = 1;
+	}
+}
+
+static const struct hda_fixup stac927x_fixups[] = {
+	[STAC_D965_REF_NO_JD] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac927x_fixup_ref_no_jd,
+		.chained = true,
+		.chain_id = STAC_D965_REF,
+	},
+	[STAC_D965_REF] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac927x_fixup_ref,
+	},
+	[STAC_D965_3ST] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = d965_3st_pin_configs,
+		.chained = true,
+		.chain_id = STAC_D965_VERBS,
+	},
+	[STAC_D965_5ST] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = d965_5st_pin_configs,
+		.chained = true,
+		.chain_id = STAC_D965_VERBS,
+	},
+	[STAC_D965_VERBS] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = d965_core_init,
+	},
+	[STAC_D965_5ST_NO_FP] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = d965_5st_no_fp_pin_configs,
+	},
+	[STAC_DELL_3ST] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_3st_pin_configs,
+		.chained = true,
+		.chain_id = STAC_927X_DELL_DMIC,
+	},
+	[STAC_DELL_BIOS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			/* configure the analog microphone on some laptops */
+			{ 0x0c, 0x90a79130 },
+			/* correct the front output jack as a hp out */
+			{ 0x0f, 0x0227011f },
+			/* correct the front input jack as a mic */
+			{ 0x0e, 0x02a79130 },
+			{}
+		},
+		.chained = true,
+		.chain_id = STAC_927X_DELL_DMIC,
+	},
+	[STAC_DELL_BIOS_SPDIF] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			/* correct the device field to SPDIF out */
+			{ 0x21, 0x01442070 },
+			{}
+		},
+		.chained = true,
+		.chain_id = STAC_DELL_BIOS,
+	},
+	[STAC_927X_DELL_DMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac927x_fixup_dell_dmic,
+	},
+	[STAC_927X_VOLKNOB] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac927x_fixup_volknob,
+	},
 };
 
-static const char * const stac927x_models[STAC_927X_MODELS] = {
-	[STAC_927X_AUTO]	= "auto",
-	[STAC_D965_REF_NO_JD]	= "ref-no-jd",
-	[STAC_D965_REF]		= "ref",
-	[STAC_D965_3ST]		= "3stack",
-	[STAC_D965_5ST]		= "5stack",
-	[STAC_D965_5ST_NO_FP]	= "5stack-no-fp",
-	[STAC_DELL_3ST]		= "dell-3stack",
-	[STAC_DELL_BIOS]	= "dell-bios",
-	[STAC_927X_VOLKNOB]	= "volknob",
+static const struct hda_model_fixup stac927x_models[] = {
+	{ .id = STAC_D965_REF_NO_JD, .name = "ref-no-jd" },
+	{ .id = STAC_D965_REF, .name = "ref" },
+	{ .id = STAC_D965_3ST, .name = "3stack" },
+	{ .id = STAC_D965_5ST, .name = "5stack" },
+	{ .id = STAC_D965_5ST_NO_FP, .name = "5stack-no-fp" },
+	{ .id = STAC_DELL_3ST, .name = "dell-3stack" },
+	{ .id = STAC_DELL_BIOS, .name = "dell-bios" },
+	{ .id = STAC_927X_VOLKNOB, .name = "volknob" },
+	{}
 };
 
-static const struct snd_pci_quirk stac927x_cfg_tbl[] = {
+static const struct snd_pci_quirk stac927x_fixup_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_D965_REF),
@@ -2644,12 +2815,12 @@ static const struct snd_pci_quirk stac927x_cfg_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f3, "Dell Inspiron 1420", STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f7, "Dell XPS M1730", STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0227, "Dell Vostro 1400  ", STAC_DELL_BIOS),
-	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022e, "Dell     ", STAC_DELL_BIOS),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022e, "Dell     ", STAC_DELL_BIOS_SPDIF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022f, "Dell Inspiron 1525", STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0242, "Dell     ", STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0243, "Dell     ", STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x02ff, "Dell     ", STAC_DELL_BIOS),
-	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0209, "Dell XPS 1330", STAC_DELL_BIOS),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0209, "Dell XPS 1330", STAC_DELL_BIOS_SPDIF),
 	/* 965 based 5 stack systems */
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_INTEL, 0xff00, 0x2300,
 			   "Intel D965", STAC_D965_5ST),
@@ -6602,16 +6773,9 @@ static int patch_stac927x(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->linear_tone_beep = 1;
 	codec->slave_dig_outs = stac927x_slave_dig_outs;
-	spec->board_config = snd_hda_check_board_config(codec, STAC_927X_MODELS,
-							stac927x_models,
-							stac927x_cfg_tbl);
- again:
-	if (spec->board_config < 0)
-		snd_printdd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-			    codec->chip_name);
-	else
-		stac92xx_set_config_regs(codec,
-				stac927x_brd_tbl[spec->board_config]);
+
+	snd_hda_pick_fixup(codec, stac927x_models, stac927x_fixup_tbl,
+			   stac927x_fixups);
 
 	spec->digbeep_nid = 0x23;
 	spec->adc_nids = stac927x_adc_nids;
@@ -6624,56 +6788,11 @@ static int patch_stac927x(struct hda_codec *codec)
 	spec->dac_list = stac927x_dac_nids;
 	spec->multiout.dac_nids = spec->dac_nids;
 
-	if (spec->board_config != STAC_D965_REF) {
-		/* GPIO0 High = Enable EAPD */
-		spec->eapd_mask = spec->gpio_mask = 0x01;
-		spec->gpio_dir = spec->gpio_data = 0x01;
-	}
+	/* GPIO0 High = Enable EAPD */
+	spec->eapd_mask = spec->gpio_mask = 0x01;
+	spec->gpio_dir = spec->gpio_data = 0x01;
 
-	switch (spec->board_config) {
-	case STAC_D965_3ST:
-	case STAC_D965_5ST:
-		/* GPIO0 High = Enable EAPD */
-		spec->num_dmics = 0;
-		spec->init = d965_core_init;
-		break;
-	case STAC_DELL_BIOS:
-		switch (codec->subsystem_id) {
-		case 0x10280209:
-		case 0x1028022e:
-			/* correct the device field to SPDIF out */
-			snd_hda_codec_set_pincfg(codec, 0x21, 0x01442070);
-			break;
-		}
-		/* configure the analog microphone on some laptops */
-		snd_hda_codec_set_pincfg(codec, 0x0c, 0x90a79130);
-		/* correct the front output jack as a hp out */
-		snd_hda_codec_set_pincfg(codec, 0x0f, 0x0227011f);
-		/* correct the front input jack as a mic */
-		snd_hda_codec_set_pincfg(codec, 0x0e, 0x02a79130);
-		/* fallthru */
-	case STAC_DELL_3ST:
-		if (codec->subsystem_id != 0x1028022f) {
-			/* GPIO2 High = Enable EAPD */
-			spec->eapd_mask = spec->gpio_mask = 0x04;
-			spec->gpio_dir = spec->gpio_data = 0x04;
-		}
-		spec->dmic_nids = stac927x_dmic_nids;
-		spec->num_dmics = STAC927X_NUM_DMICS;
-
-		spec->init = dell_3st_core_init;
-		spec->dmux_nids = stac927x_dmux_nids;
-		spec->num_dmuxes = ARRAY_SIZE(stac927x_dmux_nids);
-		break;
-	case STAC_927X_VOLKNOB:
-		spec->num_dmics = 0;
-		spec->init = stac927x_volknob_core_init;
-		break;
-	default:
-		spec->num_dmics = 0;
-		spec->init = stac927x_core_init;
-		break;
-	}
+	spec->num_dmics = 0;
 
 	spec->num_caps = STAC927X_NUM_CAPS;
 	spec->capvols = stac927x_capvols;
@@ -6685,16 +6804,14 @@ static int patch_stac927x(struct hda_codec *codec)
 	spec->aloopback_shift = 0;
 	spec->eapd_switch = 1;
 
+	if (!spec->volknob_init)
+		snd_hda_add_verbs(codec, stac927x_core_init);
+
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
 	err = stac92xx_parse_auto_config(codec);
-	if (!err) {
-		if (spec->board_config < 0) {
-			printk(KERN_WARNING "hda_codec: No auto-config is "
-			       "available, default to model=ref\n");
-			spec->board_config = STAC_D965_REF;
-			goto again;
-		}
+	if (!err)
 		err = -EINVAL;
-	}
 	if (err < 0) {
 		stac92xx_free(codec);
 		return err;
@@ -6716,9 +6833,7 @@ static int patch_stac927x(struct hda_codec *codec)
 	 */
 	codec->bus->needs_damn_long_delay = 1;
 
-	/* no jack detecion for ref-no-jd model */
-	if (spec->board_config == STAC_D965_REF_NO_JD)
-		spec->hp_detect = 0;
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
 	return 0;
 }
-- 
1.8.1
