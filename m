From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/4] ASoC: Intel: Load the atom DPCM driver only
Date: Mon,  8 Feb 2016 10:45:38 +0530
Message-ID: <1454908539-14137-4-git-send-email-vinod.koul@intel.com>
References: <1454908539-14137-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FA122605C1
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 06:12:14 +0100 (CET)
In-Reply-To: <1454908539-14137-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

DPCM driver is recommended for BYT, CHT based platforms, so if
CONFIG_SND_SST_IPC_ACPI is selected then don't compile the BYT
Device IDs in common ACPI driver to avoid probe conflicts.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig           | 4 ++--
 sound/soc/intel/common/sst-acpi.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index af7aabbc0977..7d7c872c280d 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -61,7 +61,7 @@ config SND_SOC_INTEL_HASWELL_MACH
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE=y && (SND_SOC_INTEL_BYTCR_RT5640_MACH = n)
+	depends on DW_DMAC_CORE=y && (SND_SST_IPC_ACPI = n)
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
@@ -73,7 +73,7 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE=y
+	depends on DW_DMAC_CORE=y && (SND_SST_IPC_ACPI = n)
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_MAX98090
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 7a85c576dad3..2c5eda14d510 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -215,6 +215,7 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 	.dma_size = SST_LPT_DSP_DMA_SIZE,
 };
 
+#if !IS_ENABLED(CONFIG_SND_SST_IPC_ACPI)
 static struct sst_acpi_mach baytrail_machines[] = {
 	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master", NULL, NULL, NULL },
 	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master", NULL, NULL, NULL },
@@ -231,11 +232,14 @@ static struct sst_acpi_desc sst_acpi_baytrail_desc = {
 	.sst_id = SST_DEV_ID_BYT,
 	.resindex_dma_base = -1,
 };
+#endif
 
 static const struct acpi_device_id sst_acpi_match[] = {
 	{ "INT33C8", (unsigned long)&sst_acpi_haswell_desc },
 	{ "INT3438", (unsigned long)&sst_acpi_broadwell_desc },
+#if !IS_ENABLED(CONFIG_SND_SST_IPC_ACPI)
 	{ "80860F28", (unsigned long)&sst_acpi_baytrail_desc },
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sst_acpi_match);
-- 
1.9.1
