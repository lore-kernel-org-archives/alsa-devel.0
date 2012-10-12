From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 2/3] ALSA: core: add hooks for audio
	timestamps
Date: Fri, 12 Oct 2012 12:05:36 -0500
Message-ID: <1350061537-10166-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1350061537-10166-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id F0814261640
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2012 19:06:18 +0200 (CEST)
In-Reply-To: <1350061537-10166-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

ALSA did not provide any direct means to infer the audio time for A/V
sync and system/audio time correlations (eg. PulseAudio).
Applications had to track the number of samples read/written and
add/subtract the number of samples queued in the ring buffer.  This
accounting led to small errors, typically several samples, due to the
two-step process.  Computing the audio time in the kernel is more
direct, as all the information is available in the same routines.

Also add new .audio_wallclock routine to enable fine-grain synchronization
between monotonic system time and audio hardware time.
Using the wallclock, if supported in hardware, allows for a
much better sub-microsecond precision and a common drift tracking for
all devices sharing the same wall clock (master clock).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/asound.h  |    7 +++++--
 include/sound/pcm.h     |    2 ++
 sound/core/pcm_compat.c |   19 +++++++++++--------
 sound/core/pcm_lib.c    |   32 ++++++++++++++++++++++++++++++--
 sound/core/pcm_native.c |    2 ++
 5 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 0876a1e..2d1ba63 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -152,7 +152,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 10)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 11)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -274,6 +274,7 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
 #define SNDRV_PCM_INFO_NO_PERIOD_WAKEUP	0x00800000	/* period wakeup can be disabled */
+#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   0x01000000      /* has audio wall clock for audio/system time sync */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
 typedef int __bitwise snd_pcm_state_t;
@@ -422,7 +423,8 @@ struct snd_pcm_status {
 	snd_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	snd_pcm_state_t suspended_state; /* suspended stream state */
-	unsigned char reserved[60];	/* must be filled with zero */
+	struct timespec audio_tstamp;	/* from sample counter or wall clock */
+	unsigned char reserved[60-sizeof(struct timespec)]; /* must be filled with zero */
 };
 
 struct snd_pcm_mmap_status {
@@ -431,6 +433,7 @@ struct snd_pcm_mmap_status {
 	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
 	struct timespec tstamp;		/* Timestamp */
 	snd_pcm_state_t suspended_state; /* RO: suspended stream state */
+	struct timespec audio_tstamp;	/* from sample counter or wall clock */
 };
 
 struct snd_pcm_mmap_control {
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index ba13e0b..e2f1d48 100644
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
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 91cdf94..3648ae3 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -190,7 +190,8 @@ struct snd_pcm_status32 {
 	u32 avail_max;
 	u32 overrange;
 	s32 suspended_state;
-	unsigned char reserved[60];
+	struct compat_timespec audio_tstamp;
+	unsigned char reserved[60-sizeof(struct timespec)];
 } __attribute__((packed));
 
 
@@ -205,17 +206,16 @@ static int snd_pcm_status_user_compat(struct snd_pcm_substream *substream,
 		return err;
 
 	if (put_user(status.state, &src->state) ||
-	    put_user(status.trigger_tstamp.tv_sec, &src->trigger_tstamp.tv_sec) ||
-	    put_user(status.trigger_tstamp.tv_nsec, &src->trigger_tstamp.tv_nsec) ||
-	    put_user(status.tstamp.tv_sec, &src->tstamp.tv_sec) ||
-	    put_user(status.tstamp.tv_nsec, &src->tstamp.tv_nsec) ||
+	    compat_put_timespec(&status.trigger_tstamp, &src->trigger_tstamp) ||
+	    compat_put_timespec(&status.tstamp, &src->tstamp) ||
 	    put_user(status.appl_ptr, &src->appl_ptr) ||
 	    put_user(status.hw_ptr, &src->hw_ptr) ||
 	    put_user(status.delay, &src->delay) ||
 	    put_user(status.avail, &src->avail) ||
 	    put_user(status.avail_max, &src->avail_max) ||
 	    put_user(status.overrange, &src->overrange) ||
-	    put_user(status.suspended_state, &src->suspended_state))
+	    put_user(status.suspended_state, &src->suspended_state) ||
+	    compat_put_timespec(&status.audio_tstamp, &src->audio_tstamp))
 		return -EFAULT;
 
 	return err;
@@ -364,6 +364,7 @@ struct snd_pcm_mmap_status32 {
 	u32 hw_ptr;
 	struct compat_timespec tstamp;
 	s32 suspended_state;
+	struct compat_timespec audio_tstamp;
 } __attribute__((packed));
 
 struct snd_pcm_mmap_control32 {
@@ -426,12 +427,14 @@ static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
 	sstatus.hw_ptr = status->hw_ptr % boundary;
 	sstatus.tstamp = status->tstamp;
 	sstatus.suspended_state = status->suspended_state;
+	sstatus.audio_tstamp = status->audio_tstamp;
 	snd_pcm_stream_unlock_irq(substream);
 	if (put_user(sstatus.state, &src->s.status.state) ||
 	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
-	    put_user(sstatus.tstamp.tv_sec, &src->s.status.tstamp.tv_sec) ||
-	    put_user(sstatus.tstamp.tv_nsec, &src->s.status.tstamp.tv_nsec) ||
+	    compat_put_timespec(&sstatus.tstamp, &src->s.status.tstamp) ||
 	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
+	    compat_put_timespec(&sstatus.audio_tstamp,
+		    &src->s.status.audio_tstamp) ||
 	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
 	    put_user(scontrol.avail_min, &src->c.control.avail_min))
 		return -EFAULT;
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index bbc6ba4..c060738 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -315,6 +315,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	unsigned long jdelta;
 	unsigned long curr_jiffies;
 	struct timespec curr_tstamp;
+	struct timespec audio_tstamp;
 	int crossed_boundary = 0;
 
 	old_hw_ptr = runtime->status->hw_ptr;
@@ -327,9 +328,14 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	 */
 	pos = substream->ops->pointer(substream);
 	curr_jiffies = jiffies;
-	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE)
+	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
 		snd_pcm_gettime(runtime, (struct timespec *)&curr_tstamp);
 
+		if ((runtime->hw.info & SNDRV_PCM_INFO_HAS_WALL_CLOCK) &&
+			(substream->ops->wall_clock))
+			substream->ops->wall_clock(substream, &audio_tstamp);
+	}
+
 	if (pos == SNDRV_PCM_POS_XRUN) {
 		xrun(substream);
 		return -EPIPE;
@@ -519,9 +525,31 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 		snd_BUG_ON(crossed_boundary != 1);
 		runtime->hw_ptr_wrap += runtime->boundary;
 	}
-	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE)
+	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
 		runtime->status->tstamp = curr_tstamp;
 
+		if (!(runtime->hw.info & SNDRV_PCM_INFO_HAS_WALL_CLOCK)) {
+			/*
+			 * no wall clock available, provide audio timestamp
+			 * derived from pointer position+delay
+			 */
+			u64 audio_frames, audio_nsecs;
+
+			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+				audio_frames = runtime->hw_ptr_wrap
+					+ runtime->status->hw_ptr
+					- runtime->delay;
+			else
+				audio_frames = runtime->hw_ptr_wrap
+					+ runtime->status->hw_ptr
+					+ runtime->delay;
+			audio_nsecs = div_u64(audio_frames * 1000000000LL,
+					runtime->rate);
+			audio_tstamp = ns_to_timespec(audio_nsecs);
+		}
+		runtime->status->audio_tstamp = audio_tstamp;
+	}
+
 	return snd_pcm_update_state(substream, runtime);
 }
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 53b5ada..c5206f4 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -594,6 +594,8 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 		snd_pcm_update_hw_ptr(substream);
 		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
 			status->tstamp = runtime->status->tstamp;
+			status->audio_tstamp =
+				runtime->status->audio_tstamp;
 			goto _tstamp_end;
 		}
 	}
-- 
1.7.9.5
