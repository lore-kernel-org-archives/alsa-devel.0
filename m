From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 019/112] ALSA: hda/realtek - Consolidate to a
	single path list
Date: Tue,  8 Jan 2013 12:38:12 +0100
Message-ID: <1357645185-7645-20-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CADA12651A7
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 5F215A520A
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

We don't have to keep three individual path lists for input, output
and loopback.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 94 +++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 61 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fc5f80b5..47f5c4f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -192,14 +192,8 @@ struct alc_spec {
 	int num_all_dacs;
 	hda_nid_t all_dacs[16];
 
-	/* output paths */
-	struct snd_array out_path;
-
-	/* input paths */
-	struct snd_array in_path;
-
-	/* analog loopback paths */
-	struct snd_array loopback_path;
+	/* path list */
+	struct snd_array paths;
 
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
@@ -2412,9 +2406,7 @@ static void alc_free(struct hda_codec *codec)
 
 	alc_free_kctls(codec);
 	alc_free_bind_ctls(codec);
-	snd_array_free(&spec->out_path);
-	snd_array_free(&spec->in_path);
-	snd_array_free(&spec->loopback_path);
+	snd_array_free(&spec->paths);
 	snd_hda_gen_free(&spec->gen);
 	kfree(spec);
 	snd_hda_detach_beep_device(codec);
@@ -2651,7 +2643,7 @@ static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
 	    !nid_has_mute(codec, mix_nid, HDA_INPUT))
 		return 0; /* no need for analog loopback */
 
-	path = snd_array_new(&spec->loopback_path);
+	path = snd_array_new(&spec->paths);
 	if (!path)
 		return -ENOMEM;
 	memset(path, 0, sizeof(*path));
@@ -2684,7 +2676,7 @@ static int new_capture_source(struct hda_codec *codec, int adc_idx,
 	struct hda_input_mux *imux = &spec->private_imux[0];
 	struct nid_path *path;
 
-	path = snd_array_new(&spec->in_path);
+	path = snd_array_new(&spec->paths);
 	if (!path)
 		return -ENOMEM;
 	memset(path, 0, sizeof(*path));
@@ -2894,8 +2886,8 @@ static bool alc_is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
 	struct alc_spec *spec = codec->spec;
 	int i;
 
-	for (i = 0; i < spec->out_path.used; i++) {
-		struct nid_path *path = snd_array_elem(&spec->out_path, i);
+	for (i = 0; i < spec->paths.used; i++) {
+		struct nid_path *path = snd_array_elem(&spec->paths, i);
 		if (path->path[0] == nid)
 			return true;
 	}
@@ -3018,8 +3010,8 @@ static bool is_ctl_used(struct hda_codec *codec, unsigned int val, int type)
 	struct alc_spec *spec = codec->spec;
 	int i;
 
-	for (i = 0; i < spec->out_path.used; i++) {
-		struct nid_path *path = snd_array_elem(&spec->out_path, i);
+	for (i = 0; i < spec->paths.used; i++) {
+		struct nid_path *path = snd_array_elem(&spec->paths, i);
 		if (path->ctls[type] == val)
 			return true;
 	}
@@ -3059,14 +3051,14 @@ static bool add_new_out_path(struct hda_codec *codec, hda_nid_t pin,
 	struct alc_spec *spec = codec->spec;
 	struct nid_path *path;
 
-	path = snd_array_new(&spec->out_path);
+	path = snd_array_new(&spec->paths);
 	if (!path)
 		return false;
 	memset(path, 0, sizeof(*path));
 	if (parse_nid_path(codec, dac, pin, 0, path))
 		return true;
 	/* push back */
-	spec->out_path.used--;
+	spec->paths.used--;
 	return false;
 }
 
@@ -3079,8 +3071,8 @@ static struct nid_path *get_out_path(struct hda_codec *codec, hda_nid_t pin,
 	struct alc_spec *spec = codec->spec;
 	int i;
 
-	for (i = 0; i < spec->out_path.used; i++) {
-		struct nid_path *path = snd_array_elem(&spec->out_path, i);
+	for (i = 0; i < spec->paths.used; i++) {
+		struct nid_path *path = snd_array_elem(&spec->paths, i);
 		if (path->depth <= 0)
 			continue;
 		if ((!dac || path->path[0] == dac) &&
@@ -3258,7 +3250,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	memset(spec->multiout.hp_out_nid, 0, sizeof(spec->multiout.hp_out_nid));
 	memset(spec->multiout.extra_out_nid, 0, sizeof(spec->multiout.extra_out_nid));
 	spec->multi_ios = 0;
-	snd_array_free(&spec->out_path);
+	snd_array_free(&spec->paths);
 	badness = 0;
 
 	/* fill hard-wired DACs first */
@@ -3804,38 +3796,28 @@ static int alc_auto_create_speaker_out(struct hda_codec *codec)
 					  "Speaker");
 }
 
-static bool is_ctl_associated_in_list(struct snd_array *array, hda_nid_t nid,
-				      int dir, int idx, int types)
+/* check whether a control with the given (nid, dir, idx) was assigned */
+static bool is_ctl_associated(struct hda_codec *codec, hda_nid_t nid,
+			      int dir, int idx)
 {
+	struct alc_spec *spec = codec->spec;
 	int i, type;
 
-	for (i = 0; i < array->used; i++) {
-		struct nid_path *p = snd_array_elem(array, i);
+	for (i = 0; i < spec->paths.used; i++) {
+		struct nid_path *p = snd_array_elem(&spec->paths, i);
 		if (p->depth <= 0)
 			continue;
 		for (type = 0; type < 2; type++) {
-			if (types & (1 << type)) {
-				unsigned int val = p->ctls[type];
-				if (get_amp_nid_(val) == nid &&
-				    get_amp_direction_(val) == dir &&
-				    get_amp_index_(val) == idx)
-					return true;
-			}
+			unsigned int val = p->ctls[type];
+			if (get_amp_nid_(val) == nid &&
+			    get_amp_direction_(val) == dir &&
+			    get_amp_index_(val) == idx)
+				return true;
 		}
 	}
 	return false;
 }
 
-/* check whether a control with the given (nid, dir, idx) was assigned */
-static bool is_ctl_associated(struct hda_codec *codec, hda_nid_t nid,
-			      int dir, int idx)
-{
-	struct alc_spec *spec = codec->spec;
-	return is_ctl_associated_in_list(&spec->out_path, nid, dir, idx, 3) ||
-		is_ctl_associated_in_list(&spec->in_path, nid, dir, idx, 3) ||
-		is_ctl_associated_in_list(&spec->loopback_path, nid, dir, idx, 3);
-}
-
 /* can have the amp-in capability? */
 static bool has_amp_in(struct hda_codec *codec, struct nid_path *path, int idx)
 {
@@ -3864,13 +3846,15 @@ static bool has_amp_out(struct hda_codec *codec, struct nid_path *path, int idx)
 	return true;
 }
 
-static bool is_active_in_list(struct hda_codec *codec, struct snd_array *array,
-			      hda_nid_t nid, int dir, int idx)
+/* check whether the given (nid,dir,idx) is active */
+static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
+			  unsigned int idx, unsigned int dir)
 {
+	struct alc_spec *spec = codec->spec;
 	int i, n;
 
-	for (n = 0; n < array->used; n++) {
-		struct nid_path *path = snd_array_elem(array, n);
+	for (n = 0; n < spec->paths.used; n++) {
+		struct nid_path *path = snd_array_elem(&spec->paths, n);
 		if (!path->active)
 			continue;
 		for (i = 0; i < path->depth; i++) {
@@ -3884,16 +3868,6 @@ static bool is_active_in_list(struct hda_codec *codec, struct snd_array *array,
 	return false;
 }
 
-/* check whether the given (nid,dir,idx) is active */
-static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
-			  unsigned int idx, unsigned int dir)
-{
-	struct alc_spec *spec = codec->spec;
-	return is_active_in_list(codec, &spec->out_path, nid, idx, dir) ||
-		is_active_in_list(codec, &spec->in_path, nid, idx, dir) ||
-		is_active_in_list(codec, &spec->loopback_path, nid, idx, dir);
-}
-
 /* get the default amp value for the target state */
 static int get_amp_val_to_activate(struct hda_codec *codec, hda_nid_t nid,
 				   int dir, bool enable)
@@ -4163,7 +4137,7 @@ static int alc_auto_fill_multi_ios(struct hda_codec *codec,
 	}
 	if (!hardwired && spec->multi_ios < 2) {
 		/* cancel newly assigned paths */
-		spec->out_path.used -= spec->multi_ios - old_pins;
+		spec->paths.used -= spec->multi_ios - old_pins;
 		spec->multi_ios = old_pins;
 		return badness;
 	}
@@ -4659,9 +4633,7 @@ static int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
 	snd_hda_gen_init(&spec->gen);
 	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
 	snd_array_init(&spec->bind_ctls, sizeof(struct hda_bind_ctls *), 8);
-	snd_array_init(&spec->out_path, sizeof(struct nid_path), 8);
-	snd_array_init(&spec->in_path, sizeof(struct nid_path), 8);
-	snd_array_init(&spec->loopback_path, sizeof(struct nid_path), 8);
+	snd_array_init(&spec->paths, sizeof(struct nid_path), 8);
 
 	err = alc_codec_rename_from_preset(codec);
 	if (err < 0) {
-- 
1.8.0.1
