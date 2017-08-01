From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Add the delay time to correct
	the calibration
Date: Tue, 1 Aug 2017 19:14:02 +0800
Message-ID: <1501586042-15589-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 03C1726691A
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 13:14:10 +0200 (CEST)
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

The patch adds the delay time to correct the calibration.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 9704eed..7bbfb18 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3058,6 +3058,7 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_3, 0x018c);
 	regmap_write(rt5663->regmap, RT5663_HP_CHARGE_PUMP_1, 0x1e32);
 	regmap_write(rt5663->regmap, RT5663_DACREF_LDO, 0x3b0b);
+	msleep(40);
 	regmap_write(rt5663->regmap, RT5663_STO_DAC_MIXER, 0x0000);
 	regmap_write(rt5663->regmap, RT5663_BYPASS_STO_DAC, 0x000c);
 	regmap_write(rt5663->regmap, RT5663_HP_BIAS, 0xafaa);
-- 
2.7.4
