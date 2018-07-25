From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 8/8] ASoC: Intel: Skylake: add option to
	control HDAudio + DSP usage
Date: Tue, 24 Jul 2018 19:50:55 -0500
Message-ID: <20180725005055.18138-9-pierre-louis.bossart@linux.intel.com>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 53319267749
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 02:52:33 +0200 (CEST)
In-Reply-To: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
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
 sound/soc/intel/Kconfig       | 18 ++++++++++++++++++
 sound/soc/intel/skylake/skl.c |  7 ++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 0caa1f4eb94d..494cc1015207 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -117,6 +117,24 @@ config SND_SOC_INTEL_SKYLAKE
 	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
 	  then enable this option by saying Y or m.
 
+config SND_SOC_INTEL_SKYLAKE_HDA_DSP
+	tristate "Enable HDA+DSP support"
+	depends on SND_SOC_INTEL_SKYLAKE
+	help
+	  If you have a Intel Skylake+ platform with the DSP enabled in the BIOS,
+	  and an HDAudio codec, the enable this option by saying Y or m.
+	  This option will only have an effect if there are no ACPI-enumerated audio
+	  devices (I2C, SoundWire).
+
+config SND_SOC_INTEL_SKYLAKE_FORCE_HDA_DSP
+	tristate "Force HDA+DSP support"
+	depends on SND_SOC_INTEL_SKYLAKE_HDA_DSP
+	help
+	  If you have a Intel Skylake+ platform with the DSP enabled in the BIOS,
+	  and an HDAudio codec, the enable this option by saying Y or m.
+	  This option will ignore information from the BIOS and force the use of the
+	  HDaudio codec, if present. This is a debug option not recommended for distros.
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
