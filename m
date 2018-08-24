From: <shumingf@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5682: Update calibration function
Date: Fri, 24 Aug 2018 10:51:51 +0800
Message-ID: <1535079111-9933-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id D5F2C26773B
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2018 04:52:14 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koonc@google.com, albertchen@realtek.com, alexlee@realtek.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

New calibration sequence allows rt5682 do calibration without
MCLK.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 640d400..0ea2759 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2454,27 +2454,15 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xa2bf);
 	usleep_range(15000, 20000);
 	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xf2bf);
-	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0380);
-	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x8001);
-	regmap_write(rt5682->regmap, RT5682_TEST_MODE_CTRL_1, 0x0000);
-	regmap_write(rt5682->regmap, RT5682_STO1_DAC_MIXER, 0x2080);
-	regmap_write(rt5682->regmap, RT5682_STO1_ADC_MIXER, 0x4040);
-	regmap_write(rt5682->regmap, RT5682_DEPOP_1, 0x0069);
+	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0300);
+	regmap_write(rt5682->regmap, RT5682_GLB_CLK, 0x8000);
+	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0100);
 	regmap_write(rt5682->regmap, RT5682_CHOP_DAC, 0x3000);
-	regmap_write(rt5682->regmap, RT5682_HP_CTRL_2, 0x6000);
-	regmap_write(rt5682->regmap, RT5682_HP_CHARGE_PUMP_1, 0x0f26);
-	regmap_write(rt5682->regmap, RT5682_CALIB_ADC_CTRL, 0x7f05);
-	regmap_write(rt5682->regmap, RT5682_STO1_ADC_MIXER, 0x686c);
-	regmap_write(rt5682->regmap, RT5682_CAL_REC, 0x0d0d);
-	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_9, 0x000f);
-	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x8d01);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_2, 0x0321);
 	regmap_write(rt5682->regmap, RT5682_HP_LOGIC_CTRL_2, 0x0004);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_1, 0x7c00);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_3, 0x06a1);
-	regmap_write(rt5682->regmap, RT5682_A_DAC1_MUX, 0x0311);
-	regmap_write(rt5682->regmap, RT5682_RESET_HPF_CTRL, 0x0000);
-	regmap_write(rt5682->regmap, RT5682_ADC_STO1_HP_CTRL_1, 0x3320);
+	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_1, 0x7c00);
 
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_1, 0xfc00);
 
@@ -2490,7 +2478,7 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 		pr_err("HP Calibration Failure\n");
 
 	/* restore settings */
-	regmap_write(rt5682->regmap, RT5682_STO1_ADC_MIXER, 0xc0c4);
+	regmap_write(rt5682->regmap, RT5682_GLB_CLK, 0x0000);
 	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0000);
 
 	mutex_unlock(&rt5682->calibrate_mutex);
-- 
2.7.4
