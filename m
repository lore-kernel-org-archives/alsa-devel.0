From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm1250-ev1: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:46:21 +0000
Message-ID: <E1elDUz-0005US-5v@debutante>
References: <87k1w12wcz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5545C267DA7
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:46:23 +0100 (CET)
In-Reply-To: <87k1w12wcz.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm1250-ev1: replace codec to component

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

>From 39506cf83bb1b4df80dee1492f8cebc26cec355e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:12:02 +0000
Subject: [PATCH] ASoC: wm1250-ev1: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 1	->	.idle_bias_on = 0
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm1250-ev1.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index cf5f0580df6a..9727eec6d01b 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -32,10 +32,10 @@ struct wm1250_priv {
 	struct gpio gpios[WM1250_EV1_NUM_GPIOS];
 };
 
-static int wm1250_ev1_set_bias_level(struct snd_soc_codec *codec,
+static int wm1250_ev1_set_bias_level(struct snd_soc_component *component,
 				     enum snd_soc_bias_level level)
 {
-	struct wm1250_priv *wm1250 = dev_get_drvdata(codec->dev);
+	struct wm1250_priv *wm1250 = dev_get_drvdata(component->dev);
 	int ena;
 
 	if (wm1250)
@@ -81,7 +81,7 @@ static int wm1250_ev1_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct wm1250_priv *wm1250 = snd_soc_codec_get_drvdata(dai->codec);
+	struct wm1250_priv *wm1250 = snd_soc_component_get_drvdata(dai->component);
 
 	switch (params_rate(params)) {
 	case 8000:
@@ -141,15 +141,15 @@ static struct snd_soc_dai_driver wm1250_ev1_dai = {
 	.ops = &wm1250_ev1_ops,
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm1250_ev1 = {
-	.component_driver = {
-		.dapm_widgets		= wm1250_ev1_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm1250_ev1_dapm_widgets),
-		.dapm_routes		= wm1250_ev1_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm1250_ev1_dapm_routes),
-	},
-	.set_bias_level = wm1250_ev1_set_bias_level,
-	.idle_bias_off = true,
+static const struct snd_soc_component_driver soc_component_dev_wm1250_ev1 = {
+	.dapm_widgets		= wm1250_ev1_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm1250_ev1_dapm_widgets),
+	.dapm_routes		= wm1250_ev1_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm1250_ev1_dapm_routes),
+	.set_bias_level		= wm1250_ev1_set_bias_level,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int wm1250_ev1_pdata(struct i2c_client *i2c)
@@ -224,7 +224,7 @@ static int wm1250_ev1_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		return ret;
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm1250_ev1,
+	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_dev_wm1250_ev1,
 				     &wm1250_ev1_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
@@ -237,7 +237,6 @@ static int wm1250_ev1_probe(struct i2c_client *i2c,
 
 static int wm1250_ev1_remove(struct i2c_client *i2c)
 {
-	snd_soc_unregister_codec(&i2c->dev);
 	wm1250_ev1_free(i2c);
 
 	return 0;
-- 
2.16.1
