From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: kirkwood: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:29:19 +0000
Message-ID: <E1elDEV-00035H-By@debutante>
References: <87vag7ew8f.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 37F4A267528
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:29:23 +0100 (CET)
In-Reply-To: <87vag7ew8f.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: kirkwood: replace platform to component

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

>From f98fc0f8154ed17a00a588f1a95f02cb3e33b0d0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:48:03 +0000
Subject: [PATCH] ASoC: kirkwood: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/kirkwood/kirkwood-dma.c |  3 ++-
 sound/soc/kirkwood/kirkwood-i2s.c | 20 ++------------------
 sound/soc/kirkwood/kirkwood.h     |  4 +++-
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 505b0ff03c3b..c6a58520d377 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -318,7 +318,8 @@ static void kirkwood_dma_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-const struct snd_soc_platform_driver kirkwood_soc_platform = {
+const struct snd_soc_component_driver kirkwood_soc_component = {
+	.name		= DRV_NAME,
 	.ops		= &kirkwood_dma_ops,
 	.pcm_new	= kirkwood_dma_new,
 	.pcm_free	= kirkwood_dma_free_dma_buffers,
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 105a73cc5158..9a2777b72dcd 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -26,8 +26,6 @@
 
 #include "kirkwood.h"
 
-#define DRV_NAME	"mvebu-audio"
-
 #define KIRKWOOD_I2S_FORMATS \
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE | \
@@ -524,10 +522,6 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
     },
 };
 
-static const struct snd_soc_component_driver kirkwood_i2s_component = {
-	.name		= DRV_NAME,
-};
-
 static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct kirkwood_asoc_platform_data *data = pdev->dev.platform_data;
@@ -601,24 +595,17 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_128;
 	}
 
-	err = snd_soc_register_component(&pdev->dev, &kirkwood_i2s_component,
+	err = devm_snd_soc_register_component(&pdev->dev, &kirkwood_soc_component,
 					 soc_dai, 2);
 	if (err) {
 		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
 		goto err_component;
 	}
 
-	err = snd_soc_register_platform(&pdev->dev, &kirkwood_soc_platform);
-	if (err) {
-		dev_err(&pdev->dev, "snd_soc_register_platform failed\n");
-		goto err_platform;
-	}
-
 	kirkwood_i2s_init(priv);
 
 	return 0;
- err_platform:
-	snd_soc_unregister_component(&pdev->dev);
+
  err_component:
 	if (!IS_ERR(priv->extclk))
 		clk_disable_unprepare(priv->extclk);
@@ -631,9 +618,6 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 {
 	struct kirkwood_dma_data *priv = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_platform(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
-
 	if (!IS_ERR(priv->extclk))
 		clk_disable_unprepare(priv->extclk);
 	clk_disable_unprepare(priv->clk);
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 783cb1a4f30e..c13ee5f69446 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -12,6 +12,8 @@
 #ifndef _KIRKWOOD_AUDIO_H
 #define _KIRKWOOD_AUDIO_H
 
+#define DRV_NAME	"mvebu-audio"
+
 #define KIRKWOOD_RECORD_WIN			0
 #define KIRKWOOD_PLAYBACK_WIN			1
 #define KIRKWOOD_MAX_AUDIO_WIN			2
@@ -143,6 +145,6 @@ struct kirkwood_dma_data {
 	int burst;
 };
 
-extern const struct snd_soc_platform_driver kirkwood_soc_platform;
+extern const struct snd_soc_component_driver kirkwood_soc_component;
 
 #endif
-- 
2.16.1
