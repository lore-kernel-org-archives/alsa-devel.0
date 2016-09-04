From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH v4 2/2] ASoC: Intel: Remove deprecated
 create_singlethread_workqueue
Date: Sun, 4 Sep 2016 21:28:31 +0530
Message-ID: <19c71ef6889fa5a09abdea56a4cad083f59b0e64.1473004491.git.bhaktipriya96@gmail.com>
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

The workqueue "post_msg_wq" queues a single work item
&drv->ipc_post_msg_wq and hence doesn't require ordering. Also, it is
not being used on a memory reclaim path. Hence, it has been converted to
use system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

The work item has been flushed in sst_context_cleanup to ensure that
there are no pending tasks while disconnecting the driver.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 Changes in v4:
	-No change content-wise. Split the patch into a patch set.

 sound/soc/intel/atom/sst/sst.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index a4b458e..64d6dee 100644
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
@@ -445,8 +440,8 @@ static int intel_sst_suspend(struct device *dev)
 			return -EBUSY;
 		}
 	}
-	synchronize_irq(ctx->irq_num);
-	flush_workqueue(ctx->post_msg_wq);
+			synchronize_irq(ctx->irq_num);
+			flush_work(ctx->ipc_post_msg_wq);

 	/* Move the SST state to Reset */
 	sst_set_fw_state_locked(ctx, SST_RESET);
--
2.1.4
