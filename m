From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: move atom driver to common
	acpi match" to the asoc tree
Date: Thu, 05 Nov 2015 16:29:41 +0000
Message-ID: <E1ZuNPx-0001Km-Dd@finisterre>
References: <1446739455-22332-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 35DB02663F6
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:29:53 +0100 (CET)
In-Reply-To: <1446739455-22332-4-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Atom: move atom driver to common acpi match

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

>From 0f021f92962ec6441ba8cd10e149bbfd893988f0 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 5 Nov 2015 21:34:12 +0530
Subject: [PATCH] ASoC: Intel: Atom: move atom driver to common acpi match

This patch moves the atom driver to use the common acpi match
functions.  Since atom driver has few more information in machine
table, these are appended to table and set to NULL for common
driver

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig             |  1 +
 sound/soc/intel/atom/sst/sst_acpi.c | 67 +++++++++++--------------------------
 sound/soc/intel/common/sst-acpi.c   |  8 ++---
 sound/soc/intel/common/sst-acpi.h   |  5 +++
 4 files changed, 29 insertions(+), 52 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 6d67357..043a873 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -23,6 +23,7 @@ config SND_SST_IPC_PCI
 config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
+	select SND_SOC_INTEL_SST
 	depends on ACPI
 
 config SND_SOC_INTEL_SST
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index bb19b58..f3d109e 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -40,18 +40,9 @@
 #include <acpi/acpi_bus.h>
 #include "../sst-mfld-platform.h"
 #include "../../common/sst-dsp.h"
+#include "../../common/sst-acpi.h"
 #include "sst.h"
 
-struct sst_machines {
-	char *codec_id;
-	char board[32];
-	char machine[32];
-	void (*machine_quirk)(void);
-	char firmware[FW_NAME_SIZE];
-	struct sst_platform_info *pdata;
-
-};
-
 /* LPE viewpoint addresses */
 #define SST_BYT_IRAM_PHY_START	0xff2c0000
 #define SST_BYT_IRAM_PHY_END	0xff2d4000
@@ -223,37 +214,16 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	return 0;
 }
 
-static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
-				       void *context, void **ret)
-{
-	*(bool *)context = true;
-	return AE_OK;
-}
-
-static struct sst_machines *sst_acpi_find_machine(
-	struct sst_machines *machines)
-{
-	struct sst_machines *mach;
-	bool found = false;
-
-	for (mach = machines; mach->codec_id; mach++)
-		if (ACPI_SUCCESS(acpi_get_devices(mach->codec_id,
-						  sst_acpi_mach_match,
-						  &found, NULL)) && found)
-			return mach;
-
-	return NULL;
-}
-
 static int sst_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	int ret = 0;
 	struct intel_sst_drv *ctx;
 	const struct acpi_device_id *id;
-	struct sst_machines *mach;
+	struct sst_acpi_mach *mach;
 	struct platform_device *mdev;
 	struct platform_device *plat_dev;
+	struct sst_platform_info *pdata;
 	unsigned int dev_id;
 
 	id = acpi_match_device(dev->driver->acpi_match_table, dev);
@@ -261,12 +231,13 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	dev_dbg(dev, "for %s", id->id);
 
-	mach = (struct sst_machines *)id->driver_data;
+	mach = (struct sst_acpi_mach *)id->driver_data;
 	mach = sst_acpi_find_machine(mach);
 	if (mach == NULL) {
 		dev_err(dev, "No matching machine driver found\n");
 		return -ENODEV;
 	}
+	pdata = mach->pdata;
 
 	ret = kstrtouint(id->id, 16, &dev_id);
 	if (ret < 0) {
@@ -276,16 +247,16 @@ static int sst_acpi_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "ACPI device id: %x\n", dev_id);
 
-	plat_dev = platform_device_register_data(dev, mach->pdata->platform, -1, NULL, 0);
+	plat_dev = platform_device_register_data(dev, pdata->platform, -1, NULL, 0);
 	if (IS_ERR(plat_dev)) {
-		dev_err(dev, "Failed to create machine device: %s\n", mach->pdata->platform);
+		dev_err(dev, "Failed to create machine device: %s\n", pdata->platform);
 		return PTR_ERR(plat_dev);
 	}
 
 	/* Create platform device for sst machine driver */
-	mdev = platform_device_register_data(dev, mach->machine, -1, NULL, 0);
+	mdev = platform_device_register_data(dev, mach->drv_name, -1, NULL, 0);
 	if (IS_ERR(mdev)) {
-		dev_err(dev, "Failed to create machine device: %s\n", mach->machine);
+		dev_err(dev, "Failed to create machine device: %s\n", mach->drv_name);
 		return PTR_ERR(mdev);
 	}
 
@@ -294,8 +265,8 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Fill sst platform data */
-	ctx->pdata = mach->pdata;
-	strcpy(ctx->firmware_name, mach->firmware);
+	ctx->pdata = pdata;
+	strcpy(ctx->firmware_name, mach->fw_filename);
 
 	ret = sst_platform_get_resources(ctx);
 	if (ret)
@@ -342,22 +313,22 @@ static int sst_acpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct sst_machines sst_acpi_bytcr[] = {
-	{"10EC5640", "T100", "bytt100_rt5640", NULL, "intel/fw_sst_0f28.bin",
+static struct sst_acpi_mach sst_acpi_bytcr[] = {
+	{"10EC5640", "bytt100_rt5640", "intel/fw_sst_0f28.bin", "T100", NULL,
 						&byt_rvp_platform_data },
 	{},
 };
 
 /* Cherryview-based platforms: CherryTrail and Braswell */
-static struct sst_machines sst_acpi_chv[] = {
-	{"10EC5670", "cht-bsw", "cht-bsw-rt5672", NULL, "intel/fw_sst_22a8.bin",
+static struct sst_acpi_mach sst_acpi_chv[] = {
+	{"10EC5670", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
+						&chv_platform_data },
+	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
-	{"10EC5645", "cht-bsw", "cht-bsw-rt5645", NULL, "intel/fw_sst_22a8.bin",
+	{"10EC5650", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
-	{"10EC5650", "cht-bsw", "cht-bsw-rt5645", NULL, "intel/fw_sst_22a8.bin",
+	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
-	{"193C9890", "cht-bsw", "cht-bsw-max98090", NULL,
-	"intel/fw_sst_22a8.bin", &chv_platform_data },
 	{},
 };
 
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 94a43e6..7a85c57 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -180,7 +180,7 @@ static int sst_acpi_remove(struct platform_device *pdev)
 }
 
 static struct sst_acpi_mach haswell_machines[] = {
-	{ "INT33CA", "haswell-audio", "intel/IntcSST1.bin" },
+	{ "INT33CA", "haswell-audio", "intel/IntcSST1.bin", NULL, NULL, NULL },
 	{}
 };
 
@@ -198,7 +198,7 @@ static struct sst_acpi_desc sst_acpi_haswell_desc = {
 };
 
 static struct sst_acpi_mach broadwell_machines[] = {
-	{ "INT343A", "broadwell-audio", "intel/IntcSST2.bin" },
+	{ "INT343A", "broadwell-audio", "intel/IntcSST2.bin", NULL, NULL, NULL },
 	{}
 };
 
@@ -216,8 +216,8 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 };
 
 static struct sst_acpi_mach baytrail_machines[] = {
-	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
-	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
+	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master", NULL, NULL, NULL },
+	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master", NULL, NULL, NULL },
 	{}
 };
 
diff --git a/sound/soc/intel/common/sst-acpi.h b/sound/soc/intel/common/sst-acpi.h
index 1dc0595..3ee3b7a 100644
--- a/sound/soc/intel/common/sst-acpi.h
+++ b/sound/soc/intel/common/sst-acpi.h
@@ -25,4 +25,9 @@ struct sst_acpi_mach {
 	const char *drv_name;
 	/* firmware file name */
 	const char *fw_filename;
+
+	/* board name */
+	const char *board;
+	void (*machine_quirk)(void);
+	void *pdata;
 };
-- 
2.6.1
