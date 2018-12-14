From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add more platform
	granularity" to the asoc tree
Date: Fri, 14 Dec 2018 12:37:22 +0000 (GMT)
Message-ID: <20181214123722.BC5A011258A1@debutante.sirena.org.uk>
References: <20181213190300.24999-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BBF22678D5
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:37:25 +0100 (CET)
In-Reply-To: <20181213190300.24999-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add more platform granularity

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

>From 35bc99aaa1a3af23cf78b6b56f14230b5da3993b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 13 Dec 2018 13:03:00 -0600
Subject: [PATCH] ASoC: Intel: Skylake: Add more platform granularity

The current SKYLAKE kconfig is a all-you-can-eat selection that will
support all known plaforms. This is however not necessarily a good
thing: most platforms for SKL and KBL don't support the DSP, but a
number of CNL/WHL ones do. Selecting this driver in all cases isn't
really smart and will require users to muck with blacklists.

Partition the configs to allow distributions to select on which
platform this driver is used. Keep the existing SND_SOC_INTEL_SKYLAKE
config to select everything for backwards compatibility. This patch does
not provide new functionality, only finer-grained choices in supported
platforms.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig        | 73 ++++++++++++++++++++++++++++++----
 sound/soc/intel/boards/Kconfig | 16 +++++++-
 sound/soc/intel/skylake/skl.c  | 12 ++++++
 3 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 18e717703685..99a62ba409df 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -102,15 +102,74 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
 	  recommended option
 
 config SND_SOC_INTEL_SKYLAKE
-	tristate "SKL/BXT/KBL/GLK/CNL... Platforms"
+	tristate "All Skylake/SST Platforms"
 	depends on PCI && ACPI
-	select SND_SOC_INTEL_SKYLAKE_COMMON
+	select SND_SOC_INTEL_SKL
+	select SND_SOC_INTEL_APL
+	select SND_SOC_INTEL_KBL
+	select SND_SOC_INTEL_GLK
+	select SND_SOC_INTEL_CNL
+	select SND_SOC_INTEL_CFL
 	help
-	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
-	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
-	  then enable this option by saying Y or m.
+          This is a backwards-compatible option to select all devices
+	  supported by the Intel SST/Skylake driver. This option is no
+	  longer recommended and will be deprecated when the SOF
+	  driver is introduced.  Distributions should explicitly
+	  select which platform uses this driver.
+
+config SND_SOC_INTEL_SKL
+	tristate "Skylake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel Skylake platform with the DSP enabled
+	  in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_APL
+	tristate "Broxton/ApolloLake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel Broxton/ApolloLake platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_KBL
+	tristate "Kabylake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel Kabylake platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_GLK
+	tristate "GeminiLake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel GeminiLake platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_CNL
+	tristate "CannonLake/WhiskyLake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel CNL/WHL platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_CFL
+	tristate "CoffeeLake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel CoffeeLake platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_SKYLAKE_FAMILY
+	tristate
+	select SND_SOC_INTEL_SKYLAKE_COMMON
 
-if  SND_SOC_INTEL_SKYLAKE
+if SND_SOC_INTEL_SKYLAKE_FAMILY
 
 config SND_SOC_INTEL_SKYLAKE_SSP_CLK
 	tristate
@@ -135,7 +194,7 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
 	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
 	  then enable this option by saying Y or m.
 
-endif ## SND_SOC_INTEL_SKYLAKE
+endif ## SND_SOC_INTEL_SKYLAKE_FAMILY
 
 config SND_SOC_ACPI_INTEL_MATCH
 	tristate
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 3839d6205fcf..0a7e40d06395 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -172,7 +172,7 @@ config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 
 endif ## SND_SST_ATOM_HIFI2_PLATFORM
 
-if SND_SOC_INTEL_SKYLAKE
+if SND_SOC_INTEL_SKL
 
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "SKL with RT286 I2S mode"
@@ -212,6 +212,10 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
+endif ## SND_SOC_INTEL_SKL
+
+if SND_SOC_INTEL_APL
+
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	tristate "Broxton with DA7219 and MAX98357A in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
@@ -239,6 +243,10 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 	   Say Y or m if you have such a device. This is a recommended option.
 	   If unsure select "N".
 
+endif ## SND_SOC_INTEL_APL
+
+if SND_SOC_INTEL_KBL
+
 config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	tristate "KBL with RT5663 and MAX98927 in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
@@ -303,6 +311,10 @@ config SND_SOC_INTEL_KBL_RT5660_MACH
 	  create an alsa sound card for RT5660 I2S audio codec.
 	  Say Y if you have such a device.
 
+endif ## SND_SOC_INTEL_KBL
+
+if SND_SOC_INTEL_GLK
+
 config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	tristate "GLK with RT5682 and MAX98357A in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
@@ -317,7 +329,7 @@ config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	   Say Y if you have such a device.
 	   If unsure select "N".
 
-endif ## SND_SOC_INTEL_SKYLAKE
+endif ## SND_SOC_INTEL_GLK
 
 if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
 
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index f9888b1d5521..5abd35ca4e41 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1142,24 +1142,36 @@ static void skl_remove(struct pci_dev *pci)
 
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_skl_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
 	/* BXT-P */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_bxt_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
 	/* KBL */
 	{ PCI_DEVICE(0x8086, 0x9D71),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_kbl_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_GLK)
 	/* GLK */
 	{ PCI_DEVICE(0x8086, 0x3198),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_glk_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_CNL)
 	/* CNL */
 	{ PCI_DEVICE(0x8086, 0x9dc8),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_CFL)
 	/* CFL */
 	{ PCI_DEVICE(0x8086, 0xa348),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+#endif
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
2.19.0.rc2
