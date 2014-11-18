From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5645: multiple JD mode support
Date: Tue, 18 Nov 2014 16:50:18 +0800
Message-ID: <1416300619-14334-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 56F1026508C
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 09:50:52 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

There are 3 JD modes in RT5645. This patch configure register
values according to platform data.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 include/sound/rt5645.h    |  1 +
 sound/soc/codecs/rt5645.c | 35 ++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/rt5645.h |  7 +++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index 937f421..120d961 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -26,6 +26,7 @@ struct rt5645_platform_data {
 
 	/* true if codec's jd function is used */
 	bool en_jd_func;
+	unsigned int jd_mode;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 31b5b1a..a7789a8 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2241,7 +2241,8 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec)
 
 		snd_soc_dapm_disable_pin(&codec->dapm, "micbias1");
 		snd_soc_dapm_disable_pin(&codec->dapm, "micbias2");
-		snd_soc_dapm_disable_pin(&codec->dapm, "LDO2");
+		if (rt5645->pdata.jd_mode == 0)
+			snd_soc_dapm_disable_pin(&codec->dapm, "LDO2");
 		snd_soc_dapm_disable_pin(&codec->dapm, "Mic Det Power");
 		snd_soc_dapm_sync(&codec->dapm);
 	}
@@ -2545,6 +2546,38 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 			RT5645_IRQ_CLK_INT, RT5645_IRQ_CLK_INT);
 	}
 
+	if (rt5645->pdata.jd_mode) {
+		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
+				   RT5645_IRQ_JD_1_1_EN, RT5645_IRQ_JD_1_1_EN);
+		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3,
+				   RT5645_JD_PSV_MODE, RT5645_JD_PSV_MODE);
+		regmap_update_bits(rt5645->regmap, RT5645_HPO_MIXER,
+				   RT5645_IRQ_PSV_MODE, RT5645_IRQ_PSV_MODE);
+		regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
+				   RT5645_MIC2_OVCD_EN, RT5645_MIC2_OVCD_EN);
+		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
+				   RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
+		switch (rt5645->pdata.jd_mode) {
+		case 1:
+			regmap_update_bits(rt5645->regmap, RT5645_A_JD_CTRL1,
+					   RT5645_JD1_MODE_MASK,
+					   RT5645_JD1_MODE_0);
+			break;
+		case 2:
+			regmap_update_bits(rt5645->regmap, RT5645_A_JD_CTRL1,
+					   RT5645_JD1_MODE_MASK,
+					   RT5645_JD1_MODE_1);
+			break;
+		case 3:
+			regmap_update_bits(rt5645->regmap, RT5645_A_JD_CTRL1,
+					   RT5645_JD1_MODE_MASK,
+					   RT5645_JD1_MODE_2);
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (rt5645->i2c->irq) {
 		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index c72220a..a815e36 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -594,6 +594,7 @@
 #define RT5645_M_DAC1_HM_SFT			14
 #define RT5645_M_HPVOL_HM			(0x1 << 13)
 #define RT5645_M_HPVOL_HM_SFT			13
+#define RT5645_IRQ_PSV_MODE			(0x1 << 12)
 
 /* SPK Left Mixer Control (0x46) */
 #define RT5645_G_RM_L_SM_L_MASK			(0x3 << 14)
@@ -1350,6 +1351,10 @@
 #define RT5645_PWR_CLK25M_PU			(0x1 << 4)
 #define RT5645_IRQ_CLK_MCLK			(0x0 << 3)
 #define RT5645_IRQ_CLK_INT			(0x1 << 3)
+#define RT5645_JD1_MODE_MASK			(0x3 << 0)
+#define RT5645_JD1_MODE_0			(0x0 << 0)
+#define RT5645_JD1_MODE_1			(0x1 << 0)
+#define RT5645_JD1_MODE_2			(0x2 << 0)
 
 /* VAD Control 4 (0x9d) */
 #define RT5645_VAD_SEL_MASK			(0x3 << 8)
@@ -1638,6 +1643,7 @@
 #define RT5645_OT_P_SFT				10
 #define RT5645_OT_P_NOR				(0x0 << 10)
 #define RT5645_OT_P_INV				(0x1 << 10)
+#define RT5645_IRQ_JD_1_1_EN			(0x1 << 9)
 
 /* IRQ Control 2 (0xbe) */
 #define RT5645_IRQ_MB1_OC_MASK			(0x1 << 15)
@@ -2120,6 +2126,7 @@ enum {
 #define RT5645_RXDP2_SEL_SFT			(3)
 
 /* General Control3 (0xfc) */
+#define RT5645_JD_PSV_MODE			(0x1 << 12)
 #define RT5645_IRQ_CLK_GATE_CTRL		(0x1 << 11)
 #define RT5645_MICINDET_MANU			(0x1 << 7)
 
-- 
1.8.1.1.439.g50a6b54
