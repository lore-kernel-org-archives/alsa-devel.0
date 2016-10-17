From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: Enable MCLK detection
Date: Mon, 17 Oct 2016 19:27:16 +0800
Message-ID: <1476703636-32057-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 84D1B266A34
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 13:27:24 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

There is a power saving mechanism in rt5670. It will turn off some
unused power when MCLK is not present. We call that "MCLK detection"
and it should be enabled by default.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 4 +++-
 sound/soc/codecs/rt5670.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 49caf13..6caac92 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2889,6 +2889,9 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
+	regmap_update_bits(rt5670->regmap, RT5670_DIG_MISC,
+				 RT5670_MCLK_DET, RT5670_MCLK_DET);
+
 	if (rt5670->pdata.in2_diff)
 		regmap_update_bits(rt5670->regmap, RT5670_IN2,
 					RT5670_IN_DF2, RT5670_IN_DF2);
@@ -2903,7 +2906,6 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 				   RT5670_GP1_PIN_MASK, RT5670_GP1_PIN_IRQ);
 		regmap_update_bits(rt5670->regmap, RT5670_GPIO_CTRL2,
 				   RT5670_GP1_PF_MASK, RT5670_GP1_PF_OUT);
-		regmap_update_bits(rt5670->regmap, RT5670_DIG_MISC, 0x8, 0x8);
 	}
 
 	if (rt5670->pdata.jd_mode) {
diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
index 3f1b0f1..5ba485c 100644
--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -1914,6 +1914,7 @@ enum {
 #define RT5670_IF1_ADC1_IN2_SFT			11
 #define RT5670_IF1_ADC2_IN1_SEL			(0x1 << 10)
 #define RT5670_IF1_ADC2_IN1_SFT			10
+#define RT5670_MCLK_DET				(0x1 << 3)
 
 /* General Control2 (0xfb) */
 #define RT5670_RXDC_SRC_MASK			(0x1 << 7)
-- 
1.8.1.1.439.g50a6b54
