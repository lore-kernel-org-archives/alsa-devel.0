From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: x86: Use runtime PM autosuspend
Date: Mon, 13 Feb 2017 15:39:18 +0100
Message-ID: <20170213143919.19543-4-tiwai@suse.de>
References: <20170213143919.19543-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E03C0265142
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 15:39:23 +0100 (CET)
In-Reply-To: <20170213143919.19543-1-tiwai@suse.de>
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds a few lines to the driver to use autosuspend for the
runtime PM.  It'll become useful with the combination of the keep-link
feature.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 9889cdf3ccf4..95b07a260d54 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1076,7 +1076,8 @@ static int had_pcm_open(struct snd_pcm_substream *substream)
 
 	return retval;
  error:
-	pm_runtime_put(intelhaddata->dev);
+	pm_runtime_mark_last_busy(intelhaddata->dev);
+	pm_runtime_put_autosuspend(intelhaddata->dev);
 	return retval;
 }
 
@@ -1100,7 +1101,8 @@ static int had_pcm_close(struct snd_pcm_substream *substream)
 	}
 	spin_unlock_irq(&intelhaddata->had_spinlock);
 
-	pm_runtime_put(intelhaddata->dev);
+	pm_runtime_mark_last_busy(intelhaddata->dev);
+	pm_runtime_put_autosuspend(intelhaddata->dev);
 	return 0;
 }
 
@@ -1605,7 +1607,8 @@ static void had_audio_wq(struct work_struct *work)
 		had_process_mode_change(ctx);
 	}
 	mutex_unlock(&ctx->mutex);
-	pm_runtime_put(ctx->dev);
+	pm_runtime_mark_last_busy(ctx->dev);
+	pm_runtime_put_autosuspend(ctx->dev);
 }
 
 /*
@@ -1637,10 +1640,17 @@ static int __maybe_unused hdmi_lpe_audio_suspend(struct device *dev)
 	return err;
 }
 
+static int hdmi_lpe_audio_runtime_resume(struct device *dev)
+{
+	pm_runtime_mark_last_busy(dev);
+	return 0;
+}
+
 static int __maybe_unused hdmi_lpe_audio_resume(struct device *dev)
 {
 	struct snd_intelhad *ctx = dev_get_drvdata(dev);
 
+	hdmi_lpe_audio_runtime_resume(dev);
 	snd_power_change_state(ctx->card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
@@ -1789,6 +1799,9 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	pdata->notify_pending = false;
 	spin_unlock_irq(&pdata->lpe_audio_slock);
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
@@ -1817,7 +1830,8 @@ static int hdmi_lpe_audio_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops hdmi_lpe_audio_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(hdmi_lpe_audio_suspend, hdmi_lpe_audio_resume)
-	SET_RUNTIME_PM_OPS(hdmi_lpe_audio_runtime_suspend, NULL, NULL)
+	SET_RUNTIME_PM_OPS(hdmi_lpe_audio_runtime_suspend,
+			   hdmi_lpe_audio_runtime_resume, NULL)
 };
 
 static struct platform_driver hdmi_lpe_audio_driver = {
-- 
2.11.1
