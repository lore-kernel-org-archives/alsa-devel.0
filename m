From: <shumingf@realtek.com>
Subject: [PATCH 1/5] ASoC: rt5682: Update calibration function
Date: Tue, 18 Sep 2018 19:50:38 +0800
Message-ID: <1537271438-5540-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 19209267819
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 13:50:54 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, albertchen@realtek.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

The ADC/DAC path should open while calibration process.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 731c6a8..31ec7c0 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2451,17 +2451,22 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 	mutex_lock(&rt5682->calibrate_mutex);
 
 	rt5682_reset(rt5682->regmap);
-	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xa2bf);
+	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xa2af);
 	usleep_range(15000, 20000);
-	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xf2bf);
+	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xf2af);
 	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0300);
 	regmap_write(rt5682->regmap, RT5682_GLB_CLK, 0x8000);
 	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0100);
+	regmap_write(rt5682->regmap, RT5682_HP_IMP_SENS_CTRL_19, 0x3800);
 	regmap_write(rt5682->regmap, RT5682_CHOP_DAC, 0x3000);
+	regmap_write(rt5682->regmap, RT5682_CALIB_ADC_CTRL, 0x7005);
+	regmap_write(rt5682->regmap, RT5682_STO1_ADC_MIXER, 0x686c);
+	regmap_write(rt5682->regmap, RT5682_CAL_REC, 0x0d0d);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_2, 0x0321);
 	regmap_write(rt5682->regmap, RT5682_HP_LOGIC_CTRL_2, 0x0004);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_1, 0x7c00);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_3, 0x06a1);
+	regmap_write(rt5682->regmap, RT5682_A_DAC1_MUX, 0x0311);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_1, 0x7c00);
 
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_1, 0xfc00);
@@ -2478,8 +2483,12 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 		pr_err("HP Calibration Failure\n");
 
 	/* restore settings */
+	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0x02af);
+	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0080);
 	regmap_write(rt5682->regmap, RT5682_GLB_CLK, 0x0000);
 	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0000);
+	regmap_write(rt5682->regmap, RT5682_CHOP_DAC, 0x2000);
+	regmap_write(rt5682->regmap, RT5682_CALIB_ADC_CTRL, 0x2005);
 
 	mutex_unlock(&rt5682->calibrate_mutex);
 
-- 
2.7.4
