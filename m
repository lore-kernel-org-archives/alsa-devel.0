From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uniphier: aio-dma: replace platform to
	component" to the asoc tree
Date: Tue, 13 Feb 2018 12:33:17 +0000
Message-ID: <E1elZlt-0008BZ-IA@debutante>
References: <878tbxlkbw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B019266C0E
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 13:33:22 +0100 (CET)
In-Reply-To: <878tbxlkbw.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uniphier: aio-dma: replace platform to component

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

>From 2b5803b95977d60f6e3c88672969b1da024fc3e8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 13 Feb 2018 02:02:39 +0000
Subject: [PATCH] ASoC: uniphier: aio-dma: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
index 22f122a42442..ef7bafa8e171 100644
--- a/sound/soc/uniphier/aio-dma.c
+++ b/sound/soc/uniphier/aio-dma.c
@@ -259,7 +259,7 @@ static void uniphier_aiodma_free(struct snd_pcm *pcm)
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
-static const struct snd_soc_platform_driver uniphier_soc_platform = {
+static const struct snd_soc_component_driver uniphier_soc_platform = {
 	.pcm_new   = uniphier_aiodma_new,
 	.pcm_free  = uniphier_aiodma_free,
 	.ops       = &uniphier_aiodma_ops,
@@ -313,6 +313,7 @@ int uniphier_aiodma_soc_register_platform(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return devm_snd_soc_register_platform(dev, &uniphier_soc_platform);
+	return devm_snd_soc_register_component(dev, &uniphier_soc_platform,
+					       NULL, 0);
 }
 EXPORT_SYMBOL_GPL(uniphier_aiodma_soc_register_platform);
-- 
2.16.1
