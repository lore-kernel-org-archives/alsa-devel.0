From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: only select sst-firmware
	when DW DMAC is built-in" to the asoc tree
Date: Wed, 25 Nov 2015 12:11:12 +0000
Message-ID: <E1a1Yum-0001pV-Bt@debutante>
References: <1448373681-27426-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A9DA62606C9
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 13:11:23 +0100 (CET)
In-Reply-To: <1448373681-27426-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: only select sst-firmware when DW DMAC is built-in

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

>From a92ea59b74e231cc0a969afa8d71fa314d5860f2 Mon Sep 17 00:00:00 2001
From: Jie Yang <yang.jie@intel.com>
Date: Tue, 24 Nov 2015 22:01:21 +0800
Subject: [PATCH] ASoC: Intel: sst: only select sst-firmware when DW DMAC is
 built-in

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig          | 8 ++++----
 sound/soc/intel/common/Makefile  | 4 +---
 sound/soc/intel/common/sst-dsp.c | 2 +-
 sound/soc/intel/common/sst-dsp.h | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index aee2a5c75e0d..2d3b12401db1 100644
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
index 658edce16761..3b9332e7a094 100644
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
index c9452e02e0dd..b5bbdf4fe93a 100644
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
index 859f0de00339..0b84c719ec48 100644
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
2.6.2
