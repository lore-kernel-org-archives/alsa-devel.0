From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ALSA: core: add hooks for audio timestamps
	read from WALLCLOCK
Date: Thu, 28 Jun 2012 16:12:34 -0500
Message-ID: <1340917955-31422-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1340917955-31422-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 46B1224456
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 23:12:44 +0200 (CEST)
In-Reply-To: <1340917955-31422-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

TODO: handle 64-bit alignment

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/asound.h  |    7 +++++--
 include/sound/pcm.h     |    2 ++
 sound/core/pcm_compat.c |   13 +++++++++++--
 sound/core/pcm_lib.c    |   15 +++++++++++++--
 sound/core/pcm_native.c |    2 ++
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 0876a1e..b889585 100644
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
+	struct timespec audio_tstamp;	/* audio wall clock timestamp */
+	unsigned char reserved[60-sizeof(struct timespec)]; /* must be filled with zero */
 };
 
 struct snd_pcm_mmap_status {
@@ -431,6 +433,7 @@ struct snd_pcm_mmap_status {
 	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
 	struct timespec tstamp;		/* Timestamp */
 	snd_pcm_state_t suspended_state; /* RO: suspended stream state */
+	struct timespec audio_tstamp;	/* audio wall clock timestamp */
 };
 
 struct snd_pcm_mmap_control {
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 68372bc..d4d65bf 100644
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
index 91cdf94..ab4c953 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -190,7 +190,8 @@ struct snd_pcm_status32 {
 	u32 avail_max;
 	u32 overrange;
 	s32 suspended_state;
-	unsigned char reserved[60];
+	struct timespec audio_tstamp;
+	unsigned char reserved[60-sizeof(struct timespec)];
 } __attribute__((packed));
 
 
@@ -215,7 +216,9 @@ static int snd_pcm_status_user_compat(struct snd_pcm_substream *substream,
 	    put_user(status.avail, &src->avail) ||
 	    put_user(status.avail_max, &src->avail_max) ||
 	    put_user(status.overrange, &src->overrange) ||
-	    put_user(status.suspended_state, &src->suspended_state))
+	    put_user(status.suspended_state, &src->suspended_state) ||
+	    put_user(status.audio_tstamp.tv_sec, &src->audio_tstamp.tv_sec) ||
+	    put_user(status.audio_tstamp.tv_nsec, &src->audio_tstamp.tv_nsec))
 		return -EFAULT;
 
 	return err;
@@ -364,6 +367,7 @@ struct snd_pcm_mmap_status32 {
 	u32 hw_ptr;
 	struct compat_timespec tstamp;
 	s32 suspended_state;
+	struct compat_timespec audio_tstamp;
 } __attribute__((packed));
 
 struct snd_pcm_mmap_control32 {
@@ -426,12 +430,17 @@ static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
 	sstatus.hw_ptr = status->hw_ptr % boundary;
 	sstatus.tstamp = status->tstamp;
 	sstatus.suspended_state = status->suspended_state;
+	sstatus.audio_tstamp = status->audio_tstamp;
 	snd_pcm_stream_unlock_irq(substream);
 	if (put_user(sstatus.state, &src->s.status.state) ||
 	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
 	    put_user(sstatus.tstamp.tv_sec, &src->s.status.tstamp.tv_sec) ||
 	    put_user(sstatus.tstamp.tv_nsec, &src->s.status.tstamp.tv_nsec) ||
 	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
+	    put_user(sstatus.audio_tstamp.tv_sec,
+		    &src->s.status.audio_tstamp.tv_sec) ||
+	    put_user(sstatus.audio_tstamp.tv_nsec,
+		    &src->s.status.audio_tstamp.tv_nsec) ||
 	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
 	    put_user(scontrol.avail_min, &src->c.control.avail_min))
 		return -EFAULT;
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
1.7.6.5
