From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v7 7/7] ASoC: Intel: Skylake: add option to
	control HDAudio + DSP usage
Date: Fri, 17 Aug 2018 15:37:23 -0500
Message-ID: <20180817203723.32305-8-pierre-louis.bossart@linux.intel.com>
References: <20180817203723.32305-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 37D212677E8
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2018 22:37:33 +0200 (CEST)
In-Reply-To: <20180817203723.32305-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add option to explicitly enable HDAudio + DSP usage.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig       | 9 +++++++++
 sound/soc/intel/skylake/skl.c | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 0caa1f4eb94d..3ee6a407eb08 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -117,6 +117,15 @@ config SND_SOC_INTEL_SKYLAKE
 	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
 	  then enable this option by saying Y or m.
 
+config SND_SOC_INTEL_SKYLAKE_HDA_DSP
+	bool "Enable HDAudio Codec + DSP support"
+	depends on SND_SOC_INTEL_SKYLAKE
+	help
+	  If you have a Intel Skylake+ platform with the DSP enabled in
+	  the BIOS and an HDAudio codec, then enable this option by saying Y
+	  This option will only have an effect if there are no ACPI-enumerated
+	  audio devices (I2C, SoundWire).
+
 config SND_SOC_ACPI_INTEL_MATCH
 	tristate
 	select SND_SOC_ACPI if ACPI
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index d81a275f0bc0..1c260e81798a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -474,6 +474,7 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
 						{.name = "ssp5_sclkfs"},
 };
 
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDA_DSP)
 static struct snd_soc_acpi_mach *skl_find_hda_machine(struct skl *skl,
 					struct snd_soc_acpi_mach *machines)
 {
@@ -492,6 +493,13 @@ static struct snd_soc_acpi_mach *skl_find_hda_machine(struct skl *skl,
 
 	return mach;
 }
+#else
+static struct snd_soc_acpi_mach *skl_find_hda_machine(struct skl *skl,
+					struct snd_soc_acpi_mach *machines)
+{
+	return NULL;
+}
+#endif
 
 static int skl_find_machine(struct skl *skl, void *driver_data)
 {
-- 
2.17.1
