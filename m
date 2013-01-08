From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/8] ALSA: hda - Add generic parser support to
	Analog Device codec driver
Date: Tue,  8 Jan 2013 12:50:48 +0100
Message-ID: <1357645849-8181-8-git-send-email-tiwai@suse.de>
References: <1357645849-8181-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9741E265F81
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 7A19AA51B8
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

This patch adds the support for the generic auto-parser to AD codec
driver.  For AD1988, the old code is replaced simply with the new
generic parser.  For other codecs, new model "auto" is added and
directed to use the generic parser.

No fixup codes have been implemented yet as of now.  Eventually we'd
replace each static quirk with the generic parser + fixup.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig        |   1 +
 sound/pci/hda/patch_analog.c | 915 ++++++++++++++-----------------------------
 2 files changed, 292 insertions(+), 624 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 206f678..4962441 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -99,6 +99,7 @@ config SND_HDA_CODEC_REALTEK
 config SND_HDA_CODEC_ANALOG
 	bool "Build Analog Device HD-audio codec support"
 	default y
+	select SND_HDA_GENERIC
 	help
 	  Say Y here to include Analog Device HD-audio codec support in
 	  snd-hda-intel driver, such as AD1986A.
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 308a5b9..02fe0d1 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -31,11 +31,15 @@
 #include "hda_auto_parser.h"
 #include "hda_beep.h"
 #include "hda_jack.h"
+#include "hda_generic.h"
 
 struct ad198x_spec {
+	struct hda_gen_spec gen;
+
 	const struct snd_kcontrol_new *mixers[6];
 	int num_mixers;
 	unsigned int beep_amp;	/* beep amp value, set via set_beep_amp() */
+	hda_nid_t beep_dev_nid;
 	const struct hda_verb *init_verbs[6];	/* initialization verbs
 						 * don't forget NULL termination!
 						 */
@@ -49,11 +53,6 @@ struct ad198x_spec {
 	unsigned int cur_eapd;
 	unsigned int need_dac_fix;
 
-	const hda_nid_t *alt_dac_nid;
-	const struct hda_pcm_stream *stream_analog_alt_playback;
-	int independent_hp;
-	int num_active_streams;
-
 	/* capture */
 	unsigned int num_adc_nids;
 	const hda_nid_t *adc_nids;
@@ -73,15 +72,8 @@ struct ad198x_spec {
 
 	unsigned int spdif_route;
 
-	/* dynamic controls, init_verbs and input_mux */
-	struct auto_pin_cfg autocfg;
-	struct snd_array kctls;
-	struct hda_input_mux private_imux;
-	hda_nid_t private_dac_nids[AUTO_CFG_MAX_OUTS];
-
 	unsigned int jack_present: 1;
 	unsigned int inv_jack_detect: 1;/* inverted jack-detection */
-	unsigned int inv_eapd: 1;	/* inverted EAPD implementation */
 	unsigned int analog_beep: 1;	/* analog beep input present */
 	unsigned int avoid_init_slave_vol:1;
 
@@ -150,8 +142,6 @@ static const char * const ad1988_6stack_fp_slave_pfxs[] = {
 	NULL
 };
 
-static void ad198x_free_kctls(struct hda_codec *codec);
-
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
 /* additional beep mixers; the actual parameters are overwritten at build */
 static const struct snd_kcontrol_new ad_beep_mixer[] = {
@@ -172,6 +162,33 @@ static const struct snd_kcontrol_new ad_beep2_mixer[] = {
 #define set_beep_amp(spec, nid, idx, dir) /* NOP */
 #endif
 
+#ifdef CONFIG_SND_HDA_INPUT_BEEP
+static int create_beep_ctls(struct hda_codec *codec)
+{
+	struct ad198x_spec *spec = codec->spec;
+	const struct snd_kcontrol_new *knew;
+
+	if (!spec->beep_amp)
+		return 0;
+
+	knew = spec->analog_beep ? ad_beep2_mixer : ad_beep_mixer;
+	for ( ; knew->name; knew++) {
+		int err;
+		struct snd_kcontrol *kctl;
+		kctl = snd_ctl_new1(knew, codec);
+		if (!kctl)
+			return -ENOMEM;
+		kctl->private_value = spec->beep_amp;
+		err = snd_hda_ctl_add(codec, 0, kctl);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+#else
+#define create_beep_ctls(codec)		0
+#endif
+
 static int ad198x_build_controls(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec = codec->spec;
@@ -203,22 +220,9 @@ static int ad198x_build_controls(struct hda_codec *codec)
 	}
 
 	/* create beep controls if needed */
-#ifdef CONFIG_SND_HDA_INPUT_BEEP
-	if (spec->beep_amp) {
-		const struct snd_kcontrol_new *knew;
-		knew = spec->analog_beep ? ad_beep2_mixer : ad_beep_mixer;
-		for ( ; knew->name; knew++) {
-			struct snd_kcontrol *kctl;
-			kctl = snd_ctl_new1(knew, codec);
-			if (!kctl)
-				return -ENOMEM;
-			kctl->private_value = spec->beep_amp;
-			err = snd_hda_ctl_add(codec, 0, kctl);
-			if (err < 0)
-				return err;
-		}
-	}
-#endif
+	err = create_beep_ctls(codec);
+	if (err < 0)
+		return err;
 
 	/* if we have no master control, let's create it */
 	if (!snd_hda_find_mixer_ctl(codec, "Master Playback Volume")) {
@@ -244,8 +248,6 @@ static int ad198x_build_controls(struct hda_codec *codec)
 			return err;
 	}
 
-	ad198x_free_kctls(codec); /* no longer needed */
-
 	/* assign Capture Source enums to NID */
 	kctl = snd_hda_find_mixer_ctl(codec, "Capture Source");
 	if (!kctl)
@@ -277,72 +279,6 @@ static int ad198x_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 }
 #endif
 
-static void activate_ctl(struct hda_codec *codec, const char *name, int active)
-{
-	struct snd_kcontrol *ctl = snd_hda_find_mixer_ctl(codec, name);
-	if (ctl) {
-		ctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
-		ctl->vd[0].access |= active ? 0 :
-			SNDRV_CTL_ELEM_ACCESS_INACTIVE;
-		ctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_WRITE;
-		ctl->vd[0].access |= active ?
-			SNDRV_CTL_ELEM_ACCESS_WRITE : 0;
-		snd_ctl_notify(codec->bus->card,
-			       SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
-	}
-}
-
-static void set_stream_active(struct hda_codec *codec, bool active)
-{
-	struct ad198x_spec *spec = codec->spec;
-	if (active)
-		spec->num_active_streams++;
-	else
-		spec->num_active_streams--;
-	activate_ctl(codec, "Independent HP", spec->num_active_streams == 0);
-}
-
-static int ad1988_independent_hp_info(struct snd_kcontrol *kcontrol,
-				   struct snd_ctl_elem_info *uinfo)
-{
-	static const char * const texts[] = { "OFF", "ON", NULL};
-	int index;
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	index = uinfo->value.enumerated.item;
-	if (index >= 2)
-		index = 1;
-	strcpy(uinfo->value.enumerated.name, texts[index]);
-	return 0;
-}
-
-static int ad1988_independent_hp_get(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	ucontrol->value.enumerated.item[0] = spec->independent_hp;
-	return 0;
-}
-
-static int ad1988_independent_hp_put(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	unsigned int select = ucontrol->value.enumerated.item[0];
-	if (spec->independent_hp != select) {
-		spec->independent_hp = select;
-		if (spec->independent_hp)
-			spec->multiout.hp_nid = 0;
-		else
-			spec->multiout.hp_nid = spec->alt_dac_nid[0];
-		return 1;
-	}
-	return 0;
-}
-
 /*
  * Analog playback callbacks
  */
@@ -351,15 +287,8 @@ static int ad198x_playback_pcm_open(struct hda_pcm_stream *hinfo,
 				    struct snd_pcm_substream *substream)
 {
 	struct ad198x_spec *spec = codec->spec;
-	int err;
-	set_stream_active(codec, true);
-	err = snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
+	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
 					     hinfo);
-	if (err < 0) {
-		set_stream_active(codec, false);
-		return err;
-	}
-	return 0;
 }
 
 static int ad198x_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
@@ -381,43 +310,6 @@ static int ad198x_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
 	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
 }
 
-static int ad198x_playback_pcm_close(struct hda_pcm_stream *hinfo,
-				 struct hda_codec *codec,
-				 struct snd_pcm_substream *substream)
-{
-	set_stream_active(codec, false);
-	return 0;
-}
-
-static int ad1988_alt_playback_pcm_open(struct hda_pcm_stream *hinfo,
-				 struct hda_codec *codec,
-				 struct snd_pcm_substream *substream)
-{
-	struct ad198x_spec *spec = codec->spec;
-	if (!spec->independent_hp)
-		return -EBUSY;
-	set_stream_active(codec, true);
-	return 0;
-}
-
-static int ad1988_alt_playback_pcm_close(struct hda_pcm_stream *hinfo,
-				 struct hda_codec *codec,
-				 struct snd_pcm_substream *substream)
-{
-	set_stream_active(codec, false);
-	return 0;
-}
-
-static const struct hda_pcm_stream ad198x_pcm_analog_alt_playback = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-	.ops = {
-		.open  = ad1988_alt_playback_pcm_open,
-		.close = ad1988_alt_playback_pcm_close
-	},
-};
-
 /*
  * Digital out
  */
@@ -491,7 +383,6 @@ static const struct hda_pcm_stream ad198x_pcm_analog_playback = {
 		.open = ad198x_playback_pcm_open,
 		.prepare = ad198x_playback_pcm_prepare,
 		.cleanup = ad198x_playback_pcm_cleanup,
-		.close = ad198x_playback_pcm_close
 	},
 };
 
@@ -556,43 +447,18 @@ static int ad198x_build_pcms(struct hda_codec *codec)
 		}
 	}
 
-	if (spec->alt_dac_nid && spec->stream_analog_alt_playback) {
-		codec->num_pcms++;
-		info = spec->pcm_rec + 2;
-		info->name = "AD198x Headphone";
-		info->pcm_type = HDA_PCM_TYPE_AUDIO;
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
-			*spec->stream_analog_alt_playback;
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
-			spec->alt_dac_nid[0];
-	}
-
 	return 0;
 }
 
-static void ad198x_free_kctls(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-
-	if (spec->kctls.list) {
-		struct snd_kcontrol_new *kctl = spec->kctls.list;
-		int i;
-		for (i = 0; i < spec->kctls.used; i++)
-			kfree(kctl[i].name);
-	}
-	snd_array_free(&spec->kctls);
-}
-
 static void ad198x_power_eapd_write(struct hda_codec *codec, hda_nid_t front,
 				hda_nid_t hp)
 {
-	struct ad198x_spec *spec = codec->spec;
 	if (snd_hda_query_pin_caps(codec, front) & AC_PINCAP_EAPD)
 		snd_hda_codec_write(codec, front, 0, AC_VERB_SET_EAPD_BTLENABLE,
-			    !spec->inv_eapd ? 0x00 : 0x02);
+			    !codec->inv_eapd ? 0x00 : 0x02);
 	if (snd_hda_query_pin_caps(codec, hp) & AC_PINCAP_EAPD)
 		snd_hda_codec_write(codec, hp, 0, AC_VERB_SET_EAPD_BTLENABLE,
-			    !spec->inv_eapd ? 0x00 : 0x02);
+			    !codec->inv_eapd ? 0x00 : 0x02);
 }
 
 static void ad198x_power_eapd(struct hda_codec *codec)
@@ -636,7 +502,7 @@ static void ad198x_free(struct hda_codec *codec)
 	if (!spec)
 		return;
 
-	ad198x_free_kctls(codec);
+	snd_hda_gen_spec_free(&spec->gen);
 	kfree(spec);
 	snd_hda_detach_beep_device(codec);
 }
@@ -673,7 +539,7 @@ static int ad198x_eapd_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct ad198x_spec *spec = codec->spec;
-	if (spec->inv_eapd)
+	if (codec->inv_eapd)
 		ucontrol->value.integer.value[0] = ! spec->cur_eapd;
 	else
 		ucontrol->value.integer.value[0] = spec->cur_eapd;
@@ -688,7 +554,7 @@ static int ad198x_eapd_put(struct snd_kcontrol *kcontrol,
 	hda_nid_t nid = kcontrol->private_value & 0xff;
 	unsigned int eapd;
 	eapd = !!ucontrol->value.integer.value[0];
-	if (spec->inv_eapd)
+	if (codec->inv_eapd)
 		eapd = !eapd;
 	if (eapd == spec->cur_eapd)
 		return 0;
@@ -708,6 +574,66 @@ static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
 
 
 /*
+ * Automatic parse of I/O pins from the BIOS configuration
+ */
+
+static int ad198x_auto_build_controls(struct hda_codec *codec)
+{
+	int err;
+
+	err = snd_hda_gen_build_controls(codec);
+	if (err < 0)
+		return err;
+	err = create_beep_ctls(codec);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static const struct hda_codec_ops ad198x_auto_patch_ops = {
+	.build_controls = ad198x_auto_build_controls,
+	.build_pcms = snd_hda_gen_build_pcms,
+	.init = snd_hda_gen_init,
+	.free = ad198x_free,
+#ifdef CONFIG_PM
+	.check_power_status = snd_hda_gen_check_power_status,
+	.suspend = ad198x_suspend,
+#endif
+	.reboot_notify = ad198x_shutup,
+};
+
+
+static int ad198x_parse_auto_config(struct hda_codec *codec)
+{
+	struct ad198x_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->gen.autocfg;
+	int err;
+
+	codec->spdif_status_reset = 1;
+	codec->no_trigger_sense = 1;
+	codec->no_sticky_stream = 1;
+
+	spec->gen.indep_hp = 1;
+
+	err = snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
+	if (err < 0)
+		return err;
+	err = snd_hda_gen_parse_auto_config(codec, cfg);
+	if (err < 0)
+		return err;
+
+	if (spec->beep_dev_nid) {
+		err = snd_hda_attach_beep_device(codec, spec->beep_dev_nid);
+		if (err < 0)
+			return err;
+	}
+
+	codec->patch_ops = ad198x_auto_patch_ops;
+
+	return 0;
+}
+
+/*
  * AD1986A specific
  */
 
@@ -1168,6 +1094,7 @@ static int ad1986a_samsung_p50_init(struct hda_codec *codec)
 
 /* models */
 enum {
+	AD1986A_AUTO,
 	AD1986A_6STACK,
 	AD1986A_3STACK,
 	AD1986A_LAPTOP,
@@ -1180,6 +1107,7 @@ enum {
 };
 
 static const char * const ad1986a_models[AD1986A_MODELS] = {
+	[AD1986A_AUTO]		= "auto",
 	[AD1986A_6STACK]	= "6stack",
 	[AD1986A_3STACK]	= "3stack",
 	[AD1986A_LAPTOP]	= "laptop",
@@ -1246,10 +1174,33 @@ static int alloc_ad_spec(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 	codec->spec = spec;
-	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
+	snd_hda_gen_spec_init(&spec->gen);
 	return 0;
 }
 
+/*
+ */
+static int ad1986a_parse_auto_config(struct hda_codec *codec)
+{
+	struct ad198x_spec *spec = codec->spec;
+
+	/* AD1986A has the inverted EAPD implementation */
+	codec->inv_eapd = 1;
+
+	spec->beep_dev_nid = 0x19;
+	set_beep_amp(spec, 0x18, 0, HDA_OUTPUT);
+
+	/* AD1986A has a hardware problem that it can't share a stream
+	 * with multiple output pins.  The copy of front to surrounds
+	 * causes noisy or silent outputs at a certain timing, e.g.
+	 * changing the volume.
+	 * So, let's disable the shared stream.
+	 */
+	spec->gen.multiout.no_share_stream = 1;
+
+	return ad198x_parse_auto_config(codec);
+}
+
 static int patch_ad1986a(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
@@ -1260,6 +1211,18 @@ static int patch_ad1986a(struct hda_codec *codec)
 		return err;
 	spec = codec->spec;
 
+	board_config = snd_hda_check_board_config(codec, AD1986A_MODELS,
+						  ad1986a_models,
+						  ad1986a_cfg_tbl);
+	if (board_config == AD1986A_AUTO) {
+		err = ad1986a_parse_auto_config(codec);
+		if (err < 0) {
+			ad198x_free(codec);
+			return err;
+		}
+		return 0;
+	}
+
 	err = snd_hda_attach_beep_device(codec, 0x19);
 	if (err < 0) {
 		ad198x_free(codec);
@@ -1283,14 +1246,11 @@ static int patch_ad1986a(struct hda_codec *codec)
 	spec->loopback.amplist = ad1986a_loopbacks;
 #endif
 	spec->vmaster_nid = 0x1b;
-	spec->inv_eapd = 1; /* AD1986A has the inverted EAPD implementation */
+	codec->inv_eapd = 1; /* AD1986A has the inverted EAPD implementation */
 
 	codec->patch_ops = ad198x_patch_ops;
 
 	/* override some parameters */
-	board_config = snd_hda_check_board_config(codec, AD1986A_MODELS,
-						  ad1986a_models,
-						  ad1986a_cfg_tbl);
 	switch (board_config) {
 	case AD1986A_3STACK:
 		spec->num_mixers = 2;
@@ -1546,9 +1506,31 @@ static const struct hda_amp_list ad1983_loopbacks[] = {
 };
 #endif
 
+/* models */
+enum {
+	AD1983_AUTO,
+	AD1983_BASIC,
+	AD1983_MODELS
+};
+
+static const char * const ad1983_models[AD1983_MODELS] = {
+	[AD1983_AUTO]		= "auto",
+	[AD1983_BASIC]		= "basic",
+};
+
+static int ad1983_parse_auto_config(struct hda_codec *codec)
+{
+	struct ad198x_spec *spec = codec->spec;
+
+	spec->beep_dev_nid = 0x10;
+	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
+	return ad198x_parse_auto_config(codec);
+}
+
 static int patch_ad1983(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
+	int board_config;
 	int err;
 
 	err = alloc_ad_spec(codec);
@@ -1556,6 +1538,17 @@ static int patch_ad1983(struct hda_codec *codec)
 		return err;
 	spec = codec->spec;
 
+	board_config = snd_hda_check_board_config(codec, AD1983_MODELS,
+						  ad1983_models, NULL);
+	if (board_config == AD1983_AUTO) {
+		err = ad1983_parse_auto_config(codec);
+		if (err < 0) {
+			ad198x_free(codec);
+			return err;
+		}
+		return 0;
+	}
+
 	err = snd_hda_attach_beep_device(codec, 0x10);
 	if (err < 0) {
 		ad198x_free(codec);
@@ -1924,6 +1917,7 @@ static const struct hda_input_mux ad1981_thinkpad_capture_source = {
 
 /* models */
 enum {
+	AD1981_AUTO,
 	AD1981_BASIC,
 	AD1981_HP,
 	AD1981_THINKPAD,
@@ -1932,6 +1926,7 @@ enum {
 };
 
 static const char * const ad1981_models[AD1981_MODELS] = {
+	[AD1981_AUTO]		= "auto",
 	[AD1981_HP]		= "hp",
 	[AD1981_THINKPAD]	= "thinkpad",
 	[AD1981_BASIC]		= "basic",
@@ -1951,6 +1946,15 @@ static const struct snd_pci_quirk ad1981_cfg_tbl[] = {
 	{}
 };
 
+static int ad1981_parse_auto_config(struct hda_codec *codec)
+{
+	struct ad198x_spec *spec = codec->spec;
+
+	spec->beep_dev_nid = 0x10;
+	set_beep_amp(spec, 0x0d, 0, HDA_OUTPUT);
+	return ad198x_parse_auto_config(codec);
+}
+
 static int patch_ad1981(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
@@ -1961,6 +1965,18 @@ static int patch_ad1981(struct hda_codec *codec)
 		return -ENOMEM;
 	spec = codec->spec;
 
+	board_config = snd_hda_check_board_config(codec, AD1981_MODELS,
+						  ad1981_models,
+						  ad1981_cfg_tbl);
+	if (board_config == AD1981_AUTO) {
+		err = ad1981_parse_auto_config(codec);
+		if (err < 0) {
+			ad198x_free(codec);
+			return err;
+		}
+		return 0;
+	}
+
 	err = snd_hda_attach_beep_device(codec, 0x10);
 	if (err < 0) {
 		ad198x_free(codec);
@@ -1989,9 +2005,6 @@ static int patch_ad1981(struct hda_codec *codec)
 	codec->patch_ops = ad198x_patch_ops;
 
 	/* override some parameters */
-	board_config = snd_hda_check_board_config(codec, AD1981_MODELS,
-						  ad1981_models,
-						  ad1981_cfg_tbl);
 	switch (board_config) {
 	case AD1981_HP:
 		spec->mixers[0] = ad1981_hp_mixers;
@@ -2131,13 +2144,13 @@ static int patch_ad1981(struct hda_codec *codec)
 
 /* models */
 enum {
+	AD1988_AUTO,
 	AD1988_6STACK,
 	AD1988_6STACK_DIG,
 	AD1988_3STACK,
 	AD1988_3STACK_DIG,
 	AD1988_LAPTOP,
 	AD1988_LAPTOP_DIG,
-	AD1988_AUTO,
 	AD1988_MODEL_LAST,
 };
 
@@ -2242,17 +2255,6 @@ static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
 	return err;
 }
 
-static const struct snd_kcontrol_new ad1988_hp_mixers[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Independent HP",
-		.info = ad1988_independent_hp_info,
-		.get = ad1988_independent_hp_get,
-		.put = ad1988_independent_hp_put,
-	},
-	{ } /* end */
-};
-
 /* 6-stack mode */
 static const struct snd_kcontrol_new ad1988_6stack_mixers1[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x04, 0x0, HDA_OUTPUT),
@@ -2817,414 +2819,15 @@ static const struct hda_amp_list ad1988_loopbacks[] = {
 #endif
 
 /*
- * Automatic parse of I/O pins from the BIOS configuration
  */
 
-enum {
-	AD_CTL_WIDGET_VOL,
-	AD_CTL_WIDGET_MUTE,
-	AD_CTL_BIND_MUTE,
-};
-static const struct snd_kcontrol_new ad1988_control_templates[] = {
-	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
-	HDA_CODEC_MUTE(NULL, 0, 0, 0),
-	HDA_BIND_MUTE(NULL, 0, 0, 0),
-};
-
-/* add dynamic controls */
-static int add_control(struct ad198x_spec *spec, int type, const char *name,
-		       unsigned long val)
-{
-	struct snd_kcontrol_new *knew;
-
-	knew = snd_array_new(&spec->kctls);
-	if (!knew)
-		return -ENOMEM;
-	*knew = ad1988_control_templates[type];
-	knew->name = kstrdup(name, GFP_KERNEL);
-	if (! knew->name)
-		return -ENOMEM;
-	if (get_amp_nid_(val))
-		knew->subdevice = HDA_SUBDEV_AMP_FLAG;
-	knew->private_value = val;
-	return 0;
-}
-
-#define AD1988_PIN_CD_NID		0x18
-#define AD1988_PIN_BEEP_NID		0x10
-
-static const hda_nid_t ad1988_mixer_nids[8] = {
-	/* A     B     C     D     E     F     G     H */
-	0x22, 0x2b, 0x2c, 0x29, 0x26, 0x2a, 0x27, 0x28
-};
-
-static inline hda_nid_t ad1988_idx_to_dac(struct hda_codec *codec, int idx)
-{
-	static const hda_nid_t idx_to_dac[8] = {
-		/* A     B     C     D     E     F     G     H */
-		0x03, 0x06, 0x05, 0x04, 0x0a, 0x06, 0x05, 0x0a
-	};
-	static const hda_nid_t idx_to_dac_rev2[8] = {
-		/* A     B     C     D     E     F     G     H */
-		0x03, 0x05, 0x0a, 0x04, 0x06, 0x05, 0x0a, 0x06
-	};
-	if (is_rev2(codec))
-		return idx_to_dac_rev2[idx];
-	else
-		return idx_to_dac[idx];
-}
-
-static const hda_nid_t ad1988_boost_nids[8] = {
-	0x38, 0x39, 0x3a, 0x3d, 0x3c, 0x3b, 0, 0
-};
-
-static int ad1988_pin_idx(hda_nid_t nid)
-{
-	static const hda_nid_t ad1988_io_pins[8] = {
-		0x11, 0x14, 0x15, 0x12, 0x17, 0x16, 0x24, 0x25
-	};
-	int i;
-	for (i = 0; i < ARRAY_SIZE(ad1988_io_pins); i++)
-		if (ad1988_io_pins[i] == nid)
-			return i;
-	return 0; /* should be -1 */
-}
-
-static int ad1988_pin_to_loopback_idx(hda_nid_t nid)
-{
-	static const int loopback_idx[8] = {
-		2, 0, 1, 3, 4, 5, 1, 4
-	};
-	switch (nid) {
-	case AD1988_PIN_CD_NID:
-		return 6;
-	default:
-		return loopback_idx[ad1988_pin_idx(nid)];
-	}
-}
-
-static int ad1988_pin_to_adc_idx(hda_nid_t nid)
-{
-	static const int adc_idx[8] = {
-		0, 1, 2, 8, 4, 3, 6, 7
-	};
-	switch (nid) {
-	case AD1988_PIN_CD_NID:
-		return 5;
-	default:
-		return adc_idx[ad1988_pin_idx(nid)];
-	}
-}
-
-/* fill in the dac_nids table from the parsed pin configuration */
-static int ad1988_auto_fill_dac_nids(struct hda_codec *codec,
-				     const struct auto_pin_cfg *cfg)
-{
-	struct ad198x_spec *spec = codec->spec;
-	int i, idx;
-
-	spec->multiout.dac_nids = spec->private_dac_nids;
-
-	/* check the pins hardwired to audio widget */
-	for (i = 0; i < cfg->line_outs; i++) {
-		idx = ad1988_pin_idx(cfg->line_out_pins[i]);
-		spec->private_dac_nids[i] = ad1988_idx_to_dac(codec, idx);
-	}
-	spec->multiout.num_dacs = cfg->line_outs;
-	return 0;
-}
-
-/* add playback controls from the parsed DAC table */
-static int ad1988_auto_create_multi_out_ctls(struct ad198x_spec *spec,
-					     const struct auto_pin_cfg *cfg)
-{
-	char name[32];
-	static const char * const chname[4] = {
-		"Front", "Surround", NULL /*CLFE*/, "Side"
-	};
-	hda_nid_t nid;
-	int i, err;
-
-	for (i = 0; i < cfg->line_outs; i++) {
-		hda_nid_t dac = spec->multiout.dac_nids[i];
-		if (! dac)
-			continue;
-		nid = ad1988_mixer_nids[ad1988_pin_idx(cfg->line_out_pins[i])];
-		if (i == 2) {
-			/* Center/LFE */
-			err = add_control(spec, AD_CTL_WIDGET_VOL,
-					  "Center Playback Volume",
-					  HDA_COMPOSE_AMP_VAL(dac, 1, 0, HDA_OUTPUT));
-			if (err < 0)
-				return err;
-			err = add_control(spec, AD_CTL_WIDGET_VOL,
-					  "LFE Playback Volume",
-					  HDA_COMPOSE_AMP_VAL(dac, 2, 0, HDA_OUTPUT));
-			if (err < 0)
-				return err;
-			err = add_control(spec, AD_CTL_BIND_MUTE,
-					  "Center Playback Switch",
-					  HDA_COMPOSE_AMP_VAL(nid, 1, 2, HDA_INPUT));
-			if (err < 0)
-				return err;
-			err = add_control(spec, AD_CTL_BIND_MUTE,
-					  "LFE Playback Switch",
-					  HDA_COMPOSE_AMP_VAL(nid, 2, 2, HDA_INPUT));
-			if (err < 0)
-				return err;
-		} else {
-			sprintf(name, "%s Playback Volume", chname[i]);
-			err = add_control(spec, AD_CTL_WIDGET_VOL, name,
-					  HDA_COMPOSE_AMP_VAL(dac, 3, 0, HDA_OUTPUT));
-			if (err < 0)
-				return err;
-			sprintf(name, "%s Playback Switch", chname[i]);
-			err = add_control(spec, AD_CTL_BIND_MUTE, name,
-					  HDA_COMPOSE_AMP_VAL(nid, 3, 2, HDA_INPUT));
-			if (err < 0)
-				return err;
-		}
-	}
-	return 0;
-}
-
-/* add playback controls for speaker and HP outputs */
-static int ad1988_auto_create_extra_out(struct hda_codec *codec, hda_nid_t pin,
-					const char *pfx)
-{
-	struct ad198x_spec *spec = codec->spec;
-	hda_nid_t nid;
-	int i, idx, err;
-	char name[32];
-
-	if (! pin)
-		return 0;
-
-	idx = ad1988_pin_idx(pin);
-	nid = ad1988_idx_to_dac(codec, idx);
-	/* check whether the corresponding DAC was already taken */
-	for (i = 0; i < spec->autocfg.line_outs; i++) {
-		hda_nid_t pin = spec->autocfg.line_out_pins[i];
-		hda_nid_t dac = ad1988_idx_to_dac(codec, ad1988_pin_idx(pin));
-		if (dac == nid)
-			break;
-	}
-	if (i >= spec->autocfg.line_outs) {
-		/* specify the DAC as the extra output */
-		if (!spec->multiout.hp_nid)
-			spec->multiout.hp_nid = nid;
-		else
-			spec->multiout.extra_out_nid[0] = nid;
-		/* control HP volume/switch on the output mixer amp */
-		sprintf(name, "%s Playback Volume", pfx);
-		err = add_control(spec, AD_CTL_WIDGET_VOL, name,
-				  HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT));
-		if (err < 0)
-			return err;
-	}
-	nid = ad1988_mixer_nids[idx];
-	sprintf(name, "%s Playback Switch", pfx);
-	if ((err = add_control(spec, AD_CTL_BIND_MUTE, name,
-			       HDA_COMPOSE_AMP_VAL(nid, 3, 2, HDA_INPUT))) < 0)
-		return err;
-	return 0;
-}
-
-/* create input playback/capture controls for the given pin */
-static int new_analog_input(struct ad198x_spec *spec, hda_nid_t pin,
-			    const char *ctlname, int ctlidx, int boost)
-{
-	char name[32];
-	int err, idx;
-
-	sprintf(name, "%s Playback Volume", ctlname);
-	idx = ad1988_pin_to_loopback_idx(pin);
-	if ((err = add_control(spec, AD_CTL_WIDGET_VOL, name,
-			       HDA_COMPOSE_AMP_VAL(0x20, 3, idx, HDA_INPUT))) < 0)
-		return err;
-	sprintf(name, "%s Playback Switch", ctlname);
-	if ((err = add_control(spec, AD_CTL_WIDGET_MUTE, name,
-			       HDA_COMPOSE_AMP_VAL(0x20, 3, idx, HDA_INPUT))) < 0)
-		return err;
-	if (boost) {
-		hda_nid_t bnid;
-		idx = ad1988_pin_idx(pin);
-		bnid = ad1988_boost_nids[idx];
-		if (bnid) {
-			sprintf(name, "%s Boost Volume", ctlname);
-			return add_control(spec, AD_CTL_WIDGET_VOL, name,
-					   HDA_COMPOSE_AMP_VAL(bnid, 3, idx, HDA_OUTPUT));
-
-		}
-	}
-	return 0;
-}
-
-/* create playback/capture controls for input pins */
-static int ad1988_auto_create_analog_input_ctls(struct hda_codec *codec,
-						const struct auto_pin_cfg *cfg)
-{
-	struct ad198x_spec *spec = codec->spec;
-	struct hda_input_mux *imux = &spec->private_imux;
-	int i, err, type, type_idx;
-
-	for (i = 0; i < cfg->num_inputs; i++) {
-		const char *label;
-		type = cfg->inputs[i].type;
-		label = hda_get_autocfg_input_label(codec, cfg, i);
-		snd_hda_add_imux_item(imux, label,
-				      ad1988_pin_to_adc_idx(cfg->inputs[i].pin),
-				      &type_idx);
-		err = new_analog_input(spec, cfg->inputs[i].pin,
-				       label, type_idx,
-				       type == AUTO_PIN_MIC);
-		if (err < 0)
-			return err;
-	}
-	snd_hda_add_imux_item(imux, "Mix", 9, NULL);
-
-	if ((err = add_control(spec, AD_CTL_WIDGET_VOL,
-			       "Analog Mix Playback Volume",
-			       HDA_COMPOSE_AMP_VAL(0x21, 3, 0x0, HDA_OUTPUT))) < 0)
-		return err;
-	if ((err = add_control(spec, AD_CTL_WIDGET_MUTE,
-			       "Analog Mix Playback Switch",
-			       HDA_COMPOSE_AMP_VAL(0x21, 3, 0x0, HDA_OUTPUT))) < 0)
-		return err;
-
-	return 0;
-}
-
-static void ad1988_auto_set_output_and_unmute(struct hda_codec *codec,
-					      hda_nid_t nid, int pin_type,
-					      int dac_idx)
-{
-	/* set as output */
-	snd_hda_set_pin_ctl(codec, nid, pin_type);
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
-	switch (nid) {
-	case 0x11: /* port-A - DAC 03 */
-		snd_hda_codec_write(codec, 0x37, 0, AC_VERB_SET_CONNECT_SEL, 0x00);
-		break;
-	case 0x14: /* port-B - DAC 06 */
-		snd_hda_codec_write(codec, 0x30, 0, AC_VERB_SET_CONNECT_SEL, 0x02);
-		break;
-	case 0x15: /* port-C - DAC 05 */
-		snd_hda_codec_write(codec, 0x31, 0, AC_VERB_SET_CONNECT_SEL, 0x00);
-		break;
-	case 0x17: /* port-E - DAC 0a */
-		snd_hda_codec_write(codec, 0x32, 0, AC_VERB_SET_CONNECT_SEL, 0x01);
-		break;
-	case 0x13: /* mono - DAC 04 */
-		snd_hda_codec_write(codec, 0x36, 0, AC_VERB_SET_CONNECT_SEL, 0x01);
-		break;
-	}
-}
-
-static void ad1988_auto_init_multi_out(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-	int i;
-
-	for (i = 0; i < spec->autocfg.line_outs; i++) {
-		hda_nid_t nid = spec->autocfg.line_out_pins[i];
-		ad1988_auto_set_output_and_unmute(codec, nid, PIN_OUT, i);
-	}
-}
-
-static void ad1988_auto_init_extra_out(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-	hda_nid_t pin;
-
-	pin = spec->autocfg.speaker_pins[0];
-	if (pin) /* connect to front */
-		ad1988_auto_set_output_and_unmute(codec, pin, PIN_OUT, 0);
-	pin = spec->autocfg.hp_pins[0];
-	if (pin) /* connect to front */
-		ad1988_auto_set_output_and_unmute(codec, pin, PIN_HP, 0);
-}
-
-static void ad1988_auto_init_analog_input(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-	const struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i, idx;
-
-	for (i = 0; i < cfg->num_inputs; i++) {
-		hda_nid_t nid = cfg->inputs[i].pin;
-		int type = cfg->inputs[i].type;
-		int val;
-		switch (nid) {
-		case 0x15: /* port-C */
-			snd_hda_codec_write(codec, 0x33, 0, AC_VERB_SET_CONNECT_SEL, 0x0);
-			break;
-		case 0x17: /* port-E */
-			snd_hda_codec_write(codec, 0x34, 0, AC_VERB_SET_CONNECT_SEL, 0x0);
-			break;
-		}
-		val = PIN_IN;
-		if (type == AUTO_PIN_MIC)
-			val |= snd_hda_get_default_vref(codec, nid);
-		snd_hda_set_pin_ctl(codec, nid, val);
-		if (nid != AD1988_PIN_CD_NID)
-			snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_OUT_MUTE);
-		idx = ad1988_pin_idx(nid);
-		if (ad1988_boost_nids[idx])
-			snd_hda_codec_write(codec, ad1988_boost_nids[idx], 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_OUT_ZERO);
-	}
-}
-
-/* parse the BIOS configuration and set up the alc_spec */
-/* return 1 if successful, 0 if the proper config is not found, or a negative error code */
 static int ad1988_parse_auto_config(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec = codec->spec;
-	int err;
-
-	if ((err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL)) < 0)
-		return err;
-	if ((err = ad1988_auto_fill_dac_nids(codec, &spec->autocfg)) < 0)
-		return err;
-	if (! spec->autocfg.line_outs)
-		return 0; /* can't find valid BIOS pin config */
-	if ((err = ad1988_auto_create_multi_out_ctls(spec, &spec->autocfg)) < 0 ||
-	    (err = ad1988_auto_create_extra_out(codec,
-						spec->autocfg.speaker_pins[0],
-						"Speaker")) < 0 ||
-	    (err = ad1988_auto_create_extra_out(codec, spec->autocfg.hp_pins[0],
-						"Headphone")) < 0 ||
-	    (err = ad1988_auto_create_analog_input_ctls(codec, &spec->autocfg)) < 0)
-		return err;
-
-	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
-
-	if (spec->autocfg.dig_outs)
-		spec->multiout.dig_out_nid = AD1988_SPDIF_OUT;
-	if (spec->autocfg.dig_in_pin)
-		spec->dig_in_nid = AD1988_SPDIF_IN;
-
-	if (spec->kctls.list)
-		spec->mixers[spec->num_mixers++] = spec->kctls.list;
-
-	spec->init_verbs[spec->num_init_verbs++] = ad1988_6stack_init_verbs;
-
-	spec->input_mux = &spec->private_imux;
 
-	return 1;
-}
-
-/* init callback for auto-configuration model -- overriding the default init */
-static int ad1988_auto_init(struct hda_codec *codec)
-{
-	ad198x_init(codec);
-	ad1988_auto_init_multi_out(codec);
-	ad1988_auto_init_extra_out(codec);
-	ad1988_auto_init_analog_input(codec);
-	return 0;
+	spec->beep_dev_nid = 0x10;
+	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
+	return ad198x_parse_auto_config(codec);
 }
 
 /*
@@ -3259,9 +2862,6 @@ static int patch_ad1988(struct hda_codec *codec)
 		return err;
 	spec = codec->spec;
 
-	if (is_rev2(codec))
-		snd_printk(KERN_INFO "patch_analog: AD1988A rev.2 is detected, enable workarounds\n");
-
 	board_config = snd_hda_check_board_config(codec, AD1988_MODEL_LAST,
 						  ad1988_models, ad1988_cfg_tbl);
 	if (board_config < 0) {
@@ -3276,12 +2876,13 @@ static int patch_ad1988(struct hda_codec *codec)
 		if (err < 0) {
 			ad198x_free(codec);
 			return err;
-		} else if (! err) {
-			printk(KERN_INFO "hda_codec: Cannot set up configuration from BIOS.  Using 6-stack mode...\n");
-			board_config = AD1988_6STACK;
 		}
+		return 0;
 	}
 
+	if (is_rev2(codec))
+		snd_printk(KERN_INFO "patch_analog: AD1988A rev.2 is detected, enable workarounds\n");
+
 	err = snd_hda_attach_beep_device(codec, 0x10);
 	if (err < 0) {
 		ad198x_free(codec);
@@ -3344,7 +2945,7 @@ static int patch_ad1988(struct hda_codec *codec)
 		spec->input_mux = &ad1988_laptop_capture_source;
 		spec->num_mixers = 1;
 		spec->mixers[0] = ad1988_laptop_mixers;
-		spec->inv_eapd = 1; /* inverted EAPD */
+		codec->inv_eapd = 1; /* inverted EAPD */
 		spec->num_init_verbs = 1;
 		spec->init_verbs[0] = ad1988_laptop_init_verbs;
 		if (board_config == AD1988_LAPTOP_DIG)
@@ -3352,15 +2953,6 @@ static int patch_ad1988(struct hda_codec *codec)
 		break;
 	}
 
-	if (spec->autocfg.hp_pins[0]) {
-		spec->mixers[spec->num_mixers++] = ad1988_hp_mixers;
-		spec->slave_vols = ad1988_6stack_fp_slave_pfxs;
-		spec->slave_sws = ad1988_6stack_fp_slave_pfxs;
-		spec->alt_dac_nid = ad1988_alt_dac_nid;
-		spec->stream_analog_alt_playback =
-			&ad198x_pcm_analog_alt_playback;
-	}
-
 	spec->num_adc_nids = ARRAY_SIZE(ad1988_adc_nids);
 	spec->adc_nids = ad1988_adc_nids;
 	spec->capsrc_nids = ad1988_capsrc_nids;
@@ -3388,9 +2980,6 @@ static int patch_ad1988(struct hda_codec *codec)
 
 	codec->patch_ops = ad198x_patch_ops;
 	switch (board_config) {
-	case AD1988_AUTO:
-		codec->patch_ops.init = ad1988_auto_init;
-		break;
 	case AD1988_LAPTOP:
 	case AD1988_LAPTOP_DIG:
 		codec->patch_ops.unsol_event = ad1988_laptop_unsol_event;
@@ -3568,7 +3157,43 @@ static const char * const ad1884_slave_vols[] = {
 	NULL
 };
 
-static int patch_ad1884(struct hda_codec *codec)
+enum {
+	AD1884_AUTO,
+	AD1884_BASIC,
+	AD1884_MODELS
+};
+
+static const char * const ad1884_models[AD1884_MODELS] = {
+	[AD1884_AUTO]		= "auto",
+	[AD1884_BASIC]		= "basic",
+};
+
+static int ad1884_parse_auto_config(struct hda_codec *codec)
+{
+	struct ad198x_spec *spec = codec->spec;
+
+	spec->beep_dev_nid = 0x10;
+	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
+	return ad198x_parse_auto_config(codec);
+}
+
+static int patch_ad1884_auto(struct hda_codec *codec)
+{
+	int err;
+
+	err = alloc_ad_spec(codec);
+	if (err < 0)
+		return err;
+
+	err = ad1884_parse_auto_config(codec);
+	if (err < 0) {
+		ad198x_free(codec);
+		return err;
+	}
+	return 0;
+}
+
+static int patch_ad1884_basic(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
 	int err;
@@ -3615,6 +3240,18 @@ static int patch_ad1884(struct hda_codec *codec)
 	return 0;
 }
 
+static int patch_ad1884(struct hda_codec *codec)
+{
+	int board_config;
+
+	board_config = snd_hda_check_board_config(codec, AD1884_MODELS,
+						  ad1884_models, NULL);
+	if (board_config == AD1884_AUTO)
+		return patch_ad1884_auto(codec);
+	else
+		return patch_ad1884_basic(codec);
+}
+
 /*
  * Lenovo Thinkpad T61/X61
  */
@@ -3787,6 +3424,7 @@ static int ad1984_build_pcms(struct hda_codec *codec)
 
 /* models */
 enum {
+	AD1984_AUTO,
 	AD1984_BASIC,
 	AD1984_THINKPAD,
 	AD1984_DELL_DESKTOP,
@@ -3794,6 +3432,7 @@ enum {
 };
 
 static const char * const ad1984_models[AD1984_MODELS] = {
+	[AD1984_AUTO]		= "auto",
 	[AD1984_BASIC]		= "basic",
 	[AD1984_THINKPAD]	= "thinkpad",
 	[AD1984_DELL_DESKTOP]	= "dell_desktop",
@@ -3812,12 +3451,16 @@ static int patch_ad1984(struct hda_codec *codec)
 	struct ad198x_spec *spec;
 	int board_config, err;
 
-	err = patch_ad1884(codec);
+	board_config = snd_hda_check_board_config(codec, AD1984_MODELS,
+						  ad1984_models, ad1984_cfg_tbl);
+	if (board_config == AD1984_AUTO)
+		return patch_ad1884_auto(codec);
+
+	err = patch_ad1884_basic(codec);
 	if (err < 0)
 		return err;
 	spec = codec->spec;
-	board_config = snd_hda_check_board_config(codec, AD1984_MODELS,
-						  ad1984_models, ad1984_cfg_tbl);
+
 	switch (board_config) {
 	case AD1984_BASIC:
 		/* additional digital mics */
@@ -4534,6 +4177,7 @@ static int ad1984a_touchsmart_init(struct hda_codec *codec)
  */
 
 enum {
+	AD1884A_AUTO,
 	AD1884A_DESKTOP,
 	AD1884A_LAPTOP,
 	AD1884A_MOBILE,
@@ -4544,6 +4188,7 @@ enum {
 };
 
 static const char * const ad1884a_models[AD1884A_MODELS] = {
+	[AD1884A_AUTO]		= "auto",
 	[AD1884A_DESKTOP]	= "desktop",
 	[AD1884A_LAPTOP]	= "laptop",
 	[AD1884A_MOBILE]	= "mobile",
@@ -4572,6 +4217,12 @@ static int patch_ad1884a(struct hda_codec *codec)
 	struct ad198x_spec *spec;
 	int err, board_config;
 
+	board_config = snd_hda_check_board_config(codec, AD1884A_MODELS,
+						  ad1884a_models,
+						  ad1884a_cfg_tbl);
+	if (board_config == AD1884_AUTO)
+		return patch_ad1884_auto(codec);
+
 	err = alloc_ad_spec(codec);
 	if (err < 0)
 		return err;
@@ -4603,9 +4254,6 @@ static int patch_ad1884a(struct hda_codec *codec)
 	codec->patch_ops = ad198x_patch_ops;
 
 	/* override some parameters */
-	board_config = snd_hda_check_board_config(codec, AD1884A_MODELS,
-						  ad1884a_models,
-						  ad1884a_cfg_tbl);
 	switch (board_config) {
 	case AD1884A_LAPTOP:
 		spec->mixers[0] = ad1884a_laptop_mixers;
@@ -4966,6 +4614,7 @@ static const struct hda_amp_list ad1882_loopbacks[] = {
 
 /* models */
 enum {
+	AD1882_AUTO,
 	AD1882_3STACK,
 	AD1882_6STACK,
 	AD1882_3STACK_AUTOMUTE,
@@ -4973,11 +4622,20 @@ enum {
 };
 
 static const char * const ad1882_models[AD1986A_MODELS] = {
+	[AD1882_AUTO]		= "auto",
 	[AD1882_3STACK]		= "3stack",
 	[AD1882_6STACK]		= "6stack",
 	[AD1882_3STACK_AUTOMUTE] = "3stack-automute",
 };
 
+static int ad1882_parse_auto_config(struct hda_codec *codec)
+{
+	struct ad198x_spec *spec = codec->spec;
+
+	spec->beep_dev_nid = 0x10;
+	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
+	return ad198x_parse_auto_config(codec);
+}
 
 static int patch_ad1882(struct hda_codec *codec)
 {
@@ -4989,6 +4647,17 @@ static int patch_ad1882(struct hda_codec *codec)
 		return err;
 	spec = codec->spec;
 
+	board_config = snd_hda_check_board_config(codec, AD1882_MODELS,
+						  ad1882_models, NULL);
+	if (board_config == AD1882_AUTO) {
+		err = ad1882_parse_auto_config(codec);
+		if (err < 0) {
+			ad198x_free(codec);
+			return err;
+		}
+		return 0;
+	}
+
 	err = snd_hda_attach_beep_device(codec, 0x10);
 	if (err < 0) {
 		ad198x_free(codec);
@@ -5024,8 +4693,6 @@ static int patch_ad1882(struct hda_codec *codec)
 	codec->patch_ops = ad198x_patch_ops;
 
 	/* override some parameters */
-	board_config = snd_hda_check_board_config(codec, AD1882_MODELS,
-						  ad1882_models, NULL);
 	switch (board_config) {
 	default:
 	case AD1882_3STACK:
-- 
1.8.0.1
