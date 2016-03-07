From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5640: Set PLL src according to
	source
Date: Mon, 7 Mar 2016 15:09:37 +0800
Message-ID: <1457334578-32302-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7972A2607F7
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:10:04 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

rt5640_set_dai_pll set pll source according to given source and
dai id. However, the pll source should be set according to given
source only.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5640.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 6cd84fb..863c190 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1902,21 +1902,12 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 			RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_MCLK);
 		break;
 	case RT5640_PLL1_S_BCLK1:
+		snd_soc_update_bits(codec, RT5640_GLB_CLK,
+			RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_BCLK1);
+		break;
 	case RT5640_PLL1_S_BCLK2:
-		dai_sel = get_sdp_info(codec, dai->id);
-		if (dai_sel < 0) {
-			dev_err(codec->dev,
-				"Failed to get sdp info: %d\n", dai_sel);
-			return -EINVAL;
-		}
-		if (dai_sel & RT5640_U_IF1) {
-			snd_soc_update_bits(codec, RT5640_GLB_CLK,
-				RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_BCLK1);
-		}
-		if (dai_sel & RT5640_U_IF2) {
-			snd_soc_update_bits(codec, RT5640_GLB_CLK,
-				RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_BCLK2);
-		}
+		snd_soc_update_bits(codec, RT5640_GLB_CLK,
+			RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_BCLK2);
 		break;
 	default:
 		dev_err(codec->dev, "Unknown PLL source %d\n", source);
-- 
1.8.1.1.439.g50a6b54
