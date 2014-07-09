From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/7] ASoC: Intel: sst: add power management
	handling
Date: Wed,  9 Jul 2014 14:57:53 +0530
Message-ID: <1404898076-1882-6-git-send-email-vinod.koul@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 05D1E264FF6
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 11:30:24 +0200 (CEST)
In-Reply-To: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch adds the runtime pm handlers and legacy pm handlers for this driver.

The runtime and legacy handlers are quite similar in nature as we follow same
patch for both

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |  126 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 916b38c..cb9863c 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -141,6 +141,47 @@ static irqreturn_t intel_sst_irq_thread_mrfld(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
+static int sst_save_dsp_context_v2(struct intel_sst_drv *sst)
+{
+	unsigned int pvt_id;
+	struct ipc_post *msg = NULL;
+	struct ipc_dsp_hdr dsp_hdr;
+	struct sst_block *block;
+
+	/*send msg to fw*/
+	pvt_id = sst_assign_pvt_id(sst);
+	if (sst_create_block_and_ipc_msg(&msg, true, sst, &block,
+				IPC_CMD, pvt_id)) {
+		pr_err("msg/block alloc failed. Not proceeding with context save\n");
+		return 0;
+	}
+
+	sst_fill_header_mrfld(&msg->mrfld_header, IPC_CMD,
+			      SST_TASK_ID_MEDIA, 1, pvt_id);
+	msg->mrfld_header.p.header_low_payload = sizeof(dsp_hdr);
+	msg->mrfld_header.p.header_high.part.res_rqd = 1;
+	sst_fill_header_dsp(&dsp_hdr, IPC_PREP_D3, PIPE_RSVD, pvt_id);
+	memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
+
+	sst_add_to_dispatch_list_and_post(sst, msg);
+	/*wait for reply*/
+	if (sst_wait_timeout(sst, block)) {
+		pr_err("sst: err fw context save timeout  ...\n");
+		pr_err("not suspending FW!!!");
+		sst_free_block(sst, block);
+		return -EIO;
+	}
+	if (block->ret_code) {
+		pr_err("fw responded w/ error %d", block->ret_code);
+		sst_free_block(sst, block);
+		return -EIO;
+	}
+
+	sst_free_block(sst, block);
+	return 0;
+}
+
+
 static struct intel_sst_ops mrfld_ops = {
 	.interrupt = intel_sst_interrupt_mrfld,
 	.irq_thread = intel_sst_irq_thread_mrfld,
@@ -150,6 +191,7 @@ static struct intel_sst_ops mrfld_ops = {
 	.post_message = sst_post_message_mrfld,
 	.sync_post_message = sst_sync_post_message_mrfld,
 	.process_reply = sst_process_reply_mrfld,
+	.save_dsp_context =  sst_save_dsp_context_v2,
 	.alloc_stream = sst_alloc_stream_mrfld,
 	.post_download = sst_post_download_mrfld,
 };
@@ -423,6 +465,85 @@ static void intel_sst_remove(struct pci_dev *pci)
 	pci_set_drvdata(pci, NULL);
 }
 
+/*
+ * The runtime_suspend/resume is pretty much similar to the legacy
+ * suspend/resume with the noted exception below: The PCI core takes care of
+ * taking the system through D3hot and restoring it back to D0 and so there is
+ * no need to duplicate that here.
+ */
+static int intel_sst_runtime_suspend(struct device *dev)
+{
+	int ret = 0;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	pr_info("runtime_suspend called\n");
+	if (ctx->sst_state == SST_RESET) {
+		pr_debug("LPE is already in RESET state, No action");
+		return 0;
+	}
+	/*save fw context*/
+	if (ctx->ops->save_dsp_context(ctx))
+		return -EBUSY;
+
+	/* Move the SST state to Reset */
+	sst_set_fw_state_locked(ctx, SST_RESET);
+
+	flush_workqueue(ctx->post_msg_wq);
+	synchronize_irq(ctx->irq_num);
+
+	return ret;
+}
+
+static int intel_sst_runtime_resume(struct device *dev)
+{
+	int ret = 0;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	pr_info("runtime_resume called\n");
+
+	/* When fw_clear_cache is set, clear the cached firmware copy */
+	/* fw_clear_cache is set through debugfs support */
+	if (atomic_read(&ctx->fw_clear_cache) && ctx->fw_in_mem) {
+		pr_debug("Clearing the cached firmware\n");
+		kfree(ctx->fw_in_mem);
+		ctx->fw_in_mem = NULL;
+		atomic_set(&ctx->fw_clear_cache, 0);
+	}
+
+	sst_set_fw_state_locked(ctx, SST_RESET);
+
+	return ret;
+}
+
+static int intel_sst_suspend(struct device *dev)
+{
+
+	return intel_sst_runtime_suspend(dev);
+}
+
+static int intel_sst_runtime_idle(struct device *dev)
+{
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	pr_info("runtime_idle called\n");
+	if (ctx->sst_state != SST_RESET) {
+		pm_schedule_suspend(dev, SST_SUSPEND_DELAY);
+		return -EBUSY;
+	} else {
+		return 0;
+	}
+	return -EBUSY;
+
+}
+
+static const struct dev_pm_ops intel_sst_pm = {
+	.suspend = intel_sst_suspend,
+	.resume = intel_sst_runtime_resume,
+	.runtime_suspend = intel_sst_runtime_suspend,
+	.runtime_resume = intel_sst_runtime_resume,
+	.runtime_idle = intel_sst_runtime_idle,
+};
+
 /* PCI Routines */
 static struct pci_device_id intel_sst_ids[] = {
 	{ PCI_VDEVICE(INTEL, SST_MRFLD_PCI_ID), 0},
@@ -434,6 +555,11 @@ static struct pci_driver sst_driver = {
 	.id_table = intel_sst_ids,
 	.probe = intel_sst_probe,
 	.remove = intel_sst_remove,
+#ifdef CONFIG_PM
+	.driver = {
+		.pm = &intel_sst_pm,
+	},
+#endif
 };
 
 module_pci_driver(sst_driver);
-- 
1.7.0.4
