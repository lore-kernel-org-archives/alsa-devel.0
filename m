From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/9] ASoC: Intel: move PCI probe to a seprate
	file
Date: Thu, 30 Oct 2014 16:21:50 +0530
Message-ID: <1414666312-4657-8-git-send-email-vinod.koul@intel.com>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 83B45265487
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:32:47 +0100 (CET)
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

This allow the sst.c to be common across PCI and APCI usages

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Author:    Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/Kconfig       |    4 +
 sound/soc/intel/sst/Makefile  |    4 +
 sound/soc/intel/sst/sst.c     |  200 +------------------------------------
 sound/soc/intel/sst/sst.h     |    6 +
 sound/soc/intel/sst/sst_pci.c |  225 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 240 insertions(+), 199 deletions(-)
 create mode 100644 sound/soc/intel/sst/sst_pci.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 2a3af88..cbc987e 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -4,6 +4,7 @@ config SND_MFLD_MACHINE
 	select SND_SOC_SN95031
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC
+	select SND_SST_IPC_PCI
 	help
           This adds support for ASoC machine driver for Intel(R) MID Medfield platform
           used as alsa device in audio substem in Intel(R) MID devices
@@ -16,6 +17,9 @@ config SND_SST_MFLD_PLATFORM
 config SND_SST_IPC
 	tristate
 
+config SND_SST_IPC_PCI
+	bool
+
 config SND_SOC_INTEL_SST
 	tristate "ASoC support for Intel(R) Smart Sound Technology"
 	select SND_SOC_INTEL_SST_ACPI if ACPI
diff --git a/sound/soc/intel/sst/Makefile b/sound/soc/intel/sst/Makefile
index 4d0e79b..b3fbccd 100644
--- a/sound/soc/intel/sst/Makefile
+++ b/sound/soc/intel/sst/Makefile
@@ -1,3 +1,7 @@
 snd-intel-sst-objs := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o
 
+ifneq ($(CONFIG_SND_SST_IPC_PCI),)
+snd-intel-sst-objs += sst_pci.o
+endif
+
 obj-$(CONFIG_SND_SST_IPC) += snd-intel-sst.o
diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index ad16101..97c737a 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -20,30 +20,19 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/async.h>
-#include <linux/delay.h>
-#include <linux/acpi.h>
 #include <sound/core.h>
-#include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/compress_driver.h>
-#include <asm/intel-mid.h>
 #include <asm/platform_sst_audio.h>
 #include "../sst-mfld-platform.h"
 #include "sst.h"
 #include "../sst-dsp.h"
 
-MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
-MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
-MODULE_DESCRIPTION("Intel (R) SST(R) Audio Engine Driver");
-MODULE_LICENSE("GPL v2");
-
 static inline bool sst_is_process_reply(u32 msg_id)
 {
 	return ((msg_id & PROCESS_MSG) ? true : false);
@@ -340,174 +329,7 @@ void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
 	pm_runtime_put_noidle(ctx->dev);
 }
 
-static int sst_platform_get_resources(struct intel_sst_drv *ctx)
-{
-	int ddr_base, ret = 0;
-	struct pci_dev *pci = ctx->pci;
-	ret = pci_request_regions(pci, SST_DRV_NAME);
-	if (ret)
-		return ret;
-
-	/* map registers */
-	/* DDR base */
-	if (ctx->dev_id == SST_MRFLD_PCI_ID) {
-		ctx->ddr_base = pci_resource_start(pci, 0);
-		/* check that the relocated IMR base matches with FW Binary */
-		ddr_base = relocate_imr_addr_mrfld(ctx->ddr_base);
-		if (!ctx->pdata->lib_info) {
-			dev_err(ctx->dev, "lib_info pointer NULL\n");
-			ret = -EINVAL;
-			goto do_release_regions;
-		}
-		if (ddr_base != ctx->pdata->lib_info->mod_base) {
-			dev_err(ctx->dev,
-					"FW LSP DDR BASE does not match with IFWI\n");
-			ret = -EINVAL;
-			goto do_release_regions;
-		}
-		ctx->ddr_end = pci_resource_end(pci, 0);
-
-		ctx->ddr = pcim_iomap(pci, 0,
-					pci_resource_len(pci, 0));
-		if (!ctx->ddr) {
-			ret = -EINVAL;
-			goto do_release_regions;
-		}
-		dev_dbg(ctx->dev, "sst: DDR Ptr %p\n", ctx->ddr);
-	} else {
-		ctx->ddr = NULL;
-	}
-	/* SHIM */
-	ctx->shim_phy_add = pci_resource_start(pci, 1);
-	ctx->shim = pcim_iomap(pci, 1, pci_resource_len(pci, 1));
-	if (!ctx->shim) {
-		ret = -EINVAL;
-		goto do_release_regions;
-	}
-	dev_dbg(ctx->dev, "SST Shim Ptr %p\n", ctx->shim);
-
-	/* Shared SRAM */
-	ctx->mailbox_add = pci_resource_start(pci, 2);
-	ctx->mailbox = pcim_iomap(pci, 2, pci_resource_len(pci, 2));
-	if (!ctx->mailbox) {
-		ret = -EINVAL;
-		goto do_release_regions;
-	}
-	dev_dbg(ctx->dev, "SRAM Ptr %p\n", ctx->mailbox);
-
-	/* IRAM */
-	ctx->iram_end = pci_resource_end(pci, 3);
-	ctx->iram_base = pci_resource_start(pci, 3);
-	ctx->iram = pcim_iomap(pci, 3, pci_resource_len(pci, 3));
-	if (!ctx->iram) {
-		ret = -EINVAL;
-		goto do_release_regions;
-	}
-	dev_dbg(ctx->dev, "IRAM Ptr %p\n", ctx->iram);
-
-	/* DRAM */
-	ctx->dram_end = pci_resource_end(pci, 4);
-	ctx->dram_base = pci_resource_start(pci, 4);
-	ctx->dram = pcim_iomap(pci, 4, pci_resource_len(pci, 4));
-	if (!ctx->dram) {
-		ret = -EINVAL;
-		goto do_release_regions;
-	}
-	dev_dbg(ctx->dev, "DRAM Ptr %p\n", ctx->dram);
-do_release_regions:
-	pci_release_regions(pci);
-	return 0;
-}
-/*
-* intel_sst_probe - PCI probe function
-*
-* @pci:	PCI device structure
-* @pci_id: PCI device ID structure
-*
-*/
-static int intel_sst_probe(struct pci_dev *pci,
-			const struct pci_device_id *pci_id)
-{
-	int ret = 0;
-	struct intel_sst_drv *sst_drv_ctx;
-	struct sst_platform_info *sst_pdata = pci->dev.platform_data;
-
-	dev_dbg(&pci->dev, "Probe for DID %x\n", pci->device);
-
-	ret = sst_alloc_drv_context(&sst_drv_ctx, &pci->dev, pci->device);
-	if (ret < 0)
-		return ret;
-
-	sst_drv_ctx->pdata = sst_pdata;
-	sst_drv_ctx->irq_num = pci->irq;
-
-	ret = sst_context_init(sst_drv_ctx);
-	if (ret < 0)
-		goto do_free_drv_ctx;
-
-
-	/* Init the device */
-	ret = pcim_enable_device(pci);
-	if (ret) {
-		dev_err(sst_drv_ctx->dev,
-			"device can't be enabled. Returned err: %d\n", ret);
-		goto do_destroy_wq;
-	}
-	sst_drv_ctx->pci = pci_dev_get(pci);
-
-	ret = sst_platform_get_resources(sst_drv_ctx);
-	if (ret < 0)
-		goto do_destroy_wq;
-
-	sst_set_fw_state_locked(sst_drv_ctx, SST_RESET);
-	snprintf(sst_drv_ctx->firmware_name, sizeof(sst_drv_ctx->firmware_name),
-			"%s%04x%s", "fw_sst_",
-			sst_drv_ctx->dev_id, ".bin");
-	dev_dbg(sst_drv_ctx->dev,
-		"Requesting FW %s now...\n", sst_drv_ctx->firmware_name);
-	ret = request_firmware_nowait(THIS_MODULE, 1,
-			sst_drv_ctx->firmware_name, sst_drv_ctx->dev,
-			GFP_KERNEL, sst_drv_ctx, sst_firmware_load_cb);
-
-	if (ret) {
-		dev_err(sst_drv_ctx->dev,
-			"Firmware load failed with error: %d\n", ret);
-		goto do_release_regions;
-	}
-
-
-	pci_set_drvdata(pci, sst_drv_ctx);
-	sst_configure_runtime_pm(sst_drv_ctx);
-	sst_register(sst_drv_ctx->dev);
-
-	return ret;
-
-do_release_regions:
-	pci_release_regions(pci);
-do_destroy_wq:
-	destroy_workqueue(sst_drv_ctx->post_msg_wq);
-do_free_drv_ctx:
-	dev_err(sst_drv_ctx->dev, "Probe failed with %d\n", ret);
-	return ret;
-}
-
-/**
-* intel_sst_remove - PCI remove function
-*
-* @pci:	PCI device structure
-*
-* This function is called by OS when a device is unloaded
-* This frees the interrupt etc
-*/
-static void intel_sst_remove(struct pci_dev *pci)
-{
-	struct intel_sst_drv *sst_drv_ctx = pci_get_drvdata(pci);
 
-	sst_context_cleanup(sst_drv_ctx);
-	pci_dev_put(sst_drv_ctx->pci);
-	pci_release_regions(pci);
-	pci_set_drvdata(pci, NULL);
-}
 
 static int intel_sst_runtime_suspend(struct device *dev)
 {
@@ -550,27 +372,7 @@ static int intel_sst_runtime_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops intel_sst_pm = {
+const struct dev_pm_ops intel_sst_pm = {
 	.runtime_suspend = intel_sst_runtime_suspend,
 	.runtime_resume = intel_sst_runtime_resume,
 };
-
-/*PCI Routines*/
-static struct pci_device_id intel_sst_ids[] = {
-	{ PCI_VDEVICE(INTEL, SST_MRFLD_PCI_ID), 0},
-	{ 0, }
-};
-
-static struct pci_driver sst_driver = {
-	.name = SST_DRV_NAME,
-	.id_table = intel_sst_ids,
-	.probe = intel_sst_probe,
-	.remove = intel_sst_remove,
-#ifdef CONFIG_PM
-	.driver = {
-		.pm = &intel_sst_pm,
-	},
-#endif
-};
-
-module_pci_driver(sst_driver);
diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/sst/sst.h
index b65b9c0..3ee555e 100644
--- a/sound/soc/intel/sst/sst.h
+++ b/sound/soc/intel/sst/sst.h
@@ -40,6 +40,7 @@
 #define MRFLD_FW_FEATURE_BASE_OFFSET 0x4
 #define MRFLD_FW_BSS_RESET_BIT 0
 
+extern const struct dev_pm_ops intel_sst_pm;
 enum sst_states {
 	SST_FW_LOADING = 1,
 	SST_FW_RUNNING,
@@ -537,4 +538,9 @@ void sst_fill_header_dsp(struct ipc_dsp_hdr *dsp, int msg,
 int sst_register(struct device *);
 int sst_unregister(struct device *);
 
+int sst_alloc_drv_context(struct intel_sst_drv **ctx,
+		struct device *dev, unsigned int dev_id);
+int sst_context_init(struct intel_sst_drv *ctx);
+void sst_context_cleanup(struct intel_sst_drv *ctx);
+void sst_configure_runtime_pm(struct intel_sst_drv *ctx);
 #endif
diff --git a/sound/soc/intel/sst/sst_pci.c b/sound/soc/intel/sst/sst_pci.c
new file mode 100644
index 0000000..c7eb28b
--- /dev/null
+++ b/sound/soc/intel/sst/sst_pci.c
@@ -0,0 +1,225 @@
+/*
+ *  sst_pci.c - SST (LPE) driver init file for pci enumeration.
+ *
+ *  Copyright (C) 2008-14	Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *		Harsha Priya <priya.harsha@intel.com>
+ *		Dharageswari R <dharageswari.r@intel.com>
+ *		KP Jeeja <jeeja.kp@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/fs.h>
+#include <linux/firmware.h>
+#include <linux/pm_runtime.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <asm/platform_sst_audio.h>
+#include "../sst-mfld-platform.h"
+#include "sst.h"
+
+static int sst_platform_get_resources(struct intel_sst_drv *ctx)
+{
+	int ddr_base, ret = 0;
+	struct pci_dev *pci = ctx->pci;
+
+	ret = pci_request_regions(pci, SST_DRV_NAME);
+	if (ret)
+		return ret;
+
+	/* map registers */
+	/* DDR base */
+	if (ctx->dev_id == SST_MRFLD_PCI_ID) {
+		ctx->ddr_base = pci_resource_start(pci, 0);
+		/* check that the relocated IMR base matches with FW Binary */
+		ddr_base = relocate_imr_addr_mrfld(ctx->ddr_base);
+		if (!ctx->pdata->lib_info) {
+			dev_err(ctx->dev, "lib_info pointer NULL\n");
+			ret = -EINVAL;
+			goto do_release_regions;
+		}
+		if (ddr_base != ctx->pdata->lib_info->mod_base) {
+			dev_err(ctx->dev,
+					"FW LSP DDR BASE does not match with IFWI\n");
+			ret = -EINVAL;
+			goto do_release_regions;
+		}
+		ctx->ddr_end = pci_resource_end(pci, 0);
+
+		ctx->ddr = pcim_iomap(pci, 0,
+					pci_resource_len(pci, 0));
+		if (!ctx->ddr) {
+			ret = -EINVAL;
+			goto do_release_regions;
+		}
+		dev_dbg(ctx->dev, "sst: DDR Ptr %p\n", ctx->ddr);
+	} else {
+		ctx->ddr = NULL;
+	}
+	/* SHIM */
+	ctx->shim_phy_add = pci_resource_start(pci, 1);
+	ctx->shim = pcim_iomap(pci, 1, pci_resource_len(pci, 1));
+	if (!ctx->shim) {
+		ret = -EINVAL;
+		goto do_release_regions;
+	}
+	dev_dbg(ctx->dev, "SST Shim Ptr %p\n", ctx->shim);
+
+	/* Shared SRAM */
+	ctx->mailbox_add = pci_resource_start(pci, 2);
+	ctx->mailbox = pcim_iomap(pci, 2, pci_resource_len(pci, 2));
+	if (!ctx->mailbox) {
+		ret = -EINVAL;
+		goto do_release_regions;
+	}
+	dev_dbg(ctx->dev, "SRAM Ptr %p\n", ctx->mailbox);
+
+	/* IRAM */
+	ctx->iram_end = pci_resource_end(pci, 3);
+	ctx->iram_base = pci_resource_start(pci, 3);
+	ctx->iram = pcim_iomap(pci, 3, pci_resource_len(pci, 3));
+	if (!ctx->iram) {
+		ret = -EINVAL;
+		goto do_release_regions;
+	}
+	dev_dbg(ctx->dev, "IRAM Ptr %p\n", ctx->iram);
+
+	/* DRAM */
+	ctx->dram_end = pci_resource_end(pci, 4);
+	ctx->dram_base = pci_resource_start(pci, 4);
+	ctx->dram = pcim_iomap(pci, 4, pci_resource_len(pci, 4));
+	if (!ctx->dram) {
+		ret = -EINVAL;
+		goto do_release_regions;
+	}
+	dev_dbg(ctx->dev, "DRAM Ptr %p\n", ctx->dram);
+do_release_regions:
+	pci_release_regions(pci);
+	return 0;
+}
+
+/*
+ * intel_sst_probe - PCI probe function
+ *
+ * @pci:	PCI device structure
+ * @pci_id: PCI device ID structure
+ *
+ */
+static int intel_sst_probe(struct pci_dev *pci,
+			const struct pci_device_id *pci_id)
+{
+	int ret = 0;
+	struct intel_sst_drv *sst_drv_ctx;
+	struct sst_platform_info *sst_pdata = pci->dev.platform_data;
+
+	dev_dbg(&pci->dev, "Probe for DID %x\n", pci->device);
+	ret = sst_alloc_drv_context(&sst_drv_ctx, &pci->dev, pci->device);
+	if (ret < 0)
+		return ret;
+
+	sst_drv_ctx->pdata = sst_pdata;
+	sst_drv_ctx->irq_num = pci->irq;
+	ret = sst_context_init(sst_drv_ctx);
+	if (ret < 0)
+		goto do_free_drv_ctx;
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
+
+	sst_set_fw_state_locked(sst_drv_ctx, SST_RESET);
+	snprintf(sst_drv_ctx->firmware_name, sizeof(sst_drv_ctx->firmware_name),
+			"%s%04x%s", "fw_sst_",
+			sst_drv_ctx->dev_id, ".bin");
+	dev_dbg(sst_drv_ctx->dev,
+		"Requesting FW %s now...\n", sst_drv_ctx->firmware_name);
+	ret = request_firmware_nowait(THIS_MODULE, 1,
+			sst_drv_ctx->firmware_name, sst_drv_ctx->dev,
+			GFP_KERNEL, sst_drv_ctx, sst_firmware_load_cb);
+
+	if (ret) {
+		dev_err(sst_drv_ctx->dev,
+			"Firmware load failed with error: %d\n", ret);
+		goto do_release_regions;
+	}
+
+	pci_set_drvdata(pci, sst_drv_ctx);
+	sst_configure_runtime_pm(sst_drv_ctx);
+	sst_register(sst_drv_ctx->dev);
+
+	return ret;
+
+do_release_regions:
+	pci_release_regions(pci);
+do_destroy_wq:
+	destroy_workqueue(sst_drv_ctx->post_msg_wq);
+do_free_drv_ctx:
+	dev_err(sst_drv_ctx->dev, "Probe failed with %d\n", ret);
+	return ret;
+}
+
+/**
+ * intel_sst_remove - PCI remove function
+ *
+ * @pci:	PCI device structure
+ *
+ * This function is called by OS when a device is unloaded
+ * This frees the interrupt etc
+ */
+static void intel_sst_remove(struct pci_dev *pci)
+{
+	struct intel_sst_drv *sst_drv_ctx = pci_get_drvdata(pci);
+
+	sst_context_cleanup(sst_drv_ctx);
+	pci_dev_put(sst_drv_ctx->pci);
+	pci_release_regions(pci);
+	pci_set_drvdata(pci, NULL);
+}
+
+/* PCI Routines */
+static struct pci_device_id intel_sst_ids[] = {
+	{ PCI_VDEVICE(INTEL, SST_MRFLD_PCI_ID), 0},
+	{ 0, }
+};
+
+static struct pci_driver sst_driver = {
+	.name = SST_DRV_NAME,
+	.id_table = intel_sst_ids,
+	.probe = intel_sst_probe,
+	.remove = intel_sst_remove,
+#ifdef CONFIG_PM
+	.driver = {
+		.pm = &intel_sst_pm,
+	},
+#endif
+};
+
+module_pci_driver(sst_driver);
+
+MODULE_DESCRIPTION("Intel (R) SST(R) Audio Engine PCI Driver");
+MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
+MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
+MODULE_AUTHOR("Dharageswari R <dharageswari.r@intel.com>");
+MODULE_AUTHOR("KP Jeeja <jeeja.kp@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("sst");
-- 
1.7.0.4
