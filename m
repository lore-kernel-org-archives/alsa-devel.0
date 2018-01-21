From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: intel: clean up CONFIG_SND_SST_IPC
	handling
Date: Sun, 21 Jan 2018 23:14:17 +0100
Message-ID: <20180121221505.196163-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D8F2266F88
 for <alsa-devel@alsa-project.org>; Sun, 21 Jan 2018 23:15:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Harsha Priya N <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

In a configuration with SND_SST_ATOM_HIFI2_PLATFORM_PCI=y and
SND_SST_ATOM_HIFI2_PLATFORM=m, we get this module link failure:

ERROR: "sst_context_init" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
ERROR: "sst_context_cleanup" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
ERROR: "sst_alloc_drv_context" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
ERROR: "intel_sst_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
ERROR: "sst_configure_runtime_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!

The problem is that the sound/soc/intel/atom/ directory only gets
entered by Kbuild when SND_SST_ATOM_HIFI2_PLATFORM is set, so we
only build modules (obj-m) under here but not built-in files (obj-y)
including the snd-intel-sst-core that we clearly want need here.

Before commit 4772c16ede52 ("ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI
dependencies"), this could not happen as all files in sound/soc/intel/atom/
depended on CONFIG_SND_SST_ATOM_HIFI2_PLATFORM anyway.

Slightly later, commit 05f4434bc130 ("ASoC: Intel: remove mfld_machine")
was added, which then removed the Merrifield machine code that happened
to be the only user of SND_SST_ATOM_HIFI2_PLATFORM_PCI. With that gone,
it appears that we can completely remove that symbol as well, along with
the SND_SST_IPC_PCI code and everything associated with it that is now
unused.

For clarify, this also removes the SND_SST_IPC_ACPI symbol that is now
synonymous with SND_SST_IPC, and links both into a single loadable module.

Fixes: 4772c16ede52 ("ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies")
Fixes: 05f4434bc130 ("ASoC: Intel: remove mfld_machine")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I checked that this patch leads to a clean compilation, and that the
code I'm removing is only used for the now-obsolete Merrifield PCI ID.

If I got something else wrong, or you want a different fix, please
just send a replacement patch and treat this as a bug report.
---
 sound/soc/intel/Kconfig            |  27 +----
 sound/soc/intel/atom/sst/Makefile  |   6 +-
 sound/soc/intel/atom/sst/sst_pci.c | 209 -------------------------------------
 sound/soc/intel/common/sst-acpi.c  |   4 +-
 4 files changed, 5 insertions(+), 241 deletions(-)
 delete mode 100644 sound/soc/intel/atom/sst/sst_pci.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index f2c9e8c5970a..2dc8cda7a7cd 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -17,21 +17,11 @@ if SND_SOC_INTEL_SST_TOPLEVEL
 config SND_SST_IPC
 	tristate
 	# This option controls the IPC core for HiFi2 platforms
-
-config SND_SST_IPC_PCI
-	tristate
-	select SND_SST_IPC
-	# This option controls the PCI-based IPC for HiFi2 platforms
-	#  (Medfield, Merrifield).
-
-config SND_SST_IPC_ACPI
-	tristate
-	select SND_SST_IPC
-	# This option controls the ACPI-based IPC for HiFi2 platforms
 	# (Baytrail, Cherrytrail)
 
 config SND_SOC_INTEL_SST_ACPI
 	tristate
+	select SND_SST_IPC
 	# This option controls ACPI-based probing on
 	# Haswell/Broadwell/Baytrail legacy and will be set
 	# when these platforms are enabled
@@ -72,23 +62,10 @@ config SND_SOC_INTEL_BAYTRAIL
 	  for Baytrail Chromebooks but this option is now deprecated and is
 	  not recommended, use SND_SST_ATOM_HIFI2_PLATFORM instead.
 
-config SND_SST_ATOM_HIFI2_PLATFORM_PCI
-	tristate "PCI HiFi2 (Medfield, Merrifield) Platforms"
-	depends on X86 && PCI
-	select SND_SST_IPC_PCI
-	select SND_SOC_COMPRESS
-	help
-	  If you have a Intel Medfield or Merrifield/Edison platform, then
-	  enable this option by saying Y or m. Distros will typically not
-	  enable this option: Medfield devices are not available to
-	  developers and while Merrifield/Edison can run a mainline kernel with
-	  limited functionality it will require a firmware file which
-	  is not in the standard firmware tree
-
 config SND_SST_ATOM_HIFI2_PLATFORM
 	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
 	depends on X86 && ACPI
-	select SND_SST_IPC_ACPI
+	select SND_SST_IPC
 	select SND_SOC_COMPRESS
 	select SND_SOC_ACPI_INTEL_MATCH
 	select IOSF_MBI
diff --git a/sound/soc/intel/atom/sst/Makefile b/sound/soc/intel/atom/sst/Makefile
index 795d1cf8f386..f5b7008b4cea 100644
--- a/sound/soc/intel/atom/sst/Makefile
+++ b/sound/soc/intel/atom/sst/Makefile
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-snd-intel-sst-core-objs := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o
-snd-intel-sst-pci-objs += sst_pci.o
-snd-intel-sst-acpi-objs += sst_acpi.o
+snd-intel-sst-core-objs := sst.o sst_ipc.o sst_stream.o sst_drv_interface.o sst_loader.o sst_pvt.o sst_acpi.o
 
 obj-$(CONFIG_SND_SST_IPC) += snd-intel-sst-core.o
-obj-$(CONFIG_SND_SST_IPC_PCI) += snd-intel-sst-pci.o
-obj-$(CONFIG_SND_SST_IPC_ACPI) += snd-intel-sst-acpi.o
diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
deleted file mode 100644
index 6906ee624cf6..000000000000
--- a/sound/soc/intel/atom/sst/sst_pci.c
+++ /dev/null
@@ -1,209 +0,0 @@
-/*
- *  sst_pci.c - SST (LPE) driver init file for pci enumeration.
- *
- *  Copyright (C) 2008-14	Intel Corp
- *  Authors:	Vinod Koul <vinod.koul@intel.com>
- *		Harsha Priya <priya.harsha@intel.com>
- *		Dharageswari R <dharageswari.r@intel.com>
- *		KP Jeeja <jeeja.kp@intel.com>
- *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- */
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/fs.h>
-#include <linux/firmware.h>
-#include <linux/pm_runtime.h>
-#include <sound/core.h>
-#include <sound/soc.h>
-#include <asm/platform_sst_audio.h>
-#include "../sst-mfld-platform.h"
-#include "sst.h"
-
-static int sst_platform_get_resources(struct intel_sst_drv *ctx)
-{
-	int ddr_base, ret = 0;
-	struct pci_dev *pci = ctx->pci;
-
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
-
-/*
- * intel_sst_probe - PCI probe function
- *
- * @pci:	PCI device structure
- * @pci_id: PCI device ID structure
- *
- */
-static int intel_sst_probe(struct pci_dev *pci,
-			const struct pci_device_id *pci_id)
-{
-	int ret = 0;
-	struct intel_sst_drv *sst_drv_ctx;
-	struct sst_platform_info *sst_pdata = pci->dev.platform_data;
-
-	dev_dbg(&pci->dev, "Probe for DID %x\n", pci->device);
-	ret = sst_alloc_drv_context(&sst_drv_ctx, &pci->dev, pci->device);
-	if (ret < 0)
-		return ret;
-
-	sst_drv_ctx->pdata = sst_pdata;
-	sst_drv_ctx->irq_num = pci->irq;
-	snprintf(sst_drv_ctx->firmware_name, sizeof(sst_drv_ctx->firmware_name),
-			"%s%04x%s", "fw_sst_",
-			sst_drv_ctx->dev_id, ".bin");
-
-	ret = sst_context_init(sst_drv_ctx);
-	if (ret < 0)
-		return ret;
-
-	/* Init the device */
-	ret = pcim_enable_device(pci);
-	if (ret) {
-		dev_err(sst_drv_ctx->dev,
-			"device can't be enabled. Returned err: %d\n", ret);
-		goto do_free_drv_ctx;
-	}
-	sst_drv_ctx->pci = pci_dev_get(pci);
-	ret = sst_platform_get_resources(sst_drv_ctx);
-	if (ret < 0)
-		goto do_free_drv_ctx;
-
-	pci_set_drvdata(pci, sst_drv_ctx);
-	sst_configure_runtime_pm(sst_drv_ctx);
-
-	return ret;
-
-do_free_drv_ctx:
-	sst_context_cleanup(sst_drv_ctx);
-	dev_err(sst_drv_ctx->dev, "Probe failed with %d\n", ret);
-	return ret;
-}
-
-/**
- * intel_sst_remove - PCI remove function
- *
- * @pci:	PCI device structure
- *
- * This function is called by OS when a device is unloaded
- * This frees the interrupt etc
- */
-static void intel_sst_remove(struct pci_dev *pci)
-{
-	struct intel_sst_drv *sst_drv_ctx = pci_get_drvdata(pci);
-
-	sst_context_cleanup(sst_drv_ctx);
-	pci_dev_put(sst_drv_ctx->pci);
-	pci_release_regions(pci);
-	pci_set_drvdata(pci, NULL);
-}
-
-/* PCI Routines */
-static const struct pci_device_id intel_sst_ids[] = {
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
-
-MODULE_DESCRIPTION("Intel (R) SST(R) Audio Engine PCI Driver");
-MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
-MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
-MODULE_AUTHOR("Dharageswari R <dharageswari.r@intel.com>");
-MODULE_AUTHOR("KP Jeeja <jeeja.kp@intel.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("sst");
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index cf6fbbd4e378..3b669d5adbb6 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -206,7 +206,7 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 	.dma_size = SST_LPT_DSP_DMA_SIZE,
 };
 
-#if !IS_ENABLED(CONFIG_SND_SST_IPC_ACPI)
+#if !IS_ENABLED(CONFIG_SND_SST_IPC)
 static struct sst_acpi_desc sst_acpi_baytrail_desc = {
 	.drv_name = "baytrail-pcm-audio",
 	.machines = snd_soc_acpi_intel_baytrail_legacy_machines,
@@ -222,7 +222,7 @@ static struct sst_acpi_desc sst_acpi_baytrail_desc = {
 static const struct acpi_device_id sst_acpi_match[] = {
 	{ "INT33C8", (unsigned long)&sst_acpi_haswell_desc },
 	{ "INT3438", (unsigned long)&sst_acpi_broadwell_desc },
-#if !IS_ENABLED(CONFIG_SND_SST_IPC_ACPI)
+#if !IS_ENABLED(CONFIG_SND_SST_IPC)
 	{ "80860F28", (unsigned long)&sst_acpi_baytrail_desc },
 #endif
 	{ }
-- 
2.9.0
