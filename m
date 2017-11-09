From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/17] ASoC: tlv320aic31xx: Merge init function into probe
Date: Wed, 8 Nov 2017 18:27:28 -0600
Message-ID: <20171109002741.10897-5-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171109002741.10897-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The function aic31xx_device_init() is only called from probe and
does nothing that logically shouldn't be in probe, remove this
unneeded function call and move its code into probe where it was called.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 55 ++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index c232e23a5979..94f2189695e2 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1310,9 +1310,29 @@ static const struct acpi_device_id aic31xx_acpi_match[] = {
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
 
@@ -1344,37 +1364,6 @@ static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
