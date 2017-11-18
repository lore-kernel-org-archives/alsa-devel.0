From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 6/7] ASoC: Intel: boards: align Kconfig
	configurations for HiFi2
Date: Fri, 17 Nov 2017 18:02:01 -0600
Message-ID: <20171118000202.22302-7-pierre-louis.bossart@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C779266B67
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 01:02:31 +0100 (CET)
In-Reply-To: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
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
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

Make sure all the configs are aligned
Also add the missing dependencies on SOC_ACPI stuff used to fix
DAI names based on HID.

FIXME: not sure why X86_INTEL_LPSS is needed in a machine
driver config, should it be back to X86 everywhere?

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index f900b1e6b952..7379b0220210 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -88,7 +88,8 @@ if SND_SST_ATOM_HIFI2_PLATFORM
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
-	depends on X86 && I2C && ACPI
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select CONFIG_SND_SOC_ACPI
 	select SND_SOC_RT5640
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
@@ -98,7 +99,8 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
-	depends on X86 && I2C && ACPI
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select CONFIG_SND_SOC_ACPI
 	select SND_SOC_RT5651
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
@@ -109,7 +111,8 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
-        select SND_SOC_RT5670
+	select CONFIG_SND_SOC_ACPI
+	select SND_SOC_RT5670
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
           platforms with RT5672 audio codec.
@@ -119,6 +122,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
+	select CONFIG_SND_SOC_ACPI
 	select SND_SOC_RT5645
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
@@ -140,6 +144,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
+	select CONFIG_SND_SOC_ACPI
 	select SND_SOC_DA7213
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
-- 
2.14.1
