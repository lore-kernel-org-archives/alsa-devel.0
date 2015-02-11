From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v2] ASoC: rt5677: Add the chip type to
	distinguish the setting of the clock source
Date: Wed, 11 Feb 2015 19:18:51 +0800
Message-ID: <1423653531-978-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C5732260570
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 12:19:01 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

There is only one clock source in the rt5676, so the chip type is added to
distinguish the setting of the clock source in the VAD function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 28 ++++++++++++++++++++++------
 sound/soc/codecs/rt5677.h |  6 ++++++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 5d0bb87..ab62777 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -718,11 +718,24 @@ static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
 			RT5677_LDO1_SEL_MASK, 0x0);
 		regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG2,
 			RT5677_PWR_LDO1, RT5677_PWR_LDO1);
-		regmap_update_bits(rt5677->regmap, RT5677_GLB_CLK1,
-			RT5677_MCLK_SRC_MASK, RT5677_MCLK2_SRC);
-		regmap_update_bits(rt5677->regmap, RT5677_GLB_CLK2,
-			RT5677_PLL2_PR_SRC_MASK | RT5677_DSP_CLK_SRC_MASK,
-			RT5677_PLL2_PR_SRC_MCLK2 | RT5677_DSP_CLK_SRC_BYPASS);
+		switch (rt5677->type) {
+		case RT5677:
+			regmap_update_bits(rt5677->regmap, RT5677_GLB_CLK1,
+				RT5677_MCLK_SRC_MASK, RT5677_MCLK2_SRC);
+			regmap_update_bits(rt5677->regmap, RT5677_GLB_CLK2,
+				RT5677_PLL2_PR_SRC_MASK |
+				RT5677_DSP_CLK_SRC_MASK,
+				RT5677_PLL2_PR_SRC_MCLK2 |
+				RT5677_DSP_CLK_SRC_BYPASS);
+			break;
+		case RT5676:
+			regmap_update_bits(rt5677->regmap, RT5677_GLB_CLK2,
+				RT5677_DSP_CLK_SRC_MASK,
+				RT5677_DSP_CLK_SRC_BYPASS);
+			break;
+		default:
+			break;
+		}
 		regmap_write(rt5677->regmap, RT5677_PWR_DSP2, 0x07ff);
 		regmap_write(rt5677->regmap, RT5677_PWR_DSP1, 0x07fd);
 		rt5677_set_dsp_mode(codec, true);
@@ -4733,7 +4746,8 @@ static const struct regmap_config rt5677_regmap = {
 };
 
 static const struct i2c_device_id rt5677_i2c_id[] = {
-	{ "rt5677", 0 },
+	{ "rt5677", RT5677 },
+	{ "rt5676", RT5676 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
@@ -4850,6 +4864,8 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5677);
 
+	rt5677->type = id->driver_data;
+
 	if (pdata)
 		rt5677->pdata = *pdata;
 
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index c0a625f..07df96b 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1665,6 +1665,11 @@ enum {
 	RT5677_IRQ_JD3,
 };
 
+enum rt5677_type {
+	RT5677,
+	RT5676,
+};
+
 struct rt5677_priv {
 	struct snd_soc_codec *codec;
 	struct rt5677_platform_data pdata;
@@ -1681,6 +1686,7 @@ struct rt5677_priv {
 	int pll_in;
 	int pll_out;
 	int pow_ldo2; /* POW_LDO2 pin */
+	enum rt5677_type type;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip gpio_chip;
 #endif
-- 
1.8.1.1.439.g50a6b54
