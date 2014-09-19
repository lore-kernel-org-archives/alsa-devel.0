From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5645: Minor coding style modify
Date: Fri, 19 Sep 2014 19:15:44 +0800
Message-ID: <1411125345-16935-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 14E29261A50
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 13:16:19 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Minor coding style modify

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a7762d0..dfbe74a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1838,7 +1838,7 @@ static int rt5645_hw_params(struct snd_pcm_substream *substream,
 			RT5645_I2S_DL_MASK, val_len);
 		snd_soc_update_bits(codec, RT5645_ADDA_CLK1, mask_clk, val_clk);
 		break;
-	case  RT5645_AIF2:
+	case RT5645_AIF2:
 		mask_clk = RT5645_I2S_BCLK_MS2_MASK | RT5645_I2S_PD2_MASK;
 		val_clk = bclk_ms << RT5645_I2S_BCLK_MS2_SFT |
 			pre_div << RT5645_I2S_PD2_SFT;
@@ -1983,7 +1983,7 @@ static int rt5645_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 			snd_soc_update_bits(codec, RT5645_GLB_CLK,
 				RT5645_PLL1_SRC_MASK, RT5645_PLL1_SRC_BCLK1);
 			break;
-		case  RT5645_AIF2:
+		case RT5645_AIF2:
 			snd_soc_update_bits(codec, RT5645_GLB_CLK,
 				RT5645_PLL1_SRC_MASK, RT5645_PLL1_SRC_BCLK2);
 			break;
-- 
1.8.1.1.439.g50a6b54
