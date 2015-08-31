From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-asoc-card: put ASRC OF node in case
	of unknown device" to the asoc tree
Date: Mon, 31 Aug 2015 16:09:27 +0100
Message-ID: <E1ZWQi7-0001Eq-R2@finisterre>
References: <55E46DA0.2080500@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BCF5260494
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 17:09:55 +0200 (CEST)
In-Reply-To: <55E46DA0.2080500@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maciej Szmigiero <mail@maciej.szmigiero.name>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-asoc-card: put ASRC OF node in case of unknown device

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

>From 6bd3c6f75e0f9baddbf1196a7e3fceabb50c7e3c Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Mon, 31 Aug 2015 17:07:12 +0200
Subject: [PATCH] ASoC: fsl-asoc-card: put ASRC OF node in case of unknown
 device

In case of unknown DT compatible device the ASRC OF node
possibly acquired earlier by of_parse_phandle() has
to be put before returning from probe method.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 5aeb6ed..96f55ae 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -488,7 +488,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto asrc_fail;
 	}
 
 	/* Common settings for corresponding Freescale CPU DAI driver */
-- 
2.5.0
