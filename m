From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/13] ALSA: hda - Remove static quirks for
	AD1986A codec
Date: Fri, 19 Jul 2013 17:12:22 +0200
Message-ID: <1374246742-14373-14-git-send-email-tiwai@suse.de>
References: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D007D265770
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A3CCBA5429
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
In-Reply-To: <1374246742-14373-1-git-send-email-tiwai@suse.de>
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

Finally all the static quirks in patch_analog.c are reduced by this
patch.  As machines with AD1986A codec are all old and often their
BIOS are buggy, we need to keep at least a few static pin conifgs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 1069 +++---------------------------------------
 1 file changed, 57 insertions(+), 1012 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 3b23280..0cbdd87 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -32,7 +32,6 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
-#define ENABLE_AD_STATIC_QUIRKS
 
 struct ad198x_spec {
 	struct hda_gen_spec gen;
@@ -43,114 +42,8 @@ struct ad198x_spec {
 	hda_nid_t eapd_nid;
 
 	unsigned int beep_amp;	/* beep amp value, set via set_beep_amp() */
-
-#ifdef ENABLE_AD_STATIC_QUIRKS
-	const struct snd_kcontrol_new *mixers[6];
-	int num_mixers;
-	const struct hda_verb *init_verbs[6];	/* initialization verbs
-						 * don't forget NULL termination!
-						 */
-	unsigned int num_init_verbs;
-
-	/* playback */
-	struct hda_multi_out multiout;	/* playback set-up
-					 * max_channels, dacs must be set
-					 * dig_out_nid and hp_nid are optional
-					 */
-	unsigned int cur_eapd;
-	unsigned int need_dac_fix;
-
-	/* capture */
-	unsigned int num_adc_nids;
-	const hda_nid_t *adc_nids;
-	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
-
-	/* capture source */
-	const struct hda_input_mux *input_mux;
-	const hda_nid_t *capsrc_nids;
-	unsigned int cur_mux[3];
-
-	/* channel model */
-	const struct hda_channel_mode *channel_mode;
-	int num_channel_mode;
-
-	/* PCM information */
-	struct hda_pcm pcm_rec[3];	/* used in alc_build_pcms() */
-
-	unsigned int spdif_route;
-
-	unsigned int jack_present: 1;
-	unsigned int inv_jack_detect: 1;/* inverted jack-detection */
-	unsigned int analog_beep: 1;	/* analog beep input present */
-	unsigned int avoid_init_slave_vol:1;
-
-#ifdef CONFIG_PM
-	struct hda_loopback_check loopback;
-#endif
-	/* for virtual master */
-	hda_nid_t vmaster_nid;
-	const char * const *slave_vols;
-	const char * const *slave_sws;
-#endif /* ENABLE_AD_STATIC_QUIRKS */
 };
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-/*
- * input MUX handling (common part)
- */
-static int ad198x_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-
-	return snd_hda_input_mux_info(spec->input_mux, uinfo);
-}
-
-static int ad198x_mux_enum_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
-
-	ucontrol->value.enumerated.item[0] = spec->cur_mux[adc_idx];
-	return 0;
-}
-
-static int ad198x_mux_enum_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
-
-	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
-				     spec->capsrc_nids[adc_idx],
-				     &spec->cur_mux[adc_idx]);
-}
-
-/*
- * initialization (common callbacks)
- */
-static int ad198x_init(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-	int i;
-
-	for (i = 0; i < spec->num_init_verbs; i++)
-		snd_hda_sequence_write(codec, spec->init_verbs[i]);
-	return 0;
-}
-
-static const char * const ad_slave_pfxs[] = {
-	"Front", "Surround", "Center", "LFE", "Side",
-	"Headphone", "Mono", "Speaker", "IEC958",
-	NULL
-};
-
-static const char * const ad1988_6stack_fp_slave_pfxs[] = {
-	"Front", "Surround", "Center", "LFE", "Side", "IEC958",
-	NULL
-};
-#endif /* ENABLE_AD_STATIC_QUIRKS */
 
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
 /* additional beep mixers; the actual parameters are overwritten at build */
@@ -160,12 +53,6 @@ static const struct snd_kcontrol_new ad_beep_mixer[] = {
 	{ } /* end */
 };
 
-static const struct snd_kcontrol_new ad_beep2_mixer[] = {
-	HDA_CODEC_VOLUME("Digital Beep Playback Volume", 0, 0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_BEEP("Digital Beep Playback Switch", 0, 0, HDA_OUTPUT),
-	{ } /* end */
-};
-
 #define set_beep_amp(spec, nid, idx, dir) \
 	((spec)->beep_amp = HDA_COMPOSE_AMP_VAL(nid, 1, idx, dir)) /* mono */
 #else
@@ -181,8 +68,7 @@ static int create_beep_ctls(struct hda_codec *codec)
 	if (!spec->beep_amp)
 		return 0;
 
-	knew = spec->analog_beep ? ad_beep2_mixer : ad_beep_mixer;
-	for ( ; knew->name; knew++) {
+	for (knew = ad_beep_mixer ; knew->name; knew++) {
 		int err;
 		struct snd_kcontrol *kctl;
 		kctl = snd_ctl_new1(knew, codec);
@@ -199,268 +85,6 @@ static int create_beep_ctls(struct hda_codec *codec)
 #define create_beep_ctls(codec)		0
 #endif
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-static int ad198x_build_controls(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-	struct snd_kcontrol *kctl;
-	unsigned int i;
-	int err;
-
-	for (i = 0; i < spec->num_mixers; i++) {
-		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
-		if (err < 0)
-			return err;
-	}
-	if (spec->multiout.dig_out_nid) {
-		err = snd_hda_create_spdif_out_ctls(codec,
-						    spec->multiout.dig_out_nid,
-						    spec->multiout.dig_out_nid);
-		if (err < 0)
-			return err;
-		err = snd_hda_create_spdif_share_sw(codec,
-						    &spec->multiout);
-		if (err < 0)
-			return err;
-		spec->multiout.share_spdif = 1;
-	} 
-	if (spec->dig_in_nid) {
-		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in_nid);
-		if (err < 0)
-			return err;
-	}
-
-	/* create beep controls if needed */
-	err = create_beep_ctls(codec);
-	if (err < 0)
-		return err;
-
-	/* if we have no master control, let's create it */
-	if (!snd_hda_find_mixer_ctl(codec, "Master Playback Volume")) {
-		unsigned int vmaster_tlv[4];
-		snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
-					HDA_OUTPUT, vmaster_tlv);
-		err = __snd_hda_add_vmaster(codec, "Master Playback Volume",
-					  vmaster_tlv,
-					  (spec->slave_vols ?
-					   spec->slave_vols : ad_slave_pfxs),
-					  "Playback Volume",
-					  !spec->avoid_init_slave_vol, NULL);
-		if (err < 0)
-			return err;
-	}
-	if (!snd_hda_find_mixer_ctl(codec, "Master Playback Switch")) {
-		err = snd_hda_add_vmaster(codec, "Master Playback Switch",
-					  NULL,
-					  (spec->slave_sws ?
-					   spec->slave_sws : ad_slave_pfxs),
-					  "Playback Switch");
-		if (err < 0)
-			return err;
-	}
-
-	/* assign Capture Source enums to NID */
-	kctl = snd_hda_find_mixer_ctl(codec, "Capture Source");
-	if (!kctl)
-		kctl = snd_hda_find_mixer_ctl(codec, "Input Source");
-	for (i = 0; kctl && i < kctl->count; i++) {
-		err = snd_hda_add_nid(codec, kctl, i, spec->capsrc_nids[i]);
-		if (err < 0)
-			return err;
-	}
-
-	/* assign IEC958 enums to NID */
-	kctl = snd_hda_find_mixer_ctl(codec,
-			SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source");
-	if (kctl) {
-		err = snd_hda_add_nid(codec, kctl, 0,
-				      spec->multiout.dig_out_nid);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int ad198x_check_power_status(struct hda_codec *codec, hda_nid_t nid)
-{
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_check_amp_list_power(codec, &spec->loopback, nid);
-}
-#endif
-
-/*
- * Analog playback callbacks
- */
-static int ad198x_playback_pcm_open(struct hda_pcm_stream *hinfo,
-				    struct hda_codec *codec,
-				    struct snd_pcm_substream *substream)
-{
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
-					     hinfo);
-}
-
-static int ad198x_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
-				       struct hda_codec *codec,
-				       unsigned int stream_tag,
-				       unsigned int format,
-				       struct snd_pcm_substream *substream)
-{
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout, stream_tag,
-						format, substream);
-}
-
-static int ad198x_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
-				       struct hda_codec *codec,
-				       struct snd_pcm_substream *substream)
-{
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
-}
-
-/*
- * Digital out
- */
-static int ad198x_dig_playback_pcm_open(struct hda_pcm_stream *hinfo,
-					struct hda_codec *codec,
-					struct snd_pcm_substream *substream)
-{
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
-}
-
-static int ad198x_dig_playback_pcm_close(struct hda_pcm_stream *hinfo,
-					 struct hda_codec *codec,
-					 struct snd_pcm_substream *substream)
-{
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
-}
-
-static int ad198x_dig_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
-					   struct hda_codec *codec,
-					   unsigned int stream_tag,
-					   unsigned int format,
-					   struct snd_pcm_substream *substream)
-{
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_prepare(codec, &spec->multiout, stream_tag,
-					     format, substream);
-}
-
-static int ad198x_dig_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
-					   struct hda_codec *codec,
-					   struct snd_pcm_substream *substream)
-{
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_cleanup(codec, &spec->multiout);
-}
-
-/*
- * Analog capture
- */
-static int ad198x_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
-				      struct hda_codec *codec,
-				      unsigned int stream_tag,
-				      unsigned int format,
-				      struct snd_pcm_substream *substream)
-{
-	struct ad198x_spec *spec = codec->spec;
-	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number],
-				   stream_tag, 0, format);
-	return 0;
-}
-
-static int ad198x_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
-				      struct hda_codec *codec,
-				      struct snd_pcm_substream *substream)
-{
-	struct ad198x_spec *spec = codec->spec;
-	snd_hda_codec_cleanup_stream(codec, spec->adc_nids[substream->number]);
-	return 0;
-}
-
-/*
- */
-static const struct hda_pcm_stream ad198x_pcm_analog_playback = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 6, /* changed later */
-	.nid = 0, /* fill later */
-	.ops = {
-		.open = ad198x_playback_pcm_open,
-		.prepare = ad198x_playback_pcm_prepare,
-		.cleanup = ad198x_playback_pcm_cleanup,
-	},
-};
-
-static const struct hda_pcm_stream ad198x_pcm_analog_capture = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-	.nid = 0, /* fill later */
-	.ops = {
-		.prepare = ad198x_capture_pcm_prepare,
-		.cleanup = ad198x_capture_pcm_cleanup
-	},
-};
-
-static const struct hda_pcm_stream ad198x_pcm_digital_playback = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-	.nid = 0, /* fill later */
-	.ops = {
-		.open = ad198x_dig_playback_pcm_open,
-		.close = ad198x_dig_playback_pcm_close,
-		.prepare = ad198x_dig_playback_pcm_prepare,
-		.cleanup = ad198x_dig_playback_pcm_cleanup
-	},
-};
-
-static const struct hda_pcm_stream ad198x_pcm_digital_capture = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-	/* NID is set in alc_build_pcms */
-};
-
-static int ad198x_build_pcms(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-	struct hda_pcm *info = spec->pcm_rec;
-
-	codec->num_pcms = 1;
-	codec->pcm_info = info;
-
-	info->name = "AD198x Analog";
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = ad198x_pcm_analog_playback;
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max = spec->multiout.max_channels;
-	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->multiout.dac_nids[0];
-	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ad198x_pcm_analog_capture;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = spec->num_adc_nids;
-	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];
-
-	if (spec->multiout.dig_out_nid) {
-		info++;
-		codec->num_pcms++;
-		codec->spdif_status_reset = 1;
-		info->name = "AD198x Digital";
-		info->pcm_type = HDA_PCM_TYPE_SPDIF;
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK] = ad198x_pcm_digital_playback;
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->multiout.dig_out_nid;
-		if (spec->dig_in_nid) {
-			info->stream[SNDRV_PCM_STREAM_CAPTURE] = ad198x_pcm_digital_capture;
-			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->dig_in_nid;
-		}
-	}
-
-	return 0;
-}
-#endif /* ENABLE_AD_STATIC_QUIRKS */
 
 static void ad198x_power_eapd_write(struct hda_codec *codec, hda_nid_t front,
 				hda_nid_t hp)
@@ -507,18 +131,6 @@ static void ad198x_shutup(struct hda_codec *codec)
 	ad198x_power_eapd(codec);
 }
 
-static void ad198x_free(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-
-	if (!spec)
-		return;
-
-	snd_hda_gen_spec_free(&spec->gen);
-	kfree(spec);
-	snd_hda_detach_beep_device(codec);
-}
-
 #ifdef CONFIG_PM
 static int ad198x_suspend(struct hda_codec *codec)
 {
@@ -527,65 +139,6 @@ static int ad198x_suspend(struct hda_codec *codec)
 }
 #endif
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-static const struct hda_codec_ops ad198x_patch_ops = {
-	.build_controls = ad198x_build_controls,
-	.build_pcms = ad198x_build_pcms,
-	.init = ad198x_init,
-	.free = ad198x_free,
-#ifdef CONFIG_PM
-	.check_power_status = ad198x_check_power_status,
-	.suspend = ad198x_suspend,
-#endif
-	.reboot_notify = ad198x_shutup,
-};
-
-
-/*
- * EAPD control
- * the private value = nid
- */
-#define ad198x_eapd_info	snd_ctl_boolean_mono_info
-
-static int ad198x_eapd_get(struct snd_kcontrol *kcontrol,
-			   struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	if (codec->inv_eapd)
-		ucontrol->value.integer.value[0] = ! spec->cur_eapd;
-	else
-		ucontrol->value.integer.value[0] = spec->cur_eapd;
-	return 0;
-}
-
-static int ad198x_eapd_put(struct snd_kcontrol *kcontrol,
-			   struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	hda_nid_t nid = kcontrol->private_value & 0xff;
-	unsigned int eapd;
-	eapd = !!ucontrol->value.integer.value[0];
-	if (codec->inv_eapd)
-		eapd = !eapd;
-	if (eapd == spec->cur_eapd)
-		return 0;
-	spec->cur_eapd = eapd;
-	snd_hda_codec_write_cache(codec, nid,
-				  0, AC_VERB_SET_EAPD_BTLENABLE,
-				  eapd ? 0x02 : 0x00);
-	return 1;
-}
-
-static int ad198x_ch_mode_info(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_info *uinfo);
-static int ad198x_ch_mode_get(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_value *ucontrol);
-static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_value *ucontrol);
-#endif /* ENABLE_AD_STATIC_QUIRKS */
-
 
 /*
  * Automatic parse of I/O pins from the BIOS configuration
@@ -646,446 +199,6 @@ static int ad198x_parse_auto_config(struct hda_codec *codec)
  * AD1986A specific
  */
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-#define AD1986A_SPDIF_OUT	0x02
-#define AD1986A_FRONT_DAC	0x03
-#define AD1986A_SURR_DAC	0x04
-#define AD1986A_CLFE_DAC	0x05
-#define AD1986A_ADC		0x06
-
-static const hda_nid_t ad1986a_dac_nids[3] = {
-	AD1986A_FRONT_DAC, AD1986A_SURR_DAC, AD1986A_CLFE_DAC
-};
-static const hda_nid_t ad1986a_adc_nids[1] = { AD1986A_ADC };
-static const hda_nid_t ad1986a_capsrc_nids[1] = { 0x12 };
-
-static const struct hda_input_mux ad1986a_capture_source = {
-	.num_items = 7,
-	.items = {
-		{ "Mic", 0x0 },
-		{ "CD", 0x1 },
-		{ "Aux", 0x3 },
-		{ "Line", 0x4 },
-		{ "Mix", 0x5 },
-		{ "Mono", 0x6 },
-		{ "Phone", 0x7 },
-	},
-};
-
-
-static const struct hda_bind_ctls ad1986a_bind_pcm_vol = {
-	.ops = &snd_hda_bind_vol,
-	.values = {
-		HDA_COMPOSE_AMP_VAL(AD1986A_FRONT_DAC, 3, 0, HDA_OUTPUT),
-		HDA_COMPOSE_AMP_VAL(AD1986A_SURR_DAC, 3, 0, HDA_OUTPUT),
-		HDA_COMPOSE_AMP_VAL(AD1986A_CLFE_DAC, 3, 0, HDA_OUTPUT),
-		0
-	},
-};
-
-static const struct hda_bind_ctls ad1986a_bind_pcm_sw = {
-	.ops = &snd_hda_bind_sw,
-	.values = {
-		HDA_COMPOSE_AMP_VAL(AD1986A_FRONT_DAC, 3, 0, HDA_OUTPUT),
-		HDA_COMPOSE_AMP_VAL(AD1986A_SURR_DAC, 3, 0, HDA_OUTPUT),
-		HDA_COMPOSE_AMP_VAL(AD1986A_CLFE_DAC, 3, 0, HDA_OUTPUT),
-		0
-	},
-};
-
-/*
- * mixers
- */
-static const struct snd_kcontrol_new ad1986a_mixers[] = {
-	/*
-	 * bind volumes/mutes of 3 DACs as a single PCM control for simplicity
-	 */
-	HDA_BIND_VOL("PCM Playback Volume", &ad1986a_bind_pcm_vol),
-	HDA_BIND_SW("PCM Playback Switch", &ad1986a_bind_pcm_sw),
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x1b, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Front Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Surround Playback Volume", 0x1c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Surround Playback Switch", 0x1c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x1d, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x1d, 2, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x1d, 1, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x1d, 2, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x1a, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1a, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x17, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x17, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Aux Playback Volume", 0x16, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Aux Playback Switch", 0x16, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x0f, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mono Playback Volume", 0x1e, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Mono Playback Switch", 0x1e, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x12, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Source",
-		.info = ad198x_mux_enum_info,
-		.get = ad198x_mux_enum_get,
-		.put = ad198x_mux_enum_put,
-	},
-	HDA_CODEC_MUTE("Stereo Downmix Switch", 0x09, 0x0, HDA_OUTPUT),
-	{ } /* end */
-};
-
-/* additional mixers for 3stack mode */
-static const struct snd_kcontrol_new ad1986a_3st_mixers[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Channel Mode",
-		.info = ad198x_ch_mode_info,
-		.get = ad198x_ch_mode_get,
-		.put = ad198x_ch_mode_put,
-	},
-	{ } /* end */
-};
-
-/* laptop model - 2ch only */
-static const hda_nid_t ad1986a_laptop_dac_nids[1] = { AD1986A_FRONT_DAC };
-
-/* master controls both pins 0x1a and 0x1b */
-static const struct hda_bind_ctls ad1986a_laptop_master_vol = {
-	.ops = &snd_hda_bind_vol,
-	.values = {
-		HDA_COMPOSE_AMP_VAL(0x1a, 3, 0, HDA_OUTPUT),
-		HDA_COMPOSE_AMP_VAL(0x1b, 3, 0, HDA_OUTPUT),
-		0,
-	},
-};
-
-static const struct hda_bind_ctls ad1986a_laptop_master_sw = {
-	.ops = &snd_hda_bind_sw,
-	.values = {
-		HDA_COMPOSE_AMP_VAL(0x1a, 3, 0, HDA_OUTPUT),
-		HDA_COMPOSE_AMP_VAL(0x1b, 3, 0, HDA_OUTPUT),
-		0,
-	},
-};
-
-static const struct snd_kcontrol_new ad1986a_laptop_mixers[] = {
-	HDA_CODEC_VOLUME("PCM Playback Volume", 0x03, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("PCM Playback Switch", 0x03, 0x0, HDA_OUTPUT),
-	HDA_BIND_VOL("Master Playback Volume", &ad1986a_laptop_master_vol),
-	HDA_BIND_SW("Master Playback Switch", &ad1986a_laptop_master_sw),
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x17, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x17, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Aux Playback Volume", 0x16, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Aux Playback Switch", 0x16, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x0f, 0x0, HDA_OUTPUT),
-	/* 
-	   HDA_CODEC_VOLUME("Mono Playback Volume", 0x1e, 0x0, HDA_OUTPUT),
-	   HDA_CODEC_MUTE("Mono Playback Switch", 0x1e, 0x0, HDA_OUTPUT), */
-	HDA_CODEC_VOLUME("Capture Volume", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x12, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Source",
-		.info = ad198x_mux_enum_info,
-		.get = ad198x_mux_enum_get,
-		.put = ad198x_mux_enum_put,
-	},
-	{ } /* end */
-};
-
-/* laptop-eapd model - 2ch only */
-
-static const struct hda_input_mux ad1986a_laptop_eapd_capture_source = {
-	.num_items = 3,
-	.items = {
-		{ "Mic", 0x0 },
-		{ "Internal Mic", 0x4 },
-		{ "Mix", 0x5 },
-	},
-};
-
-static const struct hda_input_mux ad1986a_automic_capture_source = {
-	.num_items = 2,
-	.items = {
-		{ "Mic", 0x0 },
-		{ "Mix", 0x5 },
-	},
-};
-
-static const struct snd_kcontrol_new ad1986a_laptop_master_mixers[] = {
-	HDA_BIND_VOL("Master Playback Volume", &ad1986a_laptop_master_vol),
-	HDA_BIND_SW("Master Playback Switch", &ad1986a_laptop_master_sw),
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1986a_laptop_eapd_mixers[] = {
-	HDA_CODEC_VOLUME("PCM Playback Volume", 0x03, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("PCM Playback Switch", 0x03, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost Volume", 0x0f, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Capture Volume", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x12, 0x0, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Source",
-		.info = ad198x_mux_enum_info,
-		.get = ad198x_mux_enum_get,
-		.put = ad198x_mux_enum_put,
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "External Amplifier",
-		.subdevice = HDA_SUBDEV_NID_FLAG | 0x1b,
-		.info = ad198x_eapd_info,
-		.get = ad198x_eapd_get,
-		.put = ad198x_eapd_put,
-		.private_value = 0x1b, /* port-D */
-	},
-	{ } /* end */
-};
-
-static const struct snd_kcontrol_new ad1986a_laptop_intmic_mixers[] = {
-	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x17, 0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x17, 0, HDA_OUTPUT),
-	{ } /* end */
-};
-
-/* laptop-automute - 2ch only */
-
-static void ad1986a_update_hp(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-	unsigned int mute;
-
-	if (spec->jack_present)
-		mute = HDA_AMP_MUTE; /* mute internal speaker */
-	else
-		/* unmute internal speaker if necessary */
-		mute = snd_hda_codec_amp_read(codec, 0x1a, 0, HDA_OUTPUT, 0);
-	snd_hda_codec_amp_stereo(codec, 0x1b, HDA_OUTPUT, 0,
-				 HDA_AMP_MUTE, mute);
-}
-
-static void ad1986a_hp_automute(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-
-	spec->jack_present = snd_hda_jack_detect(codec, 0x1a);
-	if (spec->inv_jack_detect)
-		spec->jack_present = !spec->jack_present;
-	ad1986a_update_hp(codec);
-}
-
-#define AD1986A_HP_EVENT		0x37
-
-static void ad1986a_hp_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	if ((res >> 26) != AD1986A_HP_EVENT)
-		return;
-	ad1986a_hp_automute(codec);
-}
-
-static int ad1986a_hp_init(struct hda_codec *codec)
-{
-	ad198x_init(codec);
-	ad1986a_hp_automute(codec);
-	return 0;
-}
-
-/* bind hp and internal speaker mute (with plug check) */
-static int ad1986a_hp_master_sw_put(struct snd_kcontrol *kcontrol,
-				    struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	int change = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
-	if (change)
-		ad1986a_update_hp(codec);
-	return change;
-}
-
-static const struct snd_kcontrol_new ad1986a_automute_master_mixers[] = {
-	HDA_BIND_VOL("Master Playback Volume", &ad1986a_laptop_master_vol),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Master Playback Switch",
-		.subdevice = HDA_SUBDEV_AMP_FLAG,
-		.info = snd_hda_mixer_amp_switch_info,
-		.get = snd_hda_mixer_amp_switch_get,
-		.put = ad1986a_hp_master_sw_put,
-		.private_value = HDA_COMPOSE_AMP_VAL(0x1a, 3, 0, HDA_OUTPUT),
-	},
-	{ } /* end */
-};
-
-
-/*
- * initialization verbs
- */
-static const struct hda_verb ad1986a_init_verbs[] = {
-	/* Front, Surround, CLFE DAC; mute as default */
-	{0x03, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* Downmix - off */
-	{0x09, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* HP, Line-Out, Surround, CLFE selectors */
-	{0x0a, AC_VERB_SET_CONNECT_SEL, 0x0},
-	{0x0b, AC_VERB_SET_CONNECT_SEL, 0x0},
-	{0x0c, AC_VERB_SET_CONNECT_SEL, 0x0},
-	{0x0d, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Mono selector */
-	{0x0e, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Mic selector: Mic 1/2 pin */
-	{0x0f, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Line-in selector: Line-in */
-	{0x10, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Mic 1/2 swap */
-	{0x11, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Record selector: mic */
-	{0x12, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* Mic, Phone, CD, Aux, Line-In amp; mute as default */
-	{0x13, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* PC beep */
-	{0x18, AC_VERB_SET_CONNECT_SEL, 0x0},
-	/* HP, Line-Out, Surround, CLFE, Mono pins; mute as default */
-	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x1d, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	{0x1e, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080},
-	/* HP Pin */
-	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0 },
-	/* Front, Surround, CLFE Pins */
-	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
-	{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
-	{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
-	/* Mono Pin */
-	{0x1e, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
-	/* Mic Pin */
-	{0x1f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
-	/* Line, Aux, CD, Beep-In Pin */
-	{0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
-	{0x21, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
-	{0x22, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
-	{0x23, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
-	{0x24, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
-	{ } /* end */
-};
-
-static const struct hda_verb ad1986a_ch2_init[] = {
-	/* Surround out -> Line In */
-	{ 0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
- 	/* Line-in selectors */
-	{ 0x10, AC_VERB_SET_CONNECT_SEL, 0x1 },
-	/* CLFE -> Mic in */
-	{ 0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
-	/* Mic selector, mix C/LFE (backmic) and Mic (frontmic) */
-	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x4 },
-	{ } /* end */
-};
-
-static const struct hda_verb ad1986a_ch4_init[] = {
-	/* Surround out -> Surround */
-	{ 0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x10, AC_VERB_SET_CONNECT_SEL, 0x0 },
-	/* CLFE -> Mic in */
-	{ 0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
-	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x4 },
-	{ } /* end */
-};
-
-static const struct hda_verb ad1986a_ch6_init[] = {
-	/* Surround out -> Surround out */
-	{ 0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x10, AC_VERB_SET_CONNECT_SEL, 0x0 },
-	/* CLFE -> CLFE */
-	{ 0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x0 },
-	{ } /* end */
-};
-
-static const struct hda_channel_mode ad1986a_modes[3] = {
-	{ 2, ad1986a_ch2_init },
-	{ 4, ad1986a_ch4_init },
-	{ 6, ad1986a_ch6_init },
-};
-
-/* eapd initialization */
-static const struct hda_verb ad1986a_eapd_init_verbs[] = {
-	{0x1b, AC_VERB_SET_EAPD_BTLENABLE, 0x00 },
-	{}
-};
-
-/* pin sensing on HP jack */
-static const struct hda_verb ad1986a_hp_init_verbs[] = {
-	{0x1a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1986A_HP_EVENT},
-	{}
-};
-
-
-/* models */
-enum {
-	AD1986A_AUTO,
-	AD1986A_6STACK,
-	AD1986A_3STACK,
-	AD1986A_LAPTOP,
-	AD1986A_LAPTOP_EAPD,
-	AD1986A_LAPTOP_AUTOMUTE,
-	AD1986A_MODELS
-};
-
-static const char * const ad1986a_models[AD1986A_MODELS] = {
-	[AD1986A_AUTO]		= "auto",
-	[AD1986A_6STACK]	= "6stack",
-	[AD1986A_3STACK]	= "3stack",
-	[AD1986A_LAPTOP]	= "laptop",
-	[AD1986A_LAPTOP_EAPD]	= "laptop-eapd",
-	[AD1986A_LAPTOP_AUTOMUTE] = "laptop-automute",
-};
-
-static const struct snd_pci_quirk ad1986a_cfg_tbl[] = {
-	SND_PCI_QUIRK(0x103c, 0x30af, "HP B2800", AD1986A_LAPTOP_EAPD),
-	SND_PCI_QUIRK(0x1043, 0x817f, "ASUS P5", AD1986A_3STACK),
-	SND_PCI_QUIRK(0x1043, 0x818f, "ASUS P5", AD1986A_LAPTOP),
-	SND_PCI_QUIRK(0x1043, 0x81b3, "ASUS P5", AD1986A_3STACK),
-	SND_PCI_QUIRK(0x1043, 0x81cb, "ASUS M2N", AD1986A_3STACK),
-	SND_PCI_QUIRK(0x1043, 0x8234, "ASUS M2N", AD1986A_3STACK),
-	SND_PCI_QUIRK(0x10de, 0xcb84, "ASUS A8N-VM", AD1986A_3STACK),
-	SND_PCI_QUIRK(0x144d, 0xc01e, "FSC V2060", AD1986A_LAPTOP),
-	SND_PCI_QUIRK(0x17aa, 0x1011, "Lenovo M55", AD1986A_LAPTOP),
-	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_3STACK),
-	{}
-};
-
-#ifdef CONFIG_PM
-static const struct hda_amp_list ad1986a_loopbacks[] = {
-	{ 0x13, HDA_OUTPUT, 0 }, /* Mic */
-	{ 0x14, HDA_OUTPUT, 0 }, /* Phone */
-	{ 0x15, HDA_OUTPUT, 0 }, /* CD */
-	{ 0x16, HDA_OUTPUT, 0 }, /* Aux */
-	{ 0x17, HDA_OUTPUT, 0 }, /* Line */
-	{ } /* end */
-};
-#endif
-
-static int is_jack_available(struct hda_codec *codec, hda_nid_t nid)
-{
-	unsigned int conf = snd_hda_codec_get_pincfg(codec, nid);
-	return get_defcfg_connect(conf) != AC_JACK_PORT_NONE;
-}
-#endif /* ENABLE_AD_STATIC_QUIRKS */
-
 static int alloc_ad_spec(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
@@ -1114,6 +227,9 @@ enum {
 	AD1986A_FIXUP_INV_JACK_DETECT,
 	AD1986A_FIXUP_ULTRA,
 	AD1986A_FIXUP_SAMSUNG,
+	AD1986A_FIXUP_3STACK,
+	AD1986A_FIXUP_LAPTOP,
+	AD1986A_FIXUP_LAPTOP_IMIC,
 };
 
 static const struct hda_fixup ad1986a_fixups[] = {
@@ -1139,18 +255,68 @@ static const struct hda_fixup ad1986a_fixups[] = {
 			{}
 		},
 	},
+	[AD1986A_FIXUP_3STACK] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x02214021 }, /* headphone */
+			{ 0x1b, 0x01014011 }, /* front */
+			{ 0x1c, 0x01013012 }, /* surround */
+			{ 0x1d, 0x01019015 }, /* clfe */
+			{ 0x1e, 0x411111f0 }, /* N/A */
+			{ 0x1f, 0x02a190f0 }, /* mic */
+			{ 0x20, 0x018130f0 }, /* line-in */
+			{}
+		},
+	},
+	[AD1986A_FIXUP_LAPTOP] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x02214021 }, /* headphone */
+			{ 0x1b, 0x90170110 }, /* speaker */
+			{ 0x1c, 0x411111f0 }, /* N/A */
+			{ 0x1d, 0x411111f0 }, /* N/A */
+			{ 0x1e, 0x411111f0 }, /* N/A */
+			{ 0x1f, 0x02a191f0 }, /* mic */
+			{ 0x20, 0x411111f0 }, /* N/A */
+			{}
+		},
+	},
+	[AD1986A_FIXUP_LAPTOP_IMIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1d, 0x90a7013e }, /* int mic */
+			{}
+		},
+		.chained_before = 1,
+		.chain_id = AD1986A_FIXUP_LAPTOP,
+	},
 };
 
 static const struct snd_pci_quirk ad1986a_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x103c, 0x30af, "HP B2800", AD1986A_FIXUP_LAPTOP_IMIC),
+	SND_PCI_QUIRK_MASK(0x1043, 0xff00, 0x8100, "ASUS P5", AD1986A_FIXUP_3STACK),
+	SND_PCI_QUIRK_MASK(0x1043, 0xff00, 0x8200, "ASUS M2", AD1986A_FIXUP_3STACK),
+	SND_PCI_QUIRK(0x10de, 0xcb84, "ASUS A8N-VM", AD1986A_FIXUP_3STACK),
+	SND_PCI_QUIRK(0x144d, 0xc01e, "FSC V2060", AD1986A_FIXUP_LAPTOP),
 	SND_PCI_QUIRK_MASK(0x144d, 0xff00, 0xc000, "Samsung", AD1986A_FIXUP_SAMSUNG),
 	SND_PCI_QUIRK(0x144d, 0xc027, "Samsung Q1", AD1986A_FIXUP_ULTRA),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_FIXUP_INV_JACK_DETECT),
+	SND_PCI_QUIRK(0x17aa, 0x1011, "Lenovo M55", AD1986A_FIXUP_3STACK),
+	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_FIXUP_3STACK),
+	{}
+};
+
+static const struct hda_model_fixup ad1986a_fixup_models[] = {
+	{ .id = AD1986A_FIXUP_3STACK, .name = "3stack" },
+	{ .id = AD1986A_FIXUP_LAPTOP, .name = "laptop" },
+	{ .id = AD1986A_FIXUP_LAPTOP_IMIC, .name = "laptop-imic" },
+	{ .id = AD1986A_FIXUP_LAPTOP_IMIC, .name = "laptop-eapd" }, /* alias */
 	{}
 };
 
 /*
  */
-static int ad1986a_parse_auto_config(struct hda_codec *codec)
+static int patch_ad1986a(struct hda_codec *codec)
 {
 	int err;
 	struct ad198x_spec *spec;
@@ -1175,7 +341,8 @@ static int ad1986a_parse_auto_config(struct hda_codec *codec)
 	 */
 	spec->gen.multiout.no_share_stream = 1;
 
-	snd_hda_pick_fixup(codec, NULL, ad1986a_fixup_tbl, ad1986a_fixups);
+	snd_hda_pick_fixup(codec, ad1986a_fixup_models, ad1986a_fixup_tbl,
+			   ad1986a_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	err = ad198x_parse_auto_config(codec);
@@ -1189,128 +356,6 @@ static int ad1986a_parse_auto_config(struct hda_codec *codec)
 	return 0;
 }
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-static int patch_ad1986a(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec;
-	int err, board_config;
-
-	board_config = snd_hda_check_board_config(codec, AD1986A_MODELS,
-						  ad1986a_models,
-						  ad1986a_cfg_tbl);
-	if (board_config < 0) {
-		printk(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-		       codec->chip_name);
-		board_config = AD1986A_AUTO;
-	}
-
-	if (board_config == AD1986A_AUTO)
-		return ad1986a_parse_auto_config(codec);
-
-	err = alloc_ad_spec(codec);
-	if (err < 0)
-		return err;
-	spec = codec->spec;
-
-	err = snd_hda_attach_beep_device(codec, 0x19);
-	if (err < 0) {
-		ad198x_free(codec);
-		return err;
-	}
-	set_beep_amp(spec, 0x18, 0, HDA_OUTPUT);
-
-	spec->multiout.max_channels = 6;
-	spec->multiout.num_dacs = ARRAY_SIZE(ad1986a_dac_nids);
-	spec->multiout.dac_nids = ad1986a_dac_nids;
-	spec->multiout.dig_out_nid = AD1986A_SPDIF_OUT;
-	spec->num_adc_nids = 1;
-	spec->adc_nids = ad1986a_adc_nids;
-	spec->capsrc_nids = ad1986a_capsrc_nids;
-	spec->input_mux = &ad1986a_capture_source;
-	spec->num_mixers = 1;
-	spec->mixers[0] = ad1986a_mixers;
-	spec->num_init_verbs = 1;
-	spec->init_verbs[0] = ad1986a_init_verbs;
-#ifdef CONFIG_PM
-	spec->loopback.amplist = ad1986a_loopbacks;
-#endif
-	spec->vmaster_nid = 0x1b;
-	codec->inv_eapd = 1; /* AD1986A has the inverted EAPD implementation */
-
-	codec->patch_ops = ad198x_patch_ops;
-
-	/* override some parameters */
-	switch (board_config) {
-	case AD1986A_3STACK:
-		spec->num_mixers = 2;
-		spec->mixers[1] = ad1986a_3st_mixers;
-		spec->num_init_verbs = 2;
-		spec->init_verbs[1] = ad1986a_ch2_init;
-		spec->channel_mode = ad1986a_modes;
-		spec->num_channel_mode = ARRAY_SIZE(ad1986a_modes);
-		spec->need_dac_fix = 1;
-		spec->multiout.max_channels = 2;
-		spec->multiout.num_dacs = 1;
-		break;
-	case AD1986A_LAPTOP:
-		spec->mixers[0] = ad1986a_laptop_mixers;
-		spec->multiout.max_channels = 2;
-		spec->multiout.num_dacs = 1;
-		spec->multiout.dac_nids = ad1986a_laptop_dac_nids;
-		break;
-	case AD1986A_LAPTOP_EAPD:
-		spec->num_mixers = 3;
-		spec->mixers[0] = ad1986a_laptop_master_mixers;
-		spec->mixers[1] = ad1986a_laptop_eapd_mixers;
-		spec->mixers[2] = ad1986a_laptop_intmic_mixers;
-		spec->num_init_verbs = 2;
-		spec->init_verbs[1] = ad1986a_eapd_init_verbs;
-		spec->multiout.max_channels = 2;
-		spec->multiout.num_dacs = 1;
-		spec->multiout.dac_nids = ad1986a_laptop_dac_nids;
-		if (!is_jack_available(codec, 0x25))
-			spec->multiout.dig_out_nid = 0;
-		spec->input_mux = &ad1986a_laptop_eapd_capture_source;
-		break;
-	case AD1986A_LAPTOP_AUTOMUTE:
-		spec->num_mixers = 3;
-		spec->mixers[0] = ad1986a_automute_master_mixers;
-		spec->mixers[1] = ad1986a_laptop_eapd_mixers;
-		spec->mixers[2] = ad1986a_laptop_intmic_mixers;
-		spec->num_init_verbs = 3;
-		spec->init_verbs[1] = ad1986a_eapd_init_verbs;
-		spec->init_verbs[2] = ad1986a_hp_init_verbs;
-		spec->multiout.max_channels = 2;
-		spec->multiout.num_dacs = 1;
-		spec->multiout.dac_nids = ad1986a_laptop_dac_nids;
-		if (!is_jack_available(codec, 0x25))
-			spec->multiout.dig_out_nid = 0;
-		spec->input_mux = &ad1986a_laptop_eapd_capture_source;
-		codec->patch_ops.unsol_event = ad1986a_hp_unsol_event;
-		codec->patch_ops.init = ad1986a_hp_init;
-		/* Lenovo N100 seems to report the reversed bit
-		 * for HP jack-sensing
-		 */
-		spec->inv_jack_detect = 1;
-		break;
-	}
-
-	/* AD1986A has a hardware problem that it can't share a stream
-	 * with multiple output pins.  The copy of front to surrounds
-	 * causes noisy or silent outputs at a certain timing, e.g.
-	 * changing the volume.
-	 * So, let's disable the shared stream.
-	 */
-	spec->multiout.no_share_stream = 1;
-
-	codec->no_trigger_sense = 1;
-	codec->no_sticky_stream = 1;
-
-	return 0;
-}
-#else /* ENABLE_AD_STATIC_QUIRKS */
-#define patch_ad1986a	ad1986a_parse_auto_config
-#endif /* ENABLE_AD_STATIC_QUIRKS */
 
 /*
  * AD1983 specific
-- 
1.8.3.1
