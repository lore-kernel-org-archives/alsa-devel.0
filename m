From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoc: fix sound/soc/intel/skylake/slk-ssp-clk.c build error
 on IA64
Date: Wed, 22 May 2019 20:58:35 -0700
Message-ID: <9019c87f-cf1a-b59f-d87e-8169b247cf88@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc: kbuild test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

skl-ssp-clk.c does not build on IA64 because the driver
uses the common clock interface, so make the driver depend
on COMMON_CLK.

Fixes this build error:
../sound/soc/intel/skylake/skl-ssp-clk.c:26:16: error: field 'hw' has incomplete type
  struct clk_hw hw;
                ^~

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/intel/Kconfig        |    3 ++-
 sound/soc/intel/boards/Kconfig |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- lnx-52-rc1.orig/sound/soc/intel/Kconfig
+++ lnx-52-rc1/sound/soc/intel/Kconfig
@@ -104,7 +104,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
 config SND_SOC_INTEL_SKYLAKE
 	tristate "All Skylake/SST Platforms"
 	depends on PCI && ACPI
-	select SND_SOC_INTEL_SKL
+	select SND_SOC_INTEL_SKL if COMMON_CLK
 	select SND_SOC_INTEL_APL
 	select SND_SOC_INTEL_KBL
 	select SND_SOC_INTEL_GLK
@@ -120,6 +120,7 @@ config SND_SOC_INTEL_SKYLAKE
 config SND_SOC_INTEL_SKL
 	tristate "Skylake Platforms"
 	depends on PCI && ACPI
+	depends on COMMON_CLK
 	select SND_SOC_INTEL_SKYLAKE_FAMILY
 	help
 	  If you have a Intel Skylake platform with the DSP enabled
--- lnx-52-rc1.orig/sound/soc/intel/boards/Kconfig
+++ lnx-52-rc1/sound/soc/intel/boards/Kconfig
@@ -286,7 +286,7 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927
 	select SND_SOC_MAX98927
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
-	select SND_SOC_INTEL_SKYLAKE_SSP_CLK
+	select SND_SOC_INTEL_SKYLAKE_SSP_CLK if COMMON_CLK
 	help
 	  This adds support for ASoC Onboard Codec I2S machine driver. This will
 	  create an alsa sound card for RT5663 + MAX98927.
