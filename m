From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 37/53] ALSA: x86: Remove superfluous irqsave
	flags
Date: Thu,  2 Feb 2017 18:02:51 +0100
Message-ID: <20170202170307.24484-39-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C52326759D
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:18 +0100 (CET)
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

We don't need to use irqsave/irqrestore versions for each spin lock,
but judge the context properly and use the simpler versions.

Also add some (still simplistic) comments to functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 71 ++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 81b6c26a8646..046af2367fba 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1135,7 +1135,6 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
 	int retval = 0;
-	unsigned long flag_irq;
 	struct snd_intelhad *intelhaddata;
 	struct had_stream_pvt *stream;
 	struct had_stream_data *had_stream;
@@ -1163,14 +1162,14 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irq);
+		spin_lock(&intelhaddata->had_spinlock);
 		intelhaddata->stream_info.str_id = 0;
 		intelhaddata->curr_buf = 0;
 
 		/* Stop reporting BUFFER_DONE/UNDERRUN to above layers */
 
 		had_stream->stream_type = HAD_INIT;
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irq);
+		spin_unlock(&intelhaddata->had_spinlock);
 		/* Disable Audio */
 		snd_intelhad_enable_audio_int(intelhaddata, false);
 		snd_intelhad_enable_audio(intelhaddata, false);
@@ -1402,7 +1401,6 @@ static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 				  pm_message_t state)
 {
 	struct had_stream_data *had_stream;
-	unsigned long flag_irqs;
 	struct snd_pcm_substream *substream;
 	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
 
@@ -1414,15 +1412,15 @@ static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 		return -EAGAIN;
 	}
 
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	spin_lock_irq(&intelhaddata->had_spinlock);
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		spin_unlock_irq(&intelhaddata->had_spinlock);
 		dev_dbg(intelhaddata->dev, "had not connected\n");
 		return 0;
 	}
 
 	if (intelhaddata->drv_status == HAD_DRV_SUSPENDED) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		spin_unlock_irq(&intelhaddata->had_spinlock);
 		dev_dbg(intelhaddata->dev, "had already suspended\n");
 		return 0;
 	}
@@ -1432,7 +1430,7 @@ static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_SUSPENDED\n",
 			__func__, __LINE__);
 
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+	spin_unlock_irq(&intelhaddata->had_spinlock);
 	snd_intelhad_enable_audio_int(intelhaddata, false);
 	return 0;
 }
@@ -1446,17 +1444,16 @@ static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 static int hdmi_lpe_audio_resume(struct platform_device *pdev)
 {
 	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
-	unsigned long flag_irqs;
 
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	spin_lock_irq(&intelhaddata->had_spinlock);
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		spin_unlock_irq(&intelhaddata->had_spinlock);
 		dev_dbg(intelhaddata->dev, "had not connected\n");
 		return 0;
 	}
 
 	if (intelhaddata->drv_status != HAD_DRV_SUSPENDED) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		spin_unlock_irq(&intelhaddata->had_spinlock);
 		dev_dbg(intelhaddata->dev, "had is not in suspended state\n");
 		return 0;
 	}
@@ -1465,7 +1462,7 @@ static int hdmi_lpe_audio_resume(struct platform_device *pdev)
 	dev_dbg(intelhaddata->dev,
 		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
 			__func__, __LINE__);
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+	spin_unlock_irq(&intelhaddata->had_spinlock);
 	snd_intelhad_enable_audio_int(intelhaddata, true);
 	return 0;
 }
@@ -1477,7 +1474,6 @@ static inline int had_chk_intrmiss(struct snd_intelhad *intelhaddata,
 	enum intel_had_aud_buf_type buff_done;
 	u32 buf_size, buf_addr;
 	struct had_stream_data *had_stream;
-	unsigned long flag_irqs;
 
 	had_stream = &intelhaddata->stream_data;
 
@@ -1507,14 +1503,13 @@ static inline int had_chk_intrmiss(struct snd_intelhad *intelhaddata,
 					   (buf_addr | BIT(0) | BIT(1)));
 		}
 		buf_id = buf_id % 4;
-		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
 		intelhaddata->buff_done = buf_id;
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
 	}
 
 	return intr_count;
 }
 
+/* called from irq handler */
 static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 {
 	u32 len = 1;
@@ -1525,15 +1520,15 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	struct had_stream_data *had_stream;
 	int intr_count;
 	enum had_status_stream		stream_type;
-	unsigned long flag_irqs;
+	unsigned long flags;
 
 	had_stream = &intelhaddata->stream_data;
 	stream = &intelhaddata->stream_info;
 	intr_count = 1;
 
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
 		dev_dbg(intelhaddata->dev,
 			"%s:Device already disconnected\n", __func__);
 		return 0;
@@ -1551,16 +1546,16 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 
 	/* Check for any intr_miss in case of active playback */
 	if (had_stream->stream_type == HAD_RUNNING_STREAM) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
 		intr_count = had_chk_intrmiss(intelhaddata, buf_id);
 		if (!intr_count || (intr_count > 3)) {
+			spin_unlock_irqrestore(&intelhaddata->had_spinlock,
+					       flags);
 			dev_err(intelhaddata->dev,
 				"HAD SW state in non-recoverable mode\n");
 			return 0;
 		}
 		buf_id += (intr_count - 1);
 		buf_id = buf_id % 4;
-		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
 	}
 
 	intelhaddata->buf_info[buf_id].is_valid = true;
@@ -1570,7 +1565,7 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	} else
 		intelhaddata->curr_buf = buf_id + 1;
 
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
 
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		dev_dbg(intelhaddata->dev, "HDMI cable plugged-out\n");
@@ -1604,19 +1599,20 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	return 0;
 }
 
+/* called from irq handler */
 static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
 	struct pcm_stream_info *stream;
 	struct had_stream_data *had_stream;
 	enum had_status_stream stream_type;
-	unsigned long flag_irqs;
+	unsigned long flags;
 	int drv_status;
 
 	had_stream = &intelhaddata->stream_data;
 	stream = &intelhaddata->stream_info;
 
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
 	buf_id = intelhaddata->curr_buf;
 	stream_type = had_stream->stream_type;
 	intelhaddata->buff_done = buf_id;
@@ -1624,7 +1620,7 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 	if (stream_type == HAD_RUNNING_STREAM)
 		intelhaddata->curr_buf = HAD_BUF_TYPE_A;
 
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
 
 	dev_dbg(intelhaddata->dev, "Enter:%s buf_id=%d, stream_type=%d\n",
 			__func__, buf_id, stream_type);
@@ -1646,20 +1642,20 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 	return 0;
 }
 
+/* process hot plug, called from wq */
 static int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
 	struct snd_pcm_substream *substream;
 	struct had_stream_data *had_stream;
-	unsigned long flag_irqs;
 
 	substream = intelhaddata->stream_info.had_substream;
 	had_stream = &intelhaddata->stream_data;
 
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	spin_lock_irq(&intelhaddata->had_spinlock);
 	if (intelhaddata->drv_status == HAD_DRV_CONNECTED) {
 		dev_dbg(intelhaddata->dev, "Device already connected\n");
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		spin_unlock_irq(&intelhaddata->had_spinlock);
 		return 0;
 	}
 	buf_id = intelhaddata->curr_buf;
@@ -1668,7 +1664,7 @@ static int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 	dev_dbg(intelhaddata->dev,
 		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_CONNECTED\n",
 			__func__, __LINE__);
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+	spin_unlock_irq(&intelhaddata->had_spinlock);
 
 	dev_dbg(intelhaddata->dev, "Processing HOT_PLUG, buf_id = %d\n",
 		buf_id);
@@ -1686,20 +1682,20 @@ static int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 	return 0;
 }
 
+/* process hot unplug, called from wq */
 static int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
 	struct had_stream_data *had_stream;
-	unsigned long flag_irqs;
 
 	had_stream = &intelhaddata->stream_data;
 	buf_id = intelhaddata->curr_buf;
 
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	spin_lock_irq(&intelhaddata->had_spinlock);
 
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		dev_dbg(intelhaddata->dev, "Device already disconnected\n");
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		spin_unlock_irq(&intelhaddata->had_spinlock);
 		return 0;
 
 	} else {
@@ -1715,14 +1711,14 @@ static int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 
 	/* Report to above ALSA layer */
 	if (intelhaddata->stream_info.had_substream != NULL) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		spin_unlock_irq(&intelhaddata->had_spinlock);
 		snd_pcm_stop(intelhaddata->stream_info.had_substream,
 				SNDRV_PCM_STATE_SETUP);
-		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+		spin_lock_irq(&intelhaddata->had_spinlock);
 	}
 
 	had_stream->stream_type = HAD_INIT;
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+	spin_unlock_irq(&intelhaddata->had_spinlock);
 	kfree(intelhaddata->chmap->chmap);
 	intelhaddata->chmap->chmap = NULL;
 
@@ -1922,7 +1918,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	int irq;
 	struct resource *res_mmio;
 	int ret;
-	unsigned long flags;
 
 	dev_dbg(&pdev->dev, "dma_mask: %p\n", pdev->dev.dma_mask);
 
@@ -2034,10 +2029,10 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	spin_lock_irqsave(&pdata->lpe_audio_slock, flags);
+	spin_lock_irq(&pdata->lpe_audio_slock);
 	pdata->notify_audio_lpe = notify_audio_lpe;
 	pdata->notify_pending = false;
-	spin_unlock_irqrestore(&pdata->lpe_audio_slock, flags);
+	spin_unlock_irq(&pdata->lpe_audio_slock);
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.11.0
