From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: hda - Support advanced power state
	controls
Date: Wed, 18 Mar 2015 09:50:56 +0100
Message-ID: <1426668658-15911-3-git-send-email-tiwai@suse.de>
References: <1426668658-15911-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 560532604A1
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 09:51:01 +0100 (CET)
In-Reply-To: <1426668658-15911-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This patch enables the finer power state control of each widget
depending on the jack plug state and streaming state in addition to
the existing power_down_unused power optimization.  The new feature is
enabled only when codec->power_mgmt flag is set.

Two new flags, pin_enabled and stream_enabled, are introduced in
nid_path struct for marking the two individual power states: the pin
plug/unplug and DAC/ADC stream, respectively.  They can be set
statically in case they are static routes (e.g. some mixer paths),
too.

The power up and down events for each pin are triggered via the
standard hda_jack table.  The call order is hard-coded, relying on the
current implementation of jack event chain (a la FILO/stack order).

One point to be dealt carefully is that DAC/ADC cannot be powered
on/off while streaming.  They are pinned as long as the stream is
running.  For controlling the power of DAC/ADC, a new patch_ops is
added.  The generic parser provides the default callback for that.

As of this patch, only IDT/Sigmatel codec driver enables the flag.
The support on other codecs will follow.

An assumption we made in this code is that the widget state (e.g. amp,
pinctl, connections) remains after the widget power transition (not
about FG power transition).  This is true for IDT codecs, at least.
But if the widget state is lost at widget power transition, we'd need
to implement additional code to sync the cached amp/verbs for the
specific NID.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      |   4 +
 sound/pci/hda/hda_codec.h      |   2 +
 sound/pci/hda/hda_generic.c    | 301 ++++++++++++++++++++++++++++++++++-------
 sound/pci/hda/hda_generic.h    |   5 +-
 sound/pci/hda/patch_sigmatel.c |   5 +
 5 files changed, 269 insertions(+), 48 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3e4fb7a8fdcb..7e38d6f7314b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1502,6 +1502,8 @@ void snd_hda_codec_setup_stream(struct hda_codec *codec, hda_nid_t nid,
 	if (!p)
 		return;
 
+	if (codec->patch_ops.stream_pm)
+		codec->patch_ops.stream_pm(codec, nid, true);
 	if (codec->pcm_format_first)
 		update_pcm_format(codec, p, nid, format);
 	update_pcm_stream_id(codec, p, nid, stream_tag, channel_id);
@@ -1570,6 +1572,8 @@ static void really_cleanup_stream(struct hda_codec *codec,
 );
 	memset(q, 0, sizeof(*q));
 	q->nid = nid;
+	if (codec->patch_ops.stream_pm)
+		codec->patch_ops.stream_pm(codec, nid, false);
 }
 
 /* clean up the all conflicting obsolete streams */
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 70851e6d5f10..148e84ce61cf 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -200,6 +200,7 @@ struct hda_codec_ops {
 	int (*check_power_status)(struct hda_codec *codec, hda_nid_t nid);
 #endif
 	void (*reboot_notify)(struct hda_codec *codec);
+	void (*stream_pm)(struct hda_codec *codec, hda_nid_t nid, bool on);
 };
 
 /* record for amp information cache */
@@ -370,6 +371,7 @@ struct hda_codec {
 	unsigned int cached_write:1;	/* write only to caches */
 	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
 	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
+	unsigned int power_mgmt:1; /* advanced PM for each widget */
 #ifdef CONFIG_PM
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
 	atomic_t in_pm;		/* suspend/resume being performed */
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 27ce54701f0f..8a5055d296f5 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -140,6 +140,9 @@ static void parse_user_hints(struct hda_codec *codec)
 	val = snd_hda_get_bool_hint(codec, "single_adc_amp");
 	if (val >= 0)
 		codec->single_adc_amp = !!val;
+	val = snd_hda_get_bool_hint(codec, "power_mgmt");
+	if (val >= 0)
+		codec->power_mgmt = !!val;
 
 	val = snd_hda_get_bool_hint(codec, "auto_mute");
 	if (val >= 0)
@@ -648,12 +651,21 @@ static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
 			  unsigned int dir, unsigned int idx)
 {
 	struct hda_gen_spec *spec = codec->spec;
+	int type = get_wcaps_type(get_wcaps(codec, nid));
 	int i, n;
 
 	for (n = 0; n < spec->paths.used; n++) {
 		struct nid_path *path = snd_array_elem(&spec->paths, n);
 		if (!path->active)
 			continue;
+		if (codec->power_mgmt) {
+			if (!path->stream_enabled)
+				continue;
+			/* ignore unplugged paths except for DAC/ADC */
+			if (!path->pin_enabled &&
+			    type != AC_WID_AUD_OUT && type != AC_WID_AUD_IN)
+				continue;
+		}
 		for (i = 0; i < path->depth; i++) {
 			if (path->path[i] == nid) {
 				if (dir == HDA_OUTPUT || path->idx[i] == idx)
@@ -807,6 +819,42 @@ static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
 	}
 }
 
+/* sync power of each widget in the the given path */
+static hda_nid_t path_power_update(struct hda_codec *codec,
+				   struct nid_path *path,
+				   bool allow_powerdown)
+{
+	hda_nid_t nid, changed = 0;
+	int i, state;
+
+	for (i = 0; i < path->depth; i++) {
+		nid = path->path[i];
+		if (!allow_powerdown || is_active_nid_for_any(codec, nid))
+			state = AC_PWRST_D0;
+		else
+			state = AC_PWRST_D3;
+		if (!snd_hda_check_power_state(codec, nid, state)) {
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_POWER_STATE, state);
+			changed = nid;
+			/* here we assume that widget attributes (e.g. amp,
+			 * pinctl connection) don't change with local power
+			 * state change.  If not, need to sync the cache.
+			 */
+		}
+	}
+	return changed;
+}
+
+/* do sync with the last power state change */
+static void sync_power_state_change(struct hda_codec *codec, hda_nid_t nid)
+{
+	if (nid) {
+		msleep(10);
+		snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
+	}
+}
+
 /**
  * snd_hda_activate_path - activate or deactivate the given path
  * @codec: the HDA codec
@@ -825,15 +873,13 @@ void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 	if (!enable)
 		path->active = false;
 
+	/* make sure the widget is powered up */
+	if (enable && (spec->power_down_unused || codec->power_mgmt))
+		path_power_update(codec, path, codec->power_mgmt);
+
 	for (i = path->depth - 1; i >= 0; i--) {
 		hda_nid_t nid = path->path[i];
-		if (enable && spec->power_down_unused) {
-			/* make sure the widget is powered up */
-			if (!snd_hda_check_power_state(codec, nid, AC_PWRST_D0))
-				snd_hda_codec_write(codec, nid, 0,
-						    AC_VERB_SET_POWER_STATE,
-						    AC_PWRST_D0);
-		}
+
 		if (enable && path->multi[i])
 			snd_hda_codec_update_cache(codec, nid, 0,
 					    AC_VERB_SET_CONNECT_SEL,
@@ -853,28 +899,10 @@ EXPORT_SYMBOL_GPL(snd_hda_activate_path);
 static void path_power_down_sync(struct hda_codec *codec, struct nid_path *path)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	bool changed = false;
-	int i;
 
-	if (!spec->power_down_unused || path->active)
+	if (!(spec->power_down_unused || codec->power_mgmt) || path->active)
 		return;
-
-	for (i = 0; i < path->depth; i++) {
-		hda_nid_t nid = path->path[i];
-		if (!snd_hda_check_power_state(codec, nid, AC_PWRST_D3) &&
-		    !is_active_nid_for_any(codec, nid)) {
-			snd_hda_codec_write(codec, nid, 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D3);
-			changed = true;
-		}
-	}
-
-	if (changed) {
-		msleep(10);
-		snd_hda_codec_read(codec, path->path[0], 0,
-				   AC_VERB_GET_POWER_STATE, 0);
-	}
+	sync_power_state_change(codec, path_power_update(codec, path, true));
 }
 
 /* turn on/off EAPD on the given pin */
@@ -1574,6 +1602,7 @@ static int check_aamix_out_path(struct hda_codec *codec, int path_idx)
 		return 0;
 	/* print_nid_path(codec, "output-aamix", path); */
 	path->active = false; /* unused as default */
+	path->pin_enabled = true; /* static route */
 	return snd_hda_get_path_idx(codec, path);
 }
 
@@ -2998,6 +3027,7 @@ static int new_analog_input(struct hda_codec *codec, int input_idx,
 	}
 
 	path->active = true;
+	path->stream_enabled = true; /* no DAC/ADC involved */
 	err = add_loopback_list(spec, mix_nid, idx);
 	if (err < 0)
 		return err;
@@ -3009,6 +3039,8 @@ static int new_analog_input(struct hda_codec *codec, int input_idx,
 		if (path) {
 			print_nid_path(codec, "loopback-merge", path);
 			path->active = true;
+			path->pin_enabled = true; /* static route */
+			path->stream_enabled = true; /* no DAC/ADC involved */
 			spec->loopback_merge_path =
 				snd_hda_get_path_idx(codec, path);
 		}
@@ -3810,6 +3842,7 @@ static void parse_digital(struct hda_codec *codec)
 			continue;
 		print_nid_path(codec, "digout", path);
 		path->active = true;
+		path->pin_enabled = true; /* no jack detection */
 		spec->digout_paths[i] = snd_hda_get_path_idx(codec, path);
 		set_pin_target(codec, pin, PIN_OUT, false);
 		if (!nums) {
@@ -3837,6 +3870,7 @@ static void parse_digital(struct hda_codec *codec)
 			if (path) {
 				print_nid_path(codec, "digin", path);
 				path->active = true;
+				path->pin_enabled = true; /* no jack */
 				spec->dig_in_nid = dig_nid;
 				spec->digin_path = snd_hda_get_path_idx(codec, path);
 				set_pin_target(codec, pin, PIN_IN, false);
@@ -3896,6 +3930,148 @@ static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
 	return 1;
 }
 
+/* power up/down widgets in the all paths that match with the given NID
+ * as terminals (either start- or endpoint)
+ *
+ * returns the last changed NID, or zero if unchanged.
+ */
+static hda_nid_t set_path_power(struct hda_codec *codec, hda_nid_t nid,
+				int pin_state, int stream_state)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	hda_nid_t last, changed = 0;
+	struct nid_path *path;
+	int n;
+
+	for (n = 0; n < spec->paths.used; n++) {
+		path = snd_array_elem(&spec->paths, n);
+		if (path->path[0] == nid ||
+		    path->path[path->depth - 1] == nid) {
+			bool pin_old = path->pin_enabled;
+			bool stream_old = path->stream_enabled;
+
+			if (pin_state >= 0)
+				path->pin_enabled = pin_state;
+			if (stream_state >= 0)
+				path->stream_enabled = stream_state;
+			if (path->pin_enabled != pin_old ||
+			    path->stream_enabled != stream_old) {
+				last = path_power_update(codec, path, true);
+				if (last)
+					changed = last;
+			}
+		}
+	}
+	return changed;
+}
+
+/* power up/down the paths of the given pin according to the jack state;
+ * power = 0/1 : only power up/down if it matches with the jack state,
+ *       < 0   : force power up/down to follow the jack sate
+ *
+ * returns the last changed NID, or zero if unchanged.
+ */
+static hda_nid_t set_pin_power_jack(struct hda_codec *codec, hda_nid_t pin,
+				    int power)
+{
+	bool on;
+
+	if (!codec->power_mgmt)
+		return 0;
+
+	on = snd_hda_jack_detect_state(codec, pin) != HDA_JACK_NOT_PRESENT;
+	if (power >= 0 && on != power)
+		return 0;
+	return set_path_power(codec, pin, on, -1);
+}
+
+static void pin_power_callback(struct hda_codec *codec,
+			       struct hda_jack_callback *jack,
+			       bool on)
+{
+	if (jack && jack->tbl->nid)
+		sync_power_state_change(codec,
+					set_pin_power_jack(codec, jack->tbl->nid, on));
+}
+
+/* callback only doing power up -- called at first */
+static void pin_power_up_callback(struct hda_codec *codec,
+				  struct hda_jack_callback *jack)
+{
+	pin_power_callback(codec, jack, true);
+}
+
+/* callback only doing power down -- called at last */
+static void pin_power_down_callback(struct hda_codec *codec,
+				    struct hda_jack_callback *jack)
+{
+	pin_power_callback(codec, jack, false);
+}
+
+/* set up the power up/down callbacks */
+static void add_pin_power_ctls(struct hda_codec *codec, int num_pins,
+			       const hda_nid_t *pins, bool on)
+{
+	int i;
+	hda_jack_callback_fn cb =
+		on ? pin_power_up_callback : pin_power_down_callback;
+
+	for (i = 0; i < num_pins && pins[i]; i++) {
+		if (is_jack_detectable(codec, pins[i]))
+			snd_hda_jack_detect_enable_callback(codec, pins[i], cb);
+		else
+			set_path_power(codec, pins[i], true, -1);
+	}
+}
+
+/* enabled power callback to each available I/O pin with jack detections;
+ * the digital I/O pins are excluded because of the unreliable detectsion
+ */
+static void add_all_pin_power_ctls(struct hda_codec *codec, bool on)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i;
+
+	if (!codec->power_mgmt)
+		return;
+	add_pin_power_ctls(codec, cfg->line_outs, cfg->line_out_pins, on);
+	if (cfg->line_out_type != AUTO_PIN_HP_OUT)
+		add_pin_power_ctls(codec, cfg->hp_outs, cfg->hp_pins, on);
+	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT)
+		add_pin_power_ctls(codec, cfg->speaker_outs, cfg->speaker_pins, on);
+	for (i = 0; i < cfg->num_inputs; i++)
+		add_pin_power_ctls(codec, 1, &cfg->inputs[i].pin, on);
+}
+
+/* sync path power up/down with the jack states of given pins */
+static void sync_pin_power_ctls(struct hda_codec *codec, int num_pins,
+				const hda_nid_t *pins)
+{
+	int i;
+
+	for (i = 0; i < num_pins && pins[i]; i++)
+		if (is_jack_detectable(codec, pins[i]))
+			set_pin_power_jack(codec, pins[i], -1);
+}
+
+/* sync path power up/down with pins; called at init and resume */
+static void sync_all_pin_power_ctls(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i;
+
+	if (!codec->power_mgmt)
+		return;
+	sync_pin_power_ctls(codec, cfg->line_outs, cfg->line_out_pins);
+	if (cfg->line_out_type != AUTO_PIN_HP_OUT)
+		sync_pin_power_ctls(codec, cfg->hp_outs, cfg->hp_pins);
+	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT)
+		sync_pin_power_ctls(codec, cfg->speaker_outs, cfg->speaker_pins);
+	for (i = 0; i < cfg->num_inputs; i++)
+		sync_pin_power_ctls(codec, 1, &cfg->inputs[i].pin);
+}
 
 /*
  * Jack detections for HP auto-mute and mic-switch
@@ -3933,6 +4109,10 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 		if (!nid)
 			break;
 
+		oldval = snd_hda_codec_get_pin_target(codec, nid);
+		if (oldval & PIN_IN)
+			continue; /* no mute for inputs */
+
 		if (spec->auto_mute_via_amp) {
 			struct nid_path *path;
 			hda_nid_t mute_nid;
@@ -3947,29 +4127,33 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 				spec->mute_bits |= (1ULL << mute_nid);
 			else
 				spec->mute_bits &= ~(1ULL << mute_nid);
-			set_pin_eapd(codec, nid, !mute);
 			continue;
+		} else {
+			/* don't reset VREF value in case it's controlling
+			 * the amp (see alc861_fixup_asus_amp_vref_0f())
+			 */
+			if (spec->keep_vref_in_automute)
+				val = oldval & ~PIN_HP;
+			else
+				val = 0;
+			if (!mute)
+				val |= oldval;
+			/* here we call update_pin_ctl() so that the pinctl is
+			 * changed without changing the pinctl target value;
+			 * the original target value will be still referred at
+			 * the init / resume again
+			 */
+			update_pin_ctl(codec, nid, val);
 		}
 
-		oldval = snd_hda_codec_get_pin_target(codec, nid);
-		if (oldval & PIN_IN)
-			continue; /* no mute for inputs */
-		/* don't reset VREF value in case it's controlling
-		 * the amp (see alc861_fixup_asus_amp_vref_0f())
-		 */
-		if (spec->keep_vref_in_automute)
-			val = oldval & ~PIN_HP;
-		else
-			val = 0;
-		if (!mute)
-			val |= oldval;
-		/* here we call update_pin_ctl() so that the pinctl is changed
-		 * without changing the pinctl target value;
-		 * the original target value will be still referred at the
-		 * init / resume again
-		 */
-		update_pin_ctl(codec, nid, val);
 		set_pin_eapd(codec, nid, !mute);
+		if (codec->power_mgmt) {
+			bool on = !mute;
+			if (on)
+				on = snd_hda_jack_detect_state(codec, nid)
+					!= HDA_JACK_NOT_PRESENT;
+			set_path_power(codec, nid, on, -1);
+		}
 	}
 }
 
@@ -4466,6 +4650,21 @@ static void mute_all_mixer_nid(struct hda_codec *codec, hda_nid_t mix)
 }
 
 /**
+ * snd_hda_gen_stream_pm - Stream power management callback
+ * @codec: the HDA codec
+ * @nid: audio widget
+ * @on: power on/off flag
+ *
+ * Set this in patch_ops.stream_pm.  Only valid with power_mgmt flag.
+ */
+void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on)
+{
+	if (codec->power_mgmt)
+		set_path_power(codec, nid, -1, on);
+}
+EXPORT_SYMBOL_GPL(snd_hda_gen_stream_pm);
+
+/**
  * snd_hda_gen_parse_auto_config - Parse the given BIOS configuration and
  * set up the hda_gen_spec
  * @codec: the HDA codec
@@ -4549,6 +4748,9 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 	if (err < 0)
 		return err;
 
+	/* add power-down pin callbacks at first */
+	add_all_pin_power_ctls(codec, false);
+
 	spec->const_channel_count = spec->ext_channel_count;
 	/* check the multiple speaker and headphone pins */
 	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT)
@@ -4618,6 +4820,9 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 		}
 	}
 
+	/* add power-up pin callbacks at last */
+	add_all_pin_power_ctls(codec, true);
+
 	/* mute all aamix input initially */
 	if (spec->mixer_nid)
 		mute_all_mixer_nid(codec, spec->mixer_nid);
@@ -4625,7 +4830,7 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
  dig_only:
 	parse_digital(codec);
 
-	if (spec->power_down_unused)
+	if (spec->power_down_unused || codec->power_mgmt)
 		codec->power_filter = snd_hda_gen_path_power_filter;
 
 	if (!spec->no_analog && spec->beep_nid) {
@@ -5478,6 +5683,8 @@ int snd_hda_gen_init(struct hda_codec *codec)
 
 	clear_unsol_on_unused_pins(codec);
 
+	sync_all_pin_power_ctls(codec);
+
 	/* call init functions of standard auto-mute helpers */
 	update_automute_all(codec);
 
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index b211f889b335..54659b51fe16 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -46,7 +46,9 @@ struct nid_path {
 	unsigned char idx[MAX_NID_PATH_DEPTH];
 	unsigned char multi[MAX_NID_PATH_DEPTH];
 	unsigned int ctls[NID_PATH_NUM_CTLS]; /* NID_PATH_XXX_CTL */
-	bool active;
+	bool active:1;		/* activated by driver */
+	bool pin_enabled:1;	/* pins are enabled */
+	bool stream_enabled:1;	/* stream is active */
 };
 
 /* mic/line-in auto switching entry */
@@ -340,5 +342,6 @@ int snd_hda_gen_check_power_status(struct hda_codec *codec, hda_nid_t nid);
 unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 					   hda_nid_t nid,
 					   unsigned int power_state);
+void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on);
 
 #endif /* __SOUND_HDA_GENERIC_H */
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 2956a6ba6bf0..86b944a6b0ed 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4394,6 +4394,7 @@ static const struct hda_codec_ops stac_patch_ops = {
 #ifdef CONFIG_PM
 	.suspend = stac_suspend,
 #endif
+	.stream_pm = snd_hda_gen_stream_pm,
 	.reboot_notify = stac_shutup,
 };
 
@@ -4487,6 +4488,7 @@ static int patch_stac92hd73xx(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
+	codec->power_mgmt = 1;
 	spec->linear_tone_beep = 0;
 	spec->gen.mixer_nid = 0x1d;
 	spec->have_spdif_mux = 1;
@@ -4592,6 +4594,7 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 	codec->epss = 0; /* longer delay needed for D3 */
 
 	spec = codec->spec;
+	codec->power_mgmt = 1;
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
 	spec->gen.power_down_unused = 1;
@@ -4641,6 +4644,7 @@ static int patch_stac92hd95(struct hda_codec *codec)
 	codec->epss = 0; /* longer delay needed for D3 */
 
 	spec = codec->spec;
+	codec->power_mgmt = 1;
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
 	spec->gen.power_down_unused = 1;
@@ -4682,6 +4686,7 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
+	codec->power_mgmt = 1;
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
 	spec->gen.power_down_unused = 1;
-- 
2.3.3
