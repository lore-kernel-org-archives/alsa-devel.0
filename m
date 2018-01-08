From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Fix nested/unnecessary Kconfig
	dependencies" to the asoc tree
Date: Mon, 08 Jan 2018 16:22:11 +0000
Message-ID: <E1eYaBf-00025t-2Z@debutante>
References: <20180104223601.5831-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BAA2267512
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 17:22:17 +0100 (CET)
In-Reply-To: <20180104223601.5831-6-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Fix nested/unnecessary Kconfig dependencies

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

>From f3f2bb7a0ebf9d83229810f69a53fee2c0441b2c Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 4 Jan 2018 16:35:56 -0600
Subject: [PATCH] ASoC: Intel: Fix nested/unnecessary Kconfig dependencies

This patch fixes a number of issues:
1. IOSF_MBI is only needed for byt-cr detection, which is only supported
on Baytrail/Cherrytrail, move to HiFi2 config

2. SND_SOC_INTEL_SST should not select SND_SOC_INTEL_SST_ACPI, the latter
config is only valid for Haswell/Baytrail legacy but not needed by Skylake

3. SND_SST_IPC_ACPI, used only by the atom/sst driver, should not select
SND_SOC_INTEL_SST, none of the code under common/sst*.c is used

This nesting of configs really makes no sense, it's easier to maintain
if for each platform one can control what is strictly required.

Compiled-tested with each of Haswell, Baytrail legacy, HiFi2, SKL cases
selected independently. 0-day and explicit randconfig tests did not report
additional issues and no functionality loss was observed in Intel tests on
HIFI2 and SKYLAKE platforms

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 01b75df6b118..ca0d6eb95d11 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -27,8 +27,6 @@ config SND_SST_IPC_PCI
 config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
-	select SND_SOC_INTEL_SST
-	select IOSF_MBI
 	# This option controls the ACPI-based IPC for HiFi2 platforms
 	# (Baytrail, Cherrytrail)
 
@@ -40,7 +38,6 @@ config SND_SOC_INTEL_SST_ACPI
 
 config SND_SOC_INTEL_SST
 	tristate
-	select SND_SOC_INTEL_SST_ACPI if ACPI
 
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
@@ -54,6 +51,7 @@ config SND_SOC_INTEL_HASWELL
 	depends on SND_DMA_SGBUF
 	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SST_ACPI
 	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
@@ -65,6 +63,7 @@ config SND_SOC_INTEL_BAYTRAIL
 	tristate "Intel ASoC SST driver for Baytrail (legacy)"
 	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SST_ACPI
 	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
@@ -93,6 +92,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_COMPRESS
 	select SND_SOC_ACPI_INTEL_MATCH
+	select IOSF_MBI
 	help
 	  If you have a Intel Baytrail or Cherrytrail platform with an I2S
 	  codec, then enable this option by saying Y or m. This is a
-- 
2.15.1
