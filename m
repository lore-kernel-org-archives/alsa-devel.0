From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/5] ASoC: Intel: boards: Add COMPILE_TEST for
	new machine drivers
Date: Thu, 30 May 2019 06:50:14 -0500
Message-ID: <20190530115015.5677-5-pierre-louis.bossart@linux.intel.com>
References: <20190530115015.5677-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F50BF896EB
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 13:50:40 +0200 (CEST)
In-Reply-To: <20190530115015.5677-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

We recently added COMPILE_TEST but new machine drivers were not
updated. Fix.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 59e366edc16b..7f6e9546e10c 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -157,7 +157,8 @@ config SND_SOC_INTEL_CHT_BSW_NAU8824_MACH
 
 config SND_SOC_INTEL_BYT_CHT_CX2072X_MACH
 	tristate "Baytrail & Cherrytrail with CX2072X codec"
-	depends on X86_INTEL_LPSS && I2C && ACPI
+	depends on I2C && ACPI
+	depends on X86_INTEL_LPSS || COMPILE_TEST
 	select SND_SOC_ACPI
 	select SND_SOC_CX2072X
 	help
@@ -398,8 +399,8 @@ if SND_SOC_SOF_HDA_COMMON || SND_SOC_SOF_BAYTRAIL
 config SND_SOC_INTEL_SOF_RT5682_MACH
 	tristate "SOF with rt5682 codec in I2S Mode"
 	depends on I2C && ACPI
-	depends on (SND_SOC_SOF_HDA_COMMON && MFD_INTEL_LPSS) ||\
-		   (SND_SOC_SOF_BAYTRAIL && X86_INTEL_LPSS)
+	depends on (SND_SOC_SOF_HDA_COMMON && (MFD_INTEL_LPSS || COMPILE_TEST)) ||\
+		   (SND_SOC_SOF_BAYTRAIL && (X86_INTEL_LPSS || COMPILE_TEST))
 	select SND_SOC_RT5682
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI if SND_SOC_SOF_HDA_COMMON
-- 
2.20.1
