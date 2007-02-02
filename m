From: Jakub Schmidtke <sjakub@gmail.com>
Subject: [PATCH 1/2] Added ALC861VD/ALC660VD support to
	hda-intel
Date: Fri, 2 Feb 2007 18:11:33 +0100
Message-ID: <200702021811.33314.sjakub@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FD3wFRaZ2ALZgE7"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_FD3wFRaZ2ALZgE7
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


I hope this time I do this right ;)

Forget the last patch, I have read some more about stacks and models, and 
changed quite a few things and fixed some errors. I decidec not to do 
separate sections for ALC861VD and ALC660VD, because they are really similar, 
but add 660VD as one of the models of 861VD - just like 861 and 660 are done.

Did also some more testing - but only 3stack models, as this is the type of 
hardware I have. Outputs, inputs and capture work, including HP mute, mic 
recording, boosting etc.


Changes:-

o Added ALC861VD support to patch_realtek.c under hda-intel

o Added ALC660VD as a model of 861VD

o Added pci quirks for Asus G1 as well as for two devices found in Realtek's 
driver to point at ALC660VD model (3stack-660)

o Added pci quirk for Lenovo 3000 C200 - although untested, it should work 
with ALC861VD 3stack model

o Changed preset id = 0x10ec0660 to point at new patch_alc861vd instead of 
patch_861

o Organised the list of presets


Signed-off-by: Jakub Schmidtke <sjakub@gmail.com>

--Boundary-00=_FD3wFRaZ2ALZgE7
Content-Type: text/x-diff; charset="iso-8859-2"; name="alc861vd_660vd_1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alc861vd_660vd_1.patch"

--- a/pci/hda/patch_realtek.c	2007-02-02 17:43:42.000000000 +0100
+++ b/pci/hda/patch_realtek.c	2007-02-02 17:47:36.000000000 +0100
@@ -108,6 +108,16 @@
 	ALC861_MODEL_LAST,
 };
 
+/* ALC861-VD models */
+enum {
+	ALC660VD_3ST,
+	ALC861VD_3ST,
+	ALC861VD_3ST_DIG,
+	ALC861VD_6ST_DIG,
+	ALC861VD_AUTO,
+	ALC861VD_MODEL_LAST,
+};
+
 /* ALC882 models */
 enum {
 	ALC882_3ST_DIG,
@@ -7925,20 +7935,706 @@
 }
 
 /*
+ * ALC861-VD support
+ *
+ * Based on ALC882
+ *
+ * In addition, an independent DAC
+ */
+#define ALC861VD_DIGOUT_NID	0x06
+
+static hda_nid_t alc861vd_dac_nids[4] = {
+	/* front, surr, clfe, side surr */
+	0x02, 0x03, 0x04, 0x05
+};
+
+/* dac_nids for ALC660vd are in a different order - according to
+ * Realtek's driver.
+ * This should probably tesult in a different mixer for 6stack models
+ * of ALC660vd codecs, but for now there is only 3stack mixer
+ * - and it is the same as in 861vd.
+ * adc_nids in ALC660vd are (is) the same as in 861vd
+ */
+static hda_nid_t alc660vd_dac_nids[3] = {
+	/* front, rear, clfe, rear_surr */
+	0x02, 0x04, 0x03
+};
+
+static hda_nid_t alc861vd_adc_nids[1] = {
+	/* ADC0 */
+	0x09,
+};
+
+/* input MUX */
+/* FIXME: should be a matrix-type input source selection */
+static struct hda_input_mux alc861vd_capture_source = {
+	.num_items = 4,
+	.items = {
+		{ "Mic", 0x0 },
+		{ "Front Mic", 0x1 },
+		{ "Line", 0x2 },
+		{ "CD", 0x4 },
+	},
+};
+
+#define alc861vd_mux_enum_info alc_mux_enum_info
+#define alc861vd_mux_enum_get alc_mux_enum_get
+
+static int alc861vd_mux_enum_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	const struct hda_input_mux *imux = spec->input_mux;
+	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	static hda_nid_t capture_mixers[1] = { 0x22 };
+	hda_nid_t nid = capture_mixers[adc_idx];
+	unsigned int *cur_val = &spec->cur_mux[adc_idx];
+	unsigned int i, idx;
+
+	idx = ucontrol->value.enumerated.item[0];
+	if (idx >= imux->num_items)
+		idx = imux->num_items - 1;
+	if (*cur_val == idx && ! codec->in_resume)
+		return 0;
+	for (i = 0; i < imux->num_items; i++) {
+		unsigned int v = (i == idx) ? 0x7000 : 0x7080;
+		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
+				    v | (imux->items[i].index << 8));
+	}
+	*cur_val = idx;
+	return 1;
+}
+
+/*
+ * 2ch mode
+ */
+static struct hda_channel_mode alc861vd_3stack_2ch_modes[1] = {
+	{ 2, NULL }
+};
+
+/*
+ * 6ch mode
+ */
+static struct hda_verb alc861vd_6stack_ch6_init[] = {
+	{ 0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },
+	{ 0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ } /* end */
+};
+
+/*
+ * 8ch mode
+ */
+static struct hda_verb alc861vd_6stack_ch8_init[] = {
+	{ 0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ } /* end */
+};
+
+static struct hda_channel_mode alc861vd_6stack_modes[2] = {
+	{ 6, alc861vd_6stack_ch6_init },
+	{ 8, alc861vd_6stack_ch8_init },
+};
+
+static struct snd_kcontrol_new alc861vd_chmode_mixer[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Channel Mode",
+		.info = alc_ch_mode_info,
+		.get = alc_ch_mode_get,
+		.put = alc_ch_mode_put,
+	},
+	{ } /* end */
+};
+
+static struct snd_kcontrol_new alc861vd_capture_mixer[] = {
+	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
+
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		/* The multiple "Capture Source" controls confuse alsamixer
+		 * So call somewhat different..
+		 *FIXME: the controls appear in the "playback" view!
+		 */
+		/* .name = "Capture Source", */
+		.name = "Input Source",
+		.count = 1,
+		.info = alc861vd_mux_enum_info,
+		.get = alc861vd_mux_enum_get,
+		.put = alc861vd_mux_enum_put,
+	},
+	{ } /* end */
+};
+
+/* Pin assignment: Front=0x14, Rear=0x15, CLFE=0x16, Side=0x17
+ *                 Mic=0x18, Front Mic=0x19, Line-In=0x1a, HP=0x1b
+ */
+static struct snd_kcontrol_new alc861vd_6st_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x02, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x03, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
+
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x04, 1, 0x0,
+				HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x04, 2, 0x0,
+				HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Side Playback Volume", 0x05, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
+
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
+
+	{ } /* end */
+};
+
+static struct snd_kcontrol_new alc861vd_3st_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x02, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
+
+	{ } /* end */
+};
+
+/*
+ * generic initialization of ADC, input mixers and output mixers
+ */
+static struct hda_verb alc861vd_volume_init_verbs[] = {
+	/*
+	 * Unmute ADC0 and set the default input to mic-in
+	 */
+	{0x09, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+
+	/* Unmute input amps (CD, Line In, Mic 1 & Mic 2) of
+	 * the analog-loopback mixer widget
+	 */
+	/* Amp Indices: Mic1 = 0, Mic2 = 1, Line1 = 2, Line2 = 3, CD = 4 */
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(3)},
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(4)},
+
+	/* Capture mixer: unmute Mic, F-Mic, Line, CD inputs */
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(4)},
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(6)},
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(8)},
+
+	/*
+	 * Set up output mixers (0x02 - 0x05)
+	 */
+	/* set vol=0 to output mixers */
+	{0x02, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x03, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+
+	/* set up input amps for analog loopback */
+	/* Amp Indices: DAC = 0, mixer = 1 */
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x0e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+
+	{ }
+};
+
+/*
+ * 3-stack pin configuration:
+ * front = 0x14, mic/clfe = 0x18, HP = 0x19, line/surr = 0x1a, f-mic = 0x1b
+ */
+static struct hda_verb alc861vd_3stack_init_verbs[] = {
+	/*
+	 * Set pin mode and muting
+	 */
+	/* set front pin widgets 0x14 for output */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+	/* Mic (rear) pin: input vref at 80% */
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* Front Mic pin: input vref at 80% */
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* Line In pin: input */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* Line-2 In: Headphone output (output 0 - 0x0c) */
+	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* CD pin widget for input */
+	{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+
+	{ }
+};
+
+/*
+ * 6-stack pin configuration:
+ */
+static struct hda_verb alc861vd_6stack_init_verbs[] = {
+	/*
+	 * Set pin mode and muting
+	 */
+	/* set front pin widgets 0x14 for output */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
+
+	/* Rear Pin: output 1 (0x0d) */
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x01},
+	/* CLFE Pin: output 2 (0x0e) */
+	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x16, AC_VERB_SET_CONNECT_SEL, 0x02},
+	/* Side Pin: output 3 (0x0f) */
+	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x17, AC_VERB_SET_CONNECT_SEL, 0x03},
+
+	/* Mic (rear) pin: input vref at 80% */
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* Front Mic pin: input vref at 80% */
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* Line In pin: input */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* Line-2 In: Headphone output (output 0 - 0x0c) */
+	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* CD pin widget for input */
+	{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+
+	{ }
+};
+
+/* pcm configuration: identiacal with ALC880 */
+#define alc861vd_pcm_analog_playback	alc880_pcm_analog_playback
+#define alc861vd_pcm_analog_capture	alc880_pcm_analog_capture
+#define alc861vd_pcm_digital_playback	alc880_pcm_digital_playback
+#define alc861vd_pcm_digital_capture	alc880_pcm_digital_capture
+
+/*
+ * configuration and preset
+ */
+static const char *alc861vd_models[ALC861VD_MODEL_LAST] = {
+	[ALC660VD_3ST]		= "3stack-660",
+	[ALC861VD_3ST]		= "3stack",
+	[ALC861VD_3ST_DIG]	= "3stack-digout",
+	[ALC861VD_6ST_DIG]	= "6stack-digout",
+	[ALC861VD_AUTO]		= "auto",
+};
+
+static struct snd_pci_quirk alc861vd_cfg_tbl[] = {
+	SND_PCI_QUIRK(0x1043, 0x1339, "Asus G1", ALC660VD_3ST),
+	SND_PCI_QUIRK(0x10de, 0x03f0, "Realtek ALC660 demo", ALC660VD_3ST),
+	SND_PCI_QUIRK(0x1019, 0xa88d, "Realtek ALC660 demo", ALC660VD_3ST),
+
+	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo 3000 C200", ALC861VD_3ST),
+	{}
+};
+
+static struct alc_config_preset alc861vd_presets[] = {
+	[ALC660VD_3ST] = {
+		.mixers = { alc861vd_3st_mixer },
+		.init_verbs = { alc861vd_volume_init_verbs,
+				 alc861vd_3stack_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc660vd_dac_nids),
+		.dac_nids = alc660vd_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc861vd_adc_nids),
+		.adc_nids = alc861vd_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc861vd_3stack_2ch_modes),
+		.channel_mode = alc861vd_3stack_2ch_modes,
+		.input_mux = &alc861vd_capture_source,
+	},
+	[ALC861VD_3ST] = {
+		.mixers = { alc861vd_3st_mixer },
+		.init_verbs = { alc861vd_volume_init_verbs,
+				 alc861vd_3stack_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc861vd_dac_nids),
+		.dac_nids = alc861vd_dac_nids,
+		.num_channel_mode = ARRAY_SIZE(alc861vd_3stack_2ch_modes),
+		.channel_mode = alc861vd_3stack_2ch_modes,
+		.input_mux = &alc861vd_capture_source,
+	},
+	[ALC861VD_3ST_DIG] = {
+		.mixers = { alc861vd_3st_mixer },
+		.init_verbs = { alc861vd_volume_init_verbs,
+		 		 alc861vd_3stack_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc861vd_dac_nids),
+		.dac_nids = alc861vd_dac_nids,
+		.dig_out_nid = ALC861VD_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc861vd_3stack_2ch_modes),
+		.channel_mode = alc861vd_3stack_2ch_modes,
+		.input_mux = &alc861vd_capture_source,
+	},
+	[ALC861VD_6ST_DIG] = {
+		.mixers = { alc861vd_6st_mixer, alc861vd_chmode_mixer },
+		.init_verbs = { alc861vd_volume_init_verbs,
+				alc861vd_6stack_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc861vd_dac_nids),
+		.dac_nids = alc861vd_dac_nids,
+		.dig_out_nid = ALC861VD_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc861vd_6stack_modes),
+		.channel_mode = alc861vd_6stack_modes,
+		.input_mux = &alc861vd_capture_source,
+	},
+};
+
+/*
+ * BIOS auto configuration
+ */
+static void alc861vd_auto_set_output_and_unmute(struct hda_codec *codec,
+				hda_nid_t nid, int pin_type, int dac_idx)
+{
+	/* set as output */
+	snd_hda_codec_write(codec, nid, 0,
+				AC_VERB_SET_PIN_WIDGET_CONTROL, pin_type);
+	snd_hda_codec_write(codec, nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+}
+
+static void alc861vd_auto_init_multi_out(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i <= HDA_SIDE; i++) {
+		hda_nid_t nid = spec->autocfg.line_out_pins[i];
+		if (nid)
+			alc861vd_auto_set_output_and_unmute(codec, nid,
+								PIN_OUT, i);
+	}
+}
+
+
+static void alc861vd_auto_init_hp_out(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t pin;
+
+	pin = spec->autocfg.hp_pins[0];
+	if (pin) /* connect to front and  use dac 0 */
+		alc861vd_auto_set_output_and_unmute(codec, pin, PIN_HP, 0);
+}
+
+#define alc861vd_is_input_pin(nid)	alc880_is_input_pin(nid)
+#define ALC861VD_PIN_CD_NID		ALC880_PIN_CD_NID
+
+static void alc861vd_auto_init_analog_input(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < AUTO_PIN_LAST; i++) {
+		hda_nid_t nid = spec->autocfg.input_pins[i];
+		if (alc861vd_is_input_pin(nid)) {
+			snd_hda_codec_write(codec, nid, 0,
+					AC_VERB_SET_PIN_WIDGET_CONTROL,
+					i <= AUTO_PIN_FRONT_MIC ?
+							PIN_VREF80 : PIN_IN);
+			if (nid != ALC861VD_PIN_CD_NID)
+				snd_hda_codec_write(codec, nid, 0,
+						AC_VERB_SET_AMP_GAIN_MUTE,
+						AMP_OUT_MUTE);
+		}
+	}
+}
+
+#define alc861vd_idx_to_mixer_vol(nid)		((nid) + 0x02)
+#define alc861vd_idx_to_mixer_switch(nid)	((nid) + 0x0c)
+
+/* add playback controls from the parsed DAC table */
+/* Based on ALC880 version. But ALC861VD has separate,
+ * different NIDs for mute/unmute switch and volume control */
+static int alc861vd_auto_create_multi_out_ctls(struct alc_spec *spec,
+					     const struct auto_pin_cfg *cfg)
+{
+	char name[32];
+	static const char *chname[4] = {"Front", "Surround", "CLFE", "Side"};
+	hda_nid_t nid_v, nid_s;
+	int i, err;
+
+	for (i = 0; i < cfg->line_outs; i++) {
+		if (! spec->multiout.dac_nids[i])
+			continue;
+		nid_v = alc861vd_idx_to_mixer_vol(
+				alc880_dac_to_idx(
+					spec->multiout.dac_nids[i]));
+		nid_s = alc861vd_idx_to_mixer_switch(
+				alc880_dac_to_idx(
+					spec->multiout.dac_nids[i]));
+
+		if (i == 2) {
+			/* Center/LFE */
+			if ((err = add_control(spec, ALC_CTL_WIDGET_VOL,
+						"Center Playback Volume",
+						HDA_COMPOSE_AMP_VAL(nid_v, 1,
+							0, HDA_OUTPUT))) < 0)
+				return err;
+			if ((err = add_control(spec, ALC_CTL_WIDGET_VOL,
+						"LFE Playback Volume",
+						HDA_COMPOSE_AMP_VAL(nid_v, 2,
+							0, HDA_OUTPUT))) < 0)
+				return err;
+			if ((err = add_control(spec, ALC_CTL_BIND_MUTE,
+						"Center Playback Switch",
+						HDA_COMPOSE_AMP_VAL(nid_s, 1,
+						2, HDA_INPUT))) < 0)
+				return err;
+			if ((err = add_control(spec, ALC_CTL_BIND_MUTE,
+						"LFE Playback Switch",
+						HDA_COMPOSE_AMP_VAL(nid_s, 2,
+						2, HDA_INPUT))) < 0)
+				return err;
+		} else {
+			sprintf(name, "%s Playback Volume", chname[i]);
+			if ((err = add_control(spec, ALC_CTL_WIDGET_VOL, name,
+						HDA_COMPOSE_AMP_VAL(nid_v, 3,
+							0, HDA_OUTPUT))) < 0)
+				return err;
+			sprintf(name, "%s Playback Switch", chname[i]);
+			if ((err = add_control(spec, ALC_CTL_BIND_MUTE, name,
+						HDA_COMPOSE_AMP_VAL(nid_v, 3,
+							2, HDA_INPUT))) < 0)
+				return err;
+		}
+	}
+	return 0;
+}
+
+/* add playback controls for speaker and HP outputs */
+/* Based on ALC880 version. But ALC861VD has separate,
+ * different NIDs for mute/unmute switch and volume control */
+static int alc861vd_auto_create_extra_out(struct alc_spec *spec,
+					hda_nid_t pin, const char *pfx)
+{
+	hda_nid_t nid_v, nid_s;
+	int err;
+	char name[32];
+
+	if (! pin)
+		return 0;
+
+	if (alc880_is_fixed_pin(pin)) {
+		nid_v = alc880_idx_to_dac(alc880_fixed_pin_idx(pin));
+		/* specify the DAC as the extra output */
+		if (! spec->multiout.hp_nid)
+			spec->multiout.hp_nid = nid_v;
+		else
+			spec->multiout.extra_out_nid[0] = nid_v;
+		/* control HP volume/switch on the output mixer amp */
+		nid_v = alc861vd_idx_to_mixer_vol(
+				alc880_fixed_pin_idx(pin));
+		nid_s = alc861vd_idx_to_mixer_switch(
+				alc880_fixed_pin_idx(pin));
+
+		sprintf(name, "%s Playback Volume", pfx);
+		if ((err = add_control(spec, ALC_CTL_WIDGET_VOL, name,
+				HDA_COMPOSE_AMP_VAL(nid_v, 3, 0,
+							HDA_OUTPUT))) < 0)
+			return err;
+		sprintf(name, "%s Playback Switch", pfx);
+		if ((err = add_control(spec, ALC_CTL_BIND_MUTE, name,
+				HDA_COMPOSE_AMP_VAL(nid_s, 3, 2,
+							HDA_INPUT))) < 0)
+			return err;
+	} else if (alc880_is_multi_pin(pin)) {
+		/* set manual connection */
+		/* we have only a switch on HP-out PIN */
+		sprintf(name, "%s Playback Switch", pfx);
+		if ((err = add_control(spec, ALC_CTL_WIDGET_MUTE, name,
+				HDA_COMPOSE_AMP_VAL(pin, 3, 0,
+							HDA_OUTPUT))) < 0)
+			return err;
+	}
+	return 0;
+}
+
+/* parse the BIOS configuration and set up the alc_spec
+ * return 1 if successful, 0 if the proper config is not found,
+ * or a negative error code
+ * Based on ALC880 version - had to change it to override
+ * alc880_auto_create_extra_out and alc880_auto_create_multi_out_ctls */
+static int alc861vd_parse_auto_config(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	int err;
+	static hda_nid_t alc861vd_ignore[] = { 0x1d, 0 };
+
+	if ((err = snd_hda_parse_pin_def_config(codec, &spec->autocfg,
+						alc861vd_ignore)) < 0)
+		return err;
+	if (! spec->autocfg.line_outs)
+		return 0; /* can't find valid BIOS pin config */
+
+	if ((err = alc880_auto_fill_dac_nids(spec, &spec->autocfg)) < 0 ||
+		(err = alc861vd_auto_create_multi_out_ctls(spec,
+			&spec->autocfg)) < 0 ||
+		(err = alc861vd_auto_create_extra_out(spec,
+			spec->autocfg.speaker_pins[0], "Speaker")) < 0 ||
+		(err = alc861vd_auto_create_extra_out(spec,
+			spec->autocfg.hp_pins[0], "Headphone")) < 0 ||
+		(err = alc880_auto_create_analog_input_ctls(spec,
+			&spec->autocfg)) < 0)
+		return err;
+
+	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
+
+	if (spec->autocfg.dig_out_pin)
+		spec->multiout.dig_out_nid = ALC861VD_DIGOUT_NID;
+
+	if (spec->kctl_alloc)
+		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
+
+	spec->init_verbs[spec->num_init_verbs++]
+		= alc861vd_volume_init_verbs;
+
+	spec->num_mux_defs = 1;
+	spec->input_mux = &spec->private_imux;
+
+	return 1;
+}
+
+/* additional initialization for auto-configuration model */
+static void alc861vd_auto_init(struct hda_codec *codec)
+{
+	alc861vd_auto_init_multi_out(codec);
+	alc861vd_auto_init_hp_out(codec);
+	alc861vd_auto_init_analog_input(codec);
+}
+
+static int patch_alc861vd(struct hda_codec *codec)
+{
+	struct alc_spec *spec;
+	int err, board_config;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+
+	board_config = snd_hda_check_board_config(codec, ALC861VD_MODEL_LAST,
+						  alc861vd_models,
+						  alc861vd_cfg_tbl);
+
+	if (board_config < 0 || board_config >= ALC861VD_MODEL_LAST) {
+		printk(KERN_INFO "hda_codec: Unknown model for ALC660VD/"
+			"ALC861VD, trying auto-probe from BIOS...\n");
+		board_config = ALC861VD_AUTO;
+	}
+
+	if (board_config == ALC861VD_AUTO) {
+		/* automatic parse from the BIOS config */
+		err = alc861vd_parse_auto_config(codec);
+		if (err < 0) {
+			alc_free(codec);
+			return err;
+		} else if (! err) {
+			printk(KERN_INFO
+			       "hda_codec: Cannot set up configuration "
+			       "from BIOS.  Using base mode...\n");
+			board_config = ALC861VD_3ST;
+		}
+	}
+
+	if (board_config != ALC861VD_AUTO)
+		setup_preset(spec, &alc861vd_presets[board_config]);
+
+	spec->stream_name_analog = "ALC861VD Analog";
+	spec->stream_analog_playback = &alc861vd_pcm_analog_playback;
+	spec->stream_analog_capture = &alc861vd_pcm_analog_capture;
+
+	spec->stream_name_digital = "ALC861VD Digital";
+	spec->stream_digital_playback = &alc861vd_pcm_digital_playback;
+	spec->stream_digital_capture = &alc861vd_pcm_digital_capture;
+
+	spec->adc_nids = alc861vd_adc_nids;
+	spec->num_adc_nids = ARRAY_SIZE(alc861vd_adc_nids);
+
+	spec->mixers[spec->num_mixers] = alc861vd_capture_mixer;
+	spec->num_mixers++;
+
+	codec->patch_ops = alc_patch_ops;
+
+	if (board_config == ALC861VD_AUTO)
+		spec->init_hook = alc861vd_auto_init;
+
+	return 0;
+}
+
+/*
  * patch entries
  */
 struct hda_codec_preset snd_hda_preset_realtek[] = {
 	{ .id = 0x10ec0260, .name = "ALC260", .patch = patch_alc260 },
 	{ .id = 0x10ec0262, .name = "ALC262", .patch = patch_alc262 },
- 	{ .id = 0x10ec0880, .name = "ALC880", .patch = patch_alc880 },
+	{ .id = 0x10ec0861, .rev = 0x100340, .name = "ALC660",
+		.patch = patch_alc861 },
+	{ .id = 0x10ec0660, .name = "ALC660-VD", .patch = patch_alc861vd },
+	{ .id = 0x10ec0861, .name = "ALC861", .patch = patch_alc861 },
+	{ .id = 0x10ec0862, .name = "ALC861-VD", .patch = patch_alc861vd },
+	{ .id = 0x10ec0880, .name = "ALC880", .patch = patch_alc880 },
 	{ .id = 0x10ec0882, .name = "ALC882", .patch = patch_alc882 },
 	{ .id = 0x10ec0883, .name = "ALC883", .patch = patch_alc883 },
 	{ .id = 0x10ec0885, .name = "ALC885", .patch = patch_alc882 },
 	{ .id = 0x10ec0888, .name = "ALC888", .patch = patch_alc883 },
-	{ .id = 0x10ec0861, .rev = 0x100300, .name = "ALC861",
-	  .patch = patch_alc861 },
-	{ .id = 0x10ec0861, .rev = 0x100340, .name = "ALC660",
-	  .patch = patch_alc861 },
-	{ .id = 0x10ec0660, .name = "ALC660", .patch = patch_alc861 },
 	{} /* terminator */
 };

--Boundary-00=_FD3wFRaZ2ALZgE7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_FD3wFRaZ2ALZgE7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_FD3wFRaZ2ALZgE7--
