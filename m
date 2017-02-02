From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 43/53] ALSA: x86: Properly manage PCM substream
	lifetype
Date: Thu,  2 Feb 2017 18:02:57 +0100
Message-ID: <20170202170307.24484-45-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FD8F2675A7
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

The PCM substream is referred not only in the PCM callbacks but also
in the irq handler and in the hotplug/unplug codes.  The latter code
paths don't take the PCM lock, thus the PCM may be released
unexpectedly while calling PCM helper functions or accessing
pcm->runtime fields.

This patch implements a simple refcount to assure the PCM substream
accessibility while the other codes are accessing.  It needed some
code refactoring in the relevant functions for avoiding the doubly
spinlocks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 169 ++++++++++++++++++++++++-------------------
 sound/x86/intel_hdmi_audio.h |   3 +-
 2 files changed, 98 insertions(+), 74 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 907e420cd90d..c209d9498c0e 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -154,6 +154,36 @@ static const struct snd_pcm_hardware snd_intel_hadstream = {
 	.fifo_size = HAD_FIFO_SIZE,
 };
 
+/* Get the active PCM substream;
+ * Call had_substream_put() for unreferecing.
+ * Don't call this inside had_spinlock, as it takes by itself
+ */
+static struct snd_pcm_substream *
+had_substream_get(struct snd_intelhad *intelhaddata)
+{
+	struct snd_pcm_substream *substream;
+	unsigned long flags;
+
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
+	substream = intelhaddata->stream_info.substream;
+	if (substream)
+		intelhaddata->stream_info.substream_refcount++;
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
+	return substream;
+}
+
+/* Unref the active PCM substream;
+ * Don't call this inside had_spinlock, as it takes by itself
+ */
+static void had_substream_put(struct snd_intelhad *intelhaddata)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
+	intelhaddata->stream_info.substream_refcount--;
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
+}
+
 /* Register access functions */
 static inline void
 mid_hdmi_audio_read(struct snd_intelhad *ctx, u32 reg, u32 *val)
@@ -215,7 +245,8 @@ static int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
 }
 
 /*
- * function to read-modify AUD_CONFIG register on VLV2.
+ * enable / disable audio configuration
+ *
  * The had_read_modify() function should not directly be used on VLV2 for
  * updating AUD_CONFIG register.
  * This is because:
@@ -227,39 +258,33 @@ static int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
  * causes the "channels" field to be updated as 0xy binary resulting in
  * bad audio. The fix is to always write the AUD_CONFIG[6:4] with
  * appropriate value when doing read-modify of AUD_CONFIG register.
- *
- * @substream: the current substream or NULL if no active substream
- * @data : data to be written
- * @mask : mask
- *
  */
-static int had_read_modify_aud_config_v2(struct snd_intelhad *intelhaddata,
-					u32 data, u32 mask)
+static void snd_intelhad_enable_audio(struct snd_pcm_substream *substream,
+				      struct snd_intelhad *intelhaddata,
+				      bool enable)
 {
-	struct snd_pcm_substream *substream;
 	union aud_cfg cfg_val = {.cfg_regval = 0};
-	u8 channels;
+	u8 channels, data, mask;
 
 	/*
 	 * If substream is NULL, there is no active stream.
 	 * In this case just set channels to 2
 	 */
-	substream = intelhaddata->stream_info.had_substream;
-	if (substream && substream->runtime)
-		channels = substream->runtime->channels;
-	else
-		channels = 2;
+	channels = substream ? substream->runtime->channels : 2;
 	cfg_val.cfg_regx.num_ch = channels - 2;
 
-	data = data | cfg_val.cfg_regval;
-	mask = mask | AUD_CONFIG_CH_MASK;
+	data = cfg_val.cfg_regval;
+	if (enable)
+		data |= 1;
+	mask = AUD_CONFIG_CH_MASK | 1;
 
 	dev_dbg(intelhaddata->dev, "%s : data = %x, mask =%x\n",
 		__func__, data, mask);
 
-	return had_read_modify(intelhaddata, AUD_CONFIG, data, mask);
+	had_read_modify(intelhaddata, AUD_CONFIG, data, mask);
 }
 
+/* enable / disable the audio interface */
 static void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable)
 {
 	u32 status_reg;
@@ -272,13 +297,6 @@ static void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable)
 	}
 }
 
-static void snd_intelhad_enable_audio(struct snd_intelhad *intelhaddata,
-				      bool enable)
-{
-	had_read_modify_aud_config_v2(intelhaddata, enable ? BIT(0) : 0,
-				      BIT(0));
-}
-
 static void snd_intelhad_reset_audio(struct snd_intelhad *intelhaddata,
 				     u8 reset)
 {
@@ -647,21 +665,17 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 
 /*
  * snd_intelhad_prog_buffer - programs buffer address and length registers
- * @substream:substream for which the prepare function is called
- * @intelhaddata:substream private data
+ * @substream: substream for which the prepare function is called
+ * @intelhaddata: substream private data
  *
  * This function programs ring buffer address and length into registers.
  */
-static int snd_intelhad_prog_buffer(struct snd_intelhad *intelhaddata,
-					int start, int end)
+static int snd_intelhad_prog_buffer(struct snd_pcm_substream *substream,
+				    struct snd_intelhad *intelhaddata,
+				    int start, int end)
 {
 	u32 ring_buf_addr, ring_buf_size, period_bytes;
 	u8 i, num_periods;
-	struct snd_pcm_substream *substream;
-
-	substream = intelhaddata->stream_info.had_substream;
-	if (WARN_ON(!substream))
-		return 0;
 
 	ring_buf_addr = substream->runtime->dma_addr;
 	ring_buf_size = snd_pcm_lib_buffer_bytes(substream);
@@ -989,6 +1003,11 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 		goto error;
 	}
 
+	spin_lock_irq(&intelhaddata->had_spinlock);
+	intelhaddata->stream_info.substream = substream;
+	intelhaddata->stream_info.substream_refcount++;
+	spin_unlock_irq(&intelhaddata->had_spinlock);
+
 	return retval;
  error:
 	pm_runtime_put(intelhaddata->dev);
@@ -996,17 +1015,6 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 }
 
 /*
- * had_period_elapsed - updates the hardware pointer status
- * @had_substream: substream for which the stream function is called
- */
-static void had_period_elapsed(struct snd_pcm_substream *substream)
-{
-	if (!substream || !substream->runtime)
-		return;
-	snd_pcm_period_elapsed(substream);
-}
-
-/*
  * snd_intelhad_close - to free parameteres when stream is stopped
  * @substream:  substream for which the function is called
  *
@@ -1019,7 +1027,15 @@ static int snd_intelhad_close(struct snd_pcm_substream *substream)
 	intelhaddata = snd_pcm_substream_chip(substream);
 
 	intelhaddata->stream_info.buffer_rendered = 0;
-	intelhaddata->stream_info.had_substream = NULL;
+	spin_lock_irq(&intelhaddata->had_spinlock);
+	intelhaddata->stream_info.substream = NULL;
+	intelhaddata->stream_info.substream_refcount--;
+	while (intelhaddata->stream_info.substream_refcount > 0) {
+		spin_unlock_irq(&intelhaddata->had_spinlock);
+		cpu_relax();
+		spin_lock_irq(&intelhaddata->had_spinlock);
+	}
+	spin_unlock_irq(&intelhaddata->had_spinlock);
 
 	/* Check if following drv_status modification is required - VA */
 	if (intelhaddata->drv_status != HAD_DRV_DISCONNECTED) {
@@ -1125,7 +1141,7 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 
 		/* Enable Audio */
 		snd_intelhad_enable_audio_int(intelhaddata, true);
-		snd_intelhad_enable_audio(intelhaddata, true);
+		snd_intelhad_enable_audio(substream, intelhaddata, true);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -1138,7 +1154,7 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		spin_unlock(&intelhaddata->had_spinlock);
 		/* Disable Audio */
 		snd_intelhad_enable_audio_int(intelhaddata, false);
-		snd_intelhad_enable_audio(intelhaddata, false);
+		snd_intelhad_enable_audio(substream, intelhaddata, false);
 		/* Reset buffer pointers */
 		snd_intelhad_reset_audio(intelhaddata, 1);
 		snd_intelhad_reset_audio(intelhaddata, 0);
@@ -1185,7 +1201,6 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	dev_dbg(intelhaddata->dev, "rate=%d\n", runtime->rate);
 	dev_dbg(intelhaddata->dev, "channels=%d\n", runtime->channels);
 
-	intelhaddata->stream_info.had_substream = substream;
 	intelhaddata->stream_info.buffer_rendered = 0;
 
 	/* Get N value in KHz */
@@ -1211,7 +1226,7 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	retval = snd_intelhad_audio_ctrl(substream, intelhaddata);
 
 	/* Prog buffer address */
-	retval = snd_intelhad_prog_buffer(intelhaddata,
+	retval = snd_intelhad_prog_buffer(substream, intelhaddata,
 			HAD_BUF_TYPE_A, HAD_BUF_TYPE_D);
 
 	/*
@@ -1306,12 +1321,12 @@ static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 	u32 disp_samp_freq, n_param;
 	u32 link_rate = 0;
 
-	substream = intelhaddata->stream_info.had_substream;
-	if (!substream || !substream->runtime)
+	substream = had_substream_get(intelhaddata);
+	if (!substream)
 		return 0;
 
 	/* Disable Audio */
-	snd_intelhad_enable_audio(intelhaddata, false);
+	snd_intelhad_enable_audio(substream, intelhaddata, false);
 
 	/* Update CTS value */
 	disp_samp_freq = intelhaddata->tmds_clock_speed;
@@ -1332,9 +1347,10 @@ static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 			      n_param, intelhaddata);
 
 	/* Enable Audio */
-	snd_intelhad_enable_audio(intelhaddata, true);
+	snd_intelhad_enable_audio(substream, intelhaddata, true);
 
 out:
+	had_substream_put(intelhaddata);
 	return retval;
 }
 
@@ -1348,11 +1364,9 @@ static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 				  pm_message_t state)
 {
 	struct had_stream_data *had_stream;
-	struct snd_pcm_substream *substream;
 	struct snd_intelhad *intelhaddata = platform_get_drvdata(pdev);
 
 	had_stream = &intelhaddata->stream_data;
-	substream = intelhaddata->stream_info.had_substream;
 
 	if (!pm_runtime_status_suspended(intelhaddata->dev)) {
 		dev_err(intelhaddata->dev, "audio stream is active\n");
@@ -1463,10 +1477,10 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	enum intel_had_aud_buf_type buf_id;
 	enum intel_had_aud_buf_type buff_done;
 	struct pcm_stream_info *stream;
+	struct snd_pcm_substream *substream;
 	u32 buf_size;
 	struct had_stream_data *had_stream;
 	int intr_count;
-	enum had_status_stream		stream_type;
 	unsigned long flags;
 
 	had_stream = &intelhaddata->stream_data;
@@ -1484,7 +1498,6 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	intelhaddata->buff_done = buf_id;
 	buff_done = intelhaddata->buff_done;
 	buf_size = intelhaddata->buf_info[buf_id].buf_size;
-	stream_type = had_stream->stream_type;
 
 	/* Every debug statement has an implication
 	 * of ~5msec. Thus, avoid having >3 debug statements
@@ -1536,11 +1549,13 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	/* In case of actual data,
 	 * report buffer_done to above ALSA layer
 	 */
-	buf_size = intelhaddata->buf_info[buf_id].buf_size;
-	if (stream_type >= HAD_RUNNING_STREAM) {
+	substream = had_substream_get(intelhaddata);
+	if (substream) {
+		buf_size = intelhaddata->buf_info[buf_id].buf_size;
 		intelhaddata->stream_info.buffer_rendered +=
 			(intr_count * buf_size);
-		had_period_elapsed(stream->had_substream);
+		snd_pcm_period_elapsed(substream);
+		had_substream_put(intelhaddata);
 	}
 
 	return 0;
@@ -1552,6 +1567,7 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 	enum intel_had_aud_buf_type buf_id;
 	struct pcm_stream_info *stream;
 	struct had_stream_data *had_stream;
+	struct snd_pcm_substream *substream;
 	enum had_status_stream stream_type;
 	unsigned long flags;
 	int drv_status;
@@ -1582,7 +1598,11 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 
 	if (stream_type == HAD_RUNNING_STREAM) {
 		/* Report UNDERRUN error to above layers */
-		snd_pcm_stop_xrun(stream->had_substream);
+		substream = had_substream_get(intelhaddata);
+		if (substream) {
+			snd_pcm_stop_xrun(substream);
+			had_substream_put(intelhaddata);
+		}
 	}
 
 	return 0;
@@ -1595,7 +1615,6 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 	struct snd_pcm_substream *substream;
 	struct had_stream_data *had_stream;
 
-	substream = intelhaddata->stream_info.had_substream;
 	had_stream = &intelhaddata->stream_data;
 
 	spin_lock_irq(&intelhaddata->had_spinlock);
@@ -1617,11 +1636,13 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 		buf_id);
 
 	/* Safety check */
+	substream = had_substream_get(intelhaddata);
 	if (substream) {
 		dev_dbg(intelhaddata->dev,
 			"Force to stop the active stream by disconnection\n");
 		/* Set runtime->state to hw_params done */
 		snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
+		had_substream_put(intelhaddata);
 	}
 
 	had_build_channel_allocation_map(intelhaddata);
@@ -1632,38 +1653,40 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
 	struct had_stream_data *had_stream;
+	struct snd_pcm_substream *substream;
 
 	had_stream = &intelhaddata->stream_data;
 	buf_id = intelhaddata->curr_buf;
 
+	substream = had_substream_get(intelhaddata);
+
 	spin_lock_irq(&intelhaddata->had_spinlock);
 
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		dev_dbg(intelhaddata->dev, "Device already disconnected\n");
 		spin_unlock_irq(&intelhaddata->had_spinlock);
-		return;
+		goto out;
 
 	}
 
 	/* Disable Audio */
 	snd_intelhad_enable_audio_int(intelhaddata, false);
-	snd_intelhad_enable_audio(intelhaddata, false);
+	snd_intelhad_enable_audio(substream, intelhaddata, false);
 
 	intelhaddata->drv_status = HAD_DRV_DISCONNECTED;
 	dev_dbg(intelhaddata->dev,
 		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
 			__func__, __LINE__);
+	had_stream->stream_type = HAD_INIT;
+	spin_unlock_irq(&intelhaddata->had_spinlock);
 
 	/* Report to above ALSA layer */
-	if (intelhaddata->stream_info.had_substream != NULL) {
-		spin_unlock_irq(&intelhaddata->had_spinlock);
-		snd_pcm_stop(intelhaddata->stream_info.had_substream,
-				SNDRV_PCM_STATE_SETUP);
-		spin_lock_irq(&intelhaddata->had_spinlock);
-	}
+	if (substream)
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
 
-	had_stream->stream_type = HAD_INIT;
-	spin_unlock_irq(&intelhaddata->had_spinlock);
+ out:
+	if (substream)
+		had_substream_put(intelhaddata);
 	kfree(intelhaddata->chmap->chmap);
 	intelhaddata->chmap->chmap = NULL;
 }
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 7bd273ec3275..6e5a1978e9c7 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -72,9 +72,10 @@
 #define AUD_CONFIG_CH_MASK	0x70
 
 struct pcm_stream_info {
-	struct snd_pcm_substream	*had_substream;
+	struct snd_pcm_substream *substream;
 	u64		buffer_rendered;
 	u32		ring_buf_size;
+	int substream_refcount;
 };
 
 struct ring_buf_info {
-- 
2.11.0
