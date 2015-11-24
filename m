From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: sst: only select sst-firmware
	when DW DMAC is built-in
Date: Tue, 24 Nov 2015 22:01:21 +0800
Message-ID: <1448373681-27426-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 21706265A89
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 14:55:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, yang.jie@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The previous commit ef3e199a49c8 ("ASoC: Intel: sst: only use
sst-firmware when DW DMAC is available") does not fix the 0day
building errors thoroughly:

   sound/built-in.o: In function 'dw_dma_remove'
   sound/built-in.o: In function 'dw_dma_probe'

Here we fallback to select sst-firmware only when DW DMAC
is built-in selected. We may need to refactor sst common
driver and split DW related codes to platform driver, but
ATM, this fallback may be the smallest fix.

Please be noticed that after applying this patch, we may
need select DW DMAC manually in DMA driver menu, before
we can prompt and select HSW/BDW and old BYT machines.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig          | 8 ++++----
 sound/soc/intel/common/Makefile  | 4 +---
 sound/soc/intel/common/sst-dsp.c | 2 +-
 sound/soc/intel/common/sst-dsp.h | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 13a7621..99ce3bf 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -44,7 +44,7 @@ config SND_SOC_INTEL_BAYTRAIL
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on DW_DMAC_CORE
+	depends on DW_DMAC_CORE=y
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
@@ -57,7 +57,7 @@ config SND_SOC_INTEL_HASWELL_MACH
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE
+	depends on DW_DMAC_CORE=y
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
@@ -68,7 +68,7 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE
+	depends on DW_DMAC_CORE=y
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_MAX98090
@@ -80,7 +80,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
 	depends on X86_INTEL_LPSS && I2C && DW_DMAC && \
 		   I2C_DESIGNWARE_PLATFORM
-	depends on DW_DMAC_CORE
+	depends on DW_DMAC_CORE=y
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 658edce..3b9332e 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -2,9 +2,7 @@ snd-soc-sst-dsp-objs := sst-dsp.o
 snd-soc-sst-acpi-objs := sst-acpi.o sst-match-acpi.o
 snd-soc-sst-ipc-objs := sst-ipc.o
 
-ifneq ($(CONFIG_DW_DMAC_CORE),)
-snd-soc-sst-dsp-objs += sst-firmware.o
-endif
+snd-soc-sst-dsp-$(CONFIG_DW_DMAC_CORE) += sst-firmware.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index c9452e0..b5bbdf4 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -420,7 +420,7 @@ void sst_dsp_inbox_read(struct sst_dsp *sst, void *message, size_t bytes)
 }
 EXPORT_SYMBOL_GPL(sst_dsp_inbox_read);
 
-#if IS_ENABLED(CONFIG_DW_DMAC_CORE)
+#ifdef CONFIG_DW_DMAC_CORE
 struct sst_dsp *sst_dsp_new(struct device *dev,
 	struct sst_dsp_device *sst_dev, struct sst_pdata *pdata)
 {
diff --git a/sound/soc/intel/common/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
index 859f0de..0b84c71 100644
--- a/sound/soc/intel/common/sst-dsp.h
+++ b/sound/soc/intel/common/sst-dsp.h
@@ -216,7 +216,7 @@ struct sst_pdata {
 	void *dsp;
 };
 
-#if IS_ENABLED(CONFIG_DW_DMAC_CORE)
+#ifdef CONFIG_DW_DMAC_CORE
 /* Initialization */
 struct sst_dsp *sst_dsp_new(struct device *dev,
 	struct sst_dsp_device *sst_dev, struct sst_pdata *pdata);
-- 
2.5.0
