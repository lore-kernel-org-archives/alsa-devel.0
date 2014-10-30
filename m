From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: sst: add runtime power
	management handling
Date: Thu, 30 Oct 2014 10:38:55 +0530
Message-ID: <1414645736-24426-3-git-send-email-vinod.koul@intel.com>
References: <1414645736-24426-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 93E5F260617
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 06:49:37 +0100 (CET)
In-Reply-To: <1414645736-24426-1-git-send-email-vinod.koul@intel.com>
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

This patch adds the runtime pm handlers, the driver already has code for
get/put for runtiem pm and only these handlers being missing.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |   73 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index fa34217..8eb7148 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -152,6 +152,23 @@ static irqreturn_t intel_sst_irq_thread_mrfld(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
+static int sst_save_dsp_context_v2(struct intel_sst_drv *sst)
+{
+	int ret = 0;
+
+	ret = sst_prepare_and_post_msg(sst, SST_TASK_ID_MEDIA, IPC_CMD,
+			IPC_PREP_D3, PIPE_RSVD, 0, NULL, NULL,
+			true, true, false, true);
+
+	if (ret < 0) {
+		dev_err(sst->dev, "not suspending FW!!!");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+
 static struct intel_sst_ops mrfld_ops = {
 	.interrupt = intel_sst_interrupt_mrfld,
 	.irq_thread = intel_sst_irq_thread_mrfld,
@@ -160,6 +177,7 @@ static struct intel_sst_ops mrfld_ops = {
 	.reset = intel_sst_reset_dsp_mrfld,
 	.post_message = sst_post_message_mrfld,
 	.process_reply = sst_process_reply_mrfld,
+	.save_dsp_context =  sst_save_dsp_context_v2,
 	.alloc_stream = sst_alloc_stream_mrfld,
 	.post_download = sst_post_download_mrfld,
 };
@@ -418,7 +436,55 @@ static void intel_sst_remove(struct pci_dev *pci)
 	pci_set_drvdata(pci, NULL);
 }
 
-/* PCI Routines */
+static int intel_sst_runtime_suspend(struct device *dev)
+{
+	int ret = 0;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	dev_info(dev, "runtime_suspend called\n");
+	if (ctx->sst_state == SST_RESET) {
+		dev_dbg(dev, "LPE is already in RESET state, No action");
+		return 0;
+	}
+	/*save fw context*/
+	if (ctx->ops->save_dsp_context(ctx))
+		return -EBUSY;
+
+	/* Move the SST state to Reset */
+	sst_set_fw_state_locked(ctx, SST_RESET);
+
+	synchronize_irq(ctx->irq_num);
+	flush_workqueue(ctx->post_msg_wq);
+
+	return ret;
+}
+
+static int intel_sst_runtime_resume(struct device *dev)
+{
+	int ret = 0;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	dev_info(dev, "runtime_resume called\n");
+
+	mutex_lock(&ctx->sst_lock);
+	if (ctx->sst_state == SST_RESET) {
+		dev_dbg(dev, "DSP Downloading FW now...\n");
+		ret = sst_load_fw(ctx);
+		if (ret) {
+			dev_err(dev, "FW download fail %x\n", ret);
+			ctx->sst_state = SST_RESET;
+		}
+	}
+	mutex_unlock(&ctx->sst_lock);
+	return ret;
+}
+
+static const struct dev_pm_ops intel_sst_pm = {
+	.runtime_suspend = intel_sst_runtime_suspend,
+	.runtime_resume = intel_sst_runtime_resume,
+};
+
+/*PCI Routines*/
 static struct pci_device_id intel_sst_ids[] = {
 	{ PCI_VDEVICE(INTEL, SST_MRFLD_PCI_ID), 0},
 	{ 0, }
@@ -429,6 +495,11 @@ static struct pci_driver sst_driver = {
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
