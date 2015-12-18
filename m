From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 06/19] ASoC: Intel: tag byt-rt5640 machine
	driver as deprecated
Date: Thu, 17 Dec 2015 20:35:43 -0600
Message-ID: <1450406156-22246-7-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 03A5A261543
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 03:37:13 +0100 (CET)
In-Reply-To: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: bardliao@realtek.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org

All the functionality was merged in DPCM-based driver,
keep older driver to avoid breaking userspace but
tag it as unsupported/deprecated

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 2d3b124..a23a4fd 100644
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
1.9.1
