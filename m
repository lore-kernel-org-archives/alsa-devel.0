From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Kconfig: formatting update
Date: Tue, 21 Jun 2016 09:33:04 +0530
Message-ID: <1466481784-3651-2-git-send-email-vinod.koul@intel.com>
References: <1466481784-3651-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 80F562657B0
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 05:56:25 +0200 (CEST)
In-Reply-To: <1466481784-3651-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Kconfig help texts were missing periods as suggested by Randy.

Also fix the alignment on a block of help text to be consistent
with rest.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
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
1.9.1
