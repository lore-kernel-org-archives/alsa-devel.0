From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies" to the asoc tree
Date: Mon, 08 Jan 2018 16:22:18 +0000
Message-ID: <E1eYaBm-00027v-5n@debutante>
References: <20180103165022.4984-4-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103165022.4984-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.combroonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4772c16ede522d46219a59646503d2020841a6f4 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 4 Jan 2018 16:35:54 -0600
Subject: [PATCH] ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI dependencies

PCI/ACPI selections should not happen in Kconfig for machine drivers,
move to SOC selections.

Add distinction between PCI and ACPI HiFi2 platforms and help text.

There should be no functionality change.

The PCI-based platforms may be removed at some point since Medfield
is not really supported by anyone, and with Edison now defunct support for
Merrifield/Edison is to be determined.

The dependency on SND_DMA_SGBUF for Haswell is not clear at this
point and may have to be further updated.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig        | 27 +++++++++++++++++++++++----
 sound/soc/intel/boards/Kconfig | 14 ++++----------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b827d3b70095..16374576cb6e 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -41,7 +41,7 @@ config SND_SOC_INTEL_SST_ACPI
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
 	depends on SND_DMA_SGBUF
-	depends on DMADEVICES
+	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_ACPI_INTEL_MATCH
@@ -52,7 +52,7 @@ config SND_SOC_INTEL_HASWELL
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate "Intel ASoC SST driver for Baytrail (legacy)"
-	depends on DMADEVICES
+	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_ACPI_INTEL_MATCH
@@ -62,11 +62,30 @@ config SND_SOC_INTEL_BAYTRAIL
 	  for Baytrail Chromebooks but this option is now deprecated and is
 	  not recommended, use SND_SST_ATOM_HIFI2_PLATFORM instead.
 
+config SND_SST_ATOM_HIFI2_PLATFORM_PCI
+	tristate "Intel ASoC SST driver for PCI HiFi2 platforms (Medfield, Merrifield)"
+	depends on X86 && PCI
+	select SND_SST_IPC_PCI
+	select SND_SOC_COMPRESS
+	select SND_SOC_INTEL_COMMON
+	help
+	  If you have a Intel Medfield or Merrifield/Edison platform, then
+	  enable this option by saying Y or m. Distros will typically not
+	  enable this option: Medfield devices are not available to
+	  developers and while Merrifield/Edison can run a mainline kernel with
+	  limited functionality it will require a firmware file which
+	  is not in the standard firmware tree
+
 config SND_SST_ATOM_HIFI2_PLATFORM
-	tristate "Intel ASoC SST driver for HiFi2 platforms (*field, *trail)"
-	depends on X86
+	tristate "Intel ASoC SST driver for ACPI HiFi2 platforms (Baytrail, Cherrytrail)"
+	depends on X86 && ACPI
+	select SND_SST_IPC_ACPI
 	select SND_SOC_COMPRESS
 	select SND_SOC_ACPI_INTEL_MATCH
+	help
+	  If you have a Intel Baytrail or Cherrytrail platform with an I2S
+	  codec, then enable this option by saying Y or m. This is a
+	  recommended option
 
 config SND_SOC_INTEL_SKYLAKE
 	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 08481882c240..e926f9747232 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -12,18 +12,20 @@ menuconfig SND_SOC_INTEL_MACH
 
 if SND_SOC_INTEL_MACH
 
+if SND_SST_ATOM_HIFI2_PLATFORM_PCI
+
 config SND_MFLD_MACHINE
 	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
 	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
-	select SND_SST_IPC_PCI
 	help
           This adds support for ASoC machine driver for Intel(R) MID Medfield platform
           used as alsa device in audio substem in Intel(R) MID devices
           Say Y if you have such a device.
           If unsure select "N".
 
+endif
+
 if SND_SOC_INTEL_HASWELL
 
 config SND_SOC_INTEL_HASWELL_MACH
@@ -86,7 +88,6 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
-	select SND_SST_IPC_ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5640 audio codec.
@@ -97,7 +98,6 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5651
-	select SND_SST_IPC_ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5651 audio codec.
@@ -108,7 +108,6 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
-        select SND_SST_IPC_ACPI
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
           platforms with RT5672 audio codec.
@@ -119,7 +118,6 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
-	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with RT5645/5650 audio codec.
@@ -131,7 +129,6 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
-	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
@@ -142,7 +139,6 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_DA7213
-	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
 	  platforms with DA7212/7213 audio codec.
@@ -153,7 +149,6 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with ES8316 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ES8316
-	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail &
 	  Cherrytrail platforms with ES8316 audio codec.
@@ -163,7 +158,6 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
 	depends on X86_INTEL_LPSS && I2C && ACPI
-	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for the MinnowBoard Max or
 	  Up boards and provides access to I2S signals on the Low-Speed
-- 
2.15.1
