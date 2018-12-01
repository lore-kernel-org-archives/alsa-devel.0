From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: common: add ACPI matching
	tables for ICL
Date: Fri, 30 Nov 2018 18:54:37 -0600
Message-ID: <20181201005437.5198-3-pierre-louis.bossart@linux.intel.com>
References: <20181201005437.5198-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 73E10267B9E
 for <alsa-devel@alsa-project.org>; Sat,  1 Dec 2018 01:54:59 +0100 (CET)
In-Reply-To: <20181201005437.5198-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Entry needed for ICL RVP w/ RT274

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi-intel-match.h          |  1 +
 sound/soc/intel/common/Makefile               |  2 +-
 .../intel/common/soc-acpi-intel-icl-match.c   | 32 +++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-icl-match.c

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index f48f59e5b7b0..bb5e1e4ce8bf 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -24,6 +24,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[];
 
 /*
  * generic table used for HDA codec-based platforms, possibly with
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index c1f50a079d34..56c81e20b5bf 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -7,7 +7,7 @@ snd-soc-acpi-intel-match-objs := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-m
 	soc-acpi-intel-hsw-bdw-match.o \
 	soc-acpi-intel-skl-match.o soc-acpi-intel-kbl-match.o \
 	soc-acpi-intel-bxt-match.o soc-acpi-intel-glk-match.o \
-	soc-acpi-intel-cnl-match.o \
+	soc-acpi-intel-cnl-match.o soc-acpi-intel-icl-match.o \
 	soc-acpi-intel-hda-match.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
new file mode 100644
index 000000000000..33b441dca4d3
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * soc-apci-intel-icl-match.c - tables and support for ICL ACPI enumeration.
+ *
+ * Copyright (c) 2018, Intel Corporation.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include "../skylake/skl.h"
+
+static struct skl_machine_pdata icl_pdata = {
+	.use_tplg_pcm = true,
+};
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[] = {
+	{
+		.id = "INT34C2",
+		.drv_name = "icl_rt274",
+		.fw_filename = "intel/dsp_fw_icl.bin",
+		.pdata = &icl_pdata,
+		.sof_fw_filename = "intel/sof-icl.ri",
+		.sof_tplg_filename = "intel/sof-icl-rt274.tplg",
+		.asoc_plat_name = "0000:00:1f.3",
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_icl_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
-- 
2.17.1
