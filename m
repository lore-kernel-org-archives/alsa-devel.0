From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: idma: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:53 +0000
Message-ID: <E1elDE5-00031n-CY@debutante>
References: <87po6few6d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3648D26744A
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:57 +0100 (CET)
In-Reply-To: <87po6few6d.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: idma: replace platform to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 17d619da7b4e6ee2b5b54a9e3e321679963afa4d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:49:08 +0000
Subject: [PATCH] ASoC: samsung: idma: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/idma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index a635df61f928..b1f09b942410 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -399,7 +399,7 @@ void idma_reg_addr_init(void __iomem *regs, dma_addr_t addr)
 }
 EXPORT_SYMBOL_GPL(idma_reg_addr_init);
 
-static const struct snd_soc_platform_driver asoc_idma_platform = {
+static const struct snd_soc_component_driver asoc_idma_platform = {
 	.ops = &idma_ops,
 	.pcm_new = idma_new,
 	.pcm_free = idma_free,
@@ -411,7 +411,8 @@ static int asoc_idma_platform_probe(struct platform_device *pdev)
 	if (idma_irq < 0)
 		return idma_irq;
 
-	return devm_snd_soc_register_platform(&pdev->dev, &asoc_idma_platform);
+	return devm_snd_soc_register_component(&pdev->dev, &asoc_idma_platform,
+					       NULL, 0);
 }
 
 static struct platform_driver asoc_idma_driver = {
-- 
2.16.1
