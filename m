From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/9] ASoC: Intel: modularize driver probe and
	remove
Date: Thu, 30 Oct 2014 16:21:48 +0530
Message-ID: <1414666312-4657-6-git-send-email-vinod.koul@intel.com>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BA4D26548E
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:32:42 +0100 (CET)
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

The driver probe which initializes driver and remove which cleans up can be
shared with APCI as well, so move them to common init_context and
cleanup_context routines which can be used by ACPI as well

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |  165 +++++++++++++++++++++++++-------------------
 1 files changed, 94 insertions(+), 71 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index cbbe9a7..e621922 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -243,6 +243,94 @@ int sst_alloc_drv_context(struct intel_sst_drv **ctx,
 	return 0;
 }
 
+int sst_context_init(struct intel_sst_drv *ctx)
+{
+	int ret = 0, i;
+
+	if (!ctx->pdata)
+		return -EINVAL;
+
+	if (!ctx->pdata->probe_data)
+		return -EINVAL;
+
+	memcpy(&ctx->info, ctx->pdata->probe_data, sizeof(ctx->info));
+
+	ret = sst_driver_ops(ctx);
+	if (ret != 0)
+		return -EINVAL;
+
+	sst_init_locks(ctx);
+
+	/* pvt_id 0 reserved for async messages */
+	ctx->pvt_id = 1;
+	ctx->stream_cnt = 0;
+	ctx->fw_in_mem = NULL;
+	/* we use memcpy, so set to 0 */
+	ctx->use_dma = 0;
+	ctx->use_lli = 0;
+
+	if (sst_workqueue_init(ctx))
+		return -EINVAL;
+
+	ctx->mailbox_recv_offset = ctx->pdata->ipc_info->mbox_recv_off;
+	ctx->ipc_reg.ipcx = SST_IPCX + ctx->pdata->ipc_info->ipc_offset;
+	ctx->ipc_reg.ipcd = SST_IPCD + ctx->pdata->ipc_info->ipc_offset;
+
+	dev_info(ctx->dev, "Got drv data max stream %d\n",
+				ctx->info.max_streams);
+
+	for (i = 1; i <= ctx->info.max_streams; i++) {
+		struct stream_info *stream = &ctx->streams[i];
+
+		memset(stream, 0, sizeof(*stream));
+		stream->pipe_id = PIPE_RSVD;
+		mutex_init(&stream->lock);
+	}
+
+	/* Register the ISR */
+	ret = devm_request_threaded_irq(ctx->dev, ctx->irq_num, ctx->ops->interrupt,
+					ctx->ops->irq_thread, 0, SST_DRV_NAME,
+					ctx);
+	if (ret)
+		goto do_free_mem;
+
+	dev_dbg(ctx->dev, "Registered IRQ %#x\n", ctx->irq_num);
+
+	/* default intr are unmasked so set this as masked */
+	sst_shim_write64(ctx->shim, SST_IMRX, 0xFFFF0038);
+
+	ctx->qos = devm_kzalloc(ctx->dev,
+		sizeof(struct pm_qos_request), GFP_KERNEL);
+	if (!ctx->qos) {
+		ret = -ENOMEM;
+		goto do_free_mem;
+	}
+	pm_qos_add_request(ctx->qos, PM_QOS_CPU_DMA_LATENCY,
+				PM_QOS_DEFAULT_VALUE);
+	return 0;
+
+do_free_mem:
+	destroy_workqueue(ctx->post_msg_wq);
+	return ret;
+}
+
+void sst_context_cleanup(struct intel_sst_drv *ctx)
+{
+	pm_runtime_get_noresume(ctx->dev);
+	pm_runtime_forbid(ctx->dev);
+	sst_unregister(ctx->dev);
+	sst_set_fw_state_locked(ctx, SST_SHUTDOWN);
+	flush_scheduled_work();
+	destroy_workqueue(ctx->post_msg_wq);
+	pm_qos_remove_request(ctx->qos);
+	kfree(ctx->fw_sg_list.src);
+	kfree(ctx->fw_sg_list.dst);
+	ctx->fw_sg_list.list_len = 0;
+	kfree(ctx->fw_in_mem);
+	ctx->fw_in_mem = NULL;
+	sst_memcpy_free_resources(ctx);
+	ctx = NULL;
+}
 
 /*
 * intel_sst_probe - PCI probe function
@@ -254,9 +342,8 @@ int sst_alloc_drv_context(struct intel_sst_drv **ctx,
 static int intel_sst_probe(struct pci_dev *pci,
 			const struct pci_device_id *pci_id)
 {
-	int i, ret = 0;
+	int ret = 0;
 	struct intel_sst_drv *sst_drv_ctx;
-	struct intel_sst_ops *ops;
 	struct sst_platform_info *sst_pdata = pci->dev.platform_data;
 	int ddr_base;
 
@@ -266,43 +353,12 @@ static int intel_sst_probe(struct pci_dev *pci,
 	if (ret < 0)
 		return ret;
 
-	if (!sst_pdata)
-		return -EINVAL;
-
 	sst_drv_ctx->pdata = sst_pdata;
-	if (!sst_drv_ctx->pdata->probe_data)
-		return -EINVAL;
-
-	memcpy(&sst_drv_ctx->info, sst_drv_ctx->pdata->probe_data,
-					sizeof(sst_drv_ctx->info));
-
-	if (0 != sst_driver_ops(sst_drv_ctx))
-		return -EINVAL;
-
-	ops = sst_drv_ctx->ops;
-	sst_init_locks(sst_drv_ctx);
-
-	/* pvt_id 0 reserved for async messages */
-	sst_drv_ctx->pvt_id = 1;
-	sst_drv_ctx->stream_cnt = 0;
-	sst_drv_ctx->fw_in_mem = NULL;
-
-	/* we use memcpy, so set to 0 */
-	sst_drv_ctx->use_dma = 0;
-	sst_drv_ctx->use_lli = 0;
-
-	if (sst_workqueue_init(sst_drv_ctx))
-		return -EINVAL;
 
-	dev_info(sst_drv_ctx->dev, "Got drv data max stream %d\n",
-				sst_drv_ctx->info.max_streams);
-	for (i = 1; i <= sst_drv_ctx->info.max_streams; i++) {
-		struct stream_info *stream = &sst_drv_ctx->streams[i];
+	ret = sst_context_init(sst_drv_ctx);
+	if (ret < 0)
+		goto do_free_drv_ctx;
 
-		memset(stream, 0, sizeof(*stream));
-		stream->pipe_id = PIPE_RSVD;
-		mutex_init(&stream->lock);
-	}
 
 	/* Init the device */
 	ret = pcim_enable_device(pci);
@@ -402,18 +458,6 @@ static int intel_sst_probe(struct pci_dev *pci,
 	}
 
 	sst_drv_ctx->irq_num = pci->irq;
-	/* Register the ISR */
-	ret = devm_request_threaded_irq(&pci->dev, pci->irq,
-		sst_drv_ctx->ops->interrupt,
-		sst_drv_ctx->ops->irq_thread, 0, SST_DRV_NAME,
-		sst_drv_ctx);
-	if (ret)
-		goto do_release_regions;
-	dev_dbg(sst_drv_ctx->dev, "Registered IRQ 0x%x\n", pci->irq);
-
-	/* default intr are unmasked so set this as masked */
-	if (sst_drv_ctx->dev_id == SST_MRFLD_PCI_ID)
-		sst_shim_write64(sst_drv_ctx->shim, SST_IMRX, 0xFFFF0038);
 
 	pci_set_drvdata(pci, sst_drv_ctx);
 	pm_runtime_set_autosuspend_delay(sst_drv_ctx->dev, SST_SUSPEND_DELAY);
@@ -421,14 +465,6 @@ static int intel_sst_probe(struct pci_dev *pci,
 	pm_runtime_allow(sst_drv_ctx->dev);
 	pm_runtime_put_noidle(sst_drv_ctx->dev);
 	sst_register(sst_drv_ctx->dev);
-	sst_drv_ctx->qos = devm_kzalloc(&pci->dev,
-		sizeof(struct pm_qos_request), GFP_KERNEL);
-	if (!sst_drv_ctx->qos) {
-		ret = -ENOMEM;
-		goto do_release_regions;
-	}
-	pm_qos_add_request(sst_drv_ctx->qos, PM_QOS_CPU_DMA_LATENCY,
-				PM_QOS_DEFAULT_VALUE);
 
 	return ret;
 
@@ -436,6 +472,7 @@ do_release_regions:
 	pci_release_regions(pci);
 do_free_mem:
 	destroy_workqueue(sst_drv_ctx->post_msg_wq);
+do_free_drv_ctx:
 	dev_err(sst_drv_ctx->dev, "Probe failed with %d\n", ret);
 	return ret;
 }
@@ -452,22 +489,8 @@ static void intel_sst_remove(struct pci_dev *pci)
 {
 	struct intel_sst_drv *sst_drv_ctx = pci_get_drvdata(pci);
 
-	pm_runtime_get_noresume(sst_drv_ctx->dev);
-	pm_runtime_forbid(sst_drv_ctx->dev);
-	sst_unregister(sst_drv_ctx->dev);
+	sst_context_cleanup(sst_drv_ctx);
 	pci_dev_put(sst_drv_ctx->pci);
-	sst_set_fw_state_locked(sst_drv_ctx, SST_SHUTDOWN);
-
-	flush_scheduled_work();
-	destroy_workqueue(sst_drv_ctx->post_msg_wq);
-	pm_qos_remove_request(sst_drv_ctx->qos);
-	kfree(sst_drv_ctx->fw_sg_list.src);
-	kfree(sst_drv_ctx->fw_sg_list.dst);
-	sst_drv_ctx->fw_sg_list.list_len = 0;
-	kfree(sst_drv_ctx->fw_in_mem);
-	sst_drv_ctx->fw_in_mem = NULL;
-	sst_memcpy_free_resources(sst_drv_ctx);
-	sst_drv_ctx = NULL;
 	pci_release_regions(pci);
 	pci_set_drvdata(pci, NULL);
 }
-- 
1.7.0.4
