From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: hda - Unify input label creations in
	generic parser
Date: Fri, 18 Jan 2013 11:24:01 +0100
Message-ID: <1358504643-13593-3-git-send-email-tiwai@suse.de>
References: <1358504643-13593-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 259C1265E7F
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 11:24:05 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D91EAA3A4A
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 11:24:04 +0100 (CET)
In-Reply-To: <1358504643-13593-1-git-send-email-tiwai@suse.de>
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

There are a few places creating the labels and indices of kctls for
each input pin in the current generic parser code.  This is redundant
and makes harder to maintain.  Let's create the labels and indices at
once and keep them in hda_gen_spec.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 91 +++++++++++++++++++++++++++------------------
 sound/pci/hda/hda_generic.h |  2 +
 2 files changed, 56 insertions(+), 37 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 7444d2e..ebb5584 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2514,6 +2514,38 @@ static int parse_capture_source(struct hda_codec *codec, hda_nid_t pin,
  * create playback/capture controls for input pins
  */
 
+/* fill the label for each input at first */
+static int fill_input_pin_labels(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	const struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i;
+
+	for (i = 0; i < cfg->num_inputs; i++) {
+		hda_nid_t pin = cfg->inputs[i].pin;
+		const char *label;
+		int j, idx;
+
+		if (!is_input_pin(codec, pin))
+			continue;
+
+		label = hda_get_autocfg_input_label(codec, cfg, i);
+		idx = 0;
+		for (j = i; j >= 0; j--) {
+			if (spec->input_labels[j] &&
+			    !strcmp(spec->input_labels[j], label)) {
+				idx = spec->input_label_idxs[j] + 1;
+				break;
+			}
+		}
+
+		spec->input_labels[i] = label;
+		spec->input_label_idxs[i] = idx;
+	}
+
+	return 0;
+}
+
 #define CFG_IDX_MIX	99	/* a dummy cfg->input idx for stereo mix */
 
 static int create_input_ctls(struct hda_codec *codec)
@@ -2522,29 +2554,24 @@ static int create_input_ctls(struct hda_codec *codec)
 	const struct auto_pin_cfg *cfg = &spec->autocfg;
 	hda_nid_t mixer = spec->mixer_nid;
 	int num_adcs;
-	int i, err, type_idx = 0;
-	const char *prev_label = NULL;
+	int i, err;
 	unsigned int val;
 
 	num_adcs = fill_adc_nids(codec);
 	if (num_adcs < 0)
 		return 0;
 
+	err = fill_input_pin_labels(codec);
+	if (err < 0)
+		return err;
+
 	for (i = 0; i < cfg->num_inputs; i++) {
 		hda_nid_t pin;
-		const char *label;
 
 		pin = cfg->inputs[i].pin;
 		if (!is_input_pin(codec, pin))
 			continue;
 
-		label = hda_get_autocfg_input_label(codec, cfg, i);
-		if (prev_label && !strcmp(label, prev_label))
-			type_idx++;
-		else
-			type_idx = 0;
-		prev_label = label;
-
 		val = PIN_IN;
 		if (cfg->inputs[i].type == AUTO_PIN_MIC)
 			val |= snd_hda_get_default_vref(codec, pin);
@@ -2553,14 +2580,16 @@ static int create_input_ctls(struct hda_codec *codec)
 		if (mixer) {
 			if (is_reachable_path(codec, pin, mixer)) {
 				err = new_analog_input(codec, i, pin,
-						       label, type_idx, mixer);
+						       spec->input_labels[i],
+						       spec->input_label_idxs[i],
+						       mixer);
 				if (err < 0)
 					return err;
 			}
 		}
 
-		err = parse_capture_source(codec, pin, i,
-					   num_adcs, label, -mixer);
+		err = parse_capture_source(codec, pin, i, num_adcs,
+					   spec->input_labels[i], -mixer);
 		if (err < 0)
 			return err;
 
@@ -2907,26 +2936,22 @@ static int create_multi_cap_vol_ctl(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct hda_input_mux *imux = &spec->input_mux;
-	int i, err, type, type_idx = 0;
-	const char *prev_label = NULL;
+	int i, err, type;
 
 	for (i = 0; i < imux->num_items; i++) {
-		const char *label;
 		bool inv_dmic;
+		int idx;
 
-		if (imux->items[i].index >= spec->autocfg.num_inputs)
+		idx = imux->items[i].index;
+		if (idx >= spec->autocfg.num_inputs)
 			continue;
-		label = hda_get_autocfg_input_label(codec, &spec->autocfg,
-						    imux->items[i].index);
-		if (prev_label && !strcmp(label, prev_label))
-			type_idx++;
-		else
-			type_idx = 0;
-		prev_label = label;
 		inv_dmic = is_inv_dmic_pin(codec, spec->imux_pins[i]);
 
 		for (type = 0; type < 2; type++) {
-			err = add_single_cap_ctl(codec, label, type_idx, type,
+			err = add_single_cap_ctl(codec,
+						 spec->input_labels[idx],
+						 spec->input_label_idxs[idx],
+						 type,
 						 get_first_cap_ctl(codec, i, type),
 						 inv_dmic);
 			if (err < 0)
@@ -3012,16 +3037,13 @@ static int parse_mic_boost(struct hda_codec *codec)
 	struct hda_gen_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i, err;
-	int type_idx = 0;
 	hda_nid_t nid;
-	const char *prev_label = NULL;
 
 	for (i = 0; i < cfg->num_inputs; i++) {
 		if (cfg->inputs[i].type > AUTO_PIN_MIC)
 			break;
 		nid = cfg->inputs[i].pin;
 		if (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) {
-			const char *label;
 			char boost_label[44];
 			struct nid_path *path;
 			unsigned int val;
@@ -3029,18 +3051,13 @@ static int parse_mic_boost(struct hda_codec *codec)
 			if (!nid_has_volume(codec, nid, HDA_INPUT))
 				continue;
 
-			label = hda_get_autocfg_input_label(codec, cfg, i);
-			if (prev_label && !strcmp(label, prev_label))
-				type_idx++;
-			else
-				type_idx = 0;
-			prev_label = label;
-
 			snprintf(boost_label, sizeof(boost_label),
-				 "%s Boost Volume", label);
+				 "%s Boost Volume",
+				 spec->input_labels[i]);
 			val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT);
 			err = add_control(spec, HDA_CTL_WIDGET_VOL,
-					  boost_label, type_idx, val);
+					  boost_label,
+					  spec->input_label_idxs[i], val);
 			if (err < 0)
 				return err;
 
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 7b14e9c..f6b88cd 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -105,6 +105,8 @@ struct hda_gen_spec {
 	hda_nid_t adc_nids[AUTO_CFG_MAX_OUTS];
 	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
 	hda_nid_t mixer_nid;		/* analog-mixer NID */
+	const char *input_labels[AUTO_CFG_MAX_OUTS];
+	int input_label_idxs[AUTO_CFG_MAX_OUTS];
 
 	/* capture setup for dynamic dual-adc switch */
 	hda_nid_t cur_adc;
-- 
1.8.1
