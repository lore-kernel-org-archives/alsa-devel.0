From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - make Realtek/Sigmatel/Conexant
	use the generic unsol event
Date: Tue, 25 Sep 2012 11:31:00 +0200
Message-ID: <1348565460-5642-2-git-send-email-david.henningsson@canonical.com>
References: <1348565460-5642-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 686832602F9
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 11:31:01 +0200 (CEST)
In-Reply-To: <1348565460-5642-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

For less duplication of code between codecs, and to make it easier
in the future to improve code for all codecs simultaneously.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   44 +++++++-------------
 sound/pci/hda/patch_realtek.c  |   86 ++++++++++++++--------------------------
 sound/pci/hda/patch_sigmatel.c |   20 +++-------
 3 files changed, 49 insertions(+), 101 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index c03d3b8..902ea0b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3402,7 +3402,7 @@ static void cx_auto_update_speakers(struct hda_codec *codec)
 	do_automute(codec, cfg->line_outs, cfg->line_out_pins, on);
 }
 
-static void cx_auto_hp_automute(struct hda_codec *codec)
+static void cx_auto_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct conexant_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
@@ -3413,7 +3413,7 @@ static void cx_auto_hp_automute(struct hda_codec *codec)
 	cx_auto_update_speakers(codec);
 }
 
-static void cx_auto_line_automute(struct hda_codec *codec)
+static void cx_auto_line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct conexant_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
@@ -3664,7 +3664,7 @@ static bool select_automic(struct hda_codec *codec, int idx, bool detect)
 }
 
 /* automatic switch internal and external mic */
-static void cx_auto_automic(struct hda_codec *codec)
+static void cx_auto_automic(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct conexant_spec *spec = codec->spec;
 
@@ -3675,22 +3675,6 @@ static void cx_auto_automic(struct hda_codec *codec)
 			select_automic(codec, spec->auto_mic_int, false);
 }
 
-static void cx_auto_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	switch (snd_hda_jack_get_action(codec, res >> 26)) {
-	case CONEXANT_HP_EVENT:
-		cx_auto_hp_automute(codec);
-		break;
-	case CONEXANT_LINE_EVENT:
-		cx_auto_line_automute(codec);
-		break;
-	case CONEXANT_MIC_EVENT:
-		cx_auto_automic(codec);
-		break;
-	}
-	snd_hda_jack_report_sync(codec);
-}
-
 /* check whether the pin config is suitable for auto-mic switching;
  * auto-mic is enabled only when one int-mic and one ext- and/or
  * one dock-mic exist
@@ -3900,11 +3884,12 @@ static void mute_outputs(struct hda_codec *codec, int num_nids,
 }
 
 static void enable_unsol_pins(struct hda_codec *codec, int num_pins,
-			      hda_nid_t *pins, unsigned int action)
+			      hda_nid_t *pins, unsigned int action,
+			      hda_jack_callback cb)
 {
 	int i;
 	for (i = 0; i < num_pins; i++)
-		snd_hda_jack_detect_enable(codec, pins[i], action);
+		snd_hda_jack_detect_enable_callback(codec, pins[i], action, cb);
 }
 
 static bool found_in_nid_list(hda_nid_t nid, const hda_nid_t *list, int nums)
@@ -3992,13 +3977,14 @@ static void cx_auto_init_output(struct hda_codec *codec)
 	}
 	if (spec->auto_mute) {
 		enable_unsol_pins(codec, cfg->hp_outs, cfg->hp_pins,
-				  CONEXANT_HP_EVENT);
+				  CONEXANT_HP_EVENT, cx_auto_hp_automute);
 		spec->hp_present = detect_jacks(codec, cfg->hp_outs,
 						cfg->hp_pins);
 		if (spec->detect_line) {
 			enable_unsol_pins(codec, cfg->line_outs,
 					  cfg->line_out_pins,
-					  CONEXANT_LINE_EVENT);
+					  CONEXANT_LINE_EVENT,
+					  cx_auto_line_automute);
 			spec->line_present =
 				detect_jacks(codec, cfg->line_outs,
 					     cfg->line_out_pins);
@@ -4039,16 +4025,16 @@ static void cx_auto_init_input(struct hda_codec *codec)
 
 	if (spec->auto_mic) {
 		if (spec->auto_mic_ext >= 0) {
-			snd_hda_jack_detect_enable(codec,
+			snd_hda_jack_detect_enable_callback(codec,
 				cfg->inputs[spec->auto_mic_ext].pin,
-				CONEXANT_MIC_EVENT);
+				CONEXANT_MIC_EVENT, cx_auto_automic);
 		}
 		if (spec->auto_mic_dock >= 0) {
-			snd_hda_jack_detect_enable(codec,
+			snd_hda_jack_detect_enable_callback(codec,
 				cfg->inputs[spec->auto_mic_dock].pin,
-				CONEXANT_MIC_EVENT);
+				CONEXANT_MIC_EVENT, cx_auto_automic);
 		}
-		cx_auto_automic(codec);
+		cx_auto_automic(codec, NULL);
 	} else {
 		select_input_connection(codec, spec->imux_info[0].adc,
 					spec->imux_info[0].pin);
@@ -4406,7 +4392,7 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_pcms = conexant_build_pcms,
 	.init = cx_auto_init,
 	.free = conexant_free,
-	.unsol_event = cx_auto_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend = conexant_suspend,
 #endif
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3d440fc..8477029 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -594,7 +594,7 @@ static void call_update_outputs(struct hda_codec *codec)
 }
 
 /* standard HP-automute helper */
-static void alc_hp_automute(struct hda_codec *codec)
+static void alc_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct alc_spec *spec = codec->spec;
 
@@ -607,7 +607,7 @@ static void alc_hp_automute(struct hda_codec *codec)
 }
 
 /* standard line-out-automute helper */
-static void alc_line_automute(struct hda_codec *codec)
+static void alc_line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct alc_spec *spec = codec->spec;
 
@@ -627,7 +627,7 @@ static void alc_line_automute(struct hda_codec *codec)
 	snd_hda_get_conn_index(codec, mux, nid, 0)
 
 /* standard mic auto-switch helper */
-static void alc_mic_automute(struct hda_codec *codec)
+static void alc_mic_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct alc_spec *spec = codec->spec;
 	hda_nid_t *pins = spec->imux_pins;
@@ -648,25 +648,8 @@ static void alc_mic_automute(struct hda_codec *codec)
 		alc_mux_select(codec, 0, spec->int_mic_idx, false);
 }
 
-/* handle the specified unsol action (ALC_XXX_EVENT) */
-static void alc_exec_unsol_event(struct hda_codec *codec, int action)
-{
-	switch (action) {
-	case ALC_HP_EVENT:
-		alc_hp_automute(codec);
-		break;
-	case ALC_FRONT_EVENT:
-		alc_line_automute(codec);
-		break;
-	case ALC_MIC_EVENT:
-		alc_mic_automute(codec);
-		break;
-	}
-	snd_hda_jack_report_sync(codec);
-}
-
 /* update the master volume per volume-knob's unsol event */
-static void alc_update_knob_master(struct hda_codec *codec, hda_nid_t nid)
+static void alc_update_knob_master(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	unsigned int val;
 	struct snd_kcontrol *kctl;
@@ -678,7 +661,7 @@ static void alc_update_knob_master(struct hda_codec *codec, hda_nid_t nid)
 	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (!uctl)
 		return;
-	val = snd_hda_codec_read(codec, nid, 0,
+	val = snd_hda_codec_read(codec, jack->nid, 0,
 				 AC_VERB_GET_VOLUME_KNOB_CONTROL, 0);
 	val &= HDA_AMP_VOLMASK;
 	uctl->value.integer.value[0] = val;
@@ -687,37 +670,19 @@ static void alc_update_knob_master(struct hda_codec *codec, hda_nid_t nid)
 	kfree(uctl);
 }
 
-/* unsolicited event for HP jack sensing */
-static void alc_unsol_event(struct hda_codec *codec, unsigned int res)
+static void alc880_unsol_event(struct hda_codec *codec, unsigned int res)
 {
-	int action;
-
-	if (codec->vendor_id == 0x10ec0880)
-		res >>= 28;
-	else
-		res >>= 26;
-	action = snd_hda_jack_get_action(codec, res);
-	if (action == ALC_DCVOL_EVENT) {
-		/* Execute the dc-vol event here as it requires the NID
-		 * but we don't pass NID to alc_exec_unsol_event().
-		 * Once when we convert all static quirks to the auto-parser,
-		 * this can be integerated into there.
-		 */
-		struct hda_jack_tbl *jack;
-		jack = snd_hda_jack_tbl_get_from_tag(codec, res);
-		if (jack)
-			alc_update_knob_master(codec, jack->nid);
-		return;
-	}
-	alc_exec_unsol_event(codec, action);
+	/* For some reason, the res given from ALC880 is broken.
+	   Here we adjust it properly. */
+	snd_hda_jack_unsol_event(codec, res >> 2);
 }
 
 /* call init functions of standard auto-mute helpers */
 static void alc_inithook(struct hda_codec *codec)
 {
-	alc_hp_automute(codec);
-	alc_line_automute(codec);
-	alc_mic_automute(codec);
+	alc_hp_automute(codec, NULL);
+	alc_line_automute(codec, NULL);
+	alc_mic_automute(codec, NULL);
 }
 
 /* additional initialization for ALC888 variants */
@@ -999,7 +964,8 @@ static void alc_init_automute(struct hda_codec *codec)
 			continue;
 		snd_printdd("realtek: Enable HP auto-muting on NID 0x%x\n",
 			    nid);
-		snd_hda_jack_detect_enable(codec, nid, ALC_HP_EVENT);
+		snd_hda_jack_detect_enable_callback(codec, nid, ALC_HP_EVENT,
+						    alc_hp_automute);
 		spec->detect_hp = 1;
 	}
 
@@ -1011,10 +977,10 @@ static void alc_init_automute(struct hda_codec *codec)
 					continue;
 				snd_printdd("realtek: Enable Line-Out "
 					    "auto-muting on NID 0x%x\n", nid);
-				snd_hda_jack_detect_enable(codec, nid,
-							   ALC_FRONT_EVENT);
+				snd_hda_jack_detect_enable_callback(codec, nid, ALC_FRONT_EVENT,
+								    alc_line_automute);
 				spec->detect_lo = 1;
-		}
+			}
 		spec->automute_lo_possible = spec->detect_hp;
 	}
 
@@ -1110,10 +1076,12 @@ static bool alc_auto_mic_check_imux(struct hda_codec *codec)
 		return false; /* no corresponding imux */
 	}
 
-	snd_hda_jack_detect_enable(codec, spec->ext_mic_pin, ALC_MIC_EVENT);
+	snd_hda_jack_detect_enable_callback(codec, spec->ext_mic_pin,
+					    ALC_MIC_EVENT, alc_mic_automute);
 	if (spec->dock_mic_pin)
-		snd_hda_jack_detect_enable(codec, spec->dock_mic_pin,
-					   ALC_MIC_EVENT);
+		snd_hda_jack_detect_enable_callback(codec, spec->dock_mic_pin,
+						    ALC_MIC_EVENT,
+						    alc_mic_automute);
 
 	spec->auto_mic_valid_imux = 1;
 	spec->auto_mic = 1;
@@ -2473,7 +2441,7 @@ static const struct hda_codec_ops alc_patch_ops = {
 	.build_pcms = alc_build_pcms,
 	.init = alc_init,
 	.free = alc_free,
-	.unsol_event = alc_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
 	.resume = alc_resume,
 #endif
@@ -2484,6 +2452,7 @@ static const struct hda_codec_ops alc_patch_ops = {
 	.reboot_notify = alc_shutup,
 };
 
+
 /* replace the codec chip_name with the given string */
 static int alc_codec_rename(struct hda_codec *codec, const char *name)
 {
@@ -4447,7 +4416,7 @@ static void alc880_fixup_vol_knob(struct hda_codec *codec,
 				  const struct alc_fixup *fix, int action)
 {
 	if (action == ALC_FIXUP_ACT_PROBE)
-		snd_hda_jack_detect_enable(codec, 0x21, ALC_DCVOL_EVENT);
+		snd_hda_jack_detect_enable_callback(codec, 0x21, ALC_DCVOL_EVENT, alc_update_knob_master);
 }
 
 static const struct alc_fixup alc880_fixups[] = {
@@ -4812,6 +4781,8 @@ static int patch_alc880(struct hda_codec *codec)
 	}
 
 	codec->patch_ops = alc_patch_ops;
+	codec->patch_ops.unsol_event = alc880_unsol_event;
+
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
@@ -4866,7 +4837,8 @@ static void alc260_fixup_gpio1_toggle(struct hda_codec *codec,
 		spec->detect_hp = 1;
 		spec->automute_speaker = 1;
 		spec->autocfg.hp_pins[0] = 0x0f; /* copy it for automute */
-		snd_hda_jack_detect_enable(codec, 0x0f, ALC_HP_EVENT);
+		snd_hda_jack_detect_enable_callback(codec, 0x0f, ALC_HP_EVENT,
+						    alc_hp_automute);
 		snd_hda_gen_add_verbs(&spec->gen, alc_gpio1_init_verbs);
 	}
 }
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index bb6c50e..fe16354 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4212,6 +4212,9 @@ static int stac_add_event(struct hda_codec *codec, hda_nid_t nid,
 	return 0;
 }
 
+static void handle_unsol_event(struct hda_codec *codec,
+			       struct hda_jack_tbl *event);
+
 /* check if given nid is a valid pin and no other events are assigned
  * to it.  If OK, assign the event, set the unsol flag, and returns 1.
  * Otherwise, returns zero.
@@ -4229,6 +4232,7 @@ static int enable_pin_detect(struct hda_codec *codec, hda_nid_t nid,
 	if (event->action && event->action != type)
 		return 0;
 	event->action = type;
+	event->callback = handle_unsol_event;
 	snd_hda_jack_detect_enable(codec, nid, 0);
 	return 1;
 }
@@ -4867,20 +4871,6 @@ static void stac_issue_unsol_event(struct hda_codec *codec, hda_nid_t nid)
 	handle_unsol_event(codec, event);
 }
 
-static void stac92xx_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	struct hda_jack_tbl *event;
-	int tag;
-
-	tag = (res >> 26) & 0x7f;
-	event = snd_hda_jack_tbl_get_from_tag(codec, tag);
-	if (!event)
-		return;
-	event->jack_dirty = 1;
-	handle_unsol_event(codec, event);
-	snd_hda_jack_report_sync(codec);
-}
-
 static int hp_blike_system(u32 subsystem_id);
 
 static void set_hp_led_gpio(struct hda_codec *codec)
@@ -5131,7 +5121,7 @@ static const struct hda_codec_ops stac92xx_patch_ops = {
 	.build_pcms = stac92xx_build_pcms,
 	.init = stac92xx_init,
 	.free = stac92xx_free,
-	.unsol_event = stac92xx_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend = stac92xx_suspend,
 	.resume = stac92xx_resume,
-- 
1.7.9.5
