From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 108/112] ALSA: hda - Fix multi-io channel mode
	management
Date: Tue,  8 Jan 2013 12:39:41 +0100
Message-ID: <1357645185-7645-109-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9985526523D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 12D57A53F9
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

The multi-io channels can vary not only from 1 to 6 but also may vary
from 6 to 8 or such.  At the same time, there are more speaker pins
available than the primary output pins.  So, we need three variables
to check: the minimum channel counts for primary outputs, the current
channel counts for primary outputs, and the minimum channel counts for
all outputs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 92 ++++++++++++++++++++++++++++++---------------
 sound/pci/hda/hda_generic.h | 16 +++++++-
 2 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index d13e404..193dd55 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1125,6 +1125,25 @@ static int check_aamix_out_path(struct hda_codec *codec, int path_idx)
 	return snd_hda_get_path_idx(codec, path);
 }
 
+/* fill the empty entries in the dac array for speaker/hp with the
+ * shared dac pointed by the paths
+ */
+static void refill_shared_dacs(struct hda_codec *codec, int num_outs,
+			       hda_nid_t *dacs, int *path_idx)
+{
+	struct nid_path *path;
+	int i;
+
+	for (i = 0; i < num_outs; i++) {
+		if (dacs[i])
+			continue;
+		path = snd_hda_get_path_from_idx(codec, path_idx[i]);
+		if (!path)
+			continue;
+		dacs[i] = path->path[0];
+	}
+}
+
 /* fill in the dac_nids table from the parsed pin configuration */
 static int fill_and_eval_dacs(struct hda_codec *codec,
 			      bool fill_hardwired,
@@ -1183,19 +1202,6 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 				   spec->private_dac_nids, spec->out_paths,
 				   &main_out_badness);
 
-	/* re-count num_dacs and squash invalid entries */
-	spec->multiout.num_dacs = 0;
-	for (i = 0; i < cfg->line_outs; i++) {
-		if (spec->private_dac_nids[i])
-			spec->multiout.num_dacs++;
-		else {
-			memmove(spec->private_dac_nids + i,
-				spec->private_dac_nids + i + 1,
-				sizeof(hda_nid_t) * (cfg->line_outs - i - 1));
-			spec->private_dac_nids[cfg->line_outs - 1] = 0;
-		}
-	}
-
 	if (fill_mio_first &&
 	    cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
 		/* try to fill multi-io first */
@@ -1246,16 +1252,41 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 		if (count_multiio_pins(codec, cfg->hp_pins[0]) >= 2)
 			spec->multi_ios = 1; /* give badness */
 
+	/* re-count num_dacs and squash invalid entries */
+	spec->multiout.num_dacs = 0;
+	for (i = 0; i < cfg->line_outs; i++) {
+		if (spec->private_dac_nids[i])
+			spec->multiout.num_dacs++;
+		else {
+			memmove(spec->private_dac_nids + i,
+				spec->private_dac_nids + i + 1,
+				sizeof(hda_nid_t) * (cfg->line_outs - i - 1));
+			spec->private_dac_nids[cfg->line_outs - 1] = 0;
+		}
+	}
+
+	spec->ext_channel_count = spec->min_channel_count =
+		spec->multiout.num_dacs;
+
 	if (spec->multi_ios == 2) {
 		for (i = 0; i < 2; i++)
 			spec->private_dac_nids[spec->multiout.num_dacs++] =
 				spec->multi_io[i].dac;
-		spec->ext_channel_count = 2;
 	} else if (spec->multi_ios) {
 		spec->multi_ios = 0;
 		badness += BAD_MULTI_IO;
 	}
 
+	/* re-fill the shared DAC for speaker / headphone */
+	if (cfg->line_out_type != AUTO_PIN_HP_OUT)
+		refill_shared_dacs(codec, cfg->hp_outs,
+				   spec->multiout.hp_out_nid,
+				   spec->hp_paths);
+	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT)
+		refill_shared_dacs(codec, cfg->speaker_outs,
+				   spec->multiout.extra_out_nid,
+				   spec->speaker_paths);
+
 	return badness;
 }
 
@@ -1608,14 +1639,15 @@ static int ch_mode_info(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_gen_spec *spec = codec->spec;
+	int chs;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	uinfo->value.enumerated.items = spec->multi_ios + 1;
 	if (uinfo->value.enumerated.item > spec->multi_ios)
 		uinfo->value.enumerated.item = spec->multi_ios;
-	sprintf(uinfo->value.enumerated.name, "%dch",
-		(uinfo->value.enumerated.item + 1) * 2);
+	chs = uinfo->value.enumerated.item * 2 + spec->min_channel_count;
+	sprintf(uinfo->value.enumerated.name, "%dch", chs);
 	return 0;
 }
 
@@ -1624,7 +1656,8 @@ static int ch_mode_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_gen_spec *spec = codec->spec;
-	ucontrol->value.enumerated.item[0] = (spec->ext_channel_count - 1) / 2;
+	ucontrol->value.enumerated.item[0] =
+		(spec->ext_channel_count - spec->min_channel_count) / 2;
 	return 0;
 }
 
@@ -1672,9 +1705,9 @@ static int ch_mode_put(struct snd_kcontrol *kcontrol,
 	ch = ucontrol->value.enumerated.item[0];
 	if (ch < 0 || ch > spec->multi_ios)
 		return -EINVAL;
-	if (ch == (spec->ext_channel_count - 1) / 2)
+	if (ch == (spec->ext_channel_count - spec->min_channel_count) / 2)
 		return 0;
-	spec->ext_channel_count = (ch + 1) * 2;
+	spec->ext_channel_count = ch * 2 + spec->min_channel_count;
 	for (i = 0; i < spec->multi_ios; i++)
 		set_multi_io(codec, i, i < ch);
 	spec->multiout.max_channels = max(spec->ext_channel_count,
@@ -3125,17 +3158,16 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 	if (err < 0)
 		return err;
 
-	/* check the multiple speaker pins */
-	if (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
-		spec->const_channel_count = cfg->line_outs * 2;
-	else
-		spec->const_channel_count = cfg->speaker_outs * 2;
-
-	if (spec->multi_ios > 0)
-		spec->multiout.max_channels = max(spec->ext_channel_count,
-						  spec->const_channel_count);
-	else
-		spec->multiout.max_channels = spec->multiout.num_dacs * 2;
+	spec->const_channel_count = spec->ext_channel_count;
+	/* check the multiple speaker and headphone pins */
+	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT)
+		spec->const_channel_count = max(spec->const_channel_count,
+						cfg->speaker_outs * 2);
+	if (cfg->line_out_type != AUTO_PIN_HP_OUT)
+		spec->const_channel_count = max(spec->const_channel_count,
+						cfg->hp_outs * 2);
+	spec->multiout.max_channels = max(spec->ext_channel_count,
+					  spec->const_channel_count);
 
 	err = check_auto_mute_availability(codec);
 	if (err < 0)
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 00a1eab..b65769c 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -117,8 +117,20 @@ struct hda_gen_spec {
 	unsigned int cur_mux[3];
 
 	/* channel model */
-	int const_channel_count;	/* min. channel count (for speakers) */
-	int ext_channel_count;		/* current channel count for multi-io */
+	/* min_channel_count contains the minimum channel count for primary
+	 * outputs.  When multi_ios is set, the channels can be configured
+	 * between min_channel_count and (min_channel_count + multi_ios * 2).
+	 *
+	 * ext_channel_count contains the current channel count of the primary
+	 * out.  This varies in the range above.
+	 *
+	 * Meanwhile, const_channel_count is the channel count for all outputs
+	 * including headphone and speakers.  It's a constant value, and the
+	 * PCM is set up as max(ext_channel_count, const_channel_count).
+	 */
+	int min_channel_count;		/* min. channel count for primary out */
+	int ext_channel_count;		/* current channel count for primary */
+	int const_channel_count;	/* channel count for all */
 
 	/* PCM information */
 	struct hda_pcm pcm_rec[3];	/* used in build_pcms() */
-- 
1.8.0.1
