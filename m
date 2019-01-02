From: <shumingf@realtek.com>
Subject: [PATCH] ASoC: rt5682: Fix recording no sound issue
Date: Wed, 2 Jan 2019 17:18:56 +0800
Message-ID: <1546420736-32405-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 10877267B1D
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2019 10:19:23 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, albertchen@realtek.com, bard.liao@intel.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

The ADC mixer setting needs to restore to default value
after calibration.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 34cfaf8..89c43b2 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2512,6 +2512,7 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0000);
 	regmap_write(rt5682->regmap, RT5682_CHOP_DAC, 0x2000);
 	regmap_write(rt5682->regmap, RT5682_CALIB_ADC_CTRL, 0x2005);
+	regmap_write(rt5682->regmap, RT5682_STO1_ADC_MIXER, 0xc0c4);
 
 	mutex_unlock(&rt5682->calibrate_mutex);
 
-- 
2.7.4
