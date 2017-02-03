From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: x86: Refactor PCM process engine
Date: Fri,  3 Feb 2017 17:44:00 +0100
Message-ID: <20170203164400.12983-5-tiwai@suse.de>
References: <20170203164400.12983-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BB1A8266B57
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 17:44:03 +0100 (CET)
In-Reply-To: <20170203164400.12983-1-tiwai@suse.de>
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

This is again a big rewrite of the driver; now it touches the code to
process PCM stream transfers.

The most fundamental change is that now the driver supports more than
four periods.  Instead of keeping the same index between the ring
buffers (from A to D) and the PCM buffer periods, now we keep
difference indices for both.  Also, for the cases with less periods
than four, we track the head index, too.  That is, we now have four
indices: ringbuf_head, pcm_head, ringbuf_filled, and pcm_filled.

By this flexibility, we can use even dmix, which requires 16 periods
as default.

The buffer size could be up to 20bit, so it's set to that value.  But
the pre-allocation is limited to 128k as default.  It's because the
chip requires the continuous pages (unfortunately no-SG possible),
thus we don't want too much continuous pages.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 510 ++++++++++++++-------------------------
 sound/x86/intel_hdmi_audio.h     |  23 +-
 sound/x86/intel_hdmi_lpe_audio.h |  26 +-
 3 files changed, 204 insertions(+), 355 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index c503f0de3975..2c3dcdcb43f5 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -619,82 +619,6 @@ static void snd_intelhad_prog_dip(struct snd_pcm_substream *substream,
 	had_write_register(intelhaddata, AUD_CNTL_ST, ctrl_state.regval);
 }
 
-/*
- * Programs buffer address and length registers
- * This function programs ring buffer address and length into registers.
- */
-static int snd_intelhad_prog_buffer(struct snd_pcm_substream *substream,
-				    struct snd_intelhad *intelhaddata,
-				    int start, int end)
-{
-	u32 ring_buf_addr, ring_buf_size, period_bytes;
-	u8 i, num_periods;
-
-	ring_buf_addr = substream->runtime->dma_addr;
-	ring_buf_size = snd_pcm_lib_buffer_bytes(substream);
-	intelhaddata->stream_info.ring_buf_size = ring_buf_size;
-	period_bytes = frames_to_bytes(substream->runtime,
-				substream->runtime->period_size);
-	num_periods = substream->runtime->periods;
-
-	/*
-	 * buffer addr should  be 64 byte aligned, period bytes
-	 * will be used to calculate addr offset
-	 */
-	period_bytes &= ~0x3F;
-
-	/* Hardware supports MAX_PERIODS buffers */
-	if (end >= HAD_MAX_PERIODS)
-		return -EINVAL;
-
-	for (i = start; i <= end; i++) {
-		/* Program the buf registers with addr and len */
-		intelhaddata->buf_info[i].buf_addr = ring_buf_addr +
-							 (i * period_bytes);
-		if (i < num_periods-1)
-			intelhaddata->buf_info[i].buf_size = period_bytes;
-		else
-			intelhaddata->buf_info[i].buf_size = ring_buf_size -
-							(i * period_bytes);
-
-		had_write_register(intelhaddata,
-				   AUD_BUF_A_ADDR + (i * HAD_REG_WIDTH),
-					intelhaddata->buf_info[i].buf_addr |
-					BIT(0) | BIT(1));
-		had_write_register(intelhaddata,
-				   AUD_BUF_A_LENGTH + (i * HAD_REG_WIDTH),
-					period_bytes);
-		intelhaddata->buf_info[i].is_valid = true;
-	}
-	dev_dbg(intelhaddata->dev, "%s:buf[%d-%d] addr=%#x  and size=%d\n",
-		__func__, start, end,
-		intelhaddata->buf_info[start].buf_addr,
-		intelhaddata->buf_info[start].buf_size);
-	intelhaddata->valid_buf_cnt = num_periods;
-	return 0;
-}
-
-static int snd_intelhad_read_len(struct snd_intelhad *intelhaddata)
-{
-	int i, retval = 0;
-	u32 len[4];
-
-	for (i = 0; i < 4 ; i++) {
-		had_read_register(intelhaddata,
-				  AUD_BUF_A_LENGTH + (i * HAD_REG_WIDTH),
-				  &len[i]);
-		if (!len[i])
-			retval++;
-	}
-	if (retval != 1) {
-		for (i = 0; i < 4 ; i++)
-			dev_dbg(intelhaddata->dev, "buf[%d] size=%d\n",
-				i, len[i]);
-	}
-
-	return retval;
-}
-
 static int had_calculate_maud_value(u32 aud_samp_freq, u32 link_rate)
 {
 	u32 maud_val;
@@ -882,34 +806,192 @@ static int snd_intelhad_prog_n(u32 aud_samp_freq, u32 *n_param,
 	return 0;
 }
 
+/*
+ * PCM ring buffer handling
+ */
+
+#define AUD_BUF_ADDR(x)		(AUD_BUF_A_ADDR + (x) * HAD_REG_WIDTH)
+#define AUD_BUF_LEN(x)		(AUD_BUF_A_LENGTH + (x) * HAD_REG_WIDTH)
+
+/* Set up a ring buffer at the "filled" position */
+static void had_prog_ringbuf(struct snd_pcm_substream *substream,
+			     struct snd_intelhad *intelhaddata)
+{
+	int idx = intelhaddata->ringbuf_filled;
+	int ofs = intelhaddata->pcmbuf_filled * intelhaddata->period_bytes;
+	u32 addr = substream->runtime->dma_addr + ofs;
+
+	addr |= AUD_BUF_VALID | AUD_BUF_INTR_EN;
+	had_write_register(intelhaddata, AUD_BUF_ADDR(idx), addr);
+	had_write_register(intelhaddata, AUD_BUF_LEN(idx),
+			   intelhaddata->period_bytes);
+
+	/* advance the indices to the next */
+	intelhaddata->ringbuf_filled++;
+	intelhaddata->ringbuf_filled %= HAD_NUM_RINGBUFS;
+	intelhaddata->pcmbuf_filled++;
+	intelhaddata->pcmbuf_filled %= substream->runtime->periods;
+}
+
+/* invalidate a ring buffer with the given index */
+static void had_invalidate_ringbuf(struct snd_intelhad *intelhaddata,
+				   int idx)
+{
+	had_write_register(intelhaddata, AUD_BUF_ADDR(idx), 0);
+	had_write_register(intelhaddata, AUD_BUF_LEN(idx), 0);
+}
+
+/* Initial programming of ring buffers */
+static void had_init_ringbufs(struct snd_pcm_substream *substream,
+			      struct snd_intelhad *intelhaddata)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int i, period_bytes, num_periods;
+
+	num_periods = runtime->periods;
+	intelhaddata->period_bytes = period_bytes =
+		frames_to_bytes(runtime, runtime->period_size);
+	WARN_ON(period_bytes & 0x3f);
+
+	intelhaddata->ringbuf_head = 0;
+	intelhaddata->pcmbuf_head = 0;
+	intelhaddata->ringbuf_filled = 0;
+	intelhaddata->pcmbuf_filled = 0;
+
+	for (i = 0; i < HAD_NUM_RINGBUFS; i++) {
+		if (i < num_periods)
+			had_prog_ringbuf(substream, intelhaddata);
+		else /* invalidate the rest */
+			had_invalidate_ringbuf(intelhaddata, i);
+	}
+}
+
+/* process a ring buf, advance to the next */
+static void had_advance_ringbuf(struct snd_pcm_substream *substream,
+				struct snd_intelhad *intelhaddata)
+{
+	int num_periods = substream->runtime->periods;
+
+	/* reprogram the next buffer */
+	had_prog_ringbuf(substream, intelhaddata);
+
+	/* invalidate the processed buf for shorter PCM buffer */
+	if (num_periods < HAD_NUM_RINGBUFS)
+		had_invalidate_ringbuf(intelhaddata,
+				       intelhaddata->ringbuf_head);
+
+	/* proceed to next */
+	intelhaddata->ringbuf_head++;
+	intelhaddata->ringbuf_head %= HAD_NUM_RINGBUFS;
+	intelhaddata->pcmbuf_head++;
+	intelhaddata->pcmbuf_head %= num_periods;
+}
+
+/* process the current ring buffer(s);
+ * returns the current PCM buffer byte position, or -EPIPE for underrun.
+ */
+static int had_process_ringbufs(struct snd_pcm_substream *substream,
+				struct snd_intelhad *intelhaddata)
+{
+	int len, processed;
+	unsigned long flags;
+
+	processed = 0;
+	spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
+	for (;;) {
+		/* get the remaining bytes on the buffer */
+		had_read_register(intelhaddata,
+				  AUD_BUF_LEN(intelhaddata->ringbuf_head),
+				  &len);
+		if (len < 0 || len > intelhaddata->period_bytes) {
+			dev_dbg(intelhaddata->dev, "Invalid buf length %d\n",
+				len);
+			len = -EPIPE;
+			goto out;
+		}
+
+		if (len > 0) /* OK, this is the current buffer */
+			break;
+
+		/* len=0 => already empty, check the next buffer */
+		if (++processed >= HAD_NUM_RINGBUFS) {
+			len = -EPIPE; /* all empty? - report underrun */
+			goto out;
+		}
+		had_advance_ringbuf(substream, intelhaddata);
+	}
+
+	len = intelhaddata->period_bytes - len;
+	len += intelhaddata->period_bytes * intelhaddata->pcmbuf_head;
+ out:
+	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
+	return len;
+}
+
+/* called from irq handler */
+static void had_process_buffer_done(struct snd_intelhad *intelhaddata)
+{
+	struct snd_pcm_substream *substream;
+
+	if (!intelhaddata->connected)
+		return; /* disconnected? - bail out */
+
+	substream = had_substream_get(intelhaddata);
+	if (!substream)
+		return; /* no stream? - bail out */
+
+	/* process or stop the stream */
+	if (had_process_ringbufs(substream, intelhaddata) < 0)
+		snd_pcm_stop_xrun(substream);
+	else
+		snd_pcm_period_elapsed(substream);
+
+	had_substream_put(intelhaddata);
+}
+
 #define MAX_CNT			0xFF
 
-static void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
+/*
+ * The interrupt status 'sticky' bits might not be cleared by
+ * setting '1' to that bit once...
+ */
+static void wait_clear_underrun_bit(struct snd_intelhad *intelhaddata)
 {
-	u32 hdmi_status = 0, i = 0;
+	int i;
+	u32 val;
+
+	for (i = 0; i < MAX_CNT; i++) {
+		/* clear bit30, 31 AUD_HDMI_STATUS */
+		had_read_register(intelhaddata, AUD_HDMI_STATUS, &val);
+		if (!(val & AUD_CONFIG_MASK_UNDERRUN))
+			return;
+		had_write_register(intelhaddata, AUD_HDMI_STATUS, val);
+	}
+	dev_err(intelhaddata->dev, "Unable to clear UNDERRUN bits\n");
+}
+
+/* called from irq handler */
+static void had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
+{
+	struct snd_pcm_substream *substream;
 
 	/* Handle Underrun interrupt within Audio Unit */
 	had_write_register(intelhaddata, AUD_CONFIG, 0);
 	/* Reset buffer pointers */
 	had_write_register(intelhaddata, AUD_HDMI_STATUS, 1);
 	had_write_register(intelhaddata, AUD_HDMI_STATUS, 0);
-	/*
-	 * The interrupt status 'sticky' bits might not be cleared by
-	 * setting '1' to that bit once...
-	 */
-	do { /* clear bit30, 31 AUD_HDMI_STATUS */
-		had_read_register(intelhaddata, AUD_HDMI_STATUS,
-				  &hdmi_status);
-		dev_dbg(intelhaddata->dev, "HDMI status =0x%x\n", hdmi_status);
-		if (hdmi_status & AUD_CONFIG_MASK_UNDERRUN) {
-			i++;
-			had_write_register(intelhaddata,
-					   AUD_HDMI_STATUS, hdmi_status);
-		} else
-			break;
-	} while (i < MAX_CNT);
-	if (i >= MAX_CNT)
-		dev_err(intelhaddata->dev, "Unable to clear UNDERRUN bits\n");
+
+	wait_clear_underrun_bit(intelhaddata);
+
+	if (!intelhaddata->connected)
+		return; /* disconnected? - bail out */
+
+	/* Report UNDERRUN error to above layers */
+	substream = had_substream_get(intelhaddata);
+	if (substream) {
+		snd_pcm_stop_xrun(substream);
+		had_substream_put(intelhaddata);
+	}
 }
 
 /*
@@ -955,11 +1037,6 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 	intelhaddata->stream_info.substream_refcount++;
 	spin_unlock_irq(&intelhaddata->had_spinlock);
 
-	/* these are cleared in prepare callback, but just to be sure */
-	intelhaddata->curr_buf = 0;
-	intelhaddata->underrun_count = 0;
-	intelhaddata->stream_info.buffer_rendered = 0;
-
 	return retval;
  error:
 	pm_runtime_put(intelhaddata->dev);
@@ -1123,10 +1200,6 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	dev_dbg(intelhaddata->dev, "rate=%d\n", runtime->rate);
 	dev_dbg(intelhaddata->dev, "channels=%d\n", runtime->channels);
 
-	intelhaddata->curr_buf = 0;
-	intelhaddata->underrun_count = 0;
-	intelhaddata->stream_info.buffer_rendered = 0;
-
 	/* Get N value in KHz */
 	disp_samp_freq = intelhaddata->tmds_clock_speed;
 
@@ -1150,8 +1223,7 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	retval = snd_intelhad_audio_ctrl(substream, intelhaddata);
 
 	/* Prog buffer address */
-	retval = snd_intelhad_prog_buffer(substream, intelhaddata,
-			HAD_BUF_TYPE_A, HAD_BUF_TYPE_D);
+	had_init_ringbufs(substream, intelhaddata);
 
 	/*
 	 * Program channel mapping in following order:
@@ -1171,48 +1243,17 @@ static snd_pcm_uframes_t
 snd_intelhad_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_intelhad *intelhaddata;
-	u32 bytes_rendered = 0;
-	u32 t;
-	int buf_id;
+	int len;
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 
 	if (!intelhaddata->connected)
 		return SNDRV_PCM_POS_XRUN;
 
-	/* Use a hw register to calculate sub-period position reports.
-	 * This makes PulseAudio happier.
-	 */
-
-	buf_id = intelhaddata->curr_buf % 4;
-	had_read_register(intelhaddata,
-			  AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH), &t);
-
-	if ((t == 0) || (t == ((u32)-1L))) {
-		intelhaddata->underrun_count++;
-		dev_dbg(intelhaddata->dev,
-			"discovered buffer done for buf %d, count = %d\n",
-			 buf_id, intelhaddata->underrun_count);
-
-		if (intelhaddata->underrun_count > (HAD_MIN_PERIODS/2)) {
-			dev_dbg(intelhaddata->dev,
-				"assume audio_codec_reset, underrun = %d - do xrun\n",
-				 intelhaddata->underrun_count);
-			return SNDRV_PCM_POS_XRUN;
-		}
-	} else {
-		/* Reset Counter */
-		intelhaddata->underrun_count = 0;
-	}
-
-	t = intelhaddata->buf_info[buf_id].buf_size - t;
-
-	if (intelhaddata->stream_info.buffer_rendered)
-		div_u64_rem(intelhaddata->stream_info.buffer_rendered,
-			intelhaddata->stream_info.ring_buf_size,
-			&(bytes_rendered));
-
-	return bytes_to_frames(substream->runtime, bytes_rendered + t);
+	len = had_process_ringbufs(substream, intelhaddata);
+	if (len < 0)
+		return SNDRV_PCM_POS_XRUN;
+	return bytes_to_frames(substream->runtime, len);
 }
 
 /*
@@ -1283,179 +1324,9 @@ static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 	return retval;
 }
 
-static inline int had_chk_intrmiss(struct snd_intelhad *intelhaddata,
-		enum intel_had_aud_buf_type buf_id)
-{
-	int i, intr_count = 0;
-	enum intel_had_aud_buf_type buff_done;
-	u32 buf_size, buf_addr;
-
-	buff_done = buf_id;
-
-	intr_count = snd_intelhad_read_len(intelhaddata);
-	if (intr_count > 1) {
-		/* In case of active playback */
-		dev_err(intelhaddata->dev,
-			"Driver detected %d missed buffer done interrupt(s)\n",
-			(intr_count - 1));
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
-		intelhaddata->buff_done = buf_id;
-	}
-
-	return intr_count;
-}
-
-/* called from irq handler */
-static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
-{
-	u32 len = 1;
-	enum intel_had_aud_buf_type buf_id;
-	enum intel_had_aud_buf_type buff_done;
-	struct pcm_stream_info *stream;
-	struct snd_pcm_substream *substream;
-	u32 buf_size;
-	int intr_count;
-	unsigned long flags;
-
-	stream = &intelhaddata->stream_info;
-	intr_count = 1;
-
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
-	if (!intelhaddata->connected) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
-		dev_dbg(intelhaddata->dev,
-			"%s:Device already disconnected\n", __func__);
-		return 0;
-	}
-	buf_id = intelhaddata->curr_buf;
-	intelhaddata->buff_done = buf_id;
-	buff_done = intelhaddata->buff_done;
-	buf_size = intelhaddata->buf_info[buf_id].buf_size;
-
-	/* Every debug statement has an implication
-	 * of ~5msec. Thus, avoid having >3 debug statements
-	 * for each buffer_done handling.
-	 */
-
-	/* Check for any intr_miss in case of active playback */
-	if (stream->running) {
-		intr_count = had_chk_intrmiss(intelhaddata, buf_id);
-		if (!intr_count || (intr_count > 3)) {
-			spin_unlock_irqrestore(&intelhaddata->had_spinlock,
-					       flags);
-			dev_err(intelhaddata->dev,
-				"HAD SW state in non-recoverable mode\n");
-			return 0;
-		}
-		buf_id += (intr_count - 1);
-		buf_id = buf_id % 4;
-	}
-
-	intelhaddata->buf_info[buf_id].is_valid = true;
-	if (intelhaddata->valid_buf_cnt-1 == buf_id) {
-		if (stream->running)
-			intelhaddata->curr_buf = HAD_BUF_TYPE_A;
-	} else
-		intelhaddata->curr_buf = buf_id + 1;
-
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
-
-	if (!intelhaddata->connected) {
-		dev_dbg(intelhaddata->dev, "HDMI cable plugged-out\n");
-		return 0;
-	}
-
-	/* Reprogram the registers with addr and length */
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
-	dev_dbg(intelhaddata->dev, "%s:Enabled buf[%d]\n", __func__, buf_id);
-
-	/* In case of actual data,
-	 * report buffer_done to above ALSA layer
-	 */
-	substream = had_substream_get(intelhaddata);
-	if (substream) {
-		buf_size = intelhaddata->buf_info[buf_id].buf_size;
-		intelhaddata->stream_info.buffer_rendered +=
-			(intr_count * buf_size);
-		snd_pcm_period_elapsed(substream);
-		had_substream_put(intelhaddata);
-	}
-
-	return 0;
-}
-
-/* called from irq handler */
-static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
-{
-	enum intel_had_aud_buf_type buf_id;
-	struct pcm_stream_info *stream;
-	struct snd_pcm_substream *substream;
-	unsigned long flags;
-	int connected;
-
-	stream = &intelhaddata->stream_info;
-
-	spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
-	buf_id = intelhaddata->curr_buf;
-	intelhaddata->buff_done = buf_id;
-	connected = intelhaddata->connected;
-	if (stream->running)
-		intelhaddata->curr_buf = HAD_BUF_TYPE_A;
-
-	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
-
-	dev_dbg(intelhaddata->dev, "Enter:%s buf_id=%d, stream_running=%d\n",
-			__func__, buf_id, stream->running);
-
-	snd_intelhad_handle_underrun(intelhaddata);
-
-	if (!connected) {
-		dev_dbg(intelhaddata->dev,
-			"%s:Device already disconnected\n", __func__);
-		return 0;
-	}
-
-	/* Report UNDERRUN error to above layers */
-	substream = had_substream_get(intelhaddata);
-	if (substream) {
-		snd_pcm_stop_xrun(substream);
-		had_substream_put(intelhaddata);
-	}
-
-	return 0;
-}
-
 /* process hot plug, called from wq with mutex locked */
 static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 {
-	enum intel_had_aud_buf_type buf_id;
 	struct snd_pcm_substream *substream;
 
 	spin_lock_irq(&intelhaddata->had_spinlock);
@@ -1465,17 +1336,12 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 		return;
 	}
 
-	buf_id = intelhaddata->curr_buf;
-	intelhaddata->buff_done = buf_id;
 	intelhaddata->connected = true;
 	dev_dbg(intelhaddata->dev,
 		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_CONNECTED\n",
 			__func__, __LINE__);
 	spin_unlock_irq(&intelhaddata->had_spinlock);
 
-	dev_dbg(intelhaddata->dev, "Processing HOT_PLUG, buf_id = %d\n",
-		buf_id);
-
 	/* Safety check */
 	substream = had_substream_get(intelhaddata);
 	if (substream) {
@@ -1492,11 +1358,8 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 /* process hot unplug, called from wq with mutex locked */
 static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 {
-	enum intel_had_aud_buf_type buf_id;
 	struct snd_pcm_substream *substream;
 
-	buf_id = intelhaddata->curr_buf;
-
 	substream = had_substream_get(intelhaddata);
 
 	spin_lock_irq(&intelhaddata->had_spinlock);
@@ -1868,13 +1731,12 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 
-	/* allocate dma pages for ALSA stream operations
-	 * memory allocated is based on size, not max value
-	 * thus using same argument for max & size
+	/* allocate dma pages;
+	 * try to allocate 128k buffer as default which is large enough
 	 */
 	snd_pcm_lib_preallocate_pages_for_all(pcm,
 			SNDRV_DMA_TYPE_DEV, NULL,
-			HAD_MAX_BUFFER, HAD_MAX_BUFFER);
+			128 * 1024, HAD_MAX_BUFFER);
 
 	/* create controls */
 	for (i = 0; i < ARRAY_SIZE(had_controls); i++) {
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 9f713a8a88bc..6178b09801e7 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -64,24 +64,15 @@
 
 struct pcm_stream_info {
 	struct snd_pcm_substream *substream;
-	u64		buffer_rendered;
-	u32		ring_buf_size;
 	int substream_refcount;
 	bool running;
 };
 
-struct ring_buf_info {
-	u32	buf_addr;
-	u32	buf_size;
-	u8	is_valid;
-};
-
 /*
  * struct snd_intelhad - intelhad driver structure
  *
  * @card: ptr to hold card details
  * @connected: the monitor connection status
- * @buf_info: ring buffer info
  * @stream_info: stream information
  * @eld: holds ELD info
  * @curr_buf: pointer to hold current active ring buf
@@ -91,26 +82,28 @@ struct ring_buf_info {
  * @buff_done: id of current buffer done intr
  * @dev: platoform device handle
  * @chmap: holds channel map info
- * @underrun_count: PCM stream underrun counter
  */
 struct snd_intelhad {
 	struct snd_card	*card;
 	bool		connected;
-	struct		ring_buf_info buf_info[HAD_NUM_OF_RING_BUFS];
 	struct		pcm_stream_info stream_info;
 	unsigned char	eld[HDMI_MAX_ELD_BYTES];
 	bool dp_output;
-	enum		intel_had_aud_buf_type curr_buf;
-	int		valid_buf_cnt;
 	unsigned int	aes_bits;
 	spinlock_t had_spinlock;
-	enum		intel_had_aud_buf_type buff_done;
 	struct device *dev;
 	struct snd_pcm_chmap *chmap;
-	int underrun_count;
 	int tmds_clock_speed;
 	int link_rate;
 
+	/* positions (indices) for ring buffer [A-D] */
+	unsigned int ringbuf_head;	/* being processed */
+	unsigned int ringbuf_filled;	/* to be filled */
+	/* positions (indices) for PCM buffer */
+	unsigned int pcmbuf_head;	/* being processed */
+	unsigned int pcmbuf_filled;	/* to be filled */
+	unsigned int period_bytes;	/* PCM period size in bytes */
+
 	/* internal stuff */
 	int irq;
 	void __iomem *mmio_start;
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index be9783910a3a..612714eecaff 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -26,15 +26,14 @@
 #define HAD_MAX_DEVICES		1
 #define HAD_MIN_CHANNEL		2
 #define HAD_MAX_CHANNEL		8
-#define HAD_NUM_OF_RING_BUFS	4
+#define HAD_NUM_RINGBUFS	4
 
-/* Assume 192KHz, 8channel, 25msec period */
-#define HAD_MAX_BUFFER		(600*1024)
-#define HAD_MIN_BUFFER		(32*1024)
-#define HAD_MAX_PERIODS		4
-#define HAD_MIN_PERIODS		4
-#define HAD_MAX_PERIOD_BYTES	(HAD_MAX_BUFFER/HAD_MIN_PERIODS)
-#define HAD_MIN_PERIOD_BYTES	256
+/* max 20bit address, aligned to 64 */
+#define HAD_MAX_BUFFER		((1024 * 1024 - 1) & ~0x3f)
+#define HAD_MAX_PERIODS		256	/* arbitrary, but should suffice */
+#define HAD_MIN_PERIODS		2
+#define HAD_MAX_PERIOD_BYTES	((HAD_MAX_BUFFER / HAD_MIN_PERIODS) & ~0x3f)
+#define HAD_MIN_PERIOD_BYTES	1024	/* might be smaller */
 #define HAD_FIFO_SIZE		0 /* fifo not being used */
 #define MAX_SPEAKERS		8
 
@@ -82,14 +81,6 @@
 /* Naud Value */
 #define DP_NAUD_VAL					32768
 
-/* enum intel_had_aud_buf_type - HDMI controller ring buffer types */
-enum intel_had_aud_buf_type {
-	HAD_BUF_TYPE_A = 0,
-	HAD_BUF_TYPE_B = 1,
-	HAD_BUF_TYPE_C = 2,
-	HAD_BUF_TYPE_D = 3,
-};
-
 /* HDMI Controller register offsets - audio domain common */
 /* Base address for below regs = 0x65000 */
 enum hdmi_ctrl_reg_offset_common {
@@ -274,6 +265,9 @@ union aud_buf_addr {
 	u32 regval;
 };
 
+#define AUD_BUF_VALID		(1U << 0)
+#define AUD_BUF_INTR_EN		(1U << 1)
+
 /* Length of Audio Buffer */
 union aud_buf_len {
 	struct {
-- 
2.11.0
