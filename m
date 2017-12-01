From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Switch GPIO handling to
	use gpiod_* API" to the asoc tree
Date: Fri, 01 Dec 2017 13:43:39 +0000
Message-ID: <E1eKlbP-0001CL-Sb@debutante>
References: <20171109002741.10897-6-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D4183267C5F
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 14:43:44 +0100 (CET)
In-Reply-To: <20171109002741.10897-6-afd@ti.com>
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

   ASoC: tlv320aic31xx: Switch GPIO handling to use gpiod_* API

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

>From b6b247cd5e37560e410c88b108e7408dafe60c15 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 29 Nov 2017 15:32:49 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: Switch GPIO handling to use gpiod_* API

Move to using newer gpiod_* GPIO handling functions. This simplifies
the code and eases dropping platform data in the next patch. Also
remember GPIO are active low, so set "1" to reset.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index c84febd991a0..ab03a19f6aaa 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -157,6 +157,7 @@ struct aic31xx_priv {
 	u8 i2c_regs_status;
 	struct device *dev;
 	struct regmap *regmap;
+	struct gpio_desc *gpio_reset;
 	struct aic31xx_pdata pdata;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
 	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
@@ -1020,8 +1021,8 @@ static int aic31xx_regulator_event(struct notifier_block *nb,
 		 * Put codec to reset and as at least one of the
 		 * supplies was disabled.
 		 */
-		if (gpio_is_valid(aic31xx->pdata.gpio_reset))
-			gpio_set_value(aic31xx->pdata.gpio_reset, 0);
+		if (aic31xx->gpio_reset)
+			gpiod_set_value(aic31xx->gpio_reset, 1);
 
 		regcache_mark_dirty(aic31xx->regmap);
 		dev_dbg(aic31xx->dev, "## %s: DISABLE received\n", __func__);
@@ -1073,8 +1074,8 @@ static int aic31xx_power_on(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
-	if (gpio_is_valid(aic31xx->pdata.gpio_reset)) {
-		gpio_set_value(aic31xx->pdata.gpio_reset, 1);
+	if (aic31xx->gpio_reset) {
+		gpiod_set_value(aic31xx->gpio_reset, 0);
 		udelay(100);
 	}
 	regcache_cache_only(aic31xx->regmap, false);
@@ -1334,15 +1335,11 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 	else if (aic31xx->dev->of_node)
 		aic31xx_pdata_from_of(aic31xx);
 
-	if (aic31xx->pdata.gpio_reset) {
-		ret = devm_gpio_request_one(aic31xx->dev,
-					    aic31xx->pdata.gpio_reset,
-					    GPIOF_OUT_INIT_HIGH,
-					    "aic31xx-reset-pin");
-		if (ret < 0) {
-			dev_err(aic31xx->dev, "not able to acquire gpio\n");
-			return ret;
-		}
+	aic31xx->gpio_reset = devm_gpiod_get_optional(aic31xx->dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(aic31xx->gpio_reset)) {
+		dev_err(aic31xx->dev, "not able to acquire gpio\n");
+		return PTR_ERR(aic31xx->gpio_reset);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++)
-- 
2.15.0
