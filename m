From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: HDA: Improve unlocking of a mutex in
	hdmi_pcm_open()
Date: Wed, 15 Nov 2017 15:00:21 +0100
Message-ID: <dd3cb768-1eb2-bc1d-f6ec-05249c60488e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EEEB266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 15:01:13 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Ander Conselvan De Oliveira <ander.conselvan.de.oliveira@intel.com>, Bhumika Goyal <bhumirks@gmail.com>, Daniel Dadap <ddadap@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Libin Yang <libin.yang@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2017 14:46:19 +0100

* Add a jump target so that a call of the function "mutex_unlock" is stored
  only twice in this function implementation.

* Replace four calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/hda/patch_hdmi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index c19c81d230bd..f1c0b6cab90a 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1205,8 +1205,8 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	pin_idx = hinfo_to_pin_index(codec, hinfo);
 	if (!spec->dyn_pcm_assign) {
 		if (snd_BUG_ON(pin_idx < 0)) {
-			mutex_unlock(&spec->pcm_lock);
-			return -EINVAL;
+			err = -EINVAL;
+			goto unlock;
 		}
 	} else {
 		/* no pin is assigned to the PCM
@@ -1214,16 +1214,13 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 		 */
 		if (pin_idx < 0) {
 			err = hdmi_pcm_open_no_pin(hinfo, codec, substream);
-			mutex_unlock(&spec->pcm_lock);
-			return err;
+			goto unlock;
 		}
 	}
 
 	err = hdmi_choose_cvt(codec, pin_idx, &cvt_idx);
-	if (err < 0) {
-		mutex_unlock(&spec->pcm_lock);
-		return err;
-	}
+	if (err < 0)
+		goto unlock;
 
 	per_cvt = get_cvt(spec, cvt_idx);
 	/* Claim converter */
@@ -1260,8 +1257,8 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 			per_cvt->assigned = 0;
 			hinfo->nid = 0;
 			snd_hda_spdif_ctls_unassign(codec, pcm_idx);
-			mutex_unlock(&spec->pcm_lock);
-			return -ENODEV;
+			err = -ENODEV;
+			goto unlock;
 		}
 	}
 
@@ -1275,6 +1272,10 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
 				   SNDRV_PCM_HW_PARAM_CHANNELS, 2);
 	return 0;
+
+unlock:
+	mutex_unlock(&spec->pcm_lock);
+	return err;
 }
 
 /*
-- 
2.15.0
