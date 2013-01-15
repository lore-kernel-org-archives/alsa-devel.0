From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/12] ALSA: hda - Use standard fixup table for
	IDT92HD73xx
Date: Tue, 15 Jan 2013 12:09:45 +0100
Message-ID: <1358248189-14166-9-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D9D15265D79
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 9D9F9A5232
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

This one is rather a simple conversion.  The fixups for Dell machines
are implemented by fixup functions in the end.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 331 +++++++++++++++++++++++++++--------------
 1 file changed, 218 insertions(+), 113 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 4a2594a..3cb44c1 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -79,7 +79,6 @@ enum {
 };
 
 enum {
-	STAC_92HD73XX_AUTO,
 	STAC_92HD73XX_NO_JD, /* no jack-detection */
 	STAC_92HD73XX_REF,
 	STAC_92HD73XX_INTEL,
@@ -1783,55 +1782,217 @@ static const struct snd_pci_quirk stac925x_fixup_tbl[] = {
 	{} /* terminator */
 };
 
-static const unsigned int ref92hd73xx_pin_configs[13] = {
-	0x02214030, 0x02a19040, 0x01a19020, 0x02214030,
-	0x0181302e, 0x01014010, 0x01014020, 0x01014030,
-	0x02319040, 0x90a000f0, 0x90a000f0, 0x01452050,
-	0x01452050,
+static const struct hda_pintbl ref92hd73xx_pin_configs[] = {
+	{ 0x0a, 0x02214030 },
+	{ 0x0b, 0x02a19040 },
+	{ 0x0c, 0x01a19020 },
+	{ 0x0d, 0x02214030 },
+	{ 0x0e, 0x0181302e },
+	{ 0x0f, 0x01014010 },
+	{ 0x10, 0x01014020 },
+	{ 0x11, 0x01014030 },
+	{ 0x12, 0x02319040 },
+	{ 0x13, 0x90a000f0 },
+	{ 0x14, 0x90a000f0 },
+	{ 0x22, 0x01452050 },
+	{ 0x23, 0x01452050 },
+	{}
 };
 
-static const unsigned int dell_m6_pin_configs[13] = {
-	0x0321101f, 0x4f00000f, 0x4f0000f0, 0x90170110,
-	0x03a11020, 0x0321101f, 0x4f0000f0, 0x4f0000f0,
-	0x4f0000f0, 0x90a60160, 0x4f0000f0, 0x4f0000f0,
-	0x4f0000f0,
+static const struct hda_pintbl dell_m6_pin_configs[] = {
+	{ 0x0a, 0x0321101f },
+	{ 0x0b, 0x4f00000f },
+	{ 0x0c, 0x4f0000f0 },
+	{ 0x0d, 0x90170110 },
+	{ 0x0e, 0x03a11020 },
+	{ 0x0f, 0x0321101f },
+	{ 0x10, 0x4f0000f0 },
+	{ 0x11, 0x4f0000f0 },
+	{ 0x12, 0x4f0000f0 },
+	{ 0x13, 0x90a60160 },
+	{ 0x14, 0x4f0000f0 },
+	{ 0x22, 0x4f0000f0 },
+	{ 0x23, 0x4f0000f0 },
+	{}
 };
 
-static const unsigned int alienware_m17x_pin_configs[13] = {
-	0x0321101f, 0x0321101f, 0x03a11020, 0x03014020,
-	0x90170110, 0x4f0000f0, 0x4f0000f0, 0x4f0000f0,
-	0x4f0000f0, 0x90a60160, 0x4f0000f0, 0x4f0000f0,
-	0x904601b0,
+static const struct hda_pintbl alienware_m17x_pin_configs[] = {
+	{ 0x0a, 0x0321101f },
+	{ 0x0b, 0x0321101f },
+	{ 0x0c, 0x03a11020 },
+	{ 0x0d, 0x03014020 },
+	{ 0x0e, 0x90170110 },
+	{ 0x0f, 0x4f0000f0 },
+	{ 0x10, 0x4f0000f0 },
+	{ 0x11, 0x4f0000f0 },
+	{ 0x12, 0x4f0000f0 },
+	{ 0x13, 0x90a60160 },
+	{ 0x14, 0x4f0000f0 },
+	{ 0x22, 0x4f0000f0 },
+	{ 0x23, 0x904601b0 },
+	{}
 };
 
-static const unsigned int intel_dg45id_pin_configs[13] = {
-	0x02214230, 0x02A19240, 0x01013214, 0x01014210,
-	0x01A19250, 0x01011212, 0x01016211
+static const struct hda_pintbl intel_dg45id_pin_configs[] = {
+	{ 0x0a, 0x02214230 },
+	{ 0x0b, 0x02A19240 },
+	{ 0x0c, 0x01013214 },
+	{ 0x0d, 0x01014210 },
+	{ 0x0e, 0x01A19250 },
+	{ 0x0f, 0x01011212 },
+	{ 0x10, 0x01016211 },
+	{}
 };
 
-static const unsigned int *stac92hd73xx_brd_tbl[STAC_92HD73XX_MODELS] = {
-	[STAC_92HD73XX_REF]	= ref92hd73xx_pin_configs,
-	[STAC_DELL_M6_AMIC]	= dell_m6_pin_configs,
-	[STAC_DELL_M6_DMIC]	= dell_m6_pin_configs,
-	[STAC_DELL_M6_BOTH]	= dell_m6_pin_configs,
-	[STAC_DELL_EQ]	= dell_m6_pin_configs,
-	[STAC_ALIENWARE_M17X]	= alienware_m17x_pin_configs,
-	[STAC_92HD73XX_INTEL]	= intel_dg45id_pin_configs,
+static void stac92hd73xx_fixup_ref(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	snd_hda_apply_pincfgs(codec, ref92hd73xx_pin_configs);
+	spec->gpio_mask = spec->gpio_dir = spec->gpio_data = 0;
+}
+
+static void stac92hd73xx_fixup_dell(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	snd_hda_apply_pincfgs(codec, dell_m6_pin_configs);
+	spec->num_smuxes = 0;
+	spec->eapd_switch = 0;
+}
+
+static void stac92hd73xx_fixup_dell_eq(struct hda_codec *codec,
+				       const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	stac92hd73xx_fixup_dell(codec);
+	snd_hda_add_verbs(codec, dell_eq_core_init);
+	spec->volknob_init = 1;
+}
+
+/* Analog Mics */
+static void stac92hd73xx_fixup_dell_m6_amic(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	stac92hd73xx_fixup_dell(codec);
+	snd_hda_codec_set_pincfg(codec, 0x0b, 0x90A70170);
+	spec->num_dmics = 0;
+}
+
+/* Digital Mics */
+static void stac92hd73xx_fixup_dell_m6_dmic(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	stac92hd73xx_fixup_dell(codec);
+	snd_hda_codec_set_pincfg(codec, 0x13, 0x90A60160);
+	spec->num_dmics = 1;
+}
+
+/* Both */
+static void stac92hd73xx_fixup_dell_m6_both(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	stac92hd73xx_fixup_dell(codec);
+	snd_hda_codec_set_pincfg(codec, 0x0b, 0x90A70170);
+	snd_hda_codec_set_pincfg(codec, 0x13, 0x90A60160);
+	spec->num_dmics = 1;
+}
+
+static void stac92hd73xx_fixup_alienware_m17x(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	snd_hda_apply_pincfgs(codec, alienware_m17x_pin_configs);
+	spec->num_dmics = STAC92HD73XX_NUM_DMICS;
+	spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
+	spec->eapd_switch = 0;
+}
+
+static void stac92hd73xx_fixup_no_jd(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+	spec->hp_detect = 0;
+}
+
+static const struct hda_fixup stac92hd73xx_fixups[] = {
+	[STAC_92HD73XX_REF] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd73xx_fixup_ref,
+	},
+	[STAC_DELL_M6_AMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd73xx_fixup_dell_m6_amic,
+	},
+	[STAC_DELL_M6_DMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd73xx_fixup_dell_m6_dmic,
+	},
+	[STAC_DELL_M6_BOTH] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd73xx_fixup_dell_m6_both,
+	},
+	[STAC_DELL_EQ]	= {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd73xx_fixup_dell_eq,
+	},
+	[STAC_ALIENWARE_M17X] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd73xx_fixup_alienware_m17x,
+	},
+	[STAC_92HD73XX_INTEL] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = intel_dg45id_pin_configs,
+	},
+	[STAC_92HD73XX_NO_JD] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd73xx_fixup_no_jd,
+	}
 };
 
-static const char * const stac92hd73xx_models[STAC_92HD73XX_MODELS] = {
-	[STAC_92HD73XX_AUTO] = "auto",
-	[STAC_92HD73XX_NO_JD] = "no-jd",
-	[STAC_92HD73XX_REF] = "ref",
-	[STAC_92HD73XX_INTEL] = "intel",
-	[STAC_DELL_M6_AMIC] = "dell-m6-amic",
-	[STAC_DELL_M6_DMIC] = "dell-m6-dmic",
-	[STAC_DELL_M6_BOTH] = "dell-m6",
-	[STAC_DELL_EQ] = "dell-eq",
-	[STAC_ALIENWARE_M17X] = "alienware",
+static const struct hda_model_fixup stac92hd73xx_models[] = {
+	{ .id = STAC_92HD73XX_NO_JD, .name = "no-jd" },
+	{ .id = STAC_92HD73XX_REF, .name = "ref" },
+	{ .id = STAC_92HD73XX_INTEL, .name = "intel" },
+	{ .id = STAC_DELL_M6_AMIC, .name = "dell-m6-amic" },
+	{ .id = STAC_DELL_M6_DMIC, .name = "dell-m6-dmic" },
+	{ .id = STAC_DELL_M6_BOTH, .name = "dell-m6" },
+	{ .id = STAC_DELL_EQ, .name = "dell-eq" },
+	{ .id = STAC_ALIENWARE_M17X, .name = "alienware" },
+	{}
 };
 
-static const struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
+static const struct snd_pci_quirk stac92hd73xx_fixup_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 				"DFI LanParty", STAC_92HD73XX_REF),
@@ -1869,10 +2030,7 @@ static const struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
 				"Dell Studio XPS 1645", STAC_DELL_M6_DMIC),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0413,
 				"Dell Studio 1558", STAC_DELL_M6_DMIC),
-	{} /* terminator */
-};
-
-static const struct snd_pci_quirk stac92hd73xx_codec_id_cfg_tbl[] = {
+	/* codec SSID matching */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02a1,
 		      "Alienware M17x", STAC_ALIENWARE_M17X),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x043a,
@@ -6262,23 +6420,9 @@ static int patch_stac92hd73xx(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->linear_tone_beep = 0;
 	codec->slave_dig_outs = stac92hd73xx_slave_dig_outs;
-	spec->board_config = snd_hda_check_board_config(codec,
-							STAC_92HD73XX_MODELS,
-							stac92hd73xx_models,
-							stac92hd73xx_cfg_tbl);
-	/* check codec subsystem id if not found */
-	if (spec->board_config < 0)
-		spec->board_config =
-			snd_hda_check_board_codec_sid_config(codec,
-				STAC_92HD73XX_MODELS, stac92hd73xx_models,
-				stac92hd73xx_codec_id_cfg_tbl);
-again:
-	if (spec->board_config < 0)
-		snd_printdd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-			    codec->chip_name);
-	else
-		stac92xx_set_config_regs(codec,
-				stac92hd73xx_brd_tbl[spec->board_config]);
+
+	snd_hda_pick_fixup(codec, stac92hd73xx_models, stac92hd73xx_fixup_tbl,
+			   stac92hd73xx_fixups);
 
 	num_dacs = snd_hda_get_connections(codec, 0x0a,
 			conn, STAC92HD73_DAC_COUNT + 2) - 1;
@@ -6288,7 +6432,7 @@ again:
 		       "number of channels defaulting to DAC count\n");
 		num_dacs = STAC92HD73_DAC_COUNT;
 	}
-	spec->init = stac92hd73xx_core_init;
+
 	switch (num_dacs) {
 	case 0x3: /* 6 Channel */
 		spec->aloopback_ctl = stac92hd73xx_6ch_loopback;
@@ -6320,76 +6464,37 @@ again:
 	spec->capvols = stac92hd73xx_capvols;
 	spec->capsws = stac92hd73xx_capsws;
 
-	switch (spec->board_config) {
-	case STAC_DELL_EQ:
-		spec->init = dell_eq_core_init;
-		/* fallthru */
-	case STAC_DELL_M6_AMIC:
-	case STAC_DELL_M6_DMIC:
-	case STAC_DELL_M6_BOTH:
-		spec->num_smuxes = 0;
-		spec->eapd_switch = 0;
+	/* GPIO0 High = Enable EAPD */
+	spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
+	spec->gpio_data = 0x01;
 
-		switch (spec->board_config) {
-		case STAC_DELL_M6_AMIC: /* Analog Mics */
-			snd_hda_codec_set_pincfg(codec, 0x0b, 0x90A70170);
-			spec->num_dmics = 0;
-			break;
-		case STAC_DELL_M6_DMIC: /* Digital Mics */
-			snd_hda_codec_set_pincfg(codec, 0x13, 0x90A60160);
-			spec->num_dmics = 1;
-			break;
-		case STAC_DELL_M6_BOTH: /* Both */
-			snd_hda_codec_set_pincfg(codec, 0x0b, 0x90A70170);
-			snd_hda_codec_set_pincfg(codec, 0x13, 0x90A60160);
-			spec->num_dmics = 1;
-			break;
-		}
-		break;
-	case STAC_ALIENWARE_M17X:
-		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
-		spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
-		spec->eapd_switch = 0;
-		break;
-	default:
-		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
-		spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
-		spec->eapd_switch = 1;
-		break;
-	}
-	if (spec->board_config != STAC_92HD73XX_REF) {
-		/* GPIO0 High = Enable EAPD */
-		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
-		spec->gpio_data = 0x01;
-	}
+	spec->num_dmics = STAC92HD73XX_NUM_DMICS;
+	spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
+	spec->eapd_switch = 1;
 
 	spec->num_pwrs = ARRAY_SIZE(stac92hd73xx_pwr_nids);
 	spec->pwr_nids = stac92hd73xx_pwr_nids;
 
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
+	if (!spec->volknob_init)
+		snd_hda_add_verbs(codec, stac92hd73xx_core_init);
+
 	err = stac92xx_parse_auto_config(codec);
 
-	if (!err) {
-		if (spec->board_config < 0) {
-			printk(KERN_WARNING "hda_codec: No auto-config is "
-			       "available, default to model=ref\n");
-			spec->board_config = STAC_92HD73XX_REF;
-			goto again;
-		}
+	if (!err)
 		err = -EINVAL;
-	}
-
 	if (err < 0) {
 		stac92xx_free(codec);
 		return err;
 	}
 
-	if (spec->board_config == STAC_92HD73XX_NO_JD)
-		spec->hp_detect = 0;
-
 	codec->patch_ops = stac92xx_patch_ops;
 
 	codec->proc_widget_hook = stac92hd7x_proc_hook;
 
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
 	return 0;
 }
 
-- 
1.8.1
