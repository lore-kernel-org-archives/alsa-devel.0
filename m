From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: move all ACPI match tables to
	common module" to the asoc tree
Date: Sat, 21 Oct 2017 11:29:58 +0100 (BST)
Message-ID: <20171021102958.EBBFE440057@finisterre.ee.mobilebroadband>
References: <20171012234945.30318-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 36454267791
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 12:30:07 +0200 (CEST)
In-Reply-To: <20171012234945.30318-5-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: move all ACPI match tables to common module

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

>From 6004640638a2cb81c00c17ddf21ad572af964bbe Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 12 Oct 2017 18:49:41 -0500
Subject: [PATCH] ASoC: Intel: move all ACPI match tables to common module

First step of cleaning, move all tables to soc-acpi-intel-match module.
The tables remain in separate files per platform to keep them
manageable. Skylake+ platforms are still handled elsewhere since
there is no conflict with SOF for now, but this will have to be
handled at a later point.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-acpi-intel-match.h               |  32 +++
 sound/soc/intel/Kconfig                            |  24 +-
 sound/soc/intel/Makefile                           |   2 +-
 sound/soc/intel/atom/sst/sst_acpi.c                | 311 ++-------------------
 sound/soc/intel/common/Makefile                    |   2 +
 sound/soc/intel/common/soc-acpi-intel-byt-match.c  | 166 +++++++++++
 sound/soc/intel/common/soc-acpi-intel-cht-match.c  | 156 +++++++++++
 .../intel/common/soc-acpi-intel-hsw-bdw-match.c    |  52 ++++
 sound/soc/intel/common/sst-acpi.c                  |  44 +--
 9 files changed, 446 insertions(+), 343 deletions(-)
 create mode 100644 include/sound/soc-acpi-intel-match.h
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-byt-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-cht-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
new file mode 100644
index 000000000000..1a9191cd4bb3
--- /dev/null
+++ b/include/sound/soc-acpi-intel-match.h
@@ -0,0 +1,32 @@
+
+/*
+ * Copyright (C) 2017, Intel Corporation. All rights reserved.
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
+#ifndef __LINUX_SND_SOC_ACPI_INTEL_MATCH_H
+#define __LINUX_SND_SOC_ACPI_INTEL_MATCH_H
+
+#include <linux/stddef.h>
+#include <linux/acpi.h>
+
+/*
+ * these tables are not constants, some fields can be used for
+ * pdata or machine ops
+ */
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_legacy_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cherrytrail_machines[];
+
+#endif
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index d03199cc61e0..ec74d1d023d6 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -27,10 +27,14 @@ config SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST
 	select IOSF_MBI
 
+config SND_SOC_INTEL_COMMON
+	tristate
+
 config SND_SOC_INTEL_SST
 	tristate
+	select SND_SOC_INTEL_COMMON
 	select SND_SOC_INTEL_SST_ACPI if ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
@@ -39,7 +43,7 @@ config SND_SOC_INTEL_SST_FIRMWARE
 config SND_SOC_INTEL_SST_ACPI
 	tristate
 
-config SND_SOC_INTEL_SST_MATCH
+config SND_SOC_ACPI_INTEL_MATCH
 	tristate
 	select SND_SOC_ACPI if ACPI
 
@@ -145,7 +149,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 	select SND_SOC_RT5640
 	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5640 audio codec.
@@ -158,7 +162,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 	select SND_SOC_RT5651
 	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5651 audio codec.
@@ -171,7 +175,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         select SND_SOC_RT5670
         select SND_SST_ATOM_HIFI2_PLATFORM
         select SND_SST_IPC_ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
           platforms with RT5672 audio codec.
@@ -184,7 +188,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	select SND_SOC_RT5645
 	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with RT5645/5650 audio codec.
@@ -197,7 +201,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	select SND_SOC_TS3A227E
 	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
@@ -209,7 +213,7 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	select SND_SOC_DA7213
 	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
 	  platforms with DA7212/7213 audio codec.
@@ -221,7 +225,7 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	select SND_SOC_ES8316
 	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail &
 	  Cherrytrail platforms with ES8316 audio codec.
@@ -232,7 +236,7 @@ config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for the MinnowBoard Max or
 	  Up boards and provides access to I2S signals on the Low-Speed
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index cdd495f7ee2c..9105594436f0 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -1,5 +1,5 @@
 # Core support
-obj-$(CONFIG_SND_SOC_INTEL_SST) += common/
+obj-$(CONFIG_SND_SOC_INTEL_COMMON) += common/
 
 # Platform Support
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 8d82bc8dc4ac..32d6e02e2104 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -41,6 +41,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/iosf_mbi.h>
 #include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
 #include "../sst-mfld-platform.h"
 #include "../../common/sst-dsp.h"
 #include "sst.h"
@@ -238,19 +239,26 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	return 0;
 }
 
+static int is_byt(void)
+{
+	bool status = false;
+	static const struct x86_cpu_id cpu_ids[] = {
+		{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
+		{}
+	};
+	if (x86_match_cpu(cpu_ids))
+		status = true;
+	return status;
+}
 
 static int is_byt_cr(struct device *dev, bool *bytcr)
 {
 	int status = 0;
 
 	if (IS_ENABLED(CONFIG_IOSF_MBI)) {
-		static const struct x86_cpu_id cpu_ids[] = {
-			{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
-			{}
-		};
 		u32 bios_status;
 
-		if (!x86_match_cpu(cpu_ids) || !iosf_mbi_available()) {
+		if (!is_byt() || !iosf_mbi_available()) {
 			/* bail silently */
 			return status;
 		}
@@ -303,6 +311,10 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (is_byt())
+		mach->pdata = &byt_rvp_platform_data;
+	else
+		mach->pdata = &chv_platform_data;
 	pdata = mach->pdata;
 
 	ret = kstrtouint(id->id, 16, &dev_id);
@@ -380,294 +392,9 @@ static int sst_acpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static unsigned long cht_machine_id;
-
-#define CHT_SURFACE_MACH 1
-#define BYT_THINKPAD_10  2
-
-static int cht_surface_quirk_cb(const struct dmi_system_id *id)
-{
-	cht_machine_id = CHT_SURFACE_MACH;
-	return 1;
-}
-
-static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
-{
-	cht_machine_id = BYT_THINKPAD_10;
-	return 1;
-}
-
-
-static const struct dmi_system_id byt_table[] = {
-	{
-		.callback = byt_thinkpad10_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 10"),
-		},
-	},
-	{
-		.callback = byt_thinkpad10_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Tablet B"),
-		},
-	},
-	{
-		.callback = byt_thinkpad10_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),
-		},
-	},
-	{ }
-};
-
-static const struct dmi_system_id cht_table[] = {
-	{
-		.callback = cht_surface_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
-		},
-	},
-	{ }
-};
-
-
-static struct snd_soc_acpi_mach cht_surface_mach = {
-	.id = "10EC5640",
-	.drv_name = "cht-bsw-rt5645",
-	.fw_filename = "intel/fw_sst_22a8.bin",
-	.board = "cht-bsw",
-	.pdata = &chv_platform_data,
-};
-
-static struct snd_soc_acpi_mach byt_thinkpad_10 = {
-	.id = "10EC5640",
-	.drv_name = "cht-bsw-rt5672",
-	.fw_filename = "intel/fw_sst_0f28.bin",
-	.board = "cht-bsw",
-	.pdata = &byt_rvp_platform_data,
-};
-
-static struct snd_soc_acpi_mach *cht_quirk(void *arg)
-{
-	struct snd_soc_acpi_mach *mach = arg;
-
-	dmi_check_system(cht_table);
-
-	if (cht_machine_id == CHT_SURFACE_MACH)
-		return &cht_surface_mach;
-	else
-		return mach;
-}
-
-static struct snd_soc_acpi_mach *byt_quirk(void *arg)
-{
-	struct snd_soc_acpi_mach *mach = arg;
-
-	dmi_check_system(byt_table);
-
-	if (cht_machine_id == BYT_THINKPAD_10)
-		return &byt_thinkpad_10;
-	else
-		return mach;
-}
-
-
-static struct snd_soc_acpi_mach sst_acpi_bytcr[] = {
-	{
-		.id = "10EC5640",
-		.drv_name = "bytcr_rt5640",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcr_rt5640",
-		.machine_quirk = byt_quirk,
-		.pdata = &byt_rvp_platform_data,
-	},
-	{
-		.id = "10EC5642",
-		.drv_name = "bytcr_rt5640",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcr_rt5640",
-		.pdata = &byt_rvp_platform_data
-	},
-	{
-		.id = "INTCCFFD",
-		.drv_name = "bytcr_rt5640",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcr_rt5640",
-		.pdata = &byt_rvp_platform_data
-	},
-	{
-		.id = "10EC5651",
-		.drv_name = "bytcr_rt5651",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcr_rt5651",
-		.pdata = &byt_rvp_platform_data
-	},
-	{
-		.id = "DLGS7212",
-		.drv_name = "bytcht_da7213",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcht_da7213",
-		.pdata = &byt_rvp_platform_data
-	},
-	{
-		.id = "DLGS7213",
-		.drv_name = "bytcht_da7213",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcht_da7213",
-		.pdata = &byt_rvp_platform_data
-	},
-	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
-	{
-		.id = "10EC5645",
-		.drv_name = "cht-bsw-rt5645",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "cht-bsw",
-		.pdata = &byt_rvp_platform_data
-	},
-	{
-		.id = "10EC5648",
-		.drv_name = "cht-bsw-rt5645",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "cht-bsw",
-		.pdata = &byt_rvp_platform_data
-	},
-	/* use CHT driver to Baytrail Chromebooks */
-	{
-		.id = "193C9890",
-		.drv_name = "cht-bsw-max98090",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "cht-bsw",
-		.pdata = &byt_rvp_platform_data
-	},
-#if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
-	/*
-	 * This is always last in the table so that it is selected only when
-	 * enabled explicitly and there is no codec-related information in SSDT
-	 */
-	{
-		.id = "80860F28",
-		.drv_name = "bytcht_nocodec",
-		.fw_filename = "intel/fw_sst_0f28.bin",
-		.board = "bytcht_nocodec",
-		.pdata = &byt_rvp_platform_data
-	},
-#endif
-	{},
-};
-
-/* Cherryview-based platforms: CherryTrail and Braswell */
-static struct snd_soc_acpi_mach sst_acpi_chv[] = {
-	{
-		.id = "10EC5670",
-		.drv_name = "cht-bsw-rt5672",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "cht-bsw",
-		.pdata = &chv_platform_data
-	},
-	{
-		.id = "10EC5672",
-		.drv_name = "cht-bsw-rt5672",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "cht-bsw",
-		.pdata = &chv_platform_data
-	},
-	{
-		.id = "10EC5645",
-		.drv_name = "cht-bsw-rt5645",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "cht-bsw",
-		.pdata = &chv_platform_data
-	},
-	{
-		.id = "10EC5650",
-		.drv_name = "cht-bsw-rt5645",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "cht-bsw",
-		.pdata = &chv_platform_data
-	},
-	{
-		.id = "10EC3270",
-		.drv_name = "cht-bsw-rt5645",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "cht-bsw",
-		.pdata = &chv_platform_data
-	},
-
-	{
-		.id = "193C9890",
-		.drv_name = "cht-bsw-max98090",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "cht-bsw",
-		.pdata = &chv_platform_data
-	},
-	{
-		.id = "DLGS7212",
-		.drv_name = "bytcht_da7213",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "bytcht_da7213",
-		.pdata = &chv_platform_data
-	},
-	{
-		.id = "DLGS7213",
-		.drv_name = "bytcht_da7213",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "bytcht_da7213",
-		.pdata = &chv_platform_data
-	},
-	{
-		.id = "ESSX8316",
-		.drv_name = "bytcht_es8316",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "bytcht_es8316",
-		.pdata = &chv_platform_data
-	},
-	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
-	{
-		.id = "10EC5640",
-		.drv_name = "bytcr_rt5640",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "bytcr_rt5640",
-		.machine_quirk = cht_quirk,
-		.pdata = &chv_platform_data
-	},
-	{
-		.id = "10EC3276",
-		.drv_name = "bytcr_rt5640",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "bytcr_rt5640",
-		.pdata = &chv_platform_data
-	},
-	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
-	{
-		.id = "10EC5651",
-		.drv_name = "bytcr_rt5651",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "bytcr_rt5651",
-		.pdata = &chv_platform_data
-	},
-#if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
-	/*
-	 * This is always last in the table so that it is selected only when
-	 * enabled explicitly and there is no codec-related information in SSDT
-	 */
-	{
-		.id = "808622A8",
-		.drv_name = "bytcht_nocodec",
-		.fw_filename = "intel/fw_sst_22a8.bin",
-		.board = "bytcht_nocodec",
-		.pdata = &chv_platform_data
-	},
-#endif
-	{},
-};
-
 static const struct acpi_device_id sst_acpi_ids[] = {
-	{ "80860F28", (unsigned long)&sst_acpi_bytcr},
-	{ "808622A8", (unsigned long) &sst_acpi_chv},
+	{ "80860F28", (unsigned long)&snd_soc_acpi_intel_baytrail_machines},
+	{ "808622A8", (unsigned long)&snd_soc_acpi_intel_cherrytrail_machines},
 	{ },
 };
 
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 2c958ec3f4fd..cb29653319d9 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -2,7 +2,9 @@ snd-soc-sst-dsp-objs := sst-dsp.o
 snd-soc-sst-acpi-objs := sst-acpi.o
 snd-soc-sst-ipc-objs := sst-ipc.o
 snd-soc-sst-firmware-objs := sst-firmware.o
+snd-soc-acpi-intel-match-objs := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-match.o soc-acpi-intel-hsw-bdw-match.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_FIRMWARE) += snd-soc-sst-firmware.o
+obj-$(CONFIG_SND_SOC_ACPI_INTEL_MATCH) += snd-soc-acpi-intel-match.o
diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
new file mode 100644
index 000000000000..da80b4871a55
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -0,0 +1,166 @@
+/*
+ * soc-apci-intel-byt-match.c - tables and support for BYT ACPI enumeration.
+ *
+ * Copyright (c) 2017, Intel Corporation.
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
+
+#include <linux/dmi.h>
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+
+static unsigned long byt_machine_id;
+
+#define BYT_THINKPAD_10  1
+
+static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
+{
+	byt_machine_id = BYT_THINKPAD_10;
+	return 1;
+}
+
+
+static const struct dmi_system_id byt_table[] = {
+	{
+		.callback = byt_thinkpad10_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 10"),
+		},
+	},
+	{
+		.callback = byt_thinkpad10_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Tablet B"),
+		},
+	},
+	{
+		.callback = byt_thinkpad10_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),
+		},
+	},
+	{ }
+};
+
+static struct snd_soc_acpi_mach byt_thinkpad_10 = {
+	.id = "10EC5640",
+	.drv_name = "cht-bsw-rt5672",
+	.fw_filename = "intel/fw_sst_0f28.bin",
+	.board = "cht-bsw",
+};
+
+static struct snd_soc_acpi_mach *byt_quirk(void *arg)
+{
+	struct snd_soc_acpi_mach *mach = arg;
+
+	dmi_check_system(byt_table);
+
+	if (byt_machine_id == BYT_THINKPAD_10)
+		return &byt_thinkpad_10;
+	else
+		return mach;
+}
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_legacy_machines[] = {
+	{
+		.id = "10EC5640",
+		.drv_name = "byt-rt5640",
+		.fw_filename = "intel/fw_sst_0f28.bin-48kHz_i2s_master",
+	},
+	{
+		.id = "193C9890",
+		.drv_name = "byt-max98090",
+		.fw_filename = "intel/fw_sst_0f28.bin-48kHz_i2s_master",
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_baytrail_legacy_machines);
+
+struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
+	{
+		.id = "10EC5640",
+		.drv_name = "bytcr_rt5640",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcr_rt5640",
+		.machine_quirk = byt_quirk,
+	},
+	{
+		.id = "10EC5642",
+		.drv_name = "bytcr_rt5640",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcr_rt5640",
+	},
+	{
+		.id = "INTCCFFD",
+		.drv_name = "bytcr_rt5640",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcr_rt5640",
+	},
+	{
+		.id = "10EC5651",
+		.drv_name = "bytcr_rt5651",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcr_rt5651",
+	},
+	{
+		.id = "DLGS7212",
+		.drv_name = "bytcht_da7213",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcht_da7213",
+	},
+	{
+		.id = "DLGS7213",
+		.drv_name = "bytcht_da7213",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcht_da7213",
+	},
+	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
+	{
+		.id = "10EC5645",
+		.drv_name = "cht-bsw-rt5645",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "cht-bsw",
+	},
+	{
+		.id = "10EC5648",
+		.drv_name = "cht-bsw-rt5645",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "cht-bsw",
+	},
+	/* use CHT driver to Baytrail Chromebooks */
+	{
+		.id = "193C9890",
+		.drv_name = "cht-bsw-max98090",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "cht-bsw",
+	},
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
+	/*
+	 * This is always last in the table so that it is selected only when
+	 * enabled explicitly and there is no codec-related information in SSDT
+	 */
+	{
+		.id = "80860F28",
+		.drv_name = "bytcht_nocodec",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "bytcht_nocodec",
+	},
+#endif
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_baytrail_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
new file mode 100644
index 000000000000..73eb57706654
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -0,0 +1,156 @@
+/*
+ * soc-apci-intel-cht-match.c - tables and support for CHT ACPI enumeration.
+ *
+ * Copyright (c) 2017, Intel Corporation.
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
+
+#include <linux/dmi.h>
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+
+static unsigned long cht_machine_id;
+
+#define CHT_SURFACE_MACH 1
+
+static int cht_surface_quirk_cb(const struct dmi_system_id *id)
+{
+	cht_machine_id = CHT_SURFACE_MACH;
+	return 1;
+}
+
+static const struct dmi_system_id cht_table[] = {
+	{
+		.callback = cht_surface_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
+		},
+	},
+	{ }
+};
+
+
+static struct snd_soc_acpi_mach cht_surface_mach = {
+	.id = "10EC5640",
+	.drv_name = "cht-bsw-rt5645",
+	.fw_filename = "intel/fw_sst_22a8.bin",
+	.board = "cht-bsw",
+};
+
+static struct snd_soc_acpi_mach *cht_quirk(void *arg)
+{
+	struct snd_soc_acpi_mach *mach = arg;
+
+	dmi_check_system(cht_table);
+
+	if (cht_machine_id == CHT_SURFACE_MACH)
+		return &cht_surface_mach;
+	else
+		return mach;
+}
+
+/* Cherryview-based platforms: CherryTrail and Braswell */
+struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
+	{
+		.id = "10EC5670",
+		.drv_name = "cht-bsw-rt5672",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+	},
+	{
+		.id = "10EC5672",
+		.drv_name = "cht-bsw-rt5672",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+	},
+	{
+		.id = "10EC5645",
+		.drv_name = "cht-bsw-rt5645",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+	},
+	{
+		.id = "10EC5650",
+		.drv_name = "cht-bsw-rt5645",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+	},
+	{
+		.id = "10EC3270",
+		.drv_name = "cht-bsw-rt5645",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+	},
+	{
+		.id = "193C9890",
+		.drv_name = "cht-bsw-max98090",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "cht-bsw",
+	},
+	{
+		.id = "DLGS7212",
+		.drv_name = "bytcht_da7213",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcht_da7213",
+	},
+	{
+		.id = "DLGS7213",
+		.drv_name = "bytcht_da7213",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcht_da7213",
+	},
+	{
+		.id = "ESSX8316",
+		.drv_name = "bytcht_es8316",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcht_es8316",
+	},
+	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
+	{
+		.id = "10EC5640",
+		.drv_name = "bytcr_rt5640",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcr_rt5640",
+		.machine_quirk = cht_quirk,
+	},
+	{
+		.id = "10EC3276",
+		.drv_name = "bytcr_rt5640",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcr_rt5640",
+	},
+	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
+	{
+		.id = "10EC5651",
+		.drv_name = "bytcr_rt5651",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcr_rt5651",
+	},
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
+	/*
+	 * This is always last in the table so that it is selected only when
+	 * enabled explicitly and there is no codec-related information in SSDT
+	 */
+	{
+		.id = "808622A8",
+		.drv_name = "bytcht_nocodec",
+		.fw_filename = "intel/fw_sst_22a8.bin",
+		.board = "bytcht_nocodec",
+	},
+#endif
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_cherrytrail_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
new file mode 100644
index 000000000000..23329f2a802d
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -0,0 +1,52 @@
+/*
+ * soc-apci-intel-hsw-bdw-match.c - tables and support for ACPI enumeration.
+ *
+ * Copyright (c) 2017, Intel Corporation.
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
+
+#include <linux/dmi.h>
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[] = {
+	{
+		.id = "INT33CA",
+		.drv_name = "haswell-audio",
+		.fw_filename = "intel/IntcSST1.bin",
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_haswell_machines);
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
+	{
+		.id = "INT343A",
+		.drv_name = "broadwell-audio",
+		.fw_filename =  "intel/IntcSST2.bin",
+	},
+	{
+		.id = "RT5677CE",
+		.drv_name = "bdw-rt5677",
+		.fw_filename =  "intel/IntcSST2.bin",
+	},
+	{
+		.id = "INT33CA",
+		.drv_name = "haswell-audio",
+		.fw_filename = "intel/IntcSST2.bin",
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_broadwell_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 32d74ba70e4a..cf6fbbd4e378 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -22,6 +22,7 @@
 
 #include "sst-dsp.h"
 #include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
 
 #define SST_LPT_DSP_DMA_ADDR_OFFSET	0x0F0000
 #define SST_WPT_DSP_DMA_ADDR_OFFSET	0x0FE000
@@ -179,18 +180,9 @@ static int sst_acpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct snd_soc_acpi_mach haswell_machines[] = {
-	{
-		.id = "INT33CA",
-		.drv_name = "haswell-audio",
-		.fw_filename = "intel/IntcSST1.bin",
-	},
-	{}
-};
-
 static struct sst_acpi_desc sst_acpi_haswell_desc = {
 	.drv_name = "haswell-pcm-audio",
-	.machines = haswell_machines,
+	.machines = snd_soc_acpi_intel_haswell_machines,
 	.resindex_lpe_base = 0,
 	.resindex_pcicfg_base = 1,
 	.resindex_fw_base = -1,
@@ -201,23 +193,9 @@ static struct sst_acpi_desc sst_acpi_haswell_desc = {
 	.dma_size = SST_LPT_DSP_DMA_SIZE,
 };
 
-static struct snd_soc_acpi_mach broadwell_machines[] = {
-	{
-		.id = "INT343A",
-		.drv_name = "broadwell-audio",
-		.fw_filename =  "intel/IntcSST2.bin",
-	},
-	{
-		.id = "RT5677CE",
-		.drv_name = "bdw-rt5677",
-		.fw_filename =  "intel/IntcSST2.bin",
-	},
-	{}
-};
-
 static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 	.drv_name = "haswell-pcm-audio",
-	.machines = broadwell_machines,
+	.machines = snd_soc_acpi_intel_broadwell_machines,
 	.resindex_lpe_base = 0,
 	.resindex_pcicfg_base = 1,
 	.resindex_fw_base = -1,
@@ -229,23 +207,9 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 };
 
 #if !IS_ENABLED(CONFIG_SND_SST_IPC_ACPI)
-static struct snd_soc_acpi_mach baytrail_machines[] = {
-	{
-		.id = "10EC5640",
-		.drv_name = "byt-rt5640",
-		.fw_filename = "intel/fw_sst_0f28.bin-48kHz_i2s_master",
-	},
-	{
-		.id = "193C9890",
-		.drv_name = "byt-max98090",
-		.fw_filename = "intel/fw_sst_0f28.bin-48kHz_i2s_master",
-	},
-	{}
-};
-
 static struct sst_acpi_desc sst_acpi_baytrail_desc = {
 	.drv_name = "baytrail-pcm-audio",
-	.machines = baytrail_machines,
+	.machines = snd_soc_acpi_intel_baytrail_legacy_machines,
 	.resindex_lpe_base = 0,
 	.resindex_pcicfg_base = 1,
 	.resindex_fw_base = 2,
-- 
2.14.1
