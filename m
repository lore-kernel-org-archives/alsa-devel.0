From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 4/7] ASoC: Intel: Fix nested/unnecessary
	Kconfig dependencies
Date: Fri, 17 Nov 2017 18:01:59 -0600
Message-ID: <20171118000202.22302-5-pierre-louis.bossart@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D2D63266B67
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 01:02:28 +0100 (CET)
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
selected independently, no obvious issue detected but this needs to
be validated for functionality and may expose randconfig issues

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 136426d60da0..dee731d42634 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -28,8 +28,6 @@ config SND_SST_IPC_PCI
 config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
-	select SND_SOC_INTEL_SST
-	select IOSF_MBI
 	help
 	 This option controls the ACPI-based IPC for HiFi2 platforms
 	 (Baytrail, Cherrytrail)
@@ -42,7 +40,6 @@ config SND_SOC_INTEL_SST_ACPI
 
 config SND_SOC_INTEL_SST
 	tristate
-	select SND_SOC_INTEL_SST_ACPI if ACPI
 
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
@@ -56,6 +53,7 @@ config SND_SOC_INTEL_HASWELL
 	depends on SND_DMA_SGBUF && ACPI
 	depends on DMADEVICES
 	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SST_ACPI
 	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_INTEL_COMMON
 
@@ -63,6 +61,7 @@ config SND_SOC_INTEL_BAYTRAIL
 	tristate "Intel ASoC SST driver for Baytrail (legacy)"
 	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SST_ACPI
 	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_INTEL_COMMON
 
@@ -77,6 +76,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM
 	tristate "Intel ASoC SST driver for ACPI HiFi2 platforms (Baytrail, Cherrytrail)"
 	depends on X86 && ACPI
 	select SND_SST_IPC_ACPI
+	select IOSF_MBI
 	select SND_SOC_COMPRESS
 	select SND_SOC_INTEL_COMMON
 
-- 
2.14.1
