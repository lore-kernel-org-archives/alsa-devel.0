From: Nick Stoughton <nstoughton@aether.com>
Subject: [PATCH] ALSA: provide a simple mechanism to start
 playback at a given time
Date: Tue, 14 Oct 2014 10:29:31 +0200
Message-ID: <5448499b.615f460a.1e9b.0c0d@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FF08265308
 for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2014 02:19:41 +0200 (CEST)
Received: by mail-pa0-f47.google.com with SMTP id kx10so296330pab.34
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 17:19:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Given an absolute time based on the clock used by the substream
setup a high resolution timer to cause playback to be triggered
at that time.

Signed-off-by: Nick Stoughton <nstoughton@aether.com>
---
 include/uapi/sound/asound.h |   6 ++
 sound/core/pcm_native.c     | 142 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 6ee5867..92d5856 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -462,6 +462,11 @@ struct snd_xfern {
 	snd_pcm_uframes_t frames;
 };
 
+struct snd_clock_time {
+        clockid_t       clock;
+        struct timespec time;
+};
+
 enum {
 	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
 	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
@@ -547,6 +552,7 @@ enum {
 #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
 #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
 #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
+#define SNDRV_PCM_IOCTL_START_AT	_IOW('A', 0x62, struct snd_clock_time)
 
 /*****************************************************************************
  *                                                                           *
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 85fe1a2..f16ac3c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -27,6 +27,7 @@
 #include <linux/pm_qos.h>
 #include <linux/aio.h>
 #include <linux/dma-mapping.h>
+#include <linux/time.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/info.h>
@@ -38,6 +39,9 @@
 #if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
 #include <dma-coherence.h>
 #endif
+#if defined(CONFIG_HIGH_RES_TIMERS)
+#include <linux/hrtimer.h>
+#endif
 
 /*
  *  Compatibility
@@ -1016,6 +1020,142 @@ static struct action_ops snd_pcm_action_start = {
 	.post_action = snd_pcm_post_start
 };
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+/**
+ * ktime_get_raw_offset - get the offset in ktime format between
+ * the monotonic_raw clock and the monotonic clock
+ */
+static ktime_t ktime_get_raw_offset(void)
+{
+        struct timespec rawtime = {0,0};
+        struct timespec now = {0,0};
+        struct timespec delta;
+
+        ktime_get_ts(&now);
+        getrawmonotonic(&rawtime);
+        delta = timespec_sub(now, rawtime);
+        return timespec_to_ktime(delta);
+}
+
+/*
+ * hrtimer interface
+ */
+
+struct hrtimer_pcm {
+	struct hrtimer timer;
+	struct snd_pcm_substream *substream;
+};
+
+/*
+ * called from a hard irq context - no need for locks.
+ */
+enum hrtimer_restart snd_pcm_do_start_time(struct hrtimer *timer)
+{
+        struct hrtimer_pcm *pcm_timer;
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_runtime *runtime;
+        int ret;
+
+        pcm_timer = container_of(timer, struct hrtimer_pcm, timer);
+        substream = pcm_timer->substream;
+        runtime = substream->runtime;
+
+        /* Check that the stream is still open and in the right state. */
+        if (runtime && runtime->status->state == SNDRV_PCM_STATE_PREPARED) {
+
+                ret = snd_pcm_do_start(substream, SNDRV_PCM_STATE_RUNNING);
+                if (ret == 0) {
+                        snd_pcm_post_start(substream, SNDRV_PCM_STATE_RUNNING);
+                }
+        }
+	kfree(pcm_timer);
+
+        return HRTIMER_NORESTART;
+}
+
+int snd_pcm_start_at(struct snd_pcm_substream *substream,
+        struct timespec __user *_start_time)
+{
+        struct hrtimer_pcm *pcm_timer;
+        struct timespec start_time;
+        int clock;
+        ktime_t start_kt;
+        ktime_t raw_offset;
+        int ret;
+
+	if (copy_from_user(&start_time, _start_time, sizeof(start_time)))
+		return -EFAULT;
+
+        if (!timespec_valid(&start_time))
+		return -EINVAL;
+
+        start_kt = timespec_to_ktime(start_time);
+        switch (substream->runtime->tstamp_type) {
+        case SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY:
+                clock = CLOCK_REALTIME;
+                break;
+        case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC:
+                clock = CLOCK_MONOTONIC;
+                break;
+        case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
+                clock = CLOCK_MONOTONIC_RAW;
+                break;
+        default:
+                return -EINVAL;
+        }
+        switch(clock) {
+        case CLOCK_MONOTONIC_RAW:
+                /*
+                 * convert to clock monotonic:
+                 * the raw clock and the monotonic clock run at different
+                 * rates. Currently there is no timer based on the
+                 * monotonic_raw clock but for our purposes, we assume that
+                 * the divergence between the raw and the monotonic clock
+                 * over the life of the timer will be minimal.
+                 * Typically the difference is less than 20PPM.
+                 * TODO: implement high res timer based on CLOCK_MONOTONIC_RAW
+                 */
+                raw_offset = ktime_get_raw_offset();
+                start_kt = ktime_add(raw_offset, start_kt);
+                clock = CLOCK_MONOTONIC;
+                /* and fall through ... */
+        case CLOCK_MONOTONIC:
+                if (ktime_compare(start_kt, ktime_get()) <= 0)
+                        return -ETIME;
+                break;
+        case CLOCK_REALTIME:
+                if (ktime_compare(start_kt,
+                        ktime_get_with_offset(TK_OFFS_REAL)) <= 0)
+                        return -EINVAL;
+        }
+
+        /* Fail if not playback substream */
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return -EBADFD;
+
+        ret = snd_pcm_pre_start(substream, SNDRV_PCM_STATE_PREPARED);
+        if (ret != 0)
+                return ret;
+
+        pcm_timer = kmalloc(sizeof(*pcm_timer), GFP_KERNEL);
+        hrtimer_init(&pcm_timer->timer, clock, HRTIMER_MODE_ABS);
+
+        pcm_timer->timer.function = snd_pcm_do_start_time;
+        pcm_timer->substream = substream;
+
+	hrtimer_start(&pcm_timer->timer, start_kt, HRTIMER_MODE_ABS);
+
+	return 0;
+}
+#else
+/* without high res time, interface is identical to snd_pcm_start() */
+int snd_pcm_start_at(struct snd_pcm_substream *substream,
+        struct snd_clock_time __user *_start_time)
+{
+        return -ENOSYS;
+}
+#endif
+
 /**
  * snd_pcm_start - start all linked streams
  * @substream: the PCM substream instance
@@ -2698,6 +2838,8 @@ static int snd_pcm_common_ioctl1(struct file *file,
 		return snd_pcm_reset(substream);
 	case SNDRV_PCM_IOCTL_START:
 		return snd_pcm_action_lock_irq(&snd_pcm_action_start, substream, SNDRV_PCM_STATE_RUNNING);
+        case SNDRV_PCM_IOCTL_START_AT:
+                return snd_pcm_start_at(substream, arg);
 	case SNDRV_PCM_IOCTL_LINK:
 		return snd_pcm_link(substream, (int)(unsigned long) arg);
 	case SNDRV_PCM_IOCTL_UNLINK:
-- 
1.9.3
