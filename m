From: Matt <matt@embeddedalley.com>
Subject: [PATCH] SigmaTel HDA multichannel support
Date: Sat, 25 Jun 2005 18:16:42 -0700
Message-ID: <20050625181642.A11554@cox.net>
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
To: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adds 6/8 channel support to the SigmaTel HDA patch. Please apply.

Signed-off-by: Matt <matt@embeddedalley.com>

Index: alsa-kernel/pci/hda/patch_sigmatel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_sigmatel.c,v
retrieving revision 1.2
diff -u -r1.2 patch_sigmatel.c
--- alsa-kernel/pci/hda/patch_sigmatel.c	14 Jun 2005 09:19:34 -0000	1.2
+++ alsa-kernel/pci/hda/patch_sigmatel.c	26 Jun 2005 01:09:35 -0000
@@ -30,32 +30,33 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <sound/core.h>
+#include <sound/asoundef.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 
 #undef STAC_TEST
 
 struct sigmatel_spec {
+	snd_kcontrol_new_t *mixers[4];
+	unsigned int num_mixers;
+
+	unsigned int surr_switch: 1;
+
 	/* playback */
 	struct hda_multi_out multiout;
-	hda_nid_t playback_nid;
+	hda_nid_t dac_nids[4];
 
 	/* capture */
 	hda_nid_t *adc_nids;
 	unsigned int num_adcs;
 	hda_nid_t *mux_nids;
 	unsigned int num_muxes;
-	hda_nid_t capture_nid;
 	hda_nid_t dig_in_nid;
 
-	/* power management*/
-	hda_nid_t *pstate_nids;
-	unsigned int num_pstates;
-
+#ifdef STAC_TEST
 	/* pin widgets */
 	hda_nid_t *pin_nids;
 	unsigned int num_pins;
-#ifdef STAC_TEST
 	unsigned int *pin_configs;
 #endif
 
@@ -64,16 +65,20 @@
 	snd_kcontrol_new_t *mixer;
 
 	/* capture source */
-	struct hda_input_mux input_mux;
-	char input_labels[HDA_MAX_NUM_INPUTS][16];
+	struct hda_input_mux *input_mux;
 	unsigned int cur_mux[2];
 
 	/* channel mode */
 	unsigned int num_ch_modes;
 	unsigned int cur_ch_mode;
-	const struct sigmatel_channel_mode *channel_modes;
 
-	struct hda_pcm pcm_rec[1];	/* PCM information */
+	struct hda_pcm pcm_rec[2];	/* PCM information */
+
+	/* dynamic controls and input_mux */
+	struct auto_pin_cfg autocfg;
+	unsigned int num_kctl_alloc, num_kctl_used;
+	snd_kcontrol_new_t *kctl_alloc;
+	struct hda_input_mux private_imux;
 };
 
 static hda_nid_t stac9200_adc_nids[1] = {
@@ -88,14 +93,6 @@
         0x02,
 };
 
-static hda_nid_t stac9200_pstate_nids[3] = {
-	0x01, 0x02, 0x03,
-};
-
-static hda_nid_t stac9200_pin_nids[8] = {
-	0x08, 0x09, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12,
-};
-
 static hda_nid_t stac922x_adc_nids[2] = {
         0x06, 0x07,
 };
@@ -104,24 +101,22 @@
         0x12, 0x13,
 };
 
-static hda_nid_t stac922x_dac_nids[4] = {
-        0x02, 0x03, 0x04, 0x05,
-};
-
-static hda_nid_t stac922x_pstate_nids[8] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x11,
+#ifdef STAC_TEST
+static hda_nid_t stac9200_pin_nids[8] = {
+	0x08, 0x09, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12,
 };
 
 static hda_nid_t stac922x_pin_nids[10] = {
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x10, 0x11, 0x15, 0x1b,
 };
+#endif
 
 static int stac92xx_mux_enum_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct sigmatel_spec *spec = codec->spec;
-	return snd_hda_input_mux_info(&spec->input_mux, uinfo);
+	return snd_hda_input_mux_info(spec->input_mux, uinfo);
 }
 
 static int stac92xx_mux_enum_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
@@ -140,26 +135,64 @@
 	struct sigmatel_spec *spec = codec->spec;
 	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 
-	return snd_hda_input_mux_put(codec, &spec->input_mux, ucontrol,
+	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 				     spec->mux_nids[adc_idx], &spec->cur_mux[adc_idx]);
 }
 
-static struct hda_verb stac9200_ch2_init[] = {
+static struct hda_verb stac9200_core_init[] = {
 	/* set dac0mux for dac converter */
-	{ 0x07, 0x701, 0x00},
+	{ 0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
 	{}
 };
 
-static struct hda_verb stac922x_ch2_init[] = {
+static struct hda_verb stac922x_core_init[] = {
 	/* set master volume and direct control */	
-	{ 0x16, 0x70f, 0xff},
+	{ 0x16, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	{}
 };
 
-struct sigmatel_channel_mode {
-	unsigned int channels;
-	const struct hda_verb *sequence;
-};
+static int stac922x_channel_modes[3] = {2, 6, 8};
+
+static int stac922x_ch_mode_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = spec->num_ch_modes;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	sprintf(uinfo->value.enumerated.name, "%dch",
+		stac922x_channel_modes[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int stac922x_ch_mode_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->cur_ch_mode;
+	return 0;
+}
+
+static int stac922x_ch_mode_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (ucontrol->value.enumerated.item[0] >= spec->num_ch_modes)
+		ucontrol->value.enumerated.item[0] = spec->num_ch_modes;
+	if (ucontrol->value.enumerated.item[0] == spec->cur_ch_mode &&
+	    ! codec->in_resume)
+		return 0;
+
+	spec->cur_ch_mode = ucontrol->value.enumerated.item[0];
+	spec->multiout.max_channels = stac922x_channel_modes[spec->cur_ch_mode];
+
+	return 1;
+}
 
 static snd_kcontrol_new_t stac9200_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
@@ -174,13 +207,12 @@
 	},
 	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Input Mux Volume", 0x0c, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0c, 0, HDA_OUTPUT),
 	{ } /* end */
 };
 
+/* This needs to be generated dynamically based on sequence */
 static snd_kcontrol_new_t stac922x_mixer[] = {
-	HDA_CODEC_VOLUME("PCM Playback Volume", 0x2, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("PCM Playback Switch", 0x2, 0x0, HDA_OUTPUT),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Input Source",
@@ -195,14 +227,38 @@
 	{ } /* end */
 };
 
+static snd_kcontrol_new_t stac922x_ch_mode_mixer[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Channel Mode",
+		.info = stac922x_ch_mode_info,
+		.get = stac922x_ch_mode_get,
+		.put = stac922x_ch_mode_put,
+	},
+	{ } /* end */
+};
+
 static int stac92xx_build_controls(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
 	int err;
+	int i;
 
 	err = snd_hda_add_new_ctls(codec, spec->mixer);
 	if (err < 0)
 		return err;
+
+	for (i = 0; i < spec->num_mixers; i++) {
+		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
+		if (err < 0)
+			return err;
+	}
+
+	if (spec->surr_switch) {
+		err = snd_hda_add_new_ctls(codec, stac922x_ch_mode_mixer);
+		if (err < 0)
+			return err;
+	}
 	if (spec->multiout.dig_out_nid) {
 		err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
 		if (err < 0)
@@ -222,9 +278,9 @@
 	0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
 };
 
-static unsigned int stac922x_pin_configs[14] = {
-	0x40000100, 0x40000100, 0x40000100, 0x01114010,
-	0x01813122, 0x40000100, 0x01447010, 0x01c47010,
+static unsigned int stac922x_pin_configs[10] = {
+	0x01014010, 0x01014011, 0x01014012, 0x0221401f,
+	0x01813122, 0x01014014, 0x01441030, 0x01c41030,
 	0x40000100, 0x40000100,
 };
 
@@ -255,180 +311,66 @@
 }
 #endif
 
-static int stac92xx_set_pinctl(struct hda_codec *codec, hda_nid_t nid, unsigned int value)
-{
-	unsigned int pin_ctl;
-
-	pin_ctl = snd_hda_codec_read(codec, nid, 0,
-				     AC_VERB_GET_PIN_WIDGET_CONTROL,
-				     0x00);
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    pin_ctl | value);
-
-	return 0;
-}
-
-static int stac92xx_set_vref(struct hda_codec *codec, hda_nid_t nid)
-{
-	unsigned int vref_caps = snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP) >> AC_PINCAP_VREF_SHIFT;
-	unsigned int vref_ctl = AC_PINCTL_VREF_HIZ;
-
-	if (vref_caps & AC_PINCAP_VREF_100)
-		vref_ctl = AC_PINCTL_VREF_100;
-	else if (vref_caps & AC_PINCAP_VREF_80)
-		vref_ctl = AC_PINCTL_VREF_80;
-	else if (vref_caps & AC_PINCAP_VREF_50)
-		vref_ctl = AC_PINCTL_VREF_50;
-	else if (vref_caps & AC_PINCAP_VREF_GRD)
-		vref_ctl = AC_PINCTL_VREF_GRD;
-
-	stac92xx_set_pinctl(codec, nid, vref_ctl);
-	
-	return 0;
-}
-
 /*
- * retrieve the default device type from the default config value
+ * Analog playback callbacks
  */
-#define get_defcfg_type(cfg) ((cfg & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT)
-#define get_defcfg_location(cfg) ((cfg & AC_DEFCFG_LOCATION) >> AC_DEFCFG_LOCATION_SHIFT)
-
-static int stac92xx_config_pin(struct hda_codec *codec, hda_nid_t nid, unsigned int pin_cfg)
+static int stac92xx_playback_pcm_open(struct hda_pcm_stream *hinfo,
+				      struct hda_codec *codec,
+				      snd_pcm_substream_t *substream)
 {
 	struct sigmatel_spec *spec = codec->spec;
-	u32 location = get_defcfg_location(pin_cfg);
-	char *label;
-	const char *type = NULL;
-	int ainput = 0;
-
-	switch(get_defcfg_type(pin_cfg)) {
-		case AC_JACK_HP_OUT:
-			/* Enable HP amp */
-			stac92xx_set_pinctl(codec, nid, AC_PINCTL_HP_EN);
-			/* Fall through */
-		case AC_JACK_SPDIF_OUT:
-		case AC_JACK_LINE_OUT:
-		case AC_JACK_SPEAKER:
-			/* Enable output */
-			stac92xx_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
-			break;
-		case AC_JACK_SPDIF_IN:
-			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
-			break;
-		case AC_JACK_MIC_IN:
-			if ((location & 0x0f) == AC_JACK_LOC_FRONT)
-				type = "Front Mic";
-			else
-				type = "Mic";
-			ainput = 1;
-			/* Set vref */
-			stac92xx_set_vref(codec, nid);
-			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
-			break;
-		case AC_JACK_CD:
-			type = "CD";
-			ainput = 1;
-			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
-			break;
-		case AC_JACK_LINE_IN:
-			if ((location & 0x0f) == AC_JACK_LOC_FRONT)
-				type = "Front Line";
-			else
-				type = "Line";
-			ainput = 1;
-			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
-			break;
-		case AC_JACK_AUX:
-			if ((location & 0x0f) == AC_JACK_LOC_FRONT)
-				type = "Front Aux";
-			else
-				type = "Aux";
-			ainput = 1;
-			stac92xx_set_pinctl(codec, nid, AC_PINCTL_IN_EN);
-			break;
-	}
-
-	if (ainput) {
-		hda_nid_t con_lst[HDA_MAX_NUM_INPUTS];
-		int i, j, num_cons, index = -1;
-		if (!type)
-			type = "Input";
-		label = spec->input_labels[spec->input_mux.num_items];
-		strcpy(label, type);
-		spec->input_mux.items[spec->input_mux.num_items].label = label;
-		for (i=0; i<spec->num_muxes; i++) {
-			num_cons = snd_hda_get_connections(codec, spec->mux_nids[i], con_lst, HDA_MAX_NUM_INPUTS);
-			for (j=0; j<num_cons; j++)
-				if (con_lst[j] == nid) {
-					index = j;
-					break;
-				}
-			if (index >= 0)
-				break;
-		}
-		spec->input_mux.items[spec->input_mux.num_items].index = index;
-		spec->input_mux.num_items++;
-	}
-
-	return 0;
+	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream);
 }
 
-static int stac92xx_config_pins(struct hda_codec *codec)
+/*
+ * set up the i/o for analog out
+ * when the digital out is available, copy the front out to digital out, too.
+ */
+static int stac92xx_multi_out_analog_prepare(struct hda_codec *codec, struct hda_multi_out *mout,
+				     unsigned int stream_tag,
+				     unsigned int format,
+				     snd_pcm_substream_t *substream)
 {
-	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t *nids = mout->dac_nids;
+	int chs = substream->runtime->channels;
 	int i;
-	unsigned int pin_cfg;
-
-	for (i=0; i < spec->num_pins; i++) {
-		/* Default to disabled */
-		snd_hda_codec_write(codec, spec->pin_nids[i], 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL,
-				    0x00);
-
-		pin_cfg = snd_hda_codec_read(codec, spec->pin_nids[i], 0,
-					     AC_VERB_GET_CONFIG_DEFAULT,
-					     0x00);
-		if (((pin_cfg & AC_DEFCFG_PORT_CONN) >> AC_DEFCFG_PORT_CONN_SHIFT) == AC_JACK_PORT_NONE)
-			continue;	/* Move on */
 
-		stac92xx_config_pin(codec, spec->pin_nids[i], pin_cfg);
+	down(&codec->spdif_mutex);
+	if (mout->dig_out_nid && mout->dig_out_used != HDA_DIG_EXCLUSIVE) {
+		if (chs == 2 &&
+		    snd_hda_is_supported_format(codec, mout->dig_out_nid, format) &&
+		    ! (codec->spdif_status & IEC958_AES0_NONAUDIO)) {
+			mout->dig_out_used = HDA_DIG_ANALOG_DUP;
+			/* setup digital receiver */
+			snd_hda_codec_setup_stream(codec, mout->dig_out_nid,
+						   stream_tag, 0, format);
+		} else {
+			mout->dig_out_used = 0;
+			snd_hda_codec_setup_stream(codec, mout->dig_out_nid, 0, 0, 0);
+		}
 	}
+	up(&codec->spdif_mutex);
 
+	/* front */
+	snd_hda_codec_setup_stream(codec, nids[HDA_FRONT], stream_tag, 0, format);
+	if (mout->hp_nid)
+		/* headphone out will just decode front left/right (stereo) */
+		snd_hda_codec_setup_stream(codec, mout->hp_nid, stream_tag, 0, format);
+	/* surrounds */
+	if (mout->max_channels > 2)
+		for (i = 1; i < mout->num_dacs; i++) {
+			if ((mout->max_channels == 6) && (i == 3))
+				break;
+			if (chs >= (i + 1) * 2) /* independent out */
+				snd_hda_codec_setup_stream(codec, nids[i], stream_tag, i * 2,
+						format);
+			else /* copy front */
+				snd_hda_codec_setup_stream(codec, nids[i], stream_tag, 0,
+						format);
+		}
 	return 0;
 }
 
-static int stac92xx_init(struct hda_codec *codec)
-{
-	struct sigmatel_spec *spec = codec->spec;
-	int i;
-
-	for (i=0; i < spec->num_pstates; i++)
-		snd_hda_codec_write(codec, spec->pstate_nids[i], 0,
-				    AC_VERB_SET_POWER_STATE, 0x00);
-
-	mdelay(100);
-
-	snd_hda_sequence_write(codec, spec->init);
-
-#ifdef STAC_TEST
-	stac92xx_set_config_regs(codec);
-#endif
-
-	stac92xx_config_pins(codec);
-
-	return 0;
-}
-
-/*
- * Analog playback callbacks
- */
-static int stac92xx_playback_pcm_open(struct hda_pcm_stream *hinfo,
-				      struct hda_codec *codec,
-				      snd_pcm_substream_t *substream)
-{
-	struct sigmatel_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream);
-}
 
 static int stac92xx_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 					 struct hda_codec *codec,
@@ -437,7 +379,7 @@
 					 snd_pcm_substream_t *substream)
 {
 	struct sigmatel_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout, stream_tag,
+	return stac92xx_multi_out_analog_prepare(codec, &spec->multiout, stream_tag,
 						format, substream);
 }
 
@@ -516,7 +458,7 @@
 static struct hda_pcm_stream stac92xx_pcm_analog_playback = {
 	.substreams = 1,
 	.channels_min = 2,
-	.channels_max = 2,
+	.channels_max = 8,
 	.nid = 0x02, /* NID to query formats and rates */
 	.ops = {
 		.open = stac92xx_playback_pcm_open,
@@ -544,11 +486,9 @@
 	codec->num_pcms = 1;
 	codec->pcm_info = info;
 
-	info->name = "STAC92xx";
+	info->name = "STAC92xx Analog";
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = stac92xx_pcm_analog_playback;
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->playback_nid;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE] = stac92xx_pcm_analog_capture;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->capture_nid;
 
 	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
 		codec->num_pcms++;
@@ -567,9 +507,325 @@
 	return 0;
 }
 
+#define NUM_CONTROL_ALLOC	32
+
+enum {
+	STAC_CTL_WIDGET_VOL,
+	STAC_CTL_WIDGET_MUTE,
+};
+
+static snd_kcontrol_new_t stac92xx_control_templates[] = {
+	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
+	HDA_CODEC_MUTE(NULL, 0, 0, 0),
+};
+
+/* add dynamic controls */
+static int stac92xx_add_control(struct sigmatel_spec *spec, int type, const char *name, unsigned long val)
+{
+	snd_kcontrol_new_t *knew;
+
+	if (spec->num_kctl_used >= spec->num_kctl_alloc) {
+		int num = spec->num_kctl_alloc + NUM_CONTROL_ALLOC;
+
+		knew = kcalloc(num + 1, sizeof(*knew), GFP_KERNEL); /* array + terminator */
+		if (! knew)
+			return -ENOMEM;
+		if (spec->kctl_alloc) {
+			memcpy(knew, spec->kctl_alloc, sizeof(*knew) * spec->num_kctl_alloc);
+			kfree(spec->kctl_alloc);
+		}
+		spec->kctl_alloc = knew;
+		spec->num_kctl_alloc = num;
+	}
+
+	knew = &spec->kctl_alloc[spec->num_kctl_used];
+	*knew = stac92xx_control_templates[type];
+	knew->name = snd_kmalloc_strdup(name, GFP_KERNEL);
+	if (! knew->name)
+		return -ENOMEM;
+	knew->private_value = val;
+	spec->num_kctl_used++;
+	return 0;
+}
+
+/* fill in the dac_nids table from the parsed pin configuration */
+static int stac92xx_auto_fill_dac_nids(struct hda_codec *codec, const struct auto_pin_cfg *cfg)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid;
+	int i;
+
+	/* check the pins hardwired to audio widget */
+	for (i = 0; i < cfg->line_outs; i++) {
+		nid = cfg->line_out_pins[i];
+		spec->multiout.dac_nids[i] = snd_hda_codec_read(codec, nid, 0,
+					AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
+	}
+
+	spec->multiout.num_dacs = cfg->line_outs;
+
+	return 0;
+}
+
+/* add playback controls from the parsed DAC table */
+static int stac92xx_auto_create_multi_out_ctls(struct sigmatel_spec *spec, const struct auto_pin_cfg *cfg)
+{
+	char name[32];
+	static const char *chname[4] = { "Front", "Surround", NULL /*CLFE*/, "Side" };
+	hda_nid_t nid;
+	int i, err;
+
+	for (i = 0; i < cfg->line_outs; i++) {
+		if (! spec->multiout.dac_nids[i])
+			continue;
+
+		nid = spec->multiout.dac_nids[i];
+
+		if (i == 2) {
+			/* Center/LFE */
+			if ((err = stac92xx_add_control(spec, STAC_CTL_WIDGET_VOL, "Center Playback Volume",
+					       HDA_COMPOSE_AMP_VAL(nid, 1, 0, HDA_OUTPUT))) < 0)
+				return err;
+			if ((err = stac92xx_add_control(spec, STAC_CTL_WIDGET_VOL, "LFE Playback Volume",
+					       HDA_COMPOSE_AMP_VAL(nid, 2, 0, HDA_OUTPUT))) < 0)
+				return err;
+			if ((err = stac92xx_add_control(spec, STAC_CTL_WIDGET_MUTE, "Center Playback Switch",
+					       HDA_COMPOSE_AMP_VAL(nid, 1, 0, HDA_OUTPUT))) < 0)
+				return err;
+			if ((err = stac92xx_add_control(spec, STAC_CTL_WIDGET_MUTE, "LFE Playback Switch",
+					       HDA_COMPOSE_AMP_VAL(nid, 2, 0, HDA_OUTPUT))) < 0)
+				return err;
+		} else {
+			sprintf(name, "%s Playback Volume", chname[i]);
+			if ((err = stac92xx_add_control(spec, STAC_CTL_WIDGET_VOL, name,
+					       HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT))) < 0)
+				return err;
+			sprintf(name, "%s Playback Switch", chname[i]);
+			if ((err = stac92xx_add_control(spec, STAC_CTL_WIDGET_MUTE, name,
+					       HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT))) < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+/* add playback controls for HP output */
+static int stac92xx_auto_create_hp_ctls(struct hda_codec *codec, struct auto_pin_cfg *cfg)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t pin = cfg->hp_pin;
+	hda_nid_t nid;
+	int i, err;
+
+	if (! pin)
+		return 0;
+
+	nid = snd_hda_codec_read(codec, pin, 0, AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
+	for (i = 0; i < cfg->line_outs; i++) {
+		if (! spec->multiout.dac_nids[i])
+			continue;
+		if (spec->multiout.dac_nids[i] == nid)
+			return 0;
+	}
+
+	spec->multiout.hp_nid = nid;
+
+	/* control HP volume/switch on the output mixer amp */
+	if ((err = stac92xx_add_control(spec, STAC_CTL_WIDGET_VOL, "Headphone Playback Volume",
+					HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT))) < 0)
+		return err;
+	if ((err = stac92xx_add_control(spec, STAC_CTL_WIDGET_MUTE, "Headphone Playback Switch",
+					HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT))) < 0)
+		return err;
+
+	return 0;
+}
+
+/* create playback/capture controls for input pins */
+static int stac92xx_auto_create_analog_input_ctls(struct hda_codec *codec, const struct auto_pin_cfg *cfg)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	static char *labels[AUTO_PIN_LAST] = {
+		"Mic", "Front Mic", "Line", "Front Line", "CD", "Aux"
+	};
+	struct hda_input_mux *imux = &spec->private_imux;
+	hda_nid_t con_lst[HDA_MAX_NUM_INPUTS];
+	int i, j, k;
+
+	for (i = 0; i < AUTO_PIN_LAST; i++) {
+		int index = -1;
+		if (cfg->input_pins[i]) {
+			imux->items[imux->num_items].label = labels[i];
+
+			for (j=0; j<spec->num_muxes; j++) {
+				int num_cons = snd_hda_get_connections(codec, spec->mux_nids[j], con_lst, HDA_MAX_NUM_INPUTS);
+				for (k=0; k<num_cons; k++)
+					if (con_lst[k] == cfg->input_pins[i]) {
+						index = k;
+					 	break;
+					}
+				if (index >= 0)
+					break;
+			}
+			imux->items[imux->num_items].index = index;
+			imux->num_items++;
+		}
+	}
+
+	return 0;
+}
+
+static void stac92xx_auto_set_pinctl(struct hda_codec *codec, hda_nid_t nid, int pin_type)
+
+{
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, pin_type);
+}
+
+static void stac92xx_auto_init_multi_out(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < spec->autocfg.line_outs; i++) {
+		hda_nid_t nid = spec->autocfg.line_out_pins[i];
+		stac92xx_auto_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
+	}
+}
+
+static void stac92xx_auto_init_hp_out(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t pin;
+
+	pin = spec->autocfg.hp_pin;
+	if (pin) /* connect to front */
+		stac92xx_auto_set_pinctl(codec, pin, AC_PINCTL_OUT_EN | AC_PINCTL_HP_EN);
+}
+
+static int stac922x_parse_auto_config(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int err;
+
+	if ((err = snd_hda_parse_pin_def_config(codec, &spec->autocfg)) < 0)
+		return err;
+	if ((err = stac92xx_auto_fill_dac_nids(codec, &spec->autocfg)) < 0)
+		return err;
+	if (! spec->autocfg.line_outs && ! spec->autocfg.hp_pin)
+		return 0; /* can't find valid pin config */
+
+	if ((err = stac92xx_auto_create_multi_out_ctls(spec, &spec->autocfg)) < 0 ||
+	    (err = stac92xx_auto_create_hp_ctls(codec, &spec->autocfg)) < 0 ||
+	    (err = stac92xx_auto_create_analog_input_ctls(codec, &spec->autocfg)) < 0)
+		return err;
+
+	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
+	if (spec->multiout.max_channels > 2) {
+		spec->surr_switch = 1;
+		spec->cur_ch_mode = 1;
+		spec->num_ch_modes = 2;
+		if (spec->multiout.max_channels == 8) {
+			spec->cur_ch_mode++;
+			spec->num_ch_modes++;
+		}
+	}
+
+	if (spec->autocfg.dig_out_pin) {
+		spec->multiout.dig_out_nid = 0x08;
+		stac92xx_auto_set_pinctl(codec, spec->autocfg.dig_out_pin, AC_PINCTL_OUT_EN);
+	}
+	if (spec->autocfg.dig_in_pin) {
+		spec->dig_in_nid = 0x09;
+		stac92xx_auto_set_pinctl(codec, spec->autocfg.dig_in_pin, AC_PINCTL_IN_EN);
+	}
+
+	if (spec->kctl_alloc)
+		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
+
+	spec->input_mux = &spec->private_imux;
+
+	return 1;
+}
+
+static int stac9200_parse_auto_config(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int err;
+
+	if ((err = snd_hda_parse_pin_def_config(codec, &spec->autocfg)) < 0)
+		return err;
+
+	if ((err = stac92xx_auto_create_analog_input_ctls(codec, &spec->autocfg)) < 0)
+		return err;
+
+	if (spec->autocfg.dig_out_pin) {
+		spec->multiout.dig_out_nid = 0x05;
+		stac92xx_auto_set_pinctl(codec, spec->autocfg.dig_out_pin, AC_PINCTL_OUT_EN);
+	}
+	if (spec->autocfg.dig_in_pin) {
+		spec->dig_in_nid = 0x04;
+		stac92xx_auto_set_pinctl(codec, spec->autocfg.dig_in_pin, AC_PINCTL_IN_EN);
+	}
+
+	if (spec->kctl_alloc)
+		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
+
+	spec->input_mux = &spec->private_imux;
+
+	return 1;
+}
+
+static int stac92xx_init_pstate(struct hda_codec *codec)
+{
+       hda_nid_t nid, nid_start;
+       int nodes;
+
+	snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_POWER_STATE, 0x00);
+
+       nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid_start);
+       for (nid = nid_start; nid < nodes + nid_start; nid++) {
+               unsigned int wid_caps = snd_hda_param_read(codec, nid,
+                                                  AC_PAR_AUDIO_WIDGET_CAP);
+		if (wid_caps & AC_WCAP_POWER)
+			snd_hda_codec_write(codec, nid, 0,
+                                    AC_VERB_SET_POWER_STATE, 0x00);
+	}
+
+	mdelay(100);
+
+	return 0;
+}
+
+static int stac92xx_init(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	stac92xx_init_pstate(codec);
+
+	snd_hda_sequence_write(codec, spec->init);
+
+	stac92xx_auto_init_multi_out(codec);
+	stac92xx_auto_init_hp_out(codec);
+
+	return 0;
+}
+
 static void stac92xx_free(struct hda_codec *codec)
 {
-	kfree(codec->spec);
+	struct sigmatel_spec *spec = codec->spec;
+	int i;
+
+	if (! spec)
+		return;
+
+	if (spec->kctl_alloc) {
+		for (i = 0; i < spec->num_kctl_used; i++)
+			kfree(spec->kctl_alloc[i].name);
+		kfree(spec->kctl_alloc);
+	}
+
+	kfree(spec);
 }
 
 static struct hda_codec_ops stac92xx_patch_ops = {
@@ -582,6 +838,7 @@
 static int patch_stac9200(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
+	int err;
 
 	spec  = kcalloc(1, sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
@@ -589,26 +846,27 @@
 
 	codec->spec = spec;
 
+#ifdef STAC_TEST
+	spec->pin_nids = stac9200_pin_nids;
+	spec->num_pins = 8;
+	spec->pin_configs = stac9200_pin_configs;
+	stac92xx_set_config_regs(codec);
+#endif
 	spec->multiout.max_channels = 2;
 	spec->multiout.num_dacs = 1;
 	spec->multiout.dac_nids = stac9200_dac_nids;
-	spec->multiout.dig_out_nid = 0x05;
-	spec->dig_in_nid = 0x04;
 	spec->adc_nids = stac9200_adc_nids;
 	spec->mux_nids = stac9200_mux_nids;
 	spec->num_muxes = 1;
-	spec->input_mux.num_items = 0;
-	spec->pstate_nids = stac9200_pstate_nids;
-	spec->num_pstates = 3;
-	spec->pin_nids = stac9200_pin_nids;
-#ifdef STAC_TEST
-	spec->pin_configs = stac9200_pin_configs;
-#endif
-	spec->num_pins = 8;
-	spec->init = stac9200_ch2_init;
+
+	spec->init = stac9200_core_init;
 	spec->mixer = stac9200_mixer;
-	spec->playback_nid = 0x02;
-	spec->capture_nid = 0x03;
+
+	err = stac9200_parse_auto_config(codec);
+	if (err < 0) {
+		stac92xx_free(codec);
+		return err;
+	}
 
 	codec->patch_ops = stac92xx_patch_ops;
 
@@ -618,6 +876,7 @@
 static int patch_stac922x(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
+	int err;
 
 	spec  = kcalloc(1, sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
@@ -625,26 +884,26 @@
 
 	codec->spec = spec;
 
-	spec->multiout.max_channels = 2;
-	spec->multiout.num_dacs = 4;
-	spec->multiout.dac_nids = stac922x_dac_nids;
-	spec->multiout.dig_out_nid = 0x08;
-	spec->dig_in_nid = 0x09;
-	spec->adc_nids = stac922x_adc_nids;
-	spec->mux_nids = stac922x_mux_nids;
-	spec->num_muxes = 2;
-	spec->input_mux.num_items = 0;
-	spec->pstate_nids = stac922x_pstate_nids;
-	spec->num_pstates = 8;
-	spec->pin_nids = stac922x_pin_nids;
 #ifdef STAC_TEST
+	spec->num_pins = 10;
+	spec->pin_nids = stac922x_pin_nids;
 	spec->pin_configs = stac922x_pin_configs;
+	stac92xx_set_config_regs(codec);
 #endif
-	spec->num_pins = 10;
-	spec->init = stac922x_ch2_init;
+	spec->adc_nids = stac922x_adc_nids;
+	spec->mux_nids = stac922x_mux_nids;
+	spec->num_muxes = 2;
+
+	spec->init = stac922x_core_init;
 	spec->mixer = stac922x_mixer;
-	spec->playback_nid = 0x02;
-	spec->capture_nid = 0x06;
+
+	spec->multiout.dac_nids = spec->dac_nids;
+
+	err = stac922x_parse_auto_config(codec);
+	if (err < 0) {
+		stac92xx_free(codec);
+		return err;
+	}
 
 	codec->patch_ops = stac92xx_patch_ops;
 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
