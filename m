From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Vendor drivers get a link's runtime by
	snd_soc_get_pcm_runtime()" to the asoc tree
Date: Wed, 18 Nov 2015 18:32:36 +0000
Message-ID: <E1Zz7X2-0000zM-0l@debutante>
References: <fc2186435744be7a35a9cc69da2422217916c65b.1446521493.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30A572659C7
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:32:45 +0100 (CET)
In-Reply-To: <fc2186435744be7a35a9cc69da2422217916c65b.1446521493.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Vendor drivers get a link's runtime by snd_soc_get_pcm_runtime()

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

>From 5015920a1732cabd1178cfe342f09ee3488a1791 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Wed, 18 Nov 2015 02:34:01 -0500
Subject: [PATCH] ASoC: Vendor drivers get a link's runtime by
 snd_soc_get_pcm_runtime()

Vendor drivers no longer access a DAI link's runtime by the link index
but by matching the link name via snd_soc_get_pcm_runtime(). We assume
each DAI link has a unique name.

This is preparation for changing runtimes from an array to a list later.

Vendor drivers changed:
sound/soc/fsl/fsl-asoc-card.c
sound/soc/fsl/imx-wm8962.c
sound/soc/pxa/mioa701_wm9713.c
sound/soc/samsung/bells.c
sound/soc/samsung/littlemill.c
sound/soc/samsung/odroidx2_max98090.c
sound/soc/samsung/snow.c
sound/soc/samsung/speyside.c
sound/soc/samsung/tobermory.c
sound/soc/tegra/tegra_wm8903

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c         |  5 ++++-
 sound/soc/fsl/imx-wm8962.c            | 10 +++++++--
 sound/soc/pxa/mioa701_wm9713.c        |  6 +++++-
 sound/soc/samsung/bells.c             | 40 ++++++++++++++++++++++++++---------
 sound/soc/samsung/littlemill.c        | 32 ++++++++++++++++++++++------
 sound/soc/samsung/odroidx2_max98090.c |  9 ++++++--
 sound/soc/samsung/snow.c              |  9 ++++++--
 sound/soc/samsung/speyside.c          | 12 +++++++++--
 sound/soc/samsung/tobermory.c         | 21 ++++++++++++++----
 sound/soc/tegra/tegra_wm8903.c        |  3 ++-
 10 files changed, 116 insertions(+), 31 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 1b05d1c5d9fd..f4b6c53146d5 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -222,12 +222,15 @@ static int fsl_asoc_card_set_bias_level(struct snd_soc_card *card,
 					enum snd_soc_bias_level level)
 {
 	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	struct codec_priv *codec_priv = &priv->codec_priv;
 	struct device *dev = card->dev;
 	unsigned int pll_out;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index b38b98cae855..201a70d1027a 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -69,13 +69,16 @@ static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
 					struct snd_soc_dapm_context *dapm,
 					enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	struct imx_priv *priv = &card_priv;
 	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
 	struct device *dev = &priv->pdev->dev;
 	unsigned int pll_out;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -135,12 +138,15 @@ static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
 
 static int imx_wm8962_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	struct imx_priv *priv = &card_priv;
 	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
 	struct device *dev = &priv->pdev->dev;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
 			data->clk_frequency, SND_SOC_CLOCK_IN);
 	if (ret < 0)
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 29bc60e85e92..5c8f9db50a47 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -81,8 +81,12 @@ static int rear_amp_power(struct snd_soc_codec *codec, int power)
 static int rear_amp_event(struct snd_soc_dapm_widget *widget,
 			  struct snd_kcontrol *kctl, int event)
 {
-	struct snd_soc_codec *codec = widget->dapm->card->rtd[0].codec;
+	struct snd_soc_card *card = widget->dapm->card;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_codec *codec;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec = rtd->codec;
 	return rear_amp_power(codec, SND_SOC_DAPM_EVENT_ON(event));
 }
 
diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index e5f05e62fa3c..3dd246fa0059 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -58,11 +58,16 @@ static int bells_set_bias_level(struct snd_soc_card *card,
 				struct snd_soc_dapm_context *dapm,
 				enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[DAI_DSP_CODEC].codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_codec *codec;
 	struct bells_drvdata *bells = card->drvdata;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_DSP_CODEC].name);
+	codec_dai = rtd->codec_dai;
+	codec = codec_dai->codec;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -99,11 +104,16 @@ static int bells_set_bias_level_post(struct snd_soc_card *card,
 				     struct snd_soc_dapm_context *dapm,
 				     enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[DAI_DSP_CODEC].codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_codec *codec;
 	struct bells_drvdata *bells = card->drvdata;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_DSP_CODEC].name);
+	codec_dai = rtd->codec_dai;
+	codec = codec_dai->codec;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -137,14 +147,22 @@ static int bells_set_bias_level_post(struct snd_soc_card *card,
 static int bells_late_probe(struct snd_soc_card *card)
 {
 	struct bells_drvdata *bells = card->drvdata;
-	struct snd_soc_codec *wm0010 = card->rtd[DAI_AP_DSP].codec;
-	struct snd_soc_codec *codec = card->rtd[DAI_DSP_CODEC].codec;
-	struct snd_soc_dai *aif1_dai = card->rtd[DAI_DSP_CODEC].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_codec *wm0010;
+	struct snd_soc_codec *codec;
+	struct snd_soc_dai *aif1_dai;
 	struct snd_soc_dai *aif2_dai;
 	struct snd_soc_dai *aif3_dai;
 	struct snd_soc_dai *wm9081_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_AP_DSP].name);
+	wm0010 = rtd->codec;
+
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_DSP_CODEC].name);
+	codec = rtd->codec;
+	aif1_dai = rtd->codec_dai;
+
 	ret = snd_soc_codec_set_sysclk(codec, ARIZONA_CLK_SYSCLK,
 				       ARIZONA_CLK_SRC_FLL1,
 				       bells->sysclk_rate,
@@ -181,7 +199,8 @@ static int bells_late_probe(struct snd_soc_card *card)
 		return ret;
 	}
 
-	aif2_dai = card->rtd[DAI_CODEC_CP].cpu_dai;
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_CODEC_CP].name);
+	aif2_dai = rtd->cpu_dai;
 
 	ret = snd_soc_dai_set_sysclk(aif2_dai, ARIZONA_CLK_ASYNCCLK, 0, 0);
 	if (ret != 0) {
@@ -192,8 +211,9 @@ static int bells_late_probe(struct snd_soc_card *card)
 	if (card->num_rtd == DAI_CODEC_SUB)
 		return 0;
 
-	aif3_dai = card->rtd[DAI_CODEC_SUB].cpu_dai;
-	wm9081_dai = card->rtd[DAI_CODEC_SUB].codec_dai;
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_CODEC_SUB].name);
+	aif3_dai = rtd->cpu_dai;
+	wm9081_dai = rtd->codec_dai;
 
 	ret = snd_soc_dai_set_sysclk(aif3_dai, ARIZONA_CLK_SYSCLK, 0, 0);
 	if (ret != 0) {
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index 31a820eb0ac3..7cb204e649ca 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -23,9 +23,13 @@ static int littlemill_set_bias_level(struct snd_soc_card *card,
 					  struct snd_soc_dapm_context *dapm,
 					  enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *aif1_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *aif1_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	aif1_dai = rtd->codec_dai;
+
 	if (dapm->dev != aif1_dai->dev)
 		return 0;
 
@@ -66,9 +70,13 @@ static int littlemill_set_bias_level_post(struct snd_soc_card *card,
 					       struct snd_soc_dapm_context *dapm,
 					       enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *aif1_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *aif1_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	aif1_dai = rtd->codec_dai;
+
 	if (dapm->dev != aif1_dai->dev)
 		return 0;
 
@@ -168,9 +176,13 @@ static int bbclk_ev(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_card *card = w->dapm->card;
-	struct snd_soc_dai *aif2_dai = card->rtd[1].cpu_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *aif2_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
+	aif2_dai = rtd->cpu_dai;
+
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		ret = snd_soc_dai_set_pll(aif2_dai, WM8994_FLL2,
@@ -245,11 +257,19 @@ static struct snd_soc_jack littlemill_headset;
 
 static int littlemill_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_codec *codec = card->rtd[0].codec;
-	struct snd_soc_dai *aif1_dai = card->rtd[0].codec_dai;
-	struct snd_soc_dai *aif2_dai = card->rtd[1].cpu_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_codec *codec;
+	struct snd_soc_dai *aif1_dai;
+	struct snd_soc_dai *aif2_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec = rtd->codec;
+	aif1_dai = rtd->codec_dai;
+
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
+	aif2_dai = rtd->cpu_dai;
+
 	ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_MCLK2,
 				     32768, SND_SOC_CLOCK_IN);
 	if (ret < 0)
diff --git a/sound/soc/samsung/odroidx2_max98090.c b/sound/soc/samsung/odroidx2_max98090.c
index 596f1180a369..04217279fe25 100644
--- a/sound/soc/samsung/odroidx2_max98090.c
+++ b/sound/soc/samsung/odroidx2_max98090.c
@@ -25,10 +25,15 @@ static struct snd_soc_dai_link odroidx2_dai[];
 
 static int odroidx2_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
-	struct snd_soc_dai *cpu_dai = card->rtd[0].cpu_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
+	cpu_dai = rtd->cpu_dai;
+
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, MAX98090_MCLK,
 						SND_SOC_CLOCK_IN);
 
diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index 07ce2cfa4845..d8ac907bbb0d 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -35,10 +35,15 @@ static struct snd_soc_dai_link snow_dai[] = {
 
 static int snow_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
-	struct snd_soc_dai *cpu_dai = card->rtd[0].cpu_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
+	cpu_dai = rtd->cpu_dai;
+
 	/* Set the MCLK rate for the codec */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
 					FIN_PLL_RATE, SND_SOC_CLOCK_IN);
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index d1ae21c5e253..083ef5e21b17 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -25,9 +25,13 @@ static int speyside_set_bias_level(struct snd_soc_card *card,
 				   struct snd_soc_dapm_context *dapm,
 				   enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[1].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
+	codec_dai = rtd->codec_dai;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -57,9 +61,13 @@ static int speyside_set_bias_level_post(struct snd_soc_card *card,
 					struct snd_soc_dapm_context *dapm,
 					enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[1].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
+	codec_dai = rtd->codec_dai;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index 85ccfb7188cb..3310eda7cf53 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -23,9 +23,13 @@ static int tobermory_set_bias_level(struct snd_soc_card *card,
 					  struct snd_soc_dapm_context *dapm,
 					  enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -62,9 +66,13 @@ static int tobermory_set_bias_level_post(struct snd_soc_card *card,
 					       struct snd_soc_dapm_context *dapm,
 					       enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -170,10 +178,15 @@ static struct snd_soc_jack_pin tobermory_headset_pins[] = {
 
 static int tobermory_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_codec *codec = card->rtd[0].codec;
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_codec *codec;
+	struct snd_soc_dai *codec_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec = rtd->codec;
+	codec_dai = rtd->codec_dai;
+
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
 				     32768, SND_SOC_CLOCK_IN);
 	if (ret < 0)
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index 21604009bc1a..e485278e027a 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -199,7 +199,8 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 
 static int tegra_wm8903_remove(struct snd_soc_card *card)
 {
-	struct snd_soc_pcm_runtime *rtd = &(card->rtd[0]);
+	struct snd_soc_pcm_runtime *rtd =
+		snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
-- 
2.6.2
