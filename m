From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/4] ASoC: Intel: common: add ACPI matching
	tables for EHL
Date: Thu, 15 Aug 2019 10:57:48 -0500
Message-ID: <20190815155749.29304-4-pierre-louis.bossart@linux.intel.com>
References: <20190815155749.29304-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7915F8015B
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 18:01:18 +0200 (CEST)
In-Reply-To: <20190815155749.29304-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pan Xiuli <xiuli.pan@linux.intel.com>

There are no upstream machine drivers just yet so just add dummy table
for compilation in nocodec-mode.

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi-intel-match.h           |  1 +
 sound/soc/intel/common/Makefile                |  2 +-
 .../intel/common/soc-acpi-intel-ehl-match.c    | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-ehl-match.c

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index ce6c4a970939..6c9929abd90b 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -26,6 +26,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_ehl_machines[];
 
 /*
  * generic table used for HDA codec-based platforms, possibly with
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index a14aca62ff96..18d9630ae9a2 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -8,7 +8,7 @@ snd-soc-acpi-intel-match-objs := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-m
 	soc-acpi-intel-skl-match.o soc-acpi-intel-kbl-match.o \
 	soc-acpi-intel-bxt-match.o soc-acpi-intel-glk-match.o \
 	soc-acpi-intel-cnl-match.o soc-acpi-intel-icl-match.o \
-	soc-acpi-intel-tgl-match.o \
+	soc-acpi-intel-tgl-match.o soc-acpi-intel-ehl-match.o \
 	soc-acpi-intel-hda-match.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
diff --git a/sound/soc/intel/common/soc-acpi-intel-ehl-match.c b/sound/soc/intel/common/soc-acpi-intel-ehl-match.c
new file mode 100644
index 000000000000..a1290c3fa99f
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-ehl-match.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * soc-apci-intel-ehl-match.c - tables and support for EHL ACPI enumeration.
+ *
+ * Copyright (c) 2019, Intel Corporation.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_ehl_machines[] = {
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_ehl_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
-- 
2.20.1
