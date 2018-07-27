From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v5 8/8] ASoC: Intel: Skylake: add option to
	control HDAudio + DSP usage
Date: Fri, 27 Jul 2018 18:05:54 -0500
Message-ID: <20180727230554.31027-9-pierre-louis.bossart@linux.intel.com>
References: <20180727230554.31027-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 95D61267783
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2018 01:06:26 +0200 (CEST)
In-Reply-To: <20180727230554.31027-1-pierre-louis.bossart@linux.intel.com>
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

Add two options to explicitly enable HDAudio + DSP usage and force its
use

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig       | 19 +++++++++++++++++++
 sound/soc/intel/skylake/skl.c |  7 ++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 0caa1f4eb94d..93c3693cdf13 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -117,6 +117,25 @@ config SND_SOC_INTEL_SKYLAKE
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
+config SND_SOC_INTEL_SKYLAKE_FORCE_HDA_DSP
+	bool "Force HDAudio Codec + DSP support"
+	depends on SND_SOC_INTEL_SKYLAKE_HDA_DSP
+	help
+	  If you have a Intel Skylake+ platform with the DSP enabled in
+	  the BIOS and an HDAudio codec, then enable this option by saying Y
+	  This option will ignore information from the BIOS and force the use
+	  of the HDaudio codec, if present.
+	  This is a debug option not recommended for distros.
+
 config SND_SOC_ACPI_INTEL_MATCH
 	tristate
 	select SND_SOC_ACPI if ACPI
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index e8bf46cfea45..b14a47e765de 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -474,6 +474,7 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
 						{.name = "ssp5_sclkfs"},
 };
 
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDA_DSP)
 static struct snd_soc_acpi_mach *skl_find_hda_machine(struct skl *skl,
 					struct snd_soc_acpi_mach *machines)
 {
@@ -492,6 +493,7 @@ static struct snd_soc_acpi_mach *skl_find_hda_machine(struct skl *skl,
 
 	return mach;
 }
+#endif
 
 static int skl_find_machine(struct skl *skl, void *driver_data)
 {
@@ -500,13 +502,16 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
 	struct skl_machine_pdata *pdata;
 
 	mach = snd_soc_acpi_find_machine(mach);
-	if (!mach) {
+	if (!mach || IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_FORCE_HDA_DSP)) {
 		dev_dbg(bus->dev, "No matching I2S machine driver found\n");
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDA_DSP)
 		mach = skl_find_hda_machine(skl, driver_data);
+#endif
 		if (!mach) {
 			dev_err(bus->dev, "No matching machine driver found\n");
 			return -ENODEV;
 		}
+
 	}
 
 	skl->mach = mach;
-- 
2.14.1
