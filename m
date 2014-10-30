From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/9] ASoC: Intel: more probe modularization for
	sst
Date: Thu, 30 Oct 2014 16:21:49 +0530
Message-ID: <1414666312-4657-7-git-send-email-vinod.koul@intel.com>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DE3BF26549D
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:32:44 +0100 (CET)
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

Move the PCI bar and resource initialization to a separate routine

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |  158 ++++++++++++++++++++++++--------------------
 1 files changed, 86 insertions(+), 72 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index e621922..ad16101 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -332,114 +332,132 @@ void sst_context_cleanup(struct intel_sst_drv *ctx)
 	ctx = NULL;
 }
 
-/*
-* intel_sst_probe - PCI probe function
-*
-* @pci:	PCI device structure
-* @pci_id: PCI device ID structure
-*
-*/
-static int intel_sst_probe(struct pci_dev *pci,
-			const struct pci_device_id *pci_id)
+void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
 {
-	int ret = 0;
-	struct intel_sst_drv *sst_drv_ctx;
-	struct sst_platform_info *sst_pdata = pci->dev.platform_data;
-	int ddr_base;
-
-	dev_dbg(&pci->dev, "Probe for DID %x\n", pci->device);
-
-	ret = sst_alloc_drv_context(&sst_drv_ctx, &pci->dev, pci->device);
-	if (ret < 0)
-		return ret;
-
-	sst_drv_ctx->pdata = sst_pdata;
-
-	ret = sst_context_init(sst_drv_ctx);
-	if (ret < 0)
-		goto do_free_drv_ctx;
-
+	pm_runtime_set_autosuspend_delay(ctx->dev, SST_SUSPEND_DELAY);
+	pm_runtime_use_autosuspend(ctx->dev);
+	pm_runtime_allow(ctx->dev);
+	pm_runtime_put_noidle(ctx->dev);
+}
 
-	/* Init the device */
-	ret = pcim_enable_device(pci);
-	if (ret) {
-		dev_err(sst_drv_ctx->dev,
-			"device can't be enabled. Returned err: %d\n", ret);
-		goto do_free_mem;
-	}
-	sst_drv_ctx->pci = pci_dev_get(pci);
+static int sst_platform_get_resources(struct intel_sst_drv *ctx)
+{
+	int ddr_base, ret = 0;
+	struct pci_dev *pci = ctx->pci;
 	ret = pci_request_regions(pci, SST_DRV_NAME);
 	if (ret)
-		goto do_free_mem;
+		return ret;
 
 	/* map registers */
 	/* DDR base */
-	if (sst_drv_ctx->dev_id == SST_MRFLD_PCI_ID) {
-		sst_drv_ctx->ddr_base = pci_resource_start(pci, 0);
+	if (ctx->dev_id == SST_MRFLD_PCI_ID) {
+		ctx->ddr_base = pci_resource_start(pci, 0);
 		/* check that the relocated IMR base matches with FW Binary */
-		ddr_base = relocate_imr_addr_mrfld(sst_drv_ctx->ddr_base);
-		if (!sst_drv_ctx->pdata->lib_info) {
-			dev_err(sst_drv_ctx->dev, "lib_info pointer NULL\n");
+		ddr_base = relocate_imr_addr_mrfld(ctx->ddr_base);
+		if (!ctx->pdata->lib_info) {
+			dev_err(ctx->dev, "lib_info pointer NULL\n");
 			ret = -EINVAL;
 			goto do_release_regions;
 		}
-		if (ddr_base != sst_drv_ctx->pdata->lib_info->mod_base) {
-			dev_err(sst_drv_ctx->dev,
+		if (ddr_base != ctx->pdata->lib_info->mod_base) {
+			dev_err(ctx->dev,
 					"FW LSP DDR BASE does not match with IFWI\n");
 			ret = -EINVAL;
 			goto do_release_regions;
 		}
-		sst_drv_ctx->ddr_end = pci_resource_end(pci, 0);
+		ctx->ddr_end = pci_resource_end(pci, 0);
 
-		sst_drv_ctx->ddr = pcim_iomap(pci, 0,
+		ctx->ddr = pcim_iomap(pci, 0,
 					pci_resource_len(pci, 0));
-		if (!sst_drv_ctx->ddr) {
+		if (!ctx->ddr) {
 			ret = -EINVAL;
 			goto do_release_regions;
 		}
-		dev_dbg(sst_drv_ctx->dev, "sst: DDR Ptr %p\n", sst_drv_ctx->ddr);
+		dev_dbg(ctx->dev, "sst: DDR Ptr %p\n", ctx->ddr);
 	} else {
-		sst_drv_ctx->ddr = NULL;
+		ctx->ddr = NULL;
 	}
-
 	/* SHIM */
-	sst_drv_ctx->shim_phy_add = pci_resource_start(pci, 1);
-	sst_drv_ctx->shim = pcim_iomap(pci, 1, pci_resource_len(pci, 1));
-	if (!sst_drv_ctx->shim) {
+	ctx->shim_phy_add = pci_resource_start(pci, 1);
+	ctx->shim = pcim_iomap(pci, 1, pci_resource_len(pci, 1));
+	if (!ctx->shim) {
 		ret = -EINVAL;
 		goto do_release_regions;
 	}
-	dev_dbg(sst_drv_ctx->dev, "SST Shim Ptr %p\n", sst_drv_ctx->shim);
+	dev_dbg(ctx->dev, "SST Shim Ptr %p\n", ctx->shim);
 
 	/* Shared SRAM */
-	sst_drv_ctx->mailbox_add = pci_resource_start(pci, 2);
-	sst_drv_ctx->mailbox = pcim_iomap(pci, 2, pci_resource_len(pci, 2));
-	if (!sst_drv_ctx->mailbox) {
+	ctx->mailbox_add = pci_resource_start(pci, 2);
+	ctx->mailbox = pcim_iomap(pci, 2, pci_resource_len(pci, 2));
+	if (!ctx->mailbox) {
 		ret = -EINVAL;
 		goto do_release_regions;
 	}
-	dev_dbg(sst_drv_ctx->dev, "SRAM Ptr %p\n", sst_drv_ctx->mailbox);
+	dev_dbg(ctx->dev, "SRAM Ptr %p\n", ctx->mailbox);
 
 	/* IRAM */
-	sst_drv_ctx->iram_end = pci_resource_end(pci, 3);
-	sst_drv_ctx->iram_base = pci_resource_start(pci, 3);
-	sst_drv_ctx->iram = pcim_iomap(pci, 3, pci_resource_len(pci, 3));
-	if (!sst_drv_ctx->iram) {
+	ctx->iram_end = pci_resource_end(pci, 3);
+	ctx->iram_base = pci_resource_start(pci, 3);
+	ctx->iram = pcim_iomap(pci, 3, pci_resource_len(pci, 3));
+	if (!ctx->iram) {
 		ret = -EINVAL;
 		goto do_release_regions;
 	}
-	dev_dbg(sst_drv_ctx->dev, "IRAM Ptr %p\n", sst_drv_ctx->iram);
+	dev_dbg(ctx->dev, "IRAM Ptr %p\n", ctx->iram);
 
 	/* DRAM */
-	sst_drv_ctx->dram_end = pci_resource_end(pci, 4);
-	sst_drv_ctx->dram_base = pci_resource_start(pci, 4);
-	sst_drv_ctx->dram = pcim_iomap(pci, 4, pci_resource_len(pci, 4));
-	if (!sst_drv_ctx->dram) {
+	ctx->dram_end = pci_resource_end(pci, 4);
+	ctx->dram_base = pci_resource_start(pci, 4);
+	ctx->dram = pcim_iomap(pci, 4, pci_resource_len(pci, 4));
+	if (!ctx->dram) {
 		ret = -EINVAL;
 		goto do_release_regions;
 	}
-	dev_dbg(sst_drv_ctx->dev, "DRAM Ptr %p\n", sst_drv_ctx->dram);
+	dev_dbg(ctx->dev, "DRAM Ptr %p\n", ctx->dram);
+do_release_regions:
+	pci_release_regions(pci);
+	return 0;
+}
+/*
+* intel_sst_probe - PCI probe function
+*
+* @pci:	PCI device structure
+* @pci_id: PCI device ID structure
+*
+*/
+static int intel_sst_probe(struct pci_dev *pci,
+			const struct pci_device_id *pci_id)
+{
+	int ret = 0;
+	struct intel_sst_drv *sst_drv_ctx;
+	struct sst_platform_info *sst_pdata = pci->dev.platform_data;
+
+	dev_dbg(&pci->dev, "Probe for DID %x\n", pci->device);
+
+	ret = sst_alloc_drv_context(&sst_drv_ctx, &pci->dev, pci->device);
+	if (ret < 0)
+		return ret;
+
+	sst_drv_ctx->pdata = sst_pdata;
+	sst_drv_ctx->irq_num = pci->irq;
+
+	ret = sst_context_init(sst_drv_ctx);
+	if (ret < 0)
+		goto do_free_drv_ctx;
+
+
+	/* Init the device */
+	ret = pcim_enable_device(pci);
+	if (ret) {
+		dev_err(sst_drv_ctx->dev,
+			"device can't be enabled. Returned err: %d\n", ret);
+		goto do_destroy_wq;
+	}
+	sst_drv_ctx->pci = pci_dev_get(pci);
 
+	ret = sst_platform_get_resources(sst_drv_ctx);
+	if (ret < 0)
+		goto do_destroy_wq;
 
 	sst_set_fw_state_locked(sst_drv_ctx, SST_RESET);
 	snprintf(sst_drv_ctx->firmware_name, sizeof(sst_drv_ctx->firmware_name),
@@ -457,20 +475,16 @@ static int intel_sst_probe(struct pci_dev *pci,
 		goto do_release_regions;
 	}
 
-	sst_drv_ctx->irq_num = pci->irq;
 
 	pci_set_drvdata(pci, sst_drv_ctx);
-	pm_runtime_set_autosuspend_delay(sst_drv_ctx->dev, SST_SUSPEND_DELAY);
-	pm_runtime_use_autosuspend(sst_drv_ctx->dev);
-	pm_runtime_allow(sst_drv_ctx->dev);
-	pm_runtime_put_noidle(sst_drv_ctx->dev);
+	sst_configure_runtime_pm(sst_drv_ctx);
 	sst_register(sst_drv_ctx->dev);
 
 	return ret;
 
 do_release_regions:
 	pci_release_regions(pci);
-do_free_mem:
+do_destroy_wq:
 	destroy_workqueue(sst_drv_ctx->post_msg_wq);
 do_free_drv_ctx:
 	dev_err(sst_drv_ctx->dev, "Probe failed with %d\n", ret);
-- 
1.7.0.4
