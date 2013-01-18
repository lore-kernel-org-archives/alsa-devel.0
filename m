From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/3] ALSA: hda - make sure there are enough
	input labels and paths
Date: Fri, 18 Jan 2013 15:43:01 +0100
Message-ID: <1358520183-2908-2-git-send-email-david.henningsson@canonical.com>
References: <1358520183-2908-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 52B2226510D
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 15:43:03 +0100 (CET)
In-Reply-To: <1358520183-2908-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

I found a codec configuration which had six inputs, so the max of
five was not appropriate.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c |    2 +-
 sound/pci/hda/hda_generic.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index cadfe65..13e13df 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2649,7 +2649,7 @@ static struct nid_path *get_input_path(struct hda_codec *codec, int adc_idx, int
 	}
 	if (spec->dyn_adc_switch)
 		adc_idx = spec->dyn_adc_idx[imux_idx];
-	if (adc_idx < 0 || adc_idx >= AUTO_CFG_MAX_OUTS) {
+	if (adc_idx < 0 || adc_idx >= AUTO_CFG_MAX_INS) {
 		snd_BUG();
 		return NULL;
 	}
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index f6b88cd..94bf4bc 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -105,8 +105,8 @@ struct hda_gen_spec {
 	hda_nid_t adc_nids[AUTO_CFG_MAX_OUTS];
 	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
 	hda_nid_t mixer_nid;		/* analog-mixer NID */
-	const char *input_labels[AUTO_CFG_MAX_OUTS];
-	int input_label_idxs[AUTO_CFG_MAX_OUTS];
+	const char *input_labels[AUTO_CFG_MAX_INS];
+	int input_label_idxs[AUTO_CFG_MAX_INS];
 
 	/* capture setup for dynamic dual-adc switch */
 	hda_nid_t cur_adc;
@@ -159,7 +159,7 @@ struct hda_gen_spec {
 	int speaker_paths[AUTO_CFG_MAX_OUTS];
 	int aamix_out_paths[3];
 	int digout_paths[AUTO_CFG_MAX_OUTS];
-	int input_paths[HDA_MAX_NUM_INPUTS][AUTO_CFG_MAX_OUTS];
+	int input_paths[HDA_MAX_NUM_INPUTS][AUTO_CFG_MAX_INS];
 	int loopback_paths[HDA_MAX_NUM_INPUTS];
 	int digin_path;
 
-- 
1.7.9.5
