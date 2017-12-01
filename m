From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: General source
	formatting cleanup" to the asoc tree
Date: Fri, 01 Dec 2017 13:43:54 +0000
Message-ID: <E1eKlbe-0001FG-2D@debutante>
References: <20171129213300.20021-5-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3549B267C6B
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 14:43:59 +0100 (CET)
In-Reply-To: <20171129213300.20021-5-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: General source formatting cleanup

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

>From ca7840fb47208a3521f3b60c1b78a2f0c59b4dc5 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 15:32:45 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: General source formatting cleanup

Simple non-functional changes including:

 * Fix spelling errors
 * Reformat code for easier reading
 * Remove unneeded code
 * Remove assignments that are always overridden
 * Normalize function return paths

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 63 ++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d974e8651e30..07c014501e5e 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -136,8 +136,7 @@ static const struct regmap_config aic31xx_i2c_regmap = {
 	.max_register = 12 * 128,
 };
 
-#define AIC31XX_NUM_SUPPLIES	6
-static const char * const aic31xx_supply_names[AIC31XX_NUM_SUPPLIES] = {
+static const char * const aic31xx_supply_names[] = {
 	"HPVDD",
 	"SPRVDD",
 	"SPLVDD",
@@ -146,6 +145,8 @@ static const char * const aic31xx_supply_names[AIC31XX_NUM_SUPPLIES] = {
 	"DVDD",
 };
 
+#define AIC31XX_NUM_SUPPLIES ARRAY_SIZE(aic31xx_supply_names)
+
 struct aic31xx_disable_nb {
 	struct notifier_block nb;
 	struct aic31xx_priv *aic31xx;
@@ -177,7 +178,7 @@ struct aic31xx_rate_divs {
 	u8 madc;
 };
 
-/* ADC dividers can be disabled by cofiguring them to 0 */
+/* ADC dividers can be disabled by configuring them to 0 */
 static const struct aic31xx_rate_divs aic31xx_divs[] = {
 	/* mclk/p    rate  pll: j     d        dosr ndac mdac  aors nadc madc */
 	/* 8k rate */
@@ -832,11 +833,17 @@ static int aic31xx_setup_pll(struct snd_soc_codec *codec,
 
 	dev_dbg(codec->dev,
 		"pll %d.%04d/%d dosr %d n %d m %d aosr %d n %d m %d bclk_n %d\n",
-		aic31xx_divs[i].pll_j, aic31xx_divs[i].pll_d,
-		aic31xx->p_div, aic31xx_divs[i].dosr,
-		aic31xx_divs[i].ndac, aic31xx_divs[i].mdac,
-		aic31xx_divs[i].aosr, aic31xx_divs[i].nadc,
-		aic31xx_divs[i].madc, bclk_n);
+		aic31xx_divs[i].pll_j,
+		aic31xx_divs[i].pll_d,
+		aic31xx->p_div,
+		aic31xx_divs[i].dosr,
+		aic31xx_divs[i].ndac,
+		aic31xx_divs[i].mdac,
+		aic31xx_divs[i].aosr,
+		aic31xx_divs[i].nadc,
+		aic31xx_divs[i].madc,
+		bclk_n
+	);
 
 	return 0;
 }
@@ -973,8 +980,9 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	dev_dbg(codec->dev, "## %s: clk_id = %d, freq = %d, dir = %d\n",
 		__func__, clk_id, freq, dir);
 
-	for (i = 1; freq/i > 20000000 && i < 8; i++)
-		;
+	for (i = 1; i < 8; i++)
+		if (freq / i <= 20000000)
+			break;
 	if (freq/i > 20000000) {
 		dev_err(aic31xx->dev, "%s: Too high mclk frequency %u\n",
 			__func__, freq);
@@ -982,9 +990,9 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	}
 	aic31xx->p_div = i;
 
-	for (i = 0; i < ARRAY_SIZE(aic31xx_divs) &&
-		     aic31xx_divs[i].mclk_p != freq/aic31xx->p_div; i++)
-		;
+	for (i = 0; i < ARRAY_SIZE(aic31xx_divs); i++)
+		if (aic31xx_divs[i].mclk_p == freq / aic31xx->p_div)
+			break;
 	if (i == ARRAY_SIZE(aic31xx_divs)) {
 		dev_err(aic31xx->dev, "%s: Unsupported frequency %d\n",
 			__func__, freq);
@@ -996,6 +1004,7 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 			    clk_id << AIC31XX_PLL_CLKIN_SHIFT);
 
 	aic31xx->sysclk = freq;
+
 	return 0;
 }
 
@@ -1057,7 +1066,7 @@ static void aic31xx_clk_off(struct snd_soc_codec *codec)
 static int aic31xx_power_on(struct snd_soc_codec *codec)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
-	int ret = 0;
+	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(aic31xx->supplies),
 				    aic31xx->supplies);
@@ -1070,7 +1079,7 @@ static int aic31xx_power_on(struct snd_soc_codec *codec)
 	}
 	regcache_cache_only(aic31xx->regmap, false);
 	ret = regcache_sync(aic31xx->regmap);
-	if (ret != 0) {
+	if (ret) {
 		dev_err(codec->dev,
 			"Failed to restore cache: %d\n", ret);
 		regcache_cache_only(aic31xx->regmap, true);
@@ -1078,6 +1087,7 @@ static int aic31xx_power_on(struct snd_soc_codec *codec)
 				       aic31xx->supplies);
 		return ret;
 	}
+
 	return 0;
 }
 
@@ -1126,14 +1136,11 @@ static int aic31xx_set_bias_level(struct snd_soc_codec *codec,
 
 static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 {
-	int ret = 0;
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
-	int i;
+	int i, ret;
 
 	dev_dbg(aic31xx->dev, "## %s\n", __func__);
 
-	aic31xx = snd_soc_codec_get_drvdata(codec);
-
 	aic31xx->codec = codec;
 
 	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++) {
@@ -1158,8 +1165,10 @@ static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	ret = aic31xx_add_widgets(codec);
+	if (ret)
+		return ret;
 
-	return ret;
+	return 0;
 }
 
 static int aic31xx_codec_remove(struct snd_soc_codec *codec)
@@ -1322,10 +1331,12 @@ static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
 	ret = devm_regulator_bulk_get(aic31xx->dev,
 				      ARRAY_SIZE(aic31xx->supplies),
 				      aic31xx->supplies);
-	if (ret != 0)
+	if (ret) {
 		dev_err(aic31xx->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int aic31xx_i2c_probe(struct i2c_client *i2c,
@@ -1333,18 +1344,15 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 {
 	struct aic31xx_priv *aic31xx;
 	int ret;
-	const struct regmap_config *regmap_config;
 
 	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
 		id->name, (int) id->driver_data);
 
-	regmap_config = &aic31xx_i2c_regmap;
-
 	aic31xx = devm_kzalloc(&i2c->dev, sizeof(*aic31xx), GFP_KERNEL);
-	if (aic31xx == NULL)
+	if (!aic31xx)
 		return -ENOMEM;
 
-	aic31xx->regmap = devm_regmap_init_i2c(i2c, regmap_config);
+	aic31xx->regmap = devm_regmap_init_i2c(i2c, &aic31xx_i2c_regmap);
 	if (IS_ERR(aic31xx->regmap)) {
 		ret = PTR_ERR(aic31xx->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
@@ -1400,7 +1408,6 @@ static struct i2c_driver aic31xx_i2c_driver = {
 	.remove		= aic31xx_i2c_remove,
 	.id_table	= aic31xx_i2c_id,
 };
-
 module_i2c_driver(aic31xx_i2c_driver);
 
 MODULE_AUTHOR("Jyri Sarha <jsarha@ti.com>");
-- 
2.15.0
