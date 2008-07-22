From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: added 92HD81/83 support
Date: Tue, 22 Jul 2008 10:36:54 -0400
Message-ID: <4885F086.1000601@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 47E24103897
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 16:37:07 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Added support for 92HD81/83 family of codecs.
This also includes a pwr_mapping array for pins that have more than one amp to
power down.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/pci/hda/hda_codec.h b/pci/hda/hda_codec.h
index a8b7757..21d305d 100644
--- a/pci/hda/hda_codec.h
+++ b/pci/hda/hda_codec.h
@@ -121,6 +121,7 @@ enum {
 #define AC_VERB_SET_CONFIG_DEFAULT_BYTES_1	0x71d
 #define AC_VERB_SET_CONFIG_DEFAULT_BYTES_2	0x71e
 #define AC_VERB_SET_CONFIG_DEFAULT_BYTES_3	0x71f
+#define AC_VERB_SET_EAPD				0x788
 #define AC_VERB_SET_CODEC_RESET			0x7ff

 /*
diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index d11fd1a..90ecb2d 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -72,6 +72,11 @@ enum {
 };

 enum {
+	STAC_92HD83XXX_REF,
+	STAC_92HD83XXX_MODELS
+};
+
+enum {
 	STAC_92HD71BXX_REF,
 	STAC_DELL_M4_1,
 	STAC_DELL_M4_2,
@@ -142,6 +147,7 @@ struct sigmatel_spec {

 	/* power management */
 	unsigned int num_pwrs;
+	unsigned int *pwr_mapping;
 	hda_nid_t *pwr_nids;
 	hda_nid_t *dac_list;

@@ -237,6 +243,33 @@ static hda_nid_t stac92hd73xx_dmux_nids[2] = {
 	0x20, 0x21,
 };

+#define STAC92HD83XXX_NUM_DMICS	2
+static hda_nid_t stac92hd83xxx_dmic_nids[STAC92HD83XXX_NUM_DMICS + 1] = {
+	0x11, 0x12, 0
+};
+
+#define STAC92HD81_DAC_COUNT 2
+#define STAC92HD83_DAC_COUNT 3
+static hda_nid_t stac92hd83xxx_dac_nids[STAC92HD73_DAC_COUNT] = {
+	0x13, 0x14, 0x22,
+};
+
+static hda_nid_t stac92hd83xxx_dmux_nids[2] = {
+	0x17, 0x18,
+};
+
+static hda_nid_t stac92hd83xxx_adc_nids[2] = {
+	0x15, 0x16,
+};
+
+static hda_nid_t stac92hd83xxx_pwr_nids[4] = {
+	0xa, 0xb, 0xd, 0xe,
+};
+
+static unsigned int stac92hd83xxx_pwr_mapping[4] = {
+	0x03, 0x0c, 0x10, 0x40,
+};
+
 static hda_nid_t stac92hd71bxx_pwr_nids[3] = {
 	0x0a, 0x0d, 0x0f
 };
@@ -350,6 +383,11 @@ static hda_nid_t stac92hd73xx_pin_nids[13] = {
 	0x14, 0x1e, 0x22
 };

+static hda_nid_t stac92hd83xxx_pin_nids[14] = {
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
+	0x0f, 0x10, 0x11, 0x12, 0x13,
+	0x1d, 0x1e, 0x1f, 0x20
+};
 static hda_nid_t stac92hd71bxx_pin_nids[10] = {
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x14, 0x18, 0x19, 0x1e,
@@ -627,6 +665,19 @@ static struct hda_verb stac92hd73xx_10ch_core_init[] = {
 	{}
 };

+static struct hda_verb stac92hd83xxx_core_init[] = {
+	/* start of config #1 */
+	{ 0xe, AC_VERB_SET_CONNECT_SEL, 0x3},
+
+	/* start of config #2 */
+	{ 0xa, AC_VERB_SET_CONNECT_SEL, 0x0},
+	{ 0xb, AC_VERB_SET_CONNECT_SEL, 0x0},
+	{ 0xd, AC_VERB_SET_CONNECT_SEL, 0x1},
+
+	/* power state controls amps */
+	{ 0x01, AC_VERB_SET_EAPD, 1 << 2},
+};
+
 static struct hda_verb stac92hd71bxx_core_init[] = {
 	/* set master volume and direct control */
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
@@ -697,6 +748,8 @@ static struct hda_verb stac927x_core_init[] = {
 static struct hda_verb stac9205_core_init[] = {
 	/* set master volume and direct control */	
 	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	/* enable analog pc beep path */
+	{ 0x01, AC_VERB_SET_DIGI_CONVERT_2, 1 << 5},
 	{}
 };

@@ -819,6 +872,33 @@ static struct snd_kcontrol_new stac92hd73xx_10ch_mixer[] = {
 	{ } /* end */
 };

+
+static struct snd_kcontrol_new stac92hd83xxx_mixer[] = {
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x17, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x17, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x18, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x18, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME("DAC0 Capture Volume", 0x1b, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("DAC0 Capture Switch", 0x1b, 0, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("DAC1 Capture Volume", 0x1b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("DAC1 Capture Switch", 0x1b, 0x1, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Front Mic Capture Volume", 0x1b, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Mic Capture Switch", 0x1b, 0x2, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Line In Capture Volume", 0x1b, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Line In Capture Switch", 0x1b, 0x3, HDA_INPUT),
+
+	/*
+	HDA_CODEC_VOLUME("Mic Capture Volume", 0x1b, 0x4, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Capture Switch", 0x1b 0x4, HDA_INPUT),
+	*/
+	{ } /* end */
+};
+
 static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	STAC_INPUT_SOURCE(2),

@@ -1329,6 +1409,27 @@ static struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
 	{} /* terminator */
 };

+static unsigned int ref92hd83xxx_pin_configs[14] = {
+	0x02214030, 0x02211010, 0x02a19020, 0x02170130,
+	0x01014050, 0x01819040, 0x01014020, 0x90a3014e,
+	0x40f000f0, 0x40f000f0, 0x40f000f0, 0x40f000f0,
+	0x01451160, 0x98560170,
+};
+
+static unsigned int *stac92hd83xxx_brd_tbl[STAC_92HD83XXX_MODELS] = {
+	[STAC_92HD83XXX_REF] = ref92hd83xxx_pin_configs,
+};
+
+static const char *stac92hd83xxx_models[STAC_92HD83XXX_MODELS] = {
+	[STAC_92HD83XXX_REF] = "ref",
+};
+
+static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
+	/* SigmaTel reference board */
+	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
+		      "DFI LanParty", STAC_92HD71BXX_REF),
+};
+
 static unsigned int ref92hd71bxx_pin_configs[10] = {
 	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
 	0x0181302e, 0x01114010, 0x01019020, 0x90a000f0,
@@ -2581,8 +2682,8 @@ static int stac92xx_auto_create_hp_ctls(struct hda_codec
*codec,
 }

 /* labels for mono mux outputs */
-static const char *stac92xx_mono_labels[3] = {
-	"DAC0", "DAC1", "Mixer"
+static const char *stac92xx_mono_labels[4] = {
+	"DAC0", "DAC1", "Mixer", "DAC2"
 };

 /* create mono mux for mono out on capable codecs */
@@ -2686,16 +2787,19 @@ static int stac92xx_auto_create_dmic_input_ctls(struct
hda_codec *codec,
 			}
 		continue;
 found:
-		wcaps = get_wcaps(codec, nid);
+		wcaps = get_wcaps(codec, nid) &
+			(AC_WCAP_OUT_AMP | AC_WCAP_IN_AMP);

-		if (wcaps & AC_WCAP_OUT_AMP) {
+		if (wcaps) {
 			sprintf(name, "%s Capture Volume",
 				stac92xx_dmic_labels[dimux->num_items]);

 			err = stac92xx_add_control(spec,
 				STAC_CTL_WIDGET_VOL,
 				name,
-				HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT));
+				HDA_COMPOSE_AMP_VAL(nid, 3, 0,
+				(wcaps & AC_WCAP_OUT_AMP) ?
+				HDA_OUTPUT : HDA_INPUT));
 			if (err < 0)
 				return err;
 		}
@@ -2819,8 +2923,8 @@ static int stac92xx_parse_auto_config(struct hda_codec
*codec, hda_nid_t dig_out
 		hp_speaker_swap = 1;
 	}
 	if (spec->autocfg.mono_out_pin) {
-		int dir = (get_wcaps(codec, spec->autocfg.mono_out_pin)
-				& AC_WCAP_OUT_AMP) ? HDA_OUTPUT : HDA_INPUT;
+		int dir = get_wcaps(codec, spec->autocfg.mono_out_pin) &
+			(AC_WCAP_OUT_AMP | AC_WCAP_IN_AMP);
 		u32 caps = query_amp_caps(codec,
 				spec->autocfg.mono_out_pin, dir);
 		hda_nid_t conn_list[1];
@@ -2842,21 +2946,26 @@ static int stac92xx_parse_auto_config(struct hda_codec
*codec, hda_nid_t dig_out
 						!(wcaps & AC_WCAP_LR_SWAP))
 					spec->mono_nid = conn_list[0];
 		}
-		/* all mono outs have a least a mute/unmute switch */
-		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_MUTE,
-			"Mono Playback Switch",
-			HDA_COMPOSE_AMP_VAL(spec->autocfg.mono_out_pin,
-					1, 0, dir));
-		if (err < 0)
-			return err;
-		/* check to see if there is volume support for the amp */
-		if ((caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT) {
-			err = stac92xx_add_control(spec, STAC_CTL_WIDGET_VOL,
-				"Mono Playback Volume",
-				HDA_COMPOSE_AMP_VAL(spec->autocfg.mono_out_pin,
-					1, 0, dir));
+		if (dir) {
+			hda_nid_t nid = spec->autocfg.mono_out_pin;
+
+			/* most mono outs have a least a mute/unmute switch */
+			dir = (dir & AC_WCAP_OUT_AMP) ? HDA_OUTPUT : HDA_INPUT;
+			err = stac92xx_add_control(spec, STAC_CTL_WIDGET_MUTE,
+				"Mono Playback Switch",
+				HDA_COMPOSE_AMP_VAL(nid, 1, 0, dir));
 			if (err < 0)
 				return err;
+			/* check for volume support for the amp */
+			if ((caps & AC_AMPCAP_NUM_STEPS)
+					>> AC_AMPCAP_NUM_STEPS_SHIFT) {
+				err = stac92xx_add_control(spec,
+					STAC_CTL_WIDGET_VOL,
+					"Mono Playback Volume",
+				HDA_COMPOSE_AMP_VAL(nid, 1, 0, dir));
+				if (err < 0)
+					return err;
+			}
 		}

 		stac92xx_auto_set_pinctl(codec, spec->autocfg.mono_out_pin,
@@ -2936,7 +3045,7 @@ static int stac92xx_parse_auto_config(struct hda_codec
*codec, hda_nid_t dig_out

 	if (spec->autocfg.dig_out_pin)
 		spec->multiout.dig_out_nid = dig_out;
-	if (spec->autocfg.dig_in_pin)
+	if (dig_in && spec->autocfg.dig_in_pin)
 		spec->dig_in_nid = dig_in;

 	if (spec->kctl_alloc)
@@ -3332,7 +3441,12 @@ static void stac92xx_pin_sense(struct hda_codec *codec,
int idx)
 	val = snd_hda_codec_read(codec, codec->afg, 0, 0x0fec, 0x0)
 							& 0x000000ff;
 	presence = get_hp_pin_presence(codec, nid);
-	idx = 1 << idx;
+
+	/* several codecs have two power down bits */
+	if (spec->pwr_mapping)
+		idx = spec->pwr_mapping[idx];
+	else
+		idx = 1 << idx;

 	if (presence)
 		val &= ~idx;
@@ -3668,6 +3782,94 @@ again:
 	return 0;
 }

+static struct hda_input_mux stac92hd83xxx_dmux = {
+	.num_items = 3,
+	.items = {
+		{ "Analog Inputs", 0x03 },
+		{ "Digital Mic 1", 0x04 },
+		{ "Digital Mic 2", 0x05 },
+	}
+};
+
+static int patch_stac92hd83xxx(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+	int err;
+
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	spec->mono_nid = 0x19;
+	spec->digbeep_nid = 0x21;
+	spec->dmic_nids = stac92hd83xxx_dmic_nids;
+	spec->dmux_nids = stac92hd83xxx_dmux_nids;
+	spec->adc_nids = stac92hd83xxx_adc_nids;
+	spec->pwr_nids = stac92hd83xxx_pwr_nids;
+	spec->pwr_mapping = stac92hd83xxx_pwr_mapping;
+	spec->num_pwrs = ARRAY_SIZE(stac92hd83xxx_pwr_nids);
+	spec->multiout.dac_nids = stac92hd83xxx_dac_nids;
+
+	spec->init = stac92hd83xxx_core_init;
+	switch (codec->vendor_id) {
+	case 0x111d7605:
+		spec->multiout.num_dacs = STAC92HD81_DAC_COUNT;
+		break;
+	default:
+		spec->num_pwrs--;
+		spec->init++; /* switch to config #2 */
+		spec->multiout.num_dacs = STAC92HD83_DAC_COUNT;
+	}
+
+	spec->mixer = stac92hd83xxx_mixer;
+	spec->num_pins = ARRAY_SIZE(stac92hd83xxx_pin_nids);
+	spec->num_dmuxes = ARRAY_SIZE(stac92hd83xxx_dmux_nids);
+	spec->num_adcs = ARRAY_SIZE(stac92hd83xxx_adc_nids);
+	spec->num_dmics = STAC92HD83XXX_NUM_DMICS;
+	spec->dinput_mux = &stac92hd83xxx_dmux;
+	spec->pin_nids = stac92hd83xxx_pin_nids;
+	spec->board_config = snd_hda_check_board_config(codec,
+							STAC_92HD83XXX_MODELS,
+							stac92hd83xxx_models,
+							stac92hd83xxx_cfg_tbl);
+again:
+	if (spec->board_config < 0) {
+		snd_printdd(KERN_INFO "hda_codec: Unknown model for"
+			" STAC92HD83XXX, using BIOS defaults\n");
+		err = stac92xx_save_bios_config_regs(codec);
+		if (err < 0) {
+			stac92xx_free(codec);
+			return err;
+		}
+		spec->pin_configs = spec->bios_pin_configs;
+	} else {
+		spec->pin_configs = stac92hd83xxx_brd_tbl[spec->board_config];
+		stac92xx_set_config_regs(codec);
+	}
+
+	err = stac92xx_parse_auto_config(codec, 0x1d, 0);
+	if (!err) {
+		if (spec->board_config < 0) {
+			printk(KERN_WARNING "hda_codec: No auto-config is "
+			       "available, default to model=ref\n");
+			spec->board_config = STAC_92HD83XXX_REF;
+			goto again;
+		}
+		err = -EINVAL;
+	}
+
+	if (err < 0) {
+		stac92xx_free(codec);
+		return err;
+	}
+
+	codec->patch_ops = stac92xx_patch_ops;
+
+	return 0;
+}
+
+
 static int patch_stac92hd71bxx(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
@@ -4386,6 +4588,8 @@ struct hda_codec_preset snd_hda_preset_sigmatel[] = {
  	{ .id = 0x838476a6, .name = "STAC9254", .patch = patch_stac9205 },
  	{ .id = 0x838476a7, .name = "STAC9254D", .patch = patch_stac9205 },
 	{ .id = 0x111d7603, .name = "92HD75B3X5", .patch = patch_stac92hd71bxx},
+	{ .id = 0x111d7604, .name = "92HD83C1X5", .patch = patch_stac92hd83xxx},
+	{ .id = 0x111d7605, .name = "92HD81B1X5", .patch = patch_stac92hd83xxx},
 	{ .id = 0x111d7608, .name = "92HD75B2X5", .patch = patch_stac92hd71bxx},
 	{ .id = 0x111d7674, .name = "92HD73D1X5", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d7675, .name = "92HD73C1X5", .patch = patch_stac92hd73xx },
