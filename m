From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs47l24: replace platform to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:30:39 +0000
Message-ID: <E1elDFn-0003GY-Nu@debutante>
References: <87a7xjgb01.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F104D26754D
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:30:43 +0100 (CET)
In-Reply-To: <87a7xjgb01.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs47l24: replace platform to component

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

>From 48102b0426f6d134ebd9f2624d5d42d9e7a8a9fd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:44:44 +0000
Subject: [PATCH] ASoC: cs47l24: replace platform to component

Now platform can be replaced to component, let's do it.
This patch merges cs47l24_compr_platform into soc_codec_dev_cs47l24

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l24.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index be2750680838..3f34de5f800e 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -33,6 +33,8 @@
 #include "wm_adsp.h"
 #include "cs47l24.h"
 
+#define DRV_NAME "cs47l24-codec"
+
 struct cs47l24_priv {
 	struct arizona_priv core;
 	struct arizona_fll fll[2];
@@ -1069,7 +1071,8 @@ static struct snd_soc_dai_driver cs47l24_dai[] = {
 static int cs47l24_open(struct snd_compr_stream *stream)
 {
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
-	struct cs47l24_priv *priv = snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct cs47l24_priv *priv = snd_soc_component_get_drvdata(component);
 	struct arizona *arizona = priv->core.arizona;
 	int n_adsp;
 
@@ -1177,6 +1180,16 @@ static unsigned int cs47l24_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_4L,
 };
 
+static struct snd_compr_ops cs47l24_compr_ops = {
+	.open		= cs47l24_open,
+	.free		= wm_adsp_compr_free,
+	.set_params	= wm_adsp_compr_set_params,
+	.get_caps	= wm_adsp_compr_get_caps,
+	.trigger	= wm_adsp_compr_trigger,
+	.pointer	= wm_adsp_compr_pointer,
+	.copy		= wm_adsp_compr_copy,
+};
+
 static const struct snd_soc_codec_driver soc_codec_dev_cs47l24 = {
 	.probe = cs47l24_codec_probe,
 	.remove = cs47l24_codec_remove,
@@ -1187,6 +1200,8 @@ static const struct snd_soc_codec_driver soc_codec_dev_cs47l24 = {
 	.set_pll = cs47l24_set_fll,
 
 	.component_driver = {
+		.name			= DRV_NAME,
+		.compr_ops		= &cs47l24_compr_ops,
 		.controls		= cs47l24_snd_controls,
 		.num_controls		= ARRAY_SIZE(cs47l24_snd_controls),
 		.dapm_widgets		= cs47l24_dapm_widgets,
@@ -1196,20 +1211,6 @@ static const struct snd_soc_codec_driver soc_codec_dev_cs47l24 = {
 	},
 };
 
-static const struct snd_compr_ops cs47l24_compr_ops = {
-	.open = cs47l24_open,
-	.free = wm_adsp_compr_free,
-	.set_params = wm_adsp_compr_set_params,
-	.get_caps = wm_adsp_compr_get_caps,
-	.trigger = wm_adsp_compr_trigger,
-	.pointer = wm_adsp_compr_pointer,
-	.copy = wm_adsp_compr_copy,
-};
-
-static const struct snd_soc_platform_driver cs47l24_compr_platform = {
-	.compr_ops = &cs47l24_compr_ops,
-};
-
 static int cs47l24_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
@@ -1298,23 +1299,15 @@ static int cs47l24_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_dsp_irq;
 
-	ret = snd_soc_register_platform(&pdev->dev, &cs47l24_compr_platform);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
-		goto err_spk_irqs;
-	}
-
 	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_cs47l24,
 				      cs47l24_dai, ARRAY_SIZE(cs47l24_dai));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
-		goto err_platform;
+		goto err_spk_irqs;
 	}
 
 	return ret;
 
-err_platform:
-	snd_soc_unregister_platform(&pdev->dev);
 err_spk_irqs:
 	arizona_free_spk_irqs(arizona);
 err_dsp_irq:
@@ -1328,7 +1321,6 @@ static int cs47l24_remove(struct platform_device *pdev)
 	struct cs47l24_priv *cs47l24 = platform_get_drvdata(pdev);
 	struct arizona *arizona = cs47l24->core.arizona;
 
-	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.16.1
