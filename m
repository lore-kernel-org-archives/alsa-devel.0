From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: Add dts properties for
	input/output differential configuration
Date: Fri, 26 Sep 2014 09:57:27 -0700
Message-ID: <1411750647-10134-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f202.google.com (mail-pd0-f202.google.com
 [209.85.192.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A07B2604CC
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 18:57:52 +0200 (CEST)
Received: by mail-pd0-f202.google.com with SMTP id r10so2173851pdi.1
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 09:57:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, bardliao@realtek.com, oder_chiou@realtek.com
Cc: alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Documentation/devicetree/bindings/sound/rt5677.txt |  9 +++++++++
 include/sound/rt5677.h                             |  5 ++++-
 sound/soc/codecs/rt5677.c                          | 23 ++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
index bd28df6..0701b83 100644
--- a/Documentation/devicetree/bindings/sound/rt5677.txt
+++ b/Documentation/devicetree/bindings/sound/rt5677.txt
@@ -19,6 +19,14 @@ Optional properties:
 
 - realtek,pow-ldo2-gpio : The GPIO that controls the CODEC's POW_LDO2 pin.
 
+- realtek,in1-differential
+- realtek,in2-differential
+- realtek,lout1-differential
+- realtek,lout2-differential
+- realtek,lout3-differential
+  Boolean. Indicate MIC1/2 input and LOUT1/2/3 outputs are differential,
+  rather than single-ended.
+
 Pins on the device (for linking into audio routes):
 
   * IN1P
@@ -47,4 +55,5 @@ rt5677 {
 
 	realtek,pow-ldo2-gpio =
 		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+	realtek,in1-differential = "true";
 };
diff --git a/include/sound/rt5677.h b/include/sound/rt5677.h
index a676717..082670e 100644
--- a/include/sound/rt5677.h
+++ b/include/sound/rt5677.h
@@ -19,9 +19,12 @@ enum rt5677_dmic2_clk {
 
 
 struct rt5677_platform_data {
-	/* IN1 IN2 can optionally be differential */
+	/* IN1/IN2/LOUT1/LOUT2/LOUT3 can optionally be differential */
 	bool in1_diff;
 	bool in2_diff;
+	bool lout1_diff;
+	bool lout2_diff;
+	bool lout3_diff;
 	/* DMIC2 clock source selection */
 	enum rt5677_dmic2_clk dmic2_clk_pin;
 };
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index cecbdb1..16aa4d9 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3566,6 +3566,17 @@ MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
 
 static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
 {
+	rt5677->pdata.in1_diff = of_property_read_bool(np,
+					"realtek,in1-differential");
+	rt5677->pdata.in2_diff = of_property_read_bool(np,
+					"realtek,in2-differential");
+	rt5677->pdata.lout1_diff = of_property_read_bool(np,
+					"realtek,lout1-differential");
+	rt5677->pdata.lout2_diff = of_property_read_bool(np,
+					"realtek,lout2-differential");
+	rt5677->pdata.lout3_diff = of_property_read_bool(np,
+					"realtek,lout3-differential");
+
 	rt5677->pow_ldo2 = of_get_named_gpio(np,
 					"realtek,pow-ldo2-gpio", 0);
 
@@ -3657,6 +3668,18 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5677->regmap, RT5677_IN1,
 					RT5677_IN_DF2, RT5677_IN_DF2);
 
+	if (rt5677->pdata.lout1_diff)
+		regmap_update_bits(rt5677->regmap, RT5677_LOUT1,
+					RT5677_LOUT1_L_DF, RT5677_LOUT1_L_DF);
+
+	if (rt5677->pdata.lout2_diff)
+		regmap_update_bits(rt5677->regmap, RT5677_LOUT1,
+					RT5677_LOUT2_L_DF, RT5677_LOUT2_L_DF);
+
+	if (rt5677->pdata.lout3_diff)
+		regmap_update_bits(rt5677->regmap, RT5677_LOUT1,
+					RT5677_LOUT3_L_DF, RT5677_LOUT3_L_DF);
+
 	if (rt5677->pdata.dmic2_clk_pin == RT5677_DMIC_CLK2) {
 		regmap_update_bits(rt5677->regmap, RT5677_GEN_CTRL2,
 					RT5677_GPIO5_FUNC_MASK,
-- 
2.1.0.rc2.206.gedb03e5
