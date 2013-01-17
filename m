From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 9/9] ALSA: hda - Improve naming rule for
	primary output
Date: Thu, 17 Jan 2013 17:54:54 +0100
Message-ID: <1358441694-32004-10-git-send-email-tiwai@suse.de>
References: <1358441694-32004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 23A2226531F
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:55:00 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id DDF18A51F2
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:54:59 +0100 (CET)
In-Reply-To: <1358441694-32004-1-git-send-email-tiwai@suse.de>
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

When the volume or mute control of the primary output is shared with
other (headphone or speaker) outputs, we shouldn't name it as a
specific output type but rather name it with the channel name or a
generic name like "PCM".

Also, this check should be performed individually for the volume and
the mute controls because some codecs may have shared volumes but
separate mute controls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 59 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f946714..ef4c04a 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -825,19 +825,27 @@ static int add_stereo_sw(struct hda_codec *codec, const char *pfx,
 	return add_sw_ctl(codec, pfx, cidx, chs, path);
 }
 
+/* any ctl assigned to the path with the given index? */
+static bool path_has_mixer(struct hda_codec *codec, int path_idx, int ctl_type)
+{
+	struct nid_path *path = snd_hda_get_path_from_idx(codec, path_idx);
+	return path && path->ctls[ctl_type];
+}
+
 static const char * const channel_name[4] = {
 	"Front", "Surround", "CLFE", "Side"
 };
 
 /* give some appropriate ctl name prefix for the given line out channel */
-static const char *get_line_out_pfx(struct hda_gen_spec *spec, int ch,
-				    bool can_be_master, int *index)
+static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
+				    int *index, int ctl_type)
 {
+	struct hda_gen_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 
 	*index = 0;
 	if (cfg->line_outs == 1 && !spec->multi_ios &&
-	    !cfg->hp_outs && !cfg->speaker_outs && can_be_master)
+	    !cfg->hp_outs && !cfg->speaker_outs)
 		return spec->vmaster_mute.hook ? "PCM" : "Master";
 
 	/* if there is really a single DAC used in the whole output paths,
@@ -847,24 +855,41 @@ static const char *get_line_out_pfx(struct hda_gen_spec *spec, int ch,
 	    !spec->multiout.hp_out_nid[0] && !spec->multiout.extra_out_nid[0])
 		return spec->vmaster_mute.hook ? "PCM" : "Master";
 
+	/* multi-io channels */
+	if (ch >= cfg->line_outs)
+		return channel_name[ch];
+
 	switch (cfg->line_out_type) {
 	case AUTO_PIN_SPEAKER_OUT:
+		/* if the primary channel vol/mute is shared with HP volume,
+		 * don't name it as Speaker
+		 */
+		if (!ch && cfg->hp_outs &&
+		    !path_has_mixer(codec, spec->hp_paths[0], ctl_type))
+			break;
 		if (cfg->line_outs == 1)
 			return "Speaker";
 		if (cfg->line_outs == 2)
 			return ch ? "Bass Speaker" : "Speaker";
 		break;
 	case AUTO_PIN_HP_OUT:
+		/* if the primary channel vol/mute is shared with spk volume,
+		 * don't name it as Headphone
+		 */
+		if (!ch && cfg->speaker_outs &&
+		    !path_has_mixer(codec, spec->speaker_paths[0], ctl_type))
+			break;
 		/* for multi-io case, only the primary out */
 		if (ch && spec->multi_ios)
 			break;
 		*index = ch;
 		return "Headphone";
-	default:
-		if (cfg->line_outs == 1 && !spec->multi_ios)
-			return "PCM";
-		break;
 	}
+
+	/* for a single channel output, we don't have to name the channel */
+	if (cfg->line_outs == 1 && !spec->multi_ios)
+		return "PCM";
+
 	if (ch >= ARRAY_SIZE(channel_name)) {
 		snd_BUG();
 		return "PCM";
@@ -1626,16 +1651,11 @@ static int create_multi_out_ctls(struct hda_codec *codec,
 		int index;
 		struct nid_path *path;
 
-		if (i >= cfg->line_outs) {
-			index = 0;
-			name = channel_name[i];
-		} else {
-			name = get_line_out_pfx(spec, i, true, &index);
-		}
-
 		path = snd_hda_get_path_from_idx(codec, spec->out_paths[i]);
 		if (!path)
 			continue;
+
+		name = get_line_out_pfx(codec, i, &index, NID_PATH_VOL_CTL);
 		if (!name || !strcmp(name, "CLFE")) {
 			/* Center/LFE */
 			err = add_vol_ctl(codec, "Center", 0, 1, path);
@@ -1644,6 +1664,14 @@ static int create_multi_out_ctls(struct hda_codec *codec,
 			err = add_vol_ctl(codec, "LFE", 0, 2, path);
 			if (err < 0)
 				return err;
+		} else {
+			err = add_stereo_vol(codec, name, index, path);
+			if (err < 0)
+				return err;
+		}
+
+		name = get_line_out_pfx(codec, i, &index, NID_PATH_MUTE_CTL);
+		if (!name || !strcmp(name, "CLFE")) {
 			err = add_sw_ctl(codec, "Center", 0, 1, path);
 			if (err < 0)
 				return err;
@@ -1651,9 +1679,6 @@ static int create_multi_out_ctls(struct hda_codec *codec,
 			if (err < 0)
 				return err;
 		} else {
-			err = add_stereo_vol(codec, name, index, path);
-			if (err < 0)
-				return err;
 			err = add_stereo_sw(codec, name, index, path);
 			if (err < 0)
 				return err;
-- 
1.8.1
