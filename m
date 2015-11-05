From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/6] ASoC: Intel: Move apci find machine
	routines
Date: Thu,  5 Nov 2015 21:34:11 +0530
Message-ID: <1446739455-22332-3-git-send-email-vinod.koul@intel.com>
References: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C3602660C7
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:01:02 +0100 (CET)
In-Reply-To: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

This code to find the machine is common for all drivers so move
it to a separate file and header for use in other drivers

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/Makefile         |  3 +--
 sound/soc/intel/common/sst-acpi.c       | 33 +------------------------
 sound/soc/intel/common/sst-acpi.h       | 28 +++++++++++++++++++++
 sound/soc/intel/common/sst-match-acpi.c | 43 +++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 34 deletions(-)
 create mode 100644 sound/soc/intel/common/sst-acpi.h
 create mode 100644 sound/soc/intel/common/sst-match-acpi.c

diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index d9105584c51f..658edce16761 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -1,5 +1,5 @@
 snd-soc-sst-dsp-objs := sst-dsp.o
-snd-soc-sst-acpi-objs := sst-acpi.o
+snd-soc-sst-acpi-objs := sst-acpi.o sst-match-acpi.o
 snd-soc-sst-ipc-objs := sst-ipc.o
 
 ifneq ($(CONFIG_DW_DMAC_CORE),)
@@ -8,4 +8,3 @@ endif
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
-
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 67b6d3d52f57..94a43e6fcf88 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -21,21 +21,12 @@
 #include <linux/platform_device.h>
 
 #include "sst-dsp.h"
+#include "sst-acpi.h"
 
 #define SST_LPT_DSP_DMA_ADDR_OFFSET	0x0F0000
 #define SST_WPT_DSP_DMA_ADDR_OFFSET	0x0FE000
 #define SST_LPT_DSP_DMA_SIZE		(1024 - 1)
 
-/* Descriptor for SST ASoC machine driver */
-struct sst_acpi_mach {
-	/* ACPI ID for the matching machine driver. Audio codec for instance */
-	const u8 id[ACPI_ID_LEN];
-	/* machine driver name */
-	const char *drv_name;
-	/* firmware file name */
-	const char *fw_filename;
-};
-
 /* Descriptor for setting up SST platform data */
 struct sst_acpi_desc {
 	const char *drv_name;
@@ -88,28 +79,6 @@ static void sst_acpi_fw_cb(const struct firmware *fw, void *context)
 	return;
 }
 
-static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
-				       void *context, void **ret)
-{
-	*(bool *)context = true;
-	return AE_OK;
-}
-
-static struct sst_acpi_mach *sst_acpi_find_machine(
-	struct sst_acpi_mach *machines)
-{
-	struct sst_acpi_mach *mach;
-	bool found = false;
-
-	for (mach = machines; mach->id[0]; mach++)
-		if (ACPI_SUCCESS(acpi_get_devices(mach->id,
-						  sst_acpi_mach_match,
-						  &found, NULL)) && found)
-			return mach;
-
-	return NULL;
-}
-
 static int sst_acpi_probe(struct platform_device *pdev)
 {
 	const struct acpi_device_id *id;
diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
new file mode 100644
index 000000000000..1dc059590ead
--- /dev/null
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2013-15, Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/acpi.h>
+
+/* acpi match */
+struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines);
+
+/* Descriptor for SST ASoC machine driver */
+struct sst_acpi_mach {
+	/* ACPI ID for the matching machine driver. Audio codec for instance */
+	const u8 id[ACPI_ID_LEN];
+	/* machine driver name */
+	const char *drv_name;
+	/* firmware file name */
+	const char *fw_filename;
+};
diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
new file mode 100644
index 000000000000..dd077e116d25
--- /dev/null
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -0,0 +1,43 @@
+/*
+ * sst_match_apci.c - SST (LPE) match for ACPI enumeration.
+ *
+ * Copyright (c) 2013-15, Intel Corporation.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "sst-acpi.h"
+
+static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
+				       void *context, void **ret)
+{
+	*(bool *)context = true;
+	return AE_OK;
+}
+
+struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
+{
+	struct sst_acpi_mach *mach;
+	bool found = false;
+
+	for (mach = machines; mach->id[0]; mach++)
+		if (ACPI_SUCCESS(acpi_get_devices(mach->id,
+						  sst_acpi_mach_match,
+						  &found, NULL)) && found)
+			return mach;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(sst_acpi_find_machine);
-- 
1.9.1
