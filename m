From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/12] ALSA: hda - Use standard fixup table for
	IDT92HD83xxx
Date: Tue, 15 Jan 2013 12:09:46 +0100
Message-ID: <1358248189-14166-10-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A80E8265D6D
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8B4D5A522A
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

Finally all codecs in patch_sigmatel.c have been converted to use the
standard fixup helpers.  This change also includes trivial cleanups
like the call of common setup for GPIO LED or the removal of unused
function.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 398 +++++++++++++++++++++++++----------------
 1 file changed, 248 insertions(+), 150 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 3cb44c1..fa16ff7 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -91,7 +91,6 @@ enum {
 };
 
 enum {
-	STAC_92HD83XXX_AUTO,
 	STAC_92HD83XXX_REF,
 	STAC_92HD83XXX_PWR_REF,
 	STAC_DELL_S14,
@@ -103,6 +102,7 @@ enum {
 	STAC_92HD83XXX_HP_INV_LED,
 	STAC_92HD83XXX_HP_MIC_LED,
 	STAC_92HD83XXX_HEADSET_JACK,
+	STAC_92HD83XXX_HP,
 	STAC_92HD83XXX_MODELS
 };
 
@@ -209,6 +209,7 @@ struct sigmatel_spec {
 	unsigned int gpio_led_polarity;
 	unsigned int vref_mute_led_nid; /* pin NID for mute-LED vref control */
 	unsigned int vref_led;
+	int default_polarity;
 
 	unsigned int mic_mute_led_gpio; /* capture mute LED GPIO */
 	bool mic_mute_led_on; /* current mic mute state */
@@ -595,6 +596,7 @@ static int stac_add_event(struct hda_codec *codec, hda_nid_t nid,
 static int stac_add_hp_bass_switch(struct hda_codec *codec);
 static void stac92xx_auto_set_pinctl(struct hda_codec *codec,
 				     hda_nid_t nid, int pin_type);
+static int hp_bnb2011_with_dock(struct hda_codec *codec);
 static int hp_blike_system(u32 subsystem_id);
 static int find_mute_led_cfg(struct hda_codec *codec, int default_polarity);
 
@@ -2040,68 +2042,232 @@ static const struct snd_pci_quirk stac92hd73xx_fixup_tbl[] = {
 	{} /* terminator */
 };
 
-static const unsigned int ref92hd83xxx_pin_configs[10] = {
-	0x02214030, 0x02211010, 0x02a19020, 0x02170130,
-	0x01014050, 0x01819040, 0x01014020, 0x90a3014e,
-	0x01451160, 0x98560170,
+static const struct hda_pintbl ref92hd83xxx_pin_configs[] = {
+	{ 0x0a, 0x02214030 },
+	{ 0x0b, 0x02211010 },
+	{ 0x0c, 0x02a19020 },
+	{ 0x0d, 0x02170130 },
+	{ 0x0e, 0x01014050 },
+	{ 0x0f, 0x01819040 },
+	{ 0x10, 0x01014020 },
+	{ 0x11, 0x90a3014e },
+	{ 0x1f, 0x01451160 },
+	{ 0x20, 0x98560170 },
+	{}
 };
 
-static const unsigned int dell_s14_pin_configs[10] = {
-	0x0221403f, 0x0221101f, 0x02a19020, 0x90170110,
-	0x40f000f0, 0x40f000f0, 0x40f000f0, 0x90a60160,
-	0x40f000f0, 0x40f000f0,
+static const struct hda_pintbl dell_s14_pin_configs[] = {
+	{ 0x0a, 0x0221403f },
+	{ 0x0b, 0x0221101f },
+	{ 0x0c, 0x02a19020 },
+	{ 0x0d, 0x90170110 },
+	{ 0x0e, 0x40f000f0 },
+	{ 0x0f, 0x40f000f0 },
+	{ 0x10, 0x40f000f0 },
+	{ 0x11, 0x90a60160 },
+	{ 0x1f, 0x40f000f0 },
+	{ 0x20, 0x40f000f0 },
+	{}
 };
 
-static const unsigned int dell_vostro_3500_pin_configs[10] = {
-	0x02a11020, 0x0221101f, 0x400000f0, 0x90170110,
-	0x400000f1, 0x400000f2, 0x400000f3, 0x90a60160,
-	0x400000f4, 0x400000f5,
+static const struct hda_pintbl dell_vostro_3500_pin_configs[] = {
+	{ 0x0a, 0x02a11020 },
+	{ 0x0b, 0x0221101f },
+	{ 0x0c, 0x400000f0 },
+	{ 0x0d, 0x90170110 },
+	{ 0x0e, 0x400000f1 },
+	{ 0x0f, 0x400000f2 },
+	{ 0x10, 0x400000f3 },
+	{ 0x11, 0x90a60160 },
+	{ 0x1f, 0x400000f4 },
+	{ 0x20, 0x400000f5 },
+	{}
 };
 
-static const unsigned int hp_dv7_4000_pin_configs[10] = {
-	0x03a12050, 0x0321201f, 0x40f000f0, 0x90170110,
-	0x40f000f0, 0x40f000f0, 0x90170110, 0xd5a30140,
-	0x40f000f0, 0x40f000f0,
+static const struct hda_pintbl hp_dv7_4000_pin_configs[] = {
+	{ 0x0a, 0x03a12050 },
+	{ 0x0b, 0x0321201f },
+	{ 0x0c, 0x40f000f0 },
+	{ 0x0d, 0x90170110 },
+	{ 0x0e, 0x40f000f0 },
+	{ 0x0f, 0x40f000f0 },
+	{ 0x10, 0x90170110 },
+	{ 0x11, 0xd5a30140 },
+	{ 0x1f, 0x40f000f0 },
+	{ 0x20, 0x40f000f0 },
+	{}
 };
 
-static const unsigned int hp_zephyr_pin_configs[10] = {
-	0x01813050, 0x0421201f, 0x04a1205e, 0x96130310,
-	0x96130310, 0x0101401f, 0x1111611f, 0xd5a30130,
-	0, 0,
+static const struct hda_pintbl hp_zephyr_pin_configs[] = {
+	{ 0x0a, 0x01813050 },
+	{ 0x0b, 0x0421201f },
+	{ 0x0c, 0x04a1205e },
+	{ 0x0d, 0x96130310 },
+	{ 0x0e, 0x96130310 },
+	{ 0x0f, 0x0101401f },
+	{ 0x10, 0x1111611f },
+	{ 0x11, 0xd5a30130 },
+	{}
 };
 
-static const unsigned int hp_cNB11_intquad_pin_configs[10] = {
-	0x40f000f0, 0x0221101f, 0x02a11020, 0x92170110,
-	0x40f000f0, 0x92170110, 0x40f000f0, 0xd5a30130,
-	0x40f000f0, 0x40f000f0,
+static const struct hda_pintbl hp_cNB11_intquad_pin_configs[] = {
+	{ 0x0a, 0x40f000f0 },
+	{ 0x0b, 0x0221101f },
+	{ 0x0c, 0x02a11020 },
+	{ 0x0d, 0x92170110 },
+	{ 0x0e, 0x40f000f0 },
+	{ 0x0f, 0x92170110 },
+	{ 0x10, 0x40f000f0 },
+	{ 0x11, 0xd5a30130 },
+	{ 0x1f, 0x40f000f0 },
+	{ 0x20, 0x40f000f0 },
+	{}
 };
 
-static const unsigned int *stac92hd83xxx_brd_tbl[STAC_92HD83XXX_MODELS] = {
-	[STAC_92HD83XXX_REF] = ref92hd83xxx_pin_configs,
-	[STAC_92HD83XXX_PWR_REF] = ref92hd83xxx_pin_configs,
-	[STAC_DELL_S14] = dell_s14_pin_configs,
-	[STAC_DELL_VOSTRO_3500] = dell_vostro_3500_pin_configs,
-	[STAC_92HD83XXX_HP_cNB11_INTQUAD] = hp_cNB11_intquad_pin_configs,
-	[STAC_HP_DV7_4000] = hp_dv7_4000_pin_configs,
-	[STAC_HP_ZEPHYR] = hp_zephyr_pin_configs,
+static void stac92hd83xxx_fixup_hp(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	if (hp_bnb2011_with_dock(codec)) {
+		snd_hda_codec_set_pincfg(codec, 0xa, 0x2101201f);
+		snd_hda_codec_set_pincfg(codec, 0xf, 0x2181205e);
+	}
+
+	if (find_mute_led_cfg(codec, spec->default_polarity))
+		snd_printd("mute LED gpio %d polarity %d\n",
+				spec->gpio_led,
+				spec->gpio_led_polarity);
+}
+
+static void stac92hd83xxx_fixup_hp_zephyr(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	snd_hda_apply_pincfgs(codec, hp_zephyr_pin_configs);
+	snd_hda_add_verbs(codec, stac92hd83xxx_hp_zephyr_init);
+}
+
+static void stac92hd83xxx_fixup_hp_led(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->default_polarity = 0;
+}
+
+static void stac92hd83xxx_fixup_hp_inv_led(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->default_polarity = 1;
+}
+
+static void stac92hd83xxx_fixup_hp_mic_led(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->mic_mute_led_gpio = 0x08; /* GPIO3 */
+}
+
+static void stac92hd83xxx_fixup_headset_jack(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->headset_jack = 1;
+}
+
+static const struct hda_fixup stac92hd83xxx_fixups[] = {
+	[STAC_92HD83XXX_REF] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = ref92hd83xxx_pin_configs,
+	},
+	[STAC_92HD83XXX_PWR_REF] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = ref92hd83xxx_pin_configs,
+	},
+	[STAC_DELL_S14] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_s14_pin_configs,
+	},
+	[STAC_DELL_VOSTRO_3500] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_vostro_3500_pin_configs,
+	},
+	[STAC_92HD83XXX_HP_cNB11_INTQUAD] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = hp_cNB11_intquad_pin_configs,
+		.chained = true,
+		.chain_id = STAC_92HD83XXX_HP,
+	},
+	[STAC_92HD83XXX_HP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd83xxx_fixup_hp,
+	},
+	[STAC_HP_DV7_4000] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = hp_dv7_4000_pin_configs,
+		.chained = true,
+		.chain_id = STAC_92HD83XXX_HP,
+	},
+	[STAC_HP_ZEPHYR] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd83xxx_fixup_hp_zephyr,
+		.chained = true,
+		.chain_id = STAC_92HD83XXX_HP,
+	},
+	[STAC_92HD83XXX_HP_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd83xxx_fixup_hp_led,
+		.chained = true,
+		.chain_id = STAC_92HD83XXX_HP,
+	},
+	[STAC_92HD83XXX_HP_INV_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd83xxx_fixup_hp_inv_led,
+		.chained = true,
+		.chain_id = STAC_92HD83XXX_HP,
+	},
+	[STAC_92HD83XXX_HP_MIC_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd83xxx_fixup_hp_mic_led,
+		.chained = true,
+		.chain_id = STAC_92HD83XXX_HP,
+	},
+	[STAC_92HD83XXX_HEADSET_JACK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd83xxx_fixup_headset_jack,
+	},
 };
 
-static const char * const stac92hd83xxx_models[STAC_92HD83XXX_MODELS] = {
-	[STAC_92HD83XXX_AUTO] = "auto",
-	[STAC_92HD83XXX_REF] = "ref",
-	[STAC_92HD83XXX_PWR_REF] = "mic-ref",
-	[STAC_DELL_S14] = "dell-s14",
-	[STAC_DELL_VOSTRO_3500] = "dell-vostro-3500",
-	[STAC_92HD83XXX_HP_cNB11_INTQUAD] = "hp_cNB11_intquad",
-	[STAC_HP_DV7_4000] = "hp-dv7-4000",
-	[STAC_HP_ZEPHYR] = "hp-zephyr",
-	[STAC_92HD83XXX_HP_LED] = "hp-led",
-	[STAC_92HD83XXX_HP_INV_LED] = "hp-inv-led",
-	[STAC_92HD83XXX_HP_MIC_LED] = "hp-mic-led",
-	[STAC_92HD83XXX_HEADSET_JACK] = "headset-jack",
+static const struct hda_model_fixup stac92hd83xxx_models[] = {
+	{ .id = STAC_92HD83XXX_REF, .name = "ref" },
+	{ .id = STAC_92HD83XXX_PWR_REF, .name = "mic-ref" },
+	{ .id = STAC_DELL_S14, .name = "dell-s14" },
+	{ .id = STAC_DELL_VOSTRO_3500, .name = "dell-vostro-3500" },
+	{ .id = STAC_92HD83XXX_HP_cNB11_INTQUAD, .name = "hp_cNB11_intquad" },
+	{ .id = STAC_HP_DV7_4000, .name = "hp-dv7-4000" },
+	{ .id = STAC_HP_ZEPHYR, .name = "hp-zephyr" },
+	{ .id = STAC_92HD83XXX_HP_LED, .name = "hp-led" },
+	{ .id = STAC_92HD83XXX_HP_INV_LED, .name = "hp-inv-led" },
+	{ .id = STAC_92HD83XXX_HP_MIC_LED, .name = "hp-mic-led" },
+	{ .id = STAC_92HD83XXX_HEADSET_JACK, .name = "headset-jack" },
+	{}
 };
 
-static const struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
+static const struct snd_pci_quirk stac92hd83xxx_fixup_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_92HD83XXX_REF),
@@ -2177,12 +2343,7 @@ static const struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
 			  "HP Mini", STAC_92HD83XXX_HP_LED),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x144E,
 			  "HP Pavilion dv5", STAC_92HD83XXX_HP_INV_LED),
-	{} /* terminator */
-};
-
-static const struct snd_pci_quirk stac92hd83xxx_codec_id_cfg_tbl[] = {
-	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3561,
-			  "HP", STAC_HP_ZEPHYR),
+	SND_PCI_QUIRK_VENDOR(PCI_VENDOR_ID_HP, "HP", STAC_92HD83XXX_HP),
 	{} /* terminator */
 };
 
@@ -3462,21 +3623,6 @@ static const struct snd_pci_quirk stac9205_fixup_tbl[] = {
 	{} /* terminator */
 };
 
-static void stac92xx_set_config_regs(struct hda_codec *codec,
-				     const unsigned int *pincfgs)
-{
-	int i;
-	struct sigmatel_spec *spec = codec->spec;
-
-	if (!pincfgs)
-		return;
-
-	for (i = 0; i < spec->num_pins; i++)
-		if (spec->pin_nids[i] && pincfgs[i])
-			snd_hda_codec_set_pincfg(codec, spec->pin_nids[i],
-						 pincfgs[i]);
-}
-
 /*
  * Analog playback callbacks
  */
@@ -6637,21 +6783,38 @@ static void stac92hd8x_fill_auto_spec(struct hda_codec *codec)
 	spec->num_dmics = spec->auto_dmic_cnt;
 }
 
+static void stac_setup_gpio(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (spec->gpio_led) {
+		if (!spec->vref_mute_led_nid) {
+			spec->gpio_mask |= spec->gpio_led;
+			spec->gpio_dir |= spec->gpio_led;
+			spec->gpio_data |= spec->gpio_led;
+		} else {
+			codec->patch_ops.set_power_state =
+					stac92xx_set_power_state;
+		}
+	}
+
+	if (spec->mic_mute_led_gpio) {
+		spec->gpio_mask |= spec->mic_mute_led_gpio;
+		spec->gpio_dir |= spec->mic_mute_led_gpio;
+		spec->mic_mute_led_on = true;
+		spec->gpio_data |= spec->mic_mute_led_gpio;
+	}
+}
+
 static int patch_stac92hd83xxx(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
-	int default_polarity = -1; /* no default cfg */
 	int err;
 
 	err = alloc_stac_spec(codec, 0, NULL); /* pins filled later */
 	if (err < 0)
 		return err;
 
-	if (hp_bnb2011_with_dock(codec)) {
-		snd_hda_codec_set_pincfg(codec, 0xa, 0x2101201f);
-		snd_hda_codec_set_pincfg(codec, 0xf, 0x2181205e);
-	}
-
 	codec->epss = 0; /* longer delay needed for D3 */
 	stac92hd8x_fill_auto_spec(codec);
 
@@ -6662,80 +6825,22 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 	spec->pwr_nids = stac92hd83xxx_pwr_nids;
 	spec->num_pwrs = ARRAY_SIZE(stac92hd83xxx_pwr_nids);
 	spec->multiout.dac_nids = spec->dac_nids;
-	spec->init = stac92hd83xxx_core_init;
-
-	spec->board_config = snd_hda_check_board_config(codec,
-							STAC_92HD83XXX_MODELS,
-							stac92hd83xxx_models,
-							stac92hd83xxx_cfg_tbl);
-	/* check codec subsystem id if not found */
-	if (spec->board_config < 0)
-		spec->board_config =
-			snd_hda_check_board_codec_sid_config(codec,
-				STAC_92HD83XXX_MODELS, stac92hd83xxx_models,
-				stac92hd83xxx_codec_id_cfg_tbl);
-again:
-	if (spec->board_config < 0)
-		snd_printdd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-			    codec->chip_name);
-	else
-		stac92xx_set_config_regs(codec,
-				stac92hd83xxx_brd_tbl[spec->board_config]);
 
-	codec->patch_ops = stac92xx_patch_ops;
+	snd_hda_pick_fixup(codec, stac92hd83xxx_models, stac92hd83xxx_fixup_tbl,
+			   stac92hd83xxx_fixups);
 
-	switch (spec->board_config) {
-	case STAC_HP_ZEPHYR:
-		spec->init = stac92hd83xxx_hp_zephyr_init;
-		break;
-	case STAC_92HD83XXX_HP_LED:
-		default_polarity = 0;
-		break;
-	case STAC_92HD83XXX_HP_INV_LED:
-		default_polarity = 1;
-		break;
-	case STAC_92HD83XXX_HP_MIC_LED:
-		spec->mic_mute_led_gpio = 0x08; /* GPIO3 */
-		break;
-	case STAC_92HD83XXX_HEADSET_JACK:
-		spec->headset_jack = 1;
-		break;
-	}
+	snd_hda_add_verbs(codec, stac92hd83xxx_core_init);
+	spec->default_polarity = -1; /* no default cfg */
 
-	if (find_mute_led_cfg(codec, default_polarity))
-		snd_printd("mute LED gpio %d polarity %d\n",
-				spec->gpio_led,
-				spec->gpio_led_polarity);
+	codec->patch_ops = stac92xx_patch_ops;
 
-	if (spec->gpio_led) {
-		if (!spec->vref_mute_led_nid) {
-			spec->gpio_mask |= spec->gpio_led;
-			spec->gpio_dir |= spec->gpio_led;
-			spec->gpio_data |= spec->gpio_led;
-		} else {
-			codec->patch_ops.set_power_state =
-					stac92xx_set_power_state;
-		}
-	}
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
-	if (spec->mic_mute_led_gpio) {
-		spec->gpio_mask |= spec->mic_mute_led_gpio;
-		spec->gpio_dir |= spec->mic_mute_led_gpio;
-		spec->mic_mute_led_on = true;
-		spec->gpio_data |= spec->mic_mute_led_gpio;
-	}
+	stac_setup_gpio(codec);
 
 	err = stac92xx_parse_auto_config(codec);
-	if (!err) {
-		if (spec->board_config < 0) {
-			printk(KERN_WARNING "hda_codec: No auto-config is "
-			       "available, default to model=ref\n");
-			spec->board_config = STAC_92HD83XXX_REF;
-			goto again;
-		}
+	if (!err)
 		err = -EINVAL;
-	}
-
 	if (err < 0) {
 		stac92xx_free(codec);
 		return err;
@@ -6743,6 +6848,8 @@ again:
 
 	codec->proc_widget_hook = stac92hd_proc_hook;
 
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
 	return 0;
 }
 
@@ -6925,16 +7032,7 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
-	if (spec->gpio_led) {
-		if (!spec->vref_mute_led_nid) {
-			spec->gpio_mask |= spec->gpio_led;
-			spec->gpio_dir |= spec->gpio_led;
-			spec->gpio_data |= spec->gpio_led;
-		} else {
-			codec->patch_ops.set_power_state =
-					stac92xx_set_power_state;
-		}
-	}
+	stac_setup_gpio(codec);
 
 	spec->multiout.dac_nids = spec->dac_nids;
 
-- 
1.8.1
