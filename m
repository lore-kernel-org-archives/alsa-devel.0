From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 04/17] ASoC: Intel: Atom: auto-detection of
	Baytrail-CR
Date: Fri, 12 Aug 2016 16:27:47 -0500
Message-ID: <1471037280-17433-5-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 04AAD265FED
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:46 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

BYT-CR needs special handling to deal with BIOS issues.
For some reason the IPC interrupt index is also modified from
the Baytrail-T reference.

Use PUNIT BIOS config bits to infer platform details.
Assume regular Baytrail configs if status is incorrect or
CONFIG_IOSF_MBI is not enabled.

SSP0 routing issues are solved without dedicated firmware
in following patches

Tested on Asus T100TA and T100TAF.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 82 +++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 4d31849..0c2cc42 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -39,6 +39,8 @@
 #include <acpi/platform/aclinux.h>
 #include <acpi/actypes.h>
 #include <acpi/acpi_bus.h>
+#include <asm/cpu_device_id.h>
+#include <asm/iosf_mbi.h>
 #include "../sst-mfld-platform.h"
 #include "../../common/sst-dsp.h"
 #include "../../common/sst-acpi.h"
@@ -113,6 +115,28 @@ static const struct sst_res_info byt_rvp_res_info = {
 	.acpi_ipc_irq_index = 5,
 };
 
+/* BYTCR has different BIOS from BYT */
+static const struct sst_res_info bytcr_res_info = {
+	.shim_offset = 0x140000,
+	.shim_size = 0x000100,
+	.shim_phy_addr = SST_BYT_SHIM_PHY_ADDR,
+	.ssp0_offset = 0xa0000,
+	.ssp0_size = 0x1000,
+	.dma0_offset = 0x98000,
+	.dma0_size = 0x4000,
+	.dma1_offset = 0x9c000,
+	.dma1_size = 0x4000,
+	.iram_offset = 0x0c0000,
+	.iram_size = 0x14000,
+	.dram_offset = 0x100000,
+	.dram_size = 0x28000,
+	.mbox_offset = 0x144000,
+	.mbox_size = 0x1000,
+	.acpi_lpe_res_index = 0,
+	.acpi_ddr_index = 2,
+	.acpi_ipc_irq_index = 0
+};
+
 static struct sst_platform_info byt_rvp_platform_data = {
 	.probe_data = &byt_fwparse_info,
 	.ipc_info = &byt_ipc_info,
@@ -215,6 +239,47 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	return 0;
 }
 
+
+static int is_byt_cr(struct device *dev, bool *bytcr)
+{
+	int status = 0;
+
+	if (IS_ENABLED(CONFIG_IOSF_MBI)) {
+		static const struct x86_cpu_id cpu_ids[] __initconst = {
+			{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
+			{}
+		};
+		int status;
+		u32 bios_status;
+
+		if (!x86_match_cpu(cpu_ids) || !iosf_mbi_available()) {
+			/* bail silently */
+			return status;
+		}
+
+		status = iosf_mbi_read(BT_MBI_UNIT_PMC, /* 0x04 PUNIT */
+				       MBI_REG_READ, /* 0x10 */
+				       0x006, /* BIOS_CONFIG */
+				       &bios_status);
+
+		if (status) {
+			dev_err(dev, "could not read PUNIT BIOS_CONFIG\n");
+		} else {
+			/* bits 26:27 mirror PMIC options */
+			bios_status = (bios_status >> 26) & 3;
+
+			if ((bios_status == 1) || (bios_status == 3))
+				*bytcr = true;
+			else
+				dev_info(dev, "BYT-CR not detected\n");
+		}
+	} else {
+		dev_info(dev, "IOSF_MBI not enabled, no BYT-CR detection\n");
+	}
+	return status;
+}
+
+
 static int sst_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -226,6 +291,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	struct platform_device *plat_dev;
 	struct sst_platform_info *pdata;
 	unsigned int dev_id;
+	bool bytcr = false;
 
 	id = acpi_match_device(dev->driver->acpi_match_table, dev);
 	if (!id)
@@ -251,6 +317,18 @@ static int sst_acpi_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "ACPI device id: %x\n", dev_id);
 
+	ret = sst_alloc_drv_context(&ctx, dev, dev_id);
+	if (ret < 0)
+		return ret;
+
+	ret = is_byt_cr(dev, &bytcr);
+	if (!((ret < 0) || (bytcr == false))) {
+		dev_info(dev, "Detected Baytrail-CR platform\n");
+
+		/* override resource info */
+		byt_rvp_platform_data.res_info = &bytcr_res_info;
+	}
+
 	plat_dev = platform_device_register_data(dev, pdata->platform, -1,
 						NULL, 0);
 	if (IS_ERR(plat_dev)) {
@@ -271,10 +349,6 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		return PTR_ERR(mdev);
 	}
 
-	ret = sst_alloc_drv_context(&ctx, dev, dev_id);
-	if (ret < 0)
-		return ret;
-
 	/* Fill sst platform data */
 	ctx->pdata = pdata;
 	strcpy(ctx->firmware_name, mach->fw_filename);
-- 
2.5.0
