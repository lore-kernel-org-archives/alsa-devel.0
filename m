From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 21/35] ASoC: Intel: Expose ACPI loading members
Date: Thu, 22 Aug 2019 21:04:11 +0200
Message-ID: <20190822190425.23001-22-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1925F80633
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:05:15 +0200 (CEST)
In-Reply-To: <20190822190425.23001-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

No framework should know upfront about specifics of its inheriting
members. sst-acpi contains Baytrail and Haswell specific data. In order
to prevent circular dependency, it's compiled into separate module.

Let's do it right and obey inheritance rule. As a first step, elevate
sst-acpi members so they could be shared by Haswell and
Baytrail-specific handlers - this is to prevent code duplication.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/common/sst-acpi.c | 23 ++++-------------------
 sound/soc/intel/common/sst-dsp.h  | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 0e8e0a7a11df..42f9b02f2ea3 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -19,23 +19,6 @@
 #define SST_WPT_DSP_DMA_ADDR_OFFSET	0x0FE000
 #define SST_LPT_DSP_DMA_SIZE		(1024 - 1)
 
-/* Descriptor for setting up SST platform data */
-struct sst_acpi_desc {
-	const char *drv_name;
-	struct snd_soc_acpi_mach *machines;
-	/* Platform resource indexes. Must set to -1 if not used */
-	int resindex_lpe_base;
-	int resindex_pcicfg_base;
-	int resindex_fw_base;
-	int irqindex_host_ipc;
-	int resindex_dma_base;
-	/* Unique number identifying the SST core on platform */
-	int sst_id;
-	/* DMA only valid when resindex_dma_base != -1*/
-	int dma_engine;
-	int dma_size;
-};
-
 struct sst_acpi_priv {
 	struct platform_device *pdev_mach;
 	struct platform_device *pdev_pcm;
@@ -71,7 +54,7 @@ static void sst_acpi_fw_cb(const struct firmware *fw, void *context)
 	return;
 }
 
-static int sst_acpi_probe(struct platform_device *pdev)
+int sst_acpi_probe(struct platform_device *pdev)
 {
 	const struct acpi_device_id *id;
 	struct device *dev = &pdev->dev;
@@ -157,8 +140,9 @@ static int sst_acpi_probe(struct platform_device *pdev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sst_acpi_probe);
 
-static int sst_acpi_remove(struct platform_device *pdev)
+int sst_acpi_remove(struct platform_device *pdev)
 {
 	struct sst_acpi_priv *sst_acpi = platform_get_drvdata(pdev);
 	struct sst_pdata *sst_pdata = &sst_acpi->sst_pdata;
@@ -170,6 +154,7 @@ static int sst_acpi_remove(struct platform_device *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(sst_acpi_remove);
 
 static struct sst_acpi_desc sst_acpi_haswell_desc = {
 	.drv_name = "haswell-pcm-audio",
diff --git a/sound/soc/intel/common/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
index 63c29bb45cf1..a2ac7998fbdb 100644
--- a/sound/soc/intel/common/sst-dsp.h
+++ b/sound/soc/intel/common/sst-dsp.h
@@ -166,6 +166,27 @@
 #define SST_PMCS_PS_MASK	0x3
 
 struct sst_dsp;
+struct platform_device;
+
+/* Descriptor for setting up SST platform data */
+struct sst_acpi_desc {
+	const char *drv_name;
+	struct snd_soc_acpi_mach *machines;
+	/* Platform resource indexes. Must set to -1 if not used */
+	int resindex_lpe_base;
+	int resindex_pcicfg_base;
+	int resindex_fw_base;
+	int irqindex_host_ipc;
+	int resindex_dma_base;
+	/* Unique number identifying the SST core on platform */
+	int sst_id;
+	/* DMA only valid when resindex_dma_base != -1*/
+	int dma_engine;
+	int dma_size;
+};
+
+int sst_acpi_probe(struct platform_device *pdev);
+int sst_acpi_remove(struct platform_device *pdev);
 
 /*
  * SST Platform Data.
-- 
2.17.1
