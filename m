From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/4] ASoC: Intel: Create independent acpi match
	module
Date: Mon,  8 Feb 2016 10:45:37 +0530
Message-ID: <1454908539-14137-3-git-send-email-vinod.koul@intel.com>
References: <1454908539-14137-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E2E652604A4
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 06:12:11 +0100 (CET)
In-Reply-To: <1454908539-14137-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

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
1.9.1
