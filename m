From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5645: remove unused field in pdata
Date: Tue, 5 May 2015 21:42:01 +0800
Message-ID: <1430833322-13531-2-git-send-email-bardliao@realtek.com>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A8FB9265044
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 15:42:14 +0200 (CEST)
In-Reply-To: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We can know if dmic is used by reading the value of dmic1_data_pin
and dmic2_data_pin. Also IRQ must be used if codec JD or button
detection function is used. So, dmic_en and en_jd_func can be remove
from platform data.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 include/sound/rt5645.h    |   3 --
 sound/soc/codecs/rt5645.c | 124 ++++++++++++++++++++++------------------------
 sound/soc/codecs/rt5645.h |   2 +
 3 files changed, 61 insertions(+), 68 deletions(-)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index 120d961..652cb9e 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -15,7 +15,6 @@ struct rt5645_platform_data {
 	/* IN2 can optionally be differential */
 	bool in2_diff;
 
-	bool dmic_en;
 	unsigned int dmic1_data_pin;
 	/* 0 = IN2N; 1 = GPIO5; 2 = GPIO11 */
 	unsigned int dmic2_data_pin;
@@ -24,8 +23,6 @@ struct rt5645_platform_data {
 	unsigned int hp_det_gpio;
 	bool gpio_hp_det_active_high;
 
-	/* true if codec's jd function is used */
-	bool en_jd_func;
 	unsigned int jd_mode;
 };
 
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a72d989..e435680 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2968,7 +2968,7 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, RT5645_CHARGE_PUMP, 0x0300, 0x0200);
 
 	/* for JD function */
-	if (rt5645->pdata.en_jd_func) {
+	if (rt5645->pdata.jd_mode) {
 		snd_soc_dapm_force_enable_pin(&codec->dapm, "JD Power");
 		snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO2");
 		snd_soc_dapm_sync(&codec->dapm);
@@ -3111,10 +3111,8 @@ MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
 static struct rt5645_platform_data *rt5645_pdata;
 
 static struct rt5645_platform_data strago_platform_data = {
-	.dmic_en = true,
-	.dmic1_data_pin = -1,
+	.dmic1_data_pin = RT5645_DMIC1_DISABLE,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
-	.en_jd_func = true,
 	.jd_mode = 3,
 };
 
@@ -3214,83 +3212,79 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5645->regmap, RT5645_IN2_CTRL,
 					RT5645_IN_DF2, RT5645_IN_DF2);
 
-	if (rt5645->pdata.dmic_en) {
+	if (rt5645->pdata.dmic1_data_pin || rt5645->pdata.dmic2_data_pin) {
 		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
 			RT5645_GP2_PIN_MASK, RT5645_GP2_PIN_DMIC1_SCL);
+	}
+	switch (rt5645->pdata.dmic1_data_pin) {
+	case RT5645_DMIC_DATA_IN2N:
+		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
+			RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_IN2N);
+		break;
 
-		switch (rt5645->pdata.dmic1_data_pin) {
-		case RT5645_DMIC_DATA_IN2N:
-			regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
-				RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_IN2N);
-			break;
-
-		case RT5645_DMIC_DATA_GPIO5:
-			regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
-				RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_GPIO5);
-			regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
-				RT5645_GP5_PIN_MASK, RT5645_GP5_PIN_DMIC1_SDA);
-			break;
-
-		case RT5645_DMIC_DATA_GPIO11:
-			regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
-				RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_GPIO11);
-			regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
-				RT5645_GP11_PIN_MASK,
-				RT5645_GP11_PIN_DMIC1_SDA);
-			break;
+	case RT5645_DMIC_DATA_GPIO5:
+		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
+			RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_GPIO5);
+		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
+			RT5645_GP5_PIN_MASK, RT5645_GP5_PIN_DMIC1_SDA);
+		break;
 
-		default:
-			break;
-		}
+	case RT5645_DMIC_DATA_GPIO11:
+		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
+			RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_GPIO11);
+		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
+			RT5645_GP11_PIN_MASK,
+			RT5645_GP11_PIN_DMIC1_SDA);
+		break;
 
-		switch (rt5645->pdata.dmic2_data_pin) {
-		case RT5645_DMIC_DATA_IN2P:
-			regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
-				RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_IN2P);
-			break;
+	default:
+		break;
+	}
 
-		case RT5645_DMIC_DATA_GPIO6:
-			regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
-				RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_GPIO6);
-			regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
-				RT5645_GP6_PIN_MASK, RT5645_GP6_PIN_DMIC2_SDA);
-			break;
+	switch (rt5645->pdata.dmic2_data_pin) {
+	case RT5645_DMIC_DATA_IN2P:
+		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
+			RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_IN2P);
+		break;
 
-		case RT5645_DMIC_DATA_GPIO10:
-			regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
-				RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_GPIO10);
-			regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
-				RT5645_GP10_PIN_MASK,
-				RT5645_GP10_PIN_DMIC2_SDA);
-			break;
+	case RT5645_DMIC_DATA_GPIO6:
+		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
+			RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_GPIO6);
+		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
+			RT5645_GP6_PIN_MASK, RT5645_GP6_PIN_DMIC2_SDA);
+		break;
 
-		case RT5645_DMIC_DATA_GPIO12:
-			regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
-				RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_GPIO12);
-			regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
-				RT5645_GP12_PIN_MASK,
-				RT5645_GP12_PIN_DMIC2_SDA);
-			break;
+	case RT5645_DMIC_DATA_GPIO10:
+		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
+			RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_GPIO10);
+		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
+			RT5645_GP10_PIN_MASK,
+			RT5645_GP10_PIN_DMIC2_SDA);
+		break;
 
-		default:
-			break;
-		}
+	case RT5645_DMIC_DATA_GPIO12:
+		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
+			RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_GPIO12);
+		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
+			RT5645_GP12_PIN_MASK,
+			RT5645_GP12_PIN_DMIC2_SDA);
+		break;
 
+	default:
+		break;
 	}
 
-	if (rt5645->pdata.en_jd_func) {
+	if (rt5645->pdata.jd_mode) {
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3,
-			RT5645_IRQ_CLK_GATE_CTRL, RT5645_IRQ_CLK_GATE_CTRL);
+				   RT5645_IRQ_CLK_GATE_CTRL,
+				   RT5645_IRQ_CLK_GATE_CTRL);
 		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1,
-			RT5645_CBJ_BST1_EN, RT5645_CBJ_BST1_EN);
+				   RT5645_CBJ_BST1_EN, RT5645_CBJ_BST1_EN);
 		regmap_update_bits(rt5645->regmap, RT5645_JD_CTRL3,
-			RT5645_JD_CBJ_EN | RT5645_JD_CBJ_POL,
-			RT5645_JD_CBJ_EN | RT5645_JD_CBJ_POL);
+				   RT5645_JD_CBJ_EN | RT5645_JD_CBJ_POL,
+				   RT5645_JD_CBJ_EN | RT5645_JD_CBJ_POL);
 		regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
-			RT5645_IRQ_CLK_INT, RT5645_IRQ_CLK_INT);
-	}
-
-	if (rt5645->pdata.jd_mode) {
+				   RT5645_IRQ_CLK_INT, RT5645_IRQ_CLK_INT);
 		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 				   RT5645_IRQ_JD_1_1_EN, RT5645_IRQ_JD_1_1_EN);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3,
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index c204861..9ec4e89 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2145,6 +2145,7 @@ enum {
 };
 
 enum {
+	RT5645_DMIC1_DISABLE,
 	RT5645_DMIC_DATA_IN2P,
 	RT5645_DMIC_DATA_GPIO6,
 	RT5645_DMIC_DATA_GPIO10,
@@ -2152,6 +2153,7 @@ enum {
 };
 
 enum {
+	RT5645_DMIC2_DISABLE,
 	RT5645_DMIC_DATA_IN2N,
 	RT5645_DMIC_DATA_GPIO5,
 	RT5645_DMIC_DATA_GPIO11,
-- 
1.8.1.1.439.g50a6b54
