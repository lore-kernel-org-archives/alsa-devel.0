From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/8] ALSA: hda - Use generic parser for Cirrus
	codec driver
Date: Tue,  8 Jan 2013 12:50:42 +0100
Message-ID: <1357645849-8181-2-git-send-email-tiwai@suse.de>
References: <1357645849-8181-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D106265F7E
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 74621A3E1C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
In-Reply-To: <1357645849-8181-1-git-send-email-tiwai@suse.de>
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

This time, the target is Cirrus codec.  Its parser is a subset of
generic parser, so we can migrate fully with it now.

The only tricky part is the handling of SPDIF automute.
Cirrus driver sets the SPDIF out plug over the headphone.  As a
workaround, set spec->gen.master_mute for toggling the headphone (and
other) mute.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig        |    1 +
 sound/pci/hda/patch_cirrus.c | 1323 ++++--------------------------------------
 2 files changed, 117 insertions(+), 1207 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index ebec1b7..93404d7 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -150,6 +150,7 @@ config SND_HDA_CODEC_CIRRUS
 	bool "Build Cirrus Logic codec support"
 	depends on SND_HDA_INTEL
 	default y
+	select SND_HDA_GENERIC
 	help
 	  Say Y here to include Cirrus Logic codec support in
 	  snd-hda-intel driver, such as CS4206.
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 7b0b8c3..b9dfbd8 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -24,37 +24,18 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <sound/core.h>
+#include <sound/tlv.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
-#include <sound/tlv.h>
+#include "hda_generic.h"
 
 /*
  */
 
 struct cs_spec {
-	struct auto_pin_cfg autocfg;
-	struct hda_multi_out multiout;
-	struct snd_kcontrol *vmaster_sw;
-	struct snd_kcontrol *vmaster_vol;
-
-	hda_nid_t dac_nid[AUTO_CFG_MAX_OUTS];
-	hda_nid_t slave_dig_outs[2];
-
-	unsigned int input_idx[AUTO_PIN_LAST];
-	unsigned int capsrc_idx[AUTO_PIN_LAST];
-	hda_nid_t adc_nid[AUTO_PIN_LAST];
-	unsigned int adc_idx[AUTO_PIN_LAST];
-	unsigned int num_inputs;
-	unsigned int cur_input;
-	unsigned int automic_idx;
-	hda_nid_t cur_adc;
-	unsigned int cur_adc_stream_tag;
-	unsigned int cur_adc_format;
-	hda_nid_t dig_in;
-
-	const struct hda_bind_ctls *capture_bind[2];
+	struct hda_gen_spec gen;
 
 	unsigned int gpio_mask;
 	unsigned int gpio_dir;
@@ -62,17 +43,11 @@ struct cs_spec {
 	unsigned int gpio_eapd_hp; /* EAPD GPIO bit for headphones */
 	unsigned int gpio_eapd_speaker; /* EAPD GPIO bit for speakers */
 
-	struct hda_pcm pcm_rec[2];	/* PCM information */
-
-	unsigned int hp_detect:1;
-	unsigned int mic_detect:1;
-	unsigned int speaker_2_1:1;
 	/* CS421x */
 	unsigned int spdif_detect:1;
+	unsigned int spdif_present:1;
 	unsigned int sense_b:1;
 	hda_nid_t vendor_nid;
-	struct hda_input_mux input_mux;
-	unsigned int last_input;
 };
 
 /* available models with CS420x */
@@ -148,756 +123,34 @@ enum {
 #define CS421X_DMIC_PIN_NID	0x09 /* Port E */
 #define CS421X_SPDIF_PIN_NID	0x0A /* Port H */
 
-#define CS421X_IDX_DEV_CFG	0x01
-#define CS421X_IDX_ADC_CFG	0x02
-#define CS421X_IDX_DAC_CFG	0x03
-#define CS421X_IDX_SPK_CTL	0x04
-
-#define SPDIF_EVENT		0x04
-
-/* Cirrus Logic CS4213 is like CS4210 but does not have SPDIF input/output */
-#define CS4213_VENDOR_NID	0x09
-
-
-static inline int cs_vendor_coef_get(struct hda_codec *codec, unsigned int idx)
-{
-	struct cs_spec *spec = codec->spec;
-	snd_hda_codec_write(codec, spec->vendor_nid, 0,
-			    AC_VERB_SET_COEF_INDEX, idx);
-	return snd_hda_codec_read(codec, spec->vendor_nid, 0,
-				  AC_VERB_GET_PROC_COEF, 0);
-}
-
-static inline void cs_vendor_coef_set(struct hda_codec *codec, unsigned int idx,
-				      unsigned int coef)
-{
-	struct cs_spec *spec = codec->spec;
-	snd_hda_codec_write(codec, spec->vendor_nid, 0,
-			    AC_VERB_SET_COEF_INDEX, idx);
-	snd_hda_codec_write(codec, spec->vendor_nid, 0,
-			    AC_VERB_SET_PROC_COEF, coef);
-}
-
-
-#define HP_EVENT	1
-#define MIC_EVENT	2
-
-/*
- * PCM callbacks
- */
-static int cs_playback_pcm_open(struct hda_pcm_stream *hinfo,
-				struct hda_codec *codec,
-				struct snd_pcm_substream *substream)
-{
-	struct cs_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
-					     hinfo);
-}
-
-static int cs_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
-				   struct hda_codec *codec,
-				   unsigned int stream_tag,
-				   unsigned int format,
-				   struct snd_pcm_substream *substream)
-{
-	struct cs_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout,
-						stream_tag, format, substream);
-}
-
-static int cs_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
-				   struct hda_codec *codec,
-				   struct snd_pcm_substream *substream)
-{
-	struct cs_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
-}
-
-/*
- * Digital out
- */
-static int cs_dig_playback_pcm_open(struct hda_pcm_stream *hinfo,
-				    struct hda_codec *codec,
-				    struct snd_pcm_substream *substream)
-{
-	struct cs_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
-}
-
-static int cs_dig_playback_pcm_close(struct hda_pcm_stream *hinfo,
-				     struct hda_codec *codec,
-				     struct snd_pcm_substream *substream)
-{
-	struct cs_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
-}
-
-static int cs_dig_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
-				       struct hda_codec *codec,
-				       unsigned int stream_tag,
-				       unsigned int format,
-				       struct snd_pcm_substream *substream)
-{
-	struct cs_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_prepare(codec, &spec->multiout, stream_tag,
-					     format, substream);
-}
-
-static int cs_dig_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
-				       struct hda_codec *codec,
-				       struct snd_pcm_substream *substream)
-{
-	struct cs_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_cleanup(codec, &spec->multiout);
-}
-
-static void cs_update_input_select(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	if (spec->cur_adc)
-		snd_hda_codec_write(codec, spec->cur_adc, 0,
-				    AC_VERB_SET_CONNECT_SEL,
-				    spec->adc_idx[spec->cur_input]);
-}
-
-/*
- * Analog capture
- */
-static int cs_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
-				  struct hda_codec *codec,
-				  unsigned int stream_tag,
-				  unsigned int format,
-				  struct snd_pcm_substream *substream)
-{
-	struct cs_spec *spec = codec->spec;
-	spec->cur_adc = spec->adc_nid[spec->cur_input];
-	spec->cur_adc_stream_tag = stream_tag;
-	spec->cur_adc_format = format;
-	cs_update_input_select(codec);
-	snd_hda_codec_setup_stream(codec, spec->cur_adc, stream_tag, 0, format);
-	return 0;
-}
-
-static int cs_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
-				  struct hda_codec *codec,
-				  struct snd_pcm_substream *substream)
-{
-	struct cs_spec *spec = codec->spec;
-	snd_hda_codec_cleanup_stream(codec, spec->cur_adc);
-	spec->cur_adc = 0;
-	return 0;
-}
-
-/*
- */
-static const struct hda_pcm_stream cs_pcm_analog_playback = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-	.ops = {
-		.open = cs_playback_pcm_open,
-		.prepare = cs_playback_pcm_prepare,
-		.cleanup = cs_playback_pcm_cleanup
-	},
-};
-
-static const struct hda_pcm_stream cs_pcm_analog_capture = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-	.ops = {
-		.prepare = cs_capture_pcm_prepare,
-		.cleanup = cs_capture_pcm_cleanup
-	},
-};
-
-static const struct hda_pcm_stream cs_pcm_digital_playback = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-	.ops = {
-		.open = cs_dig_playback_pcm_open,
-		.close = cs_dig_playback_pcm_close,
-		.prepare = cs_dig_playback_pcm_prepare,
-		.cleanup = cs_dig_playback_pcm_cleanup
-	},
-};
-
-static const struct hda_pcm_stream cs_pcm_digital_capture = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-};
-
-static int cs_build_pcms(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	struct hda_pcm *info = spec->pcm_rec;
-
-	codec->pcm_info = info;
-	codec->num_pcms = 0;
-
-	info->name = "Cirrus Analog";
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = cs_pcm_analog_playback;
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->dac_nid[0];
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max =
-		spec->multiout.max_channels;
-	if (spec->speaker_2_1)
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK].chmap =
-			snd_pcm_2_1_chmaps;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE] = cs_pcm_analog_capture;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid =
-		spec->adc_nid[spec->cur_input];
-	codec->num_pcms++;
-
-	if (!spec->multiout.dig_out_nid && !spec->dig_in)
-		return 0;
-
-	info++;
-	info->name = "Cirrus Digital";
-	info->pcm_type = spec->autocfg.dig_out_type[0];
-	if (!info->pcm_type)
-		info->pcm_type = HDA_PCM_TYPE_SPDIF;
-	if (spec->multiout.dig_out_nid) {
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
-			cs_pcm_digital_playback;
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
-			spec->multiout.dig_out_nid;
-	}
-	if (spec->dig_in) {
-		info->stream[SNDRV_PCM_STREAM_CAPTURE] =
-			cs_pcm_digital_capture;
-		info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->dig_in;
-	}
-	codec->num_pcms++;
-
-	return 0;
-}
-
-/*
- * parse codec topology
- */
-
-static hda_nid_t get_dac(struct hda_codec *codec, hda_nid_t pin)
-{
-	hda_nid_t dac;
-	if (!pin)
-		return 0;
-	if (snd_hda_get_connections(codec, pin, &dac, 1) != 1)
-		return 0;
-	return dac;
-}
-
-static int is_ext_mic(struct hda_codec *codec, unsigned int idx)
-{
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	hda_nid_t pin = cfg->inputs[idx].pin;
-	unsigned int val;
-	if (!is_jack_detectable(codec, pin))
-		return 0;
-	val = snd_hda_codec_get_pincfg(codec, pin);
-	return (snd_hda_get_input_pin_attr(val) != INPUT_PIN_ATTR_INT);
-}
-
-static hda_nid_t get_adc(struct hda_codec *codec, hda_nid_t pin,
-			 unsigned int *idxp)
-{
-	int i, idx;
-	hda_nid_t nid;
-
-	nid = codec->start_nid;
-	for (i = 0; i < codec->num_nodes; i++, nid++) {
-		unsigned int type;
-		type = get_wcaps_type(get_wcaps(codec, nid));
-		if (type != AC_WID_AUD_IN)
-			continue;
-		idx = snd_hda_get_conn_index(codec, nid, pin, false);
-		if (idx >= 0) {
-			*idxp = idx;
-			return nid;
-		}
-	}
-	return 0;
-}
-
-static int is_active_pin(struct hda_codec *codec, hda_nid_t nid)
-{
-	unsigned int val;
-	val = snd_hda_codec_get_pincfg(codec, nid);
-	return (get_defcfg_connect(val) != AC_JACK_PORT_NONE);
-}
-
-static int parse_output(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i, extra_nids;
-	hda_nid_t dac;
-
-	for (i = 0; i < cfg->line_outs; i++) {
-		dac = get_dac(codec, cfg->line_out_pins[i]);
-		if (!dac)
-			break;
-		spec->dac_nid[i] = dac;
-	}
-	spec->multiout.num_dacs = i;
-	spec->multiout.dac_nids = spec->dac_nid;
-	spec->multiout.max_channels = i * 2;
-
-	if (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT && i == 2)
-		spec->speaker_2_1 = 1; /* assume 2.1 speakers */
-
-	/* add HP and speakers */
-	extra_nids = 0;
-	for (i = 0; i < cfg->hp_outs; i++) {
-		dac = get_dac(codec, cfg->hp_pins[i]);
-		if (!dac)
-			break;
-		if (!i)
-			spec->multiout.hp_nid = dac;
-		else
-			spec->multiout.extra_out_nid[extra_nids++] = dac;
-	}
-	for (i = 0; i < cfg->speaker_outs; i++) {
-		dac = get_dac(codec, cfg->speaker_pins[i]);
-		if (!dac)
-			break;
-		spec->multiout.extra_out_nid[extra_nids++] = dac;
-	}
-
-	if (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
-		cfg->speaker_outs = cfg->line_outs;
-		memcpy(cfg->speaker_pins, cfg->line_out_pins,
-		       sizeof(cfg->speaker_pins));
-		cfg->line_outs = 0;
-		memset(cfg->line_out_pins, 0, sizeof(cfg->line_out_pins));
-	}
-
-	return 0;
-}
-
-static int parse_input(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i;
-
-	for (i = 0; i < cfg->num_inputs; i++) {
-		hda_nid_t pin = cfg->inputs[i].pin;
-		spec->input_idx[spec->num_inputs] = i;
-		spec->capsrc_idx[i] = spec->num_inputs++;
-		spec->cur_input = i;
-		spec->adc_nid[i] = get_adc(codec, pin, &spec->adc_idx[i]);
-	}
-	if (!spec->num_inputs)
-		return 0;
-
-	/* check whether the automatic mic switch is available */
-	if (spec->num_inputs == 2 &&
-	    cfg->inputs[0].type == AUTO_PIN_MIC &&
-	    cfg->inputs[1].type == AUTO_PIN_MIC) {
-		if (is_ext_mic(codec, cfg->inputs[0].pin)) {
-			if (!is_ext_mic(codec, cfg->inputs[1].pin)) {
-				spec->mic_detect = 1;
-				spec->automic_idx = 0;
-			}
-		} else {
-			if (is_ext_mic(codec, cfg->inputs[1].pin)) {
-				spec->mic_detect = 1;
-				spec->automic_idx = 1;
-			}
-		}
-	}
-	return 0;
-}
-
-
-static int parse_digital_output(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	hda_nid_t nid;
-
-	if (!cfg->dig_outs)
-		return 0;
-	if (snd_hda_get_connections(codec, cfg->dig_out_pins[0], &nid, 1) < 1)
-		return 0;
-	spec->multiout.dig_out_nid = nid;
-	spec->multiout.share_spdif = 1;
-	if (cfg->dig_outs > 1 &&
-	    snd_hda_get_connections(codec, cfg->dig_out_pins[1], &nid, 1) > 0) {
-		spec->slave_dig_outs[0] = nid;
-		codec->slave_dig_outs = spec->slave_dig_outs;
-	}
-	return 0;
-}
-
-static int parse_digital_input(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int idx;
-
-	if (cfg->dig_in_pin)
-		spec->dig_in = get_adc(codec, cfg->dig_in_pin, &idx);
-	return 0;
-}
-
-/*
- * create mixer controls
- */
-
-static const char * const dir_sfx[2] = { "Playback", "Capture" };
-
-static int add_mute(struct hda_codec *codec, const char *name, int index,
-		    unsigned int pval, int dir, struct snd_kcontrol **kctlp)
-{
-	char tmp[44];
-	struct snd_kcontrol_new knew =
-		HDA_CODEC_MUTE_IDX(tmp, index, 0, 0, HDA_OUTPUT);
-	knew.private_value = pval;
-	snprintf(tmp, sizeof(tmp), "%s %s Switch", name, dir_sfx[dir]);
-	*kctlp = snd_ctl_new1(&knew, codec);
-	(*kctlp)->id.subdevice = HDA_SUBDEV_AMP_FLAG;
-	return snd_hda_ctl_add(codec, 0, *kctlp);
-}
-
-static int add_volume(struct hda_codec *codec, const char *name,
-		      int index, unsigned int pval, int dir,
-		      struct snd_kcontrol **kctlp)
-{
-	char tmp[44];
-	struct snd_kcontrol_new knew =
-		HDA_CODEC_VOLUME_IDX(tmp, index, 0, 0, HDA_OUTPUT);
-	knew.private_value = pval;
-	snprintf(tmp, sizeof(tmp), "%s %s Volume", name, dir_sfx[dir]);
-	*kctlp = snd_ctl_new1(&knew, codec);
-	(*kctlp)->id.subdevice = HDA_SUBDEV_AMP_FLAG;
-	return snd_hda_ctl_add(codec, 0, *kctlp);
-}
-
-static void fix_volume_caps(struct hda_codec *codec, hda_nid_t dac)
-{
-	unsigned int caps;
-
-	/* set the upper-limit for mixer amp to 0dB */
-	caps = query_amp_caps(codec, dac, HDA_OUTPUT);
-	caps &= ~(0x7f << AC_AMPCAP_NUM_STEPS_SHIFT);
-	caps |= ((caps >> AC_AMPCAP_OFFSET_SHIFT) & 0x7f)
-		<< AC_AMPCAP_NUM_STEPS_SHIFT;
-	snd_hda_override_amp_caps(codec, dac, HDA_OUTPUT, caps);
-}
-
-static int add_vmaster(struct hda_codec *codec, hda_nid_t dac)
-{
-	struct cs_spec *spec = codec->spec;
-	unsigned int tlv[4];
-	int err;
-
-	spec->vmaster_sw =
-		snd_ctl_make_virtual_master("Master Playback Switch", NULL);
-	err = snd_hda_ctl_add(codec, dac, spec->vmaster_sw);
-	if (err < 0)
-		return err;
-
-	snd_hda_set_vmaster_tlv(codec, dac, HDA_OUTPUT, tlv);
-	spec->vmaster_vol =
-		snd_ctl_make_virtual_master("Master Playback Volume", tlv);
-	err = snd_hda_ctl_add(codec, dac, spec->vmaster_vol);
-	if (err < 0)
-		return err;
-	return 0;
-}
-
-static int add_output(struct hda_codec *codec, hda_nid_t dac, int idx,
-		      int num_ctls, int type)
-{
-	struct cs_spec *spec = codec->spec;
-	const char *name;
-	int err, index;
-	struct snd_kcontrol *kctl;
-	static const char * const speakers[] = {
-		"Front Speaker", "Surround Speaker", "Bass Speaker"
-	};
-	static const char * const line_outs[] = {
-		"Front Line Out", "Surround Line Out", "Bass Line Out"
-	};
-
-	fix_volume_caps(codec, dac);
-	if (!spec->vmaster_sw) {
-		err = add_vmaster(codec, dac);
-		if (err < 0)
-			return err;
-	}
-
-	index = 0;
-	switch (type) {
-	case AUTO_PIN_HP_OUT:
-		name = "Headphone";
-		index = idx;
-		break;
-	case AUTO_PIN_SPEAKER_OUT:
-		if (spec->speaker_2_1)
-			name = idx ? "Bass Speaker" : "Speaker";
-		else if (num_ctls > 1)
-			name = speakers[idx];
-		else
-			name = "Speaker";
-		break;
-	default:
-		if (num_ctls > 1)
-			name = line_outs[idx];
-		else
-			name = "Line Out";
-		break;
-	}
-
-	err = add_mute(codec, name, index,
-		       HDA_COMPOSE_AMP_VAL(dac, 3, 0, HDA_OUTPUT), 0, &kctl);
-	if (err < 0)
-		return err;
-	err = snd_ctl_add_slave(spec->vmaster_sw, kctl);
-	if (err < 0)
-		return err;
-
-	err = add_volume(codec, name, index,
-			 HDA_COMPOSE_AMP_VAL(dac, 3, 0, HDA_OUTPUT), 0, &kctl);
-	if (err < 0)
-		return err;
-	err = snd_ctl_add_slave(spec->vmaster_vol, kctl);
-	if (err < 0)
-		return err;
-
-	return 0;
-}		
-
-static int build_output(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i, err;
-
-	for (i = 0; i < cfg->line_outs; i++) {
-		err = add_output(codec, get_dac(codec, cfg->line_out_pins[i]),
-				 i, cfg->line_outs, cfg->line_out_type);
-		if (err < 0)
-			return err;
-	}
-	for (i = 0; i < cfg->hp_outs; i++) {
-		err = add_output(codec, get_dac(codec, cfg->hp_pins[i]),
-				 i, cfg->hp_outs, AUTO_PIN_HP_OUT);
-		if (err < 0)
-			return err;
-	}
-	for (i = 0; i < cfg->speaker_outs; i++) {
-		err = add_output(codec, get_dac(codec, cfg->speaker_pins[i]),
-				 i, cfg->speaker_outs, AUTO_PIN_SPEAKER_OUT);
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
-/*
- */
-
-static const struct snd_kcontrol_new cs_capture_ctls[] = {
-	HDA_BIND_SW("Capture Switch", 0),
-	HDA_BIND_VOL("Capture Volume", 0),
-};
-
-static int change_cur_input(struct hda_codec *codec, unsigned int idx,
-			    int force)
-{
-	struct cs_spec *spec = codec->spec;
-	
-	if (spec->cur_input == idx && !force)
-		return 0;
-	if (spec->cur_adc && spec->cur_adc != spec->adc_nid[idx]) {
-		/* stream is running, let's swap the current ADC */
-		__snd_hda_codec_cleanup_stream(codec, spec->cur_adc, 1);
-		spec->cur_adc = spec->adc_nid[idx];
-		snd_hda_codec_setup_stream(codec, spec->cur_adc,
-					   spec->cur_adc_stream_tag, 0,
-					   spec->cur_adc_format);
-	}
-	spec->cur_input = idx;
-	cs_update_input_select(codec);
-	return 1;
-}
-
-static int cs_capture_source_info(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	unsigned int idx;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = spec->num_inputs;
-	if (uinfo->value.enumerated.item >= spec->num_inputs)
-		uinfo->value.enumerated.item = spec->num_inputs - 1;
-	idx = spec->input_idx[uinfo->value.enumerated.item];
-	snd_hda_get_pin_label(codec, cfg->inputs[idx].pin, cfg,
-			      uinfo->value.enumerated.name,
-			      sizeof(uinfo->value.enumerated.name), NULL);
-	return 0;
-}
-
-static int cs_capture_source_get(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct cs_spec *spec = codec->spec;
-	ucontrol->value.enumerated.item[0] = spec->capsrc_idx[spec->cur_input];
-	return 0;
-}
-
-static int cs_capture_source_put(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct cs_spec *spec = codec->spec;
-	unsigned int idx = ucontrol->value.enumerated.item[0];
-
-	if (idx >= spec->num_inputs)
-		return -EINVAL;
-	idx = spec->input_idx[idx];
-	return change_cur_input(codec, idx, 0);
-}
-
-static const struct snd_kcontrol_new cs_capture_source = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "Capture Source",
-	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
-	.info = cs_capture_source_info,
-	.get = cs_capture_source_get,
-	.put = cs_capture_source_put,
-};
-
-static const struct hda_bind_ctls *make_bind_capture(struct hda_codec *codec,
-					       struct hda_ctl_ops *ops)
-{
-	struct cs_spec *spec = codec->spec;
-	struct hda_bind_ctls *bind;
-	int i, n;
-
-	bind = kzalloc(sizeof(*bind) + sizeof(long) * (spec->num_inputs + 1),
-		       GFP_KERNEL);
-	if (!bind)
-		return NULL;
-	bind->ops = ops;
-	n = 0;
-	for (i = 0; i < AUTO_PIN_LAST; i++) {
-		if (!spec->adc_nid[i])
-			continue;
-		bind->values[n++] =
-			HDA_COMPOSE_AMP_VAL(spec->adc_nid[i], 3,
-					    spec->adc_idx[i], HDA_INPUT);
-	}
-	return bind;
-}
-
-/* add a (input-boost) volume control to the given input pin */
-static int add_input_volume_control(struct hda_codec *codec,
-				    struct auto_pin_cfg *cfg,
-				    int item)
-{
-	hda_nid_t pin = cfg->inputs[item].pin;
-	u32 caps;
-	const char *label;
-	struct snd_kcontrol *kctl;
-		
-	if (!(get_wcaps(codec, pin) & AC_WCAP_IN_AMP))
-		return 0;
-	caps = query_amp_caps(codec, pin, HDA_INPUT);
-	caps = (caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT;
-	if (caps <= 1)
-		return 0;
-	label = hda_get_autocfg_input_label(codec, cfg, item);
-	return add_volume(codec, label, 0,
-			  HDA_COMPOSE_AMP_VAL(pin, 3, 0, HDA_INPUT), 1, &kctl);
-}
-
-static int build_input(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	int i, err;
-
-	if (!spec->num_inputs)
-		return 0;
-
-	/* make bind-capture */
-	spec->capture_bind[0] = make_bind_capture(codec, &snd_hda_bind_sw);
-	spec->capture_bind[1] = make_bind_capture(codec, &snd_hda_bind_vol);
-	for (i = 0; i < 2; i++) {
-		struct snd_kcontrol *kctl;
-		int n;
-		if (!spec->capture_bind[i])
-			return -ENOMEM;
-		kctl = snd_ctl_new1(&cs_capture_ctls[i], codec);
-		if (!kctl)
-			return -ENOMEM;
-		kctl->private_value = (long)spec->capture_bind[i];
-		err = snd_hda_ctl_add(codec, 0, kctl);
-		if (err < 0)
-			return err;
-		for (n = 0; n < AUTO_PIN_LAST; n++) {
-			if (!spec->adc_nid[n])
-				continue;
-			err = snd_hda_add_nid(codec, kctl, 0, spec->adc_nid[n]);
-			if (err < 0)
-				return err;
-		}
-	}
-	
-	if (spec->num_inputs > 1 && !spec->mic_detect) {
-		err = snd_hda_ctl_add(codec, 0,
-				      snd_ctl_new1(&cs_capture_source, codec));
-		if (err < 0)
-			return err;
-	}
+#define CS421X_IDX_DEV_CFG	0x01
+#define CS421X_IDX_ADC_CFG	0x02
+#define CS421X_IDX_DAC_CFG	0x03
+#define CS421X_IDX_SPK_CTL	0x04
 
-	for (i = 0; i < spec->num_inputs; i++) {
-		err = add_input_volume_control(codec, &spec->autocfg, i);
-		if (err < 0)
-			return err;
-	}
+#define SPDIF_EVENT		0x04
 
-	return 0;
-}
+/* Cirrus Logic CS4213 is like CS4210 but does not have SPDIF input/output */
+#define CS4213_VENDOR_NID	0x09
 
-/*
- */
 
-static int build_digital_output(struct hda_codec *codec)
+static inline int cs_vendor_coef_get(struct hda_codec *codec, unsigned int idx)
 {
 	struct cs_spec *spec = codec->spec;
-	int err;
-
-	if (!spec->multiout.dig_out_nid)
-		return 0;
-
-	err = snd_hda_create_dig_out_ctls(codec, spec->multiout.dig_out_nid,
-					  spec->multiout.dig_out_nid,
-					  spec->pcm_rec[1].pcm_type);
-	if (err < 0)
-		return err;
-	err = snd_hda_create_spdif_share_sw(codec, &spec->multiout);
-	if (err < 0)
-		return err;
-	return 0;
+	snd_hda_codec_write(codec, spec->vendor_nid, 0,
+			    AC_VERB_SET_COEF_INDEX, idx);
+	return snd_hda_codec_read(codec, spec->vendor_nid, 0,
+				  AC_VERB_GET_PROC_COEF, 0);
 }
 
-static int build_digital_input(struct hda_codec *codec)
+static inline void cs_vendor_coef_set(struct hda_codec *codec, unsigned int idx,
+				      unsigned int coef)
 {
 	struct cs_spec *spec = codec->spec;
-	if (spec->dig_in)
-		return snd_hda_create_spdif_in_ctls(codec, spec->dig_in);
-	return 0;
+	snd_hda_codec_write(codec, spec->vendor_nid, 0,
+			    AC_VERB_SET_COEF_INDEX, idx);
+	snd_hda_codec_write(codec, spec->vendor_nid, 0,
+			    AC_VERB_SET_PROC_COEF, coef);
 }
 
 /*
@@ -906,187 +159,37 @@ static int build_digital_input(struct hda_codec *codec)
  * HP/SPK/SPDIF
  */
 
-static void cs_automute(struct hda_codec *codec, struct hda_jack_tbl *tbl)
+static void cs_automute(struct hda_codec *codec)
 {
 	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	unsigned int hp_present;
-	unsigned int spdif_present;
-	hda_nid_t nid;
-	int i;
 
-	spdif_present = 0;
-	if (cfg->dig_outs) {
-		nid = cfg->dig_out_pins[0];
-		if (is_jack_detectable(codec, nid)) {
-			/*
-			TODO: SPDIF output redirect when SENSE_B is enabled.
-			Shared (SENSE_A) jack (e.g HP/mini-TOSLINK)
-			assumed.
-			*/
-			if (snd_hda_jack_detect(codec, nid)
-				/* && spec->sense_b */)
-				spdif_present = 1;
-		}
-	}
-
-	hp_present = 0;
-	for (i = 0; i < cfg->hp_outs; i++) {
-		nid = cfg->hp_pins[i];
-		if (!is_jack_detectable(codec, nid))
-			continue;
-		hp_present = snd_hda_jack_detect(codec, nid);
-		if (hp_present)
-			break;
-	}
+	/* mute HPs if spdif jack (SENSE_B) is present */
+	spec->gen.master_mute = !!(spec->spdif_present && spec->sense_b);
 
-	/* mute speakers if spdif or hp jack is plugged in */
-	for (i = 0; i < cfg->speaker_outs; i++) {
-		int pin_ctl = hp_present ? 0 : PIN_OUT;
-		/* detect on spdif is specific to CS4210 */
-		if (spdif_present && (spec->vendor_nid == CS4210_VENDOR_NID))
-			pin_ctl = 0;
+	snd_hda_gen_update_outputs(codec);
 
-		nid = cfg->speaker_pins[i];
-		snd_hda_set_pin_ctl(codec, nid, pin_ctl);
-	}
 	if (spec->gpio_eapd_hp) {
-		unsigned int gpio = hp_present ?
+		unsigned int gpio = spec->gen.hp_jack_present ?
 			spec->gpio_eapd_hp : spec->gpio_eapd_speaker;
 		snd_hda_codec_write(codec, 0x01, 0,
 				    AC_VERB_SET_GPIO_DATA, gpio);
 	}
-
-	/* specific to CS4210 */
-	if (spec->vendor_nid == CS4210_VENDOR_NID) {
-		/* mute HPs if spdif jack (SENSE_B) is present */
-		for (i = 0; i < cfg->hp_outs; i++) {
-			nid = cfg->hp_pins[i];
-			snd_hda_set_pin_ctl(codec, nid,
-				(spdif_present && spec->sense_b) ? 0 : PIN_HP);
-		}
-
-		/* SPDIF TX on/off */
-		if (cfg->dig_outs) {
-			nid = cfg->dig_out_pins[0];
-			snd_hda_set_pin_ctl(codec, nid,
-				spdif_present ? PIN_OUT : 0);
-
-		}
-		/* Update board GPIOs if neccessary ... */
-	}
-}
-
-/*
- * Auto-input redirect for CS421x
- * Switch max 3 inputs of a single ADC (nid 3)
-*/
-
-static void cs_automic(struct hda_codec *codec, struct hda_jack_tbl *tbl)
-{
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	hda_nid_t nid;
-	unsigned int present;
-
-	nid = cfg->inputs[spec->automic_idx].pin;
-	present = snd_hda_jack_detect(codec, nid);
-
-	/* specific to CS421x, single ADC */
-	if (spec->vendor_nid == CS420X_VENDOR_NID) {
-		if (present)
-			change_cur_input(codec, spec->automic_idx, 0);
-		else
-			change_cur_input(codec, !spec->automic_idx, 0);
-	} else {
-		if (present) {
-			if (spec->cur_input != spec->automic_idx) {
-				spec->last_input = spec->cur_input;
-				spec->cur_input = spec->automic_idx;
-			}
-		} else  {
-			spec->cur_input = spec->last_input;
-		}
-		cs_update_input_select(codec);
-	}
 }
 
-/*
- */
-
-static void init_output(struct hda_codec *codec)
+static bool is_active_pin(struct hda_codec *codec, hda_nid_t nid)
 {
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i;
-
-	/* mute first */
-	for (i = 0; i < spec->multiout.num_dacs; i++)
-		snd_hda_codec_write(codec, spec->multiout.dac_nids[i], 0,
-				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-	if (spec->multiout.hp_nid)
-		snd_hda_codec_write(codec, spec->multiout.hp_nid, 0,
-				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-	for (i = 0; i < ARRAY_SIZE(spec->multiout.extra_out_nid); i++) {
-		if (!spec->multiout.extra_out_nid[i])
-			break;
-		snd_hda_codec_write(codec, spec->multiout.extra_out_nid[i], 0,
-				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-	}
-
-	/* set appropriate pin controls */
-	for (i = 0; i < cfg->line_outs; i++)
-		snd_hda_set_pin_ctl(codec, cfg->line_out_pins[i], PIN_OUT);
-	/* HP */
-	for (i = 0; i < cfg->hp_outs; i++) {
-		hda_nid_t nid = cfg->hp_pins[i];
-		snd_hda_set_pin_ctl(codec, nid, PIN_HP);
-		if (!cfg->speaker_outs)
-			continue;
-		if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP) {
-			snd_hda_jack_detect_enable_callback(codec, nid, HP_EVENT, cs_automute);
-			spec->hp_detect = 1;
-		}
-	}
-
-	/* Speaker */
-	for (i = 0; i < cfg->speaker_outs; i++)
-		snd_hda_set_pin_ctl(codec, cfg->speaker_pins[i], PIN_OUT);
-
-	/* SPDIF is enabled on presence detect for CS421x */
-	if (spec->hp_detect || spec->spdif_detect)
-		cs_automute(codec, NULL);
+	unsigned int val;
+	val = snd_hda_codec_get_pincfg(codec, nid);
+	return (get_defcfg_connect(val) != AC_JACK_PORT_NONE);
 }
 
-static void init_input(struct hda_codec *codec)
+static void init_input_coef(struct hda_codec *codec)
 {
 	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
 	unsigned int coef;
-	int i;
 
-	for (i = 0; i < cfg->num_inputs; i++) {
-		unsigned int ctl;
-		hda_nid_t pin = cfg->inputs[i].pin;
-		if (!spec->adc_nid[i])
-			continue;
-		/* set appropriate pin control and mute first */
-		ctl = PIN_IN;
-		if (cfg->inputs[i].type == AUTO_PIN_MIC)
-			ctl |= snd_hda_get_default_vref(codec, pin);
-		snd_hda_set_pin_ctl(codec, pin, ctl);
-		snd_hda_codec_write(codec, spec->adc_nid[i], 0,
-				    AC_VERB_SET_AMP_GAIN_MUTE,
-				    AMP_IN_MUTE(spec->adc_idx[i]));
-		if (spec->mic_detect && spec->automic_idx == i)
-			snd_hda_jack_detect_enable_callback(codec, pin, MIC_EVENT, cs_automic);
-	}
 	/* CS420x has multiple ADC, CS421x has single ADC */
 	if (spec->vendor_nid == CS420X_VENDOR_NID) {
-		change_cur_input(codec, spec->cur_input, 1);
-		if (spec->mic_detect)
-			cs_automic(codec, NULL);
-
 		coef = cs_vendor_coef_get(codec, IDX_BEEP_CFG);
 		if (is_active_pin(codec, CS_DMIC2_PIN_NID))
 			coef |= 1 << 4; /* DMIC2 2 chan on, GPIO1 off */
@@ -1097,13 +200,6 @@ static void init_input(struct hda_codec *codec)
 					*/
 
 		cs_vendor_coef_set(codec, IDX_BEEP_CFG, coef);
-	} else {
-		if (spec->mic_detect)
-			cs_automic(codec, NULL);
-		else  {
-			spec->cur_adc = spec->adc_nid[spec->cur_input];
-			cs_update_input_select(codec);
-		}
 	}
 }
 
@@ -1176,7 +272,7 @@ static const struct hda_verb cs_errata_init_verbs[] = {
 };
 
 /* SPDIF setup */
-static void init_digital(struct hda_codec *codec)
+static void init_digital_coef(struct hda_codec *codec)
 {
 	unsigned int coef;
 
@@ -1199,7 +295,7 @@ static int cs_init(struct hda_codec *codec)
 
 	snd_hda_sequence_write(codec, cs_coef_init_verbs);
 
-	snd_hda_apply_verbs(codec);
+	snd_hda_gen_init(codec);
 
 	if (spec->gpio_mask) {
 		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
@@ -1210,52 +306,17 @@ static int cs_init(struct hda_codec *codec)
 				    spec->gpio_data);
 	}
 
-	init_output(codec);
-	init_input(codec);
-	init_digital(codec);
-
-	return 0;
-}
-
-static int cs_build_controls(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	int err;
-
-	err = build_output(codec);
-	if (err < 0)
-		return err;
-	err = build_input(codec);
-	if (err < 0)
-		return err;
-	err = build_digital_output(codec);
-	if (err < 0)
-		return err;
-	err = build_digital_input(codec);
-	if (err < 0)
-		return err;
-	err = cs_init(codec);
-	if (err < 0)
-		return err;
-
-	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
-	if (err < 0)
-		return err;
+	init_input_coef(codec);
+	init_digital_coef(codec);
 
 	return 0;
 }
 
-static void cs_free(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	kfree(spec->capture_bind[0]);
-	kfree(spec->capture_bind[1]);
-	kfree(codec->spec);
-}
+#define cs_free		snd_hda_gen_free
 
 static const struct hda_codec_ops cs_patch_ops = {
-	.build_controls = cs_build_controls,
-	.build_pcms = cs_build_pcms,
+	.build_controls = snd_hda_gen_build_controls,
+	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cs_init,
 	.free = cs_free,
 	.unsol_event = snd_hda_jack_unsol_event,
@@ -1266,22 +327,14 @@ static int cs_parse_auto_config(struct hda_codec *codec)
 	struct cs_spec *spec = codec->spec;
 	int err;
 
-	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
+	err = snd_hda_parse_pin_defcfg(codec, &spec->gen.autocfg, NULL, 0);
 	if (err < 0)
 		return err;
 
-	err = parse_output(codec);
-	if (err < 0)
-		return err;
-	err = parse_input(codec);
-	if (err < 0)
-		return err;
-	err = parse_digital_output(codec);
-	if (err < 0)
-		return err;
-	err = parse_digital_input(codec);
+	err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
 	if (err < 0)
 		return err;
+
 	return 0;
 }
 
@@ -1431,17 +484,28 @@ static const struct hda_fixup cs420x_fixups[] = {
 	},
 };
 
-static int patch_cs420x(struct hda_codec *codec)
+static struct cs_spec *cs_alloc_spec(struct hda_codec *codec, int vendor_nid)
 {
 	struct cs_spec *spec;
-	int err;
 
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
-		return -ENOMEM;
+		return NULL;
 	codec->spec = spec;
+	spec->vendor_nid = vendor_nid;
+	snd_hda_gen_spec_init(&spec->gen);
+
+	return spec;
+}
+
+static int patch_cs420x(struct hda_codec *codec)
+{
+	struct cs_spec *spec;
+	int err;
 
-	spec->vendor_nid = CS420X_VENDOR_NID;
+	spec = cs_alloc_spec(codec, CS420X_VENDOR_NID);
+	if (!spec)
+		return -ENOMEM;
 
 	snd_hda_pick_fixup(codec, cs420x_models, cs420x_fixup_tbl,
 			   cs420x_fixups);
@@ -1459,7 +523,6 @@ static int patch_cs420x(struct hda_codec *codec)
 
  error:
 	cs_free(codec);
-	codec->spec = NULL;
 	return err;
 }
 
@@ -1618,7 +681,7 @@ static int cs421x_boost_vol_put(struct snd_kcontrol *kcontrol,
 	}
 }
 
-static const struct snd_kcontrol_new cs421x_speaker_bost_ctl = {
+static const struct snd_kcontrol_new cs421x_speaker_boost_ctl = {
 
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -1663,20 +726,44 @@ static void cs4210_pinmux_init(struct hda_codec *codec)
 	}
 }
 
-static void init_cs421x_digital(struct hda_codec *codec)
+static void cs4210_spdif_automute(struct hda_codec *codec,
+				  struct hda_jack_tbl *tbl)
 {
 	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i;
+	bool spdif_present = false;
+	hda_nid_t spdif_pin = spec->gen.autocfg.dig_out_pins[0];
+
+	/* detect on spdif is specific to CS4210 */
+	if (!spec->spdif_detect ||
+	    spec->vendor_nid != CS4210_VENDOR_NID)
+		return;
+
+	spdif_present = snd_hda_jack_detect(codec, spdif_pin);
+	if (spdif_present == spec->spdif_present)
+		return;
+
+	spec->spdif_present = spdif_present;
+	/* SPDIF TX on/off */
+	if (spdif_present)
+		snd_hda_set_pin_ctl(codec, spdif_pin,
+				    spdif_present ? PIN_OUT : 0);
 
+	cs_automute(codec);
+}
+
+static void parse_cs421x_digital(struct hda_codec *codec)
+{
+	struct cs_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->gen.autocfg;
+	int i;
 
 	for (i = 0; i < cfg->dig_outs; i++) {
 		hda_nid_t nid = cfg->dig_out_pins[i];
-		if (!cfg->speaker_outs)
-			continue;
 		if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP) {
-			snd_hda_jack_detect_enable_callback(codec, nid, SPDIF_EVENT, cs_automute);
 			spec->spdif_detect = 1;
+			snd_hda_jack_detect_enable_callback(codec, nid,
+							    SPDIF_EVENT,
+							    cs4210_spdif_automute);
 		}
 	}
 }
@@ -1691,6 +778,8 @@ static int cs421x_init(struct hda_codec *codec)
 		cs4210_pinmux_init(codec);
 	}
 
+	snd_hda_gen_init(codec);
+
 	if (spec->gpio_mask) {
 		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
 				    spec->gpio_mask);
@@ -1700,233 +789,61 @@ static int cs421x_init(struct hda_codec *codec)
 				    spec->gpio_data);
 	}
 
-	init_output(codec);
-	init_input(codec);
-	init_cs421x_digital(codec);
-
-	return 0;
-}
-
-/*
- * CS4210 Input MUX (1 ADC)
- */
-static int cs421x_mux_enum_info(struct snd_kcontrol *kcontrol,
-					struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct cs_spec *spec = codec->spec;
-
-	return snd_hda_input_mux_info(&spec->input_mux, uinfo);
-}
-
-static int cs421x_mux_enum_get(struct snd_kcontrol *kcontrol,
-					struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct cs_spec *spec = codec->spec;
-
-	ucontrol->value.enumerated.item[0] = spec->cur_input;
-	return 0;
-}
-
-static int cs421x_mux_enum_put(struct snd_kcontrol *kcontrol,
-					struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct cs_spec *spec = codec->spec;
-
-	return snd_hda_input_mux_put(codec, &spec->input_mux, ucontrol,
-				spec->adc_nid[0], &spec->cur_input);
-
-}
-
-static const struct snd_kcontrol_new cs421x_capture_source = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "Capture Source",
-	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
-	.info = cs421x_mux_enum_info,
-	.get = cs421x_mux_enum_get,
-	.put = cs421x_mux_enum_put,
-};
-
-static int cs421x_add_input_volume_control(struct hda_codec *codec, int item)
-{
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	const struct hda_input_mux *imux = &spec->input_mux;
-	hda_nid_t pin = cfg->inputs[item].pin;
-	struct snd_kcontrol *kctl;
-	u32 caps;
-
-	if (!(get_wcaps(codec, pin) & AC_WCAP_IN_AMP))
-		return 0;
-
-	caps = query_amp_caps(codec, pin, HDA_INPUT);
-	caps = (caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT;
-	if (caps <= 1)
-		return 0;
-
-	return add_volume(codec,  imux->items[item].label, 0,
-			  HDA_COMPOSE_AMP_VAL(pin, 3, 0, HDA_INPUT), 1, &kctl);
-}
-
-/* add a (input-boost) volume control to the given input pin */
-static int build_cs421x_input(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	struct hda_input_mux *imux = &spec->input_mux;
-	int i, err, type_idx;
-	const char *label;
-
-	if (!spec->num_inputs)
-		return 0;
-
-	/* make bind-capture */
-	spec->capture_bind[0] = make_bind_capture(codec, &snd_hda_bind_sw);
-	spec->capture_bind[1] = make_bind_capture(codec, &snd_hda_bind_vol);
-	for (i = 0; i < 2; i++) {
-		struct snd_kcontrol *kctl;
-		int n;
-		if (!spec->capture_bind[i])
-			return -ENOMEM;
-		kctl = snd_ctl_new1(&cs_capture_ctls[i], codec);
-		if (!kctl)
-			return -ENOMEM;
-		kctl->private_value = (long)spec->capture_bind[i];
-		err = snd_hda_ctl_add(codec, 0, kctl);
-		if (err < 0)
-			return err;
-		for (n = 0; n < AUTO_PIN_LAST; n++) {
-			if (!spec->adc_nid[n])
-				continue;
-			err = snd_hda_add_nid(codec, kctl, 0, spec->adc_nid[n]);
-			if (err < 0)
-				return err;
-		}
-	}
-
-	/* Add Input MUX Items + Capture Volume/Switch */
-	for (i = 0; i < spec->num_inputs; i++) {
-		label = hda_get_autocfg_input_label(codec, cfg, i);
-		snd_hda_add_imux_item(imux, label, spec->adc_idx[i], &type_idx);
-
-		err = cs421x_add_input_volume_control(codec, i);
-		if (err < 0)
-			return err;
-	}
-
-	/*
-	    Add 'Capture Source' Switch if
-		* 2 inputs and no mic detec
-		* 3 inputs
-	*/
-	if ((spec->num_inputs == 2 && !spec->mic_detect) ||
-	    (spec->num_inputs == 3)) {
+	init_input_coef(codec);
 
-		err = snd_hda_ctl_add(codec, spec->adc_nid[0],
-			      snd_ctl_new1(&cs421x_capture_source, codec));
-		if (err < 0)
-			return err;
-	}
+	cs4210_spdif_automute(codec, NULL);
 
 	return 0;
 }
 
-/* Single DAC (Mute/Gain) */
-static int build_cs421x_output(struct hda_codec *codec)
+static int cs421x_build_controls(struct hda_codec *codec)
 {
-	hda_nid_t dac = CS4210_DAC_NID;
 	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	struct snd_kcontrol *kctl;
 	int err;
-	char *name = "Master";
-
-	fix_volume_caps(codec, dac);
 
-	err = add_mute(codec, name, 0,
-			HDA_COMPOSE_AMP_VAL(dac, 3, 0, HDA_OUTPUT), 0, &kctl);
+	err = snd_hda_gen_build_controls(codec);
 	if (err < 0)
 		return err;
 
-	err = add_volume(codec, name, 0,
-			HDA_COMPOSE_AMP_VAL(dac, 3, 0, HDA_OUTPUT), 0, &kctl);
-	if (err < 0)
-		return err;
-
-	if (cfg->speaker_outs && (spec->vendor_nid == CS4210_VENDOR_NID)) {
+	if (spec->gen.autocfg.speaker_outs &&
+	    spec->vendor_nid == CS4210_VENDOR_NID) {
 		err = snd_hda_ctl_add(codec, 0,
-			snd_ctl_new1(&cs421x_speaker_bost_ctl, codec));
+			snd_ctl_new1(&cs421x_speaker_boost_ctl, codec));
 		if (err < 0)
 			return err;
 	}
-	return err;
-}
-
-static int cs421x_build_controls(struct hda_codec *codec)
-{
-	struct cs_spec *spec = codec->spec;
-	int err;
-
-	err = build_cs421x_output(codec);
-	if (err < 0)
-		return err;
-	err = build_cs421x_input(codec);
-	if (err < 0)
-		return err;
-	err = build_digital_output(codec);
-	if (err < 0)
-		return err;
-	err =  cs421x_init(codec);
-	if (err < 0)
-		return err;
-
-	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
-	if (err < 0)
-		return err;
-
 	return 0;
 }
 
-static int parse_cs421x_input(struct hda_codec *codec)
+static void fix_volume_caps(struct hda_codec *codec, hda_nid_t dac)
 {
-	struct cs_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i;
-
-	for (i = 0; i < cfg->num_inputs; i++) {
-		hda_nid_t pin = cfg->inputs[i].pin;
-		spec->adc_nid[i] = get_adc(codec, pin, &spec->adc_idx[i]);
-		spec->cur_input = spec->last_input = i;
-		spec->num_inputs++;
+	unsigned int caps;
 
-		/* check whether the automatic mic switch is available */
-		if (is_ext_mic(codec, i) && cfg->num_inputs >= 2) {
-			spec->mic_detect = 1;
-			spec->automic_idx = i;
-		}
-	}
-	return 0;
+	/* set the upper-limit for mixer amp to 0dB */
+	caps = query_amp_caps(codec, dac, HDA_OUTPUT);
+	caps &= ~(0x7f << AC_AMPCAP_NUM_STEPS_SHIFT);
+	caps |= ((caps >> AC_AMPCAP_OFFSET_SHIFT) & 0x7f)
+		<< AC_AMPCAP_NUM_STEPS_SHIFT;
+	snd_hda_override_amp_caps(codec, dac, HDA_OUTPUT, caps);
 }
 
 static int cs421x_parse_auto_config(struct hda_codec *codec)
 {
 	struct cs_spec *spec = codec->spec;
+	hda_nid_t dac = CS4210_DAC_NID;
 	int err;
 
-	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
-	if (err < 0)
-		return err;
-	err = parse_output(codec);
-	if (err < 0)
-		return err;
-	err = parse_cs421x_input(codec);
+	fix_volume_caps(codec, dac);
+
+	err = snd_hda_parse_pin_defcfg(codec, &spec->gen.autocfg, NULL, 0);
 	if (err < 0)
 		return err;
-	err = parse_digital_output(codec);
+
+	err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
 	if (err < 0)
 		return err;
+
+	parse_cs421x_digital(codec);
 	return 0;
 }
 
@@ -1959,7 +876,7 @@ static int cs421x_suspend(struct hda_codec *codec)
 
 static const struct hda_codec_ops cs421x_patch_ops = {
 	.build_controls = cs421x_build_controls,
-	.build_pcms = cs_build_pcms,
+	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cs421x_init,
 	.free = cs_free,
 	.unsol_event = snd_hda_jack_unsol_event,
@@ -1973,12 +890,9 @@ static int patch_cs4210(struct hda_codec *codec)
 	struct cs_spec *spec;
 	int err;
 
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	spec = cs_alloc_spec(codec, CS4210_VENDOR_NID);
 	if (!spec)
 		return -ENOMEM;
-	codec->spec = spec;
-
-	spec->vendor_nid = CS4210_VENDOR_NID;
 
 	snd_hda_pick_fixup(codec, cs421x_models, cs421x_fixup_tbl,
 			   cs421x_fixups);
@@ -2003,7 +917,6 @@ static int patch_cs4210(struct hda_codec *codec)
 
  error:
 	cs_free(codec);
-	codec->spec = NULL;
 	return err;
 }
 
@@ -2012,12 +925,9 @@ static int patch_cs4213(struct hda_codec *codec)
 	struct cs_spec *spec;
 	int err;
 
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	spec = cs_alloc_spec(codec, CS4213_VENDOR_NID);
 	if (!spec)
 		return -ENOMEM;
-	codec->spec = spec;
-
-	spec->vendor_nid = CS4213_VENDOR_NID;
 
 	err = cs421x_parse_auto_config(codec);
 	if (err < 0)
@@ -2028,7 +938,6 @@ static int patch_cs4213(struct hda_codec *codec)
 
  error:
 	cs_free(codec);
-	codec->spec = NULL;
 	return err;
 }
 
-- 
1.8.0.1
