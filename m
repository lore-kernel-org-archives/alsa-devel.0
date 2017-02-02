From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 25/53] ALSA: x86: Fold intel_hdmi_audio_if.c
	into main file
Date: Thu,  2 Feb 2017 18:02:39 +0100
Message-ID: <20170202170307.24484-27-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E35A4267578
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:16 +0100 (CET)
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

As the very last step, we fold intel_hdmi_audio_if.c into the main
file, intel_hdmi_audio.c.  This is merely a cleanup, and no functional
change.

By this move, we can mark all functions and variables as static, which
allows the compiler more optimizations.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/Makefile              |   3 +-
 sound/x86/intel_hdmi_audio.c    | 391 ++++++++++++++++++++++++++++++++++++++--
 sound/x86/intel_hdmi_audio.h    |  31 ----
 sound/x86/intel_hdmi_audio_if.c | 390 ---------------------------------------
 4 files changed, 376 insertions(+), 439 deletions(-)
 delete mode 100644 sound/x86/intel_hdmi_audio_if.c

diff --git a/sound/x86/Makefile b/sound/x86/Makefile
index 3c0bf63333e6..7ff919808320 100644
--- a/sound/x86/Makefile
+++ b/sound/x86/Makefile
@@ -1,5 +1,4 @@
 snd-hdmi-lpe-audio-objs += \
-	intel_hdmi_audio.o \
-	intel_hdmi_audio_if.o
+	intel_hdmi_audio.o
 
 obj-$(CONFIG_HDMI_LPE_AUDIO) += snd-hdmi-lpe-audio.o
diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 1594f826cf31..effe93b58273 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -157,8 +157,7 @@ static const struct snd_pcm_hardware snd_intel_hadstream = {
 };
 
 /* Register access functions */
-
-int had_get_hwstate(struct snd_intelhad *intelhaddata)
+static int had_get_hwstate(struct snd_intelhad *intelhaddata)
 {
 	/* Check for device presence -SW state */
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
@@ -182,7 +181,8 @@ mid_hdmi_audio_write(struct snd_intelhad *ctx, u32 reg, u32 val)
 	iowrite32(val, ctx->mmio_start + ctx->had_config_offset + reg);
 }
 
-int had_read_register(struct snd_intelhad *intelhaddata, u32 offset, u32 *data)
+static int had_read_register(struct snd_intelhad *intelhaddata,
+			     u32 offset, u32 *data)
 {
 	int retval;
 
@@ -203,7 +203,8 @@ static void fixup_dp_config(struct snd_intelhad *intelhaddata,
 	}
 }
 
-int had_write_register(struct snd_intelhad *intelhaddata, u32 offset, u32 data)
+static int had_write_register(struct snd_intelhad *intelhaddata,
+			      u32 offset, u32 data)
 {
 	int retval;
 
@@ -216,8 +217,8 @@ int had_write_register(struct snd_intelhad *intelhaddata, u32 offset, u32 data)
 	return 0;
 }
 
-int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
-		    u32 data, u32 mask)
+static int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
+			   u32 data, u32 mask)
 {
 	u32 val_tmp;
 	int retval;
@@ -280,7 +281,7 @@ static int had_read_modify_aud_config_v2(struct snd_intelhad *intelhaddata,
 	return had_read_modify(intelhaddata, AUD_CONFIG, data, mask);
 }
 
-void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable)
+static void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable)
 {
 	u32 status_reg;
 
@@ -292,8 +293,8 @@ void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable)
 	}
 }
 
-void snd_intelhad_enable_audio(struct snd_intelhad *intelhaddata,
-			       bool enable)
+static void snd_intelhad_enable_audio(struct snd_intelhad *intelhaddata,
+				      bool enable)
 {
 	had_read_modify_aud_config_v2(intelhaddata, enable ? BIT(0) : 0,
 				      BIT(0));
@@ -488,7 +489,7 @@ static int spk_to_chmap(int spk)
 	return 0;
 }
 
-void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
+static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 {
 	int i = 0, c = 0;
 	int spk_mask = 0;
@@ -675,7 +676,7 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
  *
  * This function programs ring buffer address and length into registers.
  */
-int snd_intelhad_prog_buffer(struct snd_intelhad *intelhaddata,
+static int snd_intelhad_prog_buffer(struct snd_intelhad *intelhaddata,
 					int start, int end)
 {
 	u32 ring_buf_addr, ring_buf_size, period_bytes;
@@ -732,7 +733,7 @@ int snd_intelhad_prog_buffer(struct snd_intelhad *intelhaddata,
 	return 0;
 }
 
-int snd_intelhad_read_len(struct snd_intelhad *intelhaddata)
+static int snd_intelhad_read_len(struct snd_intelhad *intelhaddata)
 {
 	int i, retval = 0;
 	u32 len[4];
@@ -939,7 +940,7 @@ static int snd_intelhad_prog_n(u32 aud_samp_freq, u32 *n_param,
 	return 0;
 }
 
-void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
+static void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 {
 	u32 hdmi_status, i = 0;
 
@@ -1459,8 +1460,364 @@ static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 	return retval;
 }
 
-/*PCM operations structure and the calls back for the same */
-struct snd_pcm_ops snd_intelhad_playback_ops = {
+/*
+ * hdmi_lpe_audio_suspend - power management suspend function
+ *
+ * @pdev: platform device
+ *
+ * This function is called by client driver to suspend the
+ * hdmi audio.
+ */
+static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
+				  pm_message_t state)
+{
+	struct had_stream_data *had_stream;
+	unsigned long flag_irqs;
+	struct snd_pcm_substream *substream;
+	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
+
+	pr_debug("Enter:%s\n", __func__);
+
+	had_stream = &intelhaddata->stream_data;
+	substream = intelhaddata->stream_info.had_substream;
+
+	if (intelhaddata->dev->power.runtime_status != RPM_SUSPENDED) {
+		pr_err("audio stream is active\n");
+		return -EAGAIN;
+	}
+
+
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		pr_debug("had not connected\n");
+		return 0;
+	}
+
+	if (intelhaddata->drv_status == HAD_DRV_SUSPENDED) {
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		pr_debug("had already suspended\n");
+		return 0;
+	}
+
+	intelhaddata->drv_status = HAD_DRV_SUSPENDED;
+	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_SUSPENDED\n",
+			__func__, __LINE__);
+
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+	snd_intelhad_enable_audio_int(intelhaddata, false);
+	pr_debug("Exit:%s", __func__);
+	return 0;
+}
+
+/*
+ * hdmi_lpe_audio_resume - power management resume function
+ *
+ *@pdev: platform device
+ *
+ * This function is called by client driver to resume the
+ * hdmi audio.
+ */
+static int hdmi_lpe_audio_resume(struct platform_device *pdev)
+{
+	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
+	unsigned long flag_irqs;
+
+	pr_debug("Enter:%s\n", __func__);
+
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		pr_debug("had not connected\n");
+		return 0;
+	}
+
+	if (intelhaddata->drv_status != HAD_DRV_SUSPENDED) {
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		pr_err("had is not in suspended state\n");
+		return 0;
+	}
+
+	if (had_get_hwstate(intelhaddata)) {
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		pr_err("Failed to resume. Device not accessible\n");
+		return -ENODEV;
+	}
+
+	intelhaddata->drv_status = HAD_DRV_CONNECTED;
+	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
+			__func__, __LINE__);
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+	snd_intelhad_enable_audio_int(intelhaddata, true);
+	pr_debug("Exit:%s", __func__);
+	return 0;
+}
+
+static inline int had_chk_intrmiss(struct snd_intelhad *intelhaddata,
+		enum intel_had_aud_buf_type buf_id)
+{
+	int i, intr_count = 0;
+	enum intel_had_aud_buf_type buff_done;
+	u32 buf_size, buf_addr;
+	struct had_stream_data *had_stream;
+	unsigned long flag_irqs;
+
+	had_stream = &intelhaddata->stream_data;
+
+	buff_done = buf_id;
+
+	intr_count = snd_intelhad_read_len(intelhaddata);
+	if (intr_count > 1) {
+		/* In case of active playback */
+		pr_err("Driver detected %d missed buffer done interrupt(s)!!!!\n",
+				(intr_count - 1));
+		if (intr_count > 3)
+			return intr_count;
+
+		buf_id += (intr_count - 1);
+		/* Reprogram registers*/
+		for (i = buff_done; i < buf_id; i++) {
+			int j = i % 4;
+
+			buf_size = intelhaddata->buf_info[j].buf_size;
+			buf_addr = intelhaddata->buf_info[j].buf_addr;
+			had_write_register(intelhaddata,
+					   AUD_BUF_A_LENGTH +
+					   (j * HAD_REG_WIDTH), buf_size);
+			had_write_register(intelhaddata,
+					   AUD_BUF_A_ADDR+(j * HAD_REG_WIDTH),
+					   (buf_addr | BIT(0) | BIT(1)));
+		}
+		buf_id = buf_id % 4;
+		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+		intelhaddata->buff_done = buf_id;
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+	}
+
+	return intr_count;
+}
+
+static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
+{
+	u32 len = 1;
+	enum intel_had_aud_buf_type buf_id;
+	enum intel_had_aud_buf_type buff_done;
+	struct pcm_stream_info *stream;
+	u32 buf_size;
+	struct had_stream_data *had_stream;
+	int intr_count;
+	enum had_status_stream		stream_type;
+	unsigned long flag_irqs;
+
+	had_stream = &intelhaddata->stream_data;
+	stream = &intelhaddata->stream_info;
+	intr_count = 1;
+
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		pr_err("%s:Device already disconnected\n", __func__);
+		return 0;
+	}
+	buf_id = intelhaddata->curr_buf;
+	intelhaddata->buff_done = buf_id;
+	buff_done = intelhaddata->buff_done;
+	buf_size = intelhaddata->buf_info[buf_id].buf_size;
+	stream_type = had_stream->stream_type;
+
+	pr_debug("Enter:%s buf_id=%d\n", __func__, buf_id);
+
+	/* Every debug statement has an implication
+	 * of ~5msec. Thus, avoid having >3 debug statements
+	 * for each buffer_done handling.
+	 */
+
+	/* Check for any intr_miss in case of active playback */
+	if (had_stream->stream_type == HAD_RUNNING_STREAM) {
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		intr_count = had_chk_intrmiss(intelhaddata, buf_id);
+		if (!intr_count || (intr_count > 3)) {
+			pr_err("HAD SW state in non-recoverable!!! mode\n");
+			pr_err("Already played stale data\n");
+			return 0;
+		}
+		buf_id += (intr_count - 1);
+		buf_id = buf_id % 4;
+		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	}
+
+	intelhaddata->buf_info[buf_id].is_valid = true;
+	if (intelhaddata->valid_buf_cnt-1 == buf_id) {
+		if (had_stream->stream_type >= HAD_RUNNING_STREAM)
+			intelhaddata->curr_buf = HAD_BUF_TYPE_A;
+	} else
+		intelhaddata->curr_buf = buf_id + 1;
+
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+
+	if (had_get_hwstate(intelhaddata)) {
+		pr_err("HDMI cable plugged-out\n");
+		return 0;
+	}
+
+	/*Reprogram the registers with addr and length*/
+	had_write_register(intelhaddata,
+			   AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH),
+			   buf_size);
+	had_write_register(intelhaddata,
+			   AUD_BUF_A_ADDR + (buf_id * HAD_REG_WIDTH),
+			   intelhaddata->buf_info[buf_id].buf_addr |
+			   BIT(0) | BIT(1));
+
+	had_read_register(intelhaddata,
+			  AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH),
+			  &len);
+	pr_debug("%s:Enabled buf[%d]\n", __func__, buf_id);
+
+	/* In case of actual data,
+	 * report buffer_done to above ALSA layer
+	 */
+	buf_size =  intelhaddata->buf_info[buf_id].buf_size;
+	if (stream_type >= HAD_RUNNING_STREAM) {
+		intelhaddata->stream_info.buffer_rendered +=
+			(intr_count * buf_size);
+		stream->period_elapsed(stream->had_substream);
+	}
+
+	return 0;
+}
+
+static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
+{
+	enum intel_had_aud_buf_type buf_id;
+	struct pcm_stream_info *stream;
+	struct had_stream_data *had_stream;
+	enum had_status_stream stream_type;
+	unsigned long flag_irqs;
+	int drv_status;
+
+	had_stream = &intelhaddata->stream_data;
+	stream = &intelhaddata->stream_info;
+
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	buf_id = intelhaddata->curr_buf;
+	stream_type = had_stream->stream_type;
+	intelhaddata->buff_done = buf_id;
+	drv_status = intelhaddata->drv_status;
+	if (stream_type == HAD_RUNNING_STREAM)
+		intelhaddata->curr_buf = HAD_BUF_TYPE_A;
+
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+
+	pr_debug("Enter:%s buf_id=%d, stream_type=%d\n",
+			__func__, buf_id, stream_type);
+
+	snd_intelhad_handle_underrun(intelhaddata);
+
+	if (drv_status == HAD_DRV_DISCONNECTED) {
+		pr_err("%s:Device already disconnected\n", __func__);
+		return 0;
+	}
+
+	if (stream_type == HAD_RUNNING_STREAM) {
+		/* Report UNDERRUN error to above layers */
+		intelhaddata->flag_underrun = 1;
+		stream->period_elapsed(stream->had_substream);
+	}
+
+	return 0;
+}
+
+static int had_process_hot_plug(struct snd_intelhad *intelhaddata)
+{
+	enum intel_had_aud_buf_type buf_id;
+	struct snd_pcm_substream *substream;
+	struct had_stream_data *had_stream;
+	unsigned long flag_irqs;
+
+	pr_debug("Enter:%s\n", __func__);
+
+	substream = intelhaddata->stream_info.had_substream;
+	had_stream = &intelhaddata->stream_data;
+
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	if (intelhaddata->drv_status == HAD_DRV_CONNECTED) {
+		pr_debug("Device already connected\n");
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		return 0;
+	}
+	buf_id = intelhaddata->curr_buf;
+	intelhaddata->buff_done = buf_id;
+	intelhaddata->drv_status = HAD_DRV_CONNECTED;
+	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_CONNECTED\n",
+			__func__, __LINE__);
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+
+	pr_debug("Processing HOT_PLUG, buf_id = %d\n", buf_id);
+
+	/* Safety check */
+	if (substream) {
+		pr_debug("There should not be active PB from ALSA\n");
+		pr_debug("Signifies, cable is plugged-in even before\n");
+		pr_debug("processing snd_pcm_disconnect\n");
+		/* Set runtime->state to hw_params done */
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
+	}
+
+	had_build_channel_allocation_map(intelhaddata);
+
+	return 0;
+}
+
+static int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
+{
+	enum intel_had_aud_buf_type buf_id;
+	struct had_stream_data *had_stream;
+	unsigned long flag_irqs;
+
+	pr_debug("Enter:%s\n", __func__);
+
+	had_stream = &intelhaddata->stream_data;
+	buf_id = intelhaddata->curr_buf;
+
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
+		pr_debug("Device already disconnected\n");
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		return 0;
+
+	} else {
+		/* Disable Audio */
+		snd_intelhad_enable_audio_int(intelhaddata, false);
+		snd_intelhad_enable_audio(intelhaddata, false);
+	}
+
+	intelhaddata->drv_status = HAD_DRV_DISCONNECTED;
+	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
+			__func__, __LINE__);
+
+	/* Report to above ALSA layer */
+	if (intelhaddata->stream_info.had_substream != NULL) {
+		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+		pr_debug("%s: unlock -> sending pcm_stop -> lock\n", __func__);
+		snd_pcm_stop(intelhaddata->stream_info.had_substream,
+				SNDRV_PCM_STATE_SETUP);
+		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
+	}
+
+	had_stream->stream_type = HAD_INIT;
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
+	kfree(intelhaddata->chmap->chmap);
+	intelhaddata->chmap->chmap = NULL;
+	intelhaddata->audio_reg_base = NULL;
+	pr_debug("%s: unlocked -> returned\n", __func__);
+
+	return 0;
+}
+
+/* PCM operations structure and the calls back for the same */
+static struct snd_pcm_ops snd_intelhad_playback_ops = {
 	.open =		snd_intelhad_open,
 	.close =	snd_intelhad_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1472,7 +1829,7 @@ struct snd_pcm_ops snd_intelhad_playback_ops = {
 	.mmap =	snd_intelhad_pcm_mmap,
 };
 
-/**
+/*
  * snd_intelhad_pcm_free - to free the memory allocated
  *
  * @pcm: pointer to pcm instance
@@ -1505,6 +1862,7 @@ static int had_iec958_get(struct snd_kcontrol *kcontrol,
 					(intelhaddata->aes_bits >> 24) & 0xff;
 	return 0;
 }
+
 static int had_iec958_mask_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
@@ -1514,6 +1872,7 @@ static int had_iec958_mask_get(struct snd_kcontrol *kcontrol,
 	ucontrol->value.iec958.status[3] = 0xff;
 	return 0;
 }
+
 static int had_iec958_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 6efa846f98c9..d301c3021375 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -154,35 +154,4 @@ struct snd_intelhad {
 	struct work_struct hdmi_audio_wq;
 };
 
-int hdmi_lpe_audio_suspend(struct platform_device *pdev, pm_message_t state);
-int hdmi_lpe_audio_resume(struct platform_device *pdev);
-extern struct snd_pcm_ops snd_intelhad_playback_ops;
-
-int had_process_buffer_done(struct snd_intelhad *intelhaddata);
-int had_process_buffer_underrun(struct snd_intelhad *intelhaddata);
-int had_process_hot_plug(struct snd_intelhad *intelhaddata);
-int had_process_hot_unplug(struct snd_intelhad *intelhaddata);
-
-int snd_intelhad_init_audio_ctrl(struct snd_pcm_substream *substream,
-					struct snd_intelhad *intelhaddata,
-					int flag_silence);
-int snd_intelhad_prog_buffer(struct snd_intelhad *intelhaddata,
-					int start, int end);
-int snd_intelhad_invd_buffer(int start, int end);
-int snd_intelhad_read_len(struct snd_intelhad *intelhaddata);
-void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata);
-
-void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable);
-void snd_intelhad_enable_audio(struct snd_intelhad *ctx, bool enable);
-void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata);
-
-/* Register access functions */
-int had_get_hwstate(struct snd_intelhad *intelhaddata);
-int had_read_register(struct snd_intelhad *intelhaddata,
-		      u32 reg_addr, u32 *data);
-int had_write_register(struct snd_intelhad *intelhaddata,
-		       u32 reg_addr, u32 data);
-int had_read_modify(struct snd_intelhad *intelhaddata,
-		    u32 reg_addr, u32 data, u32 mask);
-
 #endif /* _INTEL_HDMI_AUDIO_ */
diff --git a/sound/x86/intel_hdmi_audio_if.c b/sound/x86/intel_hdmi_audio_if.c
deleted file mode 100644
index 327650dd1723..000000000000
--- a/sound/x86/intel_hdmi_audio_if.c
+++ /dev/null
@@ -1,390 +0,0 @@
-/*
- *   intel_hdmi_audio_if.c - Intel HDMI audio driver for MID
- *
- *  Copyright (C) 2016 Intel Corp
- *  Authors:	Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
- *		Ramesh Babu K V <ramesh.babu@intel.com>
- *		Vaibhav Agarwal <vaibhav.agarwal@intel.com>
- *		Jerome Anand <jerome.anand@intel.com>
- *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- * ALSA driver for Intel MID HDMI audio controller.  This file contains
- * interface functions exposed to HDMI Display driver and code to register
- * with ALSA framework..
- */
-
-#define pr_fmt(fmt)		"had: " fmt
-
-#include <linux/io.h>
-#include <linux/jiffies.h>
-#include <linux/slab.h>
-#include <sound/pcm.h>
-#include <sound/core.h>
-#include "intel_hdmi_audio.h"
-#include "intel_hdmi_lpe_audio.h"
-
-/*
- * hdmi_lpe_audio_suspend - power management suspend function
- *
- * @pdev: platform device
- *
- * This function is called by client driver to suspend the
- * hdmi audio.
- */
-int hdmi_lpe_audio_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct had_stream_data *had_stream;
-	unsigned long flag_irqs;
-	struct snd_pcm_substream *substream;
-	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
-
-	pr_debug("Enter:%s\n", __func__);
-
-	had_stream = &intelhaddata->stream_data;
-	substream = intelhaddata->stream_info.had_substream;
-
-	if (intelhaddata->dev->power.runtime_status != RPM_SUSPENDED) {
-		pr_err("audio stream is active\n");
-		return -EAGAIN;
-	}
-
-
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		pr_debug("had not connected\n");
-		return 0;
-	}
-
-	if (intelhaddata->drv_status == HAD_DRV_SUSPENDED) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		pr_debug("had already suspended\n");
-		return 0;
-	}
-
-	intelhaddata->drv_status = HAD_DRV_SUSPENDED;
-	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_SUSPENDED\n",
-			__func__, __LINE__);
-
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-	snd_intelhad_enable_audio_int(intelhaddata, false);
-	pr_debug("Exit:%s", __func__);
-	return 0;
-}
-
-/*
- * hdmi_lpe_audio_resume - power management resume function
- *
- *@pdev: platform device
- *
- * This function is called by client driver to resume the
- * hdmi audio.
- */
-int hdmi_lpe_audio_resume(struct platform_device *pdev)
-{
-	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
-	unsigned long flag_irqs;
-
-	pr_debug("Enter:%s\n", __func__);
-
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		pr_debug("had not connected\n");
-		return 0;
-	}
-
-	if (intelhaddata->drv_status != HAD_DRV_SUSPENDED) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		pr_err("had is not in suspended state\n");
-		return 0;
-	}
-
-	if (had_get_hwstate(intelhaddata)) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		pr_err("Failed to resume. Device not accessible\n");
-		return -ENODEV;
-	}
-
-	intelhaddata->drv_status = HAD_DRV_CONNECTED;
-	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
-			__func__, __LINE__);
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-	snd_intelhad_enable_audio_int(intelhaddata, true);
-	pr_debug("Exit:%s", __func__);
-	return 0;
-}
-
-static inline int had_chk_intrmiss(struct snd_intelhad *intelhaddata,
-		enum intel_had_aud_buf_type buf_id)
-{
-	int i, intr_count = 0;
-	enum intel_had_aud_buf_type buff_done;
-	u32 buf_size, buf_addr;
-	struct had_stream_data *had_stream;
-	unsigned long flag_irqs;
-
-	had_stream = &intelhaddata->stream_data;
-
-	buff_done = buf_id;
-
-	intr_count = snd_intelhad_read_len(intelhaddata);
-	if (intr_count > 1) {
-		/* In case of active playback */
-		pr_err("Driver detected %d missed buffer done interrupt(s)!!!!\n",
-				(intr_count - 1));
-		if (intr_count > 3)
-			return intr_count;
-
-		buf_id += (intr_count - 1);
-		/* Reprogram registers*/
-		for (i = buff_done; i < buf_id; i++) {
-			int j = i % 4;
-
-			buf_size = intelhaddata->buf_info[j].buf_size;
-			buf_addr = intelhaddata->buf_info[j].buf_addr;
-			had_write_register(intelhaddata,
-					   AUD_BUF_A_LENGTH +
-					   (j * HAD_REG_WIDTH), buf_size);
-			had_write_register(intelhaddata,
-					   AUD_BUF_A_ADDR+(j * HAD_REG_WIDTH),
-					   (buf_addr | BIT(0) | BIT(1)));
-		}
-		buf_id = buf_id % 4;
-		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-		intelhaddata->buff_done = buf_id;
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-	}
-
-	return intr_count;
-}
-
-int had_process_buffer_done(struct snd_intelhad *intelhaddata)
-{
-	u32 len = 1;
-	enum intel_had_aud_buf_type buf_id;
-	enum intel_had_aud_buf_type buff_done;
-	struct pcm_stream_info *stream;
-	u32 buf_size;
-	struct had_stream_data *had_stream;
-	int intr_count;
-	enum had_status_stream		stream_type;
-	unsigned long flag_irqs;
-
-	had_stream = &intelhaddata->stream_data;
-	stream = &intelhaddata->stream_info;
-	intr_count = 1;
-
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		pr_err("%s:Device already disconnected\n", __func__);
-		return 0;
-	}
-	buf_id = intelhaddata->curr_buf;
-	intelhaddata->buff_done = buf_id;
-	buff_done = intelhaddata->buff_done;
-	buf_size = intelhaddata->buf_info[buf_id].buf_size;
-	stream_type = had_stream->stream_type;
-
-	pr_debug("Enter:%s buf_id=%d\n", __func__, buf_id);
-
-	/* Every debug statement has an implication
-	 * of ~5msec. Thus, avoid having >3 debug statements
-	 * for each buffer_done handling.
-	 */
-
-	/* Check for any intr_miss in case of active playback */
-	if (had_stream->stream_type == HAD_RUNNING_STREAM) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		intr_count = had_chk_intrmiss(intelhaddata, buf_id);
-		if (!intr_count || (intr_count > 3)) {
-			pr_err("HAD SW state in non-recoverable!!! mode\n");
-			pr_err("Already played stale data\n");
-			return 0;
-		}
-		buf_id += (intr_count - 1);
-		buf_id = buf_id % 4;
-		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-	}
-
-	intelhaddata->buf_info[buf_id].is_valid = true;
-	if (intelhaddata->valid_buf_cnt-1 == buf_id) {
-		if (had_stream->stream_type >= HAD_RUNNING_STREAM)
-			intelhaddata->curr_buf = HAD_BUF_TYPE_A;
-	} else
-		intelhaddata->curr_buf = buf_id + 1;
-
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-
-	if (had_get_hwstate(intelhaddata)) {
-		pr_err("HDMI cable plugged-out\n");
-		return 0;
-	}
-
-	/*Reprogram the registers with addr and length*/
-	had_write_register(intelhaddata,
-			   AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH),
-			   buf_size);
-	had_write_register(intelhaddata,
-			   AUD_BUF_A_ADDR + (buf_id * HAD_REG_WIDTH),
-			   intelhaddata->buf_info[buf_id].buf_addr |
-			   BIT(0) | BIT(1));
-
-	had_read_register(intelhaddata,
-			  AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH),
-			  &len);
-	pr_debug("%s:Enabled buf[%d]\n", __func__, buf_id);
-
-	/* In case of actual data,
-	 * report buffer_done to above ALSA layer
-	 */
-	buf_size =  intelhaddata->buf_info[buf_id].buf_size;
-	if (stream_type >= HAD_RUNNING_STREAM) {
-		intelhaddata->stream_info.buffer_rendered +=
-			(intr_count * buf_size);
-		stream->period_elapsed(stream->had_substream);
-	}
-
-	return 0;
-}
-
-int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
-{
-	enum intel_had_aud_buf_type buf_id;
-	struct pcm_stream_info *stream;
-	struct had_stream_data *had_stream;
-	enum had_status_stream stream_type;
-	unsigned long flag_irqs;
-	int drv_status;
-
-	had_stream = &intelhaddata->stream_data;
-	stream = &intelhaddata->stream_info;
-
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-	buf_id = intelhaddata->curr_buf;
-	stream_type = had_stream->stream_type;
-	intelhaddata->buff_done = buf_id;
-	drv_status = intelhaddata->drv_status;
-	if (stream_type == HAD_RUNNING_STREAM)
-		intelhaddata->curr_buf = HAD_BUF_TYPE_A;
-
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-
-	pr_debug("Enter:%s buf_id=%d, stream_type=%d\n",
-			__func__, buf_id, stream_type);
-
-	snd_intelhad_handle_underrun(intelhaddata);
-
-	if (drv_status == HAD_DRV_DISCONNECTED) {
-		pr_err("%s:Device already disconnected\n", __func__);
-		return 0;
-	}
-
-	if (stream_type == HAD_RUNNING_STREAM) {
-		/* Report UNDERRUN error to above layers */
-		intelhaddata->flag_underrun = 1;
-		stream->period_elapsed(stream->had_substream);
-	}
-
-	return 0;
-}
-
-int had_process_hot_plug(struct snd_intelhad *intelhaddata)
-{
-	enum intel_had_aud_buf_type buf_id;
-	struct snd_pcm_substream *substream;
-	struct had_stream_data *had_stream;
-	unsigned long flag_irqs;
-
-	pr_debug("Enter:%s\n", __func__);
-
-	substream = intelhaddata->stream_info.had_substream;
-	had_stream = &intelhaddata->stream_data;
-
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-	if (intelhaddata->drv_status == HAD_DRV_CONNECTED) {
-		pr_debug("Device already connected\n");
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		return 0;
-	}
-	buf_id = intelhaddata->curr_buf;
-	intelhaddata->buff_done = buf_id;
-	intelhaddata->drv_status = HAD_DRV_CONNECTED;
-	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_CONNECTED\n",
-			__func__, __LINE__);
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-
-	pr_debug("Processing HOT_PLUG, buf_id = %d\n", buf_id);
-
-	/* Safety check */
-	if (substream) {
-		pr_debug("There should not be active PB from ALSA\n");
-		pr_debug("Signifies, cable is plugged-in even before\n");
-		pr_debug("processing snd_pcm_disconnect\n");
-		/* Set runtime->state to hw_params done */
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
-	}
-
-	had_build_channel_allocation_map(intelhaddata);
-
-	return 0;
-}
-
-int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
-{
-	enum intel_had_aud_buf_type buf_id;
-	struct had_stream_data *had_stream;
-	unsigned long flag_irqs;
-
-	pr_debug("Enter:%s\n", __func__);
-
-	had_stream = &intelhaddata->stream_data;
-	buf_id = intelhaddata->curr_buf;
-
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
-		pr_debug("Device already disconnected\n");
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		return 0;
-
-	} else {
-		/* Disable Audio */
-		snd_intelhad_enable_audio_int(intelhaddata, false);
-		snd_intelhad_enable_audio(intelhaddata, false);
-	}
-
-	intelhaddata->drv_status = HAD_DRV_DISCONNECTED;
-	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
-			__func__, __LINE__);
-
-	/* Report to above ALSA layer */
-	if (intelhaddata->stream_info.had_substream != NULL) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		pr_debug("%s: unlock -> sending pcm_stop -> lock\n", __func__);
-		snd_pcm_stop(intelhaddata->stream_info.had_substream,
-				SNDRV_PCM_STATE_SETUP);
-		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-	}
-
-	had_stream->stream_type = HAD_INIT;
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-	kfree(intelhaddata->chmap->chmap);
-	intelhaddata->chmap->chmap = NULL;
-	intelhaddata->audio_reg_base = NULL;
-	pr_debug("%s: unlocked -> returned\n", __func__);
-
-	return 0;
-}
-
-- 
2.11.0
