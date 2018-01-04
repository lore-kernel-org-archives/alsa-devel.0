From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 09/10] ASoC: Intel: kconfig: add some comments for if symbols
Date: Thu,  4 Jan 2018 16:36:00 -0600
Message-ID: <20180104223601.5831-10-pierre-louis.bossart@linux.intel.com>
References: <20180104223601.5831-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180104223601.5831-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, torvalds@linux-foundation.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Help in finding matching "if" endings by commenting the "endif".

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 063611ad641c..e1b6addcd13d 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -24,7 +24,7 @@ config SND_MFLD_MACHINE
           Say Y if you have such a device.
           If unsure select "N".
 
-endif
+endif ## SND_SST_ATOM_HIFI2_PLATFORM_PCI
 
 if SND_SOC_INTEL_HASWELL
 
@@ -57,7 +57,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  Ultrabook platforms.
 	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
-endif
+endif ## SND_SOC_INTEL_HASWELL
 
 if SND_SOC_INTEL_BAYTRAIL
 
@@ -80,7 +80,7 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 	  with the RT5640 audio codec. This driver is deprecated, use
 	  SND_SOC_INTEL_BYTCR_RT5640_MACH instead for better functionality.
 
-endif
+endif ## SND_SOC_INTEL_BAYTRAIL
 
 if SND_SST_ATOM_HIFI2_PLATFORM
 
@@ -172,7 +172,7 @@ config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 
 	  If unsure select "N".
 
-endif
+endif ## SND_SST_ATOM_HIFI2_PLATFORM
 
 if SND_SOC_INTEL_SKYLAKE
 
@@ -268,6 +268,6 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
           create an alsa sound card for RT5663 + RT5514 + MAX98927.
           Say Y or m if you have such a device. This is a recommended option.
           If unsure select "N".
-endif
+endif ## SND_SOC_INTEL_SKYLAKE
 
 endif ## SND_SOC_INTEL_MACH
-- 
2.14.1
