From: <shumingf@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5682: recording has no sound after
	booting
Date: Mon, 18 Mar 2019 15:17:42 +0800
Message-ID: <20190318071742.20134-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4067F80059
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 08:17:51 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, hou-hsun.lee@intel.com, hychao@google.com, lijen@google.com, albertchen@realtek.com, derek.fang@realtek.com, bard.liao@intel.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

If ASRC turns on, HW will use clk_dac as the reference clock
whether recording or playback.
Both of clk_dac and clk_adc should set proper clock while using ASRC.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index b98974edf6ad..86a7fa31c294 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1208,7 +1208,7 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component =
 		snd_soc_dapm_to_component(w->dapm);
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
-	int ref, val, reg, sft, mask, idx = -EINVAL;
+	int ref, val, reg, idx = -EINVAL;
 	static const int div_f[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48};
 	static const int div_o[] = {1, 2, 4, 6, 8, 12, 16, 24, 32, 48};
 
@@ -1222,15 +1222,10 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 
 	idx = rt5682_div_sel(rt5682, ref, div_f, ARRAY_SIZE(div_f));
 
-	if (w->shift == RT5682_PWR_ADC_S1F_BIT) {
+	if (w->shift == RT5682_PWR_ADC_S1F_BIT)
 		reg = RT5682_PLL_TRACK_3;
-		sft = RT5682_ADC_OSR_SFT;
-		mask = RT5682_ADC_OSR_MASK;
-	} else {
+	else
 		reg = RT5682_PLL_TRACK_2;
-		sft = RT5682_DAC_OSR_SFT;
-		mask = RT5682_DAC_OSR_MASK;
-	}
 
 	snd_soc_component_update_bits(component, reg,
 		RT5682_FILTER_CLK_DIV_MASK, idx << RT5682_FILTER_CLK_DIV_SFT);
@@ -1242,7 +1237,8 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 	}
 
 	snd_soc_component_update_bits(component, RT5682_ADDA_CLK_1,
-		mask, idx << sft);
+		RT5682_ADC_OSR_MASK | RT5682_DAC_OSR_MASK,
+		(idx << RT5682_ADC_OSR_SFT) | (idx << RT5682_DAC_OSR_SFT));
 
 	return 0;
 }
-- 
2.21.0
