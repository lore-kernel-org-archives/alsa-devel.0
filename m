From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: byt-match.c: remove prefix for
	SOF files" to the asoc tree
Date: Tue, 12 Feb 2019 16:58:44 +0000 (GMT)
Message-ID: <20190212165844.D44DD1128113@debutante.sirena.org.uk>
References: <20190208234557.7816-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 88C80267956
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 17:58:45 +0100 (CET)
In-Reply-To: <20190208234557.7816-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: byt-match.c: remove prefix for SOF files

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 528f07152a7840b5affe1c8844ddd1ee9d3aabd7 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Feb 2019 17:45:42 -0600
Subject: [PATCH] ASoC: Intel: byt-match.c: remove prefix for SOF files

Prefix is now handled in the code. This allows for default and
alternate paths, and more flexibility for OEMs and distros

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../intel/common/soc-acpi-intel-byt-match.c   | 48 +++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index 96f9c553fe6c..a46a3514a0f0 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -83,8 +83,8 @@ static struct snd_soc_acpi_mach byt_thinkpad_10 = {
 	.drv_name = "cht-bsw-rt5672",
 	.fw_filename = "intel/fw_sst_0f28.bin",
 	.board = "cht-bsw",
-	.sof_fw_filename = "intel/sof-byt.ri",
-	.sof_tplg_filename = "intel/sof-byt-rt5670.tplg",
+	.sof_fw_filename = "sof-byt.ri",
+	.sof_tplg_filename = "sof-byt-rt5670.tplg",
 	.asoc_plat_name = "sst-mfld-platform",
 };
 
@@ -93,8 +93,8 @@ static struct snd_soc_acpi_mach byt_pov_p1006w = {
 	.drv_name = "bytcr_rt5651",
 	.fw_filename = "intel/fw_sst_0f28.bin",
 	.board = "bytcr_rt5651",
-	.sof_fw_filename = "intel/sof-byt.ri",
-	.sof_tplg_filename = "intel/sof-byt-rt5651.tplg",
+	.sof_fw_filename = "sof-byt.ri",
+	.sof_tplg_filename = "sof-byt-rt5651.tplg",
 	.asoc_plat_name = "sst-mfld-platform",
 };
 
@@ -136,8 +136,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
 		.machine_quirk = byt_quirk,
-		.sof_fw_filename = "intel/sof-byt.ri",
-		.sof_tplg_filename = "intel/sof-byt-rt5640.tplg",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -145,8 +145,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
-		.sof_fw_filename = "intel/sof-byt.ri",
-		.sof_tplg_filename = "intel/sof-byt-rt5640.tplg",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -154,8 +154,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
-		.sof_fw_filename = "intel/sof-byt.ri",
-		.sof_tplg_filename = "intel/sof-byt-rt5640.tplg",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -163,8 +163,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcr_rt5651",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5651",
-		.sof_fw_filename = "intel/sof-byt.ri",
-		.sof_tplg_filename = "intel/sof-byt-rt5651.tplg",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt-rt5651.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -172,8 +172,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcht_da7213",
-		.sof_fw_filename = "intel/sof-byt.ri",
-		.sof_tplg_filename = "intel/sof-byt-da7213.tplg",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -181,8 +181,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcht_da7213",
-		.sof_fw_filename = "intel/sof-byt.ri",
-		.sof_tplg_filename = "intel/sof-byt-da7213.tplg",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -190,8 +190,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcht_es8316",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcht_es8316",
-		.sof_fw_filename = "intel/sof-byt.ri",
-		.sof_tplg_filename = "intel/sof-byt-es8316.tplg",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt-es8316.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
@@ -200,8 +200,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-byt.ri",
-		.sof_tplg_filename = "intel/sof-byt-rt5645.tplg",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -209,8 +209,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-byt.ri",
-		.sof_tplg_filename = "intel/sof-byt-rt5645.tplg",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* use CHT driver to Baytrail Chromebooks */
@@ -219,8 +219,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "cht-bsw-max98090",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-byt.ri",
-		.sof_tplg_filename = "intel/sof-byt-max98090.tplg",
+		.sof_fw_filename = "sof-byt.ri",
+		.sof_tplg_filename = "sof-byt-max98090.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
-- 
2.20.1
