From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH v4 1/2] ASoC: tlv320dac33: Remove deprecated
 create_singlethread_workqueue
Date: Sun, 4 Sep 2016 21:27:32 +0530
Message-ID: <26fb1f9d167bb4f3755fabaaa2a00562b49b41d4.1473004491.git.bhaktipriya96@gmail.com>
References: <cover.1473004491.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1473004491.git.bhaktipriya96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The workqueue "dac33_wq" queues a single work item &dac33->work and
hence doesn't require ordering. Also, it is not being used on a memory
reclaim path. Hence, it has been converted to use system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

The work item has been flushed in dac33_soc_remove to ensure that
there are no pending tasks while disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 Changes in v4:
	-No change. Split the patch into a patch set.

 sound/soc/codecs/tlv320dac33.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index f7a6ce7..6822ac1 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -90,7 +90,6 @@ static const char *dac33_supply_names[DAC33_NUM_SUPPLIES] = {

 struct tlv320dac33_priv {
 	struct mutex mutex;
-	struct workqueue_struct *dac33_wq;
 	struct work_struct work;
 	struct snd_soc_codec *codec;
 	struct regulator_bulk_data supplies[DAC33_NUM_SUPPLIES];
@@ -771,7 +770,7 @@ static irqreturn_t dac33_interrupt_handler(int irq, void *dev)

 	/* Do not schedule the workqueue in Mode7 */
 	if (dac33->fifo_mode != DAC33_FIFO_MODE7)
-		queue_work(dac33->dac33_wq, &dac33->work);
+		schedule_work(&dac33->work);

 	return IRQ_HANDLED;
 }
@@ -1127,7 +1126,7 @@ static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (dac33->fifo_mode) {
 			dac33->state = DAC33_PREFILL;
-			queue_work(dac33->dac33_wq, &dac33->work);
+			schedule_work(&dac33->work);
 		}
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -1135,7 +1134,7 @@ static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (dac33->fifo_mode) {
 			dac33->state = DAC33_FLUSH;
-			queue_work(dac33->dac33_wq, &dac33->work);
+			schedule_work(&dac33->work);
 		}
 		break;
 	default:
@@ -1410,14 +1409,6 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 			dac33->irq = -1;
 		}
 		if (dac33->irq != -1) {
-			/* Setup work queue */
-			dac33->dac33_wq =
-				create_singlethread_workqueue("tlv320dac33");
-			if (dac33->dac33_wq == NULL) {
-				free_irq(dac33->irq, codec);
-				return -ENOMEM;
-			}
-
 			INIT_WORK(&dac33->work, dac33_work);
 		}
 	}
@@ -1437,7 +1428,7 @@ static int dac33_soc_remove(struct snd_soc_codec *codec)

 	if (dac33->irq >= 0) {
 		free_irq(dac33->irq, dac33->codec);
-		destroy_workqueue(dac33->dac33_wq);
+		flush_work(&dac33->work);
 	}
 	return 0;
 }
--
2.1.4
