From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 039/112] ALSA: hda/realtek - Allow multiple
	individual capture volume/switch controls
Date: Tue,  8 Jan 2013 12:38:32 +0100
Message-ID: <1357645185-7645-40-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 814F62651BC
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id BCE13A5237
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

So far we create only "Capture Volume" and "Capture Switch" controls
for binding all possible amps, but we'd prefer creating individual
capture volume and switch controls per input in some cases
(e.g. conexant parser does it).

Add a new flag, spec->multi_cap_vol, to follow that policy.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 149 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 131 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4253b9a..2295389 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -221,6 +221,7 @@ struct alc_spec {
 	unsigned int inv_dmic_fixup:1; /* has inverted digital-mic workaround */
 	unsigned int inv_dmic_muted:1; /* R-ch of inv d-mic is muted? */
 	unsigned int no_primary_hp:1; /* Don't prefer HP pins to speaker pins */
+	unsigned int multi_cap_vol:1; /* allow multiple capture xxx volumes */
 
 	unsigned int parse_flags; /* passed to snd_hda_parse_pin_defcfg() */
 
@@ -2474,6 +2475,10 @@ static int check_dyn_adc_switch(struct hda_codec *codec)
 		spec->num_adc_nids = 1; /* reduce to a single ADC */
 	}
 
+	/* single index for individual volumes ctls */
+	if (!spec->dyn_adc_switch && spec->multi_cap_vol)
+		spec->num_adc_nids = 1;
+
 	return 0;
 }
 
@@ -2545,12 +2550,122 @@ static int parse_capvol_in_path(struct hda_codec *codec, struct nid_path *path)
 	return 0;
 }
 
+static int add_single_cap_ctl(struct hda_codec *codec, const char *label,
+			      int idx, bool is_switch, unsigned int ctl)
+{
+	struct alc_spec *spec = codec->spec;
+	char tmpname[44];
+	int type = is_switch ? ALC_CTL_WIDGET_MUTE : ALC_CTL_WIDGET_VOL;
+	const char *sfx = is_switch ? "Switch" : "Volume";
+
+	if (!ctl)
+		return 0;
+
+	if (label)
+		snprintf(tmpname, sizeof(tmpname),
+			 "%s Capture %s", label, sfx);
+	else
+		snprintf(tmpname, sizeof(tmpname),
+			 "Capture %s", sfx);
+	return add_control(spec, type, tmpname, idx, ctl);
+}
+
+/* create single (and simple) capture volume and switch controls */
+static int create_single_cap_vol_ctl(struct hda_codec *codec, int idx,
+				     unsigned int vol_ctl, unsigned int sw_ctl)
+{
+	int err;
+	err = add_single_cap_ctl(codec, NULL, idx, false, vol_ctl);
+	if (err < 0)
+		return err;
+	err = add_single_cap_ctl(codec, NULL, idx, true, sw_ctl);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+/* create bound capture volume and switch controls */
+static int create_bind_cap_vol_ctl(struct hda_codec *codec, int idx,
+				   unsigned int vol_ctl, unsigned int sw_ctl)
+{
+	struct alc_spec *spec = codec->spec;
+	struct snd_kcontrol_new *knew;
+
+	if (vol_ctl) {
+		knew = alc_kcontrol_new(spec, NULL, &cap_vol_temp);
+		if (!knew)
+			return -ENOMEM;
+		knew->index = idx;
+		knew->private_value = vol_ctl;
+		knew->subdevice = HDA_SUBDEV_AMP_FLAG;
+	}
+	if (sw_ctl) {
+		knew = alc_kcontrol_new(spec, NULL, &cap_sw_temp);
+		if (!knew)
+			return -ENOMEM;
+		knew->index = idx;
+		knew->private_value = sw_ctl;
+		knew->subdevice = HDA_SUBDEV_AMP_FLAG;
+	}
+	return 0;
+}
+
+/* return the vol ctl when used first in the imux list */
+static unsigned int get_first_cap_ctl(struct hda_codec *codec, int idx, int type)
+{
+	struct alc_spec *spec = codec->spec;
+	struct nid_path *path;
+	unsigned int ctl;
+	int i;
+
+	path = get_nid_path(codec, spec->imux_pins[idx],
+			    get_adc_nid(codec, 0, idx));
+	if (!path)
+		return 0;
+	ctl = path->ctls[type];
+	if (!ctl)
+		return 0;
+	for (i = 0; i < idx - 1; i++) {
+		path = get_nid_path(codec, spec->imux_pins[i],
+				    get_adc_nid(codec, 0, i));
+		if (path && path->ctls[type] == ctl)
+			return 0;
+	}
+	return ctl;
+}
+
+/* create individual capture volume and switch controls per input */
+static int create_multi_cap_vol_ctl(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	struct hda_input_mux *imux = &spec->input_mux;
+	int i, err, type, type_idx = 0;
+	const char *prev_label = NULL;
+
+	for (i = 0; i < imux->num_items; i++) {
+		const char *label;
+		label = hda_get_autocfg_input_label(codec, &spec->autocfg, i);
+		if (prev_label && !strcmp(label, prev_label))
+			type_idx++;
+		else
+			type_idx = 0;
+		prev_label = label;
+
+		for (type = 0; type < 2; type++) {
+			err = add_single_cap_ctl(codec, label, type_idx, type,
+						 get_first_cap_ctl(codec, i, type));
+			if (err < 0)
+				return err;
+		}
+	}
+	return 0;
+}
+
 static int create_capture_mixers(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	struct hda_input_mux *imux = &spec->input_mux;
-	struct snd_kcontrol_new *knew;
-	int i, n, nums;
+	int i, n, nums, err;
 
 	if (spec->dyn_adc_switch)
 		nums = 1;
@@ -2558,6 +2673,7 @@ static int create_capture_mixers(struct hda_codec *codec)
 		nums = spec->num_adc_nids;
 
 	if (!spec->auto_mic && imux->num_items > 1) {
+		struct snd_kcontrol_new *knew;
 		knew = alc_kcontrol_new(spec, NULL, &cap_src_temp);
 		if (!knew)
 			return -ENOMEM;
@@ -2565,6 +2681,7 @@ static int create_capture_mixers(struct hda_codec *codec)
 	}
 
 	for (n = 0; n < nums; n++) {
+		bool multi = false;
 		int vol, sw;
 
 		vol = sw = 0;
@@ -2577,26 +2694,22 @@ static int create_capture_mixers(struct hda_codec *codec)
 			parse_capvol_in_path(codec, path);
 			if (!vol)
 				vol = path->ctls[NID_PATH_VOL_CTL];
+			else if (vol != path->ctls[NID_PATH_VOL_CTL])
+				multi = true;
 			if (!sw)
 				sw = path->ctls[NID_PATH_MUTE_CTL];
+			else if (sw != path->ctls[NID_PATH_MUTE_CTL])
+				multi = true;
 		}
 
-		if (vol) {
-			knew = alc_kcontrol_new(spec, NULL, &cap_vol_temp);
-			if (!knew)
-				return -ENOMEM;
-			knew->index = n;
-			knew->private_value = vol;
-			knew->subdevice = HDA_SUBDEV_AMP_FLAG;
-		}
-		if (sw) {
-			knew = alc_kcontrol_new(spec, NULL, &cap_sw_temp);
-			if (!knew)
-				return -ENOMEM;
-			knew->index = n;
-			knew->private_value = sw;
-			knew->subdevice = HDA_SUBDEV_AMP_FLAG;
-		}
+		if (!multi)
+			err = create_single_cap_vol_ctl(codec, n, vol, sw);
+		else if (!spec->multi_cap_vol)
+			err = create_bind_cap_vol_ctl(codec, n, vol, sw);
+		else
+			err = create_multi_cap_vol_ctl(codec);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
-- 
1.8.0.1
