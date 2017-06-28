From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: move set_sysclk to codec level"
	to the asoc tree
Date: Wed, 28 Jun 2017 20:23:35 +0100
Message-ID: <E1dQIYp-0004Hr-1M@finisterre>
References: <1498635482-4970-3-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F85F2671BD
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 21:23:58 +0200 (CEST)
In-Reply-To: <1498635482-4970-3-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: move set_sysclk to codec level

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

>From 6c28ce3c425e32d372c7c6ee98d3c3711f13ad69 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 28 Jun 2017 15:38:02 +0800
Subject: [PATCH] ASoC: rt5670: move set_sysclk to codec level

Move set_sysclk to codec level and people can use it at both
codec and dai level.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 1146a968cb4d..7fa63ad366dd 100644
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
2.13.2
