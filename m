From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: merge DMI-based quirks
	in bytcr-rt5640 driver" to the asoc tree
Date: Sat, 19 Dec 2015 11:51:32 +0000
Message-ID: <E1aAG2u-0004fQ-Qo@debutante>
References: <1450406156-22246-6-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 692042605F2
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 12:51:43 +0100 (CET)
In-Reply-To: <1450406156-22246-6-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: merge DMI-based quirks in bytcr-rt5640 driver

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

>From 9fd57471017fcc2dc6ddda03c7bc196d31fe9ffe Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 17 Dec 2015 20:35:42 -0600
Subject: [PATCH] ASoC: Intel: boards: merge DMI-based quirks in bytcr-rt5640
 driver

Merge DMI quirks for various machines such as Asus T100
and clean-up code

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 78 ++++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 8dfb57d96985..944283f569c6 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -39,6 +39,13 @@ static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
+	{"AIF1 Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+	{"ssp2 Rx", NULL, "AIF1 Capture"},
+
 	{"Headset Mic", NULL, "MICBIAS1"},
 	{"IN2P", NULL, "Headset Mic"},
 	{"Headphone", NULL, "HPOL"},
@@ -47,15 +54,6 @@ static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
 	{"Speaker", NULL, "SPOLN"},
 	{"Speaker", NULL, "SPORP"},
 	{"Speaker", NULL, "SPORN"},
-	{"Internal Mic", NULL, "MICBIAS1"},
-	{"IN1P", NULL, "Internal Mic"},
-
-	{"AIF1 Playback", NULL, "ssp2 Tx"},
-	{"ssp2 Tx", NULL, "codec_out0"},
-	{"ssp2 Tx", NULL, "codec_out1"},
-	{"codec_in0", NULL, "ssp2 Rx"},
-	{"codec_in1", NULL, "ssp2 Rx"},
-	{"ssp2 Rx", NULL, "AIF1 Capture"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5640_intmic_dmic1_map[] = {
@@ -145,6 +143,54 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 	{}
 };
 
+static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+	struct snd_soc_codec *codec = runtime->codec;
+	struct snd_soc_card *card = runtime->card;
+	const struct snd_soc_dapm_route *custom_map;
+	int num_routes;
+
+	card->dapm.idle_bias_off = true;
+
+	ret = snd_soc_add_card_controls(card, byt_rt5640_controls,
+					ARRAY_SIZE(byt_rt5640_controls));
+	if (ret) {
+		dev_err(card->dev, "unable to add card controls\n");
+		return ret;
+	}
+
+	dmi_check_system(byt_rt5640_quirk_table);
+	switch (BYT_RT5640_MAP(byt_rt5640_quirk)) {
+	case BYT_RT5640_IN1_MAP:
+		custom_map = byt_rt5640_intmic_in1_map;
+		num_routes = ARRAY_SIZE(byt_rt5640_intmic_in1_map);
+		break;
+	case BYT_RT5640_DMIC2_MAP:
+		custom_map = byt_rt5640_intmic_dmic2_map;
+		num_routes = ARRAY_SIZE(byt_rt5640_intmic_dmic2_map);
+		break;
+	default:
+		custom_map = byt_rt5640_intmic_dmic1_map;
+		num_routes = ARRAY_SIZE(byt_rt5640_intmic_dmic1_map);
+	}
+
+	ret = snd_soc_dapm_add_routes(&card->dapm, custom_map, num_routes);
+	if (ret)
+		return ret;
+
+	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
+		ret = rt5640_dmic_enable(codec, 0, 0);
+		if (ret)
+			return ret;
+	}
+
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
+
+	return ret;
+}
+
 static const struct snd_soc_pcm_stream byt_rt5640_dai_params = {
 	.formats = SNDRV_PCM_FMTBIT_S24_LE,
 	.rate_min = 48000,
@@ -244,12 +290,13 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.ignore_suspend = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
+		.init = byt_rt5640_init,
 		.ops = &byt_rt5640_be_ssp2_ops,
 	},
 };
 
 /* SoC card */
-static struct snd_soc_card snd_soc_card_byt_rt5640 = {
+static struct snd_soc_card byt_rt5640_card = {
 	.name = "bytcr-rt5640",
 	.owner = THIS_MODULE,
 	.dai_link = byt_rt5640_dais,
@@ -258,8 +305,7 @@ static struct snd_soc_card snd_soc_card_byt_rt5640 = {
 	.num_dapm_widgets = ARRAY_SIZE(byt_rt5640_widgets),
 	.dapm_routes = byt_rt5640_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(byt_rt5640_audio_map),
-	.controls = byt_rt5640_controls,
-	.num_controls = ARRAY_SIZE(byt_rt5640_controls),
+	.fully_routed = true,
 };
 
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
@@ -267,16 +313,16 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	int ret_val = 0;
 
 	/* register the soc card */
-	snd_soc_card_byt_rt5640.dev = &pdev->dev;
+	byt_rt5640_card.dev = &pdev->dev;
+
+	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
 
-	ret_val = devm_snd_soc_register_card(&pdev->dev,
-					&snd_soc_card_byt_rt5640);
 	if (ret_val) {
 		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
 			ret_val);
 		return ret_val;
 	}
-	platform_set_drvdata(pdev, &snd_soc_card_byt_rt5640);
+	platform_set_drvdata(pdev, &byt_rt5640_card);
 	return ret_val;
 }
 
-- 
2.6.2
