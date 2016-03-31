From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 2/5] ASoC: tas571x: chip type detection via I2C name
Date: Thu, 31 Mar 2016 13:53:58 +0200
Message-ID: <1459425241-21941-2-git-send-email-petr@barix.com>
References: <1459425241-21941-1-git-send-email-petr@barix.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459425241-21941-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The chip selection was relying only on DT. It was not possible to use the
driver without DT.
This adds the chip type detection from the I2C name, which
allows to use the driver from the platform driver without DT.

Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
v1: <initial>
v2: <no change>
v3: <no change>

 sound/soc/codecs/tas571x.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index d255d65..2107322 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -414,11 +414,10 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, priv);
 
 	of_id = of_match_device(tas571x_of_match, dev);
-	if (!of_id) {
-		dev_err(dev, "Unknown device type\n");
-		return -EINVAL;
-	}
-	priv->chip = of_id->data;
+	if (of_id)
+		priv->chip = of_id->data;
+	else
+		priv->chip = (void *) id->driver_data;
 
 	priv->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(priv->mclk) && PTR_ERR(priv->mclk) != -ENOENT) {
@@ -519,9 +518,9 @@ static const struct of_device_id tas571x_of_match[] = {
 MODULE_DEVICE_TABLE(of, tas571x_of_match);
 
 static const struct i2c_device_id tas571x_i2c_id[] = {
-	{ "tas5711", 0 },
-	{ "tas5717", 0 },
-	{ "tas5719", 0 },
+	{ "tas5711", (kernel_ulong_t) &tas5711_chip },
+	{ "tas5717", (kernel_ulong_t) &tas5717_chip },
+	{ "tas5719", (kernel_ulong_t) &tas5717_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tas571x_i2c_id);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
