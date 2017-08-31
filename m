From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 23/25] ALSA/dummy: Replace tasklet with
	softirq hrtimer
Date: Thu, 31 Aug 2017 23:21:17 +0900
Message-ID: <20170831142117.4131-1-o-takashi@sakamocchi.jp>
References: <20170831105827.401092373@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id AB9802673BA
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 16:21:22 +0200 (CEST)
In-Reply-To: <20170831105827.401092373@linutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz, anna-maria@linutronix.de
Cc: alsa-devel@alsa-project.org, keescook@chromium.org, peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, john.stultz@linaro.org, tglx@linutronix.de, hch@lst.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Aug 31 2017 21:23, Anna-Maria Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The tasklet is used to defer the execution of snd_pcm_period_elapsed() to
> the softirq context. Using the CLOCK_MONOTONIC_SOFT base invokes the timer
> callback in softirq context as well which renders the tasklet useless.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Cc: alsa-devel@alsa-project.org
> ---
>  sound/drivers/dummy.c |   16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

I prefer this patch as long as this driver can still receive callbacks
from hrtimer subsystem.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Unfortunately, I have too poor machine to compile whole kernel now, thus
didn't do any tests, sorry.

I note that ALSA pcsp driver uses a combination of hrtimer/tasklet for the
same purpose. I think we can simplify it, too. Please refer to a patch in
the end of this message. (But not tested yet for the above reason...)

> --- a/sound/drivers/dummy.c
> +++ b/sound/drivers/dummy.c
> @@ -376,17 +376,9 @@ struct dummy_hrtimer_pcm {
>  	ktime_t period_time;
>  	atomic_t running;
>  	struct hrtimer timer;
> -	struct tasklet_struct tasklet;
>  	struct snd_pcm_substream *substream;
>  };
>  
> -static void dummy_hrtimer_pcm_elapsed(unsigned long priv)
> -{
> -	struct dummy_hrtimer_pcm *dpcm = (struct dummy_hrtimer_pcm *)priv;
> -	if (atomic_read(&dpcm->running))
> -		snd_pcm_period_elapsed(dpcm->substream);
> -}
> -
>  static enum hrtimer_restart dummy_hrtimer_callback(struct hrtimer *timer)
>  {
>  	struct dummy_hrtimer_pcm *dpcm;
> @@ -394,7 +386,8 @@ static enum hrtimer_restart dummy_hrtime
>  	dpcm = container_of(timer, struct dummy_hrtimer_pcm, timer);
>  	if (!atomic_read(&dpcm->running))
>  		return HRTIMER_NORESTART;
> -	tasklet_schedule(&dpcm->tasklet);
> +
> +	snd_pcm_period_elapsed(dpcm->substream);
>  	hrtimer_forward_now(timer, dpcm->period_time);
>  	return HRTIMER_RESTART;
>  }
> @@ -421,7 +414,6 @@ static int dummy_hrtimer_stop(struct snd
>  static inline void dummy_hrtimer_sync(struct dummy_hrtimer_pcm *dpcm)
>  {
>  	hrtimer_cancel(&dpcm->timer);
> -	tasklet_kill(&dpcm->tasklet);
>  }
>  
>  static snd_pcm_uframes_t
> @@ -466,12 +458,10 @@ static int dummy_hrtimer_create(struct s
>  	if (!dpcm)
>  		return -ENOMEM;
>  	substream->runtime->private_data = dpcm;
> -	hrtimer_init(&dpcm->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(&dpcm->timer, CLOCK_MONOTONIC_SOFT, HRTIMER_MODE_REL);
>  	dpcm->timer.function = dummy_hrtimer_callback;
>  	dpcm->substream = substream;
>  	atomic_set(&dpcm->running, 0);
> -	tasklet_init(&dpcm->tasklet, dummy_hrtimer_pcm_elapsed,
> -		     (unsigned long)dpcm);
>  	return 0;
>  }

>From b2417f83e0ccbdfe1fc6870817ff0a1bd9243c77 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Thu, 31 Aug 2017 22:52:33 +0900
Subject: [PATCH] ALSA: pcsp: code optimization for hrtimer in software IRQ
 context

In a development period for v4.14, code refactoring was done for hrtimer
subsystem. This enables to receive callbacks from hrtimer in software IRQ
context.

Currently, ALSA pcsp driver uses hrtimer callback to handle period elapse
of PCM buffer and actual calculation of pointer position is done in
software IRQ context of tasklet. This can be simplified to the introduced
hrtimer in software IRQ context.

This commit applies an optimization for the above reason.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/drivers/pcsp/pcsp.c     |  2 +-
 sound/drivers/pcsp/pcsp_lib.c | 24 +++++-------------------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 0dd3f46eb03e..8fac38b81c4f 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -100,7 +100,7 @@ static int snd_card_pcsp_probe(int devnum, struct device *dev)
 	if (devnum != 0)
 		return -EINVAL;
 
-	hrtimer_init(&pcsp_chip.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&pcsp_chip.timer, CLOCK_MONOTONIC_SOFT, HRTIMER_MODE_REL);
 	pcsp_chip.timer.function = pcsp_do_timer;
 
 	err = snd_card_new(dev, index, id, THIS_MODULE, 0, &card);
diff --git a/sound/drivers/pcsp/pcsp_lib.c b/sound/drivers/pcsp/pcsp_lib.c
index 2f5a35f38ce1..d2b67463ddd3 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -21,22 +21,6 @@ MODULE_PARM_DESC(nforce_wa, "Apply NForce chipset workaround "
 
 #define DMIX_WANTS_S16	1
 
-/*
- * Call snd_pcm_period_elapsed in a tasklet
- * This avoids spinlock messes and long-running irq contexts
- */
-static void pcsp_call_pcm_elapsed(unsigned long priv)
-{
-	if (atomic_read(&pcsp_chip.timer_active)) {
-		struct snd_pcm_substream *substream;
-		substream = pcsp_chip.playback_substream;
-		if (substream)
-			snd_pcm_period_elapsed(substream);
-	}
-}
-
-static DECLARE_TASKLET(pcsp_pcm_tasklet, pcsp_call_pcm_elapsed, 0);
-
 /* write the port and returns the next expire time in ns;
  * called at the trigger-start and in hrtimer callback
  */
@@ -121,8 +105,11 @@ static void pcsp_pointer_update(struct snd_pcsp *chip)
 	}
 	spin_unlock_irqrestore(&chip->substream_lock, flags);
 
-	if (periods_elapsed)
-		tasklet_schedule(&pcsp_pcm_tasklet);
+	if (!periods_elapsed)
+		return;
+
+	if (atomic_read(&pcsp_chip.timer_active))
+		snd_pcm_period_elapsed(substream);
 }
 
 enum hrtimer_restart pcsp_do_timer(struct hrtimer *handle)
@@ -195,7 +182,6 @@ void pcsp_sync_stop(struct snd_pcsp *chip)
 	pcsp_stop_playing(chip);
 	local_irq_enable();
 	hrtimer_cancel(&chip->timer);
-	tasklet_kill(&pcsp_pcm_tasklet);
 }
 
 static int snd_pcsp_playback_close(struct snd_pcm_substream *substream)
-- 
2.11.0
