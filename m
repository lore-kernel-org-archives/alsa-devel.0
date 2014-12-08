From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 1/4] sync asound.h with kernel version
Date: Mon,  8 Dec 2014 16:28:43 -0600
Message-ID: <1418077726-8516-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1418077726-8516-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D462265379
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:29:02 +0100 (CET)
In-Reply-To: <1418077726-8516-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
 include/sound/asound.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 941d32f..b89ad01 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -266,7 +266,12 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
 #define SNDRV_PCM_INFO_NO_PERIOD_WAKEUP	0x00800000	/* period wakeup can be disabled */
-#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   0x01000000      /* has audio wall clock for audio/system time sync */
+
+#define SNDRV_PCM_INFO_HAS_LINK_ATIME   0x01000000      /* report hardware link audio time, reset on startup */
+#define SNDRV_PCM_INFO_HAS_LINK_ABSOLUTE_ATIME    0x02000000  /* report absolute hardware link audio time, not reset on startup */
+#define SNDRV_PCM_INFO_HAS_LINK_ESTIMATED_ATIME    0x04000000  /* report estimated link audio time */
+#define SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME 0x08000000  /* report synchronized audio/system time */
+#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   SNDRV_PCM_INFO_HAS_LINK_ATIME /* deprecated, use LINK_ATIME */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
 typedef int __bitwise snd_pcm_state_t;
@@ -406,6 +411,15 @@ struct snd_pcm_channel_info {
 	unsigned int step;		/* samples distance in bits */
 };
 
+enum {
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT = 0,           /* DMA time, reported as per hw_ptr */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK = 1,	           /* link time reported by sample or wallclock counter, reset on startup */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_ABSOLUTE = 2,	   /* link time reported by sample or wallclock counter, not reset on startup */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_ESTIMATED = 3,    /* link time estimated indirectly */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED = 4, /* link time synchronized with system time */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LAST = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED
+};
+
 struct snd_pcm_status {
 	snd_pcm_state_t state;		/* stream state */
 	struct timespec trigger_tstamp;	/* time when stream was started/stopped/paused */
@@ -417,8 +431,8 @@ struct snd_pcm_status {
 	snd_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	snd_pcm_state_t suspended_state; /* suspended stream state */
-	__u32 reserved_alignment;	/* must be filled with zero */
-	struct timespec audio_tstamp;	/* from sample counter or wall clock */
+	__u32 audio_tstamp_data;	 /* needed for 64-bit alignment, used for configs/report to/from userspace */
+	struct timespec audio_tstamp;	/* sample counter, wall clock, PHC or on-demand sync'ed */
 	unsigned char reserved[56-sizeof(struct timespec)]; /* must be filled with zero */
 };
 
-- 
2.1.0
