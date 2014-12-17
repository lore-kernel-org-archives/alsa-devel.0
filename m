From: Tim Cussins <timcussins@eml.cc>
Subject: [PATCH v2 3/3] snd_pcm_start_at: Implement
	snd_pcm_start_at for system and audio tstamp types.
Date: Wed, 17 Dec 2014 17:29:25 +0000
Message-ID: <1418837365-19398-3-git-send-email-timcussins@eml.cc>
References: <1418837365-19398-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id BDDC32606D9
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 18:29:59 +0100 (CET)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 554C9216BE
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 12:29:59 -0500 (EST)
In-Reply-To: <1418837365-19398-1-git-send-email-timcussins@eml.cc>
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
Cc: tiwai@suse.de, nstoughton@aether.com, Tim Cussins <timcussins@eml.cc>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

System tstamp types rely on high-res timers.
Audio tstamp types delegate to the pcm driver.
Current start_at timer is cancelled on attempt to change stream state.

Signed-off-by: Tim Cussins <timcussins@eml.cc>

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 095d957..0ca2818 100644
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
@@ -834,6 +839,11 @@ static int snd_pcm_action_group(struct action_ops *ops,
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
@@ -889,6 +899,11 @@ static int snd_pcm_action_single(struct action_ops *ops,
 {
 	int res;
 	
+	/* Any attempt to change state cancels a pending start_at timer */
+	res = snd_pcm_start_at_cancel(substream);
+	if (res < 0)
+		return res;
+
 	res = ops->pre_action(substream, state);
 	if (res < 0)
 		return res;
@@ -1015,6 +1030,191 @@ static struct action_ops snd_pcm_action_start = {
 	.post_action = snd_pcm_post_start
 };
 
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
+   struct hrtimer_pcm *pcm_timer;
+   struct snd_pcm_substream *substream;
+   int ret;
+
+   pcm_timer = container_of(timer, struct hrtimer_pcm, timer);
+   substream = pcm_timer->substream;
+
+   ret = snd_pcm_do_start(substream, SNDRV_PCM_STATE_RUNNING);
+   if (ret == 0) {
+       snd_pcm_post_start(substream, SNDRV_PCM_STATE_RUNNING);
+   }
+   return HRTIMER_NORESTART;
+}
+#endif
+
+static int snd_pcm_start_at_system(struct snd_pcm_substream *substream, int system_tstamp_type, const struct timespec *start_time)
+{
+#ifdef CONFIG_HIGH_RES_TIMERS
+	struct hrtimer_pcm *pcm_timer;
+	struct timespec now;
+	int ret;
+	clockid_t clock;
+
+	/* Get time now and check if start_time is in the past */
+	snd_pcm_gettime(substream->runtime, &now);
+	if (timespec_compare(&now, start_time) >= 0) {
+		return -ETIME;
+	}
+
+	switch (system_tstamp_type) {
+		case SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY:
+			clock = CLOCK_REALTIME;
+			break;
+		case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC:
+			clock = CLOCK_MONOTONIC;
+			break;
+		case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
+		default: /* unsupported clocks bounce off */
+			return -ENOSYS;
+	}
+
+	/* Allocate a hrtimer to handle the start_at */
+	pcm_timer = kmalloc(sizeof(*pcm_timer), GFP_KERNEL);
+	if (!pcm_timer)
+		return -ENOMEM;
+
+	hrtimer_init(&pcm_timer->timer, clock, HRTIMER_MODE_ABS);
+
+	/* Setup timer */
+	pcm_timer->timer.function = snd_pcm_do_start_time;
+	pcm_timer->substream = substream;
+
+	/* Store timer in runtime start_at info */
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
+static int snd_pcm_start_at_system_cancel(struct snd_pcm_substream *substream)
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
+static int snd_pcm_start_at_audio(struct snd_pcm_substream *substream, int audio_tstamp_type, const struct timespec *start_time)
+{
+	if (substream->ops->start_at)
+		return substream->ops->start_at(substream, audio_tstamp_type, start_time);
+	else
+		return -ENOSYS;
+}
+
+static int snd_pcm_start_at_audio_cancel(struct snd_pcm_substream *substream)
+{
+	if (substream->ops->start_at_cancel)
+		return substream->ops->start_at_cancel(substream);
+	else
+		return -ENOSYS;
+}
+
+/* snd_pcm_start_at_cancel() allows state-transition code to conveniently cancel the pending timer */
+static int snd_pcm_start_at_cancel(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret = 0;
+
+	if (runtime->start_at_timer_running) {
+		switch (runtime->start_at_timer_tstamp_class) {
+			case SNDRV_PCM_TSTAMP_CLASS_SYSTEM:
+				ret = snd_pcm_start_at_system_cancel(substream);
+				break;
+			case SNDRV_PCM_TSTAMP_CLASS_AUDIO:
+				ret = snd_pcm_start_at_audio_cancel(substream);
+				break;
+			default:
+				ret = -ENOSYS;
+		}
+	}
+
+	if (ret == 0) {
+		runtime->start_at_timer_running = 0;
+	}
+
+	return ret;
+}
+
+int snd_pcm_start_at(struct snd_pcm_substream *substream,
+        struct snd_start_at __user *_start_at)
+{
+	struct snd_start_at start_at;
+	int ret;
+
+	if (copy_from_user(&start_at, _start_at, sizeof(start_at)))
+		return -EFAULT;
+
+	if (!timespec_valid(&start_at.start_time))
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
+	switch (start_at.tstamp_class) {
+		case SNDRV_PCM_TSTAMP_CLASS_SYSTEM:
+			ret = snd_pcm_start_at_system(substream, start_at.tstamp_type, &start_at.start_time);
+			break;
+		case SNDRV_PCM_TSTAMP_CLASS_AUDIO:
+			ret = snd_pcm_start_at_audio(substream, start_at.tstamp_type, &start_at.start_time);
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	if (ret == 0) {
+		substream->runtime->start_at_timer_tstamp_class = start_at.tstamp_class;
+		substream->runtime->start_at_timer_running = 1;
+	}
+
+	return ret;
+}
+
 /**
  * snd_pcm_start - start all linked streams
  * @substream: the PCM substream instance
@@ -2721,6 +2921,8 @@ static int snd_pcm_common_ioctl1(struct file *file,
 		return snd_pcm_action_lock_irq(&snd_pcm_action_start, substream, SNDRV_PCM_STATE_RUNNING);
 	case SNDRV_PCM_IOCTL_LINK:
 		return snd_pcm_link(substream, (int)(unsigned long) arg);
+	case SNDRV_PCM_IOCTL_START_AT:
+		return snd_pcm_start_at(substream, arg);
 	case SNDRV_PCM_IOCTL_UNLINK:
 		return snd_pcm_unlink(substream);
 	case SNDRV_PCM_IOCTL_RESUME:
-- 
2.1.0
