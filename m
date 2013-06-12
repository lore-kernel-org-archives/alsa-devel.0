From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 2/2] ASoC: rt5640: enable LDO1 before creating
	regmap
Date: Wed, 12 Jun 2013 15:34:24 -0600
Message-ID: <1371072864-13205-2-git-send-email-swarren@wwwdotorg.org>
References: <1371072864-13205-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 528D8261B2E
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 23:34:32 +0200 (CEST)
In-Reply-To: <1371072864-13205-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Enable the LDO1_EN GPIO to the CODEC, which enables the device to show
up on the I2C bus, before creating the regmap object. This guarantees
that if devm_regmap_init_i2c() were to attempt to communicate with the
device, it would be able to.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/rt5640.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index ce585e3..ead953c 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2053,14 +2053,6 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	} else
 		rt5640->pdata.ldo1_en = -EINVAL;
 
-	rt5640->regmap = devm_regmap_init_i2c(i2c, &rt5640_regmap);
-	if (IS_ERR(rt5640->regmap)) {
-		ret = PTR_ERR(rt5640->regmap);
-		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
-			ret);
-		return ret;
-	}
-
 	if (gpio_is_valid(rt5640->pdata.ldo1_en)) {
 		ret = devm_gpio_request_one(&i2c->dev, rt5640->pdata.ldo1_en,
 					    GPIOF_OUT_INIT_HIGH,
@@ -2073,6 +2065,14 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 		msleep(400);
 	}
 
+	rt5640->regmap = devm_regmap_init_i2c(i2c, &rt5640_regmap);
+	if (IS_ERR(rt5640->regmap)) {
+		ret = PTR_ERR(rt5640->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
 	regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
 	if ((val != RT5640_DEVICE_ID)) {
 		dev_err(&i2c->dev,
-- 
1.8.1.5
