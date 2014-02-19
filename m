From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: sst-acpi: Add support for
	multiple machine drivers per platform
Date: Wed, 19 Feb 2014 16:35:58 +0200
Message-ID: <1392820558-27548-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5585226565B
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 15:36:32 +0100 (CET)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Initial implementation of this driver focused only matching SST ACPI ID
with single machine driver and same firmware file per platform. It was known
restriction to be improved incrementally.

This patch is now changing this that SST ACPI ID refers purely to platform
specific data which refers to machine drivers on this platform, not vice
versa.

Matching machine driver is found by looking at ACPI ID which would best
match with the driver. Typically this would be the ACPI ID of audio codec
but is not tied to it.

This patch also changes that DSP firmware name is machine not platform
specific.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
This goes on top of my "[PATCHv2] ASoC: Intel: sst-acpi: Request firmware
before SST platform driver probing".
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/072812.html
---
 sound/soc/intel/sst-acpi.c | 84 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/sound/soc/intel/sst-acpi.c b/sound/soc/intel/sst-acpi.c
index 64154a77d904..c7e36c9ee52f 100644
--- a/sound/soc/intel/sst-acpi.c
+++ b/sound/soc/intel/sst-acpi.c
@@ -26,9 +26,20 @@
 #define SST_WPT_DSP_DMA_ADDR_OFFSET	0x0FE000
 #define SST_LPT_DSP_DMA_SIZE		(1024 - 1)
 
+/* Descriptor for SST ASoC machine driver */
+struct sst_acpi_mach {
+	/* ACPI ID for the matching machine driver. Audio codec for instance */
+	const u8 id[ACPI_ID_LEN];
+	/* machine driver name */
+	const char *drv_name;
+	/* firmware file name */
+	const char *fw_filename;
+};
+
 /* Descriptor for setting up SST platform data */
 struct sst_acpi_desc {
 	const char *drv_name;
+	struct sst_acpi_mach *machines;
 	/* Platform resource indexes. Must set to -1 if not used */
 	int resindex_lpe_base;
 	int resindex_pcicfg_base;
@@ -37,24 +48,17 @@ struct sst_acpi_desc {
 	int resindex_dma_base;
 	/* Unique number identifying the SST core on platform */
 	int sst_id;
-	/* firmware file name */
-	const char *fw_filename;
 	/* DMA only valid when resindex_dma_base != -1*/
 	int dma_engine;
 	int dma_size;
 };
 
-/* Descriptor for SST ASoC machine driver */
-struct sst_acpi_mach {
-	const char *drv_name;
-	struct sst_acpi_desc *res_desc;
-};
-
 struct sst_acpi_priv {
 	struct platform_device *pdev_mach;
 	struct platform_device *pdev_pcm;
 	struct sst_pdata sst_pdata;
 	struct sst_acpi_desc *desc;
+	struct sst_acpi_mach *mach;
 };
 
 static void sst_acpi_fw_cb(const struct firmware *fw, void *context)
@@ -64,10 +68,11 @@ static void sst_acpi_fw_cb(const struct firmware *fw, void *context)
 	struct sst_acpi_priv *sst_acpi = platform_get_drvdata(pdev);
 	struct sst_pdata *sst_pdata = &sst_acpi->sst_pdata;
 	struct sst_acpi_desc *desc = sst_acpi->desc;
+	struct sst_acpi_mach *mach = sst_acpi->mach;
 
 	sst_pdata->fw = fw;
 	if (!fw) {
-		dev_err(dev, "Cannot load firmware %s\n", desc->fw_filename);
+		dev_err(dev, "Cannot load firmware %s\n", mach->fw_filename);
 		return;
 	}
 
@@ -83,6 +88,28 @@ static void sst_acpi_fw_cb(const struct firmware *fw, void *context)
 	return;
 }
 
+static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
+				       void *context, void **ret)
+{
+	*(bool *)context = true;
+	return AE_OK;
+}
+
+static struct sst_acpi_mach *sst_acpi_find_machine(
+	struct sst_acpi_mach *machines)
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
+
 static int sst_acpi_probe(struct platform_device *pdev)
 {
 	const struct acpi_device_id *id;
@@ -102,8 +129,13 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	if (!id)
 		return -ENODEV;
 
-	mach = (struct sst_acpi_mach *)id->driver_data;
-	desc = mach->res_desc;
+	desc = (struct sst_acpi_desc *)id->driver_data;
+	mach = sst_acpi_find_machine(desc->machines);
+	if (mach == NULL) {
+		dev_err(dev, "No matching ASoC machine driver found\n");
+		return -ENODEV;
+	}
+
 	sst_pdata = &sst_acpi->sst_pdata;
 	sst_pdata->id = desc->sst_id;
 	sst_acpi->desc = desc;
@@ -154,7 +186,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		return PTR_ERR(sst_acpi->pdev_mach);
 
 	/* continue SST probing after firmware is loaded */
-	ret = request_firmware_nowait(THIS_MODULE, true, desc->fw_filename,
+	ret = request_firmware_nowait(THIS_MODULE, true, mach->fw_filename,
 				      dev, GFP_KERNEL, pdev, sst_acpi_fw_cb);
 	if (ret)
 		platform_device_unregister(sst_acpi->pdev_mach);
@@ -175,45 +207,45 @@ static int sst_acpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct sst_acpi_mach haswell_machines[] = {
+	{ "INT33CA", "haswell-audio", "intel/IntcSST1.bin" },
+	{}
+};
+
 static struct sst_acpi_desc sst_acpi_haswell_desc = {
 	.drv_name = "haswell-pcm-audio",
+	.machines = haswell_machines,
 	.resindex_lpe_base = 0,
 	.resindex_pcicfg_base = 1,
 	.resindex_fw_base = -1,
 	.irqindex_host_ipc = 0,
 	.sst_id = SST_DEV_ID_LYNX_POINT,
-	.fw_filename = "intel/IntcSST1.bin",
 	.dma_engine = SST_DMA_TYPE_DW,
 	.resindex_dma_base = SST_LPT_DSP_DMA_ADDR_OFFSET,
 	.dma_size = SST_LPT_DSP_DMA_SIZE,
 };
 
+static struct sst_acpi_mach broadwell_machines[] = {
+	{ "INT343A", "broadwell-audio", "intel/IntcSST2.bin" },
+	{}
+};
+
 static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 	.drv_name = "haswell-pcm-audio",
+	.machines = broadwell_machines,
 	.resindex_lpe_base = 0,
 	.resindex_pcicfg_base = 1,
 	.resindex_fw_base = -1,
 	.irqindex_host_ipc = 0,
 	.sst_id = SST_DEV_ID_WILDCAT_POINT,
-	.fw_filename = "intel/IntcSST2.bin",
 	.dma_engine = SST_DMA_TYPE_DW,
 	.resindex_dma_base = SST_WPT_DSP_DMA_ADDR_OFFSET,
 	.dma_size = SST_LPT_DSP_DMA_SIZE,
 };
 
-static struct sst_acpi_mach haswell_mach = {
-	.drv_name = "haswell-audio",
-	.res_desc = &sst_acpi_haswell_desc,
-};
-
-static struct sst_acpi_mach broadwell_mach = {
-	.drv_name = "broadwell-audio",
-	.res_desc = &sst_acpi_broadwell_desc,
-};
-
 static struct acpi_device_id sst_acpi_match[] = {
-	{ "INT33C8", (unsigned long)&haswell_mach },
-	{ "INT3438", (unsigned long)&broadwell_mach },
+	{ "INT33C8", (unsigned long)&sst_acpi_haswell_desc },
+	{ "INT3438", (unsigned long)&sst_acpi_broadwell_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sst_acpi_match);
-- 
1.8.5.3
