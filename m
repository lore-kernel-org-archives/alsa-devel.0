From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 042/112] ALSA: hda/realtek - Fix split stereo
	dmic code
Date: Tue,  8 Jan 2013 12:38:35 +0100
Message-ID: <1357645185-7645-43-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D96A2651BD
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id CD307A5245
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

The previous commit passed an utterly wrong value for checking the
split inv dmic pin.  This patch fixes it and also tries to remove
inv_dmic_split_idx field.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 58 +++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1beb797..fecd89a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -182,7 +182,6 @@ struct alc_spec {
 	int int_mic_idx, ext_mic_idx, dock_mic_idx; /* for auto-mic */
 	hda_nid_t inv_dmic_pin;
 	hda_nid_t shared_mic_vref_pin;
-	int inv_dmic_split_idx;	/* used internally for inv_dmic_split */
 
 	/* DAC list */
 	int num_all_dacs;
@@ -2552,23 +2551,19 @@ static int parse_capvol_in_path(struct hda_codec *codec, struct nid_path *path)
 static unsigned int amp_val_replace_channels(unsigned int val, unsigned int chs);
 
 static int add_single_cap_ctl(struct hda_codec *codec, const char *label,
-			      int idx, bool is_switch, unsigned int ctl)
+			      int idx, bool is_switch, unsigned int ctl,
+			      bool inv_dmic)
 {
 	struct alc_spec *spec = codec->spec;
 	char tmpname[44];
 	int type = is_switch ? ALC_CTL_WIDGET_MUTE : ALC_CTL_WIDGET_VOL;
 	const char *sfx = is_switch ? "Switch" : "Volume";
-	unsigned int chs;
+	unsigned int chs = inv_dmic ? 1 : 3;
 	int err;
 
 	if (!ctl)
 		return 0;
 
-	if (idx == spec->inv_dmic_split_idx)
-		chs = 1;
-	else
-		chs = 3;
-
 	if (label)
 		snprintf(tmpname, sizeof(tmpname),
 			 "%s Capture %s", label, sfx);
@@ -2591,15 +2586,36 @@ static int add_single_cap_ctl(struct hda_codec *codec, const char *label,
 			   amp_val_replace_channels(ctl, 2));
 }
 
+static bool is_inv_dmic_pin(struct hda_codec *codec, hda_nid_t nid)
+{
+	struct alc_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	unsigned int val;
+	int i;
+
+	if (!spec->inv_dmic_split)
+		return false;
+	for (i = 0; i < cfg->num_inputs; i++) {
+		if (cfg->inputs[i].pin != nid)
+			continue;
+		if (cfg->inputs[i].type != AUTO_PIN_MIC)
+			return false;
+		val = snd_hda_codec_get_pincfg(codec, nid);
+		return snd_hda_get_input_pin_attr(val) == INPUT_PIN_ATTR_INT;
+	}
+	return false;
+}
+
 /* create single (and simple) capture volume and switch controls */
 static int create_single_cap_vol_ctl(struct hda_codec *codec, int idx,
-				     unsigned int vol_ctl, unsigned int sw_ctl)
+				     unsigned int vol_ctl, unsigned int sw_ctl,
+				     bool inv_dmic)
 {
 	int err;
-	err = add_single_cap_ctl(codec, NULL, idx, false, vol_ctl);
+	err = add_single_cap_ctl(codec, NULL, idx, false, vol_ctl, inv_dmic);
 	if (err < 0)
 		return err;
-	err = add_single_cap_ctl(codec, NULL, idx, true, sw_ctl);
+	err = add_single_cap_ctl(codec, NULL, idx, true, sw_ctl, inv_dmic);
 	if (err < 0)
 		return err;
 	return 0;
@@ -2665,16 +2681,19 @@ static int create_multi_cap_vol_ctl(struct hda_codec *codec)
 
 	for (i = 0; i < imux->num_items; i++) {
 		const char *label;
+		bool inv_dmic;
 		label = hda_get_autocfg_input_label(codec, &spec->autocfg, i);
 		if (prev_label && !strcmp(label, prev_label))
 			type_idx++;
 		else
 			type_idx = 0;
 		prev_label = label;
+		inv_dmic = is_inv_dmic_pin(codec, spec->imux_pins[i]);
 
 		for (type = 0; type < 2; type++) {
 			err = add_single_cap_ctl(codec, label, type_idx, type,
-						 get_first_cap_ctl(codec, i, type));
+						 get_first_cap_ctl(codec, i, type),
+						 inv_dmic);
 			if (err < 0)
 				return err;
 		}
@@ -2703,6 +2722,7 @@ static int create_capture_mixers(struct hda_codec *codec)
 
 	for (n = 0; n < nums; n++) {
 		bool multi = false;
+		bool inv_dmic = false;
 		int vol, sw;
 
 		vol = sw = 0;
@@ -2721,10 +2741,13 @@ static int create_capture_mixers(struct hda_codec *codec)
 				sw = path->ctls[NID_PATH_MUTE_CTL];
 			else if (sw != path->ctls[NID_PATH_MUTE_CTL])
 				multi = true;
+			if (is_inv_dmic_pin(codec, spec->imux_pins[i]))
+				inv_dmic = true;
 		}
 
 		if (!multi)
-			err = create_single_cap_vol_ctl(codec, n, vol, sw);
+			err = create_single_cap_vol_ctl(codec, n, vol, sw,
+							inv_dmic);
 		else if (!spec->multi_cap_vol)
 			err = create_bind_cap_vol_ctl(codec, n, vol, sw);
 		else
@@ -2751,7 +2774,6 @@ static int alc_auto_create_input_ctls(struct hda_codec *codec)
 	if (num_adcs < 0)
 		return 0;
 
-	spec->inv_dmic_split_idx = -1;
 	for (i = 0; i < cfg->num_inputs; i++) {
 		hda_nid_t pin;
 		const char *label;
@@ -2805,14 +2827,6 @@ static int alc_auto_create_input_ctls(struct hda_codec *codec)
 				imux_added = true;
 			}
 		}
-
-		if (spec->inv_dmic_split) {
-			if (cfg->inputs[i].type == AUTO_PIN_MIC) {
-				unsigned int def_conf = snd_hda_codec_get_pincfg(codec, pin);
-				if (snd_hda_get_input_pin_attr(def_conf) == INPUT_PIN_ATTR_INT)
-					spec->inv_dmic_split_idx = i;
-			}
-		}
 	}
 
 	return 0;
-- 
1.8.0.1
