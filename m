From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Seprate the DC offset between
	headphone and headset
Date: Wed, 2 Aug 2017 16:01:27 +0800
Message-ID: <1501660887-22393-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 71BD4266847
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 10:01:35 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch seprates the DC offset between headphone and headset.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5663.txt |  5 ++-
 include/sound/rt5663.h                             |  2 +
 sound/soc/codecs/rt5663.c                          | 52 ++++++++++++++++------
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
index f7c7cc5..ff38171 100644
--- a/Documentation/devicetree/bindings/sound/rt5663.txt
+++ b/Documentation/devicetree/bindings/sound/rt5663.txt
@@ -14,8 +14,11 @@ Optional properties:
 
 - "realtek,dc_offset_l_manual"
 - "realtek,dc_offset_r_manual"
+- "realtek,dc_offset_l_manual_mic"
+- "realtek,dc_offset_r_manual_mic"
   Based on the different PCB layout, add the manual offset value to
-  compensate the DC offset for each L and R channel.
+  compensate the DC offset for each L and R channel, and they are different
+  between headphone and headset.
 
 Pins on the device (for linking into audio routes) for RT5663:
 
diff --git a/include/sound/rt5663.h b/include/sound/rt5663.h
index be6f1b2..7d00e58 100644
--- a/include/sound/rt5663.h
+++ b/include/sound/rt5663.h
@@ -14,6 +14,8 @@
 struct rt5663_platform_data {
 	unsigned int dc_offset_l_manual;
 	unsigned int dc_offset_r_manual;
+	unsigned int dc_offset_l_manual_mic;
+	unsigned int dc_offset_r_manual_mic;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 7bbfb18..7f05682 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1570,9 +1570,43 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		case 2:
 			rt5663->jack_type = SND_JACK_HEADSET;
 			rt5663_enable_push_button_irq(codec, true);
+
+			if (rt5663->pdata.dc_offset_l_manual_mic) {
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_2,
+					rt5663->pdata.dc_offset_l_manual_mic >>
+					16);
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_3,
+					rt5663->pdata.dc_offset_l_manual_mic &
+					0xffff);
+			}
+
+			if (rt5663->pdata.dc_offset_r_manual_mic) {
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_5,
+					rt5663->pdata.dc_offset_r_manual_mic >>
+					16);
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_6,
+					rt5663->pdata.dc_offset_r_manual_mic &
+					0xffff);
+			}
 			break;
 		default:
 			rt5663->jack_type = SND_JACK_HEADPHONE;
+
+			if (rt5663->pdata.dc_offset_l_manual) {
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_2,
+					rt5663->pdata.dc_offset_l_manual >> 16);
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_3,
+					rt5663->pdata.dc_offset_l_manual &
+					0xffff);
+			}
+
+			if (rt5663->pdata.dc_offset_r_manual) {
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_5,
+					rt5663->pdata.dc_offset_r_manual >> 16);
+				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_6,
+					rt5663->pdata.dc_offset_r_manual &
+					0xffff);
+			}
 			break;
 		}
 	} else {
@@ -3133,6 +3167,10 @@ static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
 		&rt5663->pdata.dc_offset_l_manual);
 	device_property_read_u32(dev, "realtek,dc_offset_r_manual",
 		&rt5663->pdata.dc_offset_r_manual);
+	device_property_read_u32(dev, "realtek,dc_offset_l_manual_mic",
+		&rt5663->pdata.dc_offset_l_manual_mic);
+	device_property_read_u32(dev, "realtek,dc_offset_r_manual_mic",
+		&rt5663->pdata.dc_offset_r_manual_mic);
 
 	return 0;
 }
@@ -3221,20 +3259,6 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "%s:Unknown codec type\n", __func__);
 	}
 
-	if (rt5663->pdata.dc_offset_l_manual) {
-		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_2,
-			rt5663->pdata.dc_offset_l_manual >> 16);
-		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_3,
-			rt5663->pdata.dc_offset_l_manual & 0xffff);
-	}
-
-	if (rt5663->pdata.dc_offset_r_manual) {
-		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_5,
-			rt5663->pdata.dc_offset_r_manual >> 16);
-		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_6,
-			rt5663->pdata.dc_offset_r_manual & 0xffff);
-	}
-
 	/* GPIO1 as IRQ */
 	regmap_update_bits(rt5663->regmap, RT5663_GPIO_1, RT5663_GP1_PIN_MASK,
 		RT5663_GP1_PIN_IRQ);
-- 
2.7.4
