From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 3/3] ASoC: rt5670: move set_sysclk to codec
	level
Date: Wed, 28 Jun 2017 15:38:02 +0800
Message-ID: <1498635482-4970-3-git-send-email-bardliao@realtek.com>
References: <1498635482-4970-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 86764267065
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 09:38:18 +0200 (CEST)
In-Reply-To: <1498635482-4970-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Move set_sysclk to codec level and people can use it at both
codec and dai level.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 1146a96..7fa63ad 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2442,10 +2442,9 @@ static int rt5670_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static int rt5670_set_dai_sysclk(struct snd_soc_dai *dai,
-		int clk_id, unsigned int freq, int dir)
+static int rt5670_set_codec_sysclk(struct snd_soc_dai *dai, int clk_id,
+				   int source, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg_val = 0;
 
@@ -2469,7 +2468,7 @@ static int rt5670_set_dai_sysclk(struct snd_soc_dai *dai,
 	if (clk_id != RT5670_SCLK_S_RCCLK)
 		rt5670->sysclk_src = clk_id;
 
-	dev_dbg(dai->dev, "Sysclk is %dHz and clock id is %d\n", freq, clk_id);
+	dev_dbg(codec->dev, "Sysclk : %dHz clock id : %d\n", freq, clk_id);
 
 	return 0;
 }
@@ -2721,7 +2720,6 @@ static int rt5670_resume(struct snd_soc_codec *codec)
 static const struct snd_soc_dai_ops rt5670_aif_dai_ops = {
 	.hw_params = rt5670_hw_params,
 	.set_fmt = rt5670_set_dai_fmt,
-	.set_sysclk = rt5670_set_dai_sysclk,
 	.set_tdm_slot = rt5670_set_tdm_slot,
 	.set_pll = rt5670_set_dai_pll,
 };
@@ -2774,6 +2772,7 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5670 = {
 	.resume = rt5670_resume,
 	.set_bias_level = rt5670_set_bias_level,
 	.idle_bias_off = true,
+	.set_sysclk = rt5670_set_codec_sysclk,
 	.component_driver = {
 		.controls		= rt5670_snd_controls,
 		.num_controls		= ARRAY_SIZE(rt5670_snd_controls),
-- 
2.7.4
