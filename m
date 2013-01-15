From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/20] ALSA: hda - Manage current pinctl values
	in generic parser
Date: Tue, 15 Jan 2013 12:05:35 +0100
Message-ID: <1358247947-13992-9-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B498126531F
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 89123A522A
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

Use the new pin target accessors for managing the current pinctl
values in the generic parser.  The pinctl values of all active pins
are once determined at the initialization phase, and stored via
snd_hda_codec_set_pin_target().  This will be referred again in the
codec init or resume phase to set the actual pinctl.

This value is kept while the auto-mute.  When a line-out or a speaker
pin is muted by auto-mute, the driver simply disables the pin, but it
doesn't touch the cached pinctl target value.  Upon unmute, this value
is used to restore the original pinctl in return.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 137 +++++++++++++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 52 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index a9bf188..e786f10 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -84,6 +84,41 @@ void snd_hda_gen_spec_free(struct hda_gen_spec *spec)
 EXPORT_SYMBOL_HDA(snd_hda_gen_spec_free);
 
 /*
+ * pin control value accesses
+ */
+
+#define update_pin_ctl(codec, pin, val) \
+	snd_hda_codec_update_cache(codec, pin, 0, \
+				   AC_VERB_SET_PIN_WIDGET_CONTROL, val)
+
+/* restore the pinctl based on the cached value */
+static inline void restore_pin_ctl(struct hda_codec *codec, hda_nid_t pin)
+{
+	update_pin_ctl(codec, pin, snd_hda_codec_get_pin_target(codec, pin));
+}
+
+/* set the pinctl target value and write it if requested */
+static void set_pin_target(struct hda_codec *codec, hda_nid_t pin,
+			   unsigned int val, bool do_write)
+{
+	if (!pin)
+		return;
+	val = snd_hda_correct_pin_ctl(codec, pin, val);
+	snd_hda_codec_set_pin_target(codec, pin, val);
+	if (do_write)
+		update_pin_ctl(codec, pin, val);
+}
+
+/* set pinctl target values for all given pins */
+static void set_pin_targets(struct hda_codec *codec, int num_pins,
+			    hda_nid_t *pins, unsigned int val)
+{
+	int i;
+	for (i = 0; i < num_pins; i++)
+		set_pin_target(codec, pins[i], val, false);
+}
+
+/*
  * parsing paths
  */
 
@@ -1317,6 +1352,15 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 				   spec->multiout.extra_out_nid,
 				   spec->speaker_paths);
 
+	/* set initial pinctl targets */
+	set_pin_targets(codec, cfg->line_outs, cfg->line_out_pins,
+			cfg->line_out_type == AUTO_PIN_HP_OUT ? PIN_HP : PIN_OUT);
+	if (cfg->line_out_type != AUTO_PIN_HP_OUT)
+		set_pin_targets(codec, cfg->hp_outs, cfg->hp_pins, PIN_HP);
+	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT)
+		set_pin_targets(codec, cfg->speaker_outs,
+				cfg->speaker_pins, PIN_OUT);
+
 	return badness;
 }
 
@@ -1715,14 +1759,13 @@ static int set_multi_io(struct hda_codec *codec, int idx, bool output)
 		return 0;
 
 	if (output) {
-		snd_hda_set_pin_ctl_cache(codec, nid, PIN_OUT);
+		set_pin_target(codec, nid, PIN_OUT, true);
 		snd_hda_activate_path(codec, path, true, true);
 		set_pin_eapd(codec, nid, true);
 	} else {
 		set_pin_eapd(codec, nid, false);
 		snd_hda_activate_path(codec, path, false, true);
-		snd_hda_set_pin_ctl_cache(codec, nid,
-					  spec->multi_io[idx].ctl_in);
+		set_pin_target(codec, nid, spec->multi_io[idx].ctl_in, true);
 	}
 	return 0;
 }
@@ -1871,7 +1914,7 @@ static void update_shared_mic_hp(struct hda_codec *codec, bool set_as_mic)
 	}
 
 	val = set_as_mic ? val | PIN_IN : PIN_HP;
-	snd_hda_set_pin_ctl_cache(codec, pin, val);
+	set_pin_target(codec, pin, val, true);
 
 	spec->automute_speaker = !set_as_mic;
 	call_update_outputs(codec);
@@ -2126,6 +2169,7 @@ static int create_input_ctls(struct hda_codec *codec)
 	int num_adcs;
 	int i, err, type_idx = 0;
 	const char *prev_label = NULL;
+	unsigned int val;
 
 	num_adcs = fill_adc_nids(codec);
 	if (num_adcs < 0)
@@ -2146,6 +2190,11 @@ static int create_input_ctls(struct hda_codec *codec)
 			type_idx = 0;
 		prev_label = label;
 
+		val = PIN_IN;
+		if (cfg->inputs[i].type == AUTO_PIN_MIC)
+			val |= snd_hda_get_default_vref(codec, pin);
+		set_pin_target(codec, pin, val, false);
+
 		if (mixer) {
 			if (is_reachable_path(codec, pin, mixer)) {
 				err = new_analog_input(codec, i, pin,
@@ -2611,12 +2660,12 @@ static void parse_digital(struct hda_codec *codec)
 	struct hda_gen_spec *spec = codec->spec;
 	struct nid_path *path;
 	int i, nums;
-	hda_nid_t dig_nid;
+	hda_nid_t dig_nid, pin;
 
 	/* support multiple SPDIFs; the secondary is set up as a slave */
 	nums = 0;
 	for (i = 0; i < spec->autocfg.dig_outs; i++) {
-		hda_nid_t pin = spec->autocfg.dig_out_pins[i];
+		pin = spec->autocfg.dig_out_pins[i];
 		dig_nid = look_for_dac(codec, pin, true);
 		if (!dig_nid)
 			continue;
@@ -2626,6 +2675,7 @@ static void parse_digital(struct hda_codec *codec)
 		print_nid_path("digout", path);
 		path->active = true;
 		spec->digout_paths[i] = snd_hda_get_path_idx(codec, path);
+		set_pin_target(codec, pin, PIN_OUT, false);
 		if (!nums) {
 			spec->multiout.dig_out_nid = dig_nid;
 			spec->dig_out_type = spec->autocfg.dig_out_type[0];
@@ -2639,6 +2689,7 @@ static void parse_digital(struct hda_codec *codec)
 	}
 
 	if (spec->autocfg.dig_in_pin) {
+		pin = spec->autocfg.dig_in_pin;
 		dig_nid = codec->start_nid;
 		for (i = 0; i < codec->num_nodes; i++, dig_nid++) {
 			unsigned int wcaps = get_wcaps(codec, dig_nid);
@@ -2646,14 +2697,13 @@ static void parse_digital(struct hda_codec *codec)
 				continue;
 			if (!(wcaps & AC_WCAP_DIGITAL))
 				continue;
-			path = snd_hda_add_new_path(codec,
-						    spec->autocfg.dig_in_pin,
-						    dig_nid, 0);
+			path = snd_hda_add_new_path(codec, pin, dig_nid, 0);
 			if (path) {
 				print_nid_path("digin", path);
 				path->active = true;
 				spec->dig_in_nid = dig_nid;
 				spec->digin_path = snd_hda_get_path_idx(codec, path);
+				set_pin_target(codec, pin, PIN_IN, false);
 				break;
 			}
 		}
@@ -2730,10 +2780,9 @@ static bool detect_jacks(struct hda_codec *codec, int num_pins, hda_nid_t *pins)
 
 /* standard HP/line-out auto-mute helper */
 static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
-			bool mute, bool hp_out)
+			bool mute)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	unsigned int pin_bits = mute ? 0 : (hp_out ? PIN_HP : PIN_OUT);
 	int i;
 
 	for (i = 0; i < num_pins; i++) {
@@ -2744,14 +2793,18 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 		/* don't reset VREF value in case it's controlling
 		 * the amp (see alc861_fixup_asus_amp_vref_0f())
 		 */
-		if (spec->keep_vref_in_automute) {
-			val = snd_hda_codec_read(codec, nid, 0,
-					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-			val &= ~PIN_HP;
-		} else
+		if (spec->keep_vref_in_automute)
+			val = snd_hda_codec_get_pin_target(codec, nid) & ~PIN_HP;
+		else
 			val = 0;
-		val |= pin_bits;
-		snd_hda_set_pin_ctl_cache(codec, nid, val);
+		if (!mute)
+			val |= snd_hda_codec_get_pin_target(codec, nid);
+		/* here we call update_pin_ctl() so that the pinctl is changed
+		 * without changing the pinctl target value;
+		 * the original target value will be still referred at the
+		 * init / resume again
+		 */
+		update_pin_ctl(codec, nid, val);
 		set_pin_eapd(codec, nid, !mute);
 	}
 }
@@ -2768,7 +2821,7 @@ void snd_hda_gen_update_outputs(struct hda_codec *codec)
 	 */
 	if (!spec->shared_mic_hp) /* don't change HP-pin when shared with mic */
 		do_automute(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
-		    spec->autocfg.hp_pins, spec->master_mute, true);
+		    spec->autocfg.hp_pins, spec->master_mute);
 
 	if (!spec->automute_speaker)
 		on = 0;
@@ -2776,7 +2829,7 @@ void snd_hda_gen_update_outputs(struct hda_codec *codec)
 		on = spec->hp_jack_present | spec->line_jack_present;
 	on |= spec->master_mute;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.speaker_pins),
-		    spec->autocfg.speaker_pins, on, false);
+		    spec->autocfg.speaker_pins, on);
 
 	/* toggle line-out mutes if needed, too */
 	/* if LO is a copy of either HP or Speaker, don't need to handle it */
@@ -2789,7 +2842,7 @@ void snd_hda_gen_update_outputs(struct hda_codec *codec)
 		on = spec->hp_jack_present;
 	on |= spec->master_mute;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
-		    spec->autocfg.line_out_pins, on, false);
+		    spec->autocfg.line_out_pins, on);
 }
 EXPORT_SYMBOL_HDA(snd_hda_gen_update_outputs);
 
@@ -3806,8 +3859,7 @@ EXPORT_SYMBOL_HDA(snd_hda_gen_build_pcms);
  */
 
 /* configure the given path as a proper output */
-static void set_output_and_unmute(struct hda_codec *codec,
-				  int pin_type, int path_idx)
+static void set_output_and_unmute(struct hda_codec *codec, int path_idx)
 {
 	struct nid_path *path;
 	hda_nid_t pin;
@@ -3816,7 +3868,7 @@ static void set_output_and_unmute(struct hda_codec *codec,
 	if (!path || !path->depth)
 		return;
 	pin = path->path[path->depth - 1];
-	snd_hda_set_pin_ctl_cache(codec, pin, pin_type);
+	restore_pin_ctl(codec, pin);
 	snd_hda_activate_path(codec, path, path->active, true);
 	set_pin_eapd(codec, pin, path->active);
 }
@@ -3825,26 +3877,19 @@ static void set_output_and_unmute(struct hda_codec *codec,
 static void init_multi_out(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	int pin_type;
 	int i;
 
-	if (spec->autocfg.line_out_type == AUTO_PIN_HP_OUT)
-		pin_type = PIN_HP;
-	else
-		pin_type = PIN_OUT;
-
 	for (i = 0; i < spec->autocfg.line_outs; i++)
-		set_output_and_unmute(codec, pin_type, spec->out_paths[i]);
+		set_output_and_unmute(codec, spec->out_paths[i]);
 }
 
 
-static void __init_extra_out(struct hda_codec *codec, int num_outs,
-			     int *paths, int type)
+static void __init_extra_out(struct hda_codec *codec, int num_outs, int *paths)
 {
 	int i;
 
 	for (i = 0; i < num_outs; i++)
-		set_output_and_unmute(codec, type, paths[i]);
+		set_output_and_unmute(codec, paths[i]);
 }
 
 /* initialize hp and speaker paths */
@@ -3853,11 +3898,10 @@ static void init_extra_out(struct hda_codec *codec)
 	struct hda_gen_spec *spec = codec->spec;
 
 	if (spec->autocfg.line_out_type != AUTO_PIN_HP_OUT)
-		__init_extra_out(codec, spec->autocfg.hp_outs,
-				 spec->hp_paths, PIN_HP);
+		__init_extra_out(codec, spec->autocfg.hp_outs, spec->hp_paths);
 	if (spec->autocfg.line_out_type != AUTO_PIN_SPEAKER_OUT)
 		__init_extra_out(codec, spec->autocfg.speaker_outs,
-				 spec->speaker_paths, PIN_OUT);
+				 spec->speaker_paths);
 }
 
 /* initialize multi-io paths */
@@ -3874,22 +3918,11 @@ static void init_multi_io(struct hda_codec *codec)
 			continue;
 		if (!spec->multi_io[i].ctl_in)
 			spec->multi_io[i].ctl_in =
-				snd_hda_codec_update_cache(codec, pin, 0,
-					   AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+				snd_hda_codec_get_pin_target(codec, pin);
 		snd_hda_activate_path(codec, path, path->active, true);
 	}
 }
 
-/* set up the input pin config, depending on the given auto-pin type */
-static void set_input_pin(struct hda_codec *codec, hda_nid_t nid,
-			  int auto_pin_type)
-{
-	unsigned int val = PIN_IN;
-	if (auto_pin_type == AUTO_PIN_MIC)
-		val |= snd_hda_get_default_vref(codec, nid);
-	snd_hda_set_pin_ctl_cache(codec, nid, val);
-}
-
 /* set up input pins and loopback paths */
 static void init_analog_input(struct hda_codec *codec)
 {
@@ -3900,7 +3933,7 @@ static void init_analog_input(struct hda_codec *codec)
 	for (i = 0; i < cfg->num_inputs; i++) {
 		hda_nid_t nid = cfg->inputs[i].pin;
 		if (is_input_pin(codec, nid))
-			set_input_pin(codec, nid, cfg->inputs[i].type);
+			restore_pin_ctl(codec, nid);
 
 		/* init loopback inputs */
 		if (spec->mixer_nid) {
@@ -3953,11 +3986,11 @@ static void init_digital(struct hda_codec *codec)
 	hda_nid_t pin;
 
 	for (i = 0; i < spec->autocfg.dig_outs; i++)
-		set_output_and_unmute(codec, PIN_OUT, spec->digout_paths[i]);
+		set_output_and_unmute(codec, spec->digout_paths[i]);
 	pin = spec->autocfg.dig_in_pin;
 	if (pin) {
 		struct nid_path *path;
-		snd_hda_set_pin_ctl_cache(codec, pin, PIN_IN);
+		restore_pin_ctl(codec, pin);
 		path = snd_hda_get_path_from_idx(codec, spec->digin_path);
 		if (path)
 			snd_hda_activate_path(codec, path, path->active, false);
-- 
1.8.1
