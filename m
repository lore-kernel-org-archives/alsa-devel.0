From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Kconfig: formatting update" to
	the asoc tree
Date: Wed, 22 Jun 2016 16:28:41 +0100
Message-ID: <E1bFk53-0002KR-PR@debutante>
References: <1466481784-3651-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CF61268042
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 17:28:49 +0200 (CEST)
In-Reply-To: <1466481784-3651-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Kconfig: formatting update

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

>From c3f2fe621af70ee5e52803eb779c7eca29fad0d0 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 21 Jun 2016 09:33:04 +0530
Subject: [PATCH] ASoC: Intel: Kconfig: formatting update

Kconfig help texts were missing periods as suggested by Randy.

Also fix the alignment on a block of help text to be consistent
with rest.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 63e4c14ebe9f..9c86459d0fc3 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -7,7 +7,7 @@ config SND_MFLD_MACHINE
 	help
           This adds support for ASoC machine driver for Intel(R) MID Medfield platform
           used as alsa device in audio substem in Intel(R) MID devices
-          Say Y if you have such a device
+          Say Y if you have such a device.
           If unsure select "N".
 
 config SND_SST_MFLD_PLATFORM
@@ -54,7 +54,7 @@ config SND_SOC_INTEL_HASWELL_MACH
 	help
 	  This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
 	  Ultrabook platforms.
-	  Say Y if you have such a device
+	  Say Y if you have such a device.
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
@@ -70,7 +70,7 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	help
 	   This adds support for ASoC machine driver for Broxton-P platforms
 	   with DA7219 + MAX98357A I2S audio codec.
-	   Say Y if you have such a device
+	   Say Y if you have such a device.
 	   If unsure select "N".
 
 config SND_SOC_INTEL_BXT_RT298_MACH
@@ -85,7 +85,7 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 	help
 	   This adds support for ASoC machine driver for Broxton platforms
 	   with RT286 I2S audio codec.
-	   Say Y if you have such a device
+	   Say Y if you have such a device.
 	   If unsure select "N".
 
 config SND_SOC_INTEL_BYT_RT5640_MACH
@@ -98,7 +98,7 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 	help
 	  This adds audio driver for Intel Baytrail platform based boards
 	  with the RT5640 audio codec. This driver is deprecated, use
-	  SND_SOC_INTEL_BYTCR_RT5640_MACH instead for better functionality
+	  SND_SOC_INTEL_BYTCR_RT5640_MACH instead for better functionality.
 
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
@@ -122,7 +122,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	help
 	  This adds support for the Wilcatpoint Audio DSP on Intel(R) Broadwell
 	  Ultrabook platforms.
-	  Say Y if you have such a device
+	  Say Y if you have such a device.
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
@@ -135,7 +135,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5640 audio codec.
-          Say Y if you have such a device
+          Say Y if you have such a device.
           If unsure select "N".
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
@@ -148,7 +148,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5651 audio codec.
-          Say Y if you have such a device
+          Say Y if you have such a device.
           If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
@@ -161,7 +161,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
           platforms with RT5672 audio codec.
-          Say Y if you have such a device
+          Say Y if you have such a device.
           If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
@@ -178,16 +178,16 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 
 config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with MAX98090 & TI codec"
-	depends on X86_INTEL_LPSS && I2C
+	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
-      This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
-      platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
-      If unsure select "N".
+	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
+	  platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
+	  If unsure select "N".
 
 config SND_SOC_INTEL_SKYLAKE
 	tristate
@@ -207,7 +207,7 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 	help
 	   This adds support for ASoC machine driver for Skylake platforms
 	   with RT286 I2S audio codec.
-	   Say Y if you have such a device
+	   Say Y if you have such a device.
 	   If unsure select "N".
 
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
@@ -222,7 +222,7 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	help
 	  This adds support for ASoC Onboard Codec I2S machine driver. This will
 	  create an alsa sound card for NAU88L25 + SSM4567.
-	  Say Y if you have such a device
+	  Say Y if you have such a device.
 	  If unsure select "N".
 
 config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
@@ -237,5 +237,5 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	help
 	  This adds support for ASoC Onboard Codec I2S machine driver. This will
 	  create an alsa sound card for NAU88L25 + MAX98357A.
-	  Say Y if you have such a device
+	  Say Y if you have such a device.
 	  If unsure select "N".
-- 
2.8.1
