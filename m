From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Move apci find machine routines"
	to the asoc tree
Date: Thu, 05 Nov 2015 16:29:43 +0000
Message-ID: <E1ZuNPz-0001Lf-3K@finisterre>
References: <1446739455-22332-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A06F2663FD
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:29:55 +0100 (CET)
In-Reply-To: <1446739455-22332-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Move apci find machine routines

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9641e25435c16ce0fbfeeb0e486ae0b5eb0b6341 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 5 Nov 2015 21:34:11 +0530
Subject: [PATCH] ASoC: Intel: Move apci find machine routines

This code to find the machine is common for all drivers so move
it to a separate file and header for use in other drivers

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/Makefile         |  3 +--
 sound/soc/intel/common/sst-acpi.c       | 33 +------------------------
 sound/soc/intel/common/sst-acpi.h       | 28 +++++++++++++++++++++
 sound/soc/intel/common/sst-match-acpi.c | 43 +++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 34 deletions(-)
 create mode 100644 sound/soc/intel/common/sst-acpi.h
 create mode 100644 sound/soc/intel/common/sst-match-acpi.c

diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index d910558..658edce 100644
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
index 67b6d3d..94a43e6 100644
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
index 0000000..1dc0595
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
index 0000000..dd077e1
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
2.6.1
