From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: move set_sysclk to codec level"
	to the asoc tree
Date: Wed, 18 Oct 2017 12:11:57 +0100
Message-ID: <E1e4mGT-0002ES-0b@debutante>
References: <1508152516-25767-3-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 00109266A73
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 13:12:10 +0200 (CEST)
In-Reply-To: <1508152516-25767-3-git-send-email-bardliao@realtek.com>
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

   ASoC: rt5659: move set_sysclk to codec level

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

>From fe01e5e8fae91b235ecf928f6bf0a90c17d74e36 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 16 Oct 2017 19:15:15 +0800
Subject: [PATCH] ASoC: rt5659: move set_sysclk to codec level

Move set_sysclk to codec level and people can use it at both
codec and dai level.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index fa66b11df8d4..09cfddb5e53d 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3385,10 +3385,9 @@ static int rt5659_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static int rt5659_set_dai_sysclk(struct snd_soc_dai *dai,
-		int clk_id, unsigned int freq, int dir)
+static int rt5659_set_codec_sysclk(struct snd_soc_codec *codec, int clk_id,
+				   int source, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
 	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg_val = 0;
 
@@ -3414,7 +3413,8 @@ static int rt5659_set_dai_sysclk(struct snd_soc_dai *dai,
 	rt5659->sysclk = freq;
 	rt5659->sysclk_src = clk_id;
 
-	dev_dbg(dai->dev, "Sysclk is %dHz and clock id is %d\n", freq, clk_id);
+	dev_dbg(codec->dev, "Sysclk is %dHz and clock id is %d\n",
+		freq, clk_id);
 
 	return 0;
 }
@@ -3666,7 +3666,6 @@ static int rt5659_resume(struct snd_soc_codec *codec)
 static const struct snd_soc_dai_ops rt5659_aif_dai_ops = {
 	.hw_params = rt5659_hw_params,
 	.set_fmt = rt5659_set_dai_fmt,
-	.set_sysclk = rt5659_set_dai_sysclk,
 	.set_tdm_slot = rt5659_set_tdm_slot,
 	.set_pll = rt5659_set_dai_pll,
 	.set_bclk_ratio = rt5659_set_bclk_ratio,
@@ -3747,6 +3746,7 @@ static const struct snd_soc_codec_driver soc_codec_dev_rt5659 = {
 		.dapm_routes		= rt5659_dapm_routes,
 		.num_dapm_routes	= ARRAY_SIZE(rt5659_dapm_routes),
 	},
+	.set_sysclk = rt5659_set_codec_sysclk,
 };
 
 
-- 
2.14.1
