From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/14] ALSA: drivers: Remove superfluous
	snd_pcm_suspend*() calls
Date: Tue, 15 Jan 2019 17:21:45 +0100
Message-ID: <20190115162155.6308-5-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D60526743C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:57 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The call of snd_pcm_suspend_all() & co became superfluous since we
call it in the PCM PM ops.  Let's remove them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c      | 4 ----
 sound/drivers/dummy.c      | 2 --
 sound/drivers/pcsp/pcsp.c  | 1 -
 sound/drivers/vx/vx_core.c | 4 ----
 4 files changed, 11 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 1e34e6381baa..65c903b639c2 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1200,12 +1200,8 @@ static int loopback_remove(struct platform_device *devptr)
 static int loopback_suspend(struct device *pdev)
 {
 	struct snd_card *card = dev_get_drvdata(pdev);
-	struct loopback *loopback = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-
-	snd_pcm_suspend_all(loopback->pcm[0]);
-	snd_pcm_suspend_all(loopback->pcm[1]);
 	return 0;
 }
 	
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 9af154db530a..c8d31550e9a1 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -1138,10 +1138,8 @@ static int snd_dummy_remove(struct platform_device *devptr)
 static int snd_dummy_suspend(struct device *pdev)
 {
 	struct snd_card *card = dev_get_drvdata(pdev);
-	struct snd_dummy *dummy = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(dummy->pcm);
 	return 0;
 }
 	
diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 0dd3f46eb03e..d83ad3820f02 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -197,7 +197,6 @@ static int pcsp_suspend(struct device *dev)
 {
 	struct snd_pcsp *chip = dev_get_drvdata(dev);
 	pcsp_stop_beep(chip);
-	snd_pcm_suspend_all(chip->pcm);
 	return 0;
 }
 
diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index 04368dd59a4c..19496fa486aa 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -732,12 +732,8 @@ EXPORT_SYMBOL(snd_vx_dsp_load);
  */
 int snd_vx_suspend(struct vx_core *chip)
 {
-	unsigned int i;
-
 	snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
 	chip->chip_status |= VX_STAT_IN_SUSPEND;
-	for (i = 0; i < chip->hw->num_codecs; i++)
-		snd_pcm_suspend_all(chip->pcm[i]);
 
 	return 0;
 }
-- 
2.20.1
