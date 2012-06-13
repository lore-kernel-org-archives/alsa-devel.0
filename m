From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ALSA: core: add hooks for audio timestamps
	read from WALLCLOCK
Date: Wed, 13 Jun 2012 15:26:31 -0500
Message-ID: <1339619192-2733-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1339619192-2733-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id AE02C104550
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 22:26:45 +0200 (CEST)
In-Reply-To: <1339619192-2733-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add new .audio_wallclock routine to enable fine-grain synchronization
between monotonic system time and audio hardware time.
Prior to this patch, the clock drift estimation was handled in
user-space by comparing frames and system time.
Using the wallclock, if supported in hardware, allows for a
much better sub-microsecond precision and a common drift tracking for
all devices sharing the same wall clock (master clock).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/asound.h  |    7 ++++++-
 include/sound/pcm.h     |    2 ++
 sound/core/pcm_lib.c    |   15 +++++++++++++--
 sound/core/pcm_native.c |    2 ++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 0876a1e..7c768fa 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -274,6 +274,7 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
 #define SNDRV_PCM_INFO_NO_PERIOD_WAKEUP	0x00800000	/* period wakeup can be disabled */
+#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   0x01000000      /* has audio wall clock for audio/system time sync */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
 typedef int __bitwise snd_pcm_state_t;
@@ -422,7 +423,10 @@ struct snd_pcm_status {
 	snd_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	snd_pcm_state_t suspended_state; /* suspended stream state */
-	unsigned char reserved[60];	/* must be filled with zero */
+	union {
+		unsigned char reserved[60];	/* must be filled with zero */
+		struct timespec audio_tstamp;	/* audio wall clock timestamp */
+	} ext;
 };
 
 struct snd_pcm_mmap_status {
@@ -430,6 +434,7 @@ struct snd_pcm_mmap_status {
 	int pad1;			/* Needed for 64 bit alignment */
 	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
 	struct timespec tstamp;		/* Timestamp */
+	struct timespec audio_tstamp;	/* audio wall clock timestamp */
 	snd_pcm_state_t suspended_state; /* RO: suspended stream state */
 };
 
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 0d11128..75d9db0 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -71,6 +71,8 @@ struct snd_pcm_ops {
 	int (*prepare)(struct snd_pcm_substream *substream);
 	int (*trigger)(struct snd_pcm_substream *substream, int cmd);
 	snd_pcm_uframes_t (*pointer)(struct snd_pcm_substream *substream);
+	int (*wall_clock)(struct snd_pcm_substream *substream,
+			  struct timespec *audio_ts);
 	int (*copy)(struct snd_pcm_substream *substream, int channel,
 		    snd_pcm_uframes_t pos,
 		    void __user *buf, snd_pcm_uframes_t count);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 8f312fa..beece7d 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -315,6 +315,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	unsigned long jdelta;
 	unsigned long curr_jiffies;
 	struct timespec curr_tstamp;
+	struct timespec audio_tstamp;
 
 	old_hw_ptr = runtime->status->hw_ptr;
 
@@ -326,9 +327,17 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	 */
 	pos = substream->ops->pointer(substream);
 	curr_jiffies = jiffies;
-	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE)
+	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
 		snd_pcm_gettime(runtime, (struct timespec *)&curr_tstamp);
 
+		if ((runtime->hw.info & SNDRV_PCM_INFO_HAS_WALL_CLOCK) &&
+			(substream->ops->wall_clock))
+			substream->ops->wall_clock(substream, &audio_tstamp);
+		else
+			/* no audio tstamp available, initialize anyway */
+			audio_tstamp = curr_tstamp;
+	}
+
 	if (pos == SNDRV_PCM_POS_XRUN) {
 		xrun(substream);
 		return -EPIPE;
@@ -506,8 +515,10 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	runtime->hw_ptr_base = hw_base;
 	runtime->status->hw_ptr = new_hw_ptr;
 	runtime->hw_ptr_jiffies = curr_jiffies;
-	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE)
+	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
 		runtime->status->tstamp = curr_tstamp;
+		runtime->status->audio_tstamp = audio_tstamp;
+	}
 
 	return snd_pcm_update_state(substream, runtime);
 }
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 53b5ada..bf0176b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -594,6 +594,8 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 		snd_pcm_update_hw_ptr(substream);
 		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
 			status->tstamp = runtime->status->tstamp;
+			status->ext.audio_tstamp =
+				runtime->status->audio_tstamp;
 			goto _tstamp_end;
 		}
 	}
-- 
1.7.6.5
