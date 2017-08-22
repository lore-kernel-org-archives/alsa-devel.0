From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: ctxfi: Use common error handling code in
	two functions
Date: Tue, 22 Aug 2017 18:50:16 +0200
Message-ID: <6293f7ce-a3c7-ace8-cab4-26d09f4e0c91@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 765312669F6
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 18:50:24 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 22 Aug 2017 18:43:42 +0200

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ctxfi/ctpcm.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/sound/pci/ctxfi/ctpcm.c b/sound/pci/ctxfi/ctpcm.c
index 974978041558..dece6a81060d 100644
--- a/sound/pci/ctxfi/ctpcm.c
+++ b/sound/pci/ctxfi/ctpcm.c
@@ -140,27 +140,28 @@ static int ct_pcm_playback_open(struct snd_pcm_substream *substream)
 
 	err = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
-	if (err < 0) {
-		kfree(apcm);
-		return err;
-	}
+	if (err < 0)
+		goto free_pcm;
+
 	err = snd_pcm_hw_constraint_minmax(runtime,
 					   SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 					   1024, UINT_MAX);
-	if (err < 0) {
-		kfree(apcm);
-		return err;
-	}
+	if (err < 0)
+		goto free_pcm;
 
 	apcm->timer = ct_timer_instance_new(atc->timer, apcm);
 	if (!apcm->timer) {
-		kfree(apcm);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_pcm;
 	}
 	runtime->private_data = apcm;
 	runtime->private_free = ct_atc_pcm_free_substream;
 
 	return 0;
+
+free_pcm:
+	kfree(apcm);
+	return err;
 }
 
 static int ct_pcm_playback_close(struct snd_pcm_substream *substream)
@@ -286,27 +287,28 @@ static int ct_pcm_capture_open(struct snd_pcm_substream *substream)
 
 	err = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
-	if (err < 0) {
-		kfree(apcm);
-		return err;
-	}
+	if (err < 0)
+		goto free_pcm;
+
 	err = snd_pcm_hw_constraint_minmax(runtime,
 					   SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 					   1024, UINT_MAX);
-	if (err < 0) {
-		kfree(apcm);
-		return err;
-	}
+	if (err < 0)
+		goto free_pcm;
 
 	apcm->timer = ct_timer_instance_new(atc->timer, apcm);
 	if (!apcm->timer) {
-		kfree(apcm);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_pcm;
 	}
 	runtime->private_data = apcm;
 	runtime->private_free = ct_atc_pcm_free_substream;
 
 	return 0;
+
+free_pcm:
+	kfree(apcm);
+	return err;
 }
 
 static int ct_pcm_capture_close(struct snd_pcm_substream *substream)
-- 
2.14.0
