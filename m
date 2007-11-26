From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: POSIX clocks and ALSA
Date: Mon, 26 Nov 2007 15:51:02 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711261548040.23163@tm8103.perex-int.cz>
References: <474A763E.7090001@cs.helsinki.fi>
	<Pine.LNX.4.61.0711260848180.7571@tm8103.perex-int.cz>
	<474A9A49.1030208@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E0E9A243B8
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 15:51:04 +0100 (CET)
In-Reply-To: <474A9A49.1030208@cs.helsinki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Heikki Lindholm <holindho@cs.helsinki.fi>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Nov 2007, Heikki Lindholm wrote:

> I had a look at the proposal and the thread at
> http://thread.gmane.org/gmane.linux.alsa.devel/45237/focus=45573

My initial implementation following proposal is bellow for review and 
comments. I also changed timestamps for ALSA timers to use monotonic 
clocks (can be switched back using a module parameter).

					Jaroslav

diff -r 5e8cab953031 core/pcm_lib.c
--- a/core/pcm_lib.c	Mon Nov 26 09:00:56 2007 +0100
+++ b/core/pcm_lib.c	Mon Nov 26 14:50:01 2007 +0100
@@ -188,7 +188,7 @@ static inline int snd_pcm_update_hw_ptr_
 	snd_pcm_sframes_t delta;
 
 	if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_MMAP)
-		getnstimeofday((struct timespec *)&runtime->status->tstamp);
+		snd_pcm_gettime(runtime, (struct timespec *)&runtime->status->tstamp);
 	pos = snd_pcm_update_hw_ptr_pos(substream, runtime);
 	if (pos == SNDRV_PCM_POS_XRUN) {
 		xrun(substream);
diff -r 5e8cab953031 core/pcm_native.c
--- a/core/pcm_native.c	Mon Nov 26 09:00:56 2007 +0100
+++ b/core/pcm_native.c	Mon Nov 26 15:19:22 2007 +0100
@@ -598,9 +598,9 @@ int snd_pcm_status(struct snd_pcm_substr
 		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_MMAP)
 			status->tstamp = runtime->status->tstamp;
 		else
-			getnstimeofday(&status->tstamp);
+			snd_pcm_gettime(runtime, &status->tstamp);
 	} else
-		getnstimeofday(&status->tstamp);
+		snd_pcm_gettime(runtime, &status->tstamp);
 	status->appl_ptr = runtime->control->appl_ptr;
 	status->hw_ptr = runtime->status->hw_ptr;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -688,7 +688,7 @@ static void snd_pcm_trigger_tstamp(struc
 	if (runtime->trigger_master == NULL)
 		return;
 	if (runtime->trigger_master == substream) {
-		getnstimeofday(&runtime->trigger_tstamp);
+		snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
 	} else {
 		snd_pcm_trigger_tstamp(runtime->trigger_master);
 		runtime->trigger_tstamp = runtime->trigger_master->runtime->trigger_tstamp;
@@ -2519,6 +2519,21 @@ static int snd_pcm_sync_ptr(struct snd_p
 		return -EFAULT;
 	return 0;
 }
+
+static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int arg;
+	
+	if (get_user(arg, _arg))
+		return -EFAULT;
+	if (arg < 0 || arg > SNDRV_PCM_TSTAMP_TYPE_LAST)
+		return -EINVAL;
+	runtime->tstamp_type = SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY;
+	if (arg == SNDRV_PCM_TSTAMP_TYPE_MONOTONIC)
+		runtime->tstamp_type = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC;
+	return 0;
+}
 		
 static int snd_pcm_common_ioctl1(struct file *file,
 				 struct snd_pcm_substream *substream,
@@ -2531,8 +2546,8 @@ static int snd_pcm_common_ioctl1(struct 
 		return put_user(SNDRV_PCM_VERSION, (int __user *)arg) ? -EFAULT : 0;
 	case SNDRV_PCM_IOCTL_INFO:
 		return snd_pcm_info_user(substream, arg);
-	case SNDRV_PCM_IOCTL_TSTAMP: /* just for compatibility */
-		return 0;
+	case SNDRV_PCM_IOCTL_TSTAMP:
+		return snd_pcm_tstamp(substream, arg);
 	case SNDRV_PCM_IOCTL_HW_REFINE:
 		return snd_pcm_hw_refine_user(substream, arg);
 	case SNDRV_PCM_IOCTL_HW_PARAMS:
diff -r 5e8cab953031 core/timer.c
--- a/core/timer.c	Mon Nov 26 09:00:56 2007 +0100
+++ b/core/timer.c	Mon Nov 26 14:59:33 2007 +0100
@@ -44,11 +44,14 @@
 #endif
 
 static int timer_limit = DEFAULT_TIMER_LIMIT;
+static int timer_tstamp_monotonic = 1;
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ALSA timer interface");
 MODULE_LICENSE("GPL");
 module_param(timer_limit, int, 0444);
 MODULE_PARM_DESC(timer_limit, "Maximum global timers in system.");
+module_param(timer_tstamp_monotonic, int, 0444);
+MODULE_PARM_DESC(timer_tstamp_monotonic, "Use posix monotonic clock source for timestamps (default).");
 
 struct snd_timer_user {
 	struct snd_timer_instance *timeri;
@@ -381,7 +384,10 @@ static void snd_timer_notify1(struct snd
 	struct snd_timer_instance *ts;
 	struct timespec tstamp;
 
-	getnstimeofday(&tstamp);
+	if (timer_tstamp_monotonic)
+		do_posix_clock_monotonic_gettime(&tstamp);
+	else
+		getnstimeofday(&tstamp);
 	snd_assert(event >= SNDRV_TIMER_EVENT_START &&
 		   event <= SNDRV_TIMER_EVENT_PAUSE, return);
 	if (event == SNDRV_TIMER_EVENT_START ||
@@ -1182,8 +1188,12 @@ static void snd_timer_user_tinterrupt(st
 		spin_unlock(&tu->qlock);
 		return;
 	}
-	if (tu->last_resolution != resolution || ticks > 0)
-		getnstimeofday(&tstamp);
+	if (tu->last_resolution != resolution || ticks > 0) {
+		if (timer_tstamp_monotonic)
+			do_posix_clock_monotonic_gettime(&tstamp);
+		else
+			getnstimeofday(&tstamp);
+	}
 	if ((tu->filter & (1 << SNDRV_TIMER_EVENT_RESOLUTION)) &&
 	    tu->last_resolution != resolution) {
 		r1.event = SNDRV_TIMER_EVENT_RESOLUTION;
diff -r 5e8cab953031 include/asound.h
--- a/include/asound.h	Mon Nov 26 09:00:56 2007 +0100
+++ b/include/asound.h	Mon Nov 26 15:02:57 2007 +0100
@@ -435,6 +435,13 @@ struct snd_xfern {
 };
 
 enum {
+	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
+	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY1,	/* for compatibility, equal to zero */
+	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
+	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,
+};
+
+enum {
 	SNDRV_PCM_IOCTL_PVERSION = _IOR('A', 0x00, int),
 	SNDRV_PCM_IOCTL_INFO = _IOR('A', 0x01, struct snd_pcm_info),
 	SNDRV_PCM_IOCTL_TSTAMP = _IOW('A', 0x02, int),
diff -r 5e8cab953031 include/pcm.h
--- a/include/pcm.h	Mon Nov 26 09:00:56 2007 +0100
+++ b/include/pcm.h	Mon Nov 26 15:20:22 2007 +0100
@@ -323,6 +323,7 @@ struct snd_pcm_runtime {
 
 	/* -- timer -- */
 	unsigned int timer_resolution;	/* timer resolution */
+	int tstamp_type;		/* timestamp type */
 
 	/* -- DMA -- */           
 	unsigned char *dma_area;	/* DMA area */
@@ -952,6 +953,15 @@ void snd_pcm_timer_init(struct snd_pcm_s
 void snd_pcm_timer_init(struct snd_pcm_substream *substream);
 void snd_pcm_timer_done(struct snd_pcm_substream *substream);
 
+static inline void snd_pcm_gettime(struct snd_pcm_runtime *runtime,
+				   struct timespec *tv)
+{
+	if (runtime->tstamp_type == SNDRV_PCM_TSTAMP_TYPE_MONOTONIC)
+		do_posix_clock_monotonic_gettime(tv);
+	else
+		getnstimeofday(tv);
+}
+
 /*
  *  Memory
  */

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
