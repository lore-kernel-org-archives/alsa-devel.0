From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: improve SND_SOC_INTEL_MACH
	dependencies" to the asoc tree
Date: Wed, 08 Nov 2017 18:26:22 +0000
Message-ID: <E1eCV3O-0006iq-V3@debutante>
References: <20171108130354.86106-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DD9E2675E6
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 19:26:37 +0100 (CET)
In-Reply-To: <20171108130354.86106-2-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Harsha Priya N <harshapriya.n@intel.com>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: improve SND_SOC_INTEL_MACH dependencies

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

>From 960115b842886999a64a87d8baadb81dce4293b4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 8 Nov 2017 14:03:20 +0100
Subject: [PATCH] ASoC: Intel: improve SND_SOC_INTEL_MACH dependencies

I ran into a build error with CONFIG_SND_SOC_INTEL_COMMON=m
and SND_SOC_INTEL_MACH=y:

ERROR: "snd_soc_acpi_intel_broadwell_machines" [sound/soc/intel/common/snd-soc-sst-acpi.ko] undefined!
ERROR: "snd_soc_acpi_intel_haswell_machines" [sound/soc/intel/common/snd-soc-sst-acpi.ko] undefined!
ERROR: "snd_soc_acpi_intel_cherrytrail_machines" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
ERROR: "snd_soc_acpi_intel_baytrail_machines" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!

The problem here is that the sound/soc/intel/common/ directory
is then entered only for building modules, but the sst-acpi.o
never gets built since it depends on a built-in Kconfig symbol.

That configuration obviously makes no sense since all options
below SND_SOC_INTEL_MACH also depend on something else that
in turn depends on CONFIG_SND_SOC_INTEL_COMMON.

Adding a SND_SOC_INTEL_SST_TOPLEVEL dependency to SND_SOC_INTEL_MACH
solves the build error. I notice we can also consolidate the
'depends on SND_SOC_INTEL_MACH' lines by using an 'if' block to
simplify it further and make sure the configuration stays sane.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 5063f15b4ca4..6f754708a48c 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -1,10 +1,12 @@
 config SND_SOC_INTEL_MACH
 	tristate "Intel Audio machine drivers"
+	depends on SND_SOC_INTEL_SST_TOPLEVEL
 	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 
+if SND_SOC_INTEL_MACH
+
 config SND_MFLD_MACHINE
 	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
-	depends on SND_SOC_INTEL_MACH
 	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
 	depends on SND_SST_ATOM_HIFI2_PLATFORM
@@ -17,7 +19,6 @@ config SND_MFLD_MACHINE
 
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
 	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
@@ -29,7 +30,6 @@ config SND_SOC_INTEL_HASWELL_MACH
 
 config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && GPIOLIB && I2C
 	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5677
@@ -39,7 +39,6 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
 
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
 	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
@@ -51,7 +50,6 @@ config SND_SOC_INTEL_BROADWELL_MACH
 
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
 	depends on SND_SST_IPC_ACPI = n
 	depends on SND_SOC_INTEL_BAYTRAIL
@@ -62,7 +60,6 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
 	depends on SND_SST_IPC_ACPI = n
 	depends on SND_SOC_INTEL_BAYTRAIL
@@ -74,7 +71,6 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
 	depends on SND_SST_ATOM_HIFI2_PLATFORM
@@ -87,7 +83,6 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5651
 	depends on SND_SST_ATOM_HIFI2_PLATFORM
@@ -100,7 +95,6 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
-        depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
         depends on SND_SST_ATOM_HIFI2_PLATFORM
@@ -113,7 +107,6 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
 	depends on SND_SST_ATOM_HIFI2_PLATFORM
@@ -125,7 +118,6 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 
 config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with MAX98090 & TI codec"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
@@ -138,7 +130,6 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 
 config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_DA7213
 	depends on SND_SST_ATOM_HIFI2_PLATFORM
@@ -150,7 +141,6 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 
 config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with ES8316 codec"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ES8316
 	depends on SND_SST_ATOM_HIFI2_PLATFORM
@@ -162,7 +152,6 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 
 config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
@@ -174,7 +163,6 @@ config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86 && ACPI && I2C
 	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT286
@@ -188,7 +176,6 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
 	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
@@ -203,7 +190,6 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 
 config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
 	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
@@ -218,7 +204,6 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86 && ACPI && I2C
 	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_DA7219
@@ -234,7 +219,6 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 
 config SND_SOC_INTEL_BXT_RT298_MACH
 	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86 && ACPI && I2C
 	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT298
@@ -249,7 +233,6 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927 in I2S Mode"
-	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
 	select SND_SOC_INTEL_SST
 	depends on SND_SOC_INTEL_SKYLAKE
@@ -265,7 +248,6 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         tristate "ASoC Audio driver for KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
-        depends on SND_SOC_INTEL_MACH
         depends on X86_INTEL_LPSS && I2C && SPI
         select SND_SOC_INTEL_SST
         depends on SND_SOC_INTEL_SKYLAKE
@@ -279,3 +261,5 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
           create an alsa sound card for RT5663 + RT5514 + MAX98927.
           Say Y if you have such a device.
           If unsure select "N".
+
+endif
-- 
2.15.0
