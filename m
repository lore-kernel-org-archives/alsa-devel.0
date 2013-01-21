From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/12] ALSA: hda - Improve debug prints for
	output paths
Date: Mon, 21 Jan 2013 17:06:08 +0100
Message-ID: <1358784377-26102-4-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A570261602
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D9EE4A51BB
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:18 +0100 (CET)
In-Reply-To: <1358784377-26102-1-git-send-email-tiwai@suse.de>
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

Print the information of outputs in a bit more details and concisely
in a single place instead of printing the path at each time when
detected.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 57 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 29f37c9..37d7ed7 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1113,7 +1113,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 		if (!path)
 			dac = dacs[i] = 0;
 		else {
-			print_nid_path("output", path);
+			/* print_nid_path("output", path); */
 			path->active = true;
 			path_idx[i] = snd_hda_get_path_idx(codec, path);
 			badness += assign_out_path_ctls(codec, path);
@@ -1240,7 +1240,7 @@ static int fill_multi_ios(struct hda_codec *codec,
 				badness++;
 				continue;
 			}
-			print_nid_path("multiio", path);
+			/* print_nid_path("multiio", path); */
 			spec->multi_io[spec->multi_ios].pin = nid;
 			spec->multi_io[spec->multi_ios].dac = dac;
 			spec->out_paths[cfg->line_outs + spec->multi_ios] =
@@ -1297,7 +1297,7 @@ static bool map_singles(struct hda_codec *codec, int outs,
 		if (path) {
 			dacs[i] = dac;
 			found = true;
-			print_nid_path("output", path);
+			/* print_nid_path("output", path); */
 			path->active = true;
 			path_idx[i] = snd_hda_get_path_idx(codec, path);
 		}
@@ -1320,7 +1320,7 @@ static int check_aamix_out_path(struct hda_codec *codec, int path_idx)
 				    spec->mixer_nid);
 	if (!path)
 		return 0;
-	print_nid_path("output-aamix", path);
+	/* print_nid_path("output-aamix", path); */
 	path->active = false; /* unused as default */
 	return snd_hda_get_path_idx(codec, path);
 }
@@ -1514,35 +1514,70 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 #define debug_badness(...)
 #endif
 
-static void debug_show_configs(struct hda_gen_spec *spec, struct auto_pin_cfg *cfg)
+#ifdef DEBUG_BADNESS
+static inline void print_nid_path_idx(struct hda_codec *codec,
+				      const char *pfx, int idx)
+{
+	struct nid_path *path;
+
+	path = snd_hda_get_path_from_idx(codec, idx);
+	if (path)
+		print_nid_path(pfx, path);
+}
+
+static void debug_show_configs(struct hda_codec *codec,
+			       struct auto_pin_cfg *cfg)
 {
-	debug_badness("multi_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
+	struct hda_gen_spec *spec = codec->spec;
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+	static const char * const lo_type[3] = { "LO", "SP", "HP" };
+#endif
+	int i;
+
+	debug_badness("multi_outs = %x/%x/%x/%x : %x/%x/%x/%x (type %s)\n",
 		      cfg->line_out_pins[0], cfg->line_out_pins[1],
 		      cfg->line_out_pins[2], cfg->line_out_pins[3],
 		      spec->multiout.dac_nids[0],
 		      spec->multiout.dac_nids[1],
 		      spec->multiout.dac_nids[2],
-		      spec->multiout.dac_nids[3]);
+		      spec->multiout.dac_nids[3],
+		      lo_type[cfg->line_out_type]);
+	for (i = 0; i < cfg->line_outs; i++)
+		print_nid_path_idx(codec, "  out", spec->out_paths[i]);
 	if (spec->multi_ios > 0)
 		debug_badness("multi_ios(%d) = %x/%x : %x/%x\n",
 			      spec->multi_ios,
 			      spec->multi_io[0].pin, spec->multi_io[1].pin,
 			      spec->multi_io[0].dac, spec->multi_io[1].dac);
-	debug_badness("hp_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
+	for (i = 0; i < spec->multi_ios; i++)
+		print_nid_path_idx(codec, "  mio",
+				   spec->out_paths[cfg->line_outs + i]);
+	if (cfg->hp_outs)
+		debug_badness("hp_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
 		      cfg->hp_pins[0], cfg->hp_pins[1],
 		      cfg->hp_pins[2], cfg->hp_pins[3],
 		      spec->multiout.hp_out_nid[0],
 		      spec->multiout.hp_out_nid[1],
 		      spec->multiout.hp_out_nid[2],
 		      spec->multiout.hp_out_nid[3]);
-	debug_badness("spk_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
+	for (i = 0; i < cfg->hp_outs; i++)
+		print_nid_path_idx(codec, "  hp ", spec->hp_paths[i]);
+	if (cfg->speaker_outs)
+		debug_badness("spk_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
 		      cfg->speaker_pins[0], cfg->speaker_pins[1],
 		      cfg->speaker_pins[2], cfg->speaker_pins[3],
 		      spec->multiout.extra_out_nid[0],
 		      spec->multiout.extra_out_nid[1],
 		      spec->multiout.extra_out_nid[2],
 		      spec->multiout.extra_out_nid[3]);
+	for (i = 0; i < cfg->speaker_outs; i++)
+		print_nid_path_idx(codec, "  spk", spec->speaker_paths[i]);
+	for (i = 0; i < 3; i++)
+		print_nid_path_idx(codec, "  mix", spec->aamix_out_paths[i]);
 }
+#else
+#define debug_show_configs(codec, cfg) /* NOP */
+#endif
 
 /* find all available DACs of the codec */
 static void fill_all_dac_nids(struct hda_codec *codec)
@@ -1590,7 +1625,7 @@ static int parse_output_paths(struct hda_codec *codec)
 		debug_badness("==> lo_type=%d, wired=%d, mio=%d, badness=0x%x\n",
 			      cfg->line_out_type, fill_hardwired, fill_mio_first,
 			      badness);
-		debug_show_configs(spec, cfg);
+		debug_show_configs(codec, cfg);
 		if (badness < best_badness) {
 			best_badness = badness;
 			*best_cfg = *cfg;
@@ -1646,7 +1681,7 @@ static int parse_output_paths(struct hda_codec *codec)
 	}
 	debug_badness("==> Best config: lo_type=%d, wired=%d, mio=%d\n",
 		      cfg->line_out_type, best_wired, best_mio);
-	debug_show_configs(spec, cfg);
+	debug_show_configs(codec, cfg);
 
 	if (cfg->line_out_pins[0]) {
 		struct nid_path *path;
-- 
1.8.1.1
