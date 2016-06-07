From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH] ALSA: sh: aica: Remove deprecated create_workqueue
Date: Tue, 7 Jun 2016 09:11:48 +0530
Message-ID: <20160607034147.GA17188@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

System workqueues have been able to handle high level of concurrency
for a long time now and there's no reason to use dedicated workqueues
just to gain concurrency. Since aica_queue for AICA sound
driver has workitem dreamcastcard->spu_dma_work (maps to run_spu_dma)
which is involved in aica dma transfers and is not being used on a memory
reclaim path, dedicated aica_queue has been replaced with the
use of system_wq.

Unlike a dedicated per-cpu workqueue created with create_workqueue(),
system_wq allows multiple work items to overlap executions even on
the same CPU; however, a per-cpu workqueue doesn't have any CPU
locality or global ordering guarantees unless the target CPU is
explicitly specified and thus the increase of local concurrency
shouldn't make any difference.

Since the work items could be pending, flush_work() has been used in
snd_aicapcm_pcm_close() to ensure that there is no pending task while
disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 sound/sh/aica.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index ad3d9ae..fbbc252 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -63,9 +63,6 @@ MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
 module_param(enable, bool, 0644);
 MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");

-/* Use workqueue */
-static struct workqueue_struct *aica_queue;
-
 /* Simple platform device */
 static struct platform_device *pd;
 static struct resource aica_memory_space[2] = {
@@ -327,7 +324,7 @@ static void aica_period_elapsed(unsigned long timer_var)
 		dreamcastcard->current_period = play_period;
 	if (unlikely(dreamcastcard->dma_check == 0))
 		dreamcastcard->dma_check = 1;
-	queue_work(aica_queue, &(dreamcastcard->spu_dma_work));
+	schedule_work(&(dreamcastcard->spu_dma_work));
 }

 static void spu_begin_dma(struct snd_pcm_substream *substream)
@@ -337,7 +334,7 @@ static void spu_begin_dma(struct snd_pcm_substream *substream)
 	runtime = substream->runtime;
 	dreamcastcard = substream->pcm->private_data;
 	/*get the queue to do the work */
-	queue_work(aica_queue, &(dreamcastcard->spu_dma_work));
+	schedule_work(&(dreamcastcard->spu_dma_work));
 	/* Timer may already be running */
 	if (unlikely(dreamcastcard->timer.data)) {
 		mod_timer(&dreamcastcard->timer, jiffies + 4);
@@ -381,7 +378,7 @@ static int snd_aicapcm_pcm_close(struct snd_pcm_substream
 				 *substream)
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
-	flush_workqueue(aica_queue);
+	flush_work(&(dreamcastcard->spu_dma_work));
 	if (dreamcastcard->timer.data)
 		del_timer(&dreamcastcard->timer);
 	kfree(dreamcastcard->channel);
@@ -633,9 +630,6 @@ static int snd_aica_probe(struct platform_device *devptr)
 	if (unlikely(err < 0))
 		goto freedreamcast;
 	platform_set_drvdata(devptr, dreamcastcard);
-	aica_queue = create_workqueue(CARD_NAME);
-	if (unlikely(!aica_queue))
-		goto freedreamcast;
 	snd_printk
 	    ("ALSA Driver for Yamaha AICA Super Intelligent Sound Processor\n");
 	return 0;
@@ -671,10 +665,6 @@ static int __init aica_init(void)

 static void __exit aica_exit(void)
 {
-	/* Destroy the aica kernel thread            *
-	 * being extra cautious to check if it exists*/
-	if (likely(aica_queue))
-		destroy_workqueue(aica_queue);
 	platform_device_unregister(pd);
 	platform_driver_unregister(&snd_aica_driver);
 	/* Kill any sound still playing and reset ARM7 to safe state */
