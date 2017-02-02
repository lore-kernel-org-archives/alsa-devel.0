From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 45/53] ALSA: x86: Move stream status into
	pcm_stream_info
Date: Thu,  2 Feb 2017 18:02:59 +0100
Message-ID: <20170202170307.24484-47-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A553A2675AA
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

The only remaining field in struct had_stream_data is stream_type that
holds the current stream status.  Such information fits better in
struct pcm_stream_info, so move it as a boolean "running" field to be
clearer.

This allows us to get rid or had_stream_data definition and
references.

Also, the superfluous status check get removed in a couple of places
where we can call PCM helpers in anyway.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 50 +++++++++++-----------------------------
 sound/x86/intel_hdmi_audio.h     |  6 +----
 sound/x86/intel_hdmi_lpe_audio.h |  8 -------
 3 files changed, 14 insertions(+), 50 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 04ff7f14fe12..985b7e8d4eae 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -967,11 +967,9 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 {
 	struct snd_intelhad *intelhaddata;
 	struct snd_pcm_runtime *runtime;
-	struct had_stream_data *had_stream;
 	int retval;
 
 	intelhaddata = snd_pcm_substream_chip(substream);
-	had_stream = &intelhaddata->stream_data;
 	runtime = substream->runtime;
 	intelhaddata->underrun_count = 0;
 
@@ -1122,10 +1120,8 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 {
 	int retval = 0;
 	struct snd_intelhad *intelhaddata;
-	struct had_stream_data *had_stream;
 
 	intelhaddata = snd_pcm_substream_chip(substream);
-	had_stream = &intelhaddata->stream_data;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -1139,7 +1135,7 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 			break;
 		}
 
-		had_stream->stream_type = HAD_RUNNING_STREAM;
+		intelhaddata->stream_info.running = true;
 
 		/* Enable Audio */
 		snd_intelhad_enable_audio_int(intelhaddata, true);
@@ -1154,7 +1150,7 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 
 		/* Stop reporting BUFFER_DONE/UNDERRUN to above layers */
 
-		had_stream->stream_type = HAD_INIT;
+		intelhaddata->stream_info.running = false;
 		spin_unlock(&intelhaddata->had_spinlock);
 		/* Disable Audio */
 		snd_intelhad_enable_audio_int(intelhaddata, false);
@@ -1184,11 +1180,9 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	u32 link_rate = 0;
 	struct snd_intelhad *intelhaddata;
 	struct snd_pcm_runtime *runtime;
-	struct had_stream_data *had_stream;
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 	runtime = substream->runtime;
-	had_stream = &intelhaddata->stream_data;
 
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		dev_dbg(intelhaddata->dev, "%s: HDMI cable plugged-out\n",
@@ -1364,9 +1358,6 @@ static inline int had_chk_intrmiss(struct snd_intelhad *intelhaddata,
 	int i, intr_count = 0;
 	enum intel_had_aud_buf_type buff_done;
 	u32 buf_size, buf_addr;
-	struct had_stream_data *had_stream;
-
-	had_stream = &intelhaddata->stream_data;
 
 	buff_done = buf_id;
 
@@ -1409,11 +1400,9 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	struct pcm_stream_info *stream;
 	struct snd_pcm_substream *substream;
 	u32 buf_size;
-	struct had_stream_data *had_stream;
 	int intr_count;
 	unsigned long flags;
 
-	had_stream = &intelhaddata->stream_data;
 	stream = &intelhaddata->stream_info;
 	intr_count = 1;
 
@@ -1435,7 +1424,7 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	 */
 
 	/* Check for any intr_miss in case of active playback */
-	if (had_stream->stream_type == HAD_RUNNING_STREAM) {
+	if (stream->running) {
 		intr_count = had_chk_intrmiss(intelhaddata, buf_id);
 		if (!intr_count || (intr_count > 3)) {
 			spin_unlock_irqrestore(&intelhaddata->had_spinlock,
@@ -1450,7 +1439,7 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 
 	intelhaddata->buf_info[buf_id].is_valid = true;
 	if (intelhaddata->valid_buf_cnt-1 == buf_id) {
-		if (had_stream->stream_type >= HAD_RUNNING_STREAM)
+		if (stream->running)
 			intelhaddata->curr_buf = HAD_BUF_TYPE_A;
 	} else
 		intelhaddata->curr_buf = buf_id + 1;
@@ -1496,27 +1485,23 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
 	struct pcm_stream_info *stream;
-	struct had_stream_data *had_stream;
 	struct snd_pcm_substream *substream;
-	enum had_status_stream stream_type;
 	unsigned long flags;
 	int drv_status;
 
-	had_stream = &intelhaddata->stream_data;
 	stream = &intelhaddata->stream_info;
 
 	spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
 	buf_id = intelhaddata->curr_buf;
-	stream_type = had_stream->stream_type;
 	intelhaddata->buff_done = buf_id;
 	drv_status = intelhaddata->drv_status;
-	if (stream_type == HAD_RUNNING_STREAM)
+	if (stream->running)
 		intelhaddata->curr_buf = HAD_BUF_TYPE_A;
 
 	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
 
-	dev_dbg(intelhaddata->dev, "Enter:%s buf_id=%d, stream_type=%d\n",
-			__func__, buf_id, stream_type);
+	dev_dbg(intelhaddata->dev, "Enter:%s buf_id=%d, stream_running=%d\n",
+			__func__, buf_id, stream->running);
 
 	snd_intelhad_handle_underrun(intelhaddata);
 
@@ -1526,13 +1511,11 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 		return 0;
 	}
 
-	if (stream_type == HAD_RUNNING_STREAM) {
-		/* Report UNDERRUN error to above layers */
-		substream = had_substream_get(intelhaddata);
-		if (substream) {
-			snd_pcm_stop_xrun(substream);
-			had_substream_put(intelhaddata);
-		}
+	/* Report UNDERRUN error to above layers */
+	substream = had_substream_get(intelhaddata);
+	if (substream) {
+		snd_pcm_stop_xrun(substream);
+		had_substream_put(intelhaddata);
 	}
 
 	return 0;
@@ -1543,9 +1526,6 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
 	struct snd_pcm_substream *substream;
-	struct had_stream_data *had_stream;
-
-	had_stream = &intelhaddata->stream_data;
 
 	spin_lock_irq(&intelhaddata->had_spinlock);
 	if (intelhaddata->drv_status == HAD_DRV_CONNECTED) {
@@ -1582,10 +1562,8 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
-	struct had_stream_data *had_stream;
 	struct snd_pcm_substream *substream;
 
-	had_stream = &intelhaddata->stream_data;
 	buf_id = intelhaddata->curr_buf;
 
 	substream = had_substream_get(intelhaddata);
@@ -1607,7 +1585,6 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	dev_dbg(intelhaddata->dev,
 		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
 			__func__, __LINE__);
-	had_stream->stream_type = HAD_INIT;
 	spin_unlock_irq(&intelhaddata->had_spinlock);
 
 	/* Report to above ALSA layer */
@@ -1775,8 +1752,7 @@ static void had_audio_wq(struct work_struct *work)
 		had_process_hot_plug(ctx);
 
 		/* Process mode change if stream is active */
-		if (ctx->stream_data.stream_type == HAD_RUNNING_STREAM)
-			hdmi_audio_mode_change(ctx);
+		hdmi_audio_mode_change(ctx);
 	}
 	mutex_unlock(&ctx->mutex);
 	pm_runtime_put(ctx->dev);
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 6e5a1978e9c7..2804e94a6710 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -76,6 +76,7 @@ struct pcm_stream_info {
 	u64		buffer_rendered;
 	u32		ring_buf_size;
 	int substream_refcount;
+	bool running;
 };
 
 struct ring_buf_info {
@@ -84,10 +85,6 @@ struct ring_buf_info {
 	u8	is_valid;
 };
 
-struct had_stream_data {
-	enum had_status_stream		stream_type;
-};
-
 /**
  * struct snd_intelhad - intelhad driver structure
  *
@@ -115,7 +112,6 @@ struct snd_intelhad {
 	enum		intel_had_aud_buf_type curr_buf;
 	int		valid_buf_cnt;
 	unsigned int	aes_bits;
-	struct had_stream_data stream_data;
 	spinlock_t had_spinlock;
 	enum		intel_had_aud_buf_type buff_done;
 	struct device *dev;
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 483b9feeff30..1e7e6db987c6 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -223,14 +223,6 @@ union otm_hdmi_eld_t {
 	} __packed;
 };
 
-/**
- * enum had_status_stream - HAD stream states
- */
-enum had_status_stream {
-	HAD_INIT = 0,
-	HAD_RUNNING_STREAM,
-};
-
 enum had_drv_status {
 	HAD_DRV_CONNECTED,
 	HAD_DRV_RUNNING,
-- 
2.11.0
