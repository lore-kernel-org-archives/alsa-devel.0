From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: tag byt-rt5640 machine driver as
	deprecated" to the asoc tree
Date: Sat, 19 Dec 2015 11:51:31 +0000
Message-ID: <E1aAG2t-0004ex-TM@debutante>
References: <1450406156-22246-7-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69F582605A1
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 12:51:51 +0100 (CET)
In-Reply-To: <1450406156-22246-7-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: tag byt-rt5640 machine driver as deprecated

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

>From 595788e475d09fb081bedcf49b3720e62887f77f Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 17 Dec 2015 20:35:43 -0600
Subject: [PATCH] ASoC: Intel: tag byt-rt5640 machine driver as deprecated

All the functionality was merged in DPCM-based driver,
keep older driver to avoid breaking userspace but
tag it as unsupported/deprecated

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 9b1c0aa8d2d9..337e178c1acb 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -57,13 +57,14 @@ config SND_SOC_INTEL_HASWELL_MACH
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE=y
+	depends on DW_DMAC_CORE=y && (SND_SOC_INTEL_BYTCR_RT5640_MACH = n)
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
 	help
 	  This adds audio driver for Intel Baytrail platform based boards
-	  with the RT5640 audio codec.
+	  with the RT5640 audio codec. This driver is deprecated, use
+	  SND_SOC_INTEL_BYTCR_RT5640_MACH instead for better functionality
 
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
@@ -91,14 +92,14 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
-	tristate "ASoC Audio DSP Support for MID BYT Platform"
+        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
 	depends on X86 && I2C
 	select SND_SOC_RT5640
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
-	  This adds support for ASoC machine driver for Intel(R) MID Baytrail platform
-          used as alsa device in audio substem in Intel(R) MID devices
+          This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
+          platforms with RT5640 audio codec.
           Say Y if you have such a device
           If unsure select "N".
 
-- 
2.6.2
