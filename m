From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-asoc-card: add wm8960 support" to
	the asoc tree
Date: Sat, 15 Aug 2015 09:22:11 -0700
Message-ID: <E1ZQeDj-0007RA-4B@finisterre>
References: <d873df2b23a6d39099b3c62db8901d78a60d9362.1439550574.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C94426510A
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 18:22:21 +0200 (CEST)
In-Reply-To: <d873df2b23a6d39099b3c62db8901d78a60d9362.1439550574.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-asoc-card: add wm8960 support

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

>From 50e0ee01382b8e08289d3db209738c5856fd25cf Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Fri, 14 Aug 2015 19:11:09 +0800
Subject: [PATCH] ASoC: fsl-asoc-card: add wm8960 support

add wm8960 support for fsl-asoc-card

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 040362f..5aeb6ed 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -23,6 +23,7 @@
 
 #include "../codecs/sgtl5000.h"
 #include "../codecs/wm8962.h"
+#include "../codecs/wm8960.h"
 
 #define RX 0
 #define TX 1
@@ -479,6 +480,12 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->codec_priv.fll_id = WM8962_SYSCLK_FLL;
 		priv->codec_priv.pll_id = WM8962_FLL;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8960")) {
+		codec_dai_name = "wm8960-hifi";
+		priv->card.set_bias_level = fsl_asoc_card_set_bias_level;
+		priv->codec_priv.fll_id = WM8960_SYSCLK_AUTO;
+		priv->codec_priv.pll_id = WM8960_SYSCLK_AUTO;
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		return -EINVAL;
@@ -582,6 +589,7 @@ static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-cs42888", },
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
 	{ .compatible = "fsl,imx-audio-wm8962", },
+	{ .compatible = "fsl,imx-audio-wm8960", },
 	{}
 };
 
-- 
2.5.0
