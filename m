From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: rsnd: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:31:38 +0000
Message-ID: <E1elDGk-0003M6-R6@debutante>
References: <87inc7gb37.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A4D4C267872
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:31:42 +0100 (CET)
In-Reply-To: <87inc7gb37.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: sh: rsnd: replace platform to component

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

>From 019ea01b7c510803d2f1ca8315916084887463c9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:42:53 +0000
Subject: [PATCH] ASoC: sh: rsnd: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 64d5ecb86528..b4007669c704 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1337,7 +1337,7 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 }
 
 /*
- *		snd_soc_platform
+ *		snd_soc_component
  */
 
 #define PREALLOC_BUFFER		(32 * 1024)
@@ -1364,12 +1364,9 @@ static int rsnd_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
 }
 
-static const struct snd_soc_platform_driver rsnd_soc_platform = {
+static const struct snd_soc_component_driver rsnd_soc_component = {
 	.ops		= &rsnd_pcm_ops,
 	.pcm_new	= rsnd_pcm_new,
-};
-
-static const struct snd_soc_component_driver rsnd_soc_component = {
 	.name		= "rsnd",
 };
 
@@ -1478,17 +1475,11 @@ static int rsnd_probe(struct platform_device *pdev)
 	/*
 	 *	asoc register
 	 */
-	ret = snd_soc_register_platform(dev, &rsnd_soc_platform);
-	if (ret < 0) {
-		dev_err(dev, "cannot snd soc register\n");
-		return ret;
-	}
-
-	ret = snd_soc_register_component(dev, &rsnd_soc_component,
+	ret = devm_snd_soc_register_component(dev, &rsnd_soc_component,
 					 priv->daidrv, rsnd_rdai_nr(priv));
 	if (ret < 0) {
 		dev_err(dev, "cannot snd dai register\n");
-		goto exit_snd_soc;
+		goto exit_snd_probe;
 	}
 
 	pm_runtime_enable(dev);
@@ -1496,8 +1487,6 @@ static int rsnd_probe(struct platform_device *pdev)
 	dev_info(dev, "probed\n");
 	return ret;
 
-exit_snd_soc:
-	snd_soc_unregister_platform(dev);
 exit_snd_probe:
 	for_each_rsnd_dai(rdai, priv, i) {
 		rsnd_dai_call(remove, &rdai->playback, priv);
@@ -1535,9 +1524,6 @@ static int rsnd_remove(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(remove_func); i++)
 		remove_func[i](priv);
 
-	snd_soc_unregister_component(&pdev->dev);
-	snd_soc_unregister_platform(&pdev->dev);
-
 	return ret;
 }
 
-- 
2.16.1
