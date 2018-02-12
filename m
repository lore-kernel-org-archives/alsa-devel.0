From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: imx: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:29:33 +0000
Message-ID: <E1elDEj-00037w-VT@debutante>
References: <87zi5jew9x.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A73E2267475
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:29:37 +0100 (CET)
In-Reply-To: <87zi5jew9x.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsl: imx: replace platform to component

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

>From 1d0a01f2d4051bc62ba5e0d73ed99272414045ba Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:47:02 +0000
Subject: [PATCH] ASoC: fsl: imx: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-pcm-fiq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 4e5fefee111e..0578f3486847 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -341,7 +341,7 @@ static void imx_pcm_fiq_free(struct snd_pcm *pcm)
 	imx_pcm_free(pcm);
 }
 
-static const struct snd_soc_platform_driver imx_soc_platform_fiq = {
+static const struct snd_soc_component_driver imx_soc_component_fiq = {
 	.ops		= &imx_pcm_ops,
 	.pcm_new	= imx_pcm_fiq_new,
 	.pcm_free	= imx_pcm_fiq_free,
@@ -368,7 +368,8 @@ int imx_pcm_fiq_init(struct platform_device *pdev,
 	params->dma_params_tx->maxburst = 4;
 	params->dma_params_rx->maxburst = 6;
 
-	ret = snd_soc_register_platform(&pdev->dev, &imx_soc_platform_fiq);
+	ret = devm_snd_soc_register_component(&pdev->dev, &imx_soc_component_fiq,
+					      NULL, 0);
 	if (ret)
 		goto failed_register;
 
@@ -384,7 +385,6 @@ EXPORT_SYMBOL_GPL(imx_pcm_fiq_init);
 
 void imx_pcm_fiq_exit(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(imx_pcm_fiq_exit);
 
-- 
2.16.1
