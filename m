From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 109/112] ALSA: hda - Manage input paths via
	path indices
Date: Tue,  8 Jan 2013 12:39:42 +0100
Message-ID: <1357645185-7645-110-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 58347265235
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 072D8A53C2
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
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

... like we did for output and loopback paths.
It makes the code slightly easier.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 44 ++++++++++++++++++--------------------------
 sound/pci/hda/hda_generic.h |  1 +
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 193dd55..f04a568 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1168,6 +1168,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	memset(spec->speaker_paths, 0, sizeof(spec->speaker_paths));
 	memset(spec->aamix_out_paths, 0, sizeof(spec->aamix_out_paths));
 	memset(spec->digout_paths, 0, sizeof(spec->digout_paths));
+	memset(spec->input_paths, 0, sizeof(spec->input_paths));
 	memset(spec->loopback_paths, 0, sizeof(spec->loopback_paths));
 	memset(&spec->digin_path, 0, sizeof(spec->digin_path));
 
@@ -2056,6 +2057,7 @@ static int create_input_ctls(struct hda_codec *codec)
 	for (i = 0; i < cfg->num_inputs; i++) {
 		hda_nid_t pin;
 		const char *label;
+		int imux_idx;
 		bool imux_added;
 
 		pin = cfg->inputs[i].pin;
@@ -2081,24 +2083,23 @@ static int create_input_ctls(struct hda_codec *codec)
 		}
 
 		imux_added = false;
+		imux_idx = imux->num_items;
 		for (c = 0; c < num_adcs; c++) {
 			struct nid_path *path;
 			hda_nid_t adc = spec->adc_nids[c];
 
 			if (!is_reachable_path(codec, pin, adc))
 				continue;
-			path = snd_array_new(&spec->paths);
-			if (!path)
-				return -ENOMEM;
-			memset(path, 0, sizeof(*path));
-			if (!snd_hda_parse_nid_path(codec, pin, adc, HDA_PARSE_ALL, path)) {
+			path = snd_hda_add_new_path(codec, pin, adc, HDA_PARSE_ALL);
+			if (!path) {
 				snd_printd(KERN_ERR
 					   "invalid input path 0x%x -> 0x%x\n",
 					   pin, adc);
-				spec->paths.used--;
 				continue;
 			}
 			print_nid_path("input", path);
+			spec->input_paths[imux_idx][c] =
+				snd_hda_get_path_idx(codec, path);
 
 			if (!imux_added) {
 				spec->imux_pins[imux->num_items] = pin;
@@ -2117,13 +2118,13 @@ static int create_input_ctls(struct hda_codec *codec)
  * input source mux
  */
 
-/* get the ADC NID corresponding to the given index */
-static hda_nid_t get_adc_nid(struct hda_codec *codec, int adc_idx, int imux_idx)
+/* get the input path specified by the given adc and imux indices */
+static struct nid_path *get_input_path(struct hda_codec *codec, int adc_idx, int imux_idx)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	if (spec->dyn_adc_switch)
 		adc_idx = spec->dyn_adc_idx[imux_idx];
-	return spec->adc_nids[adc_idx];
+	return snd_hda_get_path_from_idx(codec, spec->input_paths[imux_idx][adc_idx]);
 }
 
 static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
@@ -2192,9 +2193,8 @@ static int cap_put_caller(struct snd_kcontrol *kcontrol,
 	 */
 	codec->cached_write = 1;
 	for (i = 0; i < imux->num_items; i++) {
-		path = snd_hda_get_nid_path(codec, spec->imux_pins[i],
-					    get_adc_nid(codec, adc_idx, i));
-		if (!path->ctls[type])
+		path = get_input_path(codec, adc_idx, i);
+		if (!path || !path->ctls[type])
 			continue;
 		kcontrol->private_value = path->ctls[type];
 		err = func(kcontrol, ucontrol);
@@ -2394,21 +2394,18 @@ static int create_bind_cap_vol_ctl(struct hda_codec *codec, int idx,
 /* return the vol ctl when used first in the imux list */
 static unsigned int get_first_cap_ctl(struct hda_codec *codec, int idx, int type)
 {
-	struct hda_gen_spec *spec = codec->spec;
 	struct nid_path *path;
 	unsigned int ctl;
 	int i;
 
-	path = snd_hda_get_nid_path(codec, spec->imux_pins[idx],
-				    get_adc_nid(codec, 0, idx));
+	path = get_input_path(codec, 0, idx);
 	if (!path)
 		return 0;
 	ctl = path->ctls[type];
 	if (!ctl)
 		return 0;
 	for (i = 0; i < idx - 1; i++) {
-		path = snd_hda_get_nid_path(codec, spec->imux_pins[i],
-					    get_adc_nid(codec, 0, i));
+		path = get_input_path(codec, 0, i);
 		if (path && path->ctls[type] == ctl)
 			return 0;
 	}
@@ -2474,8 +2471,7 @@ static int create_capture_mixers(struct hda_codec *codec)
 		vol = sw = 0;
 		for (i = 0; i < imux->num_items; i++) {
 			struct nid_path *path;
-			path = snd_hda_get_nid_path(codec, spec->imux_pins[i],
-						    get_adc_nid(codec, n, i));
+			path = get_input_path(codec, n, i);
 			if (!path)
 				continue;
 			parse_capvol_in_path(codec, path);
@@ -2633,9 +2629,7 @@ static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
 	if (spec->cur_mux[adc_idx] == idx)
 		return 0;
 
-	path = snd_hda_get_nid_path(codec,
-				    spec->imux_pins[spec->cur_mux[adc_idx]],
-				    spec->adc_nids[adc_idx]);
+	path = get_input_path(codec, adc_idx, spec->cur_mux[adc_idx]);
 	if (!path)
 		return 0;
 	if (path->active)
@@ -2649,8 +2643,7 @@ static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
 	if (spec->dyn_adc_switch)
 		dyn_adc_pcm_resetup(codec, idx);
 
-	path = snd_hda_get_nid_path(codec, spec->imux_pins[idx],
-				    get_adc_nid(codec, adc_idx, idx));
+	path = get_input_path(codec, adc_idx, idx);
 	if (!path)
 		return 0;
 	if (path->active)
@@ -3887,8 +3880,7 @@ static void init_input_src(struct hda_codec *codec)
 
 	for (c = 0; c < nums; c++) {
 		for (i = 0; i < imux->num_items; i++) {
-			path = snd_hda_get_nid_path(codec, spec->imux_pins[i],
-						    get_adc_nid(codec, c, i));
+			path = get_input_path(codec, c, i);
 			if (path) {
 				bool active = path->active;
 				if (i == spec->cur_mux[c])
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index b65769c..1ad9127 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -156,6 +156,7 @@ struct hda_gen_spec {
 	int speaker_paths[AUTO_CFG_MAX_OUTS];
 	int aamix_out_paths[3];
 	int digout_paths[AUTO_CFG_MAX_OUTS];
+	int input_paths[HDA_MAX_NUM_INPUTS][AUTO_CFG_MAX_OUTS];
 	int loopback_paths[HDA_MAX_NUM_INPUTS];
 	int digin_path;
 
-- 
1.8.0.1
