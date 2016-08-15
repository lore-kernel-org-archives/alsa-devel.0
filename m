From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt56040: additional
	routing quirks" to the asoc tree
Date: Mon, 15 Aug 2016 15:15:54 +0100
Message-ID: <E1bZIgE-0007Lk-6Y@debutante>
References: <1471037280-17433-9-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C302426772B
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:16:00 +0200 (CEST)
In-Reply-To: <1471037280-17433-9-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt56040: additional routing quirks

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

>From f47088d5ae6bec6d01bb0fd71c7d113aa8eaaa27 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Aug 2016 16:27:51 -0500
Subject: [PATCH] ASoC: Intel: bytcr_rt56040: additional routing quirks

Allow for all possible combinations of SSP0,SSP2, AIF1, AIF2
combination (only one at a time)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 44 +++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 6c6f67356c99..4337b5e85921 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -43,6 +43,8 @@ enum {
 #define BYT_RT5640_MONO_SPEAKER BIT(17)
 #define BYT_RT5640_DIFF_MIC     BIT(18) /* defaut is single-ended */
 #define BYT_RT5640_SSP2_AIF2     BIT(19) /* default is using AIF1  */
+#define BYT_RT5640_SSP0_AIF1     BIT(20)
+#define BYT_RT5640_SSP0_AIF2     BIT(21)
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
 					BYT_RT5640_DMIC_EN;
@@ -94,6 +96,22 @@ static const struct snd_soc_dapm_route byt_rt5640_ssp2_aif2_map[] = {
 	{"ssp2 Rx", NULL, "AIF2 Capture"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5640_ssp0_aif1_map[] = {
+	{"ssp0 Tx", NULL, "modem_out"},
+	{"modem_in", NULL, "ssp0 Rx"},
+
+	{"AIF1 Playback", NULL, "ssp0 Tx"},
+	{"ssp0 Rx", NULL, "AIF1 Capture"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5640_ssp0_aif2_map[] = {
+	{"ssp0 Tx", NULL, "modem_out"},
+	{"modem_in", NULL, "ssp0 Rx"},
+
+	{"AIF2 Playback", NULL, "ssp0 Tx"},
+	{"ssp0 Rx", NULL, "AIF2 Capture"},
+};
+
 static const struct snd_soc_dapm_route byt_rt5640_stereo_spk_map[] = {
 	{"Speaker", NULL, "SPOLP"},
 	{"Speaker", NULL, "SPOLN"},
@@ -231,6 +249,14 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		ret = snd_soc_dapm_add_routes(&card->dapm,
 					byt_rt5640_ssp2_aif2_map,
 					ARRAY_SIZE(byt_rt5640_ssp2_aif2_map));
+	} else if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) {
+		ret = snd_soc_dapm_add_routes(&card->dapm,
+					byt_rt5640_ssp0_aif1_map,
+					ARRAY_SIZE(byt_rt5640_ssp0_aif1_map));
+	} else if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2) {
+		ret = snd_soc_dapm_add_routes(&card->dapm,
+					byt_rt5640_ssp0_aif2_map,
+					ARRAY_SIZE(byt_rt5640_ssp0_aif2_map));
 	} else {
 		ret = snd_soc_dapm_add_routes(&card->dapm,
 					byt_rt5640_ssp2_aif1_map,
@@ -369,7 +395,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 	{
 		.name = "SSP2-Codec",
 		.id = 1,
-		.cpu_dai_name = "ssp2-port",
+		.cpu_dai_name = "ssp2-port", /* overwritten for ssp0 routing */
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
 		.codec_dai_name = "rt5640-aif1", /* changed w/ quirk */
@@ -400,6 +426,7 @@ static struct snd_soc_card byt_rt5640_card = {
 
 static char byt_rt5640_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
 static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
+static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
@@ -434,7 +461,8 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
 
-	if (byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) {
+	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
+	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
 
 		/* fixup codec aif name */
 		snprintf(byt_rt5640_codec_aif_name,
@@ -445,6 +473,18 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			byt_rt5640_codec_aif_name;
 	}
 
+	if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
+	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
+
+		/* fixup cpu dai name name */
+		snprintf(byt_rt5640_cpu_dai_name,
+			sizeof(byt_rt5640_cpu_dai_name),
+			"%s", "ssp0-port");
+
+		byt_rt5640_dais[dai_index].cpu_dai_name =
+			byt_rt5640_cpu_dai_name;
+	}
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
 
 	if (ret_val) {
-- 
2.8.1
