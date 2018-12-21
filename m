From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: fix unmet dependencies in Kconfig
Date: Fri, 21 Dec 2018 14:49:55 -0600
Message-ID: <20181221204955.30993-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Remove warnings by selecting SND_HDA_INTEL_DSP_DETECTION_XYZ only when
SND_HDA_INTEL is part of the config.

Fixes: c337104b1a16 ('ALSA: HD-Audio: SKL+: abort probe if DSP is present and Skylake driver selected')
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 2fd1b61e8331..555cdb1d87d4 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -188,12 +188,12 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
 	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
-	select SND_HDA_INTEL_DSP_DETECTION_SKL if SND_SOC_INTEL_SKL
-	select SND_HDA_INTEL_DSP_DETECTION_APL if SND_SOC_INTEL_APL
-	select SND_HDA_INTEL_DSP_DETECTION_KBL if SND_SOC_INTEL_KBL
-	select SND_HDA_INTEL_DSP_DETECTION_GLK if SND_SOC_INTEL_GLK
-	select SND_HDA_INTEL_DSP_DETECTION_CNL if SND_SOC_INTEL_CNL
-	select SND_HDA_INTEL_DSP_DETECTION_CFL if SND_SOC_INTEL_CFL
+	select SND_HDA_INTEL_DSP_DETECTION_SKL if SND_SOC_INTEL_SKL && SND_HDA_INTEL
+	select SND_HDA_INTEL_DSP_DETECTION_APL if SND_SOC_INTEL_APL && SND_HDA_INTEL
+	select SND_HDA_INTEL_DSP_DETECTION_KBL if SND_SOC_INTEL_KBL && SND_HDA_INTEL
+	select SND_HDA_INTEL_DSP_DETECTION_GLK if SND_SOC_INTEL_GLK && SND_HDA_INTEL
+	select SND_HDA_INTEL_DSP_DETECTION_CNL if SND_SOC_INTEL_CNL && SND_HDA_INTEL
+	select SND_HDA_INTEL_DSP_DETECTION_CFL if SND_SOC_INTEL_CFL && SND_HDA_INTEL
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
 	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
-- 
2.17.1
