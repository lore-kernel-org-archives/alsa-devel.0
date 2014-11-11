From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4] ASoC: Intel: mrfld- add ACPI module
Date: Tue, 11 Nov 2014 16:36:28 +0530
Message-ID: <1415703988-12493-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DE77F264F37
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 12:05:41 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add the last ACPI module support which also uses core module like the PCI
part

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig        |    5 +
 sound/soc/intel/sst/Makefile   |    4 +-
 sound/soc/intel/sst/sst.c      |   22 ++-
 sound/soc/intel/sst/sst.h      |    1 +
 sound/soc/intel/sst/sst_acpi.c |  362 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/intel/sst/sst_pvt.c  |    2 +
 6 files changed, 391 insertions(+), 5 deletions(-)
 create mode 100644 sound/soc/intel/sst/sst_acpi.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index c963a5d..a992e85 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -20,6 +20,11 @@ config SND_SST_IPC_PCI
 	tristate
 	select SND_SST_IPC
 
+config SND_SST_IPC_ACPI
+	tristate
+	select SND_SST_IPC
+	depends on ACPI
+
 config SND_SOC_INTEL_SST
 	tristate "ASoC support for Intel(R) Smart Sound Technology"
 	select SND_SOC_INTEL_SST_ACPI if ACPI
diff --git a/sound/soc/intel/sst/Makefile b/sound/soc/intel/sst/Makefile
index b8aa1d3..fd21726 100644
--- a/sound/soc/intel/sst/Makefile
+++ b/sound/soc/intel/sst/Makefile
@@ -1,7 +1,7 @@
 snd-intel-sst-core-objs := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o
 snd-intel-sst-pci-objs += sst_pci.o
-
+snd-intel-sst-acpi-objs += sst_acpi.o
 
 obj-$(CONFIG_SND_SST_IPC) += snd-intel-sst-core.o
 obj-$(CONFIG_SND_SST_IPC_PCI) += snd-intel-sst-pci.o
-
+obj-$(CONFIG_SND_SST_IPC_ACPI) += snd-intel-sst-acpi.o
diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index b97c231..b2b5604 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/async.h>
+#include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/soc.h>
 #include <asm/platform_sst_audio.h>
@@ -181,6 +182,7 @@ int sst_driver_ops(struct intel_sst_drv *sst)
 
 	switch (sst->dev_id) {
 	case SST_MRFLD_PCI_ID:
+	case SST_BYT_ACPI_ID:
 		sst->tstamp = SST_TIME_STAMP_MRFLD;
 		sst->ops = &mrfld_ops;
 		return 0;
@@ -323,7 +325,7 @@ EXPORT_SYMBOL_GPL(sst_context_init);
 void sst_context_cleanup(struct intel_sst_drv *ctx)
 {
 	pm_runtime_get_noresume(ctx->dev);
-	pm_runtime_forbid(ctx->dev);
+	pm_runtime_disable(ctx->dev);
 	sst_unregister(ctx->dev);
 	sst_set_fw_state_locked(ctx, SST_SHUTDOWN);
 	flush_scheduled_work();
@@ -371,8 +373,19 @@ void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
 {
 	pm_runtime_set_autosuspend_delay(ctx->dev, SST_SUSPEND_DELAY);
 	pm_runtime_use_autosuspend(ctx->dev);
-	pm_runtime_allow(ctx->dev);
-	pm_runtime_put_noidle(ctx->dev);
+	/*
+	 * For acpi devices, the actual physical device state is
+	 * initially active. So change the state to active before
+	 * enabling the pm
+	 */
+	if (acpi_disabled) {
+		pm_runtime_set_active(ctx->dev);
+		pm_runtime_enable(ctx->dev);
+	} else {
+		pm_runtime_allow(ctx->dev);
+		pm_runtime_put_noidle(ctx->dev);
+	}
+	sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
 }
 EXPORT_SYMBOL_GPL(sst_configure_runtime_pm);
 
@@ -395,6 +408,9 @@ static int intel_sst_runtime_suspend(struct device *dev)
 	synchronize_irq(ctx->irq_num);
 	flush_workqueue(ctx->post_msg_wq);
 
+	/* save the shim registers because PMC doesn't save state */
+	sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
+
 	return ret;
 }
 
diff --git a/sound/soc/intel/sst/sst.h b/sound/soc/intel/sst/sst.h
index 2dcbf47..683dc71 100644
--- a/sound/soc/intel/sst/sst.h
+++ b/sound/soc/intel/sst/sst.h
@@ -29,6 +29,7 @@
 /* driver names */
 #define SST_DRV_NAME "intel_sst_driver"
 #define SST_MRFLD_PCI_ID 0x119A
+#define SST_BYT_ACPI_ID	0x80860F28
 
 #define SST_SUSPEND_DELAY 2000
 #define FW_CONTEXT_MEM (64*1024)
diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
new file mode 100644
index 0000000..2b1c5d9
--- /dev/null
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -0,0 +1,362 @@
+/*
+ * sst_acpi.c - SST (LPE) driver init file for ACPI enumeration.
+ *
+ * Copyright (c) 2013, Intel Corporation.
+ *
+ *  Authors:	Ramesh Babu K V <Ramesh.Babu@intel.com>
+ *  Authors:	Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/platform_device.h>
+#include <linux/firmware.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
+#include <linux/acpi.h>
+#include <asm/platform_sst_audio.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/compress_driver.h>
+#include <acpi/acbuffer.h>
+#include <acpi/platform/acenv.h>
+#include <acpi/platform/aclinux.h>
+#include <acpi/actypes.h>
+#include <acpi/acpi_bus.h>
+#include "../sst-mfld-platform.h"
+#include "../sst-dsp.h"
+#include "sst.h"
+
+struct sst_machines {
+	char codec_id[32];
+	char board[32];
+	char machine[32];
+	void (*machine_quirk)(void);
+	char firmware[32];
+	struct sst_platform_info *pdata;
+
+};
+
+/* LPE viewpoint addresses */
+#define SST_BYT_IRAM_PHY_START	0xff2c0000
+#define SST_BYT_IRAM_PHY_END	0xff2d4000
+#define SST_BYT_DRAM_PHY_START	0xff300000
+#define SST_BYT_DRAM_PHY_END	0xff320000
+#define SST_BYT_IMR_VIRT_START	0xc0000000 /* virtual addr in LPE */
+#define SST_BYT_IMR_VIRT_END	0xc01fffff
+#define SST_BYT_SHIM_PHY_ADDR	0xff340000
+#define SST_BYT_MBOX_PHY_ADDR	0xff344000
+#define SST_BYT_DMA0_PHY_ADDR	0xff298000
+#define SST_BYT_DMA1_PHY_ADDR	0xff29c000
+#define SST_BYT_SSP0_PHY_ADDR	0xff2a0000
+#define SST_BYT_SSP2_PHY_ADDR	0xff2a2000
+
+#define BYT_FW_MOD_TABLE_OFFSET	0x80000
+#define BYT_FW_MOD_TABLE_SIZE	0x100
+#define BYT_FW_MOD_OFFSET	(BYT_FW_MOD_TABLE_OFFSET + BYT_FW_MOD_TABLE_SIZE)
+
+static const struct sst_info byt_fwparse_info = {
+	.use_elf	= false,
+	.max_streams	= 25,
+	.iram_start	= SST_BYT_IRAM_PHY_START,
+	.iram_end	= SST_BYT_IRAM_PHY_END,
+	.iram_use	= true,
+	.dram_start	= SST_BYT_DRAM_PHY_START,
+	.dram_end	= SST_BYT_DRAM_PHY_END,
+	.dram_use	= true,
+	.imr_start	= SST_BYT_IMR_VIRT_START,
+	.imr_end	= SST_BYT_IMR_VIRT_END,
+	.imr_use	= true,
+	.mailbox_start	= SST_BYT_MBOX_PHY_ADDR,
+	.num_probes	= 0,
+	.lpe_viewpt_rqd  = true,
+};
+
+static const struct sst_ipc_info byt_ipc_info = {
+	.ipc_offset = 0,
+	.mbox_recv_off = 0x400,
+};
+
+static const struct sst_lib_dnld_info  byt_lib_dnld_info = {
+	.mod_base           = SST_BYT_IMR_VIRT_START,
+	.mod_end            = SST_BYT_IMR_VIRT_END,
+	.mod_table_offset   = BYT_FW_MOD_TABLE_OFFSET,
+	.mod_table_size     = BYT_FW_MOD_TABLE_SIZE,
+	.mod_ddr_dnld       = false,
+};
+
+static const struct sst_res_info byt_rvp_res_info = {
+	.shim_offset = 0x140000,
+	.shim_size = 0x000100,
+	.shim_phy_addr = SST_BYT_SHIM_PHY_ADDR,
+	.ssp0_offset = 0xa0000,
+	.ssp0_size = 0x1000,
+	.dma0_offset = 0x98000,
+	.dma0_size = 0x4000,
+	.dma1_offset = 0x9c000,
+	.dma1_size = 0x4000,
+	.iram_offset = 0x0c0000,
+	.iram_size = 0x14000,
+	.dram_offset = 0x100000,
+	.dram_size = 0x28000,
+	.mbox_offset = 0x144000,
+	.mbox_size = 0x1000,
+	.acpi_lpe_res_index = 0,
+	.acpi_ddr_index = 2,
+	.acpi_ipc_irq_index = 5,
+};
+
+struct sst_platform_info byt_rvp_platform_data = {
+	.probe_data = &byt_fwparse_info,
+	.ipc_info = &byt_ipc_info,
+	.lib_info = &byt_lib_dnld_info,
+	.res_info = &byt_rvp_res_info,
+	.platform = "sst-mfld-platform",
+};
+
+static int sst_platform_get_resources(struct intel_sst_drv *ctx)
+{
+	struct resource *rsrc;
+	struct platform_device *pdev = to_platform_device(ctx->dev);
+
+	/* All ACPI resource request here */
+	/* Get Shim addr */
+	rsrc = platform_get_resource(pdev, IORESOURCE_MEM,
+					ctx->pdata->res_info->acpi_lpe_res_index);
+	if (!rsrc) {
+		dev_err(ctx->dev, "Invalid SHIM base from IFWI");
+		return -EIO;
+	}
+	dev_info(ctx->dev, "LPE base: %#x size:%#x", (unsigned int) rsrc->start,
+					(unsigned int)resource_size(rsrc));
+
+	ctx->iram_base = rsrc->start + ctx->pdata->res_info->iram_offset;
+	ctx->iram_end =  ctx->iram_base + ctx->pdata->res_info->iram_size - 1;
+	dev_info(ctx->dev, "IRAM base: %#x", ctx->iram_base);
+	ctx->iram = devm_ioremap_nocache(ctx->dev, ctx->iram_base,
+					 ctx->pdata->res_info->iram_size);
+	if (!ctx->iram) {
+		dev_err(ctx->dev, "unable to map IRAM");
+		return -EIO;
+	}
+
+	ctx->dram_base = rsrc->start + ctx->pdata->res_info->dram_offset;
+	ctx->dram_end = ctx->dram_base + ctx->pdata->res_info->dram_size - 1;
+	dev_info(ctx->dev, "DRAM base: %#x", ctx->dram_base);
+	ctx->dram = devm_ioremap_nocache(ctx->dev, ctx->dram_base,
+					 ctx->pdata->res_info->dram_size);
+	if (!ctx->dram) {
+		dev_err(ctx->dev, "unable to map DRAM");
+		return -EIO;
+	}
+
+	ctx->shim_phy_add = rsrc->start + ctx->pdata->res_info->shim_offset;
+	dev_info(ctx->dev, "SHIM base: %#x", ctx->shim_phy_add);
+	ctx->shim = devm_ioremap_nocache(ctx->dev, ctx->shim_phy_add,
+					ctx->pdata->res_info->shim_size);
+	if (!ctx->shim) {
+		dev_err(ctx->dev, "unable to map SHIM");
+		return -EIO;
+	}
+
+	/* reassign physical address to LPE viewpoint address */
+	ctx->shim_phy_add = ctx->pdata->res_info->shim_phy_addr;
+
+	/* Get mailbox addr */
+	ctx->mailbox_add = rsrc->start + ctx->pdata->res_info->mbox_offset;
+	dev_info(ctx->dev, "Mailbox base: %#x", ctx->mailbox_add);
+	ctx->mailbox = devm_ioremap_nocache(ctx->dev, ctx->mailbox_add,
+					    ctx->pdata->res_info->mbox_size);
+	if (!ctx->mailbox) {
+		dev_err(ctx->dev, "unable to map mailbox");
+		return -EIO;
+	}
+
+	/* reassign physical address to LPE viewpoint address */
+	ctx->mailbox_add = ctx->info.mailbox_start;
+
+	rsrc = platform_get_resource(pdev, IORESOURCE_MEM,
+					ctx->pdata->res_info->acpi_ddr_index);
+	if (!rsrc) {
+		dev_err(ctx->dev, "Invalid DDR base from IFWI");
+		return -EIO;
+	}
+	ctx->ddr_base = rsrc->start;
+	ctx->ddr_end = rsrc->end;
+	dev_info(ctx->dev, "DDR base: %#x", ctx->ddr_base);
+	ctx->ddr = devm_ioremap_nocache(ctx->dev, ctx->ddr_base,
+					resource_size(rsrc));
+	if (!ctx->ddr) {
+		dev_err(ctx->dev, "unable to map DDR");
+		return -EIO;
+	}
+
+	/* Find the IRQ */
+	ctx->irq_num = platform_get_irq(pdev,
+				ctx->pdata->res_info->acpi_ipc_irq_index);
+	return 0;
+}
+
+static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
+				       void *context, void **ret)
+{
+	*(bool *)context = true;
+	return AE_OK;
+}
+
+static struct sst_machines *sst_acpi_find_machine(
+	struct sst_machines *machines)
+{
+	struct sst_machines *mach;
+	bool found = false;
+
+	for (mach = machines; mach->codec_id; mach++)
+		if (ACPI_SUCCESS(acpi_get_devices(mach->codec_id,
+						  sst_acpi_mach_match,
+						  &found, NULL)) && found)
+			return mach;
+
+	return NULL;
+}
+
+int sst_acpi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret = 0;
+	struct intel_sst_drv *ctx;
+	const struct acpi_device_id *id;
+	struct sst_machines *mach;
+	struct platform_device *mdev;
+	struct platform_device *plat_dev;
+	unsigned int dev_id;
+
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!id)
+		return -ENODEV;
+	dev_dbg(dev, "for %s", id->id);
+
+	mach = (struct sst_machines *)id->driver_data;
+	mach = sst_acpi_find_machine(mach);
+	if (mach == NULL) {
+		dev_err(dev, "No matching machine driver found\n");
+		return -ENODEV;
+	}
+
+	ret = kstrtouint(id->id, 16, &dev_id);
+	if (ret < 0) {
+		dev_err(dev, "Unique device id conversion error: %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(dev, "ACPI device id: %x\n", dev_id);
+
+	plat_dev = platform_device_register_data(dev, mach->pdata->platform, -1, NULL, 0);
+	if (plat_dev == NULL) {
+		dev_err(dev, "Failed to create machine device: %s\n", mach->pdata->platform);
+		return -ENODEV;
+	}
+
+	/* Create platform device for sst machine driver */
+	mdev = platform_device_register_data(dev, mach->machine, -1, NULL, 0);
+	if (mdev == NULL) {
+		dev_err(dev, "Failed to create machine device: %s\n", mach->machine);
+		return -ENODEV;
+	}
+
+	ret = sst_alloc_drv_context(&ctx, dev, dev_id);
+	if (ret < 0)
+		return ret;
+
+	/* Fill sst platform data */
+	ctx->pdata = mach->pdata;
+	strcpy(ctx->firmware_name, mach->firmware);
+
+	ret = sst_platform_get_resources(ctx);
+	if (ret)
+		return ret;
+
+	ret = sst_context_init(ctx);
+	if (ret < 0)
+		return ret;
+
+	/* need to save shim registers in BYT */
+	ctx->shim_regs64 = devm_kzalloc(ctx->dev, sizeof(*ctx->shim_regs64),
+					GFP_KERNEL);
+	if (!ctx->shim_regs64) {
+		return -ENOMEM;
+		goto do_sst_cleanup;
+	}
+
+	sst_configure_runtime_pm(ctx);
+	platform_set_drvdata(pdev, ctx);
+	return ret;
+
+do_sst_cleanup:
+	sst_context_cleanup(ctx);
+	platform_set_drvdata(pdev, NULL);
+	dev_err(ctx->dev, "failed with %d\n", ret);
+	return ret;
+}
+
+/**
+* intel_sst_remove - remove function
+*
+* @pdev:	platform device structure
+*
+* This function is called by OS when a device is unloaded
+* This frees the interrupt etc
+*/
+int sst_acpi_remove(struct platform_device *pdev)
+{
+	struct intel_sst_drv *ctx;
+
+	ctx = platform_get_drvdata(pdev);
+	sst_context_cleanup(ctx);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct sst_machines sst_acpi_bytcr[] = {
+	{"10EC5640", "T100", "bytt100_rt5640", NULL, "fw_sst_0f28.bin",
+						&byt_rvp_platform_data },
+	{},
+};
+
+static const struct acpi_device_id sst_acpi_ids[] = {
+	{ "80860F28", (unsigned long)&sst_acpi_bytcr},
+	{ },
+};
+
+static struct platform_driver sst_acpi_driver = {
+	.driver = {
+		.name			= "intel_sst_acpi",
+		.owner			= THIS_MODULE,
+		.acpi_match_table	= ACPI_PTR(sst_acpi_ids),
+		.pm			= &intel_sst_pm,
+	},
+	.probe	= sst_acpi_probe,
+	.remove	= sst_acpi_remove,
+};
+
+module_platform_driver(sst_acpi_driver);
+
+MODULE_DESCRIPTION("Intel (R) SST(R) Audio Engine ACPI Driver");
+MODULE_AUTHOR("Ramesh Babu K V");
+MODULE_AUTHOR("Omair Mohammed Abdullah");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("sst");
diff --git a/sound/soc/intel/sst/sst_pvt.c b/sound/soc/intel/sst/sst_pvt.c
index 9a5df19..4b77208 100644
--- a/sound/soc/intel/sst/sst_pvt.c
+++ b/sound/soc/intel/sst/sst_pvt.c
@@ -117,6 +117,7 @@ unsigned long long read_shim_data(struct intel_sst_drv *sst, int addr)
 
 	switch (sst->dev_id) {
 	case SST_MRFLD_PCI_ID:
+	case SST_BYT_ACPI_ID:
 		val = sst_shim_read64(sst->shim, addr);
 		break;
 	}
@@ -128,6 +129,7 @@ void write_shim_data(struct intel_sst_drv *sst, int addr,
 {
 	switch (sst->dev_id) {
 	case SST_MRFLD_PCI_ID:
+	case SST_BYT_ACPI_ID:
 		sst_shim_write64(sst->shim, addr, (u64) data);
 		break;
 	}
-- 
1.7.0.4
