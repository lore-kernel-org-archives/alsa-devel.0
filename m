From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Create independent acpi match
	module" to the asoc tree
Date: Mon, 08 Feb 2016 18:01:39 +0000
Message-ID: <E1aSq83-0002ns-He@debutante>
References: <1454908539-14137-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 531A6261527
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 19:01:45 +0100 (CET)
In-Reply-To: <1454908539-14137-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Create independent acpi match module

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

>From 2dcffcee23a2bd491a8c4041db3a8041b23fa4eb Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 8 Feb 2016 10:45:37 +0530
Subject: [PATCH] ASoC: Intel: Create independent acpi match module

The ACPI match module is common to all three drivers, HSW, SKL
and Atom-DPCM driver. But Atom-DPCM driver does not use common
sst code so we cannot include the common SST module in Atom-DPCM
driver.

So the solution is to have a independent sst-match-acpi module
which helps in matching for all the three drivers. Now all driver
can be inbuilt in a single image

This patch really fixes the regression introduced by the
commit 95f098014815 ("ASoC: Intel: Move apci find machine routines")

Acked-by: Jie Yang <yang.jie@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig         | 9 +++++++++
 sound/soc/intel/common/Makefile | 4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 803f95e40679..af7aabbc0977 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -30,11 +30,15 @@ config SND_SST_IPC_ACPI
 config SND_SOC_INTEL_SST
 	tristate
 	select SND_SOC_INTEL_SST_ACPI if ACPI
+	select SND_SOC_INTEL_SST_MATCH if ACPI
 	depends on (X86 || COMPILE_TEST)
 
 config SND_SOC_INTEL_SST_ACPI
 	tristate
 
+config SND_SOC_INTEL_SST_MATCH
+	tristate
+
 config SND_SOC_INTEL_HASWELL
 	tristate
 
@@ -97,6 +101,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 	select SND_SOC_RT5640
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
+	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5640 audio codec.
@@ -109,6 +114,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 	select SND_SOC_RT5651
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
+	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5651 audio codec.
@@ -121,6 +127,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         select SND_SOC_RT5670
         select SND_SST_MFLD_PLATFORM
         select SND_SST_IPC_ACPI
+	select SND_SOC_INTEL_SST_MATCH if ACPI
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
           platforms with RT5672 audio codec.
@@ -133,6 +140,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	select SND_SOC_RT5645
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
+	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with RT5645/5650 audio codec.
@@ -145,6 +153,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	select SND_SOC_TS3A227E
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
+	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
       This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
       platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 3b9332e7a094..fbbb25c2ceed 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -1,8 +1,10 @@
 snd-soc-sst-dsp-objs := sst-dsp.o
-snd-soc-sst-acpi-objs := sst-acpi.o sst-match-acpi.o
+snd-soc-sst-acpi-objs := sst-acpi.o
+snd-soc-sst-match-objs := sst-match-acpi.o
 snd-soc-sst-ipc-objs := sst-ipc.o
 
 snd-soc-sst-dsp-$(CONFIG_DW_DMAC_CORE) += sst-firmware.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
+obj-$(CONFIG_SND_SOC_INTEL_SST_MATCH) += snd-soc-sst-match.o
-- 
2.7.0.rc3
