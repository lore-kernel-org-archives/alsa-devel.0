From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Introduce the bitmask for
	excluding output volume
Date: Mon,  4 Nov 2013 17:09:06 +0100
Message-ID: <1383581346-10018-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (unknown [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DF1F264FD7
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 17:09:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5EF27A60D0
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 17:09:06 +0100 (CET)
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

Add a bitmask to hda_gen_spec indicating NIDs to exclude from the
possible volume controls.  That is, when the bit is set, the NID
corresponding to the bit won't be picked as an output volume control
any longer.

Basically this is just a band-aid for working around the issue found
with CS4208 codec, where only the headphone pin has a volume AMP with
different dB steps.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=60811
Cc: <stable@vger.kernel.org> [v3.12+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c  | 8 ++++++--
 sound/pci/hda/hda_generic.h  | 3 +++
 sound/pci/hda/patch_cirrus.c | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b7c89dff7066..276f6e759bac 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -549,11 +549,15 @@ static hda_nid_t look_for_out_mute_nid(struct hda_codec *codec,
 static hda_nid_t look_for_out_vol_nid(struct hda_codec *codec,
 				      struct nid_path *path)
 {
+	struct hda_gen_spec *spec = codec->spec;
 	int i;
 
 	for (i = path->depth - 1; i >= 0; i--) {
-		if (nid_has_volume(codec, path->path[i], HDA_OUTPUT))
-			return path->path[i];
+		hda_nid_t nid = path->path[i];
+		if ((spec->out_vol_mask >> nid) & 1)
+			continue;
+		if (nid_has_volume(codec, nid, HDA_OUTPUT))
+			return nid;
 	}
 	return 0;
 }
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 48d44026705b..7e45cb44d151 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -242,6 +242,9 @@ struct hda_gen_spec {
 	/* additional mute flags (only effective with auto_mute_via_amp=1) */
 	u64 mute_bits;
 
+	/* bitmask for skipping volume controls */
+	u64 out_vol_mask;
+
 	/* badness tables for output path evaluations */
 	const struct badness_table *main_out_badness;
 	const struct badness_table *extra_out_badness;
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 18d972501585..38d073ed4bcc 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -660,6 +660,8 @@ static int patch_cs4208(struct hda_codec *codec)
 		return -ENOMEM;
 
 	spec->gen.automute_hook = cs_automute;
+	/* exclude NID 0x10 (HP) from output volumes due to different steps */
+	spec->gen.out_vol_mask = 1ULL << 0x10;
 
 	snd_hda_pick_fixup(codec, cs4208_models, cs4208_fixup_tbl,
 			   cs4208_fixups);
-- 
1.8.4.2
