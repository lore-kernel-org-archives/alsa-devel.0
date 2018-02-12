From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5102: replace platform to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:29:59 +0000
Message-ID: <E1elDF9-0003C1-Jb@debutante>
References: <876087gayo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EC402675B1
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:30:04 +0100 (CET)
In-Reply-To: <876087gayo.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm5102: replace platform to component

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

>From a20863256f88513b3ba97484179911c2b9aa5dfd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:45:48 +0000
Subject: [PATCH] ASoC: wm5102: replace platform to component

Now platform can be replaced to component, let's do it.
This patch merges wm5102_compr_platform into soc_codec_dev_wm5102

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5102.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index fc066caa1918..a568050090ad 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -34,6 +34,8 @@
 #include "wm5102.h"
 #include "wm_adsp.h"
 
+#define DRV_NAME "wm5102-codec"
+
 struct wm5102_priv {
 	struct arizona_priv core;
 	struct arizona_fll fll[2];
@@ -1910,7 +1912,8 @@ static struct snd_soc_dai_driver wm5102_dai[] = {
 static int wm5102_open(struct snd_compr_stream *stream)
 {
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
-	struct wm5102_priv *priv = snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct wm5102_priv *priv = snd_soc_component_get_drvdata(component);
 
 	return wm_adsp_compr_open(&priv->core.adsp[0], stream);
 }
@@ -1992,6 +1995,16 @@ static unsigned int wm5102_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_5R,
 };
 
+static struct snd_compr_ops wm5102_compr_ops = {
+	.open		= wm5102_open,
+	.free		= wm_adsp_compr_free,
+	.set_params	= wm_adsp_compr_set_params,
+	.get_caps	= wm_adsp_compr_get_caps,
+	.trigger	= wm_adsp_compr_trigger,
+	.pointer	= wm_adsp_compr_pointer,
+	.copy		= wm_adsp_compr_copy,
+};
+
 static const struct snd_soc_codec_driver soc_codec_dev_wm5102 = {
 	.probe = wm5102_codec_probe,
 	.remove = wm5102_codec_remove,
@@ -2002,6 +2015,8 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm5102 = {
 	.set_pll = wm5102_set_fll,
 
 	.component_driver = {
+		.name			= DRV_NAME,
+		.compr_ops		= &wm5102_compr_ops,
 		.controls		= wm5102_snd_controls,
 		.num_controls		= ARRAY_SIZE(wm5102_snd_controls),
 		.dapm_widgets		= wm5102_dapm_widgets,
@@ -2011,20 +2026,6 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm5102 = {
 	},
 };
 
-static const struct snd_compr_ops wm5102_compr_ops = {
-	.open = wm5102_open,
-	.free = wm_adsp_compr_free,
-	.set_params = wm_adsp_compr_set_params,
-	.get_caps = wm_adsp_compr_get_caps,
-	.trigger = wm_adsp_compr_trigger,
-	.pointer = wm_adsp_compr_pointer,
-	.copy = wm_adsp_compr_copy,
-};
-
-static const struct snd_soc_platform_driver wm5102_compr_platform = {
-	.compr_ops = &wm5102_compr_ops,
-};
-
 static int wm5102_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
@@ -2109,23 +2110,15 @@ static int wm5102_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_dsp_irq;
 
-	ret = snd_soc_register_platform(&pdev->dev, &wm5102_compr_platform);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
-		goto err_spk_irqs;
-	}
-
 	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5102,
 				      wm5102_dai, ARRAY_SIZE(wm5102_dai));
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
@@ -2139,7 +2132,6 @@ static int wm5102_remove(struct platform_device *pdev)
 	struct wm5102_priv *wm5102 = platform_get_drvdata(pdev);
 	struct arizona *arizona = wm5102->core.arizona;
 
-	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.16.1
