From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-ssi: add check on platform_get_irq
	return value" to the asoc tree
Date: Fri, 07 Jul 2017 13:51:43 +0100
Message-ID: <E1dTSjX-0002kF-8h@finisterre>
References: <20170630221735.GA17951@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AE472671AE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jul 2017 14:52:23 +0200 (CEST)
In-Reply-To: <20170630221735.GA17951@embeddedgus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: imx-ssi: add check on platform_get_irq return value

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

>From ae1fbdff6dbcdfee9daee69fa1e7d26d1f31d1c7 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Fri, 30 Jun 2017 17:17:35 -0500
Subject: [PATCH] ASoC: imx-ssi: add check on platform_get_irq return value

Check return value from call to platform_get_irq(),
so in case of failure print error message and propagate
the return value.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-ssi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index b95132e2f9dc..06790615e04e 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -527,6 +527,10 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi->irq = platform_get_irq(pdev, 0);
+	if (ssi->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", ssi->irq);
+		return ssi->irq;
+	}
 
 	ssi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssi->clk)) {
-- 
2.13.2
