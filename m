From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht-match: remove prefix for SOF
	files" to the asoc tree
Date: Tue, 12 Feb 2019 16:58:42 +0000 (GMT)
Message-ID: <20190212165842.B41EB1128114@debutante.sirena.org.uk>
References: <20190208234557.7816-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 71E95267925
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 17:58:43 +0100 (CET)
In-Reply-To: <20190208234557.7816-4-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: cht-match: remove prefix for SOF files

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

>From 2e441dea9fee379e85dca15988671c23d6013d1c Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Feb 2019 17:45:43 -0600
Subject: [PATCH] ASoC: Intel: cht-match: remove prefix for SOF files

Prefix is now handled in the code. This allows for default and
alternate paths, and more flexibility for OEMs and distros

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../intel/common/soc-acpi-intel-cht-match.c   | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 91bb99b69601..21ce4bcbf25b 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -44,8 +44,8 @@ static struct snd_soc_acpi_mach cht_surface_mach = {
 	.drv_name = "cht-bsw-rt5645",
 	.fw_filename = "intel/fw_sst_22a8.bin",
 	.board = "cht-bsw",
-	.sof_fw_filename = "intel/sof-cht.ri",
-	.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
+	.sof_fw_filename = "sof-cht.ri",
+	.sof_tplg_filename = "sof-cht-rt5645.tplg",
 	.asoc_plat_name = "sst-mfld-platform",
 };
 
@@ -68,8 +68,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5670.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5670.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -77,8 +77,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5670.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5670.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -86,8 +86,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -95,8 +95,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -104,8 +104,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -113,8 +113,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-max98090",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-max98090.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-max98090.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -122,8 +122,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-nau8824",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-nau8824.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-nau8824.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -131,8 +131,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-da7213.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -140,8 +140,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-da7213.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -149,8 +149,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcht_es8316",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_es8316",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-es8316.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-es8316.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
@@ -160,8 +160,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
 		.machine_quirk = cht_quirk,
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5640.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -169,8 +169,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5640.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
@@ -179,8 +179,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcr_rt5651",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5651",
-		.sof_fw_filename = "intel/sof-cht.ri",
-		.sof_tplg_filename = "intel/sof-cht-rt5651.tplg",
+		.sof_fw_filename = "sof-cht.ri",
+		.sof_tplg_filename = "sof-cht-rt5651.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
-- 
2.20.1
