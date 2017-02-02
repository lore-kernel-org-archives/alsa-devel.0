From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 52/53] ALSA: x86: Yet more tidy-up and clean-ups
Date: Thu,  2 Feb 2017 18:03:06 +0100
Message-ID: <20170202170307.24484-54-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 54C9F26759B
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

- Add a few more comments to functions.

- Move the initialization of some PCM state variables to open and
  prepare callbacks, where these are clearer places.

- Remove superfluous NULL checks.

- Get rid of the bogus drv_status change to CONNECTED at close;
  this doesn't make any sense.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 68 +++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 5613c675ce70..f032610d1287 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -965,7 +965,6 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 	runtime = substream->runtime;
-	intelhaddata->underrun_count = 0;
 
 	pm_runtime_get_sync(intelhaddata->dev);
 
@@ -989,17 +988,20 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 	 */
 	retval = snd_pcm_hw_constraint_step(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64);
-	if (retval < 0) {
-		dev_dbg(intelhaddata->dev, "%s:step_size=64 failed,err=%d\n",
-			__func__, retval);
+	if (retval < 0)
 		goto error;
-	}
 
+	/* expose PCM substream */
 	spin_lock_irq(&intelhaddata->had_spinlock);
 	intelhaddata->stream_info.substream = substream;
 	intelhaddata->stream_info.substream_refcount++;
 	spin_unlock_irq(&intelhaddata->had_spinlock);
 
+	/* these are cleared in prepare callback, but just to be sure */
+	intelhaddata->curr_buf = 0;
+	intelhaddata->underrun_count = 0;
+	intelhaddata->stream_info.buffer_rendered = 0;
+
 	return retval;
  error:
 	pm_runtime_put(intelhaddata->dev);
@@ -1015,7 +1017,7 @@ static int snd_intelhad_close(struct snd_pcm_substream *substream)
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 
-	intelhaddata->stream_info.buffer_rendered = 0;
+	/* unreference and sync with the pending PCM accesses */
 	spin_lock_irq(&intelhaddata->had_spinlock);
 	intelhaddata->stream_info.substream = NULL;
 	intelhaddata->stream_info.substream_refcount--;
@@ -1026,13 +1028,6 @@ static int snd_intelhad_close(struct snd_pcm_substream *substream)
 	}
 	spin_unlock_irq(&intelhaddata->had_spinlock);
 
-	/* Check if following drv_status modification is required - VA */
-	if (intelhaddata->drv_status != HAD_DRV_DISCONNECTED) {
-		intelhaddata->drv_status = HAD_DRV_CONNECTED;
-		dev_dbg(intelhaddata->dev,
-			"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_CONNECTED\n",
-			__func__, __LINE__);
-	}
 	pm_runtime_put(intelhaddata->dev);
 	return 0;
 }
@@ -1047,9 +1042,6 @@ static int snd_intelhad_hw_params(struct snd_pcm_substream *substream,
 	unsigned long addr;
 	int pages, buf_size, retval;
 
-	if (!hw_params)
-		return -EINVAL;
-
 	intelhaddata = snd_pcm_substream_chip(substream);
 	buf_size = params_buffer_bytes(hw_params);
 	retval = snd_pcm_lib_malloc_pages(substream, buf_size);
@@ -1124,7 +1116,6 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		spin_lock(&intelhaddata->had_spinlock);
-		intelhaddata->curr_buf = 0;
 
 		/* Stop reporting BUFFER_DONE/UNDERRUN to above layers */
 
@@ -1174,6 +1165,8 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	dev_dbg(intelhaddata->dev, "rate=%d\n", runtime->rate);
 	dev_dbg(intelhaddata->dev, "channels=%d\n", runtime->channels);
 
+	intelhaddata->curr_buf = 0;
+	intelhaddata->underrun_count = 0;
 	intelhaddata->stream_info.buffer_rendered = 0;
 
 	/* Get N value in KHz */
@@ -1247,7 +1240,6 @@ snd_intelhad_pcm_pointer(struct snd_pcm_substream *substream)
 			dev_dbg(intelhaddata->dev,
 				"assume audio_codec_reset, underrun = %d - do xrun\n",
 				 intelhaddata->underrun_count);
-			intelhaddata->underrun_count = 0;
 			return SNDRV_PCM_POS_XRUN;
 		}
 	} else {
@@ -1277,6 +1269,21 @@ static int snd_intelhad_pcm_mmap(struct snd_pcm_substream *substream,
 			vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
 
+/*
+ * ALSA PCM ops
+ */
+static const struct snd_pcm_ops snd_intelhad_playback_ops = {
+	.open =		snd_intelhad_open,
+	.close =	snd_intelhad_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_intelhad_hw_params,
+	.hw_free =	snd_intelhad_hw_free,
+	.prepare =	snd_intelhad_pcm_prepare,
+	.trigger =	snd_intelhad_pcm_trigger,
+	.pointer =	snd_intelhad_pcm_pointer,
+	.mmap =	snd_intelhad_pcm_mmap,
+};
+
 /* process mode change of the running stream; called in mutex */
 static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 {
@@ -1564,18 +1571,9 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	intelhaddata->chmap->chmap = NULL;
 }
 
-/* PCM operations structure and the calls back for the same */
-static struct snd_pcm_ops snd_intelhad_playback_ops = {
-	.open =		snd_intelhad_open,
-	.close =	snd_intelhad_close,
-	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_intelhad_hw_params,
-	.hw_free =	snd_intelhad_hw_free,
-	.prepare =	snd_intelhad_pcm_prepare,
-	.trigger =	snd_intelhad_pcm_trigger,
-	.pointer =	snd_intelhad_pcm_pointer,
-	.mmap =	snd_intelhad_pcm_mmap,
-};
+/*
+ * ALSA iec958 and ELD controls
+ */
 
 static int had_iec958_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
@@ -1651,7 +1649,7 @@ static int had_ctl_eld_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new had_controls[] = {
+static const struct snd_kcontrol_new had_controls[] = {
 	{
 		.access = SNDRV_CTL_ELEM_ACCESS_READ,
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1676,7 +1674,9 @@ static struct snd_kcontrol_new had_controls[] = {
 	},
 };
 
-
+/*
+ * audio interrupt handler
+ */
 static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 {
 	struct snd_intelhad *ctx = dev_id;
@@ -1698,6 +1698,9 @@ static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*
+ * monitor plug/unplug notification from i915; just kick off the work
+ */
 static void notify_audio_lpe(struct platform_device *pdev)
 {
 	struct snd_intelhad *ctx = platform_get_drvdata(pdev);
@@ -1705,6 +1708,7 @@ static void notify_audio_lpe(struct platform_device *pdev)
 	schedule_work(&ctx->hdmi_audio_wq);
 }
 
+/* the work to handle monitor hot plug/unplug */
 static void had_audio_wq(struct work_struct *work)
 {
 	struct snd_intelhad *ctx =
-- 
2.11.0
