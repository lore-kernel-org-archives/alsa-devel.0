From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: move set_pll to codec level" to
	the asoc tree
Date: Mon, 13 Mar 2017 16:56:30 +0000
Message-ID: <E1cnTGo-0004eL-4V@debutante>
References: <1489058572-11917-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E610B266B13
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:56:45 +0100 (CET)
In-Reply-To: <1489058572-11917-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: move set_pll to codec level

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ccd00d5911ce1e144c79799f3d105961a11e4009 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 9 Mar 2017 19:31:13 +0800
Subject: [PATCH] ASoC: rt5665: move set_pll to codec level

Move set_pll function to codec level and people can use it at both
codec and dai level. Also, lower case "source" to keep it consistent.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 1baa9ce2648a..b36e217345f6 100644
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
2.11.0
