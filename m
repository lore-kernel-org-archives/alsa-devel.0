From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da732x: Merge da732x_dai1_ops and
	da732x_dai2_ops" to the asoc tree
Date: Wed, 15 Jul 2015 12:55:41 +0100
Message-ID: <E1ZFLHp-0006dB-2Q@debutante>
References: <1436925093.19790.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 12296265B88
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 13:55:52 +0200 (CEST)
In-Reply-To: <1436925093.19790.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da732x: Merge da732x_dai1_ops and da732x_dai2_ops

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

>From a01da00cbccc162a86c78f61ed4ca55dad35440f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 15 Jul 2015 09:51:33 +0800
Subject: [PATCH] ASoC: da732x: Merge da732x_dai1_ops and da732x_dai2_ops

da732x_dai1_ops is identical to da732x_dai2_ops, so merge them to
da732x_dai_ops. The da732x_dai_ops is not modified after initialization,
so make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da732x.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 207523686bd5..760935ac9fd9 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1196,13 +1196,7 @@ static int da732x_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 #define	DA732X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops da732x_dai1_ops = {
-	.hw_params	= da732x_hw_params,
-	.set_fmt	= da732x_set_dai_fmt,
-	.set_sysclk	= da732x_set_dai_sysclk,
-};
-
-static struct snd_soc_dai_ops da732x_dai2_ops = {
+static const struct snd_soc_dai_ops da732x_dai_ops = {
 	.hw_params	= da732x_hw_params,
 	.set_fmt	= da732x_set_dai_fmt,
 	.set_sysclk	= da732x_set_dai_sysclk,
@@ -1227,7 +1221,7 @@ static struct snd_soc_dai_driver da732x_dai[] = {
 			.rates = DA732X_RATES,
 			.formats = DA732X_FORMATS,
 		},
-		.ops = &da732x_dai1_ops,
+		.ops = &da732x_dai_ops,
 	},
 	{
 		.name	= "DA732X_AIFB",
@@ -1247,7 +1241,7 @@ static struct snd_soc_dai_driver da732x_dai[] = {
 			.rates = DA732X_RATES,
 			.formats = DA732X_FORMATS,
 		},
-		.ops = &da732x_dai2_ops,
+		.ops = &da732x_dai_ops,
 	},
 };
 
-- 
2.1.4
