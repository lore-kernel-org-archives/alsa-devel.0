From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: Fix lost pin setting for DMIC1
Date: Mon, 3 Aug 2015 12:17:39 +0800
Message-ID: <1438575459-29702-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 30FF3264F0F
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 06:18:02 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

I2S2_DAC pin can be used for I2S or GPIO. We should set it as GPIO
if we use GPIO5 as DMIC1 data pin.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 ++
 sound/soc/codecs/rt5645.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9d54b34..c34c498 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3356,6 +3356,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		break;
 
 	case RT5645_DMIC_DATA_GPIO5:
+		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
+			RT5645_I2S2_DAC_PIN_MASK, RT5645_I2S2_DAC_PIN_GPIO);
 		regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
 			RT5645_DMIC_1_DP_MASK, RT5645_DMIC_1_DP_GPIO5);
 		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 199b22f..dffdda2 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -1693,6 +1693,10 @@
 #define RT5645_GP6_PIN_SFT			6
 #define RT5645_GP6_PIN_GPIO6			(0x0 << 6)
 #define RT5645_GP6_PIN_DMIC2_SDA		(0x1 << 6)
+#define RT5645_I2S2_DAC_PIN_MASK		(0x1 << 4)
+#define RT5645_I2S2_DAC_PIN_SFT			4
+#define RT5645_I2S2_DAC_PIN_I2S			(0x0 << 4)
+#define RT5645_I2S2_DAC_PIN_GPIO		(0x1 << 4)
 #define RT5645_GP8_PIN_MASK			(0x1 << 3)
 #define RT5645_GP8_PIN_SFT			3
 #define RT5645_GP8_PIN_GPIO8			(0x0 << 3)
-- 
1.8.1.1.439.g50a6b54
