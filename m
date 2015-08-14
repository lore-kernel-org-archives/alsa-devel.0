From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-asoc-card: Specify codec_dai_name
	for DAI links" to the asoc tree
Date: Fri, 14 Aug 2015 01:00:46 +0100
Message-ID: <E1ZQ2QQ-0003EJ-MB@finisterre>
References: <1439409972-56973-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE783264F33
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 02:00:55 +0200 (CEST)
In-Reply-To: <1439409972-56973-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-asoc-card: Specify codec_dai_name for DAI links

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

>From 114bb13968162451f5e1d7fe793f9eb7e0083d9a Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Wed, 12 Aug 2015 13:06:12 -0700
Subject: [PATCH] ASoC: fsl-asoc-card: Specify codec_dai_name for DAI links

The dev->name of CODEC might not be identical to its codec_dai_name,
so using dev->name to probe the CODEC dai is not a correct approach.

This patch specifies each supporting codec_dai_name instead of using
dev->name any more.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index de43887..040362f 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -407,6 +407,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	struct fsl_asoc_card_priv *priv;
 	struct i2c_client *codec_dev;
 	struct clk *codec_clk;
+	const char *codec_dai_name;
 	u32 width;
 	int ret;
 
@@ -459,6 +460,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 	/* Diversify the card configurations */
 	if (of_device_is_compatible(np, "fsl,imx-audio-cs42888")) {
+		codec_dai_name = "cs42888";
 		priv->card.set_bias_level = NULL;
 		priv->cpu_priv.sysclk_freq[TX] = priv->codec_priv.mclk_freq;
 		priv->cpu_priv.sysclk_freq[RX] = priv->codec_priv.mclk_freq;
@@ -467,9 +469,11 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.slot_width = 32;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-sgtl5000")) {
+		codec_dai_name = "sgtl5000";
 		priv->codec_priv.mclk_id = SGTL5000_SYSCLK;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8962")) {
+		codec_dai_name = "wm8962";
 		priv->card.set_bias_level = fsl_asoc_card_set_bias_level;
 		priv->codec_priv.mclk_id = WM8962_SYSCLK_MCLK;
 		priv->codec_priv.fll_id = WM8962_SYSCLK_FLL;
@@ -521,7 +525,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	/* Normal DAI Link */
 	priv->dai_link[0].cpu_of_node = cpu_np;
 	priv->dai_link[0].codec_of_node = codec_np;
-	priv->dai_link[0].codec_dai_name = codec_dev->name;
+	priv->dai_link[0].codec_dai_name = codec_dai_name;
 	priv->dai_link[0].platform_of_node = cpu_np;
 	priv->dai_link[0].dai_fmt = priv->dai_fmt;
 	priv->card.num_links = 1;
@@ -530,7 +534,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		/* DPCM DAI Links only if ASRC exsits */
 		priv->dai_link[1].cpu_of_node = asrc_np;
 		priv->dai_link[1].platform_of_node = asrc_np;
-		priv->dai_link[2].codec_dai_name = codec_dev->name;
+		priv->dai_link[2].codec_dai_name = codec_dai_name;
 		priv->dai_link[2].codec_of_node = codec_np;
 		priv->dai_link[2].cpu_of_node = cpu_np;
 		priv->dai_link[2].dai_fmt = priv->dai_fmt;
-- 
2.5.0
