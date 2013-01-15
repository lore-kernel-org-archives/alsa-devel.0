From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/20] ALSA: hda - Clear the dropped paths
	properly
Date: Tue, 15 Jan 2013 12:05:32 +0100
Message-ID: <1358247947-13992-6-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DBF7265315
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 77868A5211
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

When a DAC is reassigned from surrounds to front or ADCs are reduced
due to incomplete imux, we clear the path indices but the path
instances remain as is.  Since the paths might be still referred
through the whole path list parsing (e.g. is_active_nid()), we should
clear these path instances as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 26e8d83..a9bf188 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -331,6 +331,15 @@ snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
 }
 EXPORT_SYMBOL_HDA(snd_hda_add_new_path);
 
+/* clear the given path as invalid so that it won't be picked up later */
+static void invalidate_nid_path(struct hda_codec *codec, int idx)
+{
+	struct nid_path *path = snd_hda_get_path_from_idx(codec, idx);
+	if (!path)
+		return;
+	memset(path, 0, sizeof(*path));
+}
+
 /* look for an empty DAC slot */
 static hda_nid_t look_for_dac(struct hda_codec *codec, hda_nid_t pin,
 			      bool is_digital)
@@ -891,10 +900,12 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 
 		dacs[i] = look_for_dac(codec, pin, false);
 		if (!dacs[i] && !i) {
+			/* try to steal the DAC of surrounds for the front */
 			for (j = 1; j < num_outs; j++) {
 				if (is_reachable_path(codec, dacs[j], pin)) {
 					dacs[0] = dacs[j];
 					dacs[j] = 0;
+					invalidate_nid_path(codec, path_idx[j]);
 					path_idx[j] = 0;
 					break;
 				}
@@ -2046,9 +2057,12 @@ static int check_dyn_adc_switch(struct hda_codec *codec)
 				continue;
 			if (n != nums) {
 				spec->adc_nids[nums] = spec->adc_nids[n];
-				for (i = 0; i < imux->num_items; i++)
+				for (i = 0; i < imux->num_items; i++) {
+					invalidate_nid_path(codec,
+						spec->input_paths[i][nums]);
 					spec->input_paths[i][nums] =
 						spec->input_paths[i][n];
+				}
 			}
 			nums++;
 		}
-- 
1.8.1
