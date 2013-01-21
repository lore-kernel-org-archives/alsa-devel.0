From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/12] ALSA: hda - Correct more array rooms in
	hda_gen_spec
Date: Mon, 21 Jan 2013 17:06:06 +0100
Message-ID: <1358784377-26102-2-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D02B261624
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D9FB1A51C9
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

Looking through the whole definitions, some fields have inappropriate
array sizes, especially about the capture.  The array assigned to each
input (pin) should have HDA_MAX_NUM_INPUTS entries while the array
assigned to each ADC should have AUTO_CFG_MAX_INS entries.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index eacfca9..696b606 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -102,11 +102,11 @@ struct hda_gen_spec {
 
 	/* capture */
 	unsigned int num_adc_nids;
-	hda_nid_t adc_nids[AUTO_CFG_MAX_OUTS];
+	hda_nid_t adc_nids[AUTO_CFG_MAX_INS];
 	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
 	hda_nid_t mixer_nid;		/* analog-mixer NID */
-	const char *input_labels[AUTO_CFG_MAX_INS];
-	int input_label_idxs[AUTO_CFG_MAX_INS];
+	const char *input_labels[HDA_MAX_NUM_INPUTS];
+	int input_label_idxs[HDA_MAX_NUM_INPUTS];
 
 	/* capture setup for dynamic dual-adc switch */
 	hda_nid_t cur_adc;
@@ -148,7 +148,7 @@ struct hda_gen_spec {
 	int num_all_dacs;
 	hda_nid_t all_dacs[16];
 	int num_all_adcs;
-	hda_nid_t all_adcs[AUTO_CFG_MAX_OUTS];
+	hda_nid_t all_adcs[AUTO_CFG_MAX_INS];
 
 	/* path list */
 	struct snd_array paths;
-- 
1.8.1.1
