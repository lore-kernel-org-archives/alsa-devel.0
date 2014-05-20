From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 3/3] ASoC: rt5640: Add the function
	"get_clk_info" to RL6231 shared support
Date: Tue, 20 May 2014 15:01:55 +0800
Message-ID: <1400569315-12221-3-git-send-email-oder_chiou@realtek.com>
References: <1400569315-12221-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FDC42619F5
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 09:02:21 +0200 (CEST)
In-Reply-To: <1400569315-12221-1-git-send-email-oder_chiou@realtek.com>
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

The patch adds the function "get_clk_info" to RL6231 shared support.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rl6231.c | 16 ++++++++++++++++
 sound/soc/codecs/rl6231.h |  1 +
 sound/soc/codecs/rt5640.c | 17 +----------------
 sound/soc/codecs/rt5645.c | 17 +----------------
 sound/soc/codecs/rt5651.c | 17 +----------------
 5 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 289024b..7b82fbe 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -131,6 +131,22 @@ code_find:
 }
 EXPORT_SYMBOL_GPL(rl6231_pll_calc);
 
+int rl6231_get_clk_info(int sclk, int rate)
+{
+	int i, pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
+
+	if (sclk <= 0 || rate <= 0)
+		return -EINVAL;
+
+	rate = rate << 8;
+	for (i = 0; i < ARRAY_SIZE(pd); i++)
+		if (sclk == rate * pd[i])
+			return i;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(rl6231_get_clk_info);
+
 MODULE_DESCRIPTION("RL6231 class device shared support");
 MODULE_AUTHOR("Oder Chiou <oder_chiou@realtek.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/rl6231.h b/sound/soc/codecs/rl6231.h
index efdfc86..0f7b057 100644
--- a/sound/soc/codecs/rl6231.h
+++ b/sound/soc/codecs/rl6231.h
@@ -29,5 +29,6 @@ struct rl6231_pll_code {
 int rl6231_calc_dmic_clk(int rate);
 int rl6231_pll_calc(const unsigned int freq_in,
 	const unsigned int freq_out, struct rl6231_pll_code *pll_code);
+int rl6231_get_clk_info(int sclk, int rate);
 
 #endif /* __RL6231_H__ */
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index bdc1a94..de80e89 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1626,21 +1626,6 @@ static int get_sdp_info(struct snd_soc_codec *codec, int dai_id)
 	return ret;
 }
 
-static int get_clk_info(int sclk, int rate)
-{
-	int i, pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
-
-	if (sclk <= 0 || rate <= 0)
-		return -EINVAL;
-
-	rate = rate << 8;
-	for (i = 0; i < ARRAY_SIZE(pd); i++)
-		if (sclk == rate * pd[i])
-			return i;
-
-	return -EINVAL;
-}
-
 static int rt5640_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -1650,7 +1635,7 @@ static int rt5640_hw_params(struct snd_pcm_substream *substream,
 	int dai_sel, pre_div, bclk_ms, frame_size;
 
 	rt5640->lrck[dai->id] = params_rate(params);
-	pre_div = get_clk_info(rt5640->sysclk, rt5640->lrck[dai->id]);
+	pre_div = rl6231_get_clk_info(rt5640->sysclk, rt5640->lrck[dai->id]);
 	if (pre_div < 0) {
 		dev_err(codec->dev, "Unsupported clock setting %d for DAI %d\n",
 			rt5640->lrck[dai->id], dai->id);
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index ee6db7c..02147be 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1786,21 +1786,6 @@ static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
 	{ "SPOR", NULL, "SPK amp" },
 };
 
-static int get_clk_info(int sclk, int rate)
-{
-	int i, pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
-
-	if (sclk <= 0 || rate <= 0)
-		return -EINVAL;
-
-	rate = rate << 8;
-	for (i = 0; i < ARRAY_SIZE(pd); i++)
-		if (sclk == rate * pd[i])
-			return i;
-
-	return -EINVAL;
-}
-
 static int rt5645_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -1810,7 +1795,7 @@ static int rt5645_hw_params(struct snd_pcm_substream *substream,
 	int pre_div, bclk_ms, frame_size;
 
 	rt5645->lrck[dai->id] = params_rate(params);
-	pre_div = get_clk_info(rt5645->sysclk, rt5645->lrck[dai->id]);
+	pre_div = rl6231_get_clk_info(rt5645->sysclk, rt5645->lrck[dai->id]);
 	if (pre_div < 0) {
 		dev_err(codec->dev, "Unsupported clock setting\n");
 		return -EINVAL;
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index a627a1f..ea4b1c6 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1338,21 +1338,6 @@ static const struct snd_soc_dapm_route rt5651_dapm_routes[] = {
 	{"PDMR", NULL, "PDM R Mux"},
 };
 
-static int get_clk_info(int sclk, int rate)
-{
-	int i, pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
-
-	if (sclk <= 0 || rate <= 0)
-		return -EINVAL;
-
-	rate = rate << 8;
-	for (i = 0; i < ARRAY_SIZE(pd); i++)
-		if (sclk == rate * pd[i])
-			return i;
-
-	return -EINVAL;
-}
-
 static int rt5651_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -1362,7 +1347,7 @@ static int rt5651_hw_params(struct snd_pcm_substream *substream,
 	int pre_div, bclk_ms, frame_size;
 
 	rt5651->lrck[dai->id] = params_rate(params);
-	pre_div = get_clk_info(rt5651->sysclk, rt5651->lrck[dai->id]);
+	pre_div = rl6231_get_clk_info(rt5651->sysclk, rt5651->lrck[dai->id]);
 
 	if (pre_div < 0) {
 		dev_err(codec->dev, "Unsupported clock setting\n");
-- 
1.8.1.1.439.g50a6b54
