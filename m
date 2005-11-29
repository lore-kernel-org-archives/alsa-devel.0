From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: update sigmatel support and bug fixes
Date: Tue, 29 Nov 2005 07:53:24 -0700
Message-ID: <20051129075324.B17707@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

- Explictly set pin control as input for all input pins
- Fix bug in 922x mixer (no mute on adc0vol)
- Remove broken ch_mode control
- Add support for jack retasking mixer controls to use rear line and
  mic as surround outputs
- Add board tables to support autodetect and pin config defaults for
  systems with broken bioses
- Add support for several Intel mobos
- Add support for DFI mobo with reference boards attached
  (gets rid of compile time switch to use reference boards)

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

Index: alsa-kernel/pci/hda/patch_sigmatel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_sigmatel.c,v
retrieving revision 1.9
diff -u -r1.9 patch_sigmatel.c
--- alsa-kernel/pci/hda/patch_sigmatel.c	21 Nov 2005 16:33:22 -0000	1.9
+++ alsa-kernel/pci/hda/patch_sigmatel.c	29 Nov 2005 14:40:32 -0000
@@ -4,7 +4,7 @@
  * HD audio interface patch for SigmaTel STAC92xx
  *
  * Copyright (c) 2005 Embedded Alley Solutions, Inc.
- * <matt@embeddedalley.com>
+ * Matt Porter <mporter@embeddedalley.com>
  *
  * Based on patch_cmedia.c and patch_realtek.c
  * Copyright (c) 2004 Takashi Iwai <tiwai@suse.de>
@@ -34,17 +34,22 @@
 #include "hda_codec.h"
 #include "hda_local.h"
 
-#undef STAC_TEST
-
 #define NUM_CONTROL_ALLOC	32
 #define STAC_HP_EVENT		0x37
 #define STAC_UNSOL_ENABLE 	(AC_USRSP_EN | STAC_HP_EVENT)
 
+#define STAC_REF		0
+#define STAC_D945GTP3		1
+#define STAC_D945GTP5		2
+
 struct sigmatel_spec {
 	struct snd_kcontrol_new *mixers[4];
 	unsigned int num_mixers;
 
+	int board_config;
 	unsigned int surr_switch: 1;
+	unsigned int line_switch: 1;
+	unsigned int mic_switch: 1;
 
 	/* playback */
 	struct hda_multi_out multiout;
@@ -57,12 +62,10 @@
 	unsigned int num_muxes;
 	hda_nid_t dig_in_nid;
 
-#ifdef STAC_TEST
 	/* pin widgets */
 	hda_nid_t *pin_nids;
 	unsigned int num_pins;
 	unsigned int *pin_configs;
-#endif
 
 	/* codec specific stuff */
 	struct hda_verb *init;
@@ -72,9 +75,8 @@
 	struct hda_input_mux *input_mux;
 	unsigned int cur_mux[2];
 
-	/* channel mode */
-	unsigned int num_ch_modes;
-	unsigned int cur_ch_mode;
+	/* i/o switches */
+	unsigned int io_switch[2];
 
 	struct hda_pcm pcm_rec[2];	/* PCM information */
 
@@ -105,7 +107,6 @@
         0x12, 0x13,
 };
 
-#ifdef STAC_TEST
 static hda_nid_t stac9200_pin_nids[8] = {
 	0x08, 0x09, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12,
 };
@@ -114,7 +115,6 @@
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x10, 0x11, 0x15, 0x1b,
 };
-#endif
 
 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
@@ -155,49 +155,6 @@
 	{}
 };
 
-static int stac922x_channel_modes[3] = {2, 6, 8};
-
-static int stac922x_ch_mode_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = spec->num_ch_modes;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	sprintf(uinfo->value.enumerated.name, "%dch",
-		stac922x_channel_modes[uinfo->value.enumerated.item]);
-	return 0;
-}
-
-static int stac922x_ch_mode_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
-
-	ucontrol->value.enumerated.item[0] = spec->cur_ch_mode;
-	return 0;
-}
-
-static int stac922x_ch_mode_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct sigmatel_spec *spec = codec->spec;
-
-	if (ucontrol->value.enumerated.item[0] >= spec->num_ch_modes)
-		ucontrol->value.enumerated.item[0] = spec->num_ch_modes;
-	if (ucontrol->value.enumerated.item[0] == spec->cur_ch_mode &&
-	    ! codec->in_resume)
-		return 0;
-
-	spec->cur_ch_mode = ucontrol->value.enumerated.item[0];
-	spec->multiout.max_channels = stac922x_channel_modes[spec->cur_ch_mode];
-
-	return 1;
-}
-
 static struct snd_kcontrol_new stac9200_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Master Playback Switch", 0xb, 0, HDA_OUTPUT),
@@ -226,22 +183,10 @@
 		.put = stac92xx_mux_enum_put,
 	},
 	HDA_CODEC_VOLUME("Capture Volume", 0x17, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mux Capture Volume", 0x12, 0x0, HDA_OUTPUT),
 	{ } /* end */
 };
 
-static struct snd_kcontrol_new stac922x_ch_mode_mixer[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Channel Mode",
-		.info = stac922x_ch_mode_info,
-		.get = stac922x_ch_mode_get,
-		.put = stac922x_ch_mode_put,
-	},
-	{ } /* end */
-};
-
 static int stac92xx_build_controls(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -258,11 +203,6 @@
 			return err;
 	}
 
-	if (spec->surr_switch) {
-		err = snd_hda_add_new_ctls(codec, stac922x_ch_mode_mixer);
-		if (err < 0)
-			return err;
-	}
 	if (spec->multiout.dig_out_nid) {
 		err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
 		if (err < 0)
@@ -276,18 +216,67 @@
 	return 0;	
 }
 
-#ifdef STAC_TEST
-static unsigned int stac9200_pin_configs[8] = {
+static unsigned int ref9200_pin_configs[8] = {
 	0x01c47010, 0x01447010, 0x0221401f, 0x01114010,
 	0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
 };
 
-static unsigned int stac922x_pin_configs[10] = {
-	0x01014010, 0x01014011, 0x01014012, 0x0221401f,
-	0x01813122, 0x01014014, 0x01441030, 0x01c41030,
+static unsigned int *stac9200_brd_tbl[] = {
+	ref9200_pin_configs,
+};
+
+static struct hda_board_config stac9200_cfg_tbl[] = {
+	{ .modelname = "ref",
+	  .pci_subvendor = PCI_VENDOR_ID_INTEL,
+	  .pci_subdevice = 0x2668,	/* DFI LanParty */
+	  .config = STAC_REF },
+	{} /* terminator */
+};
+
+static unsigned int ref922x_pin_configs[10] = {
+	0x01014010, 0x01016011, 0x01012012, 0x0221401f,
+	0x01813122, 0x01011014, 0x01441030, 0x01c41030,
 	0x40000100, 0x40000100,
 };
 
+static unsigned int d945gtp3_pin_configs[10] = {
+	0x0221401f, 0x01a19022, 0x01813021, 0x01114010,
+	0x40000100, 0x40000100, 0x40000100, 0x40000100,
+	0x02a19120, 0x40000100,
+};
+
+static unsigned int d945gtp5_pin_configs[10] = {
+	0x0221401f, 0x01111012, 0x01813024, 0x01114010,
+	0x01a19021, 0x01116011, 0x01452130, 0x40000100,
+	0x02a19320, 0x40000100,
+};
+
+static unsigned int *stac922x_brd_tbl[] = {
+	ref922x_pin_configs,
+	d945gtp3_pin_configs,
+	d945gtp5_pin_configs,
+};
+
+static struct hda_board_config stac922x_cfg_tbl[] = {
+	{ .modelname = "ref",
+	  .pci_subvendor = PCI_VENDOR_ID_INTEL,
+	  .pci_subdevice = 0x2668,	/* DFI LanParty */
+	  .config = STAC_REF },		/* SigmaTel reference board */
+	{ .pci_subvendor = PCI_VENDOR_ID_INTEL,
+	  .pci_subdevice = 0x0101,
+	  .config = STAC_D945GTP3 },	/* Intel D945GTP - 3 Stack */
+	{ .pci_subvendor = PCI_VENDOR_ID_INTEL,
+	  .pci_subdevice = 0x0404,
+	  .config = STAC_D945GTP5 },	/* Intel D945GTP - 5 Stack */
+	{ .pci_subvendor = PCI_VENDOR_ID_INTEL,
+	  .pci_subdevice = 0x0303,
+	  .config = STAC_D945GTP5 },	/* Intel D945GNT - 5 Stack */
+	{ .pci_subvendor = PCI_VENDOR_ID_INTEL,
+	  .pci_subdevice = 0x0013,
+	  .config = STAC_D945GTP5 },	/* Intel D955XBK - 5 Stack */
+	{} /* terminator */
+};
+
 static void stac92xx_set_config_regs(struct hda_codec *codec)
 {
 	int i;
@@ -310,10 +299,9 @@
 		pin_cfg = snd_hda_codec_read(codec, spec->pin_nids[i], 0,
 					     AC_VERB_GET_CONFIG_DEFAULT,
 					     0x00);	
-		printk("pin nid %2.2x pin config %8.8x\n", spec->pin_nids[i], pin_cfg);
+		snd_printdd(KERN_INFO "hda_codec: pin nid %2.2x pin config %8.8x\n", spec->pin_nids[i], pin_cfg);
 	}
 }
-#endif
 
 /*
  * Analog playback callbacks
@@ -326,56 +314,6 @@
 	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream);
 }
 
-/*
- * set up the i/o for analog out
- * when the digital out is available, copy the front out to digital out, too.
- */
-static int stac92xx_multi_out_analog_prepare(struct hda_codec *codec, struct hda_multi_out *mout,
-				     unsigned int stream_tag,
-				     unsigned int format,
-				     struct snd_pcm_substream *substream)
-{
-	hda_nid_t *nids = mout->dac_nids;
-	int chs = substream->runtime->channels;
-	int i;
-
-	down(&codec->spdif_mutex);
-	if (mout->dig_out_nid && mout->dig_out_used != HDA_DIG_EXCLUSIVE) {
-		if (chs == 2 &&
-		    snd_hda_is_supported_format(codec, mout->dig_out_nid, format) &&
-		    ! (codec->spdif_status & IEC958_AES0_NONAUDIO)) {
-			mout->dig_out_used = HDA_DIG_ANALOG_DUP;
-			/* setup digital receiver */
-			snd_hda_codec_setup_stream(codec, mout->dig_out_nid,
-						   stream_tag, 0, format);
-		} else {
-			mout->dig_out_used = 0;
-			snd_hda_codec_setup_stream(codec, mout->dig_out_nid, 0, 0, 0);
-		}
-	}
-	up(&codec->spdif_mutex);
-
-	/* front */
-	snd_hda_codec_setup_stream(codec, nids[HDA_FRONT], stream_tag, 0, format);
-	if (mout->hp_nid)
-		/* headphone out will just decode front left/right (stereo) */
-		snd_hda_codec_setup_stream(codec, mout->hp_nid, stream_tag, 0, format);
-	/* surrounds */
-	if (mout->max_channels > 2)
-		for (i = 1; i < mout->num_dacs; i++) {
-			if ((mout->max_channels == 6) && (i == 3))
-				break;
-			if (chs >= (i + 1) * 2) /* independent out */
-				snd_hda_codec_setup_stream(codec, nids[i], stream_tag, i * 2,
-						format);
-			else /* copy front */
-				snd_hda_codec_setup_stream(codec, nids[i], stream_tag, 0,
-						format);
-		}
-	return 0;
-}
-
-
 static int stac92xx_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 					 struct hda_codec *codec,
 					 unsigned int stream_tag,
@@ -383,8 +321,7 @@
 					 struct snd_pcm_substream *substream)
 {
 	struct sigmatel_spec *spec = codec->spec;
-	return stac92xx_multi_out_analog_prepare(codec, &spec->multiout, stream_tag,
-						format, substream);
+	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout, stream_tag, format, substream);
 }
 
 static int stac92xx_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
@@ -511,14 +448,70 @@
 	return 0;
 }
 
+static void stac92xx_auto_set_pinctl(struct hda_codec *codec, hda_nid_t nid, int pin_type)
+
+{
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, pin_type);
+}
+
+static int stac92xx_io_switch_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int stac92xx_io_switch_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	int io_idx = kcontrol-> private_value & 0xff;
+
+	ucontrol->value.integer.value[0] = spec->io_switch[io_idx];
+	return 0;
+}
+
+static int stac92xx_io_switch_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+        struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+        hda_nid_t nid = kcontrol->private_value >> 8;
+	int io_idx = kcontrol-> private_value & 0xff;
+        unsigned short val = ucontrol->value.integer.value[0];
+
+	spec->io_switch[io_idx] = val;
+
+	if (val)
+		stac92xx_auto_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
+	else
+		stac92xx_auto_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
+
+        return 1;
+}
+
+#define STAC_CODEC_IO_SWITCH(xname, xpval) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	  .name = xname, \
+	  .index = 0, \
+          .info = stac92xx_io_switch_info, \
+          .get = stac92xx_io_switch_get, \
+          .put = stac92xx_io_switch_put, \
+          .private_value = xpval, \
+	}
+
+
 enum {
 	STAC_CTL_WIDGET_VOL,
 	STAC_CTL_WIDGET_MUTE,
+	STAC_CTL_WIDGET_IO_SWITCH,
 };
 
 static struct snd_kcontrol_new stac92xx_control_templates[] = {
 	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
 	HDA_CODEC_MUTE(NULL, 0, 0, 0),
+	STAC_CODEC_IO_SWITCH(NULL, 0),
 };
 
 /* add dynamic controls */
@@ -550,6 +543,51 @@
 	return 0;
 }
 
+/* flag inputs as additional dynamic lineouts */
+static int stac92xx_add_dyn_out_pins(struct hda_codec *codec, struct auto_pin_cfg *cfg)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	switch (cfg->line_outs) {
+	case 3:
+		/* add line-in as side */
+		if (cfg->input_pins[AUTO_PIN_LINE]) {
+			cfg->line_out_pins[3] = cfg->input_pins[AUTO_PIN_LINE];
+			spec->line_switch = 1;
+			cfg->line_outs++;
+		}
+		break;
+	case 2:
+		/* add line-in as clfe and mic as side */
+		if (cfg->input_pins[AUTO_PIN_LINE]) {
+			cfg->line_out_pins[2] = cfg->input_pins[AUTO_PIN_LINE];
+			spec->line_switch = 1;
+			cfg->line_outs++;
+		}
+		if (cfg->input_pins[AUTO_PIN_MIC]) {
+			cfg->line_out_pins[3] = cfg->input_pins[AUTO_PIN_MIC];
+			spec->mic_switch = 1;
+			cfg->line_outs++;
+		}
+		break;
+	case 1:
+		/* add line-in as surr and mic as clfe */
+		if (cfg->input_pins[AUTO_PIN_LINE]) {
+			cfg->line_out_pins[1] = cfg->input_pins[AUTO_PIN_LINE];
+			spec->line_switch = 1;
+			cfg->line_outs++;
+		}
+		if (cfg->input_pins[AUTO_PIN_MIC]) {
+			cfg->line_out_pins[2] = cfg->input_pins[AUTO_PIN_MIC];
+			spec->mic_switch = 1;
+			cfg->line_outs++;
+		}
+		break;
+	}
+
+	return 0;
+}
+
 /* fill in the dac_nids table from the parsed pin configuration */
 static int stac92xx_auto_fill_dac_nids(struct hda_codec *codec, const struct auto_pin_cfg *cfg)
 {
@@ -578,7 +616,7 @@
 	int i, err;
 
 	for (i = 0; i < cfg->line_outs; i++) {
-		if (! spec->multiout.dac_nids[i])
+		if (!spec->multiout.dac_nids[i])
 			continue;
 
 		nid = spec->multiout.dac_nids[i];
@@ -609,6 +647,14 @@
 		}
 	}
 
+	if (spec->line_switch)
+		if ((err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH, "Line In as Output Switch", cfg->input_pins[AUTO_PIN_LINE] << 8)) < 0)
+			return err;
+
+	if (spec->mic_switch)
+		if ((err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH, "Mic as Output Switch", (cfg->input_pins[AUTO_PIN_MIC] << 8) | 1)) < 0)
+			return err;
+
 	return 0;
 }
 
@@ -666,6 +712,9 @@
 	for (i = 0; i < AUTO_PIN_LAST; i++) {
 		int index = -1;
 		if (cfg->input_pins[i]) {
+			/* Enable active pin widget as an input */
+			stac92xx_auto_set_pinctl(codec, cfg->input_pins[i], AC_PINCTL_IN_EN);
+
 			imux->items[imux->num_items].label = labels[i];
 
 			for (j=0; j<spec->num_muxes; j++) {
@@ -686,12 +735,6 @@
 	return 0;
 }
 
-static void stac92xx_auto_set_pinctl(struct hda_codec *codec, hda_nid_t nid, int pin_type)
-
-{
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, pin_type);
-}
-
 static void stac92xx_auto_init_multi_out(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -720,6 +763,8 @@
 
 	if ((err = snd_hda_parse_pin_def_config(codec, &spec->autocfg)) < 0)
 		return err;
+	if ((err = stac92xx_add_dyn_out_pins(codec, &spec->autocfg)) < 0)
+		return err;
 	if ((err = stac92xx_auto_fill_dac_nids(codec, &spec->autocfg)) < 0)
 		return err;
 	if (! spec->autocfg.line_outs && ! spec->autocfg.hp_pin)
@@ -731,15 +776,8 @@
 		return err;
 
 	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
-	if (spec->multiout.max_channels > 2) {
+	if (spec->multiout.max_channels > 2)
 		spec->surr_switch = 1;
-		spec->cur_ch_mode = 1;
-		spec->num_ch_modes = 2;
-		if (spec->multiout.max_channels == 8) {
-			spec->cur_ch_mode++;
-			spec->num_ch_modes++;
-		}
-	}
 
 	if (spec->autocfg.dig_out_pin) {
 		spec->multiout.dig_out_nid = 0x08;
@@ -901,13 +939,16 @@
 		return -ENOMEM;
 
 	codec->spec = spec;
+	spec->board_config = snd_hda_check_board_config(codec, stac9200_cfg_tbl);
+	if (spec->board_config < 0)
+                snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC9200, using BIOS defaults\n");
+	else {
+		spec->num_pins = 8;
+		spec->pin_nids = stac9200_pin_nids;
+		spec->pin_configs = stac9200_brd_tbl[spec->board_config];
+		stac92xx_set_config_regs(codec);
+	}
 
-#ifdef STAC_TEST
-	spec->pin_nids = stac9200_pin_nids;
-	spec->num_pins = 8;
-	spec->pin_configs = stac9200_pin_configs;
-	stac92xx_set_config_regs(codec);
-#endif
 	spec->multiout.max_channels = 2;
 	spec->multiout.num_dacs = 1;
 	spec->multiout.dac_nids = stac9200_dac_nids;
@@ -939,13 +980,16 @@
 		return -ENOMEM;
 
 	codec->spec = spec;
+	spec->board_config = snd_hda_check_board_config(codec, stac922x_cfg_tbl);
+	if (spec->board_config < 0)
+                snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC922x, using BIOS defaults\n");
+	else {
+		spec->num_pins = 10;
+		spec->pin_nids = stac922x_pin_nids;
+		spec->pin_configs = stac922x_brd_tbl[spec->board_config];
+		stac92xx_set_config_regs(codec);
+	}
 
-#ifdef STAC_TEST
-	spec->num_pins = 10;
-	spec->pin_nids = stac922x_pin_nids;
-	spec->pin_configs = stac922x_pin_configs;
-	stac92xx_set_config_regs(codec);
-#endif
 	spec->adc_nids = stac922x_adc_nids;
 	spec->mux_nids = stac922x_mux_nids;
 	spec->num_muxes = 2;


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
