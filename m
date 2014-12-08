From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 8/9] ALSA: core: replace .wall_clock by
	.get_time_info
Date: Mon,  8 Dec 2014 16:23:45 -0600
Message-ID: <1418077426-8309-9-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CC16F2605BD
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:24:42 +0100 (CET)
In-Reply-To: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Introduce more generic .get_time_info to retrieve
system timestamp and audio timestamp in single routine.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/pcm.h     |  6 ++--
 sound/core/pcm_lib.c    | 81 +++++++++++++++++++++++++++++++------------------
 sound/core/pcm_native.c |  7 +++++
 3 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2bd7914..b490363 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -74,8 +74,10 @@ struct snd_pcm_ops {
 	int (*prepare)(struct snd_pcm_substream *substream);
 	int (*trigger)(struct snd_pcm_substream *substream, int cmd);
 	snd_pcm_uframes_t (*pointer)(struct snd_pcm_substream *substream);
-	int (*wall_clock)(struct snd_pcm_substream *substream,
-			  struct timespec *audio_ts);
+	int (*get_time_info)(struct snd_pcm_substream *substream,
+			struct timespec *system_ts, struct timespec *audio_ts,
+			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
+			struct snd_pcm_audio_tstamp_report *audio_tstamp_report);
 	int (*copy)(struct snd_pcm_substream *substream, int channel,
 		    snd_pcm_uframes_t pos,
 		    void __user *buf, snd_pcm_uframes_t count);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index ec9e786..6c61e6c 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -232,6 +232,42 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static void update_audio_tstamp(struct snd_pcm_substream *substream,
+				struct timespec *curr_tstamp,
+				struct timespec *audio_tstamp)
+
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	u64 audio_frames, audio_nsecs;
+
+	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
+		runtime->status->tstamp = *curr_tstamp;
+
+		if (!(substream->ops->get_time_info) ||
+			(runtime->audio_tstamp_report.actual_type == SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT)) {
+
+			/*
+			 * provide audio timestamp derived from pointer position
+			 * add delay only if requested
+			 */
+
+			audio_frames = runtime->hw_ptr_wrap
+				+ runtime->status->hw_ptr;
+
+			if (runtime->audio_tstamp_config.report_delay) {
+				if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+					audio_frames -=  runtime->delay;
+				else
+					audio_frames +=  runtime->delay;
+			}
+			audio_nsecs = div_u64(audio_frames * 1000000000LL,
+					runtime->rate);
+			*audio_tstamp = ns_to_timespec(audio_nsecs);
+		}
+		runtime->status->audio_tstamp = *audio_tstamp;
+	}
+}
+
 static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 				  unsigned int in_interrupt)
 {
@@ -256,11 +292,18 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	pos = substream->ops->pointer(substream);
 	curr_jiffies = jiffies;
 	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
-		snd_pcm_gettime(runtime, (struct timespec *)&curr_tstamp);
-
-		if ((runtime->hw.info & SNDRV_PCM_INFO_HAS_WALL_CLOCK) &&
-			(substream->ops->wall_clock))
-			substream->ops->wall_clock(substream, &audio_tstamp);
+		if ((substream->ops->get_time_info) &&
+			(runtime->audio_tstamp_config.type_requested != SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT)) {
+			substream->ops->get_time_info(substream, &curr_tstamp,
+						&audio_tstamp,
+						&runtime->audio_tstamp_config,
+						&runtime->audio_tstamp_report);
+
+			/* re-test in case tstamp type is not supported in hardware and was demoted to DEFAULT */
+			if (runtime->audio_tstamp_report.actual_type == SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT)
+				snd_pcm_gettime(runtime, (struct timespec *)&curr_tstamp);
+		} else
+			snd_pcm_gettime(runtime, (struct timespec *)&curr_tstamp);
 	}
 
 	if (pos == SNDRV_PCM_POS_XRUN) {
@@ -403,8 +446,10 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	}
 
  no_delta_check:
-	if (runtime->status->hw_ptr == new_hw_ptr)
+	if (runtime->status->hw_ptr == new_hw_ptr) {
+		update_audio_tstamp(substream, &curr_tstamp, &audio_tstamp);
 		return 0;
+	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    runtime->silence_size > 0)
@@ -426,30 +471,8 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 		snd_BUG_ON(crossed_boundary != 1);
 		runtime->hw_ptr_wrap += runtime->boundary;
 	}
-	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
-		runtime->status->tstamp = curr_tstamp;
 
-		if (!(runtime->hw.info & SNDRV_PCM_INFO_HAS_WALL_CLOCK)) {
-			/*
-			 * no wall clock available, provide audio timestamp
-			 * derived from pointer position+delay
-			 */
-			u64 audio_frames, audio_nsecs;
-
-			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-				audio_frames = runtime->hw_ptr_wrap
-					+ runtime->status->hw_ptr
-					- runtime->delay;
-			else
-				audio_frames = runtime->hw_ptr_wrap
-					+ runtime->status->hw_ptr
-					+ runtime->delay;
-			audio_nsecs = div_u64(audio_frames * 1000000000LL,
-					runtime->rate);
-			audio_tstamp = ns_to_timespec(audio_nsecs);
-		}
-		runtime->status->audio_tstamp = audio_tstamp;
-	}
+	update_audio_tstamp(substream, &curr_tstamp, &audio_tstamp);
 
 	return snd_pcm_update_state(substream, runtime);
 }
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 7dcd6bd..f079be8 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -706,6 +706,10 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	snd_pcm_stream_lock_irq(substream);
+
+
+	snd_pcm_unpack_audio_tstamp_config(status->audio_tstamp_data,
+					&runtime->audio_tstamp_config);
 	memset(status, 0, sizeof(*status));
 	status->state = runtime->status->state;
 	status->suspended_state = runtime->status->suspended_state;
@@ -718,6 +722,9 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 			status->tstamp = runtime->status->tstamp;
 			status->audio_tstamp =
 				runtime->status->audio_tstamp;
+			snd_pcm_pack_audio_tstamp_report(&status->audio_tstamp_data,
+							&runtime->audio_tstamp_report);
+
 			goto _tstamp_end;
 		}
 	} else {
-- 
2.1.0
