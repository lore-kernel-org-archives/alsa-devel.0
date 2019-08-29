From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: SOF/Intel: fix selection of
	SND_INTEL_NHTL
Date: Thu, 29 Aug 2019 16:42:13 -0500
Message-ID: <20190829214213.11653-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F349AF800E7
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 23:42:28 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

We should only select SND_INTEL_NHLT when ACPI is defined. This was
done for the legacy HDAudio driver but not for DSP-enabled cases,
leading to compilation errors with randconfig.

Fix by aligning on the same solution.

For the Skylake driver this is overkill since there is a top-level
dependency on ACPI, but it doesn't hurt and it's better to have
consistency.

Fixes: 68b953aeb50d9 ('ASoC: SOF: Intel: hda: fixup HDaudio topology name with DMIC number')
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig     | 2 +-
 sound/soc/sof/intel/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a3ec17fd63cd..01c99750212a 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -215,7 +215,7 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
 	select SND_SOC_INTEL_SST
 	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
 	select SND_SOC_ACPI_INTEL_MATCH
-	select SND_INTEL_NHLT
+	select SND_INTEL_NHLT if ACPI
 	help
 	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
 	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 889b6202d054..479ba249e219 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -286,7 +286,7 @@ config SND_SOC_SOF_HDA
 	tristate
 	select SND_HDA_EXT_CORE if SND_SOC_SOF_HDA_LINK
 	select SND_SOC_HDAC_HDA if SND_SOC_SOF_HDA_AUDIO_CODEC
-	select SND_INTEL_NHLT
+	select SND_INTEL_NHLT if ACPI
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
-- 
2.20.1
