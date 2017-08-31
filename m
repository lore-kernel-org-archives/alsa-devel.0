From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH 23/25] ALSA/dummy: Replace tasklet with softirq hrtimer
Date: Thu, 31 Aug 2017 12:23:45 -0000
Message-ID: <20170831105827.401092373@linutronix.de>
References: <20170831105725.809317030@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=ALSAdummy_Replace_tasklet_with_softirq_hrtimer.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.org>, keescook@chromium.org, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Thomas Gleixner <tglx@linutronix.de>

The tasklet is used to defer the execution of snd_pcm_period_elapsed() to
the softirq context. Using the CLOCK_MONOTONIC_SOFT base invokes the timer
callback in softirq context as well which renders the tasklet useless.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
---
 sound/drivers/dummy.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -376,17 +376,9 @@ struct dummy_hrtimer_pcm {
 	ktime_t period_time;
 	atomic_t running;
 	struct hrtimer timer;
-	struct tasklet_struct tasklet;
 	struct snd_pcm_substream *substream;
 };
 
-static void dummy_hrtimer_pcm_elapsed(unsigned long priv)
-{
-	struct dummy_hrtimer_pcm *dpcm = (struct dummy_hrtimer_pcm *)priv;
-	if (atomic_read(&dpcm->running))
-		snd_pcm_period_elapsed(dpcm->substream);
-}
-
 static enum hrtimer_restart dummy_hrtimer_callback(struct hrtimer *timer)
 {
 	struct dummy_hrtimer_pcm *dpcm;
@@ -394,7 +386,8 @@ static enum hrtimer_restart dummy_hrtime
 	dpcm = container_of(timer, struct dummy_hrtimer_pcm, timer);
 	if (!atomic_read(&dpcm->running))
 		return HRTIMER_NORESTART;
-	tasklet_schedule(&dpcm->tasklet);
+
+	snd_pcm_period_elapsed(dpcm->substream);
 	hrtimer_forward_now(timer, dpcm->period_time);
 	return HRTIMER_RESTART;
 }
@@ -421,7 +414,6 @@ static int dummy_hrtimer_stop(struct snd
 static inline void dummy_hrtimer_sync(struct dummy_hrtimer_pcm *dpcm)
 {
 	hrtimer_cancel(&dpcm->timer);
-	tasklet_kill(&dpcm->tasklet);
 }
 
 static snd_pcm_uframes_t
@@ -466,12 +458,10 @@ static int dummy_hrtimer_create(struct s
 	if (!dpcm)
 		return -ENOMEM;
 	substream->runtime->private_data = dpcm;
-	hrtimer_init(&dpcm->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&dpcm->timer, CLOCK_MONOTONIC_SOFT, HRTIMER_MODE_REL);
 	dpcm->timer.function = dummy_hrtimer_callback;
 	dpcm->substream = substream;
 	atomic_set(&dpcm->running, 0);
-	tasklet_init(&dpcm->tasklet, dummy_hrtimer_pcm_elapsed,
-		     (unsigned long)dpcm);
 	return 0;
 }
 
