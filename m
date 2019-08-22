From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 22/35] ASoC: Intel: Haswell: Define separate
	ACPI loader
Date: Thu, 22 Aug 2019 21:04:12 +0200
Message-ID: <20190822190425.23001-23-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B6AAF80636
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:17 +0200 (CEST)
In-Reply-To: <20190822190425.23001-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

With common acpi code exposed, separate Haswell specific code from other
legacy platforms. To reduce diff delta, it's still loaded with separate
module called: hsw-acpi. This may be address later, once heavy hitters
are gone.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/Kconfig           |  6 ++-
 sound/soc/intel/common/sst-acpi.c | 32 ----------------
 sound/soc/intel/haswell/Makefile  |  2 +
 sound/soc/intel/haswell/acpi.c    | 63 +++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 33 deletions(-)
 create mode 100644 sound/soc/intel/haswell/acpi.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a3ec17fd63cd..9191773d203c 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -31,6 +31,10 @@ config SND_SST_IPC_ACPI
 	# This option controls the ACPI-based IPC for HiFi2 platforms
 	# (Baytrail, Cherrytrail)
 
+config SND_SOC_INTEL_HASWELL_ACPI
+	tristate
+	# This option controls the ACPI-based on HSW/BDW platforms
+
 config SND_SOC_INTEL_SST_ACPI
 	tristate
 	# This option controls ACPI-based probing on
@@ -52,7 +56,7 @@ config SND_SOC_INTEL_HASWELL
 	depends on SND_DMA_SGBUF
 	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SST_ACPI
+	select SND_SOC_INTEL_HASWELL_ACPI
 	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 42f9b02f2ea3..7d2f04ff0479 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -15,10 +15,6 @@
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 
-#define SST_LPT_DSP_DMA_ADDR_OFFSET	0x0F0000
-#define SST_WPT_DSP_DMA_ADDR_OFFSET	0x0FE000
-#define SST_LPT_DSP_DMA_SIZE		(1024 - 1)
-
 struct sst_acpi_priv {
 	struct platform_device *pdev_mach;
 	struct platform_device *pdev_pcm;
@@ -156,32 +152,6 @@ int sst_acpi_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(sst_acpi_remove);
 
-static struct sst_acpi_desc sst_acpi_haswell_desc = {
-	.drv_name = "haswell-pcm-audio",
-	.machines = snd_soc_acpi_intel_haswell_machines,
-	.resindex_lpe_base = 0,
-	.resindex_pcicfg_base = 1,
-	.resindex_fw_base = -1,
-	.irqindex_host_ipc = 0,
-	.sst_id = SST_DEV_ID_LYNX_POINT,
-	.dma_engine = SST_DMA_TYPE_DW,
-	.resindex_dma_base = SST_LPT_DSP_DMA_ADDR_OFFSET,
-	.dma_size = SST_LPT_DSP_DMA_SIZE,
-};
-
-static struct sst_acpi_desc sst_acpi_broadwell_desc = {
-	.drv_name = "haswell-pcm-audio",
-	.machines = snd_soc_acpi_intel_broadwell_machines,
-	.resindex_lpe_base = 0,
-	.resindex_pcicfg_base = 1,
-	.resindex_fw_base = -1,
-	.irqindex_host_ipc = 0,
-	.sst_id = SST_DEV_ID_WILDCAT_POINT,
-	.dma_engine = SST_DMA_TYPE_DW,
-	.resindex_dma_base = SST_WPT_DSP_DMA_ADDR_OFFSET,
-	.dma_size = SST_LPT_DSP_DMA_SIZE,
-};
-
 #if !IS_ENABLED(CONFIG_SND_SST_IPC_ACPI)
 static struct sst_acpi_desc sst_acpi_baytrail_desc = {
 	.drv_name = "baytrail-pcm-audio",
@@ -196,8 +166,6 @@ static struct sst_acpi_desc sst_acpi_baytrail_desc = {
 #endif
 
 static const struct acpi_device_id sst_acpi_match[] = {
-	{ "INT33C8", (unsigned long)&sst_acpi_haswell_desc },
-	{ "INT3438", (unsigned long)&sst_acpi_broadwell_desc },
 #if !IS_ENABLED(CONFIG_SND_SST_IPC_ACPI)
 	{ "80860F28", (unsigned long)&sst_acpi_baytrail_desc },
 #endif
diff --git a/sound/soc/intel/haswell/Makefile b/sound/soc/intel/haswell/Makefile
index ad2341aea8ae..0af852d0577b 100644
--- a/sound/soc/intel/haswell/Makefile
+++ b/sound/soc/intel/haswell/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 snd-soc-sst-haswell-pcm-objs := \
 	        sst-haswell-ipc.o sst-haswell-pcm.o sst-haswell-dsp.o
+snd-soc-hsw-acpi-objs := acpi.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += snd-soc-sst-haswell-pcm.o
+obj-$(CONFIG_SND_SOC_INTEL_HASWELL_ACPI) += snd-soc-hsw-acpi.o
diff --git a/sound/soc/intel/haswell/acpi.c b/sound/soc/intel/haswell/acpi.c
new file mode 100644
index 000000000000..7bd8b03851c4
--- /dev/null
+++ b/sound/soc/intel/haswell/acpi.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel HSW loader on ACPI systems
+ *
+ * Copyright (C) 2019, Intel Corporation. All rights reserved.
+ */
+
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include "../common/sst-dsp.h"
+
+#define SST_LPT_DSP_DMA_ADDR_OFFSET	0x0F0000
+#define SST_WPT_DSP_DMA_ADDR_OFFSET	0x0FE000
+#define SST_LPT_DSP_DMA_SIZE		(1024 - 1)
+
+static struct sst_acpi_desc hsw_acpi_desc = {
+	.drv_name = "haswell-pcm-audio",
+	.machines = snd_soc_acpi_intel_haswell_machines,
+	.resindex_lpe_base = 0,
+	.resindex_pcicfg_base = 1,
+	.resindex_fw_base = -1,
+	.irqindex_host_ipc = 0,
+	.sst_id = SST_DEV_ID_LYNX_POINT,
+	.dma_engine = SST_DMA_TYPE_DW,
+	.resindex_dma_base = SST_LPT_DSP_DMA_ADDR_OFFSET,
+	.dma_size = SST_LPT_DSP_DMA_SIZE,
+};
+
+static struct sst_acpi_desc bdw_acpi_desc = {
+	.drv_name = "haswell-pcm-audio",
+	.machines = snd_soc_acpi_intel_broadwell_machines,
+	.resindex_lpe_base = 0,
+	.resindex_pcicfg_base = 1,
+	.resindex_fw_base = -1,
+	.irqindex_host_ipc = 0,
+	.sst_id = SST_DEV_ID_WILDCAT_POINT,
+	.dma_engine = SST_DMA_TYPE_DW,
+	.resindex_dma_base = SST_WPT_DSP_DMA_ADDR_OFFSET,
+	.dma_size = SST_LPT_DSP_DMA_SIZE,
+};
+
+static const struct acpi_device_id hsw_acpi_ids[] = {
+	{ "INT33C8", (unsigned long)&hsw_acpi_desc },
+	{ "INT3438", (unsigned long)&bdw_acpi_desc },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, hsw_acpi_ids);
+
+static struct platform_driver hsw_acpi_driver = {
+	.probe = sst_acpi_probe,
+	.remove = sst_acpi_remove,
+	.driver = {
+		.name = "hsw-acpi",
+		.acpi_match_table = ACPI_PTR(hsw_acpi_ids),
+	},
+};
+module_platform_driver(hsw_acpi_driver);
+
+MODULE_AUTHOR("Cezary Rojewski <cezary.rojewski@intel.com>");
+MODULE_DESCRIPTION("Intel HSW loader on ACPI systems");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1
