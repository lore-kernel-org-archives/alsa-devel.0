From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: soc-acpi: cht-match: remove
	asoc_plat_name field" to the asoc tree
Date: Tue, 12 Feb 2019 16:58:25 +0000 (GMT)
Message-ID: <20190212165825.A87311128113@debutante.sirena.org.uk>
References: <20190208234557.7816-12-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A05B267903
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 17:58:26 +0100 (CET)
In-Reply-To: <20190208234557.7816-12-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: soc-acpi: cht-match: remove asoc_plat_name field

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

>From 9eebe4372f4a608e51b7a2c0b064069e78a6ce5b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Feb 2019 17:45:51 -0600
Subject: [PATCH] ASoC: Intel: soc-acpi: cht-match: remove asoc_plat_name field

This field was never used, let's remove it

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-cht-match.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 21ce4bcbf25b..deafd87cc764 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -46,7 +46,6 @@ static struct snd_soc_acpi_mach cht_surface_mach = {
 	.board = "cht-bsw",
 	.sof_fw_filename = "sof-cht.ri",
 	.sof_tplg_filename = "sof-cht-rt5645.tplg",
-	.asoc_plat_name = "sst-mfld-platform",
 };
 
 static struct snd_soc_acpi_mach *cht_quirk(void *arg)
@@ -70,7 +69,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5670.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5672",
@@ -79,7 +77,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5670.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5645",
@@ -88,7 +85,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5645.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5650",
@@ -97,7 +93,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5645.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC3270",
@@ -106,7 +101,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5645.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "193C9890",
@@ -115,7 +109,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-max98090.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10508824",
@@ -124,7 +117,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "cht-bsw",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-nau8824.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7212",
@@ -133,7 +125,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "bytcht_da7213",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-da7213.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7213",
@@ -142,7 +133,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "bytcht_da7213",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-da7213.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "ESSX8316",
@@ -151,7 +141,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "bytcht_es8316",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-es8316.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{
@@ -162,7 +151,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.machine_quirk = cht_quirk,
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5640.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC3276",
@@ -171,7 +159,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "bytcr_rt5640",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5640.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
 	{
@@ -181,7 +168,6 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.board = "bytcr_rt5651",
 		.sof_fw_filename = "sof-cht.ri",
 		.sof_tplg_filename = "sof-cht-rt5651.tplg",
-		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
-- 
2.20.1
