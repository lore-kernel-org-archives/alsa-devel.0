From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2 1/2] ASoC: rt5665: move set_pll to codec
	level
Date: Thu, 9 Mar 2017 19:22:51 +0800
Message-ID: <1489058572-11917-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id BBE4B26720C
 for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2017 12:23:15 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Move set_pll function to codec level and people can use it at both
codec and dai level. Also, lower case "source" to keep it consistent.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 1baa9ce..b36e217 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4222,15 +4222,15 @@ static int rt5665_set_dai_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int rt5665_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int Source,
-			unsigned int freq_in, unsigned int freq_out)
+static int rt5665_set_codec_pll(struct snd_soc_codec *codec, int pll_id,
+				int source, unsigned int freq_in,
+				unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = dai->codec;
 	struct rt5665_priv *rt5665 = snd_soc_codec_get_drvdata(codec);
 	struct rl6231_pll_code pll_code;
 	int ret;
 
-	if (Source == rt5665->pll_src && freq_in == rt5665->pll_in &&
+	if (source == rt5665->pll_src && freq_in == rt5665->pll_in &&
 	    freq_out == rt5665->pll_out)
 		return 0;
 
@@ -4244,7 +4244,7 @@ static int rt5665_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int Source,
 		return 0;
 	}
 
-	switch (Source) {
+	switch (source) {
 	case RT5665_PLL1_S_MCLK:
 		snd_soc_update_bits(codec, RT5665_GLB_CLK,
 			RT5665_PLL1_SRC_MASK, RT5665_PLL1_SRC_MCLK);
@@ -4262,7 +4262,7 @@ static int rt5665_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int Source,
 				RT5665_PLL1_SRC_MASK, RT5665_PLL1_SRC_BCLK3);
 		break;
 	default:
-		dev_err(codec->dev, "Unknown PLL Source %d\n", Source);
+		dev_err(codec->dev, "Unknown PLL Source %d\n", source);
 		return -EINVAL;
 	}
 
@@ -4284,7 +4284,7 @@ static int rt5665_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int Source,
 
 	rt5665->pll_in = freq_in;
 	rt5665->pll_out = freq_out;
-	rt5665->pll_src = Source;
+	rt5665->pll_src = source;
 
 	return 0;
 }
@@ -4403,7 +4403,6 @@ static const struct snd_soc_dai_ops rt5665_aif_dai_ops = {
 	.set_fmt = rt5665_set_dai_fmt,
 	.set_sysclk = rt5665_set_dai_sysclk,
 	.set_tdm_slot = rt5665_set_tdm_slot,
-	.set_pll = rt5665_set_dai_pll,
 	.set_bclk_ratio = rt5665_set_bclk_ratio,
 };
 
@@ -4512,7 +4511,8 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5665 = {
 		.num_dapm_widgets = ARRAY_SIZE(rt5665_dapm_widgets),
 		.dapm_routes = rt5665_dapm_routes,
 		.num_dapm_routes = ARRAY_SIZE(rt5665_dapm_routes),
-	}
+	},
+	.set_pll = rt5665_set_codec_pll,
 };
 
 
-- 
2.7.4
