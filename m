From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_card_prelinks() macro" to
	the asoc tree
Date: Thu, 20 Sep 2018 18:36:00 +0100 (BST)
Message-ID: <20180920173600.CA400440078@finisterre.ee.mobilebroadband>
References: <87worjppm1.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 740D02678CC
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:36:04 +0200 (CEST)
In-Reply-To: <87worjppm1.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add for_each_card_prelinks() macro

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

>From 7fe072b4df5d0cc832eb758c1eed243c145a2dfc Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Sep 2018 01:28:49 +0000
Subject: [PATCH] ASoC: add for_each_card_prelinks() macro

To be more readable code, this patch adds
new for_each_card_prelinks() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h                              |  4 ++++
 sound/soc/fsl/pcm030-audio-fabric.c              |  5 +++--
 sound/soc/generic/simple-card-utils.c            |  6 ++----
 sound/soc/intel/boards/skl_hda_dsp_generic.c     |  5 +++--
 sound/soc/mediatek/mt2701/mt2701-cs42448.c       | 13 +++++++------
 sound/soc/mediatek/mt2701/mt2701-wm8960.c        | 13 +++++++------
 sound/soc/mediatek/mt6797/mt6797-mt6351.c        | 13 +++++++------
 sound/soc/mediatek/mt8173/mt8173-max98090.c      | 13 +++++++------
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c |  7 ++++---
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c |  7 ++++---
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        |  7 ++++---
 sound/soc/meson/axg-card.c                       |  3 +--
 sound/soc/qcom/apq8096.c                         |  7 +++----
 sound/soc/qcom/sdm845.c                          |  7 +++----
 sound/soc/samsung/tm2_wm5110.c                   | 13 +++++++------
 sound/soc/soc-core.c                             | 16 +++++++---------
 16 files changed, 73 insertions(+), 66 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ec1ae9f4feeb..f94b989e7a1a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1120,6 +1120,10 @@ struct snd_soc_card {
 
 	void *drvdata;
 };
+#define for_each_card_prelinks(card, i, link)				\
+	for ((i) = 0;							\
+	     ((i) < (card)->num_links) && ((link) = &(card)->dai_link[i]); \
+	     (i)++)
 
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
 struct snd_soc_pcm_runtime {
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index ec731223cab3..e339f36cea95 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -57,6 +57,7 @@ static int pcm030_fabric_probe(struct platform_device *op)
 	struct device_node *platform_np;
 	struct snd_soc_card *card = &pcm030_card;
 	struct pcm030_audio_data *pdata;
+	struct snd_soc_dai_link *dai_link;
 	int ret;
 	int i;
 
@@ -78,8 +79,8 @@ static int pcm030_fabric_probe(struct platform_device *op)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < card->num_links; i++)
-		card->dai_link[i].platform_of_node = platform_np;
+	for_each_card_prelinks(card, i, dai_link)
+		dai_link->platform_of_node = platform_np;
 
 	ret = request_module("snd-soc-wm9712");
 	if (ret)
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index b400dbf1f834..f34cc6cddfa2 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -404,11 +404,9 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_canonicalize_cpu);
 int asoc_simple_card_clean_reference(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *dai_link;
-	int num_links;
+	int i;
 
-	for (num_links = 0, dai_link = card->dai_link;
-	     num_links < card->num_links;
-	     num_links++, dai_link++) {
+	for_each_card_prelinks(card, i, dai_link) {
 		of_node_put(dai_link->cpu_of_node);
 		of_node_put(dai_link->codecs->of_node);
 	}
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index b213e9b47505..b415dd4c85f5 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -104,6 +104,7 @@ static struct snd_soc_card hda_soc_card = {
 static int skl_hda_fill_card_info(struct skl_machine_pdata *pdata)
 {
 	struct snd_soc_card *card = &hda_soc_card;
+	struct snd_soc_dai_link *dai_link;
 	u32 codec_count, codec_mask;
 	int i, num_links, num_route;
 
@@ -125,8 +126,8 @@ static int skl_hda_fill_card_info(struct skl_machine_pdata *pdata)
 	card->num_links = num_links;
 	card->num_dapm_routes = num_route;
 
-	for (i = 0; i < num_links; i++)
-		skl_hda_be_dai_links[i].platform_name = pdata->platform;
+	for_each_card_prelinks(card, i, dai_link)
+		dai_link->platform_name = pdata->platform;
 
 	return 0;
 }
diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index 666282b865a8..875f84691535 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -299,6 +299,7 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 		devm_kzalloc(&pdev->dev, sizeof(struct mt2701_cs42448_private),
 			     GFP_KERNEL);
 	struct device *dev = &pdev->dev;
+	struct snd_soc_dai_link *dai_link;
 
 	if (!priv)
 		return -ENOMEM;
@@ -309,10 +310,10 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
 		return -EINVAL;
 	}
-	for (i = 0; i < card->num_links; i++) {
-		if (mt2701_cs42448_dai_links[i].platform_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_links->platform_name)
 			continue;
-		mt2701_cs42448_dai_links[i].platform_of_node = platform_node;
+		dai_links->platform_of_node = platform_node;
 	}
 
 	card->dev = dev;
@@ -324,10 +325,10 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
-	for (i = 0; i < card->num_links; i++) {
-		if (mt2701_cs42448_dai_links[i].codec_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_links->codec_name)
 			continue;
-		mt2701_cs42448_dai_links[i].codec_of_node = codec_node;
+		dai_links->codec_of_node = codec_node;
 	}
 
 	codec_node_bt_mrg = of_parse_phandle(pdev->dev.of_node,
diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index e5d49e6e2f99..c67f62935e53 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -97,6 +97,7 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt2701_wm8960_card;
 	struct device_node *platform_node, *codec_node;
+	struct snd_soc_dai_link *dai_link;
 	int ret, i;
 
 	platform_node = of_parse_phandle(pdev->dev.of_node,
@@ -105,10 +106,10 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
 		return -EINVAL;
 	}
-	for (i = 0; i < card->num_links; i++) {
-		if (mt2701_wm8960_dai_links[i].platform_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_links->platform_name)
 			continue;
-		mt2701_wm8960_dai_links[i].platform_of_node = platform_node;
+		dai_links->platform_of_node = platform_node;
 	}
 
 	card->dev = &pdev->dev;
@@ -120,10 +121,10 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
-	for (i = 0; i < card->num_links; i++) {
-		if (mt2701_wm8960_dai_links[i].codec_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_links->codec_name)
 			continue;
-		mt2701_wm8960_dai_links[i].codec_of_node = codec_node;
+		dai_links->codec_of_node = codec_node;
 	}
 
 	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index 6e578e830e42..ff2e0ca4384e 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -158,6 +158,7 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt6797_mt6351_card;
 	struct device_node *platform_node, *codec_node;
+	struct snd_soc_dai_link *dai_link;
 	int ret, i;
 
 	card->dev = &pdev->dev;
@@ -168,10 +169,10 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
 		return -EINVAL;
 	}
-	for (i = 0; i < card->num_links; i++) {
-		if (mt6797_mt6351_dai_links[i].platform_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->platform_name)
 			continue;
-		mt6797_mt6351_dai_links[i].platform_of_node = platform_node;
+		dai_links->platform_of_node = platform_node;
 	}
 
 	codec_node = of_parse_phandle(pdev->dev.of_node,
@@ -181,10 +182,10 @@ static int mt6797_mt6351_dev_probe(struct platform_device *pdev)
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
-	for (i = 0; i < card->num_links; i++) {
-		if (mt6797_mt6351_dai_links[i].codec_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_links->codec_name)
 			continue;
-		mt6797_mt6351_dai_links[i].codec_of_node = codec_node;
+		dai_links->codec_of_node = codec_node;
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index 902d111016d6..4d6596d5cb07 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -137,6 +137,7 @@ static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8173_max98090_card;
 	struct device_node *codec_node, *platform_node;
+	struct snd_soc_dai_link *dai_link;
 	int ret, i;
 
 	platform_node = of_parse_phandle(pdev->dev.of_node,
@@ -145,10 +146,10 @@ static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
 		return -EINVAL;
 	}
-	for (i = 0; i < card->num_links; i++) {
-		if (mt8173_max98090_dais[i].platform_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->platform_name)
 			continue;
-		mt8173_max98090_dais[i].platform_of_node = platform_node;
+		dai_link->platform_of_node = platform_node;
 	}
 
 	codec_node = of_parse_phandle(pdev->dev.of_node,
@@ -158,10 +159,10 @@ static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
-	for (i = 0; i < card->num_links; i++) {
-		if (mt8173_max98090_dais[i].codec_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->codec_name)
 			continue;
-		mt8173_max98090_dais[i].codec_of_node = codec_node;
+		dai_link->codec_of_node = codec_node;
 	}
 	card->dev = &pdev->dev;
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 5b4e90180827..da5b58ce791b 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -178,6 +178,7 @@ static int mt8173_rt5650_rt5514_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8173_rt5650_rt5514_card;
 	struct device_node *platform_node;
+	struct snd_soc_dai_link *dai_link;
 	int i, ret;
 
 	platform_node = of_parse_phandle(pdev->dev.of_node,
@@ -187,10 +188,10 @@ static int mt8173_rt5650_rt5514_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < card->num_links; i++) {
-		if (mt8173_rt5650_rt5514_dais[i].platform_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->platform_name)
 			continue;
-		mt8173_rt5650_rt5514_dais[i].platform_of_node = platform_node;
+		dai_link->platform_of_node = platform_node;
 	}
 
 	mt8173_rt5650_rt5514_codecs[0].of_node =
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 82675ed057de..d83cd039b413 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -224,6 +224,7 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8173_rt5650_rt5676_card;
 	struct device_node *platform_node;
+	struct snd_soc_dai_link *dai_link;
 	int i, ret;
 
 	platform_node = of_parse_phandle(pdev->dev.of_node,
@@ -233,10 +234,10 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < card->num_links; i++) {
-		if (mt8173_rt5650_rt5676_dais[i].platform_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->platform_name)
 			continue;
-		mt8173_rt5650_rt5676_dais[i].platform_of_node = platform_node;
+		dai_link->platform_of_node = platform_node;
 	}
 
 	mt8173_rt5650_rt5676_codecs[0].of_node =
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index ef05fbc40c32..7edf250c8fb1 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -239,6 +239,7 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 	struct device_node *platform_node;
 	struct device_node *np;
 	const char *codec_capture_dai;
+	struct snd_soc_dai_link *dai_link;
 	int i, ret;
 
 	platform_node = of_parse_phandle(pdev->dev.of_node,
@@ -248,10 +249,10 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < card->num_links; i++) {
-		if (mt8173_rt5650_dais[i].platform_name)
+	for_each_card_prelinks(card, i, dai_link) {
+		if (dai_link->platform_name)
 			continue;
-		mt8173_rt5650_dais[i].platform_of_node = platform_node;
+		dai_link->platform_of_node = platform_node;
 	}
 
 	mt8173_rt5650_codecs[0].of_node =
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 197e10a96e28..aa54d2c612c9 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -101,8 +101,7 @@ static void axg_card_clean_references(struct axg_card *priv)
 	int i, j;
 
 	if (card->dai_link) {
-		for (i = 0; i < card->num_links; i++) {
-			link = &card->dai_link[i];
+		for_each_card_prelinks(card, i, link) {
 			of_node_put(link->cpu_of_node);
 			for_each_link_codecs(link, j, codec)
 				of_node_put(codec->of_node);
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 1543e85629f8..fb45f396ab4a 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -25,13 +25,12 @@ static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 
 static void apq8096_add_be_ops(struct snd_soc_card *card)
 {
-	struct snd_soc_dai_link *link = card->dai_link;
-	int i, num_links = card->num_links;
+	struct snd_soc_dai_link *link;
+	int i;
 
-	for (i = 0; i < num_links; i++) {
+	for_each_card_prelinks(card, i, link) {
 		if (link->no_pcm == 1)
 			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
-		link++;
 	}
 }
 
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 2a781d87ee65..9effbecc571f 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -195,15 +195,14 @@ static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 
 static void sdm845_add_be_ops(struct snd_soc_card *card)
 {
-	struct snd_soc_dai_link *link = card->dai_link;
-	int i, num_links = card->num_links;
+	struct snd_soc_dai_link *link;
+	int i;
 
-	for (i = 0; i < num_links; i++) {
+	for_each_card_prelinks(card, i, link) {
 		if (link->no_pcm == 1) {
 			link->ops = &sdm845_be_ops;
 			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
 		}
-		link++;
 	}
 }
 
diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index 43332c32d7e9..dc93941e01c3 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -491,6 +491,7 @@ static int tm2_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &tm2_card;
 	struct tm2_machine_priv *priv;
 	struct of_phandle_args args;
+	struct snd_soc_dai_link *dai_link;
 	int num_codecs, ret, i;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -558,18 +559,18 @@ static int tm2_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize WM5110 - I2S and HDMI - I2S1 DAI links */
-	for (i = 0; i < card->num_links; i++) {
+	for_each_card_prelinks(card, i, dai_link) {
 		unsigned int dai_index = 0; /* WM5110 */
 
-		card->dai_link[i].cpu_name = NULL;
-		card->dai_link[i].platform_name = NULL;
+		dai_link->cpu_name = NULL;
+		dai_link->platform_name = NULL;
 
 		if (num_codecs > 1 && i == card->num_links - 1)
 			dai_index = 1; /* HDMI */
 
-		card->dai_link[i].codec_of_node = codec_dai_node[dai_index];
-		card->dai_link[i].cpu_of_node = cpu_dai_node[dai_index];
-		card->dai_link[i].platform_of_node = cpu_dai_node[dai_index];
+		dai_link->codec_of_node = codec_dai_node[dai_index];
+		dai_link->cpu_of_node = cpu_dai_node[dai_index];
+		dai_link->platform_of_node = cpu_dai_node[dai_index];
 	}
 
 	if (num_codecs > 1) {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index da2b2a758b6d..532d8c59ed1e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1889,9 +1889,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 			continue;
 
 		/* machine matches, so override the rtd data */
-		for (i = 0; i < card->num_links; i++) {
-
-			dai_link = &card->dai_link[i];
+		for_each_card_prelinks(card, i, dai_link) {
 
 			/* ignore this FE */
 			if (dai_link->dynamic) {
@@ -1955,8 +1953,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	soc_check_tplg_fes(card);
 
 	/* bind DAIs */
-	for (i = 0; i < card->num_links; i++) {
-		ret = soc_bind_dai_link(card, &card->dai_link[i]);
+	for_each_card_prelinks(card, i, dai_link) {
+		ret = soc_bind_dai_link(card, dai_link);
 		if (ret != 0)
 			goto base_error;
 	}
@@ -1969,8 +1967,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	/* add predefined DAI links to the list */
-	for (i = 0; i < card->num_links; i++)
-		snd_soc_add_dai_link(card, card->dai_link+i);
+	for_each_card_prelinks(card, i, dai_link)
+		snd_soc_add_dai_link(card, dai_link);
 
 	/* card bind complete so register a sound card */
 	ret = snd_card_new(card->dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
@@ -2714,12 +2712,12 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 int snd_soc_register_card(struct snd_soc_card *card)
 {
 	int i, ret;
+	struct snd_soc_dai_link *link;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai_link *link = &card->dai_link[i];
+	for_each_card_prelinks(card, i, link) {
 
 		ret = soc_init_dai_link(card, link);
 		if (ret) {
-- 
2.19.0
