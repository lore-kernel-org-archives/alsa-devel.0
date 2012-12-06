From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Store the DAI clock ID when
	setting
Date: Thu,  6 Dec 2012 18:18:00 +0900
Message-ID: <1354785480-21904-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 41F3E260307
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 10:18:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

So the code to suppress duplicate changes is effective.

Reported-by: Kyung Kwee Ryu <Kyung-Kwee.Ryu@wolfsonmicro.comyu@wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ef68f7a..dfaeca9 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1,3 +1,4 @@
+#define DEBUG
 /*
  * arizona.c - Wolfson Arizona class device shared support
  *
@@ -679,6 +680,9 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
+	int base = dai->driver->base;
 	int i, sr_val;
 
 	/*
@@ -699,14 +703,16 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 	case ARIZONA_CLK_SYSCLK:
 		snd_soc_update_bits(codec, ARIZONA_SAMPLE_RATE_1,
 				    ARIZONA_SAMPLE_RATE_1_MASK, sr_val);
-		snd_soc_update_bits(codec, base + ARIZONA_AIF_RATE_CTRL,
-				    ARIZONA_AIF1_RATE_MASK, 0);
+		if (base)
+			snd_soc_update_bits(codec, base + ARIZONA_AIF_RATE_CTRL,
+					    ARIZONA_AIF1_RATE_MASK, 0);
 		break;
 	case ARIZONA_CLK_ASYNCCLK:
 		snd_soc_update_bits(codec, ARIZONA_ASYNC_SAMPLE_RATE_1,
 				    ARIZONA_ASYNC_SAMPLE_RATE_MASK, sr_val);
-		snd_soc_update_bits(codec, base + ARIZONA_AIF_RATE_CTRL,
-				    ARIZONA_AIF1_RATE_MASK, 8);
+		if (base)
+			snd_soc_update_bits(codec, base + ARIZONA_AIF_RATE_CTRL,
+					    ARIZONA_AIF1_RATE_MASK, 8);
 		break;
 	default:
 		arizona_aif_err(dai, "Invalid clock %d\n", dai_priv->clk);
@@ -721,12 +727,10 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
 	int base = dai->driver->base;
 	const int *rates;
 	int i, ret;
-	int bclk, lrclk, wl, frame, sr_val;
+	int bclk, lrclk, wl, frame;
 
 	if (params_rate(params) % 8000)
 		rates = &arizona_44k1_bclk_rates[0];
@@ -754,7 +758,7 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	wl = snd_pcm_format_width(params_format(params));
 	frame = wl << ARIZONA_AIF1TX_WL_SHIFT | wl;
 
-	ret = arizona_hw_params_rate(codec, params, dai);
+	ret = arizona_hw_params_rate(substream, params, dai);
 	if (ret != 0)
 		return ret;
 
@@ -823,6 +827,8 @@ static int arizona_dai_set_sysclk(struct snd_soc_dai *dai,
 	routes[1].source = arizona_dai_clk_str(clk_id);
 	snd_soc_dapm_add_routes(&codec->dapm, routes, ARRAY_SIZE(routes));
 
+	dai_priv->clk = clk_id;
+
 	return snd_soc_dapm_sync(&codec->dapm);
 }
 
-- 
1.7.10.4
