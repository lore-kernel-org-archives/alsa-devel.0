From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Rename power_mgmt flag with
	power_save_node
Date: Fri, 20 Mar 2015 18:23:25 +0100
Message-ID: <1426872205-30122-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B62260845
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 18:23:27 +0100 (CET)
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

David suggested that the name "power_mgmt" is too ambiguous.  Rename
the flag with a bit clearer one "power_save_node".

Also, add the corresponding description to HD-Audio.txt, too.

Reported-by: David Henningsson <david.henningsson@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/HD-Audio.txt |  6 +++++-
 sound/pci/hda/hda_codec.h             |  2 +-
 sound/pci/hda/hda_generic.c           | 30 +++++++++++++++---------------
 sound/pci/hda/patch_sigmatel.c        |  8 ++++----
 sound/pci/hda/patch_via.c             | 12 ++++++------
 5 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio.txt b/Documentation/sound/alsa/HD-Audio.txt
index 42a0a39b77e6..e7193aac669c 100644
--- a/Documentation/sound/alsa/HD-Audio.txt
+++ b/Documentation/sound/alsa/HD-Audio.txt
@@ -466,7 +466,11 @@ The generic parser supports the following hints:
 - add_jack_modes (bool): add "xxx Jack Mode" enum controls to each
   I/O jack for allowing to change the headphone amp and mic bias VREF
   capabilities
-- power_down_unused (bool): power down the unused widgets
+- power_save_node (bool): advanced power management for each widget,
+  controlling the power sate (D0/D3) of each widget node depending on
+  the actual pin and stream states
+- power_down_unused (bool): power down the unused widgets, a subset of
+  power_save_node, and will be dropped in future
 - add_hp_mic (bool): add the headphone to capture source if possible
 - hp_mic_detect (bool): enable/disable the hp/mic shared input for a
   single built-in mic case; default true
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 148e84ce61cf..ccf355d4a8fa 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -371,7 +371,7 @@ struct hda_codec {
 	unsigned int cached_write:1;	/* write only to caches */
 	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
 	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
-	unsigned int power_mgmt:1; /* advanced PM for each widget */
+	unsigned int power_save_node:1; /* advanced PM for each widget */
 #ifdef CONFIG_PM
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
 	atomic_t in_pm;		/* suspend/resume being performed */
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 94c7f43ad182..de4024db27b4 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -140,9 +140,9 @@ static void parse_user_hints(struct hda_codec *codec)
 	val = snd_hda_get_bool_hint(codec, "single_adc_amp");
 	if (val >= 0)
 		codec->single_adc_amp = !!val;
-	val = snd_hda_get_bool_hint(codec, "power_mgmt");
+	val = snd_hda_get_bool_hint(codec, "power_save_node");
 	if (val >= 0)
-		codec->power_mgmt = !!val;
+		codec->power_save_node = !!val;
 
 	val = snd_hda_get_bool_hint(codec, "auto_mute");
 	if (val >= 0)
@@ -661,7 +661,7 @@ static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
 		struct nid_path *path = snd_array_elem(&spec->paths, n);
 		if (!path->active)
 			continue;
-		if (codec->power_mgmt) {
+		if (codec->power_save_node) {
 			if (!path->stream_enabled && !path->pin_fixed)
 				continue;
 			/* ignore unplugged paths except for DAC/ADC */
@@ -879,8 +879,8 @@ void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 		path->active = false;
 
 	/* make sure the widget is powered up */
-	if (enable && (spec->power_down_unused || codec->power_mgmt))
-		path_power_update(codec, path, codec->power_mgmt);
+	if (enable && (spec->power_down_unused || codec->power_save_node))
+		path_power_update(codec, path, codec->power_save_node);
 
 	for (i = path->depth - 1; i >= 0; i--) {
 		hda_nid_t nid = path->path[i];
@@ -905,7 +905,7 @@ static void path_power_down_sync(struct hda_codec *codec, struct nid_path *path)
 {
 	struct hda_gen_spec *spec = codec->spec;
 
-	if (!(spec->power_down_unused || codec->power_mgmt) || path->active)
+	if (!(spec->power_down_unused || codec->power_save_node) || path->active)
 		return;
 	sync_power_state_change(codec, path_power_update(codec, path, true));
 }
@@ -3981,7 +3981,7 @@ static hda_nid_t set_pin_power_jack(struct hda_codec *codec, hda_nid_t pin,
 {
 	bool on;
 
-	if (!codec->power_mgmt)
+	if (!codec->power_save_node)
 		return 0;
 
 	on = snd_hda_jack_detect_state(codec, pin) != HDA_JACK_NOT_PRESENT;
@@ -4038,7 +4038,7 @@ static void add_all_pin_power_ctls(struct hda_codec *codec, bool on)
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i;
 
-	if (!codec->power_mgmt)
+	if (!codec->power_save_node)
 		return;
 	add_pin_power_ctls(codec, cfg->line_outs, cfg->line_out_pins, on);
 	if (cfg->line_out_type != AUTO_PIN_HP_OUT)
@@ -4067,7 +4067,7 @@ static void sync_all_pin_power_ctls(struct hda_codec *codec)
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i;
 
-	if (!codec->power_mgmt)
+	if (!codec->power_save_node)
 		return;
 	sync_pin_power_ctls(codec, cfg->line_outs, cfg->line_out_pins);
 	if (cfg->line_out_type != AUTO_PIN_HP_OUT)
@@ -4111,7 +4111,7 @@ static int add_fake_beep_paths(struct hda_codec *codec)
 	hda_nid_t nid = spec->beep_nid;
 	int err;
 
-	if (!codec->power_mgmt || !nid)
+	if (!codec->power_save_node || !nid)
 		return 0;
 	err = add_fake_paths(codec, nid, cfg->line_outs, cfg->line_out_pins);
 	if (err < 0)
@@ -4232,7 +4232,7 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 		}
 
 		set_pin_eapd(codec, nid, !mute);
-		if (codec->power_mgmt) {
+		if (codec->power_save_node) {
 			bool on = !mute;
 			if (on)
 				on = snd_hda_jack_detect_state(codec, nid)
@@ -4740,11 +4740,11 @@ static void mute_all_mixer_nid(struct hda_codec *codec, hda_nid_t mix)
  * @nid: audio widget
  * @on: power on/off flag
  *
- * Set this in patch_ops.stream_pm.  Only valid with power_mgmt flag.
+ * Set this in patch_ops.stream_pm.  Only valid with power_save_node flag.
  */
 void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on)
 {
-	if (codec->power_mgmt)
+	if (codec->power_save_node)
 		set_path_power(codec, nid, -1, on);
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_stream_pm);
@@ -4915,14 +4915,14 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
  dig_only:
 	parse_digital(codec);
 
-	if (spec->power_down_unused || codec->power_mgmt)
+	if (spec->power_down_unused || codec->power_save_node)
 		codec->power_filter = snd_hda_gen_path_power_filter;
 
 	if (!spec->no_analog && spec->beep_nid) {
 		err = snd_hda_attach_beep_device(codec, spec->beep_nid);
 		if (err < 0)
 			return err;
-		if (codec->beep && codec->power_mgmt) {
+		if (codec->beep && codec->power_save_node) {
 			err = add_fake_beep_paths(codec);
 			if (err < 0)
 				return err;
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 7e531d5cde51..5b7c173adcb8 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4494,7 +4494,7 @@ static int patch_stac92hd73xx(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
-	codec->power_mgmt = 1;
+	codec->power_save_node = 1;
 	spec->linear_tone_beep = 0;
 	spec->gen.mixer_nid = 0x1d;
 	spec->have_spdif_mux = 1;
@@ -4600,7 +4600,7 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 	codec->epss = 0; /* longer delay needed for D3 */
 
 	spec = codec->spec;
-	codec->power_mgmt = 1;
+	codec->power_save_node = 1;
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
 	spec->gen.power_down_unused = 1;
@@ -4650,7 +4650,7 @@ static int patch_stac92hd95(struct hda_codec *codec)
 	codec->epss = 0; /* longer delay needed for D3 */
 
 	spec = codec->spec;
-	codec->power_mgmt = 1;
+	codec->power_save_node = 1;
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
 	spec->gen.power_down_unused = 1;
@@ -4692,7 +4692,7 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
-	codec->power_mgmt = 1;
+	codec->power_save_node = 1;
 	spec->linear_tone_beep = 0;
 	spec->gen.own_eapd_ctl = 1;
 	spec->gen.power_down_unused = 1;
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index d5d1dca4f11b..485663bb9101 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -133,7 +133,7 @@ static struct via_spec *via_new_spec(struct hda_codec *codec)
 	spec->gen.keep_eapd_on = 1;
 	spec->gen.pcm_playback_hook = via_playback_pcm_hook;
 	spec->gen.add_stereo_mix_input = HDA_HINT_STEREO_MIX_AUTO;
-	codec->power_mgmt = 1;
+	codec->power_save_node = 1;
 	spec->gen.power_down_unused = 1;
 	return spec;
 }
@@ -236,7 +236,7 @@ static int via_pin_power_ctl_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	ucontrol->value.enumerated.item[0] = codec->power_mgmt;
+	ucontrol->value.enumerated.item[0] = codec->power_save_node;
 	return 0;
 }
 
@@ -247,9 +247,9 @@ static int via_pin_power_ctl_put(struct snd_kcontrol *kcontrol,
 	struct via_spec *spec = codec->spec;
 	bool val = !!ucontrol->value.enumerated.item[0];
 
-	if (val == codec->power_mgmt)
+	if (val == codec->power_save_node)
 		return 0;
-	codec->power_mgmt = val;
+	codec->power_save_node = val;
 	spec->gen.power_down_unused = val;
 	analog_low_current_mode(codec);
 	return 1;
@@ -295,7 +295,7 @@ static void __analog_low_current_mode(struct hda_codec *codec, bool force)
 	bool enable;
 	unsigned int verb, parm;
 
-	if (!codec->power_mgmt)
+	if (!codec->power_save_node)
 		enable = false;
 	else
 		enable = is_aa_path_mute(codec) && !spec->gen.active_streams;
@@ -517,7 +517,7 @@ static int via_parse_auto_config(struct hda_codec *codec)
 		return err;
 
 	/* disable widget PM at start for compatibility */
-	codec->power_mgmt = 0;
+	codec->power_save_node = 0;
 	spec->gen.power_down_unused = 0;
 	return 0;
 }
-- 
2.3.3
