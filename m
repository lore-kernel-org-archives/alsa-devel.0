From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 44/53] ALSA: x86: Implement runtime PM
Date: Thu,  2 Feb 2017 18:02:58 +0100
Message-ID: <20170202170307.24484-46-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F3607267595
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:17 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Although the driver has some PM callbacks, it doesn't do it right:
- the suspend callback doesn't handle to suspend the running PCM,
- the runtime PM ops are missing,
- pm_runtime_get_sync() isn't used at the right place.

This patch covers the above and provides the basic runtime PM
functionality.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 127 +++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 77 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index c209d9498c0e..04ff7f14fe12 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -975,7 +975,7 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 	runtime = substream->runtime;
 	intelhaddata->underrun_count = 0;
 
-	pm_runtime_get(intelhaddata->dev);
+	pm_runtime_get_sync(intelhaddata->dev);
 
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		dev_dbg(intelhaddata->dev, "%s: HDMI cable plugged-out\n",
@@ -1129,6 +1129,8 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
 		/* Disable local INTRs till register prgmng is done */
 		if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 			dev_dbg(intelhaddata->dev,
@@ -1145,6 +1147,8 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 		spin_lock(&intelhaddata->had_spinlock);
 		intelhaddata->curr_buf = 0;
 
@@ -1354,80 +1358,6 @@ static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 	return retval;
 }
 
-/*
- * hdmi_lpe_audio_suspend - power management suspend function
- * @pdev: platform device
- *
- * This function is called to suspend the hdmi audio.
- */
-static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
-				  pm_message_t state)
-{
-	struct had_stream_data *had_stream;
-	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
-
-	had_stream = &intelhaddata->stream_data;
-
-	if (!pm_runtime_status_suspended(intelhaddata->dev)) {
-		dev_err(intelhaddata->dev, "audio stream is active\n");
-		return -EAGAIN;
-	}
-
-	spin_lock_irq(&intelhaddata->had_spinlock);
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
-		spin_unlock_irq(&intelhaddata->had_spinlock);
-		dev_dbg(intelhaddata->dev, "had not connected\n");
-		return 0;
-	}
-
-	if (intelhaddata->drv_status == HAD_DRV_SUSPENDED) {
-		spin_unlock_irq(&intelhaddata->had_spinlock);
-		dev_dbg(intelhaddata->dev, "had already suspended\n");
-		return 0;
-	}
-
-	intelhaddata->drv_status = HAD_DRV_SUSPENDED;
-	dev_dbg(intelhaddata->dev,
-		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_SUSPENDED\n",
-			__func__, __LINE__);
-
-	spin_unlock_irq(&intelhaddata->had_spinlock);
-	snd_intelhad_enable_audio_int(intelhaddata, false);
-	return 0;
-}
-
-/*
- * hdmi_lpe_audio_resume - power management resume function
- * @pdev: platform device
- *
- * This function is called to resume the hdmi audio.
- */
-static int hdmi_lpe_audio_resume(struct platform_device *pdev)
-{
-	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
-
-	spin_lock_irq(&intelhaddata->had_spinlock);
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
-		spin_unlock_irq(&intelhaddata->had_spinlock);
-		dev_dbg(intelhaddata->dev, "had not connected\n");
-		return 0;
-	}
-
-	if (intelhaddata->drv_status != HAD_DRV_SUSPENDED) {
-		spin_unlock_irq(&intelhaddata->had_spinlock);
-		dev_dbg(intelhaddata->dev, "had is not in suspended state\n");
-		return 0;
-	}
-
-	intelhaddata->drv_status = HAD_DRV_CONNECTED;
-	dev_dbg(intelhaddata->dev,
-		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
-			__func__, __LINE__);
-	spin_unlock_irq(&intelhaddata->had_spinlock);
-	snd_intelhad_enable_audio_int(intelhaddata, true);
-	return 0;
-}
-
 static inline int had_chk_intrmiss(struct snd_intelhad *intelhaddata,
 		enum intel_had_aud_buf_type buf_id)
 {
@@ -1808,6 +1738,7 @@ static void had_audio_wq(struct work_struct *work)
 		container_of(work, struct snd_intelhad, hdmi_audio_wq);
 	struct intel_hdmi_lpe_audio_pdata *pdata = ctx->dev->platform_data;
 
+	pm_runtime_get_sync(ctx->dev);
 	mutex_lock(&ctx->mutex);
 	if (!pdata->hdmi_connected) {
 		dev_dbg(ctx->dev, "%s: Event: HAD_NOTIFY_HOT_UNPLUG\n",
@@ -1848,6 +1779,44 @@ static void had_audio_wq(struct work_struct *work)
 			hdmi_audio_mode_change(ctx);
 	}
 	mutex_unlock(&ctx->mutex);
+	pm_runtime_put(ctx->dev);
+}
+
+/*
+ * PM callbacks
+ */
+
+static int hdmi_lpe_audio_runtime_suspend(struct device *dev)
+{
+	struct snd_intelhad *ctx = dev_get_drvdata(dev);
+	struct snd_pcm_substream *substream;
+
+	substream = had_substream_get(ctx);
+	if (substream) {
+		snd_pcm_suspend(substream);
+		had_substream_put(ctx);
+	}
+
+	return 0;
+}
+
+static int hdmi_lpe_audio_suspend(struct device *dev)
+{
+	struct snd_intelhad *ctx = dev_get_drvdata(dev);
+	int err;
+
+	err = hdmi_lpe_audio_runtime_suspend(dev);
+	if (!err)
+		snd_power_change_state(ctx->card, SNDRV_CTL_POWER_D3hot);
+	return err;
+}
+
+static int hdmi_lpe_audio_resume(struct device *dev)
+{
+	struct snd_intelhad *ctx = dev_get_drvdata(dev);
+
+	snd_power_change_state(ctx->card, SNDRV_CTL_POWER_D0);
+	return 0;
 }
 
 /* release resources */
@@ -2021,14 +1990,18 @@ static int hdmi_lpe_audio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct dev_pm_ops hdmi_lpe_audio_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(hdmi_lpe_audio_suspend, hdmi_lpe_audio_resume)
+	SET_RUNTIME_PM_OPS(hdmi_lpe_audio_runtime_suspend, NULL, NULL)
+};
+
 static struct platform_driver hdmi_lpe_audio_driver = {
 	.driver		= {
 		.name  = "hdmi-lpe-audio",
+		.pm = &hdmi_lpe_audio_pm,
 	},
 	.probe          = hdmi_lpe_audio_probe,
 	.remove		= hdmi_lpe_audio_remove,
-	.suspend	= hdmi_lpe_audio_suspend,
-	.resume		= hdmi_lpe_audio_resume
 };
 
 module_platform_driver(hdmi_lpe_audio_driver);
-- 
2.11.0
