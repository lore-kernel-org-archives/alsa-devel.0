From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: move set_sysclk to codec level"
	to the asoc tree
Date: Mon, 13 Mar 2017 16:56:27 +0000
Message-ID: <E1cnTGl-0004dH-42@debutante>
References: <1489059074-12046-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6280F266CC6
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:56:46 +0100 (CET)
In-Reply-To: <1489059074-12046-2-git-send-email-bardliao@realtek.com>
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

   ASoC: rt5665: move set_sysclk to codec level

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

>From 28d2ca39be43fab0caee2f13d818504e9e802ef7 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 9 Mar 2017 19:31:14 +0800
Subject: [PATCH] ASoC: rt5665: move set_sysclk to codec level

Move set_sysclk to codec level and people can use it at both
codec and dai level.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index b36e217345f6..1d00c6078feb 100644
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
2.11.0
