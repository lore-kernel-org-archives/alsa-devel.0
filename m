From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: add ACPI matching tables
	for ICL" to the asoc tree
Date: Mon,  3 Dec 2018 12:07:09 +0000 (GMT)
Message-ID: <20181203120709.9E960440080@finisterre.ee.mobilebroadband>
References: <20181201005437.5198-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EEE6A26770D
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2018 13:07:10 +0100 (CET)
In-Reply-To: <20181201005437.5198-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: common: add ACPI matching tables for ICL

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9923e9072d813e2efa591d01e6971e0833c38815 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 30 Nov 2018 18:54:37 -0600
Subject: [PATCH] ASoC: Intel: common: add ACPI matching tables for ICL

Entry needed for ICL RVP w/ RT274

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.0.rc1
