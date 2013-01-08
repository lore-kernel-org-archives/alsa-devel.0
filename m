From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/8] ALSA: hda - Use generic parser in Conexant
	codec driver
Date: Tue,  8 Jan 2013 12:50:46 +0100
Message-ID: <1357645849-8181-6-git-send-email-tiwai@suse.de>
References: <1357645849-8181-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DDB2265F7F
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 6EBAAA50DD
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

... and drop most of own parser code.

It doesn't replace any present static quirks, though.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig          |    1 +
 sound/pci/hda/patch_conexant.c | 1318 ++--------------------------------------
 2 files changed, 62 insertions(+), 1257 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 07025a9..206f678 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -162,6 +162,7 @@ config SND_HDA_CODEC_CIRRUS
 config SND_HDA_CODEC_CONEXANT
 	bool "Build Conexant HD-audio codec support"
 	default y
+	select SND_HDA_GENERIC
 	help
 	  Say Y here to include Conexant HD-audio codec support in
 	  snd-hda-intel driver, such as CX20549.
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 727e678..f27125b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -33,6 +33,7 @@
 #include "hda_auto_parser.h"
 #include "hda_beep.h"
 #include "hda_jack.h"
+#include "hda_generic.h"
 
 #define CXT_PIN_DIR_IN              0x00
 #define CXT_PIN_DIR_OUT             0x01
@@ -53,25 +54,12 @@
 #define AUTO_MIC_PORTB		(1 << 1)
 #define AUTO_MIC_PORTC		(1 << 2)
 
-struct pin_dac_pair {
-	hda_nid_t pin;
-	hda_nid_t dac;
-	int type;
-};
-
-struct imux_info {
-	hda_nid_t pin;		/* input pin NID */
-	hda_nid_t adc;		/* connected ADC NID */	
-	hda_nid_t boost;	/* optional boost volume NID */
-	int index;		/* corresponding to autocfg.input */
-};
-
 struct conexant_spec {
+	struct hda_gen_spec gen;
+
 	const struct snd_kcontrol_new *mixers[5];
 	int num_mixers;
 	hda_nid_t vmaster_nid;
-	struct hda_vmaster_mute_hook vmaster_mute;
-	bool vmaster_mute_led;
 
 	const struct hda_verb *init_verbs[5];	/* initialization verbs
 						 * don't forget NULL
@@ -88,11 +76,6 @@ struct conexant_spec {
 	unsigned int hp_present;
 	unsigned int line_present;
 	unsigned int auto_mic;
-	int auto_mic_ext;		/* imux_pins[] index for ext mic */
-	int auto_mic_dock;		/* imux_pins[] index for dock mic */
-	int auto_mic_int;		/* imux_pins[] index for int mic */
-	unsigned int need_dac_fix;
-	hda_nid_t slave_dig_outs[2];
 
 	/* capture */
 	unsigned int num_adc_nids;
@@ -120,30 +103,13 @@ struct conexant_spec {
 
 	unsigned int spdif_route;
 
-	/* dynamic controls, init_verbs and input_mux */
-	struct auto_pin_cfg autocfg;
-	struct hda_input_mux private_imux;
-	struct imux_info imux_info[HDA_MAX_NUM_INPUTS];
-	hda_nid_t private_adc_nids[HDA_MAX_NUM_INPUTS];
-	hda_nid_t private_dac_nids[AUTO_CFG_MAX_OUTS];
-	struct pin_dac_pair dac_info[8];
-	int dac_info_filled;
-
 	unsigned int port_d_mode;
-	unsigned int auto_mute:1;	/* used in auto-parser */
-	unsigned int detect_line:1;	/* Line-out detection enabled */
-	unsigned int automute_lines:1;	/* automute line-out as well */
-	unsigned int automute_hp_lo:1;	/* both HP and LO available */
 	unsigned int dell_automute:1;
 	unsigned int dell_vostro:1;
 	unsigned int ideapad:1;
 	unsigned int thinkpad:1;
 	unsigned int hp_laptop:1;
 	unsigned int asus:1;
-	unsigned int pin_eapd_ctrls:1;
-	unsigned int fixup_stereo_dmic:1;
-
-	unsigned int adc_switching:1;
 
 	unsigned int ext_mic_present;
 	unsigned int recording;
@@ -335,8 +301,6 @@ static const struct hda_pcm_stream cx5051_pcm_analog_capture = {
 	},
 };
 
-static bool is_2_1_speaker(struct conexant_spec *spec);
-
 static int conexant_build_pcms(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
@@ -351,9 +315,6 @@ static int conexant_build_pcms(struct hda_codec *codec)
 		spec->multiout.max_channels;
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
 		spec->multiout.dac_nids[0];
-	if (is_2_1_speaker(spec))
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK].chmap =
-			snd_pcm_2_1_chmaps;
 	if (spec->capture_stream)
 		info->stream[SNDRV_PCM_STREAM_CAPTURE] = *spec->capture_stream;
 	else {
@@ -384,8 +345,6 @@ static int conexant_build_pcms(struct hda_codec *codec)
 			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid =
 				spec->dig_in_nid;
 		}
-		if (spec->slave_dig_outs[0])
-			codec->slave_dig_outs = spec->slave_dig_outs;
 	}
 
 	return 0;
@@ -471,6 +430,29 @@ static const struct snd_kcontrol_new cxt_beep_mixer[] = {
 	HDA_CODEC_MUTE_BEEP_MONO("Beep Playback Switch", 0, 1, 0, HDA_OUTPUT),
 	{ } /* end */
 };
+/* create beep controls if needed */
+static int add_beep_ctls(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+	int err;
+
+	if (spec->beep_amp) {
+		const struct snd_kcontrol_new *knew;
+		for (knew = cxt_beep_mixer; knew->name; knew++) {
+			struct snd_kcontrol *kctl;
+			kctl = snd_ctl_new1(knew, codec);
+			if (!kctl)
+				return -ENOMEM;
+			kctl->private_value = spec->beep_amp;
+			err = snd_hda_ctl_add(codec, 0, kctl);
+			if (err < 0)
+				return err;
+		}
+	}
+	return 0;
+}
+#else
+#define add_beep_ctls(codec)	0
 #endif
 
 static const char * const slave_pfxs[] = {
@@ -521,10 +503,9 @@ static int conexant_build_controls(struct hda_codec *codec)
 	}
 	if (spec->vmaster_nid &&
 	    !snd_hda_find_mixer_ctl(codec, "Master Playback Switch")) {
-		err = __snd_hda_add_vmaster(codec, "Master Playback Switch",
-					    NULL, slave_pfxs,
-					    "Playback Switch", true,
-					    &spec->vmaster_mute.sw_kctl);
+		err = snd_hda_add_vmaster(codec, "Master Playback Switch",
+					  NULL, slave_pfxs,
+					  "Playback Switch");
 		if (err < 0)
 			return err;
 	}
@@ -535,22 +516,9 @@ static int conexant_build_controls(struct hda_codec *codec)
 			return err;
 	}
 
-#ifdef CONFIG_SND_HDA_INPUT_BEEP
-	/* create beep controls if needed */
-	if (spec->beep_amp) {
-		const struct snd_kcontrol_new *knew;
-		for (knew = cxt_beep_mixer; knew->name; knew++) {
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
+	err = add_beep_ctls(codec);
+	if (err < 0)
+		return err;
 
 	return 0;
 }
@@ -665,8 +633,6 @@ static int conexant_ch_mode_put(struct snd_kcontrol *kcontrol,
 	int err = snd_hda_ch_mode_put(codec, ucontrol, spec->channel_mode,
 				      spec->num_channel_mode,
 				      &spec->multiout.max_channels);
-	if (err >= 0 && spec->need_dac_fix)
-		spec->multiout.num_dacs = spec->multiout.max_channels / 2;
 	return err;
 }
 
@@ -2505,10 +2471,6 @@ static void conexant_check_dig_outs(struct hda_codec *codec,
 			continue;
 		if (snd_hda_get_connections(codec, *dig_pins, nid_loc, 1) != 1)
 			continue;
-		if (spec->slave_dig_outs[0])
-			nid_loc++;
-		else
-			nid_loc = spec->slave_dig_outs;
 	}
 }
 
@@ -3154,623 +3116,6 @@ static int patch_cxt5066(struct hda_codec *codec)
  * Automatic parser for CX20641 & co
  */
 
-static int cx_auto_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
-				       struct hda_codec *codec,
-				       unsigned int stream_tag,
-				       unsigned int format,
-				       struct snd_pcm_substream *substream)
-{
-	struct conexant_spec *spec = codec->spec;
-	hda_nid_t adc = spec->imux_info[spec->cur_mux[0]].adc;
-	if (spec->adc_switching) {
-		spec->cur_adc = adc;
-		spec->cur_adc_stream_tag = stream_tag;
-		spec->cur_adc_format = format;
-	}
-	snd_hda_codec_setup_stream(codec, adc, stream_tag, 0, format);
-	return 0;
-}
-
-static int cx_auto_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
-				       struct hda_codec *codec,
-				       struct snd_pcm_substream *substream)
-{
-	struct conexant_spec *spec = codec->spec;
-	snd_hda_codec_cleanup_stream(codec, spec->cur_adc);
-	spec->cur_adc = 0;
-	return 0;
-}
-
-static const struct hda_pcm_stream cx_auto_pcm_analog_capture = {
-	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
-	.nid = 0, /* fill later */
-	.ops = {
-		.prepare = cx_auto_capture_pcm_prepare,
-		.cleanup = cx_auto_capture_pcm_cleanup
-	},
-};
-
-static const hda_nid_t cx_auto_adc_nids[] = { 0x14 };
-
-#define get_connection_index(codec, mux, nid)\
-	snd_hda_get_conn_index(codec, mux, nid, 0)
-
-/* get an unassigned DAC from the given list.
- * Return the nid if found and reduce the DAC list, or return zero if
- * not found
- */
-static hda_nid_t get_unassigned_dac(struct hda_codec *codec, hda_nid_t pin,
-				    hda_nid_t *dacs, int *num_dacs)
-{
-	int i, nums = *num_dacs;
-	hda_nid_t ret = 0;
-
-	for (i = 0; i < nums; i++) {
-		if (get_connection_index(codec, pin, dacs[i]) >= 0) {
-			ret = dacs[i];
-			break;
-		}
-	}
-	if (!ret)
-		return 0;
-	if (--nums > 0)
-		memmove(dacs, dacs + 1, nums * sizeof(hda_nid_t));
-	*num_dacs = nums;
-	return ret;
-}
-
-#define MAX_AUTO_DACS	5
-
-#define DAC_SLAVE_FLAG	0x8000	/* filled dac is a slave */
-
-/* fill analog DAC list from the widget tree */
-static int fill_cx_auto_dacs(struct hda_codec *codec, hda_nid_t *dacs)
-{
-	hda_nid_t nid, end_nid;
-	int nums = 0;
-
-	end_nid = codec->start_nid + codec->num_nodes;
-	for (nid = codec->start_nid; nid < end_nid; nid++) {
-		unsigned int wcaps = get_wcaps(codec, nid);
-		unsigned int type = get_wcaps_type(wcaps);
-		if (type == AC_WID_AUD_OUT && !(wcaps & AC_WCAP_DIGITAL)) {
-			dacs[nums++] = nid;
-			if (nums >= MAX_AUTO_DACS)
-				break;
-		}
-	}
-	return nums;
-}
-
-/* fill pin_dac_pair list from the pin and dac list */
-static int fill_dacs_for_pins(struct hda_codec *codec, hda_nid_t *pins,
-			      int num_pins, hda_nid_t *dacs, int *rest,
-			      struct pin_dac_pair *filled, int nums, 
-			      int type)
-{
-	int i, start = nums;
-
-	for (i = 0; i < num_pins; i++, nums++) {
-		filled[nums].pin = pins[i];
-		filled[nums].type = type;
-		filled[nums].dac = get_unassigned_dac(codec, pins[i], dacs, rest);
-		if (filled[nums].dac) 
-			continue;
-		if (filled[start].dac && get_connection_index(codec, pins[i], filled[start].dac) >= 0) {
-			filled[nums].dac = filled[start].dac | DAC_SLAVE_FLAG;
-			continue;
-		}
-		if (filled[0].dac && get_connection_index(codec, pins[i], filled[0].dac) >= 0) {
-			filled[nums].dac = filled[0].dac | DAC_SLAVE_FLAG;
-			continue;
-		}
-		snd_printdd("Failed to find a DAC for pin 0x%x", pins[i]);
-	}
-	return nums;
-}
-
-/* parse analog output paths */
-static void cx_auto_parse_output(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	hda_nid_t dacs[MAX_AUTO_DACS];
-	int i, j, nums, rest;
-
-	rest = fill_cx_auto_dacs(codec, dacs);
-	/* parse all analog output pins */
-	nums = fill_dacs_for_pins(codec, cfg->line_out_pins, cfg->line_outs,
-			  dacs, &rest, spec->dac_info, 0,
-			  AUTO_PIN_LINE_OUT);
-	nums = fill_dacs_for_pins(codec, cfg->hp_pins, cfg->hp_outs,
-			  dacs, &rest, spec->dac_info, nums,
-			  AUTO_PIN_HP_OUT);
-	nums = fill_dacs_for_pins(codec, cfg->speaker_pins, cfg->speaker_outs,
-			  dacs, &rest, spec->dac_info, nums,
-			  AUTO_PIN_SPEAKER_OUT);
-	spec->dac_info_filled = nums;
-	/* fill multiout struct */
-	for (i = 0; i < nums; i++) {
-		hda_nid_t dac = spec->dac_info[i].dac;
-		if (!dac || (dac & DAC_SLAVE_FLAG))
-			continue;
-		switch (spec->dac_info[i].type) {
-		case AUTO_PIN_LINE_OUT:
-			spec->private_dac_nids[spec->multiout.num_dacs] = dac;
-			spec->multiout.num_dacs++;
-			break;
-		case AUTO_PIN_HP_OUT:
-		case AUTO_PIN_SPEAKER_OUT:
-			if (!spec->multiout.hp_nid) {
-				spec->multiout.hp_nid = dac;
-				break;
-			}
-			for (j = 0; j < ARRAY_SIZE(spec->multiout.extra_out_nid); j++)
-				if (!spec->multiout.extra_out_nid[j]) {
-					spec->multiout.extra_out_nid[j] = dac;
-					break;
-				}
-			break;
-		}
-	}
-	spec->multiout.dac_nids = spec->private_dac_nids;
-	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
-
-	for (i = 0; i < cfg->hp_outs; i++) {
-		if (is_jack_detectable(codec, cfg->hp_pins[i])) {
-			spec->auto_mute = 1;
-			break;
-		}
-	}
-	if (spec->auto_mute &&
-	    cfg->line_out_pins[0] &&
-	    cfg->line_out_type != AUTO_PIN_SPEAKER_OUT &&
-	    cfg->line_out_pins[0] != cfg->hp_pins[0] &&
-	    cfg->line_out_pins[0] != cfg->speaker_pins[0]) {
-		for (i = 0; i < cfg->line_outs; i++) {
-			if (is_jack_detectable(codec, cfg->line_out_pins[i])) {
-				spec->detect_line = 1;
-				break;
-			}
-		}
-		spec->automute_lines = spec->detect_line;
-	}
-
-	spec->vmaster_nid = spec->private_dac_nids[0];
-}
-
-static void cx_auto_turn_eapd(struct hda_codec *codec, int num_pins,
-			      hda_nid_t *pins, bool on);
-
-static void do_automute(struct hda_codec *codec, int num_pins,
-			hda_nid_t *pins, bool on)
-{
-	struct conexant_spec *spec = codec->spec;
-	int i;
-	for (i = 0; i < num_pins; i++)
-		snd_hda_set_pin_ctl(codec, pins[i], on ? PIN_OUT : 0);
-	if (spec->pin_eapd_ctrls)
-		cx_auto_turn_eapd(codec, num_pins, pins, on);
-}
-
-static int detect_jacks(struct hda_codec *codec, int num_pins, hda_nid_t *pins)
-{
-	int i, present = 0;
-
-	for (i = 0; i < num_pins; i++) {
-		hda_nid_t nid = pins[i];
-		if (!nid || !is_jack_detectable(codec, nid))
-			break;
-		present |= snd_hda_jack_detect(codec, nid);
-	}
-	return present;
-}
-
-/* auto-mute/unmute speaker and line outs according to headphone jack */
-static void cx_auto_update_speakers(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int on = 1;
-
-	/* turn on HP EAPD when HP jacks are present */
-	if (spec->pin_eapd_ctrls) {
-		if (spec->auto_mute)
-			on = spec->hp_present;
-		cx_auto_turn_eapd(codec, cfg->hp_outs, cfg->hp_pins, on);
-	}
-
-	/* mute speakers in auto-mode if HP or LO jacks are plugged */
-	if (spec->auto_mute)
-		on = !(spec->hp_present ||
-		       (spec->detect_line && spec->line_present));
-	do_automute(codec, cfg->speaker_outs, cfg->speaker_pins, on);
-
-	/* toggle line-out mutes if needed, too */
-	/* if LO is a copy of either HP or Speaker, don't need to handle it */
-	if (cfg->line_out_pins[0] == cfg->hp_pins[0] ||
-	    cfg->line_out_pins[0] == cfg->speaker_pins[0])
-		return;
-	if (spec->auto_mute) {
-		/* mute LO in auto-mode when HP jack is present */
-		if (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT ||
-		    spec->automute_lines)
-			on = !spec->hp_present;
-		else
-			on = 1;
-	}
-	do_automute(codec, cfg->line_outs, cfg->line_out_pins, on);
-}
-
-static void cx_auto_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-
-	if (!spec->auto_mute)
-		return;
-	spec->hp_present = detect_jacks(codec, cfg->hp_outs, cfg->hp_pins);
-	cx_auto_update_speakers(codec);
-}
-
-static void cx_auto_line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-
-	if (!spec->auto_mute || !spec->detect_line)
-		return;
-	spec->line_present = detect_jacks(codec, cfg->line_outs,
-					  cfg->line_out_pins);
-	cx_auto_update_speakers(codec);
-}
-
-static int cx_automute_mode_info(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct conexant_spec *spec = codec->spec;
-	static const char * const texts3[] = {
-		"Disabled", "Speaker Only", "Line Out+Speaker"
-	};
-
-	if (spec->automute_hp_lo)
-		return snd_hda_enum_helper_info(kcontrol, uinfo, 3, texts3);
-	return snd_hda_enum_bool_helper_info(kcontrol, uinfo);
-}
-
-static int cx_automute_mode_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct conexant_spec *spec = codec->spec;
-	unsigned int val;
-	if (!spec->auto_mute)
-		val = 0;
-	else if (!spec->automute_lines)
-		val = 1;
-	else
-		val = 2;
-	ucontrol->value.enumerated.item[0] = val;
-	return 0;
-}
-
-static int cx_automute_mode_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct conexant_spec *spec = codec->spec;
-
-	switch (ucontrol->value.enumerated.item[0]) {
-	case 0:
-		if (!spec->auto_mute)
-			return 0;
-		spec->auto_mute = 0;
-		break;
-	case 1:
-		if (spec->auto_mute && !spec->automute_lines)
-			return 0;
-		spec->auto_mute = 1;
-		spec->automute_lines = 0;
-		break;
-	case 2:
-		if (!spec->automute_hp_lo)
-			return -EINVAL;
-		if (spec->auto_mute && spec->automute_lines)
-			return 0;
-		spec->auto_mute = 1;
-		spec->automute_lines = 1;
-		break;
-	default:
-		return -EINVAL;
-	}
-	cx_auto_update_speakers(codec);
-	return 1;
-}
-
-static const struct snd_kcontrol_new cx_automute_mode_enum[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Auto-Mute Mode",
-		.info = cx_automute_mode_info,
-		.get = cx_automute_mode_get,
-		.put = cx_automute_mode_put,
-	},
-	{ }
-};
-
-static int cx_auto_mux_enum_info(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct conexant_spec *spec = codec->spec;
-
-	return snd_hda_input_mux_info(&spec->private_imux, uinfo);
-}
-
-static int cx_auto_mux_enum_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct conexant_spec *spec = codec->spec;
-
-	ucontrol->value.enumerated.item[0] = spec->cur_mux[0];
-	return 0;
-}
-
-/* look for the route the given pin from mux and return the index;
- * if do_select is set, actually select the route.
- */
-static int __select_input_connection(struct hda_codec *codec, hda_nid_t mux,
-				     hda_nid_t pin, hda_nid_t *srcp,
-				     bool do_select, int depth)
-{
-	struct conexant_spec *spec = codec->spec;
-	hda_nid_t conn[HDA_MAX_NUM_INPUTS];
-	int startidx, i, nums;
-
-	switch (get_wcaps_type(get_wcaps(codec, mux))) {
-	case AC_WID_AUD_IN:
-	case AC_WID_AUD_SEL:
-	case AC_WID_AUD_MIX:
-		break;
-	default:
-		return -1;
-	}
-
-	nums = snd_hda_get_connections(codec, mux, conn, ARRAY_SIZE(conn));
-	for (i = 0; i < nums; i++)
-		if (conn[i] == pin) {
-			if (do_select)
-				snd_hda_codec_write(codec, mux, 0,
-						    AC_VERB_SET_CONNECT_SEL, i);
-			if (srcp)
-				*srcp = mux;
-			return i;
-		}
-	depth++;
-	if (depth == 2)
-		return -1;
-
-	/* Try to rotate around connections to avoid one boost controlling
-	   another input path as well */
-	startidx = 0;
-	for (i = 0; i < spec->private_imux.num_items; i++)
-		if (spec->imux_info[i].pin == pin) {
-			startidx = i;
-			break;
-		}
-
-	for (i = 0; i < nums; i++) {
-		int j = (i + startidx) % nums;
-		int ret  = __select_input_connection(codec, conn[j], pin, srcp,
-						     do_select, depth);
-		if (ret >= 0) {
-			if (do_select)
-				snd_hda_codec_write(codec, mux, 0,
-						    AC_VERB_SET_CONNECT_SEL, j);
-			return j;
-		}
-	}
-	return -1;
-}
-
-static void select_input_connection(struct hda_codec *codec, hda_nid_t mux,
-				   hda_nid_t pin)
-{
-	__select_input_connection(codec, mux, pin, NULL, true, 0);
-}
-
-static int get_input_connection(struct hda_codec *codec, hda_nid_t mux,
-				hda_nid_t pin)
-{
-	return __select_input_connection(codec, mux, pin, NULL, false, 0);
-}
-
-static int cx_auto_mux_enum_update(struct hda_codec *codec,
-				   const struct hda_input_mux *imux,
-				   unsigned int idx)
-{
-	struct conexant_spec *spec = codec->spec;
-	hda_nid_t adc;
-	int changed = 1;
-
-	if (!imux->num_items)
-		return 0;
-	if (idx >= imux->num_items)
-		idx = imux->num_items - 1;
-	if (spec->cur_mux[0] == idx)
-		changed = 0;
-	adc = spec->imux_info[idx].adc;
-	select_input_connection(codec, spec->imux_info[idx].adc,
-				spec->imux_info[idx].pin);
-	if (spec->cur_adc && spec->cur_adc != adc) {
-		/* stream is running, let's swap the current ADC */
-		__snd_hda_codec_cleanup_stream(codec, spec->cur_adc, 1);
-		spec->cur_adc = adc;
-		snd_hda_codec_setup_stream(codec, adc,
-					   spec->cur_adc_stream_tag, 0,
-					   spec->cur_adc_format);
-	}
-	spec->cur_mux[0] = idx;
-	return changed;
-}
-
-static int cx_auto_mux_enum_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct conexant_spec *spec = codec->spec;
-
-	return cx_auto_mux_enum_update(codec, &spec->private_imux,
-				       ucontrol->value.enumerated.item[0]);
-}
-
-static const struct snd_kcontrol_new cx_auto_capture_mixers[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Source",
-		.info = cx_auto_mux_enum_info,
-		.get = cx_auto_mux_enum_get,
-		.put = cx_auto_mux_enum_put
-	},
-	{}
-};
-
-static bool select_automic(struct hda_codec *codec, int idx, bool detect)
-{
-	struct conexant_spec *spec = codec->spec;
-	if (idx < 0)
-		return false;
-	if (detect && !snd_hda_jack_detect(codec, spec->imux_info[idx].pin))
-		return false;
-	cx_auto_mux_enum_update(codec, &spec->private_imux, idx);
-	return true;
-}
-
-/* automatic switch internal and external mic */
-static void cx_auto_automic(struct hda_codec *codec, struct hda_jack_tbl *jack)
-{
-	struct conexant_spec *spec = codec->spec;
-
-	if (!spec->auto_mic)
-		return;
-	if (!select_automic(codec, spec->auto_mic_ext, true))
-		if (!select_automic(codec, spec->auto_mic_dock, true))
-			select_automic(codec, spec->auto_mic_int, false);
-}
-
-/* check whether the pin config is suitable for auto-mic switching;
- * auto-mic is enabled only when one int-mic and one ext- and/or
- * one dock-mic exist
- */
-static void cx_auto_check_auto_mic(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	int pset[INPUT_PIN_ATTR_NORMAL + 1];
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(pset); i++)
-		pset[i] = -1;
-	for (i = 0; i < spec->private_imux.num_items; i++) {
-		hda_nid_t pin = spec->imux_info[i].pin;
-		unsigned int def_conf = snd_hda_codec_get_pincfg(codec, pin);
-		int type, attr;
-		attr = snd_hda_get_input_pin_attr(def_conf);
-		if (attr == INPUT_PIN_ATTR_UNUSED)
-			return; /* invalid entry */
-		if (attr > INPUT_PIN_ATTR_NORMAL)
-			attr = INPUT_PIN_ATTR_NORMAL;
-		if (attr != INPUT_PIN_ATTR_INT &&
-		    !is_jack_detectable(codec, pin))
-			return; /* non-detectable pin */
-		type = get_defcfg_device(def_conf);
-		if (type != AC_JACK_MIC_IN &&
-		    (attr != INPUT_PIN_ATTR_DOCK || type != AC_JACK_LINE_IN))
-			return; /* no valid input type */
-		if (pset[attr] >= 0)
-			return; /* already occupied */
-		pset[attr] = i;
-	}
-	if (pset[INPUT_PIN_ATTR_INT] < 0 ||
-	    (pset[INPUT_PIN_ATTR_NORMAL] < 0 && pset[INPUT_PIN_ATTR_DOCK]))
-		return; /* no input to switch*/
-	spec->auto_mic = 1;
-	spec->auto_mic_ext = pset[INPUT_PIN_ATTR_NORMAL];
-	spec->auto_mic_dock = pset[INPUT_PIN_ATTR_DOCK];
-	spec->auto_mic_int = pset[INPUT_PIN_ATTR_INT];
-}
-
-static void cx_auto_parse_input(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	struct hda_input_mux *imux;
-	int i, j;
-
-	imux = &spec->private_imux;
-	for (i = 0; i < cfg->num_inputs; i++) {
-		for (j = 0; j < spec->num_adc_nids; j++) {
-			hda_nid_t adc = spec->adc_nids[j];
-			int idx = get_input_connection(codec, adc,
-						       cfg->inputs[i].pin);
-			if (idx >= 0) {
-				const char *label;
-				label = hda_get_autocfg_input_label(codec, cfg, i);
-				spec->imux_info[imux->num_items].index = i;
-				spec->imux_info[imux->num_items].boost = 0;
-				spec->imux_info[imux->num_items].adc = adc;
-				spec->imux_info[imux->num_items].pin =
-					cfg->inputs[i].pin;
-				snd_hda_add_imux_item(imux, label, idx, NULL);
-				break;
-			}
-		}
-	}
-	if (imux->num_items >= 2 && cfg->num_inputs == imux->num_items)
-		cx_auto_check_auto_mic(codec);
-	if (imux->num_items > 1) {
-		for (i = 1; i < imux->num_items; i++) {
-			if (spec->imux_info[i].adc != spec->imux_info[0].adc) {
-				spec->adc_switching = 1;
-				break;
-			}
-		}
-	}
-}
-
-/* get digital-input audio widget corresponding to the given pin */
-static hda_nid_t cx_auto_get_dig_in(struct hda_codec *codec, hda_nid_t pin)
-{
-	hda_nid_t nid, end_nid;
-
-	end_nid = codec->start_nid + codec->num_nodes;
-	for (nid = codec->start_nid; nid < end_nid; nid++) {
-		unsigned int wcaps = get_wcaps(codec, nid);
-		unsigned int type = get_wcaps_type(wcaps);
-		if (type == AC_WID_AUD_IN && (wcaps & AC_WCAP_DIGITAL)) {
-			if (get_connection_index(codec, nid, pin) >= 0)
-				return nid;
-		}
-	}
-	return 0;
-}
-
-static void cx_auto_parse_digital(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	hda_nid_t nid;
-
-	if (cfg->dig_outs &&
-	    snd_hda_get_connections(codec, cfg->dig_out_pins[0], &nid, 1) == 1)
-		spec->multiout.dig_out_nid = nid;
-	if (cfg->dig_in_pin)
-		spec->dig_in_nid = cx_auto_get_dig_in(codec, cfg->dig_in_pin);
-}
-
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
 static void cx_auto_parse_beep(struct hda_codec *codec)
 {
@@ -3811,24 +3156,8 @@ static void cx_auto_parse_eapd(struct hda_codec *codec)
 	 * OTOH, if only one or two EAPDs are found, it's an old chip,
 	 * thus it might control over all pins.
 	 */
-	spec->pin_eapd_ctrls = spec->num_eapds > 2;
-}
-
-static int cx_auto_parse_auto_config(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	int err;
-
-	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
-	if (err < 0)
-		return err;
-
-	cx_auto_parse_output(codec);
-	cx_auto_parse_input(codec);
-	cx_auto_parse_digital(codec);
-	cx_auto_parse_beep(codec);
-	cx_auto_parse_eapd(codec);
-	return 0;
+	if (spec->num_eapds > 2)
+		spec->gen.own_eapd_ctl = 1;
 }
 
 static void cx_auto_turn_eapd(struct hda_codec *codec, int num_pins,
@@ -3843,569 +3172,36 @@ static void cx_auto_turn_eapd(struct hda_codec *codec, int num_pins,
 	}
 }
 
-static void select_connection(struct hda_codec *codec, hda_nid_t pin,
-			      hda_nid_t src)
-{
-	int idx = get_connection_index(codec, pin, src);
-	if (idx >= 0)
-		snd_hda_codec_write(codec, pin, 0,
-				    AC_VERB_SET_CONNECT_SEL, idx);
-}
-
-static void mute_outputs(struct hda_codec *codec, int num_nids,
-			 const hda_nid_t *nids)
-{
-	int i, val;
-
-	for (i = 0; i < num_nids; i++) {
-		hda_nid_t nid = nids[i];
-		if (!(get_wcaps(codec, nid) & AC_WCAP_OUT_AMP))
-			continue;
-		if (query_amp_caps(codec, nid, HDA_OUTPUT) & AC_AMPCAP_MUTE)
-			val = AMP_OUT_MUTE;
-		else
-			val = AMP_OUT_ZERO;
-		snd_hda_codec_write(codec, nid, 0,
-				    AC_VERB_SET_AMP_GAIN_MUTE, val);
-	}
-}
-
-static void enable_unsol_pins(struct hda_codec *codec, int num_pins,
-			      hda_nid_t *pins, unsigned int action,
-			      hda_jack_callback cb)
-{
-	int i;
-	for (i = 0; i < num_pins; i++)
-		snd_hda_jack_detect_enable_callback(codec, pins[i], action, cb);
-}
-
-static bool found_in_nid_list(hda_nid_t nid, const hda_nid_t *list, int nums)
-{
-	int i;
-	for (i = 0; i < nums; i++)
-		if (list[i] == nid)
-			return true;
-	return false;
-}
-
-/* is the given NID found in any of autocfg items? */
-static bool found_in_autocfg(struct auto_pin_cfg *cfg, hda_nid_t nid)
-{
-	int i;
-
-	if (found_in_nid_list(nid, cfg->line_out_pins, cfg->line_outs) ||
-	    found_in_nid_list(nid, cfg->hp_pins, cfg->hp_outs) ||
-	    found_in_nid_list(nid, cfg->speaker_pins, cfg->speaker_outs) ||
-	    found_in_nid_list(nid, cfg->dig_out_pins, cfg->dig_outs))
-		return true;
-	for (i = 0; i < cfg->num_inputs; i++)
-		if (cfg->inputs[i].pin == nid)
-			return true;
-	if (cfg->dig_in_pin == nid)
-		return true;
-	return false;
-}
-
-/* clear unsol-event tags on unused pins; Conexant codecs seem to leave
- * invalid unsol tags by some reason
- */
-static void clear_unsol_on_unused_pins(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i;
-
-	for (i = 0; i < codec->init_pins.used; i++) {
-		struct hda_pincfg *pin = snd_array_elem(&codec->init_pins, i);
-		if (!found_in_autocfg(cfg, pin->nid))
-			snd_hda_codec_write(codec, pin->nid, 0,
-					    AC_VERB_SET_UNSOLICITED_ENABLE, 0);
-	}
-}
-
 /* turn on/off EAPD according to Master switch */
 static void cx_auto_vmaster_hook(void *private_data, int enabled)
 {
 	struct hda_codec *codec = private_data;
 	struct conexant_spec *spec = codec->spec;
 
-	if (enabled && spec->pin_eapd_ctrls) {
-		cx_auto_update_speakers(codec);
-		return;
-	}
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, enabled);
 }
 
-static void cx_auto_init_output(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	hda_nid_t nid;
-	int i;
-
-	mute_outputs(codec, spec->multiout.num_dacs, spec->multiout.dac_nids);
-	for (i = 0; i < cfg->hp_outs; i++) {
-		unsigned int val = PIN_OUT;
-		if (snd_hda_query_pin_caps(codec, cfg->hp_pins[i]) &
-		    AC_PINCAP_HP_DRV)
-			val |= AC_PINCTL_HP_EN;
-		snd_hda_set_pin_ctl(codec, cfg->hp_pins[i], val);
-	}
-	mute_outputs(codec, cfg->hp_outs, cfg->hp_pins);
-	mute_outputs(codec, cfg->line_outs, cfg->line_out_pins);
-	mute_outputs(codec, cfg->speaker_outs, cfg->speaker_pins);
-	for (i = 0; i < spec->dac_info_filled; i++) {
-		nid = spec->dac_info[i].dac;
-		if (!nid)
-			nid = spec->multiout.dac_nids[0];
-		else if (nid & DAC_SLAVE_FLAG)
-			nid &= ~DAC_SLAVE_FLAG;
-		select_connection(codec, spec->dac_info[i].pin, nid);
-	}
-	if (spec->auto_mute) {
-		enable_unsol_pins(codec, cfg->hp_outs, cfg->hp_pins,
-				  CONEXANT_HP_EVENT, cx_auto_hp_automute);
-		spec->hp_present = detect_jacks(codec, cfg->hp_outs,
-						cfg->hp_pins);
-		if (spec->detect_line) {
-			enable_unsol_pins(codec, cfg->line_outs,
-					  cfg->line_out_pins,
-					  CONEXANT_LINE_EVENT,
-					  cx_auto_line_automute);
-			spec->line_present =
-				detect_jacks(codec, cfg->line_outs,
-					     cfg->line_out_pins);
-		}
-	}
-	cx_auto_update_speakers(codec);
-	/* turn on all EAPDs if no individual EAPD control is available */
-	if (!spec->pin_eapd_ctrls)
-		cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, true);
-	clear_unsol_on_unused_pins(codec);
-}
-
-static void cx_auto_init_input(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i, val;
-
-	for (i = 0; i < spec->num_adc_nids; i++) {
-		hda_nid_t nid = spec->adc_nids[i];
-		if (!(get_wcaps(codec, nid) & AC_WCAP_IN_AMP))
-			continue;
-		if (query_amp_caps(codec, nid, HDA_INPUT) & AC_AMPCAP_MUTE)
-			val = AMP_IN_MUTE(0);
-		else
-			val = AMP_IN_UNMUTE(0);
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-				    val);
-	}
-
-	for (i = 0; i < cfg->num_inputs; i++) {
-		hda_nid_t pin = cfg->inputs[i].pin;
-		unsigned int type = PIN_IN;
-		if (cfg->inputs[i].type == AUTO_PIN_MIC)
-			type |= snd_hda_get_default_vref(codec, pin);
-		snd_hda_set_pin_ctl(codec, pin, type);
-	}
-
-	if (spec->auto_mic) {
-		if (spec->auto_mic_ext >= 0) {
-			snd_hda_jack_detect_enable_callback(codec,
-				cfg->inputs[spec->auto_mic_ext].pin,
-				CONEXANT_MIC_EVENT, cx_auto_automic);
-		}
-		if (spec->auto_mic_dock >= 0) {
-			snd_hda_jack_detect_enable_callback(codec,
-				cfg->inputs[spec->auto_mic_dock].pin,
-				CONEXANT_MIC_EVENT, cx_auto_automic);
-		}
-		cx_auto_automic(codec, NULL);
-	} else {
-		select_input_connection(codec, spec->imux_info[0].adc,
-					spec->imux_info[0].pin);
-	}
-}
-
-static void cx_auto_init_digital(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
-
-	if (spec->multiout.dig_out_nid)
-		snd_hda_set_pin_ctl(codec, cfg->dig_out_pins[0], PIN_OUT);
-	if (spec->dig_in_nid)
-		snd_hda_set_pin_ctl(codec, cfg->dig_in_pin, PIN_IN);
-}
-
-static int cx_auto_init(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	snd_hda_apply_verbs(codec);
-	cx_auto_init_output(codec);
-	cx_auto_init_input(codec);
-	cx_auto_init_digital(codec);
-	snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
-	return 0;
-}
-
-static int cx_auto_add_volume_idx(struct hda_codec *codec, const char *basename,
-			      const char *dir, int cidx,
-			      hda_nid_t nid, int hda_dir, int amp_idx, int chs)
-{
-	static char name[44];
-	static struct snd_kcontrol_new knew[] = {
-		HDA_CODEC_VOLUME(name, 0, 0, 0),
-		HDA_CODEC_MUTE(name, 0, 0, 0),
-	};
-	static const char * const sfx[2] = { "Volume", "Switch" };
-	int i, err;
-
-	for (i = 0; i < 2; i++) {
-		struct snd_kcontrol *kctl;
-		knew[i].private_value = HDA_COMPOSE_AMP_VAL(nid, chs, amp_idx,
-							    hda_dir);
-		knew[i].subdevice = HDA_SUBDEV_AMP_FLAG;
-		knew[i].index = cidx;
-		snprintf(name, sizeof(name), "%s%s %s", basename, dir, sfx[i]);
-		kctl = snd_ctl_new1(&knew[i], codec);
-		if (!kctl)
-			return -ENOMEM;
-		err = snd_hda_ctl_add(codec, nid, kctl);
-		if (err < 0)
-			return err;
-		if (!(query_amp_caps(codec, nid, hda_dir) &
-		      (AC_AMPCAP_MUTE | AC_AMPCAP_MIN_MUTE)))
-			break;
-	}
-	return 0;
-}
-
-#define cx_auto_add_volume(codec, str, dir, cidx, nid, hda_dir)		\
-	cx_auto_add_volume_idx(codec, str, dir, cidx, nid, hda_dir, 0, 3)
-
-#define cx_auto_add_pb_volume(codec, nid, str, idx)			\
-	cx_auto_add_volume(codec, str, " Playback", idx, nid, HDA_OUTPUT)
-
-static int try_add_pb_volume(struct hda_codec *codec, hda_nid_t dac,
-			     hda_nid_t pin, const char *name, int idx)
-{
-	unsigned int caps;
-	if (dac && !(dac & DAC_SLAVE_FLAG)) {
-		caps = query_amp_caps(codec, dac, HDA_OUTPUT);
-		if (caps & AC_AMPCAP_NUM_STEPS)
-			return cx_auto_add_pb_volume(codec, dac, name, idx);
-	}
-	caps = query_amp_caps(codec, pin, HDA_OUTPUT);
-	if (caps & AC_AMPCAP_NUM_STEPS)
-		return cx_auto_add_pb_volume(codec, pin, name, idx);
-	return 0;
-}
-
-static bool is_2_1_speaker(struct conexant_spec *spec)
-{
-	int i, type, num_spk = 0;
-
-	for (i = 0; i < spec->dac_info_filled; i++) {
-		type = spec->dac_info[i].type;
-		if (type == AUTO_PIN_LINE_OUT)
-			type = spec->autocfg.line_out_type;
-		if (type == AUTO_PIN_SPEAKER_OUT)
-			num_spk++;
-	}
-	return (num_spk == 2 && spec->autocfg.line_out_type != AUTO_PIN_LINE_OUT);
-}
-
-static int cx_auto_build_output_controls(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	int i, err;
-	int num_line = 0, num_hp = 0, num_spk = 0;
-	bool speaker_2_1;
-	static const char * const texts[3] = { "Front", "Surround", "CLFE" };
-
-	if (spec->dac_info_filled == 1)
-		return try_add_pb_volume(codec, spec->dac_info[0].dac,
-					 spec->dac_info[0].pin,
-					 "Master", 0);
-
-	speaker_2_1 = is_2_1_speaker(spec);
-
-	for (i = 0; i < spec->dac_info_filled; i++) {
-		const char *label;
-		int idx, type;
-		hda_nid_t dac = spec->dac_info[i].dac;
-		type = spec->dac_info[i].type;
-		if (type == AUTO_PIN_LINE_OUT)
-			type = spec->autocfg.line_out_type;
-		switch (type) {
-		case AUTO_PIN_LINE_OUT:
-		default:
-			label = texts[num_line++];
-			idx = 0;
-			break;
-		case AUTO_PIN_HP_OUT:
-			label = "Headphone";
-			idx = num_hp++;
-			break;
-		case AUTO_PIN_SPEAKER_OUT:
-			if (speaker_2_1) {
-				label = num_spk++ ? "Bass Speaker" : "Speaker";
-				idx = 0;
-			} else {
-				label = "Speaker";
-				idx = num_spk++;
-			}
-			break;
-		}
-		err = try_add_pb_volume(codec, dac,
-					spec->dac_info[i].pin,
-					label, idx);
-		if (err < 0)
-			return err;
-	}
-
-	if (spec->auto_mute) {
-		err = snd_hda_add_new_ctls(codec, cx_automute_mode_enum);
-		if (err < 0)
-			return err;
-	}
-	
-	return 0;
-}
-
-/* Returns zero if this is a normal stereo channel, and non-zero if it should
-   be split in two independent channels.
-   dest_label must be at least 44 characters. */
-static int cx_auto_get_rightch_label(struct hda_codec *codec, const char *label,
-				     char *dest_label, int nid)
-{
-	struct conexant_spec *spec = codec->spec;
-	int i;
-
-	if (!spec->fixup_stereo_dmic)
-		return 0;
-
-	for (i = 0; i < AUTO_CFG_MAX_INS; i++) {
-		int def_conf;
-		if (spec->autocfg.inputs[i].pin != nid)
-			continue;
-
-		if (spec->autocfg.inputs[i].type != AUTO_PIN_MIC)
-			return 0;
-		def_conf = snd_hda_codec_get_pincfg(codec, nid);
-		if (snd_hda_get_input_pin_attr(def_conf) != INPUT_PIN_ATTR_INT)
-			return 0;
-
-		/* Finally found the inverted internal mic! */
-		snprintf(dest_label, 44, "Inverted %s", label);
-		return 1;
-	}
-	return 0;
-}
-
-static int cx_auto_add_capture_volume(struct hda_codec *codec, hda_nid_t nid,
-				      const char *label, const char *pfx,
-				      int cidx)
-{
-	struct conexant_spec *spec = codec->spec;
-	int i;
-
-	for (i = 0; i < spec->num_adc_nids; i++) {
-		char rightch_label[44];
-		hda_nid_t adc_nid = spec->adc_nids[i];
-		int idx = get_input_connection(codec, adc_nid, nid);
-		if (idx < 0)
-			continue;
-		if (codec->single_adc_amp)
-			idx = 0;
-
-		if (cx_auto_get_rightch_label(codec, label, rightch_label, nid)) {
-			/* Make two independent kcontrols for left and right */
-			int err = cx_auto_add_volume_idx(codec, label, pfx,
-					      cidx, adc_nid, HDA_INPUT, idx, 1);
-			if (err < 0)
-				return err;
-			return cx_auto_add_volume_idx(codec, rightch_label, pfx,
-						      cidx, adc_nid, HDA_INPUT, idx, 2);
-		}
-		return cx_auto_add_volume_idx(codec, label, pfx,
-					      cidx, adc_nid, HDA_INPUT, idx, 3);
-	}
-	return 0;
-}
-
-static int cx_auto_add_boost_volume(struct hda_codec *codec, int idx,
-				    const char *label, int cidx)
-{
-	struct conexant_spec *spec = codec->spec;
-	hda_nid_t mux, nid;
-	int i, con;
-
-	nid = spec->imux_info[idx].pin;
-	if (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) {
-		char rightch_label[44];
-		if (cx_auto_get_rightch_label(codec, label, rightch_label, nid)) {
-			int err = cx_auto_add_volume_idx(codec, label, " Boost",
-							 cidx, nid, HDA_INPUT, 0, 1);
-			if (err < 0)
-				return err;
-			return cx_auto_add_volume_idx(codec, rightch_label, " Boost",
-						      cidx, nid, HDA_INPUT, 0, 2);
-		}
-		return cx_auto_add_volume(codec, label, " Boost", cidx,
-					  nid, HDA_INPUT);
-	}
-	con = __select_input_connection(codec, spec->imux_info[idx].adc, nid,
-					&mux, false, 0);
-	if (con < 0)
-		return 0;
-	for (i = 0; i < idx; i++) {
-		if (spec->imux_info[i].boost == mux)
-			return 0; /* already present */
-	}
-
-	if (get_wcaps(codec, mux) & AC_WCAP_OUT_AMP) {
-		spec->imux_info[idx].boost = mux;
-		return cx_auto_add_volume(codec, label, " Boost", cidx,
-					  mux, HDA_OUTPUT);
-	}
-	return 0;
-}
-
-static int cx_auto_build_input_controls(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	struct hda_input_mux *imux = &spec->private_imux;
-	const char *prev_label;
-	int input_conn[HDA_MAX_NUM_INPUTS];
-	int i, j, err, cidx;
-	int multi_connection;
-
-	if (!imux->num_items)
-		return 0;
-
-	multi_connection = 0;
-	for (i = 0; i < imux->num_items; i++) {
-		cidx = get_input_connection(codec, spec->imux_info[i].adc,
-					    spec->imux_info[i].pin);
-		if (cidx < 0)
-			continue;
-		input_conn[i] = spec->imux_info[i].adc;
-		if (!codec->single_adc_amp)
-			input_conn[i] |= cidx << 8;
-		if (i > 0 && input_conn[i] != input_conn[0])
-			multi_connection = 1;
-	}
-
-	prev_label = NULL;
-	cidx = 0;
-	for (i = 0; i < imux->num_items; i++) {
-		hda_nid_t nid = spec->imux_info[i].pin;
-		const char *label;
-
-		label = hda_get_autocfg_input_label(codec, &spec->autocfg,
-						    spec->imux_info[i].index);
-		if (label == prev_label)
-			cidx++;
-		else
-			cidx = 0;
-		prev_label = label;
-
-		err = cx_auto_add_boost_volume(codec, i, label, cidx);
-		if (err < 0)
-			return err;
-
-		if (!multi_connection) {
-			if (i > 0)
-				continue;
-			err = cx_auto_add_capture_volume(codec, nid,
-							 "Capture", "", cidx);
-		} else {
-			bool dup_found = false;
-			for (j = 0; j < i; j++) {
-				if (input_conn[j] == input_conn[i]) {
-					dup_found = true;
-					break;
-				}
-			}
-			if (dup_found)
-				continue;
-			err = cx_auto_add_capture_volume(codec, nid,
-							 label, " Capture", cidx);
-		}
-		if (err < 0)
-			return err;
-	}
-
-	if (spec->private_imux.num_items > 1 && !spec->auto_mic) {
-		err = snd_hda_add_new_ctls(codec, cx_auto_capture_mixers);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
 static int cx_auto_build_controls(struct hda_codec *codec)
 {
-	struct conexant_spec *spec = codec->spec;
 	int err;
 
-	err = cx_auto_build_output_controls(codec);
-	if (err < 0)
-		return err;
-	err = cx_auto_build_input_controls(codec);
+	err = snd_hda_gen_build_controls(codec);
 	if (err < 0)
 		return err;
-	err = conexant_build_controls(codec);
-	if (err < 0)
-		return err;
-	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
+
+	err = add_beep_ctls(codec);
 	if (err < 0)
 		return err;
-	if (spec->vmaster_mute.sw_kctl) {
-		spec->vmaster_mute.hook = cx_auto_vmaster_hook;
-		err = snd_hda_add_vmaster_hook(codec, &spec->vmaster_mute,
-					       spec->vmaster_mute_led);
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
 
-static int cx_auto_search_adcs(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	hda_nid_t nid, end_nid;
-
-	end_nid = codec->start_nid + codec->num_nodes;
-	for (nid = codec->start_nid; nid < end_nid; nid++) {
-		unsigned int caps = get_wcaps(codec, nid);
-		if (get_wcaps_type(caps) != AC_WID_AUD_IN)
-			continue;
-		if (caps & AC_WCAP_DIGITAL)
-			continue;
-		if (snd_BUG_ON(spec->num_adc_nids >=
-			       ARRAY_SIZE(spec->private_adc_nids)))
-			break;
-		spec->private_adc_nids[spec->num_adc_nids++] = nid;
-	}
-	spec->adc_nids = spec->private_adc_nids;
 	return 0;
 }
 
 static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_controls = cx_auto_build_controls,
-	.build_pcms = conexant_build_pcms,
-	.init = cx_auto_init,
-	.free = conexant_free,
+	.build_pcms = snd_hda_gen_build_pcms,
+	.init = snd_hda_gen_init,
+	.free = snd_hda_gen_free,
 	.unsol_event = snd_hda_jack_unsol_event,
-#ifdef CONFIG_PM
-	.suspend = conexant_suspend,
-#endif
-	.reboot_notify = snd_hda_shutup_pins,
 };
 
 /*
@@ -4424,7 +3220,7 @@ static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
 				  const struct hda_fixup *fix, int action)
 {
 	struct conexant_spec *spec = codec->spec;
-	spec->fixup_stereo_dmic = 1;
+	spec->gen.inv_dmic_split = 1;
 }
 
 static void cxt5066_increase_mic_boost(struct hda_codec *codec,
@@ -4545,8 +3341,14 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
 		return -ENOMEM;
+	snd_hda_gen_spec_init(&spec->gen);
 	codec->spec = spec;
 
+	cx_auto_parse_beep(codec);
+	cx_auto_parse_eapd(codec);
+	if (spec->gen.own_eapd_ctl)
+		spec->gen.vmaster_mute.hook = cx_auto_vmaster_hook;
+
 	switch (codec->vendor_id) {
 	case 0x14f15045:
 		codec->single_adc_amp = 1;
@@ -4562,8 +3364,6 @@ static int patch_conexant_auto(struct hda_codec *codec)
 		break;
 	}
 
-	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
-
 	/* Show mute-led control only on HP laptops
 	 * This is a sort of white-list: on HP laptops, EAPD corresponds
 	 * only to the mute-LED without actualy amp function.  Meanwhile,
@@ -4572,20 +3372,20 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	 */
 	switch (codec->subsystem_id >> 16) {
 	case 0x103c:
-		spec->vmaster_mute_led = 1;
+		spec->gen.vmaster_mute_enum = 1;
 		break;
 	}
 
-	err = cx_auto_search_adcs(codec);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
+	err = snd_hda_parse_pin_defcfg(codec, &spec->gen.autocfg, NULL, 0);
 	if (err < 0)
-		return err;
-	err = cx_auto_parse_auto_config(codec);
-	if (err < 0) {
-		kfree(codec->spec);
-		codec->spec = NULL;
-		return err;
-	}
-	spec->capture_stream = &cx_auto_pcm_analog_capture;
+		goto error;
+
+	err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
+	if (err < 0)
+		goto error;
+
 	codec->patch_ops = cx_auto_patch_ops;
 	if (spec->beep_amp)
 		snd_hda_attach_beep_device(codec, spec->beep_amp);
@@ -4602,6 +3402,10 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	}
 
 	return 0;
+
+ error:
+	snd_hda_gen_free(codec);
+	return err;
 }
 
 /*
-- 
1.8.0.1
