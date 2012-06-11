From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/8] ASoC: wm8996: Inline wm8996_reset() and
	optimise cache-only usage
Date: Mon, 11 Jun 2012 19:55:39 +0800
Message-ID: <1339415740-2376-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C8C6104264
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 13:56:29 +0200 (CEST)
In-Reply-To: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There is only one caller and this allows us to cleanly leave the CODEC
with the internal LDO powered down which is the default state we're
looking for and means that we can robustly disable the register cache
only when we either disable the LDO or power down the external
regulators.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index e0cf5b0..1579880 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1528,18 +1528,6 @@ static bool wm8996_volatile_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8996_reset(struct wm8996_priv *wm8996)
-{
-	if (wm8996->pdata.ldo_ena > 0) {
-		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
-		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 1);
-		return 0;
-	} else {
-		return regmap_write(wm8996->regmap, WM8996_SOFTWARE_RESET,
-				    0x8915);
-	}
-}
-
 static const int bclk_divs[] = {
 	1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96
 };
@@ -1631,8 +1619,10 @@ static int wm8996_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_OFF:
 		regcache_cache_only(codec->control_data, true);
-		if (wm8996->pdata.ldo_ena >= 0)
+		if (wm8996->pdata.ldo_ena >= 0) {
 			gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
+			regcache_cache_only(codec->control_data, true);
+		}
 		regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies),
 				       wm8996->supplies);
 		break;
@@ -3019,13 +3009,18 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 	dev_info(&i2c->dev, "revision %c\n",
 		 (reg & WM8996_CHIP_REV_MASK) + 'A');
 
-	ret = wm8996_reset(wm8996);
-	if (ret < 0) {
-		dev_err(&i2c->dev, "Failed to issue reset\n");
-		goto err_regmap;
+	if (wm8996->pdata.ldo_ena > 0) {
+		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
+		regcache_cache_only(wm8996->regmap, true);
+	} else {
+		ret = regmap_write(wm8996->regmap, WM8996_SOFTWARE_RESET,
+				   0x8915);
+		if (ret != 0) {
+			dev_err(&i2c->dev, "Failed to issue reset: %d\n", ret);
+			goto err_regmap;
+		}
 	}
 
-	regcache_cache_only(wm8996->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8996->supplies), wm8996->supplies);
 
 	wm8996_init_gpio(wm8996);
-- 
1.7.10
