From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 2/7] ALSA: CA0132: Add DSP mixers,
	switches and controls
Date: Fri, 7 Dec 2012 21:35:58 -0800
Message-ID: <1354944963-4654-3-git-send-email-ian_minett@creativelabs.com>
References: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Add the new switches, virtual nodes, controls and parameters used for 
configuring the firmware DSP.
Update callbacks and other routines to set up the correct streams and 
use the new effect switches.
Add verb tables for DSP init.

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 5e45a27..7856133 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -31,6 +31,7 @@
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
+#include "hda_jack.h"
 #include "hda_auto_parser.h"
 
 #include "ca0132_regs.h"
@@ -668,18 +669,6 @@ enum ca0132_sample_rate {
 	SR_RATE_UNKNOWN = 0x1F
 };
 
-/*
- *  Scp Helper function
- */
-enum get_set {
-	IS_SET = 0,
-	IS_GET = 1,
-};
-
-/*
- * Duplicated from ca0110 codec
- */
-
 static void init_output(struct hda_codec *codec, hda_nid_t pin, hda_nid_t dac)
 {
 	if (pin) {
@@ -704,54 +693,18 @@ static void init_input(struct hda_codec *codec, hda_nid_t pin, hda_nid_t adc)
 					    AC_VERB_SET_AMP_GAIN_MUTE,
 					    AMP_IN_UNMUTE(0));
 	}
-	if (adc && (get_wcaps(codec, adc) & AC_WCAP_IN_AMP))
+	if (adc && (get_wcaps(codec, adc) & AC_WCAP_IN_AMP)) {
 		snd_hda_codec_write(codec, adc, 0, AC_VERB_SET_AMP_GAIN_MUTE,
 				    AMP_IN_UNMUTE(0));
-}
 
-static int _add_switch(struct hda_codec *codec, hda_nid_t nid, const char *pfx,
-		       int chan, int dir)
-{
-	char namestr[44];
-	int type = dir ? HDA_INPUT : HDA_OUTPUT;
-	struct snd_kcontrol_new knew =
-		HDA_CODEC_MUTE_MONO(namestr, nid, chan, 0, type);
-	if ((query_amp_caps(codec, nid, type) & AC_AMPCAP_MUTE) == 0) {
-		snd_printdd("Skipping '%s %s Switch' (no mute on node 0x%x)\n", pfx, dirstr[dir], nid);
-		return 0;
+		/* init to 0 dB and unmute. */
+		snd_hda_codec_amp_stereo(codec, adc, HDA_INPUT, 0,
+					 HDA_AMP_VOLMASK, 0x5a);
+		snd_hda_codec_amp_stereo(codec, adc, HDA_INPUT, 0,
+					 HDA_AMP_MUTE, 0);
 	}
-	sprintf(namestr, "%s %s Switch", pfx, dirstr[dir]);
-	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
 }
 
-static int _add_volume(struct hda_codec *codec, hda_nid_t nid, const char *pfx,
-		       int chan, int dir)
-{
-	char namestr[44];
-	int type = dir ? HDA_INPUT : HDA_OUTPUT;
-	struct snd_kcontrol_new knew =
-		HDA_CODEC_VOLUME_MONO(namestr, nid, chan, 0, type);
-	if ((query_amp_caps(codec, nid, type) & AC_AMPCAP_NUM_STEPS) == 0) {
-		snd_printdd("Skipping '%s %s Volume' (no amp on node 0x%x)\n", pfx, dirstr[dir], nid);
-		return 0;
-	}
-	sprintf(namestr, "%s %s Volume", pfx, dirstr[dir]);
-	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
-}
-
-#define add_out_switch(codec, nid, pfx) _add_switch(codec, nid, pfx, 3, 0)
-#define add_out_volume(codec, nid, pfx) _add_volume(codec, nid, pfx, 3, 0)
-#define add_in_switch(codec, nid, pfx) _add_switch(codec, nid, pfx, 3, 1)
-#define add_in_volume(codec, nid, pfx) _add_volume(codec, nid, pfx, 3, 1)
-#define add_mono_switch(codec, nid, pfx, chan) \
-	_add_switch(codec, nid, pfx, chan, 0)
-#define add_mono_volume(codec, nid, pfx, chan) \
-	_add_volume(codec, nid, pfx, chan, 0)
-#define add_in_mono_switch(codec, nid, pfx, chan) \
-	_add_switch(codec, nid, pfx, chan, 1)
-#define add_in_mono_volume(codec, nid, pfx, chan) \
-	_add_volume(codec, nid, pfx, chan, 1)
-
 enum dsp_download_state {
 	DSP_DOWNLOAD_FAILED = -1,
 	DSP_DOWNLOAD_INIT   = 0,
@@ -770,21 +723,27 @@ enum dsp_download_state {
  */
 
 struct ca0132_spec {
+	struct snd_kcontrol_new *mixers[5];
+	unsigned int num_mixers;
+	const struct hda_verb *base_init_verbs;
+	const struct hda_verb *base_exit_verbs;
+	const struct hda_verb *init_verbs[5];
+	unsigned int num_init_verbs;  /* exclude base init verbs */
 	struct auto_pin_cfg autocfg;
+
+	/* Nodes configurations */
 	struct hda_multi_out multiout;
 	hda_nid_t out_pins[AUTO_CFG_MAX_OUTS];
 	hda_nid_t dacs[AUTO_CFG_MAX_OUTS];
-	hda_nid_t hp_dac;
+	unsigned int num_outputs;
 	hda_nid_t input_pins[AUTO_PIN_LAST];
 	hda_nid_t adcs[AUTO_PIN_LAST];
 	hda_nid_t dig_out;
 	hda_nid_t dig_in;
 	unsigned int num_inputs;
-	long curr_hp_switch;
-	long curr_hp_volume[2];
-	long curr_speaker_switch;
-	const char *input_labels[AUTO_PIN_LAST];
-	struct hda_pcm pcm_rec[2]; /* PCM information */
+	hda_nid_t shared_mic_nid;
+	hda_nid_t shared_out_nid;
+	struct hda_pcm pcm_rec[5];  /* PCM information */
 
 	/* chip access */
 	struct mutex chipio_mutex; /* chip access mutex */
@@ -799,6 +758,19 @@ struct ca0132_spec {
 	unsigned int scp_resp_header;
 	unsigned int scp_resp_data[4];
 	unsigned int scp_resp_count;
+
+	/* mixer and effects related */
+	unsigned char dmic_ctl;
+	int cur_out_type;
+	int cur_mic_type;
+	long vnode_lvol[VNODES_COUNT];
+	long vnode_rvol[VNODES_COUNT];
+	long vnode_lswitch[VNODES_COUNT];
+	long vnode_rswitch[VNODES_COUNT];
+	long effects_switch[EFFECTS_COUNT];
+	long voicefx_val;
+	long cur_mic_boost;
+
 };
 
 /*
@@ -882,6 +854,7 @@ static int chipio_write_address(struct hda_codec *codec,
  */
 static int chipio_write_data(struct hda_codec *codec, unsigned int data)
 {
+	struct ca0132_spec *spec = codec->spec;
 	int res;
 
 	/* send low 16 bits of the data */
@@ -893,6 +866,8 @@ static int chipio_write_data(struct hda_codec *codec, unsigned int data)
 				  data >> 16);
 	}
 
+	spec->curr_chip_addx = (res != -EIO) ?
+					(spec->curr_chip_addx + 4) : ~0UL;
 	return res;
 }
 
@@ -922,6 +897,7 @@ static int chipio_write_data_multiple(struct hda_codec *codec,
  */
 static int chipio_read_data(struct hda_codec *codec, unsigned int *data)
 {
+	struct ca0132_spec *spec = codec->spec;
 	int res;
 
 	/* post read */
@@ -939,6 +915,8 @@ static int chipio_read_data(struct hda_codec *codec, unsigned int *data)
 					   0);
 	}
 
+	spec->curr_chip_addx = (res != -EIO) ?
+					(spec->curr_chip_addx + 4) : ~0UL;\
 	return res;
 }
 
@@ -1414,6 +1392,12 @@ static int dspio_scp(struct hda_codec *codec,
 	return status;
 }
 
+static int dspio_set_param(struct hda_codec *codec, int mod_id,
+			int req, void *data, unsigned int len)
+{
+	return dspio_scp(codec, mod_id, req, SCP_SET, data, len, NULL, NULL);
+}
+
 /*
  * Allocate a DSP DMA channel via an SCP message
  */
@@ -2595,6 +2579,10 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
 
 
 /*
+ * Controls stuffs.
+ */
+
+/*
  * Mixer controls helpers.
  */
 #define CA0132_CODEC_VOL_MONO(xname, nid, channel, dir) \
@@ -2626,17 +2614,63 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
 	CA0132_CODEC_MUTE_MONO(xname, nid, 3, dir)
 
 /*
+ * PCM stuffs
+ */
+static void ca0132_setup_stream(struct hda_codec *codec, hda_nid_t nid,
+				 u32 stream_tag,
+				 int channel_id, int format)
+{
+	unsigned int oldval, newval;
+
+	if (!nid)
+		return;
+
+	snd_printdd(
+		   "ca0132_setup_stream: NID=0x%x, stream=0x%x, "
+		   "channel=%d, format=0x%x\n",
+		   nid, stream_tag, channel_id, format);
+
+	/* update the format-id if changed */
+	oldval = snd_hda_codec_read(codec, nid, 0,
+				    AC_VERB_GET_STREAM_FORMAT,
+				    0);
+	if (oldval != format) {
+		msleep(20);
+		snd_hda_codec_write(codec, nid, 0,
+				    AC_VERB_SET_STREAM_FORMAT,
+				    format);
+	}
+
+	oldval = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
+	newval = (stream_tag << 4) | channel_id;
+	if (oldval != newval) {
+		snd_hda_codec_write(codec, nid, 0,
+				    AC_VERB_SET_CHANNEL_STREAMID,
+				    newval);
+	}
+}
+
+static void ca0132_cleanup_stream(struct hda_codec *codec, hda_nid_t nid)
+{
+	unsigned int val;
+
+	if (!nid)
+		return;
+
+	snd_printdd(KERN_INFO "ca0132_cleanup_stream: NID=0x%x\n", nid);
+
+	val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
+	if (!val)
+		return;
+
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_STREAM_FORMAT, 0);
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CHANNEL_STREAMID, 0);
+}
+
+
+/*
  * PCM callbacks
  */
-static int ca0132_playback_pcm_open(struct hda_pcm_stream *hinfo,
-				    struct hda_codec *codec,
-				    struct snd_pcm_substream *substream)
-{
-	struct ca0132_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
-					     hinfo);
-}
-
 static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 			struct hda_codec *codec,
 			unsigned int stream_tag,
@@ -2644,8 +2678,10 @@ static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 			struct snd_pcm_substream *substream)
 {
 	struct ca0132_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout,
-						stream_tag, format, substream);
+
+	ca0132_setup_stream(codec, spec->dacs[0], stream_tag, 0, format);
+
+	return 0;
 }
 
 static int ca0132_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
@@ -2653,7 +2689,16 @@ static int ca0132_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
 			struct snd_pcm_substream *substream)
 {
 	struct ca0132_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
+
+	if (spec->dsp_state == DSP_DOWNLOADING)
+		return 0;
+
+	/*Allow stream some time to flush effects tail*/
+	msleep(50);
+
+	ca0132_cleanup_stream(codec, spec->dacs[0]);
+
+	return 0;
 }
 
 /*
@@ -2695,13 +2740,831 @@ static int ca0132_dig_playback_pcm_close(struct hda_pcm_stream *hinfo,
 }
 
 /*
+ * Analog capture
+ */
+static int ca0132_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
+					struct hda_codec *codec,
+					unsigned int stream_tag,
+					unsigned int format,
+					struct snd_pcm_substream *substream)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	ca0132_setup_stream(codec, spec->adcs[substream->number],
+			    stream_tag, 0, format);
+
+	return 0;
+}
+
+static int ca0132_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
+			struct hda_codec *codec,
+			struct snd_pcm_substream *substream)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	if (spec->dsp_state == DSP_DOWNLOADING)
+		return 0;
+
+	ca0132_cleanup_stream(codec, hinfo->nid);
+	return 0;
+}
+
+static int ca0132_select_out(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int pin_ctl;
+	int jack_present;
+	int auto_jack;
+	unsigned int tmp;
+	int err;
+
+	snd_printdd(KERN_INFO "ca0132_select_out\n");
+
+	snd_hda_power_up(codec);
+
+	auto_jack = spec->vnode_lswitch[VNID_HP_ASEL - VNODE_START_NID];
+
+	if (auto_jack)
+		jack_present = snd_hda_jack_detect(codec, spec->out_pins[1]);
+	else
+		jack_present =
+			spec->vnode_lswitch[VNID_HP_SEL - VNODE_START_NID];
+
+	if (jack_present)
+		spec->cur_out_type = HEADPHONE_OUT;
+	else
+		spec->cur_out_type = SPEAKER_OUT;
+
+	if (spec->cur_out_type == SPEAKER_OUT) {
+		snd_printdd(KERN_INFO "ca0132_select_out speaker\n");
+		/*speaker out config*/
+		tmp = FLOAT_ONE;
+		err = dspio_set_param(codec, 0x80, 0x04,
+					&tmp, sizeof(unsigned int));
+		if (err < 0)
+			goto exit;
+		/*enable speaker EQ*/
+		tmp = FLOAT_ONE;
+		err = dspio_set_param(codec, 0x8f, 0x00,
+					&tmp, sizeof(unsigned int));
+		if (err < 0)
+			goto exit;
+
+		/* Setup EAPD */
+		snd_hda_codec_write(codec, spec->out_pins[1], 0,
+				    VENDOR_CHIPIO_EAPD_SEL_SET, 0x02);
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+				    AC_VERB_SET_EAPD_BTLENABLE, 0x00);
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+				    VENDOR_CHIPIO_EAPD_SEL_SET, 0x00);
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+				    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
+
+		/* disable headphone node */
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[1], 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_codec_write(codec, spec->out_pins[1], 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    pin_ctl & 0xBF);
+		/* enable speaker node */
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
+					     AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    pin_ctl | 0x40);
+	} else {
+		snd_printdd(KERN_INFO "ca0132_select_out hp\n");
+		/*headphone out config*/
+		tmp = FLOAT_ZERO;
+		err = dspio_set_param(codec, 0x80, 0x04,
+					&tmp, sizeof(unsigned int));
+		if (err < 0)
+			goto exit;
+		/*disable speaker EQ*/
+		tmp = FLOAT_ZERO;
+		err = dspio_set_param(codec, 0x8f, 0x00,
+					&tmp, sizeof(unsigned int));
+		if (err < 0)
+			goto exit;
+
+		/* Setup EAPD */
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+				    VENDOR_CHIPIO_EAPD_SEL_SET, 0x00);
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+				    AC_VERB_SET_EAPD_BTLENABLE, 0x00);
+		snd_hda_codec_write(codec, spec->out_pins[1], 0,
+				    VENDOR_CHIPIO_EAPD_SEL_SET, 0x02);
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+				    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
+
+		/* disable speaker*/
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_codec_write(codec, spec->out_pins[0], 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    pin_ctl & 0xBF);
+		/* enable headphone*/
+		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[1], 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_codec_write(codec, spec->out_pins[1], 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    pin_ctl | 0x40);
+	}
+
+exit:
+	snd_hda_power_down(codec);
+
+	return err < 0 ? err : 0;
+}
+
+static void ca0132_set_dmic(struct hda_codec *codec, int enable);
+static int ca0132_mic_boost_set(struct hda_codec *codec, long val);
+static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val);
+
+static int ca0132_set_vipsource(struct hda_codec *codec, int val)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+
+	if (!dspload_is_loaded(codec))
+		return 0;
+
+	/* if CrystalVoice if off, vipsource should be 0 */
+	if (!spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] ||
+	    (val == 0)) {
+		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, 0);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
+		if (spec->cur_mic_type == DIGITAL_MIC)
+			tmp = FLOAT_TWO;
+		else
+			tmp = FLOAT_ONE;
+		dspio_set_param(codec, 0x80, 0x00, &tmp, sizeof(unsigned int));
+		tmp = FLOAT_ZERO;
+		dspio_set_param(codec, 0x80, 0x05, &tmp, sizeof(unsigned int));
+	} else {
+		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_16_000);
+		chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_16_000);
+		if (spec->cur_mic_type == DIGITAL_MIC)
+			tmp = FLOAT_TWO;
+		else
+			tmp = FLOAT_ONE;
+		dspio_set_param(codec, 0x80, 0x00, &tmp, sizeof(unsigned int));
+		tmp = FLOAT_ONE;
+		dspio_set_param(codec, 0x80, 0x05, &tmp, sizeof(unsigned int));
+		msleep(20);
+		chipio_set_control_param(codec, CONTROL_PARAM_VIP_SOURCE, val);
+	}
+
+	return 1;
+}
+
+static int ca0132_select_mic(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	int jack_present;
+	int auto_jack;
+
+	snd_printdd(KERN_INFO "ca0132_select_mic\n");
+
+	snd_hda_power_up(codec);
+
+	auto_jack = spec->vnode_lswitch[VNID_AMIC1_ASEL - VNODE_START_NID];
+
+	if (auto_jack)
+		jack_present = snd_hda_jack_detect(codec, spec->input_pins[0]);
+	else
+		jack_present =
+			spec->vnode_lswitch[VNID_AMIC1_SEL - VNODE_START_NID];
+
+	if (jack_present)
+		spec->cur_mic_type = LINE_MIC_IN;
+	else
+		spec->cur_mic_type = DIGITAL_MIC;
+
+	if (spec->cur_mic_type == DIGITAL_MIC) {
+		/* enable digital Mic */
+		chipio_set_conn_rate(codec, MEM_CONNID_DMIC, SR_32_000);
+		ca0132_set_dmic(codec, 1);
+		ca0132_mic_boost_set(codec, 0);
+		/* set voice focus */
+		ca0132_effects_set(codec, VOICE_FOCUS,
+				   spec->effects_switch
+				   [VOICE_FOCUS - EFFECT_START_NID]);
+	} else {
+		/* disable digital Mic */
+		chipio_set_conn_rate(codec, MEM_CONNID_DMIC, SR_96_000);
+		ca0132_set_dmic(codec, 0);
+		ca0132_mic_boost_set(codec, spec->cur_mic_boost);
+		/* disable voice focus */
+		ca0132_effects_set(codec, VOICE_FOCUS, 0);
+	}
+
+	snd_hda_power_down(codec);
+
+	return 0;
+}
+
+/*
+ * Check if VNODE settings take effect immediately.
+ */
+static bool ca0132_is_vnode_effective(struct hda_codec *codec,
+				     hda_nid_t vnid,
+				     hda_nid_t *shared_nid)
+{
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid;
+	bool effective = false;
+
+	switch (vnid) {
+	case VNID_SPK:
+		nid = spec->shared_out_nid;
+		effective = true;
+		break;
+	case VNID_MIC:
+		nid = spec->shared_mic_nid;
+		effective = true;
+		break;
+	default:
+		break;
+	}
+
+	if (effective && shared_nid)
+		*shared_nid = nid;
+
+	return effective;
+}
+
+/*
+ * The following functions are control change helpers.
+ * They return 0 if no changed.  Return 1 if changed.
+ */
+static int ca0132_voicefx_set(struct hda_codec *codec, int enable)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+
+	/* based on CrystalVoice state to enable VoiceFX. */
+	if (enable) {
+		tmp = spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] ?
+			FLOAT_ONE : FLOAT_ZERO;
+	} else {
+		tmp = FLOAT_ZERO;
+	}
+
+	dspio_set_param(codec, ca0132_voicefx.mid,
+			ca0132_voicefx.reqs[0], &tmp, sizeof(unsigned int));
+
+	return 1;
+}
+
+static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int on;
+	int num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
+	int err = 0;
+	int idx = nid - EFFECT_START_NID;
+
+	if ((idx < 0) || (idx >= num_fx))
+		return 0; /* no changed */
+
+	/* for out effect, qualify with PE */
+	if ((nid >= OUT_EFFECT_START_NID) && (nid < OUT_EFFECT_END_NID)) {
+		/* if PE if off, turn off out effects. */
+		if (!spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
+			val = 0;
+	}
+
+	/* for in effect, qualify with CrystalVoice */
+	if ((nid >= IN_EFFECT_START_NID) && (nid < IN_EFFECT_END_NID)) {
+		/* if CrystalVoice if off, turn off in effects. */
+		if (!spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID])
+			val = 0;
+
+		/* Voice Focus applies to 2-ch Mic, Digital Mic */
+		if ((nid == VOICE_FOCUS) && (spec->cur_mic_type != DIGITAL_MIC))
+			val = 0;
+	}
+
+	snd_printdd(KERN_INFO, "ca0132_effect_set: nid=0x%x, val=%ld\n",
+		    nid, val);
+
+	on = (val == 0) ? FLOAT_ZERO : FLOAT_ONE;
+	err = dspio_set_param(codec, ca0132_effects[idx].mid,
+				ca0132_effects[idx].reqs[0],
+				&on, sizeof(unsigned int));
+
+	if (err < 0)
+		return 0; /* no changed */
+
+	return 1;
+}
+
+static int ca0132_pe_switch_set(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid;
+	int i, ret = 0;
+
+	snd_printdd(KERN_INFO "ca0132_pe_switch_set: val=%ld\n",
+		    spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID]);
+
+	i = OUT_EFFECT_START_NID - EFFECT_START_NID;
+	nid = OUT_EFFECT_START_NID;
+	/* PE affects all out effects */
+	for (; nid < OUT_EFFECT_END_NID; nid++, i++)
+		ret |= ca0132_effects_set(codec, nid, spec->effects_switch[i]);
+
+	return ret;
+}
+
+/* Check if Mic1 is streaming, if so, stop streaming */
+static int stop_mic1(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int oldval = snd_hda_codec_read(codec, spec->adcs[0], 0,
+						 AC_VERB_GET_CONV, 0);
+	if (oldval != 0)
+		snd_hda_codec_write(codec, spec->adcs[0], 0,
+				    AC_VERB_SET_CHANNEL_STREAMID,
+				    0);
+	return oldval;
+}
+
+/* Resume Mic1 streaming if it was stopped. */
+static void resume_mic1(struct hda_codec *codec, unsigned int oldval)
+{
+	struct ca0132_spec *spec = codec->spec;
+	/* Restore the previous stream and channel */
+	if (oldval != 0)
+		snd_hda_codec_write(codec, spec->adcs[0], 0,
+				    AC_VERB_SET_CHANNEL_STREAMID,
+				    oldval);
+}
+
+static int ca0132_cvoice_switch_set(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid;
+	int i, ret = 0;
+	unsigned int oldval;
+
+	snd_printdd(KERN_INFO "ca0132_cvoice_switch_set: val=%ld\n",
+		    spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID]);
+
+	i = IN_EFFECT_START_NID - EFFECT_START_NID;
+	nid = IN_EFFECT_START_NID;
+	/* CrystalVoice affects all in effects */
+	for (; nid < IN_EFFECT_END_NID; nid++, i++)
+		ret |= ca0132_effects_set(codec, nid, spec->effects_switch[i]);
+
+	/* including VoiceFX */
+	ret |= ca0132_voicefx_set(codec, (spec->voicefx_val ? 1 : 0));
+
+	/* set correct vipsource */
+	oldval = stop_mic1(codec);
+	ret |= ca0132_set_vipsource(codec, 1);
+	resume_mic1(codec, oldval);
+	return ret;
+}
+
+static int ca0132_mic_boost_set(struct hda_codec *codec, long val)
+{
+	struct ca0132_spec *spec = codec->spec;
+	int ret = 0;
+
+	if (val) /* on */
+		ret = snd_hda_codec_amp_update(codec, spec->input_pins[0], 0,
+					HDA_INPUT, 0, HDA_AMP_VOLMASK, 3);
+	else /* off */
+		ret = snd_hda_codec_amp_update(codec, spec->input_pins[0], 0,
+					HDA_INPUT, 0, HDA_AMP_VOLMASK, 0);
+
+	return ret;
+}
+
+static int ca0132_vnode_switch_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	hda_nid_t shared_nid = 0;
+	bool effective;
+	int ret = 0;
+	struct ca0132_spec *spec = codec->spec;
+	int auto_jack;
+
+	if (nid == VNID_HP_SEL) {
+		auto_jack =
+			spec->vnode_lswitch[VNID_HP_ASEL - VNODE_START_NID];
+		if (!auto_jack)
+			ca0132_select_out(codec);
+		return 1;
+	}
+
+	if (nid == VNID_AMIC1_SEL) {
+		auto_jack =
+			spec->vnode_lswitch[VNID_AMIC1_ASEL - VNODE_START_NID];
+		if (!auto_jack)
+			ca0132_select_mic(codec);
+		return 1;
+	}
+
+	if (nid == VNID_HP_ASEL) {
+		ca0132_select_out(codec);
+		return 1;
+	}
+
+	if (nid == VNID_AMIC1_ASEL) {
+		ca0132_select_mic(codec);
+		return 1;
+	}
+
+	/* if effective conditions, then update hw immediately. */
+	effective = ca0132_is_vnode_effective(codec, nid, &shared_nid);
+	if (effective) {
+		int dir = get_amp_direction(kcontrol);
+		int ch = get_amp_channels(kcontrol);
+		unsigned long pval;
+
+		mutex_lock(&codec->control_mutex);
+		pval = kcontrol->private_value;
+		kcontrol->private_value = HDA_COMPOSE_AMP_VAL(shared_nid, ch,
+								0, dir);
+		ret = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
+		kcontrol->private_value = pval;
+		mutex_unlock(&codec->control_mutex);
+	}
+
+	return ret;
+}
+/* End of control change helpers. */
+
+static int ca0132_voicefx_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	unsigned int items = sizeof(ca0132_voicefx_presets)
+				/ sizeof(struct ct_voicefx_preset);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = items;
+	if (uinfo->value.enumerated.item >= items)
+		uinfo->value.enumerated.item = items - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       ca0132_voicefx_presets[uinfo->value.enumerated.item].name);
+	return 0;
+}
+
+static int ca0132_voicefx_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->voicefx_val;
+	return 0;
+}
+
+static int ca0132_voicefx_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	int i, err = 0;
+	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = sizeof(ca0132_voicefx_presets)
+				/ sizeof(struct ct_voicefx_preset);
+
+	if (sel >= items)
+		return 0;
+
+	snd_printdd(KERN_INFO "ca0132_voicefx_put: sel=%d, preset=%s\n",
+		    sel, ca0132_voicefx_presets[sel].name);
+
+	/*
+	 * Idx 0 is default.
+	 * Default needs to qualify with CrystalVoice state.
+	 */
+	for (i = 0; i < VOICEFX_MAX_PARAM_COUNT; i++) {
+		err = dspio_set_param(codec, ca0132_voicefx.mid,
+				ca0132_voicefx.reqs[i],
+				&(ca0132_voicefx_presets[sel].vals[i]),
+				sizeof(unsigned int));
+		if (err < 0)
+			break;
+	}
+
+	if (err >= 0) {
+		spec->voicefx_val = sel;
+		/* enable voice fx */
+		ca0132_voicefx_set(codec, (sel ? 1 : 0));
+	}
+
+	return 1;
+}
+
+static int ca0132_switch_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	int ch = get_amp_channels(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+
+	/* vnode */
+	if ((nid >= VNODE_START_NID) && (nid < VNODE_END_NID)) {
+		if (ch & 1) {
+			*valp = spec->vnode_lswitch[nid - VNODE_START_NID];
+			valp++;
+		}
+		if (ch & 2) {
+			*valp = spec->vnode_rswitch[nid - VNODE_START_NID];
+			valp++;
+		}
+		return 0;
+	}
+
+	/* effects, include PE and CrystalVoice */
+	if ((nid >= EFFECT_START_NID) && (nid < EFFECT_END_NID)) {
+		*valp = spec->effects_switch[nid - EFFECT_START_NID];
+		return 0;
+	}
+
+	/* mic boost */
+	if (nid == spec->input_pins[0]) {
+		*valp = spec->cur_mic_boost;
+		return 0;
+	}
+
+	return 0;
+}
+
+static int ca0132_switch_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	int ch = get_amp_channels(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	int changed = 1;
+
+	snd_printdd(KERN_INFO "ca0132_switch_put: nid=0x%x, val=%ld\n",
+		    nid, *valp);
+
+	snd_hda_power_up(codec);
+	/* vnode */
+	if ((nid >= VNODE_START_NID) && (nid < VNODE_END_NID)) {
+		if (ch & 1) {
+			spec->vnode_lswitch[nid - VNODE_START_NID] = *valp;
+			valp++;
+		}
+		if (ch & 2) {
+			spec->vnode_rswitch[nid - VNODE_START_NID] = *valp;
+			valp++;
+		}
+		changed = ca0132_vnode_switch_set(kcontrol, ucontrol);
+		goto exit;
+	}
+
+	/* PE */
+	if (nid == PLAY_ENHANCEMENT) {
+		spec->effects_switch[nid - EFFECT_START_NID] = *valp;
+		changed = ca0132_pe_switch_set(codec);
+		goto exit;
+	}
+
+	/* CrystalVoice */
+	if (nid == CRYSTAL_VOICE) {
+		spec->effects_switch[nid - EFFECT_START_NID] = *valp;
+		changed = ca0132_cvoice_switch_set(codec);
+		goto exit;
+	}
+
+	/* out and in effects */
+	if (((nid >= OUT_EFFECT_START_NID) && (nid < OUT_EFFECT_END_NID)) ||
+	    ((nid >= IN_EFFECT_START_NID) && (nid < IN_EFFECT_END_NID))) {
+		spec->effects_switch[nid - EFFECT_START_NID] = *valp;
+		changed = ca0132_effects_set(codec, nid, *valp);
+		goto exit;
+	}
+
+	/* mic boost */
+	if (nid == spec->input_pins[0]) {
+		spec->cur_mic_boost = *valp;
+
+		/* Mic boost does not apply to Digital Mic */
+		if (spec->cur_mic_type != DIGITAL_MIC)
+			changed = ca0132_mic_boost_set(codec, *valp);
+		goto exit;
+	}
+
+exit:
+	snd_hda_power_down(codec);
+	return changed;
+}
+
+/*
+ * Volume related
+ */
+static int ca0132_volume_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	int ch = get_amp_channels(kcontrol);
+	int dir = get_amp_direction(kcontrol);
+	unsigned long pval;
+	int err;
+
+	switch (nid) {
+	case VNID_SPK:
+		/* follow shared_out info */
+		nid = spec->shared_out_nid;
+		mutex_lock(&codec->control_mutex);
+		pval = kcontrol->private_value;
+		kcontrol->private_value = HDA_COMPOSE_AMP_VAL(nid, ch, 0, dir);
+		err = snd_hda_mixer_amp_volume_info(kcontrol, uinfo);
+		kcontrol->private_value = pval;
+		mutex_unlock(&codec->control_mutex);
+		break;
+	case VNID_MIC:
+		/* follow shared_mic info */
+		nid = spec->shared_mic_nid;
+		mutex_lock(&codec->control_mutex);
+		pval = kcontrol->private_value;
+		kcontrol->private_value = HDA_COMPOSE_AMP_VAL(nid, ch, 0, dir);
+		err = snd_hda_mixer_amp_volume_info(kcontrol, uinfo);
+		kcontrol->private_value = pval;
+		mutex_unlock(&codec->control_mutex);
+		break;
+	default:
+		err = snd_hda_mixer_amp_volume_info(kcontrol, uinfo);
+	}
+	return err;
+}
+
+static int ca0132_volume_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	int ch = get_amp_channels(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+
+	/* store the left and right volume */
+	if (ch & 1) {
+		*valp = spec->vnode_lvol[nid - VNODE_START_NID];
+		valp++;
+	}
+	if (ch & 2) {
+		*valp = spec->vnode_rvol[nid - VNODE_START_NID];
+		valp++;
+	}
+	return 0;
+}
+
+static int ca0132_volume_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	int ch = get_amp_channels(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	hda_nid_t shared_nid = 0;
+	bool effective;
+	int changed = 1;
+
+	/* store the left and right volume */
+	if (ch & 1) {
+		spec->vnode_lvol[nid - VNODE_START_NID] = *valp;
+		valp++;
+	}
+	if (ch & 2) {
+		spec->vnode_rvol[nid - VNODE_START_NID] = *valp;
+		valp++;
+	}
+
+	/* if effective conditions, then update hw immediately. */
+	effective = ca0132_is_vnode_effective(codec, nid, &shared_nid);
+	if (effective) {
+		int dir = get_amp_direction(kcontrol);
+		unsigned long pval;
+
+		snd_hda_power_up(codec);
+		mutex_lock(&codec->control_mutex);
+		pval = kcontrol->private_value;
+		kcontrol->private_value = HDA_COMPOSE_AMP_VAL(shared_nid, ch,
+								0, dir);
+		changed = snd_hda_mixer_amp_volume_put(kcontrol, ucontrol);
+		kcontrol->private_value = pval;
+		mutex_unlock(&codec->control_mutex);
+		snd_hda_power_down(codec);
+	}
+
+	return changed;
+}
+
+static int ca0132_volume_tlv(struct snd_kcontrol *kcontrol, int op_flag,
+			     unsigned int size, unsigned int __user *tlv)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	int ch = get_amp_channels(kcontrol);
+	int dir = get_amp_direction(kcontrol);
+	unsigned long pval;
+	int err;
+
+	switch (nid) {
+	case VNID_SPK:
+		/* follow shared_out tlv */
+		nid = spec->shared_out_nid;
+		mutex_lock(&codec->control_mutex);
+		pval = kcontrol->private_value;
+		kcontrol->private_value = HDA_COMPOSE_AMP_VAL(nid, ch, 0, dir);
+		err = snd_hda_mixer_amp_tlv(kcontrol, op_flag, size, tlv);
+		kcontrol->private_value = pval;
+		mutex_unlock(&codec->control_mutex);
+		break;
+	case VNID_MIC:
+		/* follow shared_mic tlv */
+		nid = spec->shared_mic_nid;
+		mutex_lock(&codec->control_mutex);
+		pval = kcontrol->private_value;
+		kcontrol->private_value = HDA_COMPOSE_AMP_VAL(nid, ch, 0, dir);
+		err = snd_hda_mixer_amp_tlv(kcontrol, op_flag, size, tlv);
+		kcontrol->private_value = pval;
+		mutex_unlock(&codec->control_mutex);
+		break;
+	default:
+		err = snd_hda_mixer_amp_tlv(kcontrol, op_flag, size, tlv);
+	}
+	return err;
+}
+
+static int add_fx_switch(struct hda_codec *codec, hda_nid_t nid,
+			 const char *pfx, int dir)
+{
+	char namestr[44];
+	int type = dir ? HDA_INPUT : HDA_OUTPUT;
+	struct snd_kcontrol_new knew =
+		CA0132_CODEC_MUTE_MONO(namestr, nid, 1, type);
+	sprintf(namestr, "%s %s Switch", pfx, dirstr[dir]);
+	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
+}
+
+static int add_voicefx(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_MUTE_MONO(ca0132_voicefx.name,
+				    VOICEFX, 1, 0, HDA_INPUT);
+	knew.info = ca0132_voicefx_info;
+	knew.get = ca0132_voicefx_get;
+	knew.put = ca0132_voicefx_put;
+	return snd_hda_ctl_add(codec, VOICEFX, snd_ctl_new1(&knew, codec));
+}
+
+/*
+ * When changing Node IDs for Mixer Controls below, make sure to update
+ * Node IDs in ca0132_config() as well.
+ */
+static struct snd_kcontrol_new ca0132_mixer[] = {
+	CA0132_CODEC_VOL("Master Playback Volume", VNID_SPK, HDA_OUTPUT),
+	CA0132_CODEC_MUTE("Master Playback Switch", VNID_SPK, HDA_OUTPUT),
+	CA0132_CODEC_VOL("Capture Volume", VNID_MIC, HDA_INPUT),
+	CA0132_CODEC_MUTE("Capture Switch", VNID_MIC, HDA_INPUT),
+	HDA_CODEC_VOLUME("Analog-Mic2 Capture Volume", 0x08, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Analog-Mic2 Capture Switch", 0x08, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("What U Hear Capture Volume", 0x0a, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("What U Hear Capture Switch", 0x0a, 0, HDA_INPUT),
+	CA0132_CODEC_MUTE_MONO("Mic1-Boost (30dB) Capture Switch",
+			       0x12, 1, HDA_INPUT),
+	CA0132_CODEC_MUTE_MONO("HP/Speaker Playback Switch",
+			       VNID_HP_SEL, 1, HDA_OUTPUT),
+	CA0132_CODEC_MUTE_MONO("AMic1/DMic Capture Switch",
+			       VNID_AMIC1_SEL, 1, HDA_INPUT),
+	CA0132_CODEC_MUTE_MONO("HP/Speaker Auto Detect Playback Switch",
+			       VNID_HP_ASEL, 1, HDA_OUTPUT),
+	CA0132_CODEC_MUTE_MONO("AMic1/DMic Auto Detect Capture Switch",
+			       VNID_AMIC1_ASEL, 1, HDA_INPUT),
+	{ } /* end */
+};
+
+/*
+ * PCM
  */
 static struct hda_pcm_stream ca0132_pcm_analog_playback = {
 	.substreams = 1,
 	.channels_min = 2,
-	.channels_max = 2,
+	.channels_max = 6,
 	.ops = {
-		.open = ca0132_playback_pcm_open,
 		.prepare = ca0132_playback_pcm_prepare,
 		.cleanup = ca0132_playback_pcm_cleanup
 	},
@@ -2711,6 +3574,10 @@ static struct hda_pcm_stream ca0132_pcm_analog_capture = {
 	.substreams = 1,
 	.channels_min = 2,
 	.channels_max = 2,
+	.ops = {
+		.prepare = ca0132_capture_pcm_prepare,
+		.cleanup = ca0132_capture_pcm_cleanup
+	},
 };
 
 static struct hda_pcm_stream ca0132_pcm_digital_playback = {
@@ -2745,10 +3612,24 @@ static int ca0132_build_pcms(struct hda_codec *codec)
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max =
 		spec->multiout.max_channels;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ca0132_pcm_analog_capture;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = spec->num_inputs;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[0];
 	codec->num_pcms++;
 
+	info++;
+	info->name = "CA0132 Analog Mic-In2";
+	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ca0132_pcm_analog_capture;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[1];
+	codec->num_pcms++;
+
+	info++;
+	info->name = "CA0132 What U Hear";
+	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ca0132_pcm_analog_capture;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[2];
+	codec->num_pcms++;
+
 	if (!spec->dig_out && !spec->dig_in)
 		return 0;
 
@@ -2770,233 +3651,44 @@ static int ca0132_build_pcms(struct hda_codec *codec)
 	return 0;
 }
 
-#define REG_CODEC_MUTE		0x18b014
-#define REG_CODEC_HP_VOL_L	0x18b070
-#define REG_CODEC_HP_VOL_R	0x18b074
-
-static int ca0132_hp_switch_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ca0132_spec *spec = codec->spec;
-	long *valp = ucontrol->value.integer.value;
-
-	*valp = spec->curr_hp_switch;
-	return 0;
-}
-
-static int ca0132_hp_switch_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ca0132_spec *spec = codec->spec;
-	long *valp = ucontrol->value.integer.value;
-	unsigned int data;
-	int err;
-
-	/* any change? */
-	if (spec->curr_hp_switch == *valp)
-		return 0;
-
-	snd_hda_power_up(codec);
-
-	err = chipio_read(codec, REG_CODEC_MUTE, &data);
-	if (err < 0)
-		goto exit;
-
-	/* *valp 0 is mute, 1 is unmute */
-	data = (data & 0x7f) | (*valp ? 0 : 0x80);
-	err = chipio_write(codec, REG_CODEC_MUTE, data);
-	if (err < 0)
-		goto exit;
-
-	spec->curr_hp_switch = *valp;
-
- exit:
-	snd_hda_power_down(codec);
-	return err < 0 ? err : 1;
-}
-
-static int ca0132_speaker_switch_get(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ca0132_spec *spec = codec->spec;
-	long *valp = ucontrol->value.integer.value;
-
-	*valp = spec->curr_speaker_switch;
-	return 0;
-}
-
-static int ca0132_speaker_switch_put(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ca0132_spec *spec = codec->spec;
-	long *valp = ucontrol->value.integer.value;
-	unsigned int data;
-	int err;
-
-	/* any change? */
-	if (spec->curr_speaker_switch == *valp)
-		return 0;
-
-	snd_hda_power_up(codec);
-
-	err = chipio_read(codec, REG_CODEC_MUTE, &data);
-	if (err < 0)
-		goto exit;
-
-	/* *valp 0 is mute, 1 is unmute */
-	data = (data & 0xef) | (*valp ? 0 : 0x10);
-	err = chipio_write(codec, REG_CODEC_MUTE, data);
-	if (err < 0)
-		goto exit;
-
-	spec->curr_speaker_switch = *valp;
-
- exit:
-	snd_hda_power_down(codec);
-	return err < 0 ? err : 1;
-}
-
-static int ca0132_hp_volume_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ca0132_spec *spec = codec->spec;
-	long *valp = ucontrol->value.integer.value;
-
-	*valp++ = spec->curr_hp_volume[0];
-	*valp = spec->curr_hp_volume[1];
-	return 0;
-}
-
-static int ca0132_hp_volume_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ca0132_spec *spec = codec->spec;
-	long *valp = ucontrol->value.integer.value;
-	long left_vol, right_vol;
-	unsigned int data;
-	int val;
-	int err;
-
-	left_vol = *valp++;
-	right_vol = *valp;
-
-	/* any change? */
-	if ((spec->curr_hp_volume[0] == left_vol) &&
-		(spec->curr_hp_volume[1] == right_vol))
-		return 0;
-
-	snd_hda_power_up(codec);
-
-	err = chipio_read(codec, REG_CODEC_HP_VOL_L, &data);
-	if (err < 0)
-		goto exit;
-
-	val = 31 - left_vol;
-	data = (data & 0xe0) | val;
-	err = chipio_write(codec, REG_CODEC_HP_VOL_L, data);
-	if (err < 0)
-		goto exit;
-
-	val = 31 - right_vol;
-	data = (data & 0xe0) | val;
-	err = chipio_write(codec, REG_CODEC_HP_VOL_R, data);
-	if (err < 0)
-		goto exit;
-
-	spec->curr_hp_volume[0] = left_vol;
-	spec->curr_hp_volume[1] = right_vol;
-
- exit:
-	snd_hda_power_down(codec);
-	return err < 0 ? err : 1;
-}
-
-static int add_hp_switch(struct hda_codec *codec, hda_nid_t nid)
-{
-	struct snd_kcontrol_new knew =
-		HDA_CODEC_MUTE_MONO("Headphone Playback Switch",
-				     nid, 1, 0, HDA_OUTPUT);
-	knew.get = ca0132_hp_switch_get;
-	knew.put = ca0132_hp_switch_put;
-	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
-}
-
-static int add_hp_volume(struct hda_codec *codec, hda_nid_t nid)
-{
-	struct snd_kcontrol_new knew =
-		HDA_CODEC_VOLUME_MONO("Headphone Playback Volume",
-				       nid, 3, 0, HDA_OUTPUT);
-	knew.get = ca0132_hp_volume_get;
-	knew.put = ca0132_hp_volume_put;
-	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
-}
-
-static int add_speaker_switch(struct hda_codec *codec, hda_nid_t nid)
-{
-	struct snd_kcontrol_new knew =
-		HDA_CODEC_MUTE_MONO("Speaker Playback Switch",
-				     nid, 1, 0, HDA_OUTPUT);
-	knew.get = ca0132_speaker_switch_get;
-	knew.put = ca0132_speaker_switch_put;
-	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
-}
-
-static void ca0132_fix_hp_caps(struct hda_codec *codec)
-{
-	struct ca0132_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	unsigned int caps;
-
-	/* set mute-capable, 1db step, 32 steps, ofs 6 */
-	caps = 0x80031f06;
-	snd_hda_override_amp_caps(codec, cfg->hp_pins[0], HDA_OUTPUT, caps);
-}
-
 static int ca0132_build_controls(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i, err;
+	int i, num_fx;
+	int err = 0;
 
-	if (spec->multiout.num_dacs) {
-		err = add_speaker_switch(codec, spec->out_pins[0]);
+	/* Add Mixer controls */
+	for (i = 0; i < spec->num_mixers; i++) {
+		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
 		if (err < 0)
 			return err;
 	}
 
-	if (cfg->hp_outs) {
-		ca0132_fix_hp_caps(codec);
-		err = add_hp_switch(codec, cfg->hp_pins[0]);
-		if (err < 0)
-			return err;
-		err = add_hp_volume(codec, cfg->hp_pins[0]);
+	/* Add in and out effects controls.
+	 * VoiceFX, PE and CrystalVoice are added separately.
+	 */
+	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
+	for (i = 0; i < num_fx; i++) {
+		err = add_fx_switch(codec, ca0132_effects[i].nid,
+				    ca0132_effects[i].name,
+				    ca0132_effects[i].direct);
 		if (err < 0)
 			return err;
 	}
 
-	for (i = 0; i < spec->num_inputs; i++) {
-		const char *label = spec->input_labels[i];
+	err = add_fx_switch(codec, PLAY_ENHANCEMENT, "PlayEnhancement", 0);
+	if (err < 0)
+		return err;
 
-		err = add_in_switch(codec, spec->adcs[i], label);
-		if (err < 0)
-			return err;
-		err = add_in_volume(codec, spec->adcs[i], label);
-		if (err < 0)
-			return err;
-		if (cfg->inputs[i].type == AUTO_PIN_MIC) {
-			/* add Mic-Boost */
-			err = add_in_mono_volume(codec, spec->input_pins[i],
-						 "Mic Boost", 1);
-			if (err < 0)
-				return err;
-		}
-	}
+	err = add_fx_switch(codec, CRYSTAL_VOICE, "CrystalVoice", 1);
+	if (err < 0)
+		return err;
+
+	add_voicefx(codec);
+
+	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
+	if (err < 0)
+		return err;
 
 	if (spec->dig_out) {
 		err = snd_hda_create_spdif_out_ctls(codec, spec->dig_out,
@@ -3017,6 +3709,204 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	return 0;
 }
 
+static void ca0132_init_unsol(struct hda_codec *codec)
+{
+	snd_hda_jack_detect_enable(codec, UNSOL_TAG_HP, UNSOL_TAG_HP);
+	snd_hda_jack_detect_enable(codec, UNSOL_TAG_AMIC1, UNSOL_TAG_AMIC1);
+}
+
+static void refresh_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir)
+{
+	unsigned int caps;
+
+	caps = snd_hda_param_read(codec, nid, dir == HDA_OUTPUT ?
+				  AC_PAR_AMP_OUT_CAP : AC_PAR_AMP_IN_CAP);
+	snd_hda_override_amp_caps(codec, nid, dir, caps);
+}
+
+static void ca0132_set_dmic(struct hda_codec *codec, int enable)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+	u8 val;
+	unsigned int oldval;
+
+	snd_printdd(KERN_INFO "ca0132_set_dmic: enable=%d\n", enable);
+
+	oldval = stop_mic1(codec);
+	ca0132_set_vipsource(codec, 0);
+	if (enable) {
+		/* set DMic input as 2-ch */
+		tmp = FLOAT_TWO;
+		dspio_set_param(codec, 0x80, 0x00, &tmp, sizeof(unsigned int));
+
+		val = spec->dmic_ctl;
+		val |= 0x80;
+		snd_hda_codec_write(codec, spec->input_pins[0], 0,
+				    VENDOR_CHIPIO_DMIC_CTL_SET, val);
+
+		if (!(spec->dmic_ctl & 0x20))
+			chipio_set_control_flag(codec, CONTROL_FLAG_DMIC, 1);
+	} else {
+		/* set AMic input as mono */
+		tmp = FLOAT_ONE;
+		dspio_set_param(codec, 0x80, 0x00, &tmp, sizeof(unsigned int));
+
+		val = spec->dmic_ctl;
+		/* clear bit7 and bit5 to disable dmic */
+		val &= 0x5f;
+		snd_hda_codec_write(codec, spec->input_pins[0], 0,
+				    VENDOR_CHIPIO_DMIC_CTL_SET, val);
+
+		if (!(spec->dmic_ctl & 0x20))
+			chipio_set_control_flag(codec, CONTROL_FLAG_DMIC, 0);
+	}
+	ca0132_set_vipsource(codec, 1);
+	resume_mic1(codec, oldval);
+}
+
+static void ca0132_init_dmic(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	u8 val;
+
+	/* Setup Digital Mic here, but don't enable.
+	 * Enable based on jack detect.
+	 */
+
+	/* MCLK uses MPIO1, set to enable.
+	 * Bit 2-0: MPIO select
+	 * Bit   3: set to disable
+	 * Bit 7-4: reserved
+	 */
+	val = 0x01;
+	snd_hda_codec_write(codec, spec->input_pins[0], 0,
+			    VENDOR_CHIPIO_DMIC_MCLK_SET, val);
+
+	/* Data1 uses MPIO3. Data2 not use
+	 * Bit 2-0: Data1 MPIO select
+	 * Bit   3: set disable Data1
+	 * Bit 6-4: Data2 MPIO select
+	 * Bit   7: set disable Data2
+	 */
+	val = 0x83;
+	snd_hda_codec_write(codec, spec->input_pins[0], 0,
+			    VENDOR_CHIPIO_DMIC_PIN_SET, val);
+
+	/* Use Ch-0 and Ch-1. Rate is 48K, mode 1. Disable DMic first.
+	 * Bit 3-0: Channel mask
+	 * Bit   4: set for 48KHz, clear for 32KHz
+	 * Bit   5: mode
+	 * Bit   6: set to select Data2, clear for Data1
+	 * Bit   7: set to enable DMic, clear for AMic
+	 */
+	val = 0x23;
+	/* keep a copy of dmic ctl val for enable/disable dmic purpuse */
+	spec->dmic_ctl = val;
+	snd_hda_codec_write(codec, spec->input_pins[0], 0,
+			    VENDOR_CHIPIO_DMIC_CTL_SET, val);
+}
+
+static void ca0132_init_analog_mic2(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	mutex_lock(&spec->chipio_mutex);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x20);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x2D);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
+	mutex_unlock(&spec->chipio_mutex);
+}
+
+static void ca0132_refresh_widget_caps(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	int i;
+	hda_nid_t nid;
+
+	snd_printdd(KERN_INFO "ca0132_refresh_widget_caps.\n");
+	nid = codec->start_nid;
+	for (i = 0; i < codec->num_nodes; i++, nid++)
+		codec->wcaps[i] = snd_hda_param_read(codec, nid,
+						     AC_PAR_AUDIO_WIDGET_CAP);
+
+	for (i = 0; i < spec->multiout.num_dacs; i++)
+		refresh_amp_caps(codec, spec->dacs[i], HDA_OUTPUT);
+
+	for (i = 0; i < spec->num_outputs; i++)
+		refresh_amp_caps(codec, spec->out_pins[i], HDA_OUTPUT);
+
+	for (i = 0; i < spec->num_inputs; i++) {
+		refresh_amp_caps(codec, spec->adcs[i], HDA_INPUT);
+		refresh_amp_caps(codec, spec->input_pins[i], HDA_INPUT);
+	}
+}
+
+static void ca0132_setup_defaults(struct hda_codec *codec)
+{
+	unsigned int tmp;
+	int num_fx;
+	int idx, i;
+
+	if (!dspload_is_loaded(codec))
+		return;
+
+	/* out, in effects + voicefx */
+	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
+	for (idx = 0; idx < num_fx; idx++) {
+		for (i = 0; i <= ca0132_effects[idx].params; i++) {
+			dspio_set_param(codec, ca0132_effects[idx].mid,
+					ca0132_effects[idx].reqs[i],
+					&(ca0132_effects[idx].def_vals[i]),
+					sizeof(unsigned int));
+		}
+	}
+
+	/*remove DSP headroom*/
+	tmp = FLOAT_ZERO;
+	dspio_set_param(codec, 0x96, 0x3C, &tmp, sizeof(unsigned int));
+
+	/*set speaker EQ bypass attenuation*/
+	dspio_set_param(codec, 0x8f, 0x01, &tmp, sizeof(unsigned int));
+
+	/* set AMic1 and AMic2 as mono mic */
+	tmp = FLOAT_ONE;
+	dspio_set_param(codec, 0x80, 0x00, &tmp, sizeof(unsigned int));
+	dspio_set_param(codec, 0x80, 0x01, &tmp, sizeof(unsigned int));
+
+	/* set AMic1 as CrystalVoice input */
+	tmp = FLOAT_ONE;
+	dspio_set_param(codec, 0x80, 0x05, &tmp, sizeof(unsigned int));
+
+	/* set WUH source */
+	tmp = FLOAT_TWO;
+	dspio_set_param(codec, 0x31, 0x00, &tmp, sizeof(unsigned int));
+ }
+
+static void ca0132_init_flags(struct hda_codec *codec)
+{
+	chipio_set_control_flag(codec, CONTROL_FLAG_IDLE_ENABLE, 0);
+	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_A_COMMON_MODE, 0);
+	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_D_COMMON_MODE, 0);
+	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_A_10KOHM_LOAD, 0);
+	chipio_set_control_flag(codec, CONTROL_FLAG_PORT_D_10KOHM_LOAD, 0);
+	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_C_HIGH_PASS, 1);
+}
+
+static void ca0132_init_params(struct hda_codec *codec)
+{
+	chipio_set_control_param(codec, CONTROL_PARAM_PORTA_160OHM_GAIN, 6);
+	chipio_set_control_param(codec, CONTROL_PARAM_PORTD_160OHM_GAIN, 6);
+}
 
 static void ca0132_set_ct_ext(struct hda_codec *codec, int enable)
 {
@@ -3034,44 +3924,28 @@ static void ca0132_config(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 
-	codec->pcm_format_first = 1;
-	codec->no_sticky_stream = 1;
+	spec->dacs[0] = 0x2;
+	spec->dacs[1] = 0x3;
+	spec->dacs[2] = 0x4;
 
-	/* line-outs */
-	cfg->line_outs = 1;
-	cfg->line_out_pins[0] = 0x0b; /* front */
-	cfg->line_out_type = AUTO_PIN_LINE_OUT;
-
-	spec->dacs[0] = 0x02;
-	spec->out_pins[0] = 0x0b;
 	spec->multiout.dac_nids = spec->dacs;
-	spec->multiout.num_dacs = 1;
+	spec->multiout.num_dacs = 3;
 	spec->multiout.max_channels = 2;
 
-	/* headphone */
-	cfg->hp_outs = 1;
-	cfg->hp_pins[0] = 0x0f;
+	spec->num_outputs = 2;
+	spec->out_pins[0] = 0x0b; /* speaker out */
+	spec->out_pins[1] = 0x10; /* headphone out */
+	spec->shared_out_nid = 0x2;
 
-	spec->hp_dac = 0;
-	spec->multiout.hp_nid = 0;
+	spec->num_inputs = 3;
+	spec->adcs[0] = 0x7; /* digital mic / analog mic1 */
+	spec->adcs[1] = 0x8; /* analog mic2 */
+	spec->adcs[2] = 0xa; /* what u hear */
+	spec->shared_mic_nid = 0x7;
 
-	/* inputs */
-	cfg->num_inputs = 2;  /* Mic-in and line-in */
-	cfg->inputs[0].pin = 0x12;
-	cfg->inputs[0].type = AUTO_PIN_MIC;
-	cfg->inputs[1].pin = 0x11;
-	cfg->inputs[1].type = AUTO_PIN_LINE_IN;
-
-	/* Mic-in */
 	spec->input_pins[0] = 0x12;
-	spec->input_labels[0] = "Mic";
-	spec->adcs[0] = 0x07;
-
-	/* Line-In */
 	spec->input_pins[1] = 0x11;
-	spec->input_labels[1] = "Line";
-	spec->adcs[1] = 0x08;
-	spec->num_inputs = 2;
+	spec->input_pins[2] = 0x13;
 
 	/* SPDIF I/O */
 	spec->dig_out = 0x05;
@@ -3084,16 +3958,115 @@ static void ca0132_config(struct hda_codec *codec)
 	cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
 }
 
+/*
+ * Verbs tables.
+ */
+
+/* Sends before DSP download. */
+static struct hda_verb ca0132_base_init_verbs[] = {
+	/*enable ct extension*/
+	{0x15, VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE, 0x1},
+	/*enable DSP node unsol, needed for DSP download*/
+	{0x16, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | UNSOL_TAG_DSP},
+	{}
+};
+
+/* Send at exit. */
+static struct hda_verb ca0132_base_exit_verbs[] = {
+	/*set afg to D3*/
+	{0x01, AC_VERB_SET_POWER_STATE, 0x03},
+	/*disable ct extension*/
+	{0x15, VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE, 0},
+	{}
+};
+
+/* Other verbs tables.  Sends after DSP download. */
+static struct hda_verb ca0132_init_verbs0[] = {
+	/* chip init verbs */
+	{0x15, 0x70D, 0xF0},
+	{0x15, 0x70E, 0xFE},
+	{0x15, 0x707, 0x75},
+	{0x15, 0x707, 0xD3},
+	{0x15, 0x707, 0x09},
+	{0x15, 0x707, 0x53},
+	{0x15, 0x707, 0xD4},
+	{0x15, 0x707, 0xEF},
+	{0x15, 0x707, 0x75},
+	{0x15, 0x707, 0xD3},
+	{0x15, 0x707, 0x09},
+	{0x15, 0x707, 0x02},
+	{0x15, 0x707, 0x37},
+	{0x15, 0x707, 0x78},
+	{0x15, 0x53C, 0xCE},
+	{0x15, 0x575, 0xC9},
+	{0x15, 0x53D, 0xCE},
+	{0x15, 0x5B7, 0xC9},
+	{0x15, 0x70D, 0xE8},
+	{0x15, 0x70E, 0xFE},
+	{0x15, 0x707, 0x02},
+	{0x15, 0x707, 0x68},
+	{0x15, 0x707, 0x62},
+	{0x15, 0x53A, 0xCE},
+	{0x15, 0x546, 0xC9},
+	{0x15, 0x53B, 0xCE},
+	{0x15, 0x5E8, 0xC9},
+	{0x15, 0x717, 0x0D},
+	{0x15, 0x718, 0x20},
+	{}
+};
+
+static struct hda_verb ca0132_init_verbs1[] = {
+	{0x10, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | UNSOL_TAG_HP},
+	{0x12, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | UNSOL_TAG_AMIC1},
+	/* config EAPD */
+	{0x0b, 0x78D, 0x00},
+	/*{0x0b, AC_VERB_SET_EAPD_BTLENABLE, 0x02},*/
+	/*{0x10, 0x78D, 0x02},*/
+	/*{0x10, AC_VERB_SET_EAPD_BTLENABLE, 0x02},*/
+	{}
+};
+
 static void ca0132_init_chip(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
+	int num_fx;
+	int i;
+	unsigned int on;
 
 	mutex_init(&spec->chipio_mutex);
+
+	spec->cur_out_type = SPEAKER_OUT;
+	spec->cur_mic_type = DIGITAL_MIC;
+	spec->cur_mic_boost = 0;
+
+	for (i = 0; i < VNODES_COUNT; i++) {
+		spec->vnode_lvol[i] = 0x5a;
+		spec->vnode_rvol[i] = 0x5a;
+		spec->vnode_lswitch[i] = 0;
+		spec->vnode_rswitch[i] = 0;
+	}
+
+	/*
+	 * Default states for effects are in ca0132_effects[].
+	 */
+	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
+	for (i = 0; i < num_fx; i++) {
+		on = (unsigned int)ca0132_effects[i].reqs[0];
+		spec->effects_switch[i] = on ? 1 : 0;
+	}
+
+	spec->voicefx_val = 0;
+	spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID] = 1;
+	spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] = 0;
+
 }
 
 static void ca0132_exit_chip(struct hda_codec *codec)
 {
 	/* put any chip cleanup stuffs here. */
+
+	if (dspload_is_loaded(codec))
+		dsp_reset(codec);
 }
 
 static void ca0132_set_dsp_msr(struct hda_codec *codec, bool is96k)
@@ -3151,15 +4124,25 @@ static int ca0132_init(struct hda_codec *codec)
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i;
 
+	spec->dsp_state = DSP_DOWNLOAD_INIT;
+	spec->curr_chip_addx = (unsigned int)INVALID_CHIP_ADDRESS;
+
+	snd_hda_power_up(codec);
+
+	ca0132_init_params(codec);
+	ca0132_init_flags(codec);
+	snd_hda_sequence_write(codec, spec->base_init_verbs);
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 	ca0132_download_dsp(codec);
 #endif
+	ca0132_refresh_widget_caps(codec);
+	ca0132_setup_defaults(codec);
+	ca0132_init_analog_mic2(codec);
+	ca0132_init_dmic(codec);
+
+	for (i = 0; i < spec->num_outputs; i++)
+		init_output(codec, spec->out_pins[i], spec->dacs[0]);
 
-	for (i = 0; i < spec->multiout.num_dacs; i++) {
-		init_output(codec, spec->out_pins[i],
-			    spec->multiout.dac_nids[i]);
-	}
-	init_output(codec, cfg->hp_pins[0], spec->hp_dac);
 	init_output(codec, cfg->dig_out_pins[0], spec->dig_out);
 
 	for (i = 0; i < spec->num_inputs; i++)
@@ -3167,7 +4150,17 @@ static int ca0132_init(struct hda_codec *codec)
 
 	init_input(codec, cfg->dig_in_pin, spec->dig_in);
 
-	ca0132_set_ct_ext(codec, 1);
+	for (i = 0; i < spec->num_init_verbs; i++)
+		snd_hda_sequence_write(codec, spec->init_verbs[i]);
+
+	ca0132_init_unsol(codec);
+
+	ca0132_select_out(codec);
+	ca0132_select_mic(codec);
+
+	snd_hda_jack_report_sync(codec);
+
+	snd_hda_power_down(codec);
 
 	return 0;
 }
@@ -3175,8 +4168,12 @@ static int ca0132_init(struct hda_codec *codec)
 
 static void ca0132_free(struct hda_codec *codec)
 {
-	ca0132_set_ct_ext(codec, 0);
+	struct ca0132_spec *spec = codec->spec;
+
+	snd_hda_power_up(codec);
+	snd_hda_sequence_write(codec, spec->base_exit_verbs);
 	ca0132_exit_chip(codec);
+	snd_hda_power_down(codec);
 	kfree(codec->spec);
 }
 
@@ -3192,6 +4189,7 @@ static struct hda_codec_ops ca0132_patch_ops = {
 static int patch_ca0132(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec;
+	int err;
 
 	snd_printdd("patch_ca0132\n");
 
@@ -3200,10 +4198,23 @@ static int patch_ca0132(struct hda_codec *codec)
 		return -ENOMEM;
 	codec->spec = spec;
 
+	spec->num_mixers = 1;
+	spec->mixers[0] = ca0132_mixer;
+
+	spec->base_init_verbs = ca0132_base_init_verbs;
+	spec->base_exit_verbs = ca0132_base_exit_verbs;
+	spec->init_verbs[0] = ca0132_init_verbs0;
+	spec->init_verbs[1] = ca0132_init_verbs1;
+	spec->num_init_verbs = 2;
+
 	ca0132_init_chip(codec);
 
 	ca0132_config(codec);
 
+	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
+	if (err < 0)
+		return err;
+
 	codec->patch_ops = ca0132_patch_ops;
 
 	return 0;
@@ -3213,7 +4224,7 @@ static int patch_ca0132(struct hda_codec *codec)
  * patch entries
  */
 static struct hda_codec_preset snd_hda_preset_ca0132[] = {
-	{ .id = 0x11020011, .name = "CA0132",     .patch = patch_ca0132 },
+	{ .id = 0x11020011, .name = "CA0132", .patch = patch_ca0132 },
 	{} /* terminator */
 };
 
-- 
1.7.4.1
