From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH v4 34/36] ALSA/dummy: Replace tasklet with
	softirq hrtimer
Date: Thu, 21 Dec 2017 11:42:03 +0100
Message-ID: <20171221104205.7269-35-anna-maria@linutronix.de>
References: <20171221104205.7269-1-anna-maria@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id BA67D266FA1
 for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2017 11:43:25 +0100 (CET)
In-Reply-To: <20171221104205.7269-1-anna-maria@linutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: alsa-devel@alsa-project.org, keescook@chromium.org, Peter Zijlstra <peterz@infradead.org>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Ingo Molnar <mingo@redhat.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

From: Thomas Gleixner <tglx@linutronix.de>

The tasklet is used to defer the execution of snd_pcm_period_elapsed() to
the softirq context. Using the HRTIMER_MODE_SOFT mode invokes the timer
callback in softirq context as well which renders the tasklet useless.

[o-takashi: avoid stall due to a call of hrtimer_cancel() on a callback
            of hrtimer]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>
Link: http://lkml.kernel.org/r/20170905161820.jtysvxtfleunbbmf@breakpoint.cc
---
 sound/drivers/dummy.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 7b2b1f766b00..6ad2ff57833d 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -375,17 +375,9 @@ struct dummy_hrtimer_pcm {
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
@@ -393,7 +385,14 @@ static enum hrtimer_restart dummy_hrtimer_callback(struct hrtimer *timer)
 	dpcm = container_of(timer, struct dummy_hrtimer_pcm, timer);
 	if (!atomic_read(&dpcm->running))
 		return HRTIMER_NORESTART;
-	tasklet_schedule(&dpcm->tasklet);
+	/*
+	 * In cases of XRUN and draining, this calls .trigger to stop PCM
+	 * substream.
+	 */
+	snd_pcm_period_elapsed(dpcm->substream);
+	if (!atomic_read(&dpcm->running))
+		return HRTIMER_NORESTART;
+
 	hrtimer_forward_now(timer, dpcm->period_time);
 	return HRTIMER_RESTART;
 }
@@ -403,7 +402,7 @@ static int dummy_hrtimer_start(struct snd_pcm_substream *substream)
 	struct dummy_hrtimer_pcm *dpcm = substream->runtime->private_data;
 
 	dpcm->base_time = hrtimer_cb_get_time(&dpcm->timer);
-	hrtimer_start(&dpcm->timer, dpcm->period_time, HRTIMER_MODE_REL);
+	hrtimer_start(&dpcm->timer, dpcm->period_time, HRTIMER_MODE_REL_SOFT);
 	atomic_set(&dpcm->running, 1);
 	return 0;
 }
@@ -413,14 +412,14 @@ static int dummy_hrtimer_stop(struct snd_pcm_substream *substream)
 	struct dummy_hrtimer_pcm *dpcm = substream->runtime->private_data;
 
 	atomic_set(&dpcm->running, 0);
-	hrtimer_cancel(&dpcm->timer);
+	if (!hrtimer_callback_running(&dpcm->timer))
+		hrtimer_cancel(&dpcm->timer);
 	return 0;
 }
 
 static inline void dummy_hrtimer_sync(struct dummy_hrtimer_pcm *dpcm)
 {
 	hrtimer_cancel(&dpcm->timer);
-	tasklet_kill(&dpcm->tasklet);
 }
 
 static snd_pcm_uframes_t
@@ -465,12 +464,10 @@ static int dummy_hrtimer_create(struct snd_pcm_substream *substream)
 	if (!dpcm)
 		return -ENOMEM;
 	substream->runtime->private_data = dpcm;
-	hrtimer_init(&dpcm->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&dpcm->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dpcm->timer.function = dummy_hrtimer_callback;
 	dpcm->substream = substream;
 	atomic_set(&dpcm->running, 0);
-	tasklet_init(&dpcm->tasklet, dummy_hrtimer_pcm_elapsed,
-		     (unsigned long)dpcm);
 	return 0;
 }
 
-- 
2.11.0
