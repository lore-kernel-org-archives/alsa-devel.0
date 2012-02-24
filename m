From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 38/38] ALSA: hda/realtek - Small code cleanups
Date: Fri, 24 Feb 2012 17:36:31 +0100
Message-ID: <1330101391-8788-39-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id BD395104326
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id C5354933A7
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
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

A few clean-ups for post-static-quirk time:
- Call alc_auto_init_std() statically in alc_init() instead of setting
  spec->init_hook in each caller.  spec->init_hook field is left
  unused for any future use.

- Move the call of set_capture_mixer() to to alc_parse_auto_config()
  instead of each caller.

- Get rid of the ADC-filling and imux check in each parser function.
  This is no longer needed since the auto-parser always check ADCs and
  imux.  It was only for the static quirks.

- Kill unused defines

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  140 ++---------------------------------------
 1 files changed, 5 insertions(+), 135 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e82911a..e142f6f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -222,8 +222,6 @@ struct alc_spec {
 	struct snd_array bind_ctls;
 };
 
-#define ALC_MODEL_AUTO		0	/* common for all chips */
-
 static bool check_amp_caps(struct hda_codec *codec, hda_nid_t nid,
 			   int dir, unsigned int bits)
 {
@@ -1074,45 +1072,6 @@ static bool alc_check_dyn_adc_switch(struct hda_codec *codec)
 	return true;
 }
 
-/* rebuild imux for matching with the given auto-mic pins (if not yet) */
-static bool alc_rebuild_imux_for_auto_mic(struct hda_codec *codec)
-{
-	struct alc_spec *spec = codec->spec;
-	struct hda_input_mux *imux;
-	static char * const texts[3] = {
-		"Mic", "Internal Mic", "Dock Mic"
-	};
-	int i;
-
-	if (!spec->auto_mic)
-		return false;
-	imux = &spec->private_imux[0];
-	if (spec->input_mux == imux)
-		return true;
-	spec->imux_pins[0] = spec->ext_mic_pin;
-	spec->imux_pins[1] = spec->int_mic_pin;
-	spec->imux_pins[2] = spec->dock_mic_pin;
-	for (i = 0; i < 3; i++) {
-		strcpy(imux->items[i].label, texts[i]);
-		if (spec->imux_pins[i]) {
-			hda_nid_t pin = spec->imux_pins[i];
-			int c;
-			for (c = 0; c < spec->num_adc_nids; c++) {
-				hda_nid_t cap = get_capsrc(spec, c);
-				int idx = get_connection_index(codec, cap, pin);
-				if (idx >= 0) {
-					imux->items[i].index = idx;
-					break;
-				}
-			}
-			imux->num_items = i + 1;
-		}
-	}
-	spec->num_mux_defs = 1;
-	spec->input_mux = imux;
-	return true;
-}
-
 /* check whether all auto-mic pins are valid; setup indices if OK */
 static bool alc_auto_mic_check_imux(struct hda_codec *codec)
 {
@@ -2092,6 +2051,7 @@ static int alc_build_controls(struct hda_codec *codec)
  */
 
 static void alc_init_special_input_src(struct hda_codec *codec);
+static void alc_auto_init_std(struct hda_codec *codec);
 
 static int alc_init(struct hda_codec *codec)
 {
@@ -2104,6 +2064,7 @@ static int alc_init(struct hda_codec *codec)
 	for (i = 0; i < spec->num_init_verbs; i++)
 		snd_hda_sequence_write(codec, spec->init_verbs[i]);
 	alc_init_special_input_src(codec);
+	alc_auto_init_std(codec);
 
 	if (spec->init_hook)
 		spec->init_hook(codec);
@@ -4442,6 +4403,9 @@ static int alc_parse_auto_config(struct hda_codec *codec,
 	if (spec->kctls.list)
 		add_mixer(spec, spec->kctls.list);
 
+	if (!spec->no_analog && !spec->cap_mixer)
+		set_capture_mixer(codec);
+
 	return 1;
 }
 
@@ -4844,15 +4808,6 @@ static int patch_alc880(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->no_analog && !spec->adc_nids) {
-		alc_auto_fill_adc_caps(codec);
-		alc_rebuild_imux_for_auto_mic(codec);
-		alc_remove_invalid_adc_nids(codec);
-	}
-
-	if (!spec->no_analog && !spec->cap_mixer)
-		set_capture_mixer(codec);
-
 	if (!spec->no_analog) {
 		err = snd_hda_attach_beep_device(codec, 0x1);
 		if (err < 0)
@@ -4861,7 +4816,6 @@ static int patch_alc880(struct hda_codec *codec)
 	}
 
 	codec->patch_ops = alc_patch_ops;
-	spec->init_hook = alc_auto_init_std;
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
@@ -5009,15 +4963,6 @@ static int patch_alc260(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->no_analog && !spec->adc_nids) {
-		alc_auto_fill_adc_caps(codec);
-		alc_rebuild_imux_for_auto_mic(codec);
-		alc_remove_invalid_adc_nids(codec);
-	}
-
-	if (!spec->no_analog && !spec->cap_mixer)
-		set_capture_mixer(codec);
-
 	if (!spec->no_analog) {
 		err = snd_hda_attach_beep_device(codec, 0x1);
 		if (err < 0)
@@ -5026,7 +4971,6 @@ static int patch_alc260(struct hda_codec *codec)
 	}
 
 	codec->patch_ops = alc_patch_ops;
-	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
@@ -5477,15 +5421,6 @@ static int patch_alc882(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->no_analog && !spec->adc_nids) {
-		alc_auto_fill_adc_caps(codec);
-		alc_rebuild_imux_for_auto_mic(codec);
-		alc_remove_invalid_adc_nids(codec);
-	}
-
-	if (!spec->no_analog && !spec->cap_mixer)
-		set_capture_mixer(codec);
-
 	if (!spec->no_analog && has_cdefine_beep(codec)) {
 		err = snd_hda_attach_beep_device(codec, 0x1);
 		if (err < 0)
@@ -5494,7 +5429,6 @@ static int patch_alc882(struct hda_codec *codec)
 	}
 
 	codec->patch_ops = alc_patch_ops;
-	spec->init_hook = alc_auto_init_std;
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
@@ -5631,15 +5565,6 @@ static int patch_alc262(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->no_analog && !spec->adc_nids) {
-		alc_auto_fill_adc_caps(codec);
-		alc_rebuild_imux_for_auto_mic(codec);
-		alc_remove_invalid_adc_nids(codec);
-	}
-
-	if (!spec->no_analog && !spec->cap_mixer)
-		set_capture_mixer(codec);
-
 	if (!spec->no_analog && has_cdefine_beep(codec)) {
 		err = snd_hda_attach_beep_device(codec, 0x1);
 		if (err < 0)
@@ -5648,7 +5573,6 @@ static int patch_alc262(struct hda_codec *codec)
 	}
 
 	codec->patch_ops = alc_patch_ops;
-	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
@@ -5745,17 +5669,7 @@ static int patch_alc268(struct hda_codec *codec)
 					  (0 << AC_AMPCAP_MUTE_SHIFT));
 	}
 
-	if (!spec->no_analog && !spec->adc_nids) {
-		alc_auto_fill_adc_caps(codec);
-		alc_rebuild_imux_for_auto_mic(codec);
-		alc_remove_invalid_adc_nids(codec);
-	}
-
-	if (!spec->no_analog && !spec->cap_mixer)
-		set_capture_mixer(codec);
-
 	codec->patch_ops = alc_patch_ops;
-	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
 
 	return 0;
@@ -6283,15 +6197,6 @@ static int patch_alc269(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->no_analog && !spec->adc_nids) {
-		alc_auto_fill_adc_caps(codec);
-		alc_rebuild_imux_for_auto_mic(codec);
-		alc_remove_invalid_adc_nids(codec);
-	}
-
-	if (!spec->no_analog && !spec->cap_mixer)
-		set_capture_mixer(codec);
-
 	if (!spec->no_analog && has_cdefine_beep(codec)) {
 		err = snd_hda_attach_beep_device(codec, 0x1);
 		if (err < 0)
@@ -6303,7 +6208,6 @@ static int patch_alc269(struct hda_codec *codec)
 #ifdef CONFIG_PM
 	codec->patch_ops.resume = alc269_resume;
 #endif
-	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc269_shutup;
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
@@ -6424,15 +6328,6 @@ static int patch_alc861(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->no_analog && !spec->adc_nids) {
-		alc_auto_fill_adc_caps(codec);
-		alc_rebuild_imux_for_auto_mic(codec);
-		alc_remove_invalid_adc_nids(codec);
-	}
-
-	if (!spec->no_analog && !spec->cap_mixer)
-		set_capture_mixer(codec);
-
 	if (!spec->no_analog) {
 		err = snd_hda_attach_beep_device(codec, 0x23);
 		if (err < 0)
@@ -6441,7 +6336,6 @@ static int patch_alc861(struct hda_codec *codec)
 	}
 
 	codec->patch_ops = alc_patch_ops;
-	spec->init_hook = alc_auto_init_std;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	spec->power_hook = alc_power_eapd;
 #endif
@@ -6542,15 +6436,6 @@ static int patch_alc861vd(struct hda_codec *codec)
 		add_verb(spec, alc660vd_eapd_verbs);
 	}
 
-	if (!spec->no_analog && !spec->adc_nids) {
-		alc_auto_fill_adc_caps(codec);
-		alc_rebuild_imux_for_auto_mic(codec);
-		alc_remove_invalid_adc_nids(codec);
-	}
-
-	if (!spec->no_analog && !spec->cap_mixer)
-		set_capture_mixer(codec);
-
 	if (!spec->no_analog) {
 		err = snd_hda_attach_beep_device(codec, 0x23);
 		if (err < 0)
@@ -6560,7 +6445,6 @@ static int patch_alc861vd(struct hda_codec *codec)
 
 	codec->patch_ops = alc_patch_ops;
 
-	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
@@ -6912,15 +6796,6 @@ static int patch_alc662(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->no_analog && !spec->adc_nids) {
-		alc_auto_fill_adc_caps(codec);
-		alc_rebuild_imux_for_auto_mic(codec);
-		alc_remove_invalid_adc_nids(codec);
-	}
-
-	if (!spec->no_analog && !spec->cap_mixer)
-		set_capture_mixer(codec);
-
 	if (!spec->no_analog && has_cdefine_beep(codec)) {
 		err = snd_hda_attach_beep_device(codec, 0x1);
 		if (err < 0)
@@ -6941,7 +6816,6 @@ static int patch_alc662(struct hda_codec *codec)
 	}
 
 	codec->patch_ops = alc_patch_ops;
-	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
@@ -6984,11 +6858,7 @@ static int patch_alc680(struct hda_codec *codec)
 		return err;
 	}
 
-	if (!spec->no_analog && !spec->cap_mixer)
-		set_capture_mixer(codec);
-
 	codec->patch_ops = alc_patch_ops;
-	spec->init_hook = alc_auto_init_std;
 
 	return 0;
 }
-- 
1.7.9
