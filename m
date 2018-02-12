From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-utils: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:28:10 +0000
Message-ID: <E1elDDO-0002s4-ON@debutante>
References: <87h8r55q5a.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 08201267371
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:12 +0100 (CET)
In-Reply-To: <87h8r55q5a.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-utils: replace codec to component

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

>From 03a0ddeda7ebafea8e99078581a50d856e3587a4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:58:01 +0000
Subject: [PATCH] ASoC: soc-utils: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming	= 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-utils.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index e237858c9ed4..2d9e98bd1530 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -288,7 +288,12 @@ static const struct snd_soc_component_driver dummy_platform = {
 	.ops = &dummy_dma_ops,
 };
 
-static const struct snd_soc_codec_driver dummy_codec;
+static const struct snd_soc_component_driver dummy_codec = {
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
 
 #define STUB_RATES	SNDRV_PCM_RATE_8000_192000
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S8 | \
@@ -338,33 +343,22 @@ static int snd_soc_dummy_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	ret = snd_soc_register_codec(&pdev->dev, &dummy_codec, &dummy_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &dummy_codec, &dummy_dai, 1);
 	if (ret < 0)
 		return ret;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &dummy_platform,
 					      NULL, 0);
-	if (ret < 0) {
-		snd_soc_unregister_codec(&pdev->dev);
-		return ret;
-	}
 
 	return ret;
 }
 
-static int snd_soc_dummy_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-
-	return 0;
-}
-
 static struct platform_driver soc_dummy_driver = {
 	.driver = {
 		.name = "snd-soc-dummy",
 	},
 	.probe = snd_soc_dummy_probe,
-	.remove = snd_soc_dummy_remove,
 };
 
 static struct platform_device *soc_dummy_dev;
-- 
2.16.1
