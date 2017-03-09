From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v3 2/2] ASoC: rt5665: move set_sysclk to codec
	level
Date: Thu, 9 Mar 2017 19:31:14 +0800
Message-ID: <1489059074-12046-2-git-send-email-bardliao@realtek.com>
References: <1489059074-12046-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 0437D266928
 for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2017 12:31:24 +0100 (CET)
In-Reply-To: <1489059074-12046-1-git-send-email-bardliao@realtek.com>
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

Move set_sysclk to codec level and people can use it at both
codec and dai level.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
v3: remove change of machine driver which is done accidentally in v2.
---
 sound/soc/codecs/rt5665.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index b36e217..1d00c60 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4188,10 +4188,9 @@ static int rt5665_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static int rt5665_set_dai_sysclk(struct snd_soc_dai *dai,
-		int clk_id, unsigned int freq, int dir)
+static int rt5665_set_codec_sysclk(struct snd_soc_codec *codec, int clk_id,
+				   int source, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
 	struct rt5665_priv *rt5665 = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg_val = 0;
 
@@ -4217,7 +4216,7 @@ static int rt5665_set_dai_sysclk(struct snd_soc_dai *dai,
 	rt5665->sysclk = freq;
 	rt5665->sysclk_src = clk_id;
 
-	dev_dbg(dai->dev, "Sysclk is %dHz and clock id is %d\n", freq, clk_id);
+	dev_dbg(codec->dev, "Sysclk is %dHz and clock id is %d\n", freq, clk_id);
 
 	return 0;
 }
@@ -4401,7 +4400,6 @@ static int rt5665_resume(struct snd_soc_codec *codec)
 static const struct snd_soc_dai_ops rt5665_aif_dai_ops = {
 	.hw_params = rt5665_hw_params,
 	.set_fmt = rt5665_set_dai_fmt,
-	.set_sysclk = rt5665_set_dai_sysclk,
 	.set_tdm_slot = rt5665_set_tdm_slot,
 	.set_bclk_ratio = rt5665_set_bclk_ratio,
 };
@@ -4512,6 +4510,7 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5665 = {
 		.dapm_routes = rt5665_dapm_routes,
 		.num_dapm_routes = ARRAY_SIZE(rt5665_dapm_routes),
 	},
+	.set_sysclk = rt5665_set_codec_sysclk,
 	.set_pll = rt5665_set_codec_pll,
 };
 
-- 
2.7.4
