From: Tim Cussins <timcussins@eml.cc>
Subject: [RFC] kernel: Add snd_pcm_start_at
Date: Wed,  3 Dec 2014 16:26:28 +0000
Message-ID: <1417623988-8949-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 4A6E1260451
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 17:26:38 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 01074211C7
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 11:26:35 -0500 (EST)
Received: from PC816.linn.co.uk (unknown [195.59.102.251])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7FB99C00282
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 11:26:35 -0500 (EST)
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
List-Id: alsa-devel@alsa-project.org

snd_pcm_start_at() - kernel-side

The headlines:

- Provide snd_pcm_start_at ioctl
- Add SND_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK
- Use the stream tstamp_type to interpret the start_at timespec
	- snd_pcm_start_at_ops defines handler for a TSTAMP_TYPE
	- handler requirements clearly defined
	- If posix clock, use a high-res timer implementation (thx Nick Stoughton!)
	- If audio wallclock, delegate to the pcm driver if possible, otherwise error
	- Further implementations easily added
- Cancel pending timer on:
	- Subsequent call to snd_pcm_start_at()
	- Any /attempt/ to change the stream state

Major points for discussion:

- snd_pcm_start_at_ops requirements aren't clear enough
	- callback must not do cleanup
	- cancel is guaranteed to be called - do cleanup here
- snd_pcm_gettime() can't currently return a value when tstamp_type is AUDIO_WALLCLOCK
- start_at timer callbacks *should* probably lock the stream, contrary to Nick's note
- The user story for start_at cancellation from userspace is a bit weird...
	- Cancellation on state-change seems necessary, but not sufficient
	- Maybe add snd_pcm_start_at_cancel()?

Future thoughts:

- Perhaps snd_pcm_start_at should be a blocking call (EAGAIN when stream is non-blocking)
- Maybe tstamp_types and startat_types should be different things

I've become convinced that exposing the nature of the pcm clock is troublesome, and unnecessary,
 and fell back to Takashi's suggestion of a DEVICE_SPECIFIC tstamp_type. I note that
AUDIO_WALLCLOCK seems to capture the concept of 'pcm time', so I've called it that.

Because I'm using SND_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK instead of SNDRV_PCM_TSTAMP_TYPE_PTP,
there's no additional payload required for snd_pcm_sw_set_tstamp_type().

Comments and suggestions welcome :)
Tim


diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1e7f74a..b8bfa9b 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -82,6 +82,8 @@ struct snd_pcm_ops {
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
 	int (*ack)(struct snd_pcm_substream *substream);
+	int (*wall_clock_start_at)(struct snd_pcm_substream *substream, const struct timespec *ts);
+	int (*wall_clock_start_at_cancel)(struct snd_pcm_substream *substream);
 };
 
 /*
@@ -210,6 +212,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE
 #endif
 
+#define SNDRV_PCM_START_AT_TSTAMP_TYPE_NULL (SNDRV_PCM_TSTAMP_TYPE_LAST+1)
+
 struct snd_pcm_file {
 	struct snd_pcm_substream *substream;
 	int no_compat_mmap;
@@ -364,6 +368,10 @@ struct snd_pcm_runtime {
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
 	struct snd_pcm_hwptr_log *hwptr_log;
 #endif
+
+	int start_at_tstamp_type;	/* start_at timer tstamp_type Set to
+					   SNDRV_PCM_START_AT_TSTAMP_TYPE_NULL if not active */
+	void *start_at_timer_data;	/* start_at timer data */
 };
 
 struct snd_pcm_group {		/* keep linked substreams */
@@ -1069,6 +1077,7 @@ static inline void snd_pcm_gettime(struct snd_pcm_runtime *runtime,
 	case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
 		getrawmonotonic(tv);
 		break;
+	case SNDRV_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK:
 	default:
 		getnstimeofday(tv);
 		break;
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 941d32f..dfe2bac 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -467,8 +467,9 @@ struct snd_xfern {
 enum {
 	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
 	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
-	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,    /* monotonic_raw (no NTP) */
-	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
+	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,	/* monotonic_raw (no NTP) */
+	SNDRV_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK,	/* audio wallclock timestamp */
+	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK,
 };
 
 /* channel positions */
@@ -549,6 +550,7 @@ enum {
 #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
 #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
 #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
+#define SNDRV_PCM_IOCTL_START_AT	_IOW('A', 0x62, struct timespec)
 
 /*****************************************************************************
  *                                                                           *
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index cfc56c8..483f85d 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1003,6 +1003,7 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 	init_waitqueue_head(&runtime->tsleep);
 
 	runtime->status->state = SNDRV_PCM_STATE_OPEN;
+	runtime->start_at_tstamp_type = SNDRV_PCM_START_AT_TSTAMP_TYPE_NULL;
 
 	substream->runtime = runtime;
 	substream->private_data = pcm->private_data;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 095d957..352921d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -35,6 +35,9 @@
 #include <sound/timer.h>
 #include <sound/minors.h>
 #include <asm/io.h>
+#if defined(CONFIG_HIGH_RES_TIMERS)
+#include <linux/hrtimer.h>
+#endif
 
 /*
  *  Compatibility
@@ -67,6 +70,8 @@ static int snd_pcm_hw_params_old_user(struct snd_pcm_substream *substream,
 #endif
 static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream);
 
+static int snd_pcm_start_at_cancel(struct snd_pcm_substream *substream);
+
 /*
  *
  */
@@ -265,6 +270,7 @@ static const char * const snd_pcm_hw_param_names[] = {
 };
 #endif
 
+
 int snd_pcm_hw_refine(struct snd_pcm_substream *substream, 
 		      struct snd_pcm_hw_params *params)
 {
@@ -834,6 +840,11 @@ static int snd_pcm_action_group(struct action_ops *ops,
 	struct snd_pcm_substream *s1;
 	int res = 0, depth = 1;
 
+	/* Any attempt to change state cancels a pending start_at timer */
+	res = snd_pcm_start_at_cancel(substream);
+	if (res < 0)
+		return res;
+
 	snd_pcm_group_for_each_entry(s, substream) {
 		if (do_lock && s != substream) {
 			if (s->pcm->nonatomic)
@@ -888,6 +899,11 @@ static int snd_pcm_action_single(struct action_ops *ops,
 				 int state)
 {
 	int res;
+
+	/* Any attempt to change state cancels a pending start_at timer */
+	res = snd_pcm_start_at_cancel(substream);
+	if (res < 0)
+		return res;
 	
 	res = ops->pre_action(substream, state);
 	if (res < 0)
@@ -1015,6 +1031,234 @@ static struct action_ops snd_pcm_action_start = {
 	.post_action = snd_pcm_post_start
 };
 
+static inline clockid_t snd_pcm_get_clockid(struct snd_pcm_substream* substream)
+{
+	switch(substream->runtime->tstamp_type)
+	{
+	case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC:
+		return CLOCK_MONOTONIC;
+	case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
+		return CLOCK_MONOTONIC_RAW;
+	default:
+		return CLOCK_REALTIME;
+	}
+}
+
+/* snd_pcm_start_at_ops
+ * There are various mechanisms for supporting snd_pcm_start_at. Posix clocks may
+ * use hires timers if available.
+ *
+ * schedule() may use the runtime member 'start_at_timer_data' to store enough
+ * information to cancel the timer. When the timer fires, it must be single-shot,
+ * and must not cancel/delete the timer: cancel() is guaranteed to be called
+ * before the timer is reused, so resources should be freed within cancel(), not
+ * by the timer callback.
+ *
+ * cancel() returns when the start_at timer callback is guaranteed to be both
+ * cancelled and not currently running.
+*/
+
+struct snd_pcm_start_at_ops {
+	int (*schedule)(struct snd_pcm_substream *substream, const struct timespec *start_time);
+	int (*cancel)(struct snd_pcm_substream *substream);
+};
+
+/* To support snd_pcm_start_at for posix tstamp_types, we use high-res timers, if
+ * kernel is configured appropriately.
+ */
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+/*
+ * hrtimer interface
+ */
+
+struct hrtimer_pcm {
+   struct hrtimer timer;
+   struct snd_pcm_substream *substream;
+};
+
+/*
+ * called from a hard irq context - no need for locks.
+ * only problem is that the caller might have gone away and closed the substream
+ * before the timer expires.
+ */
+enum hrtimer_restart snd_pcm_do_start_time(struct hrtimer *timer)
+{
+	struct hrtimer_pcm *pcm_timer;
+	struct snd_pcm_substream *substream;
+	int ret;
+
+	pcm_timer = container_of(timer, struct hrtimer_pcm, timer);
+	substream = pcm_timer->substream;
+
+	ret = snd_pcm_do_start(substream, SNDRV_PCM_STATE_RUNNING);
+	if (ret == 0) {
+		snd_pcm_post_start(substream, SNDRV_PCM_STATE_RUNNING);
+	}
+	return HRTIMER_NORESTART;
+}
+#endif
+
+
+
+static int start_at_posix_schedule(struct snd_pcm_substream *substream, const struct timespec *start_time)
+{
+#ifdef CONFIG_HIGH_RES_TIMERS
+	struct hrtimer_pcm *pcm_timer;
+	struct timespec now;
+	int ret;
+
+	/* Get time now and check if start_time is in the past */
+	snd_pcm_gettime(substream->runtime, &now);
+	if (timespec_compare(&now, start_time) >= 0) {
+		return -ETIME;
+	}
+
+	/* Allocate a hrtimer to handle the start_at */
+	pcm_timer = kmalloc(sizeof(*pcm_timer), GFP_KERNEL);
+	if (!pcm_timer)
+		return -ENOMEM;
+
+	hrtimer_init(&pcm_timer->timer, snd_pcm_get_clockid(substream), HRTIMER_MODE_ABS);
+
+	/* Setup timer */
+	pcm_timer->timer.function = snd_pcm_do_start_time;
+	pcm_timer->substream = substream;
+
+	/* Store timer in start_at info */
+	substream->runtime->start_at_timer_data = pcm_timer;
+
+	/* Pre start */
+	ret = snd_pcm_pre_start(substream, SNDRV_PCM_STATE_PREPARED);
+	if (ret < 0)
+		goto error;
+
+	ret = hrtimer_start(&pcm_timer->timer, timespec_to_ktime(*start_time), HRTIMER_MODE_ABS);
+	if (ret < 0 )
+		goto error;
+
+	return 0;
+error:
+	kfree(pcm_timer);
+	return ret;
+#else
+	return -ENOSYS;
+#endif
+}
+
+static int start_at_posix_cancel(struct snd_pcm_substream *substream)
+{
+#ifdef CONFIG_HIGH_RES_TIMERS
+	struct hrtimer_pcm *pcm_timer = substream->runtime->start_at_timer_data;
+	hrtimer_cancel(&pcm_timer->timer); /* Cancel existing timer. (NOP if it's not running) */
+	kfree(pcm_timer);
+	return 0;
+#else
+	return -ENOSYS;
+#endif
+}
+
+static int start_at_wallclock_schedule(struct snd_pcm_substream *substream, const struct timespec *start_time)
+{
+	if (substream->ops->wall_clock_start_at)
+		return substream->ops->wall_clock_start_at(substream, start_time);
+	else
+		return -ENOSYS;
+}
+
+static int start_at_wallclock_cancel(struct snd_pcm_substream *substream)
+{
+	if (substream->ops->wall_clock_start_at_cancel)
+		return substream->ops->wall_clock_start_at_cancel(substream);
+	else
+		return -ENOSYS;
+}
+
+static struct snd_pcm_start_at_ops start_at_ops[SNDRV_PCM_START_AT_TSTAMP_TYPE_NULL+1] = {
+	[SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY] = {
+		.schedule 	= start_at_posix_schedule,
+		.cancel 	= start_at_posix_cancel
+		},
+	[SNDRV_PCM_TSTAMP_TYPE_MONOTONIC] = {
+		.schedule 	= start_at_posix_schedule,
+		.cancel 	= start_at_posix_cancel
+		},
+	[SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW] = { /* hrtimers can't handle CLOCK_MONOTONIC_RAW */
+		.schedule 	= NULL,
+		.cancel 	= NULL,
+		},
+	[SNDRV_PCM_TSTAMP_TYPE_AUDIO_WALLCLOCK] = { /* delegate start_at to pcm driver */
+		.schedule 	= start_at_wallclock_schedule,
+		.cancel 	= start_at_wallclock_cancel,
+		},
+	[SNDRV_PCM_START_AT_TSTAMP_TYPE_NULL] = { /* null handler - required for handling first cancellation */
+		.schedule	= NULL,
+		.cancel		= NULL,
+		},
+};
+
+/* snd_pcm_start_at_cancel() allows state-transition code to conveniently cancel the pending timer */
+static int snd_pcm_start_at_cancel(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_start_at_ops *ops = &start_at_ops[substream->runtime->start_at_tstamp_type];
+	int ret = 0;
+
+	/* If ops->cancel is NULL, it's not an error. */
+	if (ops->cancel) {
+		ret = ops->cancel(substream);
+		if (ret == 0)
+			substream->runtime->start_at_tstamp_type = SNDRV_PCM_START_AT_TSTAMP_TYPE_NULL;
+	}
+
+	return ret;
+}
+
+int snd_pcm_start_at(struct snd_pcm_substream *substream,
+        struct timespec __user *_start_time)
+{
+	struct timespec start_time;
+	int new_tstamp_type;
+	struct snd_pcm_start_at_ops *ops;
+	int ret;
+
+	if (copy_from_user(&start_time, _start_time, sizeof(start_time)))
+		return -EFAULT;
+
+	if (!timespec_valid(&start_time))
+		return -EINVAL;
+
+	/*  If not a playback substream, give up */
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return -EINVAL;
+
+	/* Cancel any existing timer */
+	ret = snd_pcm_start_at_cancel(substream);
+	if (ret < 0)
+		return ret;
+
+	/* Get new tstamp_type */
+	new_tstamp_type = substream->runtime->tstamp_type;
+
+	/* Save current start_at tstamp_type. This way, it's valid before
+	   schedule() is called */
+	substream->runtime->start_at_tstamp_type = new_tstamp_type;
+
+	/* Get apprpriate start_at ops */
+	ops = &start_at_ops[new_tstamp_type];
+
+	/* Schedule start_at. If it doesn't exist, that's an error. */
+	if (ops->schedule) {
+		ret = ops->schedule(substream, &start_time);
+		/* If successful, mark timer as cancelled */
+		if (ret < 0)
+			/* If schedule() failed, reset tstamp type */
+			substream->runtime->start_at_tstamp_type = SNDRV_PCM_START_AT_TSTAMP_TYPE_NULL;
+		return ret;
+	}
+	else
+		return -ENOSYS;
+}
+
 /**
  * snd_pcm_start - start all linked streams
  * @substream: the PCM substream instance
@@ -2721,6 +2965,8 @@ static int snd_pcm_common_ioctl1(struct file *file,
 		return snd_pcm_action_lock_irq(&snd_pcm_action_start, substream, SNDRV_PCM_STATE_RUNNING);
 	case SNDRV_PCM_IOCTL_LINK:
 		return snd_pcm_link(substream, (int)(unsigned long) arg);
+        case SNDRV_PCM_IOCTL_START_AT:
+                return snd_pcm_start_at(substream, arg);
 	case SNDRV_PCM_IOCTL_UNLINK:
 		return snd_pcm_unlink(substream);
 	case SNDRV_PCM_IOCTL_RESUME:
-- 
1.9.1
