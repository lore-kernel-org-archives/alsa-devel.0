From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 7/8] ASoC: rt5665: move set_sysclk to codec
	level
Date: Wed, 8 Mar 2017 19:05:35 +0800
Message-ID: <1488971136-19100-7-git-send-email-bardliao@realtek.com>
References: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E5712670A1
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:05:52 +0100 (CET)
In-Reply-To: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
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
 sound/soc/codecs/rt5665.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 2db039d..52148fc 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4129,10 +4129,9 @@ static int rt5665_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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
 
@@ -4397,7 +4396,6 @@ static int rt5665_resume(struct snd_soc_codec *codec)
 static const struct snd_soc_dai_ops rt5665_aif_dai_ops = {
 	.hw_params = rt5665_hw_params,
 	.set_fmt = rt5665_set_dai_fmt,
-	.set_sysclk = rt5665_set_dai_sysclk,
 	.set_tdm_slot = rt5665_set_tdm_slot,
 	.set_bclk_ratio = rt5665_set_bclk_ratio,
 };
@@ -4508,6 +4506,7 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5665 = {
 		.dapm_routes = rt5665_dapm_routes,
 		.num_dapm_routes = ARRAY_SIZE(rt5665_dapm_routes),
 	},
+	.set_sysclk = rt5665_set_codec_sysclk,
 	.set_pll = rt5665_set_codec_pll,
 };
 
-- 
2.7.4
