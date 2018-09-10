From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel_ssc_dai: use
	devm_snd_soc_register_component()" to the asoc tree
Date: Mon, 10 Sep 2018 15:22:27 +0100 (BST)
Message-ID: <20180910142227.CECC71122D51@debutante.sirena.org.uk>
References: <87r2i6ruv9.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 744722678BD
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 16:22:28 +0200 (CEST)
In-Reply-To: <87r2i6ruv9.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel_ssc_dai: use devm_snd_soc_register_component()

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

>From e14614dc5153ad41f7d1e5b125e4cd155ca79aa2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 7 Sep 2018 01:00:15 +0000
Subject: [PATCH] ASoC: atmel_ssc_dai: use devm_snd_soc_register_component()

Now we have devm_snd_soc_register_component().
Let's use it instead of snd_soc_register_component().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index d3b69682d9c2..6291ec7f9dd6 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -1005,11 +1005,11 @@ static int asoc_ssc_init(struct device *dev)
 	struct ssc_device *ssc = dev_get_drvdata(dev);
 	int ret;
 
-	ret = snd_soc_register_component(dev, &atmel_ssc_component,
+	ret = devm_snd_soc_register_component(dev, &atmel_ssc_component,
 					 &atmel_ssc_dai, 1);
 	if (ret) {
 		dev_err(dev, "Could not register DAI: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	if (ssc->pdata->use_dma)
@@ -1019,15 +1019,10 @@ static int asoc_ssc_init(struct device *dev)
 
 	if (ret) {
 		dev_err(dev, "Could not register PCM: %d\n", ret);
-		goto err_unregister_dai;
+		return ret;
 	}
 
 	return 0;
-
-err_unregister_dai:
-	snd_soc_unregister_component(dev);
-err:
-	return ret;
 }
 
 static void asoc_ssc_exit(struct device *dev)
@@ -1038,8 +1033,6 @@ static void asoc_ssc_exit(struct device *dev)
 		atmel_pcm_dma_platform_unregister(dev);
 	else
 		atmel_pcm_pdc_platform_unregister(dev);
-
-	snd_soc_unregister_component(dev);
 }
 
 /**
-- 
2.19.0.rc1
