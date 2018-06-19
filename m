From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: move SKL+ codec ACPI tables to
	common directory" to the asoc tree
Date: Tue, 19 Jun 2018 16:24:39 +0100
Message-ID: <E1fVIUp-0002PC-V3@debutante>
References: <20180618182942.4925-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B17DD2676D8
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 17:24:42 +0200 (CEST)
In-Reply-To: <20180618182942.4925-4-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: move SKL+ codec ACPI tables to common directory

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

>From cbaa7f0bdbee1969bb311c641abbd0d2af6ba861 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 18 Jun 2018 13:29:37 -0500
Subject: [PATCH] ASoC: Intel: move SKL+ codec ACPI tables to common directory

No functionality change, just move to common tables to make it easier
to deal with SOF and share the same machine drivers - as done
previously for BYT/CHT/HSW/BDW.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-acpi-intel-match.h          |   5 +
 sound/soc/intel/common/Makefile               |   6 +-
 .../intel/common/soc-acpi-intel-bxt-match.c   |  35 ++++
 .../intel/common/soc-acpi-intel-cnl-match.c   |  29 ++++
 .../intel/common/soc-acpi-intel-glk-match.c   |  23 +++
 .../intel/common/soc-acpi-intel-kbl-match.c   |  91 ++++++++++
 .../intel/common/soc-acpi-intel-skl-match.c   |  47 +++++
 sound/soc/intel/skylake/skl.c                 | 162 +-----------------
 8 files changed, 241 insertions(+), 157 deletions(-)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-bxt-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-cnl-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-glk-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-kbl-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-skl-match.c

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index 9da6388c20a1..917ddd0f2762 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -29,5 +29,10 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_legacy_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cherrytrail_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_skl_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[];
 
 #endif
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 7379d8830c39..915a34cdc8ac 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -3,7 +3,11 @@ snd-soc-sst-dsp-objs := sst-dsp.o
 snd-soc-sst-acpi-objs := sst-acpi.o
 snd-soc-sst-ipc-objs := sst-ipc.o
 snd-soc-sst-firmware-objs := sst-firmware.o
-snd-soc-acpi-intel-match-objs := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-match.o soc-acpi-intel-hsw-bdw-match.o
+snd-soc-acpi-intel-match-objs := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-match.o \
+	soc-acpi-intel-hsw-bdw-match.o \
+	soc-acpi-intel-skl-match.o soc-acpi-intel-kbl-match.o \
+	soc-acpi-intel-bxt-match.o soc-acpi-intel-glk-match.o \
+	soc-acpi-intel-cnl-match.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
new file mode 100644
index 000000000000..569f1de97e82
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * soc-apci-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
+ *
+ * Copyright (c) 2018, Intel Corporation.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+
+static struct snd_soc_acpi_codecs bxt_codecs = {
+	.num_codecs = 1,
+	.codecs = {"MX98357A"}
+};
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
+	{
+		.id = "INT343A",
+		.drv_name = "bxt_alc298s_i2s",
+		.fw_filename = "intel/dsp_fw_bxtn.bin",
+	},
+	{
+		.id = "DLGS7219",
+		.drv_name = "bxt_da7219_max98357a",
+		.fw_filename = "intel/dsp_fw_bxtn.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &bxt_codecs,
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_bxt_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
new file mode 100644
index 000000000000..b83ee053d417
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * soc-apci-intel-cnl-match.c - tables and support for CNL ACPI enumeration.
+ *
+ * Copyright (c) 2018, Intel Corporation.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include "../skylake/skl.h"
+
+static struct skl_machine_pdata cnl_pdata = {
+	.use_tplg_pcm = true,
+};
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[] = {
+	{
+		.id = "INT34C2",
+		.drv_name = "cnl_rt274",
+		.fw_filename = "intel/dsp_fw_cnl.bin",
+		.pdata = &cnl_pdata,
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_cnl_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
new file mode 100644
index 000000000000..dee09439e7cb
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * soc-apci-intel-glk-match.c - tables and support for GLK ACPI enumeration.
+ *
+ * Copyright (c) 2018, Intel Corporation.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
+	{
+		.id = "INT343A",
+		.drv_name = "glk_alc298s_i2s",
+		.fw_filename = "intel/dsp_fw_glk.bin",
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_glk_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
new file mode 100644
index 000000000000..0ee173ca437d
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * soc-apci-intel-kbl-match.c - tables and support for KBL ACPI enumeration.
+ *
+ * Copyright (c) 2018, Intel Corporation.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include "../skylake/skl.h"
+
+static struct skl_machine_pdata skl_dmic_data;
+
+static struct snd_soc_acpi_codecs kbl_codecs = {
+	.num_codecs = 1,
+	.codecs = {"10508825"}
+};
+
+static struct snd_soc_acpi_codecs kbl_poppy_codecs = {
+	.num_codecs = 1,
+	.codecs = {"10EC5663"}
+};
+
+static struct snd_soc_acpi_codecs kbl_5663_5514_codecs = {
+	.num_codecs = 2,
+	.codecs = {"10EC5663", "10EC5514"}
+};
+
+static struct snd_soc_acpi_codecs kbl_7219_98357_codecs = {
+	.num_codecs = 1,
+	.codecs = {"MX98357A"}
+};
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
+	{
+		.id = "INT343A",
+		.drv_name = "kbl_alc286s_i2s",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+	},
+	{
+		.id = "INT343B",
+		.drv_name = "kbl_n88l25_s4567",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &kbl_codecs,
+		.pdata = &skl_dmic_data,
+	},
+	{
+		.id = "MX98357A",
+		.drv_name = "kbl_n88l25_m98357a",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &kbl_codecs,
+		.pdata = &skl_dmic_data,
+	},
+	{
+		.id = "MX98927",
+		.drv_name = "kbl_r5514_5663_max",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &kbl_5663_5514_codecs,
+		.pdata = &skl_dmic_data,
+	},
+	{
+		.id = "MX98927",
+		.drv_name = "kbl_rt5663_m98927",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &kbl_poppy_codecs,
+		.pdata = &skl_dmic_data,
+	},
+	{
+		.id = "10EC5663",
+		.drv_name = "kbl_rt5663",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+	},
+	{
+		.id = "DLGS7219",
+		.drv_name = "kbl_da7219_max98357a",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &kbl_7219_98357_codecs,
+		.pdata = &skl_dmic_data,
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_kbl_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
diff --git a/sound/soc/intel/common/soc-acpi-intel-skl-match.c b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
new file mode 100644
index 000000000000..0c9c0edd35b3
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * soc-apci-intel-skl-match.c - tables and support for SKL ACPI enumeration.
+ *
+ * Copyright (c) 2018, Intel Corporation.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include "../skylake/skl.h"
+
+static struct skl_machine_pdata skl_dmic_data;
+
+static struct snd_soc_acpi_codecs skl_codecs = {
+	.num_codecs = 1,
+	.codecs = {"10508825"}
+};
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_skl_machines[] = {
+	{
+		.id = "INT343A",
+		.drv_name = "skl_alc286s_i2s",
+		.fw_filename = "intel/dsp_fw_release.bin",
+	},
+	{
+		.id = "INT343B",
+		.drv_name = "skl_n88l25_s4567",
+		.fw_filename = "intel/dsp_fw_release.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &skl_codecs,
+		.pdata = &skl_dmic_data,
+	},
+	{
+		.id = "MX98357A",
+		.drv_name = "skl_n88l25_m98357a",
+		.fw_filename = "intel/dsp_fw_release.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &skl_codecs,
+		.pdata = &skl_dmic_data,
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_skl_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 6dec748e8949..670ff9aaca55 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <sound/pcm.h>
 #include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
 #include <sound/hda_register.h>
 #include <sound/hdaudio.h>
 #include <sound/hda_i915.h>
@@ -36,8 +37,6 @@
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
 
-static struct skl_machine_pdata skl_dmic_data;
-
 /*
  * initialize the PCI registers
  */
@@ -1026,172 +1025,23 @@ static void skl_remove(struct pci_dev *pci)
 	dev_set_drvdata(&pci->dev, NULL);
 }
 
-static struct snd_soc_acpi_codecs skl_codecs = {
-	.num_codecs = 1,
-	.codecs = {"10508825"}
-};
-
-static struct snd_soc_acpi_codecs kbl_codecs = {
-	.num_codecs = 1,
-	.codecs = {"10508825"}
-};
-
-static struct snd_soc_acpi_codecs bxt_codecs = {
-	.num_codecs = 1,
-	.codecs = {"MX98357A"}
-};
-
-static struct snd_soc_acpi_codecs kbl_poppy_codecs = {
-	.num_codecs = 1,
-	.codecs = {"10EC5663"}
-};
-
-static struct snd_soc_acpi_codecs kbl_5663_5514_codecs = {
-	.num_codecs = 2,
-	.codecs = {"10EC5663", "10EC5514"}
-};
-
-static struct snd_soc_acpi_codecs kbl_7219_98357_codecs = {
-	.num_codecs = 1,
-	.codecs = {"MX98357A"}
-};
-
-static struct skl_machine_pdata cnl_pdata = {
-	.use_tplg_pcm = true,
-};
-
-static struct snd_soc_acpi_mach sst_skl_devdata[] = {
-	{
-		.id = "INT343A",
-		.drv_name = "skl_alc286s_i2s",
-		.fw_filename = "intel/dsp_fw_release.bin",
-	},
-	{
-		.id = "INT343B",
-		.drv_name = "skl_n88l25_s4567",
-		.fw_filename = "intel/dsp_fw_release.bin",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &skl_codecs,
-		.pdata = &skl_dmic_data
-	},
-	{
-		.id = "MX98357A",
-		.drv_name = "skl_n88l25_m98357a",
-		.fw_filename = "intel/dsp_fw_release.bin",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &skl_codecs,
-		.pdata = &skl_dmic_data
-	},
-	{}
-};
-
-static struct snd_soc_acpi_mach sst_bxtp_devdata[] = {
-	{
-		.id = "INT343A",
-		.drv_name = "bxt_alc298s_i2s",
-		.fw_filename = "intel/dsp_fw_bxtn.bin",
-	},
-	{
-		.id = "DLGS7219",
-		.drv_name = "bxt_da7219_max98357a",
-		.fw_filename = "intel/dsp_fw_bxtn.bin",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &bxt_codecs,
-	},
-	{}
-};
-
-static struct snd_soc_acpi_mach sst_kbl_devdata[] = {
-	{
-		.id = "INT343A",
-		.drv_name = "kbl_alc286s_i2s",
-		.fw_filename = "intel/dsp_fw_kbl.bin",
-	},
-	{
-		.id = "INT343B",
-		.drv_name = "kbl_n88l25_s4567",
-		.fw_filename = "intel/dsp_fw_kbl.bin",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &kbl_codecs,
-		.pdata = &skl_dmic_data
-	},
-	{
-		.id = "MX98357A",
-		.drv_name = "kbl_n88l25_m98357a",
-		.fw_filename = "intel/dsp_fw_kbl.bin",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &kbl_codecs,
-		.pdata = &skl_dmic_data
-	},
-	{
-		.id = "MX98927",
-		.drv_name = "kbl_r5514_5663_max",
-		.fw_filename = "intel/dsp_fw_kbl.bin",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &kbl_5663_5514_codecs,
-		.pdata = &skl_dmic_data
-	},
-	{
-		.id = "MX98927",
-		.drv_name = "kbl_rt5663_m98927",
-		.fw_filename = "intel/dsp_fw_kbl.bin",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &kbl_poppy_codecs,
-		.pdata = &skl_dmic_data
-	},
-	{
-		.id = "10EC5663",
-		.drv_name = "kbl_rt5663",
-		.fw_filename = "intel/dsp_fw_kbl.bin",
-	},
-	{
-		.id = "DLGS7219",
-		.drv_name = "kbl_da7219_max98357a",
-		.fw_filename = "intel/dsp_fw_kbl.bin",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &kbl_7219_98357_codecs,
-		.pdata = &skl_dmic_data
-	},
-
-	{}
-};
-
-static struct snd_soc_acpi_mach sst_glk_devdata[] = {
-	{
-		.id = "INT343A",
-		.drv_name = "glk_alc298s_i2s",
-		.fw_filename = "intel/dsp_fw_glk.bin",
-	},
-	{}
-};
-
-static const struct snd_soc_acpi_mach sst_cnl_devdata[] = {
-	{
-		.id = "INT34C2",
-		.drv_name = "cnl_rt274",
-		.fw_filename = "intel/dsp_fw_cnl.bin",
-		.pdata = &cnl_pdata,
-	},
-	{}
-};
-
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
-		.driver_data = (unsigned long)&sst_skl_devdata},
+		.driver_data = (unsigned long)&snd_soc_acpi_intel_skl_machines},
 	/* BXT-P */
 	{ PCI_DEVICE(0x8086, 0x5a98),
-		.driver_data = (unsigned long)&sst_bxtp_devdata},
+		.driver_data = (unsigned long)&snd_soc_acpi_intel_bxt_machines},
 	/* KBL */
 	{ PCI_DEVICE(0x8086, 0x9D71),
-		.driver_data = (unsigned long)&sst_kbl_devdata},
+		.driver_data = (unsigned long)&snd_soc_acpi_intel_kbl_machines},
 	/* GLK */
 	{ PCI_DEVICE(0x8086, 0x3198),
-		.driver_data = (unsigned long)&sst_glk_devdata},
+		.driver_data = (unsigned long)&snd_soc_acpi_intel_glk_machines},
 	/* CNL */
 	{ PCI_DEVICE(0x8086, 0x9dc8),
-		.driver_data = (unsigned long)&sst_cnl_devdata},
+		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
2.17.1
