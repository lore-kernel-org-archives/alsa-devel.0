From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8960: Support shared LRCLK
Date: Thu, 13 Sep 2012 11:48:28 +0800
Message-ID: <1347508108-24248-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 976FE2616E9
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 05:48:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If the LRCLK is shared and the WM8960 is clock master then we should
enable the LRCM bit to tell the device that it should drive LRCLK when
either ADC or DAC is enabled rather than separately driving the two
LRCLKs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/wm8960.h    |    2 ++
 sound/soc/codecs/wm8960.c |   11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/sound/wm8960.h b/include/sound/wm8960.h
index 74e9a95..b5a1ab9e 100644
--- a/include/sound/wm8960.h
+++ b/include/sound/wm8960.h
@@ -19,6 +19,8 @@ struct wm8960_data {
 	bool capless;  /* Headphone outputs configured in capless mode */
 
 	int dres;  /* Discharge resistance for headphone outputs */
+
+	bool shared_lrclk;  /* DAC and ADC LRCLKs are wired together */
 };
 
 #endif
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 7cb0d07c..8740423 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1029,6 +1029,7 @@ static const struct regmap_config wm8960_regmap = {
 static __devinit int wm8960_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
+	struct wm8960_data *pdata = dev_get_platdata(&i2c->dev);
 	struct wm8960_priv *wm8960;
 	int ret;
 
@@ -1041,6 +1042,16 @@ static __devinit int wm8960_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(wm8960->regmap))
 		return PTR_ERR(wm8960->regmap);
 
+	if (pdata && pdata->shared_lrclk) {
+		ret = regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2,
+					 0x4, 0x4);
+		if (ret != 0) {
+			dev_err(&i2c->dev, "Failed to enable LRCM: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	i2c_set_clientdata(i2c, wm8960);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.10.4
