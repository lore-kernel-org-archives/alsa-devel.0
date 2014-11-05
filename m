From: <bardliao@realtek.com>
Subject: [PATCH] ASoC:rt5645:Add JD function support
Date: Wed, 5 Nov 2014 15:02:08 +0800
Message-ID: <1415170928-29408-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C9DED261A12
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 08:02:47 +0100 (CET)
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

From: Bard Liao <bardliao@realtek.com>

rt5645 codec support jack detection function. The patch will set
related registers if JD function is used.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 include/sound/rt5645.h    |  3 +++
 sound/soc/codecs/rt5645.c | 20 ++++++++++++++++++++
 sound/soc/codecs/rt5645.h |  5 +++++
 3 files changed, 28 insertions(+)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index a535271..937f421 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -23,6 +23,9 @@ struct rt5645_platform_data {
 
 	unsigned int hp_det_gpio;
 	bool gpio_hp_det_active_high;
+
+	/* true if codec's jd function is used */
+	bool en_jd_func;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 0e92e63..1c099ee 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2205,6 +2205,13 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 
 	snd_soc_update_bits(codec, RT5645_CHARGE_PUMP, 0x0300, 0x0200);
 
+	/* for JD function */
+	if (rt5645->pdata.en_jd_func) {
+		snd_soc_dapm_force_enable_pin(&codec->dapm, "JD Power");
+		snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO2");
+		snd_soc_dapm_sync(&codec->dapm);
+	}
+
 	return 0;
 }
 
@@ -2438,6 +2445,19 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	}
 
+	if (rt5645->pdata.en_jd_func) {
+		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3,
+			RT5645_IRQ_CLK_GATE_CTRL | RT5645_MICINDET_MANU,
+			RT5645_IRQ_CLK_GATE_CTRL | RT5645_MICINDET_MANU);
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1,
+			RT5645_CBJ_BST1_EN, RT5645_CBJ_BST1_EN);
+		regmap_update_bits(rt5645->regmap, RT5645_JD_CTRL3,
+			RT5645_JD_CBJ_EN | RT5645_JD_CBJ_POL,
+			RT5645_JD_CBJ_EN | RT5645_JD_CBJ_POL);
+		regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
+			RT5645_IRQ_CLK_INT, RT5645_IRQ_CLK_INT);
+	}
+
 	if (rt5645->i2c->irq) {
 		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 5ec2520..82f681b 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -1348,6 +1348,8 @@
 #define RT5645_PWR_CLK25M_SFT			4
 #define RT5645_PWR_CLK25M_PD			(0x0 << 4)
 #define RT5645_PWR_CLK25M_PU			(0x1 << 4)
+#define RT5645_IRQ_CLK_MCLK			(0x0 << 3)
+#define RT5645_IRQ_CLK_INT			(0x1 << 3)
 
 /* VAD Control 4 (0x9d) */
 #define RT5645_VAD_SEL_MASK			(0x3 << 8)
@@ -2116,6 +2118,9 @@ enum {
 #define RT5645_RXDP2_SEL_ADC			(0x1 << 3)
 #define RT5645_RXDP2_SEL_SFT			(3)
 
+/* General Control3 (0xfc) */
+#define RT5645_IRQ_CLK_GATE_CTRL		(0x1 << 11)
+#define RT5645_MICINDET_MANU			(0x1 << 7)
 
 /* Vendor ID (0xfd) */
 #define RT5645_VER_C				0x2
-- 
1.8.1.1.439.g50a6b54
