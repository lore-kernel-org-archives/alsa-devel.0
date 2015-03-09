From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5670: Revert Keep sysclk on patch
Date: Mon, 9 Mar 2015 16:55:22 +0800
Message-ID: <1425891323-21445-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B8A62605C4
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 09:55:56 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The "Keep sysclk on if JD func is used" patch force enable/disable
pin in rt5670_set_dai_sysclk. But some machine driver call it in
dapm widget event. It will cause kernel crash.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 592f961..32cd266 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2273,13 +2273,6 @@ static int rt5670_set_dai_sysclk(struct snd_soc_dai *dai,
 	if (freq == rt5670->sysclk && clk_id == rt5670->sysclk_src)
 		return 0;
 
-	if (rt5670->pdata.jd_mode) {
-		if (clk_id == RT5670_SCLK_S_PLL1)
-			snd_soc_dapm_force_enable_pin(&codec->dapm, "PLL1");
-		else
-			snd_soc_dapm_disable_pin(&codec->dapm, "PLL1");
-		snd_soc_dapm_sync(&codec->dapm);
-	}
 	switch (clk_id) {
 	case RT5670_SCLK_S_MCLK:
 		reg_val |= RT5670_SCLK_SRC_MCLK;
@@ -2724,10 +2717,6 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 	}
 
 	if (rt5670->pdata.jd_mode) {
-		regmap_update_bits(rt5670->regmap, RT5670_GLB_CLK,
-				   RT5670_SCLK_SRC_MASK, RT5670_SCLK_SRC_RCCLK);
-		rt5670->sysclk = 0;
-		rt5670->sysclk_src = RT5670_SCLK_S_RCCLK;
 		regmap_update_bits(rt5670->regmap, RT5670_PWR_ANLG1,
 				   RT5670_PWR_MB, RT5670_PWR_MB);
 		regmap_update_bits(rt5670->regmap, RT5670_PWR_ANLG2,
-- 
1.8.1.1.439.g50a6b54
