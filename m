From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/9] ASoC: Intel: move the driver wq init to a
	routine
Date: Thu, 30 Oct 2014 16:21:45 +0530
Message-ID: <1414666312-4657-3-git-send-email-vinod.koul@intel.com>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E0AF02605DF
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:32:34 +0100 (CET)
In-Reply-To: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

This will be used by APCI code as well, so moving to common routine helps

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index ff0ff9f..253b917 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -206,6 +206,22 @@ void sst_process_pending_msg(struct work_struct *work)
 	ctx->ops->post_message(ctx, NULL, false);
 }
 
+static int sst_workqueue_init(struct intel_sst_drv *ctx)
+{
+	INIT_LIST_HEAD(&ctx->memcpy_list);
+	INIT_LIST_HEAD(&ctx->rx_list);
+	INIT_LIST_HEAD(&ctx->ipc_dispatch_list);
+	INIT_LIST_HEAD(&ctx->block_list);
+	INIT_WORK(&ctx->ipc_post_msg_wq, sst_process_pending_msg);
+	init_waitqueue_head(&ctx->wait_queue);
+
+	ctx->post_msg_wq =
+		create_singlethread_workqueue("sst_post_msg_wq");
+	if (!ctx->post_msg_wq)
+		return -EBUSY;
+	return 0;
+}
+
 /*
 * intel_sst_probe - PCI probe function
 *
@@ -254,24 +270,13 @@ static int intel_sst_probe(struct pci_dev *pci,
 	sst_drv_ctx->use_dma = 0;
 	sst_drv_ctx->use_lli = 0;
 
-	INIT_LIST_HEAD(&sst_drv_ctx->memcpy_list);
-	INIT_LIST_HEAD(&sst_drv_ctx->ipc_dispatch_list);
-	INIT_LIST_HEAD(&sst_drv_ctx->block_list);
-	INIT_LIST_HEAD(&sst_drv_ctx->rx_list);
-
-	sst_drv_ctx->post_msg_wq =
-		create_singlethread_workqueue("sst_post_msg_wq");
-	if (!sst_drv_ctx->post_msg_wq) {
-		ret = -EINVAL;
-		goto do_free_drv_ctx;
-	}
-	INIT_WORK(&sst_drv_ctx->ipc_post_msg_wq, sst_process_pending_msg);
-	init_waitqueue_head(&sst_drv_ctx->wait_queue);
-
 	spin_lock_init(&sst_drv_ctx->ipc_spin_lock);
 	spin_lock_init(&sst_drv_ctx->block_lock);
 	spin_lock_init(&sst_drv_ctx->rx_msg_lock);
 
+	if (sst_workqueue_init(sst_drv_ctx))
+		return -EINVAL;
+
 	dev_info(sst_drv_ctx->dev, "Got drv data max stream %d\n",
 				sst_drv_ctx->info.max_streams);
 	for (i = 1; i <= sst_drv_ctx->info.max_streams; i++) {
@@ -414,7 +419,6 @@ do_release_regions:
 	pci_release_regions(pci);
 do_free_mem:
 	destroy_workqueue(sst_drv_ctx->post_msg_wq);
-do_free_drv_ctx:
 	dev_err(sst_drv_ctx->dev, "Probe failed with %d\n", ret);
 	return ret;
 }
-- 
1.7.0.4
