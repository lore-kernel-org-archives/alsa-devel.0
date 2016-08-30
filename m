From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH v3] ASoC: Remove deprecated create_singlethread_workqueue
Date: Wed, 31 Aug 2016 00:57:09 +0530
Message-ID: <20160830192709.GA16591@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Tejun Heo <tj@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The workqueue "dac33_wq" queues a single work item &dac33->work and hence
doesn't require ordering. Also, it is not being used on a memory reclaim
path. Hence, it has been converted to use system_wq.

The work item has been flushed in dac33_soc_remove to ensure that
there are no pending tasks while disconnecting the driver.

The workqueue "post_msg_wq" queues a single work item
&drv->ipc_post_msg_wq and hence doesn't require ordering. Also, it is
not being used on a memory reclaim path. Hence, it has been converted to
use system_wq.

The work item has been flushed in sst_context_cleanup to ensure that
there are no pending tasks while disconnecting the driver.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 Changes in v3:
	-Added missing '&'

 sound/soc/codecs/tlv320dac33.c | 17 ++++-------------
 sound/soc/intel/atom/sst/sst.c | 14 +++++---------
 2 files changed, 9 insertions(+), 22 deletions(-)

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
diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index a4b458e..1454603 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -76,7 +76,7 @@ static irqreturn_t intel_sst_interrupt_mrfld(int irq, void *context)
 		spin_unlock(&drv->ipc_spin_lock);

 		/* we can send more messages to DSP so trigger work */
-		queue_work(drv->post_msg_wq, &drv->ipc_post_msg_wq);
+		schedule_work(&drv->ipc_post_msg_wq);
 		retval = IRQ_HANDLED;
 	}

@@ -212,10 +212,6 @@ static int sst_workqueue_init(struct intel_sst_drv *ctx)
 	INIT_WORK(&ctx->ipc_post_msg_wq, sst_process_pending_msg);
 	init_waitqueue_head(&ctx->wait_queue);

-	ctx->post_msg_wq =
-		create_singlethread_workqueue("sst_post_msg_wq");
-	if (!ctx->post_msg_wq)
-		return -EBUSY;
 	return 0;
 }

@@ -318,7 +314,6 @@ int sst_context_init(struct intel_sst_drv *ctx)
 	return 0;

 do_free_mem:
-	destroy_workqueue(ctx->post_msg_wq);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sst_context_init);
@@ -330,7 +325,7 @@ void sst_context_cleanup(struct intel_sst_drv *ctx)
 	sst_unregister(ctx->dev);
 	sst_set_fw_state_locked(ctx, SST_SHUTDOWN);
 	flush_scheduled_work();
-	destroy_workqueue(ctx->post_msg_wq);
+	flush_work(&ctx->ipc_post_msg_wq);
 	pm_qos_remove_request(ctx->qos);
 	kfree(ctx->fw_sg_list.src);
 	kfree(ctx->fw_sg_list.dst);
@@ -414,7 +409,7 @@ static int intel_sst_runtime_suspend(struct device *dev)
 	sst_set_fw_state_locked(ctx, SST_RESET);

 	synchronize_irq(ctx->irq_num);
-	flush_workqueue(ctx->post_msg_wq);
+	flush_work(&ctx->ipc_post_msg_wq);

 	ctx->ops->reset(ctx);
 	/* save the shim registers because PMC doesn't save state */
@@ -445,8 +440,9 @@ static int intel_sst_suspend(struct device *dev)
 			return -EBUSY;
 		}
 	}
+
 	synchronize_irq(ctx->irq_num);
-	flush_workqueue(ctx->post_msg_wq);
+	flush_work(&ctx->ipc_post_msg_wq);

 	/* Move the SST state to Reset */
 	sst_set_fw_state_locked(ctx, SST_RESET);
--
2.1.4
