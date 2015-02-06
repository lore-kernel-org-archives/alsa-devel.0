From: Tim Cussins <timcussins@eml.cc>
Subject: [PATCH v3 kernel 3/3] snd_pcm_start_at implementation
Date: Fri,  6 Feb 2015 16:16:28 +0000
Message-ID: <1423239388-17745-3-git-send-email-timcussins@eml.cc>
References: <1423239388-17745-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CB483265335
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 17:16:40 +0100 (CET)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 698E42000D
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 11:16:40 -0500 (EST)
In-Reply-To: <1423239388-17745-1-git-send-email-timcussins@eml.cc>
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
Cc: Tim Cussins <timcussins@eml.cc>
List-Id: alsa-devel@alsa-project.org

- posix clocks require hi-res timers. If the kernel is configured without,
  start_at_* will return -ENOSYS.

- If there is a pending startat timer, relevant info is copied to the
  snd_pcm_status structure.

- snd_pcm_start_at_{register,unregister} are provided for the convenience
  of drivers implementing start_at.

- start_at can be called in any state: If the stream isn't in an appropriate
  state when the timer expires, the start_at fails.

- The startat timer is cancelled when the stream is released.

Signed-off-by: Tim Cussins <timcussins@eml.cc>

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 932234d..af808d9 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -35,6 +35,9 @@
 #include <sound/pcm_params.h>
 #include <sound/timer.h>
 #include <sound/minors.h>
+#if defined(CONFIG_HIGH_RES_TIMERS)
+#include <linux/hrtimer.h>
+#endif
 
 /*
  *  Compatibility
@@ -709,6 +712,16 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 	snd_pcm_stream_lock_irq(substream);
 	status->state = runtime->status->state;
 	status->suspended_state = runtime->status->suspended_state;
+
+	if (runtime->startat_timer_running) {
+		status->startat_pending = 1;
+		status->startat_clock_type = runtime->startat_clock_type;
+		status->startat_start_time = runtime->startat_start_time;
+	}
+	else {
+		status->startat_pending = 0;
+	}
+
 	if (status->state == SNDRV_PCM_STATE_OPEN)
 		goto _end;
 	status->trigger_tstamp = runtime->trigger_tstamp;
@@ -1016,6 +1029,251 @@ static struct action_ops snd_pcm_action_start = {
 	.post_action = snd_pcm_post_start
 };
 
+void snd_pcm_start_at_register(struct snd_pcm_substream *substream, int clock_type, const struct timespec *start_time, void *data)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->startat_timer_running = true;
+	runtime->startat_timer_data = data;
+	runtime->startat_clock_type = clock_type;
+	runtime->startat_start_time = *start_time;
+}
+
+EXPORT_SYMBOL(snd_pcm_start_at_register);
+
+void snd_pcm_start_at_unregister(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->startat_timer_running = false;
+	runtime->startat_timer_data = NULL;
+}
+
+EXPORT_SYMBOL(snd_pcm_start_at_unregister);
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
+enum hrtimer_restart snd_pcm_do_start_time(struct hrtimer *timer)
+{
+	struct hrtimer_pcm *pcm_timer;
+	struct snd_pcm_substream *substream;
+	int ret;
+
+	pcm_timer = container_of(timer, struct hrtimer_pcm, timer);
+	substream = pcm_timer->substream;
+
+	snd_pcm_stream_lock(substream);
+
+	snd_pcm_start_at_unregister(substream);
+
+	ret = snd_pcm_do_start(substream, SNDRV_PCM_STATE_RUNNING);
+	if (ret == 0) {
+		snd_pcm_post_start(substream, SNDRV_PCM_STATE_RUNNING);
+	}
+
+	snd_pcm_stream_unlock(substream);
+
+	return HRTIMER_NORESTART;
+}
+#endif
+
+static int snd_pcm_start_at_system(struct snd_pcm_substream *substream, int clock_type, const struct timespec *start_time)
+{
+#ifdef CONFIG_HIGH_RES_TIMERS
+	struct hrtimer_pcm *pcm_timer;
+	struct timespec now;
+	int ret;
+	clockid_t clock;
+
+	switch (clock_type) {
+	case SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY:
+		clock = CLOCK_REALTIME;
+		getnstimeofday(&now);
+		break;
+	case SNDRV_PCM_STARTAT_CLOCK_TYPE_MONOTONIC:
+		clock = CLOCK_MONOTONIC;
+		ktime_get_ts(&now);
+		break;
+	default: /* unsupported clocks bounce off */
+		return -ENOSYS;
+	}
+
+	/* Check if start_time is in the past */
+	if (timespec_compare(&now, start_time) >= 0) {
+		return -ETIME;
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
+	snd_pcm_start_at_register(substream, clock_type, start_time, pcm_timer);
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
+	struct hrtimer_pcm *pcm_timer = substream->runtime->startat_timer_data;
+	hrtimer_cancel(&pcm_timer->timer); /* Cancel existing timer. (NOP if it's not running) */
+	snd_pcm_start_at_unregister(substream);
+	kfree(pcm_timer);
+	return 0;
+#else
+	return -ENOSYS;
+#endif
+}
+
+static int snd_pcm_start_at_audio(struct snd_pcm_substream *substream, int clock_type, const struct timespec *start_time)
+{
+	if (substream->ops->start_at)
+		return substream->ops->start_at(substream, clock_type, start_time);
+	else
+		return -ENOSYS;
+}
+
+static int snd_pcm_start_at_audio_cancel(struct snd_pcm_substream *substream)
+{
+	if (substream->ops->start_at_abort)
+		return substream->ops->start_at_abort(substream);
+	else
+		return -ENOSYS;
+}
+
+// call this with stream locked
+static int snd_pcm_start_at_cancel(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret = 0;
+
+	if (runtime->startat_timer_running) {
+		switch (runtime->startat_clock_type) {
+		case SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY:
+		case SNDRV_PCM_STARTAT_CLOCK_TYPE_MONOTONIC:
+			ret = snd_pcm_start_at_system_cancel(substream);
+			break;
+		case SNDRV_PCM_STARTAT_CLOCK_TYPE_LINK:
+			ret = snd_pcm_start_at_audio_cancel(substream);
+			break;
+		default:
+			ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+static int snd_pcm_start_at_gettime(struct snd_pcm_substream *substream, int clock_type, struct timespec *current_time)
+{
+	int ret = 0;
+
+	switch (clock_type)
+	{
+	case SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY:
+		getnstimeofday(current_time);
+		break;
+	case SNDRV_PCM_STARTAT_CLOCK_TYPE_MONOTONIC:
+		ktime_get_ts(current_time);
+		break;
+	case SNDRV_PCM_STARTAT_CLOCK_TYPE_LINK:
+		if (substream->ops->start_at_gettime)
+			ret = substream->ops->start_at_gettime(substream, clock_type, current_time);
+		else
+			ret = -ENOSYS;
+		break;
+	default:
+		ret = -EINVAL;
+	}
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
+	snd_pcm_stream_lock(substream);
+
+	switch (start_at.op)
+	{
+	case SNDRV_PCM_STARTAT_OP_SET:
+		if (!timespec_valid(&start_at.args.set.start_time)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		/*  If not a playback substream, give up */
+		if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK) {
+			ret = -EINVAL;
+			break;
+		}
+
+		switch (start_at.args.set.clock_type)
+		{
+		case SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY:
+		case SNDRV_PCM_STARTAT_CLOCK_TYPE_MONOTONIC:
+			ret = snd_pcm_start_at_system(substream,
+				start_at.args.set.clock_type, &start_at.args.set.start_time);
+			break;
+		case SNDRV_PCM_STARTAT_CLOCK_TYPE_LINK:
+			ret = snd_pcm_start_at_audio(substream,
+				start_at.args.set.clock_type, &start_at.args.set.start_time);
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
+	case SNDRV_PCM_STARTAT_OP_CANCEL:
+		ret = snd_pcm_start_at_cancel(substream);
+		break;
+	case SNDRV_PCM_STARTAT_OP_STATUS:
+		ret = snd_pcm_start_at_gettime(substream, start_at.args.status.clock_type, &start_at.args.status.current_time);
+		if (ret == 0)
+			ret = copy_to_user(_start_at, &start_at, sizeof(start_at));
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	snd_pcm_stream_unlock(substream);
+	return ret;
+}
+
 /**
  * snd_pcm_start - start all linked streams
  * @substream: the PCM substream instance
@@ -2184,6 +2442,8 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 	if (substream->ref_count > 0)
 		return;
 
+	snd_pcm_start_at_cancel(substream);
+
 	snd_pcm_drop(substream);
 	if (substream->hw_opened) {
 		if (substream->ops->hw_free != NULL)
@@ -2729,6 +2989,8 @@ static int snd_pcm_common_ioctl1(struct file *file,
 		return snd_pcm_action_lock_irq(&snd_pcm_action_start, substream, SNDRV_PCM_STATE_RUNNING);
 	case SNDRV_PCM_IOCTL_LINK:
 		return snd_pcm_link(substream, (int)(unsigned long) arg);
+	case SNDRV_PCM_IOCTL_START_AT:
+		return snd_pcm_start_at(substream, arg);
 	case SNDRV_PCM_IOCTL_UNLINK:
 		return snd_pcm_unlink(substream);
 	case SNDRV_PCM_IOCTL_RESUME:
-- 
1.9.1
