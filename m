From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: [PATCH 2/3] ASoC: TSCS42xx: Cleanup private data
	members
Date: Fri, 23 Mar 2018 18:32:11 -0500
Message-ID: <20180323233136.GA20651@t7-ThinkPad-E560>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 06F6E266B67
 for <alsa-devel@alsa-project.org>; Sat, 24 Mar 2018 00:32:23 +0100 (CET)
Received: by mail-oi0-f65.google.com with SMTP id u141-v6so11714142oif.1
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 16:32:23 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

In the TSCS42xx driver there are some unnecesarry private data members

Remove blrcm from private data
Remove dev from private data

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
---
 sound/soc/codecs/tscs42xx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 37636d6efe60..d41852a37ac6 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -31,7 +31,6 @@ struct tscs42xx {
 
 	int bclk_ratio;
 	int samplerate;
-	unsigned int blrcm;
 	struct mutex audio_params_lock;
 
 	u8 coeff_ram[COEFF_RAM_SIZE];
@@ -41,8 +40,6 @@ struct tscs42xx {
 	struct mutex pll_lock;
 
 	struct regmap *regmap;
-
-	struct device *dev;
 };
 
 struct coeff_ram_ctl {
@@ -1404,12 +1401,11 @@ static int tscs42xx_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 	i2c_set_clientdata(i2c, tscs42xx);
-	tscs42xx->dev = &i2c->dev;
 
 	tscs42xx->regmap = devm_regmap_init_i2c(i2c, &tscs42xx_regmap);
 	if (IS_ERR(tscs42xx->regmap)) {
 		ret = PTR_ERR(tscs42xx->regmap);
-		dev_err(tscs42xx->dev, "Failed to allocate regmap (%d)\n", ret);
+		dev_err(&i2c->dev, "Failed to allocate regmap (%d)\n", ret);
 		return ret;
 	}
 
@@ -1417,21 +1413,21 @@ static int tscs42xx_i2c_probe(struct i2c_client *i2c,
 
 	ret = part_is_valid(tscs42xx);
 	if (ret <= 0) {
-		dev_err(tscs42xx->dev, "No valid part (%d)\n", ret);
+		dev_err(&i2c->dev, "No valid part (%d)\n", ret);
 		ret = -ENODEV;
 		return ret;
 	}
 
 	ret = regmap_write(tscs42xx->regmap, R_RESET, RV_RESET_ENABLE);
 	if (ret < 0) {
-		dev_err(tscs42xx->dev, "Failed to reset device (%d)\n", ret);
+		dev_err(&i2c->dev, "Failed to reset device (%d)\n", ret);
 		return ret;
 	}
 
 	ret = regmap_register_patch(tscs42xx->regmap, tscs42xx_patch,
 			ARRAY_SIZE(tscs42xx_patch));
 	if (ret < 0) {
-		dev_err(tscs42xx->dev, "Failed to apply patch (%d)\n", ret);
+		dev_err(&i2c->dev, "Failed to apply patch (%d)\n", ret);
 		return ret;
 	}
 
@@ -1439,10 +1435,10 @@ static int tscs42xx_i2c_probe(struct i2c_client *i2c,
 	mutex_init(&tscs42xx->coeff_ram_lock);
 	mutex_init(&tscs42xx->pll_lock);
 
-	ret = devm_snd_soc_register_component(tscs42xx->dev,
+	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_codec_dev_tscs42xx, &tscs42xx_dai, 1);
 	if (ret) {
-		dev_err(tscs42xx->dev, "Failed to register codec (%d)\n", ret);
+		dev_err(&i2c->dev, "Failed to register codec (%d)\n", ret);
 		return ret;
 	}
 
-- 
2.15.1
