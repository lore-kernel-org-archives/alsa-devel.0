From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/6] ASoC: Intel: Atom: move atom driver to
	common acpi match
Date: Thu,  5 Nov 2015 21:34:12 +0530
Message-ID: <1446739455-22332-4-git-send-email-vinod.koul@intel.com>
References: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A0C1266176
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:01:06 +0100 (CET)
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

This patch moves the atom driver to use the common acpi match
functions.  Since atom driver has few more information in machine
table, these are appended to table and set to NULL for common
driver

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig             |  1 +
 sound/soc/intel/atom/sst/sst_acpi.c | 67 +++++++++++--------------------------
 sound/soc/intel/common/sst-acpi.c   |  8 ++---
 sound/soc/intel/common/sst-acpi.h   |  5 +++
 4 files changed, 29 insertions(+), 52 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 7b778ab85f8b..13a762172b5d 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -24,6 +24,7 @@ config SND_SST_IPC_PCI
 config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
+	select SND_SOC_INTEL_SST
 	depends on ACPI
 
 config SND_SOC_INTEL_SST
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index bb19b5801466..f3d109eb3800 100644
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
index 94a43e6fcf88..7a85c576dad3 100644
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
index 1dc059590ead..3ee3b7ab5d03 100644
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
1.9.1
