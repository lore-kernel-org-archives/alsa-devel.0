From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Implement loopback control switch
	for Realtek and other codecs
Date: Tue,  8 Dec 2015 17:10:11 +0100
Message-ID: <1449591011-21360-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BD64F260504
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:10:18 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 829E8AB12
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 16:10:18 +0000 (UTC)
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

Many codecs, typically found on Realtek codecs, have the analog
loopback path merged to the secondary input of the middle of the
output paths.  Currently, we don't offer the dynamic switching in such
configuration but let each loopback path mute by itself.

This should work well in theory, but in reality, we often see that
such a dead loopback path causes some background noises even if all
the elements get muted.  Such a problem has been fixed by adding the
quirk accordingly to disable aamix, and it's the right fix, per se.
The only problem is that it's not so trivial to achieve it; user needs
to pass a hint string via patch module option or sysfs.

This patch gives a bit improvement on the situation: it adds "Loopback
Mixing" control element for such codecs like other codecs (e.g. IDT or
VIA codecs) with the individual loopback paths.  User can turn on/off
the loopback path simply via a mixer app.

For keeping the compatibility, the loopback is still enabled on these
codecs.  But user can try to turn it off if experiencing a suspicious
background or click noise on the fly, then build a static fixup later
once after the problem is addressed.

Other than the addition of the loopback enable/disablement control,
there should be no changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 87 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f3c058f6c831..30c8efe0f80a 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -754,9 +754,6 @@ static void activate_amp(struct hda_codec *codec, hda_nid_t nid, int dir,
 	unsigned int caps;
 	unsigned int mask, val;
 
-	if (!enable && is_active_nid(codec, nid, dir, idx_to_check))
-		return;
-
 	caps = query_amp_caps(codec, nid, dir);
 	val = get_amp_val_to_activate(codec, nid, dir, caps, enable);
 	mask = get_amp_mask_to_modify(codec, nid, dir, idx_to_check, caps);
@@ -767,12 +764,22 @@ static void activate_amp(struct hda_codec *codec, hda_nid_t nid, int dir,
 	update_amp(codec, nid, dir, idx, mask, val);
 }
 
+static void check_and_activate_amp(struct hda_codec *codec, hda_nid_t nid,
+				   int dir, int idx, int idx_to_check,
+				   bool enable)
+{
+	/* check whether the given amp is still used by others */
+	if (!enable && is_active_nid(codec, nid, dir, idx_to_check))
+		return;
+	activate_amp(codec, nid, dir, idx, idx_to_check, enable);
+}
+
 static void activate_amp_out(struct hda_codec *codec, struct nid_path *path,
 			     int i, bool enable)
 {
 	hda_nid_t nid = path->path[i];
 	init_amp(codec, nid, HDA_OUTPUT, 0);
-	activate_amp(codec, nid, HDA_OUTPUT, 0, 0, enable);
+	check_and_activate_amp(codec, nid, HDA_OUTPUT, 0, 0, enable);
 }
 
 static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
@@ -800,9 +807,16 @@ static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
 	 * when aa-mixer is available, we need to enable the path as well
 	 */
 	for (n = 0; n < nums; n++) {
-		if (n != idx && (!add_aamix || conn[n] != spec->mixer_merge_nid))
-			continue;
-		activate_amp(codec, nid, HDA_INPUT, n, idx, enable);
+		if (n != idx) {
+			if (conn[n] != spec->mixer_merge_nid)
+				continue;
+			/* when aamix is disabled, force to off */
+			if (!add_aamix) {
+				activate_amp(codec, nid, HDA_INPUT, n, n, false);
+				continue;
+			}
+		}
+		check_and_activate_amp(codec, nid, HDA_INPUT, n, idx, enable);
 	}
 }
 
@@ -1563,6 +1577,12 @@ static bool map_singles(struct hda_codec *codec, int outs,
 	return found;
 }
 
+static inline bool has_aamix_out_paths(struct hda_gen_spec *spec)
+{
+	return spec->aamix_out_paths[0] || spec->aamix_out_paths[1] ||
+		spec->aamix_out_paths[2];
+}
+
 /* create a new path including aamix if available, and return its index */
 static int check_aamix_out_path(struct hda_codec *codec, int path_idx)
 {
@@ -2405,25 +2425,51 @@ static void update_aamix_paths(struct hda_codec *codec, bool do_mix,
 	}
 }
 
+/* re-initialize the output paths; only called from loopback_mixing_put() */
+static void update_output_paths(struct hda_codec *codec, int num_outs,
+				const int *paths)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct nid_path *path;
+	int i;
+
+	for (i = 0; i < num_outs; i++) {
+		path = snd_hda_get_path_from_idx(codec, paths[i]);
+		if (path)
+			snd_hda_activate_path(codec, path, path->active,
+					      spec->aamix_mode);
+	}
+}
+
 static int loopback_mixing_put(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_gen_spec *spec = codec->spec;
+	const struct auto_pin_cfg *cfg = &spec->autocfg;
 	unsigned int val = ucontrol->value.enumerated.item[0];
 
 	if (val == spec->aamix_mode)
 		return 0;
 	spec->aamix_mode = val;
-	update_aamix_paths(codec, val, spec->out_paths[0],
-			   spec->aamix_out_paths[0],
-			   spec->autocfg.line_out_type);
-	update_aamix_paths(codec, val, spec->hp_paths[0],
-			   spec->aamix_out_paths[1],
-			   AUTO_PIN_HP_OUT);
-	update_aamix_paths(codec, val, spec->speaker_paths[0],
-			   spec->aamix_out_paths[2],
-			   AUTO_PIN_SPEAKER_OUT);
+	if (has_aamix_out_paths(spec)) {
+		update_aamix_paths(codec, val, spec->out_paths[0],
+				   spec->aamix_out_paths[0],
+				   cfg->line_out_type);
+		update_aamix_paths(codec, val, spec->hp_paths[0],
+				   spec->aamix_out_paths[1],
+				   AUTO_PIN_HP_OUT);
+		update_aamix_paths(codec, val, spec->speaker_paths[0],
+				   spec->aamix_out_paths[2],
+				   AUTO_PIN_SPEAKER_OUT);
+	} else {
+		update_output_paths(codec, cfg->line_outs, spec->out_paths);
+		if (cfg->line_out_type != AUTO_PIN_HP_OUT)
+			update_output_paths(codec, cfg->hp_outs, spec->hp_paths);
+		if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT)
+			update_output_paths(codec, cfg->speaker_outs,
+					    spec->speaker_paths);
+	}
 	return 1;
 }
 
@@ -2441,12 +2487,13 @@ static int create_loopback_mixing_ctl(struct hda_codec *codec)
 
 	if (!spec->mixer_nid)
 		return 0;
-	if (!(spec->aamix_out_paths[0] || spec->aamix_out_paths[1] ||
-	      spec->aamix_out_paths[2]))
-		return 0;
 	if (!snd_hda_gen_add_kctl(spec, NULL, &loopback_mixing_enum))
 		return -ENOMEM;
 	spec->have_aamix_ctl = 1;
+	/* if no explicit aamix path is present (e.g. for Realtek codecs),
+	 * enable aamix as default -- just for compatibility
+	 */
+	spec->aamix_mode = !has_aamix_out_paths(spec);
 	return 0;
 }
 
@@ -5647,6 +5694,8 @@ static void init_aamix_paths(struct hda_codec *codec)
 
 	if (!spec->have_aamix_ctl)
 		return;
+	if (!has_aamix_out_paths(spec))
+		return;
 	update_aamix_paths(codec, spec->aamix_mode, spec->out_paths[0],
 			   spec->aamix_out_paths[0],
 			   spec->autocfg.line_out_type);
-- 
2.6.3
