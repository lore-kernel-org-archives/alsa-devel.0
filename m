From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/8] ASoC: wm8996: Convert to
	devm_regmap_init_i2c()
Date: Mon, 11 Jun 2012 19:55:37 +0800
Message-ID: <1339415740-2376-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 17B822436D
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 13:56:09 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index eec7166..49e0e8d 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2997,7 +2997,7 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 		msleep(5);
 	}
 
-	wm8996->regmap = regmap_init_i2c(i2c, &wm8996_regmap);
+	wm8996->regmap = devm_regmap_init_i2c(i2c, &wm8996_regmap);
 	if (IS_ERR(wm8996->regmap)) {
 		ret = PTR_ERR(wm8996->regmap);
 		dev_err(&i2c->dev, "regmap_init() failed: %d\n", ret);
@@ -3047,7 +3047,6 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 err_gpiolib:
 	wm8996_free_gpio(wm8996);
 err_regmap:
-	regmap_exit(wm8996->regmap);
 err_enable:
 	if (wm8996->pdata.ldo_ena > 0)
 		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
@@ -3066,7 +3065,6 @@ static __devexit int wm8996_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 	wm8996_free_gpio(wm8996);
-	regmap_exit(wm8996->regmap);
 	if (wm8996->pdata.ldo_ena > 0) {
 		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
 		gpio_free(wm8996->pdata.ldo_ena);
-- 
1.7.10
