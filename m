From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use rtd->codec on samsung/bells"
	to the asoc tree
Date: Tue,  5 Dec 2017 12:45:59 +0000 (GMT)
Message-ID: <20171205124559.621DE44006B@finisterre.ee.mobilebroadband>
References: <87y3mhu7xm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F11B266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 13:46:02 +0100 (CET)
In-Reply-To: <87y3mhu7xm.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: don't use rtd->codec on samsung/bells

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

>From f4a2be1c559e53e31545bdea2c246dbce6b70e1c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 5 Dec 2017 04:24:28 +0000
Subject: [PATCH] ASoC: don't use rtd->codec on samsung/bells

rtd->codec will be removed soon.
rtd->codec = rtd->codec_dai->codec, thus,
we can use rtd->codec_dai->component instead of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/bells.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 34deba461ae1..0e66cd8ef2f9 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -60,13 +60,13 @@ static int bells_set_bias_level(struct snd_soc_card *card,
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai *codec_dai;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct bells_drvdata *bells = card->drvdata;
 	int ret;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_DSP_CODEC].name);
 	codec_dai = rtd->codec_dai;
-	codec = codec_dai->codec;
+	component = codec_dai->component;
 
 	if (dapm->dev != codec_dai->dev)
 		return 0;
@@ -76,7 +76,7 @@ static int bells_set_bias_level(struct snd_soc_card *card,
 		if (dapm->bias_level != SND_SOC_BIAS_STANDBY)
 			break;
 
-		ret = snd_soc_codec_set_pll(codec, WM5102_FLL1,
+		ret = snd_soc_component_set_pll(component, WM5102_FLL1,
 					    ARIZONA_FLL_SRC_MCLK1,
 					    MCLK_RATE,
 					    bells->sysclk_rate);
@@ -84,7 +84,7 @@ static int bells_set_bias_level(struct snd_soc_card *card,
 			pr_err("Failed to start FLL: %d\n", ret);
 
 		if (bells->asyncclk_rate) {
-			ret = snd_soc_codec_set_pll(codec, WM5102_FLL2,
+			ret = snd_soc_component_set_pll(component, WM5102_FLL2,
 						    ARIZONA_FLL_SRC_AIF2BCLK,
 						    BCLK2_RATE,
 						    bells->asyncclk_rate);
@@ -106,27 +106,27 @@ static int bells_set_bias_level_post(struct snd_soc_card *card,
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai *codec_dai;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct bells_drvdata *bells = card->drvdata;
 	int ret;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_DSP_CODEC].name);
 	codec_dai = rtd->codec_dai;
-	codec = codec_dai->codec;
+	component = codec_dai->component;
 
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
 	switch (level) {
 	case SND_SOC_BIAS_STANDBY:
-		ret = snd_soc_codec_set_pll(codec, WM5102_FLL1, 0, 0, 0);
+		ret = snd_soc_component_set_pll(component, WM5102_FLL1, 0, 0, 0);
 		if (ret < 0) {
 			pr_err("Failed to stop FLL: %d\n", ret);
 			return ret;
 		}
 
 		if (bells->asyncclk_rate) {
-			ret = snd_soc_codec_set_pll(codec, WM5102_FLL2,
+			ret = snd_soc_component_set_pll(component, WM5102_FLL2,
 						    0, 0, 0);
 			if (ret < 0) {
 				pr_err("Failed to stop FLL: %d\n", ret);
@@ -148,8 +148,8 @@ static int bells_late_probe(struct snd_soc_card *card)
 {
 	struct bells_drvdata *bells = card->drvdata;
 	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_codec *wm0010;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *wm0010;
+	struct snd_soc_component *component;
 	struct snd_soc_dai *aif1_dai;
 	struct snd_soc_dai *aif2_dai;
 	struct snd_soc_dai *aif3_dai;
@@ -157,22 +157,22 @@ static int bells_late_probe(struct snd_soc_card *card)
 	int ret;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_AP_DSP].name);
-	wm0010 = rtd->codec;
+	wm0010 = rtd->codec_dai->component;
 
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_DSP_CODEC].name);
-	codec = rtd->codec;
+	component = rtd->codec_dai->component;
 	aif1_dai = rtd->codec_dai;
 
-	ret = snd_soc_codec_set_sysclk(codec, ARIZONA_CLK_SYSCLK,
+	ret = snd_soc_component_set_sysclk(component, ARIZONA_CLK_SYSCLK,
 				       ARIZONA_CLK_SRC_FLL1,
 				       bells->sysclk_rate,
 				       SND_SOC_CLOCK_IN);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to set SYSCLK: %d\n", ret);
+		dev_err(component->dev, "Failed to set SYSCLK: %d\n", ret);
 		return ret;
 	}
 
-	ret = snd_soc_codec_set_sysclk(wm0010, 0, 0, SYS_MCLK_RATE, 0);
+	ret = snd_soc_component_set_sysclk(wm0010, 0, 0, SYS_MCLK_RATE, 0);
 	if (ret != 0) {
 		dev_err(wm0010->dev, "Failed to set WM0010 clock: %d\n", ret);
 		return ret;
@@ -182,20 +182,20 @@ static int bells_late_probe(struct snd_soc_card *card)
 	if (ret != 0)
 		dev_err(aif1_dai->dev, "Failed to set AIF1 clock: %d\n", ret);
 
-	ret = snd_soc_codec_set_sysclk(codec, ARIZONA_CLK_OPCLK, 0,
+	ret = snd_soc_component_set_sysclk(component, ARIZONA_CLK_OPCLK, 0,
 				       SYS_MCLK_RATE, SND_SOC_CLOCK_OUT);
 	if (ret != 0)
-		dev_err(codec->dev, "Failed to set OPCLK: %d\n", ret);
+		dev_err(component->dev, "Failed to set OPCLK: %d\n", ret);
 
 	if (card->num_rtd == DAI_CODEC_CP)
 		return 0;
 
-	ret = snd_soc_codec_set_sysclk(codec, ARIZONA_CLK_ASYNCCLK,
+	ret = snd_soc_component_set_sysclk(component, ARIZONA_CLK_ASYNCCLK,
 				       ARIZONA_CLK_SRC_FLL2,
 				       bells->asyncclk_rate,
 				       SND_SOC_CLOCK_IN);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to set ASYNCCLK: %d\n", ret);
+		dev_err(component->dev, "Failed to set ASYNCCLK: %d\n", ret);
 		return ret;
 	}
 
@@ -221,7 +221,7 @@ static int bells_late_probe(struct snd_soc_card *card)
 		return ret;
 	}
 
-	ret = snd_soc_codec_set_sysclk(wm9081_dai->codec, WM9081_SYSCLK_MCLK,
+	ret = snd_soc_component_set_sysclk(wm9081_dai->component, WM9081_SYSCLK_MCLK,
 				       0, SYS_MCLK_RATE, 0);
 	if (ret != 0) {
 		dev_err(wm9081_dai->dev, "Failed to set MCLK: %d\n", ret);
-- 
2.15.0
