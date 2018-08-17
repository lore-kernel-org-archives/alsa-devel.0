From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v7 1/7] ASoC: Intel: common: add table for
	HDA-based platforms
Date: Fri, 17 Aug 2018 15:37:17 -0500
Message-ID: <20180817203723.32305-2-pierre-louis.bossart@linux.intel.com>
References: <20180817203723.32305-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A99626779C
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2018 22:37:29 +0200 (CEST)
In-Reply-To: <20180817203723.32305-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Expose a table containing machine driver information for HDAudio-based
platforms handled by ASoC on Intel hardware.

We only set constant values that are valid across multiple
platforms. The firmware name used by the DSP will be set dynamically
for each platform.

The table is made of a single entry for now, if we need more
complicated set-up where HDAudio is mixed with ACPI-enumerated devices
(I2C, SoundWire) then we'd expect the differentiation to be handled
through information provided by the BIOS (as done for KBL
Chromebooks).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi-intel-match.h          |  6 +++
 sound/soc/intel/common/Makefile               |  3 +-
 .../intel/common/soc-acpi-intel-hda-match.c   | 40 +++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-hda-match.c

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index bb1d24b703fb..f48f59e5b7b0 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -25,4 +25,10 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[];
 
+/*
+ * generic table used for HDA codec-based platforms, possibly with
+ * additional ACPI-enumerated codecs
+ */
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_hda_machines[];
+
 #endif
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 915a34cdc8ac..c1f50a079d34 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -7,7 +7,8 @@ snd-soc-acpi-intel-match-objs := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-m
 	soc-acpi-intel-hsw-bdw-match.o \
 	soc-acpi-intel-skl-match.o soc-acpi-intel-kbl-match.o \
 	soc-acpi-intel-bxt-match.o soc-acpi-intel-glk-match.o \
-	soc-acpi-intel-cnl-match.o
+	soc-acpi-intel-cnl-match.o \
+	soc-acpi-intel-hda-match.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
diff --git a/sound/soc/intel/common/soc-acpi-intel-hda-match.c b/sound/soc/intel/common/soc-acpi-intel-hda-match.c
new file mode 100644
index 000000000000..533c1064f84b
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-hda-match.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Intel Corporation.
+
+/*
+ * soc-apci-intel-hda-match.c - tables and support for HDA+ACPI enumeration.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include "../skylake/skl.h"
+
+static struct skl_machine_pdata hda_pdata = {
+	.use_tplg_pcm = true,
+};
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_hda_machines[] = {
+	{
+		/* .id is not used in this file */
+		.drv_name = "skl_hda_dsp_generic",
+
+		/* .fw_filename is dynamically set in skylake driver */
+
+		/* .sof_fw_filename is dynamically set in sof/intel driver */
+
+		.sof_tplg_filename = "intel/sof-hda-generic.tplg",
+
+		/*
+		 * .machine_quirk and .quirk_data are not used here but
+		 * can be used if we need a more complicated machine driver
+		 * combining HDA+other device (e.g. DMIC).
+		 */
+		.pdata = &hda_pdata,
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_hda_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
-- 
2.17.1
