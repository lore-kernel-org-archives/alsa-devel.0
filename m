From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: rename 'reef' to 'sof'
	in ACPI matching table" to the asoc tree
Date: Thu, 21 Jun 2018 16:31:38 +0100
Message-ID: <E1fW1Yg-0001N5-PT@debutante>
References: <20180619190037.8307-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DC5E2676C3
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 17:31:45 +0200 (CEST)
In-Reply-To: <20180619190037.8307-1-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: common: rename 'reef' to 'sof' in ACPI matching table

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

>From 4f722a6a736765310bc95dd3879f1545e5f64303 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 19 Jun 2018 14:00:37 -0500
Subject: [PATCH] ASoC: Intel: common: rename 'reef' to 'sof' in ACPI matching
 table

Align with firmware tools, no functionality change

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../intel/common/soc-acpi-intel-byt-match.c   | 40 +++++++-------
 .../intel/common/soc-acpi-intel-cht-match.c   | 52 +++++++++----------
 .../common/soc-acpi-intel-hsw-bdw-match.c     | 16 +++---
 3 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index bfe1ca68a542..4daa8a4f0c0c 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -59,8 +59,8 @@ static struct snd_soc_acpi_mach byt_thinkpad_10 = {
 	.drv_name = "cht-bsw-rt5672",
 	.fw_filename = "intel/fw_sst_0f28.bin",
 	.board = "cht-bsw",
-	.sof_fw_filename = "intel/reef-byt.ri",
-	.sof_tplg_filename = "intel/reef-byt-rt5670.tplg",
+	.sof_fw_filename = "intel/sof-byt.ri",
+	.sof_tplg_filename = "intel/sof-byt-rt5670.tplg",
 	.asoc_plat_name = "sst-mfld-platform",
 };
 
@@ -98,8 +98,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
 		.machine_quirk = byt_quirk,
-		.sof_fw_filename = "intel/reef-byt.ri",
-		.sof_tplg_filename = "intel/reef-byt-rt5640.tplg",
+		.sof_fw_filename = "intel/sof-byt.ri",
+		.sof_tplg_filename = "intel/sof-byt-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -107,8 +107,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
-		.sof_fw_filename = "intel/reef-byt.ri",
-		.sof_tplg_filename = "intel/reef-byt-rt5640.tplg",
+		.sof_fw_filename = "intel/sof-byt.ri",
+		.sof_tplg_filename = "intel/sof-byt-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -116,8 +116,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
-		.sof_fw_filename = "intel/reef-byt.ri",
-		.sof_tplg_filename = "intel/reef-byt-rt5640.tplg",
+		.sof_fw_filename = "intel/sof-byt.ri",
+		.sof_tplg_filename = "intel/sof-byt-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -125,8 +125,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcr_rt5651",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5651",
-		.sof_fw_filename = "intel/reef-byt.ri",
-		.sof_tplg_filename = "intel/reef-byt-rt5651.tplg",
+		.sof_fw_filename = "intel/sof-byt.ri",
+		.sof_tplg_filename = "intel/sof-byt-rt5651.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -134,8 +134,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcht_da7213",
-		.sof_fw_filename = "intel/reef-byt.ri",
-		.sof_tplg_filename = "intel/reef-byt-da7213.tplg",
+		.sof_fw_filename = "intel/sof-byt.ri",
+		.sof_tplg_filename = "intel/sof-byt-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -143,8 +143,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcht_da7213",
-		.sof_fw_filename = "intel/reef-byt.ri",
-		.sof_tplg_filename = "intel/reef-byt-da7213.tplg",
+		.sof_fw_filename = "intel/sof-byt.ri",
+		.sof_tplg_filename = "intel/sof-byt-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
@@ -153,8 +153,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-byt.ri",
-		.sof_tplg_filename = "intel/reef-byt-rt5645.tplg",
+		.sof_fw_filename = "intel/sof-byt.ri",
+		.sof_tplg_filename = "intel/sof-byt-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -162,8 +162,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-byt.ri",
-		.sof_tplg_filename = "intel/reef-byt-rt5645.tplg",
+		.sof_fw_filename = "intel/sof-byt.ri",
+		.sof_tplg_filename = "intel/sof-byt-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* use CHT driver to Baytrail Chromebooks */
@@ -172,8 +172,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "cht-bsw-max98090",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-byt.ri",
-		.sof_tplg_filename = "intel/reef-byt-max98090.tplg",
+		.sof_fw_filename = "intel/sof-byt.ri",
+		.sof_tplg_filename = "intel/sof-byt-max98090.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index ad1eb2d644be..3c3f2f8585d7 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -44,8 +44,8 @@ static struct snd_soc_acpi_mach cht_surface_mach = {
 	.drv_name = "cht-bsw-rt5645",
 	.fw_filename = "intel/fw_sst_22a8.bin",
 	.board = "cht-bsw",
-	.sof_fw_filename = "intel/reef-cht.ri",
-	.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+	.sof_fw_filename = "intel/sof-cht.ri",
+	.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
 	.asoc_plat_name = "sst-mfld-platform",
 };
 
@@ -68,8 +68,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-rt5670.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-rt5670.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -77,8 +77,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-rt5670.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-rt5670.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -86,8 +86,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -95,8 +95,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -104,8 +104,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-rt5645.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -113,8 +113,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-max98090",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-max98090.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-max98090.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -131,8 +131,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-da7213.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -140,8 +140,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-da7213.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-da7213.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -149,8 +149,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcht_es8316",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_es8316",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-es8316.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-es8316.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
@@ -160,8 +160,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
 		.machine_quirk = cht_quirk,
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-rt5640.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
@@ -169,8 +169,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-rt5640.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-rt5640.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
@@ -179,8 +179,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcr_rt5651",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5651",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-rt5651.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-rt5651.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index 53e7acdfbb81..494a0ea9b029 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -23,8 +23,8 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[] = {
 		.id = "INT33CA",
 		.drv_name = "haswell-audio",
 		.fw_filename = "intel/IntcSST1.bin",
-		.sof_fw_filename = "intel/reef-hsw.ri",
-		.sof_tplg_filename = "intel/reef-hsw.tplg",
+		.sof_fw_filename = "intel/sof-hsw.ri",
+		.sof_tplg_filename = "intel/sof-hsw.tplg",
 		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
@@ -36,24 +36,24 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.id = "INT343A",
 		.drv_name = "broadwell-audio",
 		.fw_filename =  "intel/IntcSST2.bin",
-		.sof_fw_filename = "intel/reef-bdw.ri",
-		.sof_tplg_filename = "intel/reef-bdw-rt286.tplg",
+		.sof_fw_filename = "intel/sof-bdw.ri",
+		.sof_tplg_filename = "intel/sof-bdw-rt286.tplg",
 		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "RT5677CE",
 		.drv_name = "bdw-rt5677",
 		.fw_filename =  "intel/IntcSST2.bin",
-		.sof_fw_filename = "intel/reef-bdw.ri",
-		.sof_tplg_filename = "intel/reef-bdw-rt5677.tplg",
+		.sof_fw_filename = "intel/sof-bdw.ri",
+		.sof_tplg_filename = "intel/sof-bdw-rt5677.tplg",
 		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "INT33CA",
 		.drv_name = "haswell-audio",
 		.fw_filename = "intel/IntcSST2.bin",
-		.sof_fw_filename = "intel/reef-bdw.ri",
-		.sof_tplg_filename = "intel/reef-bdw-rt5640.tplg",
+		.sof_fw_filename = "intel/sof-bdw.ri",
+		.sof_tplg_filename = "intel/sof-bdw-rt5640.tplg",
 		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
-- 
2.18.0.rc2
