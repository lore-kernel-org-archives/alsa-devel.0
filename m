From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 044/112] ALSA: hda - More generic auto-mic
	switching for Realtek codecs
Date: Tue,  8 Jan 2013 12:38:37 +0100
Message-ID: <1357645185-7645-45-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 94F3C2651C1
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D7D49A5254
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

This patch extends the capability of the auto-mic feature.
Instead of limiting the automatic input-source selection only to the
mics (internal, external and dock mics), allow it for generic inputs,
e.g. switching between the rear line-in and the front mic.

The logic is to check the attribute and location of input pins, and
enable the automatic selection feature only if all such pins are in
different locations (e.g. internal, front, rear, etc) and line-in or
mic pins.  That is, if multiple input pins are assigned to a single
location, the feature isn't enabled because we don't know the
priority.

(You may wonder why this restriction doesn't exist for the headphone
 automute.  The reason is that the output case is different from the
 input: the input source is an exclusive selection while the output
 can be multiplexed.)

Note that, for avoiding regressions, the line-in auto switching
feature isn't activated as default.  It has to be set explicitly via
spec->line_in_auto_switch flag in a fixup code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 143 +++++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 65 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fecd89a..2aaecdc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/sort.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include "hda_codec.h"
@@ -90,6 +91,13 @@ struct alc_multi_io {
 #define ALC_FIXUP_ACT_INIT	HDA_FIXUP_ACT_INIT
 #define ALC_FIXUP_ACT_BUILD	HDA_FIXUP_ACT_BUILD
 
+#define MAX_AUTO_MIC_PINS	3
+
+struct alc_automic_entry {
+	hda_nid_t pin;		/* pin */
+	int idx;		/* imux index, -1 = invalid */
+	unsigned int attr;	/* pin attribute (INPUT_PIN_ATTR_*) */
+};
 
 #define MAX_NID_PATH_DEPTH	5
 
@@ -159,9 +167,6 @@ struct alc_spec {
 	/* capture source */
 	struct hda_input_mux input_mux;
 	unsigned int cur_mux[3];
-	hda_nid_t ext_mic_pin;
-	hda_nid_t dock_mic_pin;
-	hda_nid_t int_mic_pin;
 
 	/* channel model */
 	const struct hda_channel_mode *channel_mode;
@@ -179,7 +184,6 @@ struct alc_spec {
 	hda_nid_t private_dac_nids[AUTO_CFG_MAX_OUTS];
 	hda_nid_t imux_pins[HDA_MAX_NUM_INPUTS];
 	unsigned int dyn_adc_idx[HDA_MAX_NUM_INPUTS];
-	int int_mic_idx, ext_mic_idx, dock_mic_idx; /* for auto-mic */
 	hda_nid_t inv_dmic_pin;
 	hda_nid_t shared_mic_vref_pin;
 
@@ -190,6 +194,10 @@ struct alc_spec {
 	/* path list */
 	struct snd_array paths;
 
+	/* auto-mic stuff */
+	int am_num_entries;
+	struct alc_automic_entry am_entry[MAX_AUTO_MIC_PINS];
+
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
 #ifdef CONFIG_PM
@@ -210,6 +218,7 @@ struct alc_spec {
 	unsigned int automute_speaker_possible:1; /* there are speakers and either LO or HP */
 	unsigned int automute_lo_possible:1;	  /* there are line outs and HP */
 	unsigned int keep_vref_in_automute:1; /* Don't clear VREF in automute */
+	unsigned int line_in_auto_switch:1; /* allow line-in auto switch */
 
 	/* other flags */
 	unsigned int need_dac_fix:1; /* need to limit DACs for multi channels */
@@ -608,20 +617,18 @@ static void alc_line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack
 static void alc_mic_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct alc_spec *spec = codec->spec;
-	hda_nid_t *pins = spec->imux_pins;
+	int i;
 
 	if (!spec->auto_mic)
 		return;
-	if (snd_BUG_ON(spec->int_mic_idx < 0 || spec->ext_mic_idx < 0))
-		return;
 
-	if (snd_hda_jack_detect(codec, pins[spec->ext_mic_idx]))
-		alc_mux_select(codec, 0, spec->ext_mic_idx, false);
-	else if (spec->dock_mic_idx >= 0 &&
-		   snd_hda_jack_detect(codec, pins[spec->dock_mic_idx]))
-		alc_mux_select(codec, 0, spec->dock_mic_idx, false);
-	else
-		alc_mux_select(codec, 0, spec->int_mic_idx, false);
+	for (i = spec->am_num_entries - 1; i > 0; i--) {
+		if (snd_hda_jack_detect(codec, spec->am_entry[i].pin)) {
+			alc_mux_select(codec, 0, spec->am_entry[i].idx, false);
+			return;
+		}
+	}
+	alc_mux_select(codec, 0, spec->am_entry[0].idx, false);
 }
 
 /* update the master volume per volume-knob's unsol event */
@@ -970,26 +977,33 @@ static bool alc_auto_mic_check_imux(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	const struct hda_input_mux *imux;
+	int i;
 
 	imux = &spec->input_mux;
-	spec->ext_mic_idx = find_idx_in_nid_list(spec->ext_mic_pin,
-					spec->imux_pins, imux->num_items);
-	spec->int_mic_idx = find_idx_in_nid_list(spec->int_mic_pin,
-					spec->imux_pins, imux->num_items);
-	spec->dock_mic_idx = find_idx_in_nid_list(spec->dock_mic_pin,
-					spec->imux_pins, imux->num_items);
-	if (spec->ext_mic_idx < 0 || spec->int_mic_idx < 0)
-		return false; /* no corresponding imux */
-
-	snd_hda_jack_detect_enable_callback(codec, spec->ext_mic_pin,
-					    ALC_MIC_EVENT, alc_mic_automute);
-	if (spec->dock_mic_pin)
-		snd_hda_jack_detect_enable_callback(codec, spec->dock_mic_pin,
+	for (i = 0; i < spec->am_num_entries; i++) {
+		spec->am_entry[i].idx =
+			find_idx_in_nid_list(spec->am_entry[i].pin,
+					     spec->imux_pins, imux->num_items);
+		if (spec->am_entry[i].idx < 0)
+			return false; /* no corresponding imux */
+	}
+
+	/* we don't need the jack detection for the first pin */
+	for (i = 1; i < spec->am_num_entries; i++)
+		snd_hda_jack_detect_enable_callback(codec,
+						    spec->am_entry[i].pin,
 						    ALC_MIC_EVENT,
 						    alc_mic_automute);
 	return true;
 }
 
+static int compare_attr(const void *ap, const void *bp)
+{
+	const struct alc_automic_entry *a = ap;
+	const struct alc_automic_entry *b = bp;
+	return (int)(a->attr - b->attr);
+}
+
 /*
  * Check the availability of auto-mic switch;
  * Set up if really supported
@@ -998,66 +1012,63 @@ static int alc_init_auto_mic(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
-	hda_nid_t fixed, ext, dock;
-	int i;
+	unsigned int types;
+	int i, num_pins;
 
-	spec->ext_mic_idx = spec->int_mic_idx = spec->dock_mic_idx = -1;
-
-	fixed = ext = dock = 0;
+	types = 0;
+	num_pins = 0;
 	for (i = 0; i < cfg->num_inputs; i++) {
 		hda_nid_t nid = cfg->inputs[i].pin;
-		unsigned int defcfg;
-		defcfg = snd_hda_codec_get_pincfg(codec, nid);
-		switch (snd_hda_get_input_pin_attr(defcfg)) {
+		unsigned int attr;
+		attr = snd_hda_codec_get_pincfg(codec, nid);
+		attr = snd_hda_get_input_pin_attr(attr);
+		if (types & (1 << attr))
+			return 0; /* already occupied */
+		switch (attr) {
 		case INPUT_PIN_ATTR_INT:
-			if (fixed)
-				return 0; /* already occupied */
 			if (cfg->inputs[i].type != AUTO_PIN_MIC)
 				return 0; /* invalid type */
-			fixed = nid;
 			break;
 		case INPUT_PIN_ATTR_UNUSED:
 			return 0; /* invalid entry */
-		case INPUT_PIN_ATTR_DOCK:
-			if (dock)
-				return 0; /* already occupied */
-			if (cfg->inputs[i].type > AUTO_PIN_LINE_IN)
-				return 0; /* invalid type */
-			dock = nid;
-			break;
 		default:
-			if (ext)
-				return 0; /* already occupied */
-			if (cfg->inputs[i].type != AUTO_PIN_MIC)
+			if (cfg->inputs[i].type > AUTO_PIN_LINE_IN)
 				return 0; /* invalid type */
-			ext = nid;
+			if (!spec->line_in_auto_switch &&
+			    cfg->inputs[i].type != AUTO_PIN_MIC)
+				return 0; /* only mic is allowed */
+			if (!is_jack_detectable(codec, nid))
+				return 0; /* no unsol support */
 			break;
 		}
+		if (num_pins >= MAX_AUTO_MIC_PINS)
+			return 0;
+		types |= (1 << attr);
+		spec->am_entry[num_pins].pin = nid;
+		spec->am_entry[num_pins].attr = attr;
+		num_pins++;
 	}
-	if (!ext && dock) {
-		ext = dock;
-		dock = 0;
-	}
-	if (!ext || !fixed)
+
+	if (num_pins < 2)
 		return 0;
-	if (!is_jack_detectable(codec, ext))
-		return 0; /* no unsol support */
-	if (dock && !is_jack_detectable(codec, dock))
-		return 0; /* no unsol support */
 
-	/* check imux indices */
-	spec->ext_mic_pin = ext;
-	spec->int_mic_pin = fixed;
-	spec->dock_mic_pin = dock;
+	spec->am_num_entries = num_pins;
+	/* sort the am_entry in the order of attr so that the pin with a
+	 * higher attr will be selected when the jack is plugged.
+	 */
+	sort(spec->am_entry, num_pins, sizeof(spec->am_entry[0]),
+	     compare_attr, NULL);
 
 	if (!alc_auto_mic_check_imux(codec))
 		return 0;
 
 	spec->auto_mic = 1;
 	spec->num_adc_nids = 1;
-	spec->cur_mux[0] = spec->int_mic_idx;
+	spec->cur_mux[0] = spec->am_entry[0].idx;
 	snd_printdd("realtek: Enable auto-mic switch on NID 0x%x/0x%x/0x%x\n",
-		    ext, fixed, dock);
+		    spec->am_entry[0].pin,
+		    spec->am_entry[1].pin,
+		    spec->am_entry[2].pin);
 
 	return 0;
 }
@@ -6193,8 +6204,10 @@ static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
 {
 	struct alc_spec *spec = codec->spec;
 
+	if (snd_BUG_ON(!spec->am_entry[1].pin || !spec->autocfg.hp_pins[0]))
+		return;
 	if (action == ALC_FIXUP_ACT_PROBE)
-		snd_hda_jack_set_gating_jack(codec, spec->ext_mic_pin,
+		snd_hda_jack_set_gating_jack(codec, spec->am_entry[1].pin,
 					     spec->autocfg.hp_pins[0]);
 }
 
-- 
1.8.0.1
