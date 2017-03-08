From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 6/8] ASoC: rt5665: move set_pll to codec level
Date: Wed, 8 Mar 2017 19:05:34 +0800
Message-ID: <1488971136-19100-6-git-send-email-bardliao@realtek.com>
References: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E7FF266A33
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:05:51 +0100 (CET)
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

Move set_pll function to codec level and people can use it at both
codec and dai level.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index ca6aa66..2db039d 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4163,10 +4163,10 @@ static int rt5665_set_dai_sysclk(struct snd_soc_dai *dai,
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
@@ -4399,7 +4399,6 @@ static const struct snd_soc_dai_ops rt5665_aif_dai_ops = {
 	.set_fmt = rt5665_set_dai_fmt,
 	.set_sysclk = rt5665_set_dai_sysclk,
 	.set_tdm_slot = rt5665_set_tdm_slot,
-	.set_pll = rt5665_set_dai_pll,
 	.set_bclk_ratio = rt5665_set_bclk_ratio,
 };
 
@@ -4508,7 +4507,8 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5665 = {
 		.num_dapm_widgets = ARRAY_SIZE(rt5665_dapm_widgets),
 		.dapm_routes = rt5665_dapm_routes,
 		.num_dapm_routes = ARRAY_SIZE(rt5665_dapm_routes),
-	}
+	},
+	.set_pll = rt5665_set_codec_pll,
 };
 
 
-- 
2.7.4
