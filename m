From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 1/5] sync asound.h with kernel version
Date: Fri, 20 Feb 2015 18:28:10 -0600
Message-ID: <1424478494-5135-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1424478494-5135-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D140026147D
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 01:28:34 +0100 (CET)
In-Reply-To: <1424478494-5135-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/asound.h | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 1f23cd6..3d46e9a 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -140,7 +140,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 12)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 13)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -267,9 +267,17 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
 #define SNDRV_PCM_INFO_NO_PERIOD_WAKEUP	0x00800000	/* period wakeup can be disabled */
-#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   0x01000000      /* has audio wall clock for audio/system time sync */
+#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   0x01000000      /* (Deprecated)has audio wall clock for audio/system time sync */
+#define SNDRV_PCM_INFO_HAS_LINK_ATIME              0x01000000  /* report hardware link audio time, reset on startup */
+#define SNDRV_PCM_INFO_HAS_LINK_ABSOLUTE_ATIME     0x02000000  /* report absolute hardware link audio time, not reset on startup */
+#define SNDRV_PCM_INFO_HAS_LINK_ESTIMATED_ATIME    0x04000000  /* report estimated link audio time */
+#define SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME 0x08000000  /* report synchronized audio/system time */
+
+#define SNDRV_PCM_INFO_DRAIN_TRIGGER	0x40000000		/* internal kernel flag - trigger in drain */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
+
+
 typedef int __bitwise snd_pcm_state_t;
 #define	SNDRV_PCM_STATE_OPEN		((__force snd_pcm_state_t) 0) /* stream is open */
 #define	SNDRV_PCM_STATE_SETUP		((__force snd_pcm_state_t) 1) /* stream has a setup */
@@ -407,6 +415,22 @@ struct snd_pcm_channel_info {
 	unsigned int step;		/* samples distance in bits */
 };
 
+enum {
+	/*
+	 *  first definition for backwards compatibility only,
+	 *  maps to wallclock/link time for HDAudio playback and DEFAULT/DMA time for everything else
+	 */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_COMPAT = 0,
+
+	/* timestamp definitions */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT = 1,           /* DMA time, reported as per hw_ptr */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK = 2,	           /* link time reported by sample or wallclock counter, reset on startup */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_ABSOLUTE = 3,	   /* link time reported by sample or wallclock counter, not reset on startup */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_ESTIMATED = 4,    /* link time estimated indirectly */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED = 5, /* link time synchronized with system time */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LAST = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED
+};
+
 struct snd_pcm_status {
 	snd_pcm_state_t state;		/* stream state */
 	struct timespec trigger_tstamp;	/* time when stream was started/stopped/paused */
@@ -418,9 +442,11 @@ struct snd_pcm_status {
 	snd_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	snd_pcm_state_t suspended_state; /* suspended stream state */
-	__u32 reserved_alignment;	/* must be filled with zero */
-	struct timespec audio_tstamp;	/* from sample counter or wall clock */
-	unsigned char reserved[56-sizeof(struct timespec)]; /* must be filled with zero */
+	__u32 audio_tstamp_data;	 /* needed for 64-bit alignment, used for configs/report to/from userspace */
+	struct timespec audio_tstamp;	/* sample counter, wall clock, PHC or on-demand sync'ed */
+	struct timespec driver_tstamp;	/* useful in case reference system tstamp is reported with delay */
+	__u32 audio_tstamp_accuracy;	/* in ns units, only valid if indicated in audio_tstamp_data */
+	unsigned char reserved[52-2*sizeof(struct timespec)]; /* must be filled with zero */
 };
 
 struct snd_pcm_mmap_status {
@@ -533,6 +559,7 @@ enum {
 #define SNDRV_PCM_IOCTL_DELAY		_IOR('A', 0x21, snd_pcm_sframes_t)
 #define SNDRV_PCM_IOCTL_HWSYNC		_IO('A', 0x22)
 #define SNDRV_PCM_IOCTL_SYNC_PTR	_IOWR('A', 0x23, struct snd_pcm_sync_ptr)
+#define SNDRV_PCM_IOCTL_STATUS_EXT	_IOWR('A', 0x24, struct snd_pcm_status)
 #define SNDRV_PCM_IOCTL_CHANNEL_INFO	_IOR('A', 0x32, struct snd_pcm_channel_info)
 #define SNDRV_PCM_IOCTL_PREPARE		_IO('A', 0x40)
 #define SNDRV_PCM_IOCTL_RESET		_IO('A', 0x41)
-- 
1.9.1
