From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ALSA: sh: aica: Convert timers to use timer_setup()
Date: Wed, 4 Oct 2017 17:53:36 -0700
Message-ID: <20171005005336.GA23796@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. This requires adding a pointer to
hold the timer's target substream, as there won't be a way to pass this in
the future.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 sound/sh/aica.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index fdc680ae8aa0..2b26311405a4 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -299,14 +299,14 @@ static void run_spu_dma(struct work_struct *work)
 	}
 }
 
-static void aica_period_elapsed(unsigned long timer_var)
+static void aica_period_elapsed(struct timer_list *t)
 {
+	struct snd_card_aica *dreamcastcard = from_timer(dreamcastcard,
+							      t, timer);
+	struct snd_pcm_substream *substream = dreamcastcard->timer_substream;
 	/*timer function - so cannot sleep */
 	int play_period;
 	struct snd_pcm_runtime *runtime;
-	struct snd_pcm_substream *substream;
-	struct snd_card_aica *dreamcastcard;
-	substream = (struct snd_pcm_substream *) timer_var;
 	runtime = substream->runtime;
 	dreamcastcard = substream->pcm->private_data;
 	/* Have we played out an additional period? */
@@ -336,12 +336,12 @@ static void spu_begin_dma(struct snd_pcm_substream *substream)
 	/*get the queue to do the work */
 	schedule_work(&(dreamcastcard->spu_dma_work));
 	/* Timer may already be running */
-	if (unlikely(dreamcastcard->timer.data)) {
+	if (unlikely(dreamcastcard->timer_substream)) {
 		mod_timer(&dreamcastcard->timer, jiffies + 4);
 		return;
 	}
-	setup_timer(&dreamcastcard->timer, aica_period_elapsed,
-		    (unsigned long) substream);
+	timer_setup(&dreamcastcard->timer, aica_period_elapsed, 0);
+	dreamcastcard->timer_substream = substream;
 	mod_timer(&dreamcastcard->timer, jiffies + 4);
 }
 
@@ -379,7 +379,7 @@ static int snd_aicapcm_pcm_close(struct snd_pcm_substream
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
 	flush_work(&(dreamcastcard->spu_dma_work));
-	if (dreamcastcard->timer.data)
+	if (dreamcastcard->timer_substream)
 		del_timer(&dreamcastcard->timer);
 	kfree(dreamcastcard->channel);
 	spu_disable();
@@ -600,7 +600,7 @@ static int snd_aica_probe(struct platform_device *devptr)
 {
 	int err;
 	struct snd_card_aica *dreamcastcard;
-	dreamcastcard = kmalloc(sizeof(struct snd_card_aica), GFP_KERNEL);
+	dreamcastcard = kzalloc(sizeof(struct snd_card_aica), GFP_KERNEL);
 	if (unlikely(!dreamcastcard))
 		return -ENOMEM;
 	err = snd_card_new(&devptr->dev, index, SND_AICA_DRIVER,
@@ -619,8 +619,6 @@ static int snd_aica_probe(struct platform_device *devptr)
 	err = snd_aicapcmchip(dreamcastcard, 0);
 	if (unlikely(err < 0))
 		goto freedreamcast;
-	dreamcastcard->timer.data = 0;
-	dreamcastcard->channel = NULL;
 	/* Add basic controls */
 	err = add_aicamixer_controls(dreamcastcard);
 	if (unlikely(err < 0))
-- 
2.7.4


-- 
Kees Cook
Pixel Security
