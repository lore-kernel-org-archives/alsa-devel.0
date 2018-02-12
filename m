From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: dma-sh7760: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:31:29 +0000
Message-ID: <E1elDGb-0003LE-Tg@debutante>
References: <87h8rrgb2p.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A1EC0267857
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:31:33 +0100 (CET)
In-Reply-To: <87h8rrgb2p.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: sh: dma-sh7760: replace platform to component

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

>From eb5d510c869b95d3e219d4b01156f9095ec162f6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:43:10 +0000
Subject: [PATCH] ASoC: sh: dma-sh7760: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/dma-sh7760.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 1e7d417b53ef..2dc3b762fdd9 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -320,14 +320,15 @@ static int camelot_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static const struct snd_soc_platform_driver sh7760_soc_platform = {
+static const struct snd_soc_component_driver sh7760_soc_component = {
 	.ops		= &camelot_pcm_ops,
 	.pcm_new	= camelot_pcm_new,
 };
 
 static int sh7760_soc_platform_probe(struct platform_device *pdev)
 {
-	return devm_snd_soc_register_platform(&pdev->dev, &sh7760_soc_platform);
+	return devm_snd_soc_register_component(&pdev->dev, &sh7760_soc_component,
+					       NULL, 0);
 }
 
 static struct platform_driver sh7760_pcm_driver = {
-- 
2.16.1
