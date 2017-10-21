From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: add SOF firmare/topology file
	information" to the asoc tree
Date: Sat, 21 Oct 2017 11:29:27 +0100 (BST)
Message-ID: <20171021102927.3F9C9440057@finisterre.ee.mobilebroadband>
References: <20171012234945.30318-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FB9A267778
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 12:29:34 +0200 (CEST)
In-Reply-To: <20171012234945.30318-6-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: add SOF firmare/topology file information

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c1a8ed6930e4df1de24546e41b55530985170718 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 12 Oct 2017 18:49:42 -0500
Subject: [PATCH] ASoC: Intel: add SOF firmare/topology file information

Prepare for SOF integration, no functional change

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-byt-match.c  | 30 ++++++++++++++++
 sound/soc/intel/common/soc-acpi-intel-cht-match.c  | 40 +++++++++++++++++++++-
 .../intel/common/soc-acpi-intel-hsw-bdw-match.c    | 12 +++++++
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index da80b4871a55..bfe1ca68a542 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -59,6 +59,9 @@ static struct snd_soc_acpi_mach byt_thinkpad_10 = {
 	.drv_name = "cht-bsw-rt5672",
 	.fw_filename = "intel/fw_sst_0f28.bin",
 	.board = "cht-bsw",
+	.sof_fw_filename = "intel/reef-byt.ri",
+	.sof_tplg_filename = "intel/reef-byt-rt5670.tplg",
+	.asoc_plat_name = "sst-mfld-platform",
 };
 
 static struct snd_soc_acpi_mach *byt_quirk(void *arg)
@@ -95,36 +98,54 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
 		.machine_quirk = byt_quirk,
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5640.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5642",
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5640.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "INTCCFFD",
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5640",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5640.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5651",
 		.drv_name = "bytcr_rt5651",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcr_rt5651",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5651.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7212",
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcht_da7213",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-da7213.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7213",
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "bytcht_da7213",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-da7213.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
 	{
@@ -132,12 +153,18 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5645.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5648",
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-rt5645.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* use CHT driver to Baytrail Chromebooks */
 	{
@@ -145,6 +172,9 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
 		.drv_name = "cht-bsw-max98090",
 		.fw_filename = "intel/fw_sst_0f28.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-byt.ri",
+		.sof_tplg_filename = "intel/reef-byt-max98090.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 73eb57706654..b50a0d53846b 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -39,12 +39,14 @@ static const struct dmi_system_id cht_table[] = {
 	{ }
 };
 
-
 static struct snd_soc_acpi_mach cht_surface_mach = {
 	.id = "10EC5640",
 	.drv_name = "cht-bsw-rt5645",
 	.fw_filename = "intel/fw_sst_22a8.bin",
 	.board = "cht-bsw",
+	.sof_fw_filename = "intel/reef-cht.ri",
+	.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+	.asoc_plat_name = "sst-mfld-platform",
 };
 
 static struct snd_soc_acpi_mach *cht_quirk(void *arg)
@@ -66,54 +68,81 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5670.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5672",
 		.drv_name = "cht-bsw-rt5672",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5670.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5645",
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC5650",
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC3270",
 		.drv_name = "cht-bsw-rt5645",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5645.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "193C9890",
 		.drv_name = "cht-bsw-max98090",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-max98090.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7212",
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-da7213.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "DLGS7213",
 		.drv_name = "bytcht_da7213",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_da7213",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-da7213.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "ESSX8316",
 		.drv_name = "bytcht_es8316",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcht_es8316",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-es8316.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{
@@ -122,12 +151,18 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
 		.machine_quirk = cht_quirk,
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5640.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
 		.id = "10EC3276",
 		.drv_name = "bytcr_rt5640",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5640",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5640.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 	/* some CHT-T platforms rely on RT5651, use Baytrail machine driver */
 	{
@@ -135,6 +170,9 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "bytcr_rt5651",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "bytcr_rt5651",
+		.sof_fw_filename = "intel/reef-cht.ri",
+		.sof_tplg_filename = "intel/reef-cht-rt5651.tplg",
+		.asoc_plat_name = "sst-mfld-platform",
 	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index 23329f2a802d..e0e8c8c27528 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -23,6 +23,9 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[] = {
 		.id = "INT33CA",
 		.drv_name = "haswell-audio",
 		.fw_filename = "intel/IntcSST1.bin",
+		.sof_fw_filename = "intel/reef-hsw.ri",
+		.sof_tplg_filename = "intel/reef-hsw.tplg",
+		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
 };
@@ -33,16 +36,25 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.id = "INT343A",
 		.drv_name = "broadwell-audio",
 		.fw_filename =  "intel/IntcSST2.bin",
+		.sof_fw_filename = "intel/reef-bdw.ri",
+		.sof_tplg_filename = "intel/reef-bdw-rt286.tplg",
+		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "RT5677CE",
 		.drv_name = "bdw-rt5677",
 		.fw_filename =  "intel/IntcSST2.bin",
+		.sof_fw_filename = "intel/reef-bdw.ri",
+		.sof_tplg_filename = "intel/reef-bdw-rt286.tplg",
+		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
 		.id = "INT33CA",
 		.drv_name = "haswell-audio",
 		.fw_filename = "intel/IntcSST2.bin",
+		.sof_fw_filename = "intel/reef-bdw.ri",
+		.sof_tplg_filename = "intel/reef-bdw-rt5640.tplg",
+		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{}
 };
-- 
2.14.1
