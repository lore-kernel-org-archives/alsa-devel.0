From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 4/7] HDA patch_via.c: Add VT1708S and VT1702
	support
Date: Tue, 9 Sep 2008 15:56:01 +0800
Message-ID: <20080909075601.GG9638@prithivi.gnumonks.org>
References: <20080909073717.GC9638@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 95687103850
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:02:43 +0200 (CEST)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.63)
	(envelope-from <HaraldWelte@viatech.com>) id 1KcyBP-0007ug-4C
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 10:02:43 +0200
Received: from laforge by prithivi.gnumonks.org with local (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1Kcy4v-0004yq-6Y
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 15:56:01 +0800
Content-Disposition: inline
In-Reply-To: <20080909073717.GC9638@prithivi.gnumonks.org>
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

[ALSA] HDA VIA: Add support vor VIA VT1708S and VT1702 codec

The VT1702 and VT1708S codecs are new HDA codecs by VIA.

This patch adds support for them to the patch_via.c file for HDA

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

Index: linux-2.6/sound/pci/hda/patch_via.c
===================================================================
--- linux-2.6.orig/sound/pci/hda/patch_via.c
+++ linux-2.6/sound/pci/hda/patch_via.c
@@ -1,7 +1,7 @@
 /*
  * Universal Interface for Intel High Definition Audio Codec
  *
- * HD audio interface patch for VIA VT1708 codec
+ * HD audio interface patch for VIA VT1702/VT1708/VT1709 codec
  *
  * Copyright (c) 2006-2008 Lydia Wang <lydiawang@viatech.com>
  *			   Takashi Iwai <tiwai@suse.de>
@@ -31,6 +31,7 @@
 /* 2007-09-17  Lydia Wang  Add VT1708B codec support                        */
 /* 2007-11-14  Lydia Wang  Add VT1708A codec HP and CD pin connect config    */
 /* 2008-02-03  Lydia Wang  Fix Rear channels and Back channels inverse issue */
+/* 2008-03-06  Lydia Wang  Add VT1702 codec and VT1708S codec support        */
 /*                                                                           */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
 
@@ -55,8 +56,8 @@
 #define VT1708_DIGOUT_NID	0x14
 #define VT1708_DIGIN_NID	0x16
 #define VT1708_DIGIN_PIN	0x26
-#define VT1708_HP_PIN_NID      0x20
-#define VT1708_CD_PIN_NID      0x24
+#define VT1708_HP_PIN_NID	0x20
+#define VT1708_CD_PIN_NID	0x24
 
 #define VT1709_HP_DAC_NID	0x28
 #define VT1709_DIGOUT_NID	0x13
@@ -68,12 +69,19 @@
 #define VT1708B_DIGIN_NID	0x15
 #define VT1708B_DIGIN_PIN	0x21
 
+#define VT1708S_HP_NID		0x25
+#define VT1708S_DIGOUT_NID	0x12
+
+#define VT1702_HP_NID		0x17
+#define VT1702_DIGOUT_NID	0x11
+
 #define IS_VT1708_VENDORID(x)		((x) >= 0x11061708 && (x) <= 0x1106170b)
 #define IS_VT1709_10CH_VENDORID(x)	((x) >= 0x1106e710 && (x) <= 0x1106e713)
 #define IS_VT1709_6CH_VENDORID(x)	((x) >= 0x1106e714 && (x) <= 0x1106e717)
 #define IS_VT1708B_8CH_VENDORID(x)	((x) >= 0x1106e720 && (x) <= 0x1106e723)
 #define IS_VT1708B_4CH_VENDORID(x)	((x) >= 0x1106e724 && (x) <= 0x1106e727)
-
+#define IS_VT1708S_VENDORID(x)		((x) >= 0x11060397 && (x) <= 0x11067397)
+#define IS_VT1702_VENDORID(x)		((x) >= 0x11060398 && (x) <= 0x11067398)
 
 enum {
 	VIA_CTL_WIDGET_VOL,
@@ -150,6 +158,16 @@
 	0x13, 0x14
 };
 
+static hda_nid_t vt1708S_adc_nids[2] = {
+	/* ADC1-2 */
+	0x13, 0x14
+};
+
+static hda_nid_t vt1702_adc_nids[3] = {
+	/* ADC1-2 */
+	0x12, 0x20, 0x1F
+};
+
 /* add dynamic controls */
 static int via_add_control(struct via_spec *spec, int type, const char *name,
 			   unsigned long val)
@@ -294,6 +312,9 @@
 		  IS_VT1708B_4CH_VENDORID(vendor_id)) && (adc_idx == 0))
 		return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 					     0x17, &spec->cur_mux[adc_idx]);
+	else if (IS_VT1702_VENDORID(vendor_id) && (adc_idx == 0))
+		return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
+					     0x13, &spec->cur_mux[adc_idx]);
 	else
 		return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 					     spec->adc_nids[adc_idx],
@@ -2011,6 +2032,707 @@
 	return 0;
 }
 
+/* Patch for VT1708S */
+
+/* capture mixer elements */
+static struct snd_kcontrol_new vt1708S_capture_mixer[] = {
+	HDA_CODEC_VOLUME("Capture Volume", 0x13, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x13, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x14, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x14, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x1A, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost", 0x1E, 0x0, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		/* The multiple "Capture Source" controls confuse alsamixer
+		 * So call somewhat different..
+		 */
+		/* .name = "Capture Source", */
+		.name = "Input Source",
+		.count = 1,
+		.info = via_mux_enum_info,
+		.get = via_mux_enum_get,
+		.put = via_mux_enum_put,
+	},
+	{ } /* end */
+};
+
+static struct hda_verb vt1708S_volume_init_verbs[] = {
+	/* Unmute ADC0-1 and set the default input to mic-in */
+	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+
+	/* Unmute input amps (CD, Line In, Mic 1 & Mic 2) of the
+	 * analog-loopback mixer widget */
+	/* Amp Indices: CD = 1, Mic1 = 2, Line = 3, Mic2 = 4 */
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(3)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(4)},
+
+	/* Setup default input of PW4 to MW0 */
+	{0x1d, AC_VERB_SET_CONNECT_SEL, 0x0},
+	/* PW9 Output enable */
+	{0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
+	{ }
+};
+
+static struct hda_pcm_stream vt1708S_pcm_analog_playback = {
+	.substreams = 2,
+	.channels_min = 2,
+	.channels_max = 8,
+	.nid = 0x10, /* NID to query formats and rates */
+	.ops = {
+		.open = via_playback_pcm_open,
+		.prepare = via_playback_pcm_prepare,
+		.cleanup = via_playback_pcm_cleanup
+	},
+};
+
+static struct hda_pcm_stream vt1708S_pcm_analog_capture = {
+	.substreams = 2,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0x13, /* NID to query formats and rates */
+	.ops = {
+		.prepare = via_capture_pcm_prepare,
+		.cleanup = via_capture_pcm_cleanup
+	},
+};
+
+static struct hda_pcm_stream vt1708S_pcm_digital_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in via_build_pcms */
+	.ops = {
+		.open = via_dig_playback_pcm_open,
+		.close = via_dig_playback_pcm_close,
+		.prepare = via_dig_playback_pcm_prepare
+	},
+};
+
+/* fill in the dac_nids table from the parsed pin configuration */
+static int vt1708S_auto_fill_dac_nids(struct via_spec *spec,
+				     const struct auto_pin_cfg *cfg)
+{
+	int i;
+	hda_nid_t nid;
+
+	spec->multiout.num_dacs = cfg->line_outs;
+
+	spec->multiout.dac_nids = spec->private_dac_nids;
+
+	for (i = 0; i < 4; i++) {
+		nid = cfg->line_out_pins[i];
+		if (nid) {
+			/* config dac list */
+			switch (i) {
+			case AUTO_SEQ_FRONT:
+				spec->multiout.dac_nids[i] = 0x10;
+				break;
+			case AUTO_SEQ_CENLFE:
+				spec->multiout.dac_nids[i] = 0x24;
+				break;
+			case AUTO_SEQ_SURROUND:
+				spec->multiout.dac_nids[i] = 0x11;
+				break;
+			case AUTO_SEQ_SIDE:
+				spec->multiout.dac_nids[i] = 0x25;
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/* add playback controls from the parsed DAC table */
+static int vt1708S_auto_create_multi_out_ctls(struct via_spec *spec,
+					     const struct auto_pin_cfg *cfg)
+{
+	char name[32];
+	static const char *chname[4] = { "Front", "Surround", "C/LFE", "Side" };
+	hda_nid_t nid_vols[] = {0x10, 0x11, 0x24, 0x25};
+	hda_nid_t nid_mutes[] = {0x1C, 0x18, 0x26, 0x27};
+	hda_nid_t nid, nid_vol, nid_mute;
+	int i, err;
+
+	for (i = 0; i <= AUTO_SEQ_SIDE; i++) {
+		nid = cfg->line_out_pins[i];
+
+		if (!nid)
+			continue;
+
+		nid_vol = nid_vols[i];
+		nid_mute = nid_mutes[i];
+
+		if (i == AUTO_SEQ_CENLFE) {
+			/* Center/LFE */
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+					      "Center Playback Volume",
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 1, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+					      "LFE Playback Volume",
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 2, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+					      "Center Playback Switch",
+					      HDA_COMPOSE_AMP_VAL(nid_mute,
+								  1, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+					      "LFE Playback Switch",
+					      HDA_COMPOSE_AMP_VAL(nid_mute,
+								  2, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+		} else if (i == AUTO_SEQ_FRONT) {
+			/* add control to mixer index 0 */
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+					      "Master Front Playback Volume",
+					      HDA_COMPOSE_AMP_VAL(0x16, 3, 0,
+								  HDA_INPUT));
+			if (err < 0)
+				return err;
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+					      "Master Front Playback Switch",
+					      HDA_COMPOSE_AMP_VAL(0x16, 3, 0,
+								  HDA_INPUT));
+			if (err < 0)
+				return err;
+
+			/* Front */
+			sprintf(name, "%s Playback Volume", chname[i]);
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+			sprintf(name, "%s Playback Switch", chname[i]);
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
+					      HDA_COMPOSE_AMP_VAL(nid_mute,
+								  3, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+		} else {
+			sprintf(name, "%s Playback Volume", chname[i]);
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+			sprintf(name, "%s Playback Switch", chname[i]);
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
+					      HDA_COMPOSE_AMP_VAL(nid_mute,
+								  3, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+static int vt1708S_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
+{
+	int err;
+
+	if (!pin)
+		return 0;
+
+	spec->multiout.hp_nid = VT1708S_HP_NID; /* AOW3 */
+
+	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+			      "Headphone Playback Volume",
+			      HDA_COMPOSE_AMP_VAL(0x25, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+
+	err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+			      "Headphone Playback Switch",
+			      HDA_COMPOSE_AMP_VAL(pin, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+/* create playback/capture controls for input pins */
+static int vt1708S_auto_create_analog_input_ctls(struct via_spec *spec,
+						const struct auto_pin_cfg *cfg)
+{
+	static char *labels[] = {
+		"Mic", "Front Mic", "Line", "Front Line", "CD", "Aux", NULL
+	};
+	struct hda_input_mux *imux = &spec->private_imux;
+	int i, err, idx = 0;
+
+	/* for internal loopback recording select */
+	imux->items[imux->num_items].label = "Stereo Mixer";
+	imux->items[imux->num_items].index = 5;
+	imux->num_items++;
+
+	for (i = 0; i < AUTO_PIN_LAST; i++) {
+		if (!cfg->input_pins[i])
+			continue;
+
+		switch (cfg->input_pins[i]) {
+		case 0x1a: /* Mic */
+			idx = 2;
+			break;
+
+		case 0x1b: /* Line In */
+			idx = 3;
+			break;
+
+		case 0x1e: /* Front Mic */
+			idx = 4;
+			break;
+
+		case 0x1f: /* CD */
+			idx = 1;
+			break;
+		}
+		err = via_new_analog_input(spec, cfg->input_pins[i], labels[i],
+					   idx, 0x16);
+		if (err < 0)
+			return err;
+		imux->items[imux->num_items].label = labels[i];
+		imux->items[imux->num_items].index = idx-1;
+		imux->num_items++;
+	}
+	return 0;
+}
+
+static int vt1708S_parse_auto_config(struct hda_codec *codec)
+{
+	struct via_spec *spec = codec->spec;
+	int err;
+	static hda_nid_t vt1708s_ignore[] = {0x21, 0};
+
+	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg,
+					   vt1708s_ignore);
+	if (err < 0)
+		return err;
+	err = vt1708S_auto_fill_dac_nids(spec, &spec->autocfg);
+	if (err < 0)
+		return err;
+	if (!spec->autocfg.line_outs && !spec->autocfg.hp_pins[0])
+		return 0; /* can't find valid BIOS pin config */
+
+	err = vt1708S_auto_create_multi_out_ctls(spec, &spec->autocfg);
+	if (err < 0)
+		return err;
+	err = vt1708S_auto_create_hp_ctls(spec, spec->autocfg.hp_pins[0]);
+	if (err < 0)
+		return err;
+	err = vt1708S_auto_create_analog_input_ctls(spec, &spec->autocfg);
+	if (err < 0)
+		return err;
+
+	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
+
+	if (spec->autocfg.dig_out_pin)
+		spec->multiout.dig_out_nid = VT1708S_DIGOUT_NID;
+
+	if (spec->kctl_alloc)
+		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
+
+	spec->input_mux = &spec->private_imux;
+
+	return 1;
+}
+
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+static struct hda_amp_list vt1708S_loopbacks[] = {
+	{ 0x16, HDA_INPUT, 1 },
+	{ 0x16, HDA_INPUT, 2 },
+	{ 0x16, HDA_INPUT, 3 },
+	{ 0x16, HDA_INPUT, 4 },
+	{ } /* end */
+};
+#endif
+
+static int patch_vt1708S(struct hda_codec *codec)
+{
+	struct via_spec *spec;
+	int err;
+
+	/* create a codec specific record */
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+
+	/* automatic parse from the BIOS config */
+	err = vt1708S_parse_auto_config(codec);
+	if (err < 0) {
+		via_free(codec);
+		return err;
+	} else if (!err) {
+		printk(KERN_INFO "hda_codec: Cannot set up configuration "
+		       "from BIOS.  Using genenic mode...\n");
+	}
+
+	spec->init_verbs = vt1708S_volume_init_verbs;
+
+	spec->stream_name_analog = "VT1708S Analog";
+	spec->stream_analog_playback = &vt1708S_pcm_analog_playback;
+	spec->stream_analog_capture = &vt1708S_pcm_analog_capture;
+
+	spec->stream_name_digital = "VT1708S Digital";
+	spec->stream_digital_playback = &vt1708S_pcm_digital_playback;
+
+	if (!spec->adc_nids && spec->input_mux) {
+		spec->adc_nids = vt1708S_adc_nids;
+		spec->num_adc_nids = ARRAY_SIZE(vt1708S_adc_nids);
+		spec->mixers[spec->num_mixers] = vt1708S_capture_mixer;
+		spec->num_mixers++;
+	}
+
+	codec->patch_ops = via_patch_ops;
+
+	codec->patch_ops.init = via_auto_init;
+
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+	spec->loopback.amplist = vt1708S_loopbacks;
+#endif
+
+	return 0;
+}
+
+/* Patch for VT1702 */
+
+/* capture mixer elements */
+static struct snd_kcontrol_new vt1702_capture_mixer[] = {
+	HDA_CODEC_VOLUME("Capture Volume", 0x12, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x12, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x20, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x20, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Digital Mic Capture Volume", 0x1F, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Digital Mic Capture Switch", 0x1F, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Digital Mic Boost Capture Volume", 0x1E, 0x0,
+			 HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		/* The multiple "Capture Source" controls confuse alsamixer
+		 * So call somewhat different..
+		 */
+		/* .name = "Capture Source", */
+		.name = "Input Source",
+		.count = 1,
+		.info = via_mux_enum_info,
+		.get = via_mux_enum_get,
+		.put = via_mux_enum_put,
+	},
+	{ } /* end */
+};
+
+static struct hda_verb vt1702_volume_init_verbs[] = {
+	/*
+	 * Unmute ADC0-1 and set the default input to mic-in
+	 */
+	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x1F, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+
+
+	/* Unmute input amps (CD, Line In, Mic 1 & Mic 2) of the analog-loopback
+	 * mixer widget
+	 */
+	/* Amp Indices: Mic1 = 1, Line = 1, Mic2 = 3 */
+	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},
+	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(3)},
+	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
+
+	/* Setup default input of PW4 to MW0 */
+	{0x17, AC_VERB_SET_CONNECT_SEL, 0x1},
+	/* PW6 PW7 Output enable */
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
+	{0x1C, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
+	{ }
+};
+
+static struct hda_pcm_stream vt1702_pcm_analog_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0x10, /* NID to query formats and rates */
+	.ops = {
+		.open = via_playback_pcm_open,
+		.prepare = via_playback_pcm_prepare,
+		.cleanup = via_playback_pcm_cleanup
+	},
+};
+
+static struct hda_pcm_stream vt1702_pcm_analog_capture = {
+	.substreams = 3,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0x12, /* NID to query formats and rates */
+	.ops = {
+		.prepare = via_capture_pcm_prepare,
+		.cleanup = via_capture_pcm_cleanup
+	},
+};
+
+static struct hda_pcm_stream vt1702_pcm_digital_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in via_build_pcms */
+	.ops = {
+		.open = via_dig_playback_pcm_open,
+		.close = via_dig_playback_pcm_close,
+		.prepare = via_dig_playback_pcm_prepare
+	},
+};
+
+/* fill in the dac_nids table from the parsed pin configuration */
+static int vt1702_auto_fill_dac_nids(struct via_spec *spec,
+				     const struct auto_pin_cfg *cfg)
+{
+	spec->multiout.num_dacs = 1;
+	spec->multiout.dac_nids = spec->private_dac_nids;
+
+	if (cfg->line_out_pins[0]) {
+		/* config dac list */
+		spec->multiout.dac_nids[0] = 0x10;
+	}
+
+	return 0;
+}
+
+/* add playback controls from the parsed DAC table */
+static int vt1702_auto_create_line_out_ctls(struct via_spec *spec,
+					     const struct auto_pin_cfg *cfg)
+{
+	int err;
+
+	if (!cfg->line_out_pins[0])
+		return -1;
+
+	/* add control to mixer index 0 */
+	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+			      "Master Front Playback Volume",
+			      HDA_COMPOSE_AMP_VAL(0x1A, 3, 0, HDA_INPUT));
+	if (err < 0)
+		return err;
+	err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+			      "Master Front Playback Switch",
+			      HDA_COMPOSE_AMP_VAL(0x1A, 3, 0, HDA_INPUT));
+	if (err < 0)
+		return err;
+
+	/* Front */
+	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+			      "Front Playback Volume",
+			      HDA_COMPOSE_AMP_VAL(0x10, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+	err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+			      "Front Playback Switch",
+			      HDA_COMPOSE_AMP_VAL(0x16, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int vt1702_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
+{
+	int err;
+
+	if (!pin)
+		return 0;
+
+	spec->multiout.hp_nid = 0x1D;
+
+	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+			      "Headphone Playback Volume",
+			      HDA_COMPOSE_AMP_VAL(0x1D, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+
+	err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+			      "Headphone Playback Switch",
+			      HDA_COMPOSE_AMP_VAL(pin, 3, 0, HDA_OUTPUT));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+/* create playback/capture controls for input pins */
+static int vt1702_auto_create_analog_input_ctls(struct via_spec *spec,
+						const struct auto_pin_cfg *cfg)
+{
+	static char *labels[] = {
+		"Mic", "Front Mic", "Line", "Front Line", "CD", "Aux", NULL
+	};
+	struct hda_input_mux *imux = &spec->private_imux;
+	int i, err, idx = 0;
+
+	/* for internal loopback recording select */
+	imux->items[imux->num_items].label = "Stereo Mixer";
+	imux->items[imux->num_items].index = 3;
+	imux->num_items++;
+
+	for (i = 0; i < AUTO_PIN_LAST; i++) {
+		if (!cfg->input_pins[i])
+			continue;
+
+		switch (cfg->input_pins[i]) {
+		case 0x14: /* Mic */
+			idx = 1;
+			break;
+
+		case 0x15: /* Line In */
+			idx = 2;
+			break;
+
+		case 0x18: /* Front Mic */
+			idx = 3;
+			break;
+		}
+		err = via_new_analog_input(spec, cfg->input_pins[i],
+					   labels[i], idx, 0x1A);
+		if (err < 0)
+			return err;
+		imux->items[imux->num_items].label = labels[i];
+		imux->items[imux->num_items].index = idx-1;
+		imux->num_items++;
+	}
+	return 0;
+}
+
+static int vt1702_parse_auto_config(struct hda_codec *codec)
+{
+	struct via_spec *spec = codec->spec;
+	int err;
+	static hda_nid_t vt1702_ignore[] = {0x1C, 0};
+
+	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg,
+					   vt1702_ignore);
+	if (err < 0)
+		return err;
+	err = vt1702_auto_fill_dac_nids(spec, &spec->autocfg);
+	if (err < 0)
+		return err;
+	if (!spec->autocfg.line_outs && !spec->autocfg.hp_pins[0])
+		return 0; /* can't find valid BIOS pin config */
+
+	err = vt1702_auto_create_line_out_ctls(spec, &spec->autocfg);
+	if (err < 0)
+		return err;
+	err = vt1702_auto_create_hp_ctls(spec, spec->autocfg.hp_pins[0]);
+	if (err < 0)
+		return err;
+	err = vt1702_auto_create_analog_input_ctls(spec, &spec->autocfg);
+	if (err < 0)
+		return err;
+
+	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
+
+	if (spec->autocfg.dig_out_pin)
+		spec->multiout.dig_out_nid = VT1702_DIGOUT_NID;
+
+	if (spec->kctl_alloc)
+		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
+
+	spec->input_mux = &spec->private_imux;
+
+	return 1;
+}
+
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+static struct hda_amp_list vt1702_loopbacks[] = {
+	{ 0x1A, HDA_INPUT, 1 },
+	{ 0x1A, HDA_INPUT, 2 },
+	{ 0x1A, HDA_INPUT, 3 },
+	{ 0x1A, HDA_INPUT, 4 },
+	{ } /* end */
+};
+#endif
+
+static int patch_vt1702(struct hda_codec *codec)
+{
+	struct via_spec *spec;
+	int err;
+	unsigned int response;
+	unsigned char control;
+
+	/* create a codec specific record */
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+
+	/* automatic parse from the BIOS config */
+	err = vt1702_parse_auto_config(codec);
+	if (err < 0) {
+		via_free(codec);
+		return err;
+	} else if (!err) {
+		printk(KERN_INFO "hda_codec: Cannot set up configuration "
+		       "from BIOS.  Using genenic mode...\n");
+	}
+
+	spec->init_verbs = vt1702_volume_init_verbs;
+
+	spec->stream_name_analog = "VT1702 Analog";
+	spec->stream_analog_playback = &vt1702_pcm_analog_playback;
+	spec->stream_analog_capture = &vt1702_pcm_analog_capture;
+
+	spec->stream_name_digital = "VT1702 Digital";
+	spec->stream_digital_playback = &vt1702_pcm_digital_playback;
+
+	if (!spec->adc_nids && spec->input_mux) {
+		spec->adc_nids = vt1702_adc_nids;
+		spec->num_adc_nids = ARRAY_SIZE(vt1702_adc_nids);
+		spec->mixers[spec->num_mixers] = vt1702_capture_mixer;
+		spec->num_mixers++;
+	}
+
+	codec->patch_ops = via_patch_ops;
+
+	codec->patch_ops.init = via_auto_init;
+
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+	spec->loopback.amplist = vt1702_loopbacks;
+#endif
+
+	/* Open backdoor */
+	response = snd_hda_codec_read(codec, codec->afg, 0, 0xF8C, 0);
+	control = (unsigned char)(response & 0xff);
+	control |= 0x3;
+	snd_hda_codec_write(codec,  codec->afg, 0, 0xF88, control);
+
+	/* Enable GPIO 0&1 for volume&mute control */
+	/* Enable GPIO 2 for DMIC-DATA */
+	response = snd_hda_codec_read(codec, codec->afg, 0, 0xF84, 0);
+	control = (unsigned char)((response >> 16) & 0x3f);
+	snd_hda_codec_write(codec,  codec->afg, 0, 0xF82, control);
+
+	return 0;
+}
+
 /*
  * patch entries
  */
@@ -2051,5 +2773,37 @@
 	  .patch = patch_vt1708B_4ch},
 	{ .id = 0x1106E727, .name = "VIA VT1708B 4-Ch",
 	  .patch = patch_vt1708B_4ch},
+	{ .id = 0x11060397, .name = "VIA VT1708S",
+	  .patch = patch_vt1708S},
+	{ .id = 0x11061397, .name = "VIA VT1708S",
+	  .patch = patch_vt1708S},
+	{ .id = 0x11062397, .name = "VIA VT1708S",
+	  .patch = patch_vt1708S},
+	{ .id = 0x11063397, .name = "VIA VT1708S",
+	  .patch = patch_vt1708S},
+	{ .id = 0x11064397, .name = "VIA VT1708S",
+	  .patch = patch_vt1708S},
+	{ .id = 0x11065397, .name = "VIA VT1708S",
+	  .patch = patch_vt1708S},
+	{ .id = 0x11066397, .name = "VIA VT1708S",
+	  .patch = patch_vt1708S},
+	{ .id = 0x11067397, .name = "VIA VT1708S",
+	  .patch = patch_vt1708S},
+	{ .id = 0x11060398, .name = "VIA VT1702",
+	  .patch = patch_vt1702},
+	{ .id = 0x11061398, .name = "VIA VT1702",
+	  .patch = patch_vt1702},
+	{ .id = 0x11062398, .name = "VIA VT1702",
+	  .patch = patch_vt1702},
+	{ .id = 0x11063398, .name = "VIA VT1702",
+	  .patch = patch_vt1702},
+	{ .id = 0x11064398, .name = "VIA VT1702",
+	  .patch = patch_vt1702},
+	{ .id = 0x11065398, .name = "VIA VT1702",
+	  .patch = patch_vt1702},
+	{ .id = 0x11066398, .name = "VIA VT1702",
+	  .patch = patch_vt1702},
+	{ .id = 0x11067398, .name = "VIA VT1702",
+	  .patch = patch_vt1702},
 	{} /* terminator */
 };
-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
