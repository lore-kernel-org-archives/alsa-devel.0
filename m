From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: Add the DMIC initial delay to
	wait it ready.
Date: Tue, 18 Oct 2016 10:52:17 +0800
Message-ID: <1476759137-20207-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 08FD9266B69
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 04:52:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, woojoo.lee@samsung.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Due to the DMIC that needs time to initial after the MCLK is provided, the
field of delay time is implemented by the platform data.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5514.txt |  3 +++
 sound/soc/codecs/rt5514.c                          | 17 +++++++++++++++++
 sound/soc/codecs/rt5514.h                          |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
index 9cabfc1..a8074e7 100644
--- a/Documentation/devicetree/bindings/sound/rt5514.txt
+++ b/Documentation/devicetree/bindings/sound/rt5514.txt
@@ -13,6 +13,9 @@ Optional properties:
 - clocks: The phandle of the master clock to the CODEC
 - clock-names: Should be "mclk"
 
+- realtek,dmic-init-delay
+  Set the DMIC initial delay to wait it ready.
+
 Pins on the device (for linking into audio routes) for RT5514:
 
   * DMIC1L
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index f24b7cf..0d7bbdf 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -452,6 +452,9 @@ static int rt5514_set_dmic_clk(struct snd_soc_dapm_widget *w,
 			RT5514_CLK_DMIC_OUT_SEL_MASK,
 			idx << RT5514_CLK_DMIC_OUT_SEL_SFT);
 
+	if (rt5514->pdata.dmic_init_delay)
+		msleep(rt5514->pdata.dmic_init_delay);
+
 	return idx;
 }
 
@@ -1073,9 +1076,18 @@ static const struct of_device_id rt5514_of_match[] = {
 MODULE_DEVICE_TABLE(of, rt5514_of_match);
 #endif
 
+static int rt5514_parse_dt(struct rt5514_priv *rt5514, struct device *dev)
+{
+	device_property_read_u32(dev, "realtek,dmic-init-delay",
+		&rt5514->pdata.dmic_init_delay);
+
+	return 0;
+}
+
 static int rt5514_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
+	struct rt5514_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5514_priv *rt5514;
 	int ret;
 	unsigned int val;
@@ -1087,6 +1099,11 @@ static int rt5514_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5514);
 
+	if (pdata)
+		rt5514->pdata = *pdata;
+	else if (i2c->dev.of_node)
+		rt5514_parse_dt(rt5514, &i2c->dev);
+
 	rt5514->i2c_regmap = devm_regmap_init_i2c(i2c, &rt5514_i2c_regmap);
 	if (IS_ERR(rt5514->i2c_regmap)) {
 		ret = PTR_ERR(rt5514->i2c_regmap);
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 229de0e..5d343fb 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -13,6 +13,7 @@
 #define __RT5514_H__
 
 #include <linux/clk.h>
+#include <sound/rt5514.h>
 
 #define RT5514_DEVICE_ID			0x10ec5514
 
@@ -243,6 +244,7 @@ enum {
 };
 
 struct rt5514_priv {
+	struct rt5514_platform_data pdata;
 	struct snd_soc_codec *codec;
 	struct regmap *i2c_regmap, *regmap;
 	struct clk *mclk;
-- 
1.8.1.1.439.g50a6b54
