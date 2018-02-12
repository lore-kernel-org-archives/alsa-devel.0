From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3008: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:39:32 +0000
Message-ID: <E1elDOO-0004Xn-B7@debutante>
References: <87shapxpt7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 73CDF267B4D
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:39:34 +0100 (CET)
In-Reply-To: <87shapxpt7.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: pcm3008: replace codec to component

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

>From d66827daf16d8ceb46d985b2dc423f3c3136bce0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:17:53 +0000
Subject: [PATCH] ASoC: pcm3008: replace codec to component

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
 sound/soc/codecs/pcm3008.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index e59d8ffb93bd..c6ce9bd77c5e 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -32,8 +32,8 @@ static int pcm3008_dac_ev(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol,
 			  int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct pcm3008_setup_data *setup = codec->dev->platform_data;
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct pcm3008_setup_data *setup = component->dev->platform_data;
 
 	gpio_set_value_cansleep(setup->pdda_pin,
 				SND_SOC_DAPM_EVENT_ON(event));
@@ -45,8 +45,8 @@ static int pcm3008_adc_ev(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol,
 			  int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct pcm3008_setup_data *setup = codec->dev->platform_data;
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct pcm3008_setup_data *setup = component->dev->platform_data;
 
 	gpio_set_value_cansleep(setup->pdad_pin,
 				SND_SOC_DAPM_EVENT_ON(event));
@@ -98,13 +98,15 @@ static struct snd_soc_dai_driver pcm3008_dai = {
 	},
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_pcm3008 = {
-	.component_driver = {
-		.dapm_widgets		= pcm3008_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(pcm3008_dapm_widgets),
-		.dapm_routes		= pcm3008_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(pcm3008_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_pcm3008 = {
+	.dapm_widgets		= pcm3008_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pcm3008_dapm_widgets),
+	.dapm_routes		= pcm3008_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(pcm3008_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int pcm3008_codec_probe(struct platform_device *pdev)
@@ -146,22 +148,14 @@ static int pcm3008_codec_probe(struct platform_device *pdev)
 	if (ret != 0)
 		return ret;
 
-	return snd_soc_register_codec(&pdev->dev,
-			&soc_codec_dev_pcm3008, &pcm3008_dai, 1);
-}
-
-static int pcm3008_codec_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_pcm3008, &pcm3008_dai, 1);
 }
 
 MODULE_ALIAS("platform:pcm3008-codec");
 
 static struct platform_driver pcm3008_codec_driver = {
 	.probe		= pcm3008_codec_probe,
-	.remove		= pcm3008_codec_remove,
 	.driver		= {
 		.name	= "pcm3008-codec",
 	},
-- 
2.16.1
