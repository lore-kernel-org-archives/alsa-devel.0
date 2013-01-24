From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/13] ALSA: hda - Implement path-based power
	filter to the generic parser
Date: Thu, 24 Jan 2013 18:38:01 +0100
Message-ID: <1359049082-5880-13-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B67462616FC
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 03762A51C9
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
In-Reply-To: <1359049082-5880-1-git-send-email-tiwai@suse.de>
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

This patch adds a better power filter hook for powering down unused
widgets in the generic parser.

The feature is enabled by setting hda_gen_spec.power_down_unused
flag.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 73 +++++++++++++++++++++++++++++++++++++++++----
 sound/pci/hda/hda_generic.h |  1 +
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 31ffd66..19d014a 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/sort.h>
+#include <linux/delay.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/bitops.h>
@@ -153,6 +154,9 @@ static void parse_user_hints(struct hda_codec *codec)
 	val = snd_hda_get_bool_hint(codec, "add_in_jack_modes");
 	if (val >= 0)
 		spec->add_in_jack_modes = !!val;
+	val = snd_hda_get_bool_hint(codec, "power_down_unused");
+	if (val >= 0)
+		spec->power_down_unused = !!val;
 
 	if (!snd_hda_get_int_hint(codec, "mixer_nid", &val))
 		spec->mixer_nid = val;
@@ -700,14 +704,23 @@ static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
 void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 			   bool enable, bool add_aamix)
 {
+	struct hda_gen_spec *spec = codec->spec;
 	int i;
 
 	if (!enable)
 		path->active = false;
 
 	for (i = path->depth - 1; i >= 0; i--) {
+		hda_nid_t nid = path->path[i];
+		if (enable && spec->power_down_unused) {
+			/* make sure the widget is powered up */
+			if (!snd_hda_check_power_state(codec, nid, AC_PWRST_D0))
+				snd_hda_codec_write(codec, nid, 0,
+						    AC_VERB_SET_POWER_STATE,
+						    AC_PWRST_D0);
+		}
 		if (enable && path->multi[i])
-			snd_hda_codec_write_cache(codec, path->path[i], 0,
+			snd_hda_codec_write_cache(codec, nid, 0,
 					    AC_VERB_SET_CONNECT_SEL,
 					    path->idx[i]);
 		if (has_amp_in(codec, path, i))
@@ -721,6 +734,33 @@ void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 }
 EXPORT_SYMBOL_HDA(snd_hda_activate_path);
 
+/* if the given path is inactive, put widgets into D3 (only if suitable) */
+static void path_power_down_sync(struct hda_codec *codec, struct nid_path *path)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	bool changed;
+	int i;
+
+	if (!spec->power_down_unused || path->active)
+		return;
+
+	for (i = 0; i < path->depth; i++) {
+		hda_nid_t nid = path->path[i];
+		if (!snd_hda_check_power_state(codec, nid, AC_PWRST_D3)) {
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_POWER_STATE,
+					    AC_PWRST_D3);
+			changed = true;
+		}
+	}
+
+	if (changed) {
+		msleep(10);
+		snd_hda_codec_read(codec, path->path[0], 0,
+				   AC_VERB_GET_POWER_STATE, 0);
+	}
+}
+
 /* turn on/off EAPD on the given pin */
 static void set_pin_eapd(struct hda_codec *codec, hda_nid_t pin, bool enable)
 {
@@ -2007,6 +2047,7 @@ static int set_multi_io(struct hda_codec *codec, int idx, bool output)
 		set_pin_eapd(codec, nid, false);
 		snd_hda_activate_path(codec, path, false, true);
 		set_pin_target(codec, nid, spec->multi_io[idx].ctl_in, true);
+		path_power_down_sync(codec, path);
 	}
 
 	/* update jack retasking in case it modifies any of them */
@@ -2093,9 +2134,11 @@ static void update_aamix_paths(struct hda_codec *codec, bool do_mix,
 	if (do_mix) {
 		snd_hda_activate_path(codec, nomix_path, false, true);
 		snd_hda_activate_path(codec, mix_path, true, true);
+		path_power_down_sync(codec, nomix_path);
 	} else {
 		snd_hda_activate_path(codec, mix_path, false, true);
 		snd_hda_activate_path(codec, nomix_path, true, true);
+		path_power_down_sync(codec, mix_path);
 	}
 }
 
@@ -3356,7 +3399,7 @@ static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
 {
 	struct hda_gen_spec *spec = codec->spec;
 	const struct hda_input_mux *imux;
-	struct nid_path *path;
+	struct nid_path *old_path, *path;
 
 	imux = &spec->input_mux;
 	if (!imux->num_items)
@@ -3367,11 +3410,11 @@ static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
 	if (spec->cur_mux[adc_idx] == idx)
 		return 0;
 
-	path = get_input_path(codec, adc_idx, spec->cur_mux[adc_idx]);
-	if (!path)
+	old_path = get_input_path(codec, adc_idx, spec->cur_mux[adc_idx]);
+	if (!old_path)
 		return 0;
-	if (path->active)
-		snd_hda_activate_path(codec, path, false, false);
+	if (old_path->active)
+		snd_hda_activate_path(codec, old_path, false, false);
 
 	spec->cur_mux[adc_idx] = idx;
 
@@ -3389,6 +3432,7 @@ static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
 	snd_hda_activate_path(codec, path, true, false);
 	if (spec->cap_sync_hook)
 		spec->cap_sync_hook(codec, NULL);
+	path_power_down_sync(codec, old_path);
 	return 1;
 }
 
@@ -3853,6 +3897,20 @@ static int check_auto_mic_availability(struct hda_codec *codec)
 	return 0;
 }
 
+/* power_filter hook; make inactive widgets into power down */
+static unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
+						  hda_nid_t nid,
+						  unsigned int power_state)
+{
+	if (power_state != AC_PWRST_D0)
+		return power_state;
+	if (get_wcaps_type(get_wcaps(codec, nid)) >= AC_WID_POWER)
+		return power_state;
+	if (is_active_nid(codec, nid, HDA_OUTPUT, 0))
+		return power_state;
+	return AC_PWRST_D3;
+}
+
 
 /*
  * Parse the given BIOS configuration and set up the hda_gen_spec
@@ -3980,6 +4038,9 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
  dig_only:
 	parse_digital(codec);
 
+	if (spec->power_down_unused)
+		codec->power_filter = snd_hda_gen_path_power_filter;
+
 	return 1;
 }
 EXPORT_SYMBOL_HDA(snd_hda_gen_parse_auto_config);
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index d226856..065fcc7 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -211,6 +211,7 @@ struct hda_gen_spec {
 	unsigned int add_stereo_mix_input:1; /* add aamix as a capture src */
 	unsigned int add_out_jack_modes:1; /* add output jack mode enum ctls */
 	unsigned int add_in_jack_modes:1; /* add input jack mode enum ctls */
+	unsigned int power_down_unused:1; /* power down unused widgets */
 
 	/* other internal flags */
 	unsigned int no_analog:1; /* digital I/O only */
-- 
1.8.1.1
