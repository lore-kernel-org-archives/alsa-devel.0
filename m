From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 07/19] ASoC: tlv320aic31xx: Merge init
	function into probe
Date: Wed, 29 Nov 2017 15:32:48 -0600
Message-ID: <20171129213300.20021-8-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id D5BBD26796D
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 22:33:04 +0100 (CET)
In-Reply-To: <20171129213300.20021-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The function aic31xx_device_init() is only called from probe and
does nothing that logically shouldn't be in probe, remove this
unneeded function call and move its code into probe where it was called.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 55 ++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 07c014501e5e..c84febd991a0 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1302,9 +1302,29 @@ static const struct acpi_device_id aic31xx_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, aic31xx_acpi_match);
 #endif
 
-static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
+static int aic31xx_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
 {
-	int ret, i;
+	struct aic31xx_priv *aic31xx;
+	int i, ret;
+
+	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
+		id->name, (int)id->driver_data);
+
+	aic31xx = devm_kzalloc(&i2c->dev, sizeof(*aic31xx), GFP_KERNEL);
+	if (!aic31xx)
+		return -ENOMEM;
+
+	aic31xx->regmap = devm_regmap_init_i2c(i2c, &aic31xx_i2c_regmap);
+	if (IS_ERR(aic31xx->regmap)) {
+		ret = PTR_ERR(aic31xx->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+	aic31xx->dev = &i2c->dev;
+
+	aic31xx->pdata.codec_type = id->driver_data;
 
 	dev_set_drvdata(aic31xx->dev, aic31xx);
 
@@ -1336,37 +1356,6 @@ static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
 		return ret;
 	}
 
-	return 0;
-}
-
-static int aic31xx_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
-{
-	struct aic31xx_priv *aic31xx;
-	int ret;
-
-	dev_dbg(&i2c->dev, "## %s: %s codec_type = %d\n", __func__,
-		id->name, (int) id->driver_data);
-
-	aic31xx = devm_kzalloc(&i2c->dev, sizeof(*aic31xx), GFP_KERNEL);
-	if (!aic31xx)
-		return -ENOMEM;
-
-	aic31xx->regmap = devm_regmap_init_i2c(i2c, &aic31xx_i2c_regmap);
-	if (IS_ERR(aic31xx->regmap)) {
-		ret = PTR_ERR(aic31xx->regmap);
-		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
-			ret);
-		return ret;
-	}
-	aic31xx->dev = &i2c->dev;
-
-	aic31xx->pdata.codec_type = id->driver_data;
-
-	ret = aic31xx_device_init(aic31xx);
-	if (ret)
-		return ret;
-
 	if (aic31xx->pdata.codec_type & DAC31XX_BIT)
 		return snd_soc_register_codec(&i2c->dev,
 				&soc_codec_driver_aic31xx,
-- 
2.15.0
