From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] ad193x: move codec register/unregister to bus
	probe/remove
Date: Mon, 29 Mar 2010 11:16:00 +0800
Message-ID: <1269832560-6845-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A0542415F
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 05:17:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

The way i've factored out the bus probe and removal functions so
that there's no code in the individual I2C and SPI functions means
that the register() and unregister() functions could just be squashed
into the bus_probe() and bus_remove() functions.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/codecs/ad193x.c |  102 +++++++++++++++++++-------------------------
 1 files changed, 44 insertions(+), 58 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index d034464..e6fe8ac 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -34,8 +34,6 @@ static const u8 ad193x_reg[AD193X_NUM_REGS] = {
 
 static struct snd_soc_codec *ad193x_codec;
 struct snd_soc_codec_device soc_codec_dev_ad193x;
-static int ad193x_register(struct ad193x_priv *ad193x, int bus_type);
-static void ad193x_unregister(struct ad193x_priv *ad193x);
 
 /*
  * AD193X volume/mute/de-emphasis etc. controls
@@ -289,69 +287,23 @@ static int ad193x_bus_probe(struct device *dev, void *ctrl_data, int bus_type)
 {
 	struct snd_soc_codec *codec;
 	struct ad193x_priv *ad193x;
+	int ret;
+
+	if (ad193x_codec) {
+		dev_err(dev, "Another ad193x is registered\n");
+		return -EINVAL;
+	}
 
 	ad193x = kzalloc(sizeof(struct ad193x_priv), GFP_KERNEL);
 	if (ad193x == NULL)
 		return -ENOMEM;
 
-	codec = &ad193x->codec;
-	codec->control_data = ctrl_data;
-	codec->dev = dev;
-
 	dev_set_drvdata(dev, ad193x);
 
-	return ad193x_register(ad193x, bus_type);
-}
-
-static int ad193x_bus_remove(struct device *dev)
-{
-	struct ad193x_priv *ad193x = dev_get_drvdata(dev);
-
-	ad193x_unregister(ad193x);
-	return 0;
-}
-
-static struct snd_soc_dai_ops ad193x_dai_ops = {
-	.hw_params = ad193x_hw_params,
-	.digital_mute = ad193x_mute,
-	.set_tdm_slot = ad193x_set_tdm_slot,
-	.set_fmt = ad193x_set_dai_fmt,
-};
-
-/* codec DAI instance */
-struct snd_soc_dai ad193x_dai = {
-	.name = "AD193X",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 2,
-		.channels_max = 8,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
-			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
-	},
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 2,
-		.channels_max = 4,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
-			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
-	},
-	.ops = &ad193x_dai_ops,
-};
-EXPORT_SYMBOL_GPL(ad193x_dai);
-
-static int ad193x_register(struct ad193x_priv *ad193x, int bus_type)
-{
-	int ret;
-	struct snd_soc_codec *codec = &ad193x->codec;
-
-	if (ad193x_codec) {
-		dev_err(codec->dev, "Another ad193x is registered\n");
-		return -EINVAL;
-	}
-
+	codec = &ad193x->codec;
 	mutex_init(&codec->mutex);
+	codec->control_data = ctrl_data;
+	codec->dev = dev;
 	codec->private_data = ad193x;
 	codec->reg_cache = ad193x->reg_cache;
 	codec->reg_cache_size = AD193X_NUM_REGS;
@@ -412,14 +364,48 @@ static int ad193x_register(struct ad193x_priv *ad193x, int bus_type)
 	return 0;
 }
 
-static void ad193x_unregister(struct ad193x_priv *ad193x)
+static int ad193x_bus_remove(struct device *dev)
 {
+	struct ad193x_priv *ad193x = dev_get_drvdata(dev);
+
 	snd_soc_unregister_dai(&ad193x_dai);
 	snd_soc_unregister_codec(&ad193x->codec);
 	kfree(ad193x);
 	ad193x_codec = NULL;
+
+	return 0;
 }
 
+static struct snd_soc_dai_ops ad193x_dai_ops = {
+	.hw_params = ad193x_hw_params,
+	.digital_mute = ad193x_mute,
+	.set_tdm_slot = ad193x_set_tdm_slot,
+	.set_fmt = ad193x_set_dai_fmt,
+};
+
+/* codec DAI instance */
+struct snd_soc_dai ad193x_dai = {
+	.name = "AD193X",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 4,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.ops = &ad193x_dai_ops,
+};
+EXPORT_SYMBOL_GPL(ad193x_dai);
+
 static int ad193x_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-- 
1.5.6.3
