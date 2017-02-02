From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 41/53] ALSA: x86: Drop redundant had_stream_pvt
Date: Thu,  2 Feb 2017 18:02:55 +0100
Message-ID: <20170202170307.24484-43-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F20FB267593
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

The had_stream_pvt struct assigned to PCM runtime private data tracks
merely the stream running status, and the very same information is
carried by had_stream->stream_type.  Kill it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 46 ++++------------------------------------
 sound/x86/intel_hdmi_audio.h     |  6 ------
 sound/x86/intel_hdmi_lpe_audio.h | 15 -------------
 3 files changed, 4 insertions(+), 63 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 621be602addd..88e9a91f28a0 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -953,7 +953,6 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 {
 	struct snd_intelhad *intelhaddata;
 	struct snd_pcm_runtime *runtime;
-	struct had_stream_pvt *stream;
 	struct had_stream_data *had_stream;
 	int retval;
 
@@ -968,31 +967,16 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 		dev_dbg(intelhaddata->dev, "%s: HDMI cable plugged-out\n",
 			__func__);
 		retval = -ENODEV;
-		goto exit_put_handle;
-	}
-
-	/* Check, if device already in use */
-	if (runtime->private_data) {
-		dev_dbg(intelhaddata->dev, "Device already in use\n");
-		retval = -EBUSY;
-		goto exit_put_handle;
+		goto error;
 	}
 
 	/* set the runtime hw parameter with local snd_pcm_hardware struct */
 	runtime->hw = snd_intel_hadstream;
 
-	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
-	if (!stream) {
-		retval = -ENOMEM;
-		goto exit_put_handle;
-	}
-	stream->stream_status = STREAM_INIT;
-	runtime->private_data = stream;
-
 	retval = snd_pcm_hw_constraint_integer(runtime,
 			 SNDRV_PCM_HW_PARAM_PERIODS);
 	if (retval < 0)
-		goto exit_err;
+		goto error;
 
 	/* Make sure, that the period size is always aligned
 	 * 64byte boundary
@@ -1002,15 +986,12 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 	if (retval < 0) {
 		dev_dbg(intelhaddata->dev, "%s:step_size=64 failed,err=%d\n",
 			__func__, retval);
-		goto exit_err;
+		goto error;
 	}
 
 	return retval;
-exit_err:
-	kfree(stream);
-exit_put_handle:
+ error:
 	pm_runtime_put(intelhaddata->dev);
-	runtime->private_data = NULL;
 	return retval;
 }
 
@@ -1020,16 +1001,8 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
  */
 static void had_period_elapsed(struct snd_pcm_substream *substream)
 {
-	struct had_stream_pvt *stream;
-
 	if (!substream || !substream->runtime)
 		return;
-	stream = substream->runtime->private_data;
-	if (!stream)
-		return;
-
-	if (stream->stream_status != STREAM_RUNNING)
-		return;
 	snd_pcm_period_elapsed(substream);
 }
 
@@ -1042,13 +1015,8 @@ static void had_period_elapsed(struct snd_pcm_substream *substream)
 static int snd_intelhad_close(struct snd_pcm_substream *substream)
 {
 	struct snd_intelhad *intelhaddata;
-	struct snd_pcm_runtime *runtime;
 
 	intelhaddata = snd_pcm_substream_chip(substream);
-	runtime = substream->runtime;
-
-	if (WARN_ON(!runtime->private_data))
-		return 0;
 
 	intelhaddata->stream_info.buffer_rendered = 0;
 	intelhaddata->stream_info.buffer_ptr = 0;
@@ -1062,8 +1030,6 @@ static int snd_intelhad_close(struct snd_pcm_substream *substream)
 			"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_CONNECTED\n",
 			__func__, __LINE__);
 	}
-	kfree(runtime->private_data);
-	runtime->private_data = NULL;
 	pm_runtime_put(intelhaddata->dev);
 	return 0;
 }
@@ -1142,11 +1108,9 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 {
 	int retval = 0;
 	struct snd_intelhad *intelhaddata;
-	struct had_stream_pvt *stream;
 	struct had_stream_data *had_stream;
 
 	intelhaddata = snd_pcm_substream_chip(substream);
-	stream = substream->runtime->private_data;
 	had_stream = &intelhaddata->stream_data;
 
 	switch (cmd) {
@@ -1158,7 +1122,6 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 			retval = -ENODEV;
 			break;
 		}
-		stream->stream_status = STREAM_RUNNING;
 
 		had_stream->stream_type = HAD_RUNNING_STREAM;
 
@@ -1182,7 +1145,6 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		/* Reset buffer pointers */
 		snd_intelhad_reset_audio(intelhaddata, 1);
 		snd_intelhad_reset_audio(intelhaddata, 0);
-		stream->stream_status = STREAM_DROPPED;
 		snd_intelhad_enable_audio_int(intelhaddata, false);
 		break;
 
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 258396e61829..3bd2bb60f1f1 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -86,12 +86,6 @@ struct ring_buf_info {
 	u8	is_valid;
 };
 
-struct had_stream_pvt {
-	enum had_stream_status		stream_status;
-	int				stream_ops;
-	ssize_t				dbg_cum_bytes;
-};
-
 struct had_stream_data {
 	enum had_status_stream		stream_type;
 };
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 1bc961522d0d..483b9feeff30 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -224,21 +224,6 @@ union otm_hdmi_eld_t {
 };
 
 /**
- * enum had_status - Audio stream states
- *
- * @STREAM_INIT: Stream initialized
- * @STREAM_RUNNING: Stream running
- * @STREAM_PAUSED: Stream paused
- * @STREAM_DROPPED: Stream dropped
- */
-enum had_stream_status {
-	STREAM_INIT = 0,
-	STREAM_RUNNING = 1,
-	STREAM_PAUSED = 2,
-	STREAM_DROPPED = 3
-};
-
-/**
  * enum had_status_stream - HAD stream states
  */
 enum had_status_stream {
-- 
2.11.0
