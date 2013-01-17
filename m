From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/9] ALSA: hda - Record all detected ADCs in
	hda_gen_spec
Date: Thu, 17 Jan 2013 17:54:52 +0100
Message-ID: <1358441694-32004-8-git-send-email-tiwai@suse.de>
References: <1358441694-32004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 014542650D7
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:55:00 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D3066A5077
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

Since the generic parser reduces the ADC list, copy the list of the
all detected ADCs and keep it.

This list can be later referred by the codec driver for finer power
controls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 5 +++++
 sound/pci/hda/hda_generic.h | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 9c06749..fc3f241 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2368,6 +2368,11 @@ static int fill_adc_nids(struct hda_codec *codec)
 			break;
 	}
 	spec->num_adc_nids = nums;
+
+	/* copy the detected ADCs to all_adcs[] */
+	spec->num_all_adcs = nums;
+	memcpy(spec->all_adcs, spec->adc_nids, nums * sizeof(hda_nid_t));
+
 	return nums;
 }
 
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 43a8482..a0486b1 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -142,9 +142,11 @@ struct hda_gen_spec {
 	unsigned int dyn_adc_idx[HDA_MAX_NUM_INPUTS];
 	hda_nid_t shared_mic_vref_pin;
 
-	/* DAC list */
+	/* DAC/ADC lists */
 	int num_all_dacs;
 	hda_nid_t all_dacs[16];
+	int num_all_adcs;
+	hda_nid_t all_adcs[AUTO_CFG_MAX_OUTS];
 
 	/* path list */
 	struct snd_array paths;
-- 
1.8.1
