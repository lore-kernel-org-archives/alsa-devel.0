From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCHv2] ASoC: Intel: sst-acpi: Request firmware
	before SST platform driver probing
Date: Wed, 19 Feb 2014 10:30:38 +0200
Message-ID: <1392798638-20767-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8273F2652A8
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 09:31:16 +0100 (CET)
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

We originally thought to request SST audio DSP firmware during the SST
platform driver initialization. However plain request_firmware doesn't
work in driver probe paths if userspace is not ready to handle it. For
instance when drivers are built-in.

Implementing asynchronous firmware request in SST platform driver
initialization complicates code needlessly since it anyway will fail if
firmware is missing.

This is more simple to handle by requesting firmware asynchronously in
sst_acpi_probe() and register SST platform only after firmware is loaded.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
V2:
- Fix leak in sst_acpi_probe that sst_acpi->pdev_mach wasn't unregistered
  in case of request_firmware_nowait fails
- Test is sst_acpi->pdev_pcm valid before unregistering it in sst_acpi_remove.
  It can contain not only NULL or valid pointer but an error code too
---
 sound/soc/intel/sst-acpi.c | 56 ++++++++++++++++++++++++++++++++--------------
 sound/soc/intel/sst-dsp.h  |  2 +-
 2 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/sst-acpi.c b/sound/soc/intel/sst-acpi.c
index aba73ca8a923..64154a77d904 100644
--- a/sound/soc/intel/sst-acpi.c
+++ b/sound/soc/intel/sst-acpi.c
@@ -16,6 +16,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
@@ -56,6 +57,32 @@ struct sst_acpi_priv {
 	struct sst_acpi_desc *desc;
 };
 
+static void sst_acpi_fw_cb(const struct firmware *fw, void *context)
+{
+	struct platform_device *pdev = context;
+	struct device *dev = &pdev->dev;
+	struct sst_acpi_priv *sst_acpi = platform_get_drvdata(pdev);
+	struct sst_pdata *sst_pdata = &sst_acpi->sst_pdata;
+	struct sst_acpi_desc *desc = sst_acpi->desc;
+
+	sst_pdata->fw = fw;
+	if (!fw) {
+		dev_err(dev, "Cannot load firmware %s\n", desc->fw_filename);
+		return;
+	}
+
+	/* register PCM and DAI driver */
+	sst_acpi->pdev_pcm =
+		platform_device_register_data(dev, desc->drv_name, -1,
+					      sst_pdata, sizeof(*sst_pdata));
+	if (IS_ERR(sst_acpi->pdev_pcm)) {
+		dev_err(dev, "Cannot register device %s. Error %d\n",
+			desc->drv_name, (int)PTR_ERR(sst_acpi->pdev_pcm));
+	}
+
+	return;
+}
+
 static int sst_acpi_probe(struct platform_device *pdev)
 {
 	const struct acpi_device_id *id;
@@ -79,7 +106,6 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	desc = mach->res_desc;
 	sst_pdata = &sst_acpi->sst_pdata;
 	sst_pdata->id = desc->sst_id;
-	sst_pdata->fw_filename = desc->fw_filename;
 	sst_acpi->desc = desc;
 
 	if (desc->resindex_dma_base >= 0) {
@@ -118,37 +144,33 @@ static int sst_acpi_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* register PCM and DAI driver */
-	sst_acpi->pdev_pcm =
-		platform_device_register_data(dev, desc->drv_name, -1,
-					      sst_pdata, sizeof(*sst_pdata));
-	if (IS_ERR(sst_acpi->pdev_pcm))
-		return PTR_ERR(sst_acpi->pdev_pcm);
-
-	/* register machine driver */
 	platform_set_drvdata(pdev, sst_acpi);
 
+	/* register machine driver */
 	sst_acpi->pdev_mach =
 		platform_device_register_data(dev, mach->drv_name, -1,
 					      sst_pdata, sizeof(*sst_pdata));
-	if (IS_ERR(sst_acpi->pdev_mach)) {
-		ret = PTR_ERR(sst_acpi->pdev_mach);
-		goto sst_err;
-	}
+	if (IS_ERR(sst_acpi->pdev_mach))
+		return PTR_ERR(sst_acpi->pdev_mach);
 
-	return ret;
+	/* continue SST probing after firmware is loaded */
+	ret = request_firmware_nowait(THIS_MODULE, true, desc->fw_filename,
+				      dev, GFP_KERNEL, pdev, sst_acpi_fw_cb);
+	if (ret)
+		platform_device_unregister(sst_acpi->pdev_mach);
 
-sst_err:
-	platform_device_unregister(sst_acpi->pdev_pcm);
 	return ret;
 }
 
 static int sst_acpi_remove(struct platform_device *pdev)
 {
 	struct sst_acpi_priv *sst_acpi = platform_get_drvdata(pdev);
+	struct sst_pdata *sst_pdata = &sst_acpi->sst_pdata;
 
 	platform_device_unregister(sst_acpi->pdev_mach);
-	platform_device_unregister(sst_acpi->pdev_pcm);
+	if (!IS_ERR_OR_NULL(sst_acpi->pdev_pcm))
+		platform_device_unregister(sst_acpi->pdev_pcm);
+	release_firmware(sst_pdata->fw);
 
 	return 0;
 }
diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index d134359fecac..3730fd324455 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -152,7 +152,7 @@ struct sst_pdata {
 	int irq;
 
 	/* Firmware */
-	const char *fw_filename;
+	const struct firmware *fw;
 
 	/* DMA */
 	u32 dma_base;
-- 
1.8.5.3
