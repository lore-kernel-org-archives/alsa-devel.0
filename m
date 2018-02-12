From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm5102a: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:39:22 +0000
Message-ID: <E1elDOE-0004VL-Se@debutante>
References: <87o9ldxpr2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC9A267950
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:39:25 +0100 (CET)
In-Reply-To: <87o9ldxpr2.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: pcm5102a: replace codec to component

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

>From d5e90bad6faa0ea93a14f88aaae62fb58e968a0a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:19:05 +0000
Subject: [PATCH] ASoC: pcm5102a: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm5102a.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/pcm5102a.c b/sound/soc/codecs/pcm5102a.c
index 8ba322a00363..39ac2857a554 100644
--- a/sound/soc/codecs/pcm5102a.c
+++ b/sound/soc/codecs/pcm5102a.c
@@ -32,20 +32,19 @@ static struct snd_soc_dai_driver pcm5102a_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_pcm5102a;
+static struct snd_soc_component_driver soc_component_dev_pcm5102a = {
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
 
 static int pcm5102a_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_pcm5102a,
+	return devm_snd_soc_register_component(&pdev->dev, &soc_component_dev_pcm5102a,
 			&pcm5102a_dai, 1);
 }
 
-static int pcm5102a_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
-}
-
 static const struct of_device_id pcm5102a_of_match[] = {
 	{ .compatible = "ti,pcm5102a", },
 	{ }
@@ -54,7 +53,6 @@ MODULE_DEVICE_TABLE(of, pcm5102a_of_match);
 
 static struct platform_driver pcm5102a_codec_driver = {
 	.probe		= pcm5102a_probe,
-	.remove		= pcm5102a_remove,
 	.driver		= {
 		.name	= "pcm5102a-codec",
 		.of_match_table = pcm5102a_of_match,
-- 
2.16.1
