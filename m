From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: move set_pll to codec level" to
	the asoc tree
Date: Wed, 18 Oct 2017 12:11:53 +0100
Message-ID: <E1e4mGP-0002DP-DW@debutante>
References: <1508152516-25767-4-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 01F83266FEA
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 13:12:10 +0200 (CEST)
In-Reply-To: <1508152516-25767-4-git-send-email-bardliao@realtek.com>
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

   ASoC: rt5659: move set_pll to codec level

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

>From c8a04b5de4bbdd0c7553aaa315c72722b10f0207 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 16 Oct 2017 19:15:16 +0800
Subject: [PATCH] ASoC: rt5659: move set_pll to codec level

Move set_pll function to codec level and people can use it at both
codec and dai level.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 09cfddb5e53d..07e7757417bc 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3419,15 +3419,15 @@ static int rt5659_set_codec_sysclk(struct snd_soc_codec *codec, int clk_id,
 	return 0;
 }
 
-static int rt5659_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int Source,
-			unsigned int freq_in, unsigned int freq_out)
+static int rt5659_set_codec_pll(struct snd_soc_codec *codec, int pll_id,
+				int source, unsigned int freq_in,
+				unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = dai->codec;
 	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
 	struct rl6231_pll_code pll_code;
 	int ret;
 
-	if (Source == rt5659->pll_src && freq_in == rt5659->pll_in &&
+	if (source == rt5659->pll_src && freq_in == rt5659->pll_in &&
 	    freq_out == rt5659->pll_out)
 		return 0;
 
@@ -3441,7 +3441,7 @@ static int rt5659_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int Source,
 		return 0;
 	}
 
-	switch (Source) {
+	switch (source) {
 	case RT5659_PLL1_S_MCLK:
 		snd_soc_update_bits(codec, RT5659_GLB_CLK,
 			RT5659_PLL1_SRC_MASK, RT5659_PLL1_SRC_MCLK);
@@ -3459,7 +3459,7 @@ static int rt5659_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int Source,
 				RT5659_PLL1_SRC_MASK, RT5659_PLL1_SRC_BCLK3);
 		break;
 	default:
-		dev_err(codec->dev, "Unknown PLL Source %d\n", Source);
+		dev_err(codec->dev, "Unknown PLL source %d\n", source);
 		return -EINVAL;
 	}
 
@@ -3481,7 +3481,7 @@ static int rt5659_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int Source,
 
 	rt5659->pll_in = freq_in;
 	rt5659->pll_out = freq_out;
-	rt5659->pll_src = Source;
+	rt5659->pll_src = source;
 
 	return 0;
 }
@@ -3667,7 +3667,6 @@ static const struct snd_soc_dai_ops rt5659_aif_dai_ops = {
 	.hw_params = rt5659_hw_params,
 	.set_fmt = rt5659_set_dai_fmt,
 	.set_tdm_slot = rt5659_set_tdm_slot,
-	.set_pll = rt5659_set_dai_pll,
 	.set_bclk_ratio = rt5659_set_bclk_ratio,
 };
 
@@ -3747,6 +3746,7 @@ static const struct snd_soc_codec_driver soc_codec_dev_rt5659 = {
 		.num_dapm_routes	= ARRAY_SIZE(rt5659_dapm_routes),
 	},
 	.set_sysclk = rt5659_set_codec_sysclk,
+	.set_pll = rt5659_set_codec_pll,
 };
 
 
-- 
2.14.1
