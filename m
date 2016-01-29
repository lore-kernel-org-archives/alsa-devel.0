From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5102: Add support for the audio trace
	firmware" to the asoc tree
Date: Fri, 29 Jan 2016 12:40:32 +0100
Message-ID: <E1aP7Pk-0006we-Ae@finisterre>
References: <1453398782-32198-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 56232260699
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 12:40:47 +0100 (CET)
In-Reply-To: <1453398782-32198-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm5102: Add support for the audio trace firmware

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 69fa80584f69554275ef1257d41b90f4e0d417fc Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 21 Jan 2016 17:53:01 +0000
Subject: [PATCH] ASoC: wm5102: Add support for the audio trace firmware

wm5102 also supports the audio trace firmware, this patch adds support
for this into the wm5102 driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5102.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 7c0860d..aa1e96a 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1599,6 +1599,9 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "Slim2 Capture", NULL, "SYSCLK" },
 	{ "Slim3 Capture", NULL, "SYSCLK" },
 
+	{ "Audio Trace DSP", NULL, "DSP1" },
+	{ "Audio Trace DSP", NULL, "SYSCLK" },
+
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
 
@@ -1864,14 +1867,67 @@ static struct snd_soc_dai_driver wm5102_dai[] = {
 		 },
 		.ops = &arizona_simple_dai_ops,
 	},
+	{
+		.name = "wm5102-cpu-trace",
+		.capture = {
+			.stream_name = "Audio Trace CPU",
+			.channels_min = 1,
+			.channels_max = 6,
+			.rates = WM5102_RATES,
+			.formats = WM5102_FORMATS,
+		},
+		.compress_new = snd_soc_new_compress,
+	},
+	{
+		.name = "wm5102-dsp-trace",
+		.capture = {
+			.stream_name = "Audio Trace DSP",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = WM5102_RATES,
+			.formats = WM5102_FORMATS,
+		},
+	},
 };
 
+static int wm5102_open(struct snd_compr_stream *stream)
+{
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(rtd->codec);
+
+	return wm_adsp_compr_open(&priv->core.adsp[0], stream);
+}
+
+static irqreturn_t wm5102_adsp2_irq(int irq, void *data)
+{
+	struct wm5102_priv *priv = data;
+	struct arizona *arizona = priv->core.arizona;
+	int ret;
+
+	ret = wm_adsp_compr_handle_irq(&priv->core.adsp[0]);
+	if (ret == -ENODEV) {
+		dev_err(arizona->dev, "Spurious compressed data IRQ\n");
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int wm5102_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->core.arizona;
 	int ret;
 
+	ret = arizona_request_irq(arizona, ARIZONA_IRQ_DSP_IRQ1,
+				  "ADSP2 Compressed IRQ", wm5102_adsp2_irq,
+				  priv);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request DSP IRQ: %d\n", ret);
+		return ret;
+	}
+
 	ret = wm_adsp2_codec_probe(&priv->core.adsp[0], codec);
 	if (ret)
 		return ret;
@@ -1946,6 +2002,20 @@ static struct snd_soc_codec_driver soc_codec_dev_wm5102 = {
 	.num_dapm_routes = ARRAY_SIZE(wm5102_dapm_routes),
 };
 
+static struct snd_compr_ops wm5102_compr_ops = {
+	.open = wm5102_open,
+	.free = wm_adsp_compr_free,
+	.set_params = wm_adsp_compr_set_params,
+	.get_caps = wm_adsp_compr_get_caps,
+	.trigger = wm_adsp_compr_trigger,
+	.pointer = wm_adsp_compr_pointer,
+	.copy = wm_adsp_compr_copy,
+};
+
+static struct snd_soc_platform_driver wm5102_compr_platform = {
+	.compr_ops = &wm5102_compr_ops,
+};
+
 static int wm5102_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
@@ -2005,12 +2075,25 @@ static int wm5102_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5102,
+	ret = snd_soc_register_platform(&pdev->dev, &wm5102_compr_platform);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5102,
 				      wm5102_dai, ARRAY_SIZE(wm5102_dai));
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
+		snd_soc_unregister_platform(&pdev->dev);
+	}
+
+	return ret;
 }
 
 static int wm5102_remove(struct platform_device *pdev)
 {
+	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.6.4
