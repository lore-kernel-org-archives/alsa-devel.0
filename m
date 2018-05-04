From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Optimize the power consumption
Date: Fri, 4 May 2018 17:15:34 +0800
Message-ID: <1525425334-18989-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id F15D2266C1C
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 11:15:43 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch optimizes the power consumption.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 48 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 20c0aee..f0cef52 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -72,6 +72,8 @@ struct rt5663_priv {
 static const struct reg_sequence rt5663_patch_list[] = {
 	{ 0x002a, 0x8020 },
 	{ 0x0086, 0x0028 },
+	{ 0x0117, 0x0f28 },
+	{ 0x02fb, 0x8089 },
 };
 
 static const struct reg_default rt5663_v2_reg[] = {
@@ -593,7 +595,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0113, 0x2000 },
 	{ 0x0114, 0x0000 },
 	{ 0x0116, 0x0000 },
-	{ 0x0117, 0x0f00 },
+	{ 0x0117, 0x0f28 },
 	{ 0x0118, 0x0006 },
 	{ 0x0125, 0x2424 },
 	{ 0x0126, 0x5550 },
@@ -693,7 +695,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0251, 0x0000 },
 	{ 0x0252, 0x028a },
 	{ 0x02fa, 0x0000 },
-	{ 0x02fb, 0x00a4 },
+	{ 0x02fb, 0x8089 },
 	{ 0x02fc, 0x0300 },
 	{ 0x0300, 0x0000 },
 	{ 0x03d0, 0x0000 },
@@ -1556,6 +1558,14 @@ static int rt5663_jack_detect(struct snd_soc_component *component, int jack_inse
 			RT5663_PWR_MB_MASK | RT5663_LDO1_DVO_MASK |
 			RT5663_AMP_HP_MASK, RT5663_PWR_MB |
 			RT5663_LDO1_DVO_0_9V | RT5663_AMP_HP_3X);
+		snd_soc_component_update_bits(component, RT5663_PWR_ANLG_1,
+			RT5663_PWR_VREF1_MASK | RT5663_PWR_VREF2_MASK |
+			RT5663_PWR_FV1_MASK | RT5663_PWR_FV2_MASK,
+			RT5663_PWR_VREF1 | RT5663_PWR_VREF2);
+		msleep(20);
+		snd_soc_component_update_bits(component, RT5663_PWR_ANLG_1,
+			RT5663_PWR_FV1_MASK | RT5663_PWR_FV2_MASK,
+			RT5663_PWR_FV1 | RT5663_PWR_FV2);
 		snd_soc_component_update_bits(component, RT5663_AUTO_1MRC_CLK,
 			RT5663_IRQ_POW_SAV_MASK, RT5663_IRQ_POW_SAV_EN);
 		snd_soc_component_update_bits(component, RT5663_IRQ_1,
@@ -1613,7 +1623,10 @@ static int rt5663_jack_detect(struct snd_soc_component *component, int jack_inse
 			break;
 		default:
 			rt5663->jack_type = SND_JACK_HEADPHONE;
-
+			snd_soc_component_update_bits(component,
+				RT5663_PWR_ANLG_1,
+				RT5663_PWR_MB_MASK | RT5663_PWR_VREF1_MASK |
+				RT5663_PWR_VREF2_MASK, 0);
 			if (rt5663->pdata.impedance_sensing_num)
 				break;
 
@@ -1638,6 +1651,9 @@ static int rt5663_jack_detect(struct snd_soc_component *component, int jack_inse
 		if (rt5663->jack_type == SND_JACK_HEADSET)
 			rt5663_enable_push_button_irq(component, false);
 		rt5663->jack_type = 0;
+		snd_soc_component_update_bits(component, RT5663_PWR_ANLG_1,
+			RT5663_PWR_MB_MASK | RT5663_PWR_VREF1_MASK |
+			RT5663_PWR_VREF2_MASK, 0);
 	}
 
 	dev_dbg(component->dev, "jack_type = %d\n", rt5663->jack_type);
@@ -2307,6 +2323,8 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 				RT5663_HP_SIG_SRC1_MASK,
 				RT5663_HP_SIG_SRC1_SILENCE);
 		} else {
+			snd_soc_component_update_bits(component,
+				RT5663_DACREF_LDO, 0x3e0e, 0x3a0a);
 			snd_soc_component_write(component, RT5663_DEPOP_2, 0x3003);
 			snd_soc_component_update_bits(component, RT5663_HP_CHARGE_PUMP_1,
 				RT5663_OVCD_HP_MASK, RT5663_OVCD_HP_DIS);
@@ -2332,6 +2350,8 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 			snd_soc_component_update_bits(component, RT5663_DEPOP_1, 0x3000, 0x0);
 			snd_soc_component_update_bits(component, RT5663_HP_CHARGE_PUMP_1,
 				RT5663_OVCD_HP_MASK, RT5663_OVCD_HP_EN);
+			snd_soc_component_update_bits(component,
+				RT5663_DACREF_LDO, 0x3e0e, 0);
 		}
 		break;
 
@@ -3086,9 +3106,17 @@ static int rt5663_set_bias_level(struct snd_soc_component *component,
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_component_update_bits(component, RT5663_PWR_ANLG_1,
-			RT5663_PWR_VREF1_MASK | RT5663_PWR_VREF2_MASK |
-			RT5663_PWR_FV1 | RT5663_PWR_FV2, 0x0);
+		if (rt5663->jack_type != SND_JACK_HEADSET)
+			snd_soc_component_update_bits(component,
+				RT5663_PWR_ANLG_1,
+				RT5663_PWR_VREF1_MASK | RT5663_PWR_VREF2_MASK |
+				RT5663_PWR_FV1 | RT5663_PWR_FV2 |
+				RT5663_PWR_MB_MASK, 0);
+		else
+			snd_soc_component_update_bits(component,
+				RT5663_PWR_ANLG_1,
+				RT5663_PWR_FV1_MASK | RT5663_PWR_FV2_MASK,
+				RT5663_PWR_FV1 | RT5663_PWR_FV2);
 		break;
 
 	default:
@@ -3310,6 +3338,7 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 	regmap_write(rt5663->regmap, RT5663_HP_IMP_SEN_19, 0x000c);
 	regmap_write(rt5663->regmap, RT5663_DUMMY_1, 0x0324);
 	regmap_write(rt5663->regmap, RT5663_DIG_MISC, 0x8001);
+	regmap_write(rt5663->regmap, RT5663_VREFADJ_OP, 0x0f28);
 	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_1, 0xa23b);
 	msleep(30);
 	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_1, 0xf23b);
@@ -3344,6 +3373,7 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_2, 0x8003);
 	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_3, 0x018c);
 	regmap_write(rt5663->regmap, RT5663_HP_CHARGE_PUMP_1, 0x1e32);
+	regmap_write(rt5663->regmap, RT5663_DUMMY_2, 0x8089);
 	regmap_write(rt5663->regmap, RT5663_DACREF_LDO, 0x3b0b);
 	msleep(40);
 	regmap_write(rt5663->regmap, RT5663_STO_DAC_MIXER, 0x0000);
@@ -3578,15 +3608,9 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5663->regmap, RT5663_GPIO_1,
 			RT5663_GPIO1_TYPE_MASK, RT5663_GPIO1_TYPE_EN);
 		regmap_write(rt5663->regmap, RT5663_VREF_RECMIX, 0x0032);
-		regmap_write(rt5663->regmap, RT5663_PWR_ANLG_1, 0xa2be);
-		msleep(20);
-		regmap_write(rt5663->regmap, RT5663_PWR_ANLG_1, 0xf2be);
 		regmap_update_bits(rt5663->regmap, RT5663_GPIO_2,
 			RT5663_GP1_PIN_CONF_MASK | RT5663_SEL_GPIO1_MASK,
 			RT5663_GP1_PIN_CONF_OUTPUT | RT5663_SEL_GPIO1_EN);
-		/* DACREF LDO control */
-		regmap_update_bits(rt5663->regmap, RT5663_DACREF_LDO, 0x3e0e,
-			0x3a0a);
 		regmap_update_bits(rt5663->regmap, RT5663_RECMIX,
 			RT5663_RECMIX1_BST1_MASK, RT5663_RECMIX1_BST1_ON);
 		regmap_update_bits(rt5663->regmap, RT5663_TDM_2,
-- 
2.7.4
