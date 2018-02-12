From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: fsi: replace platform to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:31:20 +0000
Message-ID: <E1elDGS-0003KA-MU@debutante>
References: <87fu8ozj7k.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 996CA26783D
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:31:24 +0100 (CET)
In-Reply-To: <87fu8ozj7k.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: sh: fsi: replace platform to component

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

>From f5a82fa6016ad1c2a3f45a4d44eab2ac48daf130 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:43:26 +0000
Subject: [PATCH] ASoC: sh: fsi: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/fsi.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index c3aaf4788557..3bae06dd121f 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1764,7 +1764,7 @@ static const struct snd_pcm_ops fsi_pcm_ops = {
 };
 
 /*
- *		snd_soc_platform
+ *		snd_soc_component
  */
 
 #define PREALLOC_BUFFER		(32 * 1024)
@@ -1818,13 +1818,10 @@ static struct snd_soc_dai_driver fsi_soc_dai[] = {
 	},
 };
 
-static const struct snd_soc_platform_driver fsi_soc_platform = {
-	.ops		= &fsi_pcm_ops,
-	.pcm_new	= fsi_pcm_new,
-};
-
 static const struct snd_soc_component_driver fsi_soc_component = {
 	.name		= "fsi",
+	.ops		= &fsi_pcm_ops,
+	.pcm_new	= fsi_pcm_new,
 };
 
 /*
@@ -2007,23 +2004,15 @@ static int fsi_probe(struct platform_device *pdev)
 		goto exit_fsib;
 	}
 
-	ret = snd_soc_register_platform(&pdev->dev, &fsi_soc_platform);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot snd soc register\n");
-		goto exit_fsib;
-	}
-
-	ret = snd_soc_register_component(&pdev->dev, &fsi_soc_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &fsi_soc_component,
 				    fsi_soc_dai, ARRAY_SIZE(fsi_soc_dai));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cannot snd component register\n");
-		goto exit_snd_soc;
+		goto exit_fsib;
 	}
 
 	return ret;
 
-exit_snd_soc:
-	snd_soc_unregister_platform(&pdev->dev);
 exit_fsib:
 	pm_runtime_disable(&pdev->dev);
 	fsi_stream_remove(&master->fsib);
@@ -2041,9 +2030,6 @@ static int fsi_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	snd_soc_unregister_component(&pdev->dev);
-	snd_soc_unregister_platform(&pdev->dev);
-
 	fsi_stream_remove(&master->fsia);
 	fsi_stream_remove(&master->fsib);
 
-- 
2.16.1
