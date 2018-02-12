From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm: stm32_adfsdm: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:13 +0000
Message-ID: <E1elDDR-0002sx-RK@debutante>
References: <87k1w15qfb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 225E6267380
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:15 +0100 (CET)
In-Reply-To: <87k1w15qfb.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: stm: stm32_adfsdm: replace platform to component

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

>From 66bf428e555cdbf77c5a9cffefd8fca4af76ce9d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:51:58 +0000
Subject: [PATCH] ASoC: stm: stm32_adfsdm: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 7306e3eca9e1..db73fef3e500 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -281,7 +281,7 @@ static void stm32_adfsdm_pcm_free(struct snd_pcm *pcm)
 	}
 }
 
-static struct snd_soc_platform_driver stm32_adfsdm_soc_platform = {
+static struct snd_soc_component_driver stm32_adfsdm_soc_platform = {
 	.ops		= &stm32_adfsdm_pcm_ops,
 	.pcm_new	= stm32_adfsdm_pcm_new,
 	.pcm_free	= stm32_adfsdm_pcm_free,
@@ -322,8 +322,9 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->iio_cb))
 		return PTR_ERR(priv->iio_cb);
 
-	ret = devm_snd_soc_register_platform(&pdev->dev,
-					     &stm32_adfsdm_soc_platform);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &stm32_adfsdm_soc_platform,
+					      NULL, 0);
 	if (ret < 0)
 		dev_err(&pdev->dev, "%s: Failed to register PCM platform\n",
 			__func__);
-- 
2.16.1
