From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 021/112] ALSA: hda/realtek - Rename
	get_out_path() to get_nid_path()
Date: Tue,  8 Jan 2013 12:38:14 +0100
Message-ID: <1357645185-7645-22-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CEC732651A8
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 64450A520E
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

The function can be used not only for output paths but generically.
Also swap the argument order.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 206b983..419979d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3064,11 +3064,11 @@ static bool add_new_out_path(struct hda_codec *codec, hda_nid_t pin,
 	return false;
 }
 
-/* get the path pointing from the given dac to pin;
+/* get the path between the given NIDs;
  * passing 0 to either @pin or @dac behaves as a wildcard
  */
-static struct nid_path *get_out_path(struct hda_codec *codec, hda_nid_t pin,
-				     hda_nid_t dac)
+static struct nid_path *
+get_nid_path(struct hda_codec *codec, hda_nid_t from_nid, hda_nid_t to_nid)
 {
 	struct alc_spec *spec = codec->spec;
 	int i;
@@ -3077,8 +3077,8 @@ static struct nid_path *get_out_path(struct hda_codec *codec, hda_nid_t pin,
 		struct nid_path *path = snd_array_elem(&spec->paths, i);
 		if (path->depth <= 0)
 			continue;
-		if ((!dac || path->path[0] == dac) &&
-		    (!pin || path->path[path->depth - 1] == pin))
+		if ((!from_nid || path->path[0] == from_nid) &&
+		    (!to_nid || path->path[path->depth - 1] == to_nid))
 			return path;
 	}
 	return NULL;
@@ -3094,7 +3094,7 @@ static struct nid_path *get_out_path(struct hda_codec *codec, hda_nid_t pin,
 static int assign_out_path_ctls(struct hda_codec *codec, hda_nid_t pin,
 				hda_nid_t dac)
 {
-	struct nid_path *path = get_out_path(codec, pin, dac);
+	struct nid_path *path = get_nid_path(codec, dac, pin);
 	hda_nid_t nid;
 	unsigned int val;
 	int badness = 0;
@@ -3495,9 +3495,9 @@ static int alc_auto_fill_dac_nids(struct hda_codec *codec)
 	debug_show_configs(spec, cfg);
 
 	if (cfg->line_out_pins[0]) {
-		struct nid_path *path = get_out_path(codec,
-						     cfg->line_out_pins[0],
-						     spec->multiout.dac_nids[0]);
+		struct nid_path *path = get_nid_path(codec,
+						     spec->multiout.dac_nids[0],
+						     cfg->line_out_pins[0]);
 		if (path)
 			spec->vmaster_nid = alc_look_for_out_vol_nid(codec, path);
 	}
@@ -3641,7 +3641,7 @@ static int alc_auto_create_multi_out_ctls(struct hda_codec *codec,
 			name = alc_get_line_out_pfx(spec, i, true, &index);
 		}
 
-		path = get_out_path(codec, pin, dac);
+		path = get_nid_path(codec, dac, pin);
 		if (!path)
 			continue;
 		if (!name || !strcmp(name, "CLFE")) {
@@ -3677,7 +3677,7 @@ static int alc_auto_create_extra_out(struct hda_codec *codec, hda_nid_t pin,
 	struct nid_path *path;
 	int err;
 
-	path = get_out_path(codec, pin, dac);
+	path = get_nid_path(codec, dac, pin);
 	if (!path)
 		return 0;
 	/* bind volume control will be created in the case of dac = 0 */
@@ -3763,7 +3763,7 @@ static int alc_auto_create_extra_outs(struct hda_codec *codec, int num_pins,
 		struct nid_path *path;
 		if (!pins[i] || !dacs[i])
 			continue;
-		path = get_out_path(codec, pins[i], dacs[i]);
+		path = get_nid_path(codec, dacs[i], pins[i]);
 		if (!path)
 			continue;
 		vol = alc_look_for_out_vol_nid(codec, path);
@@ -3975,7 +3975,7 @@ static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
 	struct nid_path *path;
 
 	snd_hda_set_pin_ctl_cache(codec, pin, pin_type);
-	path = get_out_path(codec, pin, dac);
+	path = get_nid_path(codec, dac, pin);
 	if (!path)
 		return;
 	activate_path(codec, path, true);
@@ -4183,7 +4183,7 @@ static int alc_set_multi_io(struct hda_codec *codec, int idx, bool output)
 	hda_nid_t nid = spec->multi_io[idx].pin;
 	struct nid_path *path;
 
-	path = get_out_path(codec, nid, spec->multi_io[idx].dac);
+	path = get_nid_path(codec, spec->multi_io[idx].dac, nid);
 	if (!path)
 		return -EINVAL;
 
-- 
1.8.0.1
