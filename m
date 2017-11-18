From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 2/7] ASoC: Intel: Kconfig: Simplify-clarify
	ACPI/PCI dependencies
Date: Fri, 17 Nov 2017 18:01:57 -0600
Message-ID: <20171118000202.22302-3-pierre-louis.bossart@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 91FFE267205
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 01:02:25 +0100 (CET)
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

PCI/ACPI selections should not happen in Kconfig for machine drivers,
move to SOC selections.

Add distinction between PCI and ACPI HiFi2 platforms. The PCI-based
platforms may be removed at some point since Medfield is not really
supported by anyone and there is no publicly available firmware for
Merrifield.

There should be no functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig        | 16 ++++++++++++----
 sound/soc/intel/boards/Kconfig | 14 ++++----------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 98ef2273665f..175b2965ca21 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -39,7 +39,7 @@ config SND_SOC_INTEL_SST_ACPI
 
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
-	depends on SND_DMA_SGBUF
+	depends on SND_DMA_SGBUF && ACPI
 	depends on DMADEVICES
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
@@ -47,14 +47,22 @@ config SND_SOC_INTEL_HASWELL
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate "Intel ASoC SST driver for Baytrail (legacy)"
-	depends on DMADEVICES
+	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_INTEL_COMMON
 
+config SND_SST_ATOM_HIFI2_PLATFORM_PCI
+	tristate "Intel ASoC SST driver for PCI HiFi2 platforms (Medfield, Merrifield)"
+	depends on X86 && PCI
+	select SND_SST_IPC_PCI
+	select SND_SOC_COMPRESS
+	select SND_SOC_INTEL_COMMON
+
 config SND_SST_ATOM_HIFI2_PLATFORM
-	tristate "Intel ASoC SST driver for HiFi2 platforms (*field, *trail)"
-	depends on X86
+	tristate "Intel ASoC SST driver for ACPI HiFi2 platforms (Baytrail, Cherrytrail)"
+	depends on X86 && ACPI
+	select SND_SST_IPC_ACPI
 	select SND_SOC_COMPRESS
 	select SND_SOC_INTEL_COMMON
 
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 4ae44b0cea0a..bb40f042962f 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -12,18 +12,20 @@ config  SND_SOC_INTEL_MACH
 
 if SND_SOC_INTEL_MACH
 
+if SND_SST_ATOM_HIFI2_PLATFORM_PCI
+
 config SND_MFLD_MACHINE
 	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
 	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
-	select SND_SST_IPC_PCI
 	help
           This adds support for ASoC machine driver for Intel(R) MID Medfield platform
           used as alsa device in audio substem in Intel(R) MID devices
           Say Y if you have such a device.
           If unsure select "N".
 
+endif
+
 if SND_SOC_INTEL_HASWELL
 
 config SND_SOC_INTEL_HASWELL_MACH
@@ -88,7 +90,6 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
-	select SND_SST_IPC_ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5640 audio codec.
@@ -99,7 +100,6 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5651
-	select SND_SST_IPC_ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5651 audio codec.
@@ -110,7 +110,6 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
-        select SND_SST_IPC_ACPI
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
           platforms with RT5672 audio codec.
@@ -121,7 +120,6 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
-	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with RT5645/5650 audio codec.
@@ -133,7 +131,6 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
-	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
@@ -144,7 +141,6 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_DA7213
-	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
 	  platforms with DA7212/7213 audio codec.
@@ -155,7 +151,6 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with ES8316 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ES8316
-	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail &
 	  Cherrytrail platforms with ES8316 audio codec.
@@ -166,7 +161,6 @@ config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
 	default n
 	depends on X86_INTEL_LPSS && I2C && ACPI
-	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for the MinnowBoard Max or
 	  Up boards and provides access to I2S signals on the Low-Speed
-- 
2.14.1
