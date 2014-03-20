From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH] ASoC: sirf: Move the tx rx enable from port to
	codec, that will not need register sharing
Date: Thu, 20 Mar 2014 15:46:19 +0800
Message-ID: <1395301579-2960-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f43.google.com (mail-pb0-f43.google.com
 [209.85.160.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DDDC265204
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 08:46:54 +0100 (CET)
Received: by mail-pb0-f43.google.com with SMTP id um1so563853pbc.30
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 00:46:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, rjying@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <rongjun.ying@csr.com>

The port driver only used to register component and dmaengine pcm.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
 sound/soc/codecs/sirf-audio-codec.c |   74 +++++++++++++++++++++---
 sound/soc/codecs/sirf-audio-codec.h |   50 ++++++++++++++++
 sound/soc/sirf/sirf-audio-port.c    |  107 -----------------------------------
 sound/soc/sirf/sirf-audio-port.h    |   62 --------------------
 4 files changed, 116 insertions(+), 177 deletions(-)
 delete mode 100644 sound/soc/sirf/sirf-audio-port.h

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index 58e7c1f..c5177bc 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -279,13 +279,63 @@ static const struct snd_soc_dapm_route sirf_audio_codec_map[] = {
 	{"Mic input mode mux", "Differential", "MICIN1"},
 };
 
+static void sirf_audio_codec_tx_enable(struct sirf_audio_codec *sirf_audio_codec)
+{
+	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_PORT_IC_TXFIFO_OP,
+		AUDIO_FIFO_RESET, AUDIO_FIFO_RESET);
+	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_PORT_IC_TXFIFO_OP,
+		AUDIO_FIFO_RESET, ~AUDIO_FIFO_RESET);
+	regmap_write(sirf_audio_codec->regmap, AUDIO_PORT_IC_TXFIFO_INT_MSK, 0);
+	regmap_write(sirf_audio_codec->regmap, AUDIO_PORT_IC_TXFIFO_OP, 0);
+	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_PORT_IC_TXFIFO_OP,
+		AUDIO_FIFO_START, AUDIO_FIFO_START);
+	regmap_update_bits(sirf_audio_codec->regmap,
+		AUDIO_PORT_IC_CODEC_TX_CTRL, IC_TX_ENABLE, IC_TX_ENABLE);
+}
+
+static void sirf_audio_codec_tx_disable(struct sirf_audio_codec *sirf_audio_codec)
+{
+	regmap_write(sirf_audio_codec->regmap, AUDIO_PORT_IC_TXFIFO_OP, 0);
+	regmap_update_bits(sirf_audio_codec->regmap,
+		AUDIO_PORT_IC_CODEC_TX_CTRL, IC_TX_ENABLE, ~IC_TX_ENABLE);
+}
+
+static void sirf_audio_codec_rx_enable(struct sirf_audio_codec *sirf_audio_codec,
+	int channels)
+{
+	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_PORT_IC_RXFIFO_OP,
+		AUDIO_FIFO_RESET, AUDIO_FIFO_RESET);
+	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_PORT_IC_RXFIFO_OP,
+		AUDIO_FIFO_RESET, ~AUDIO_FIFO_RESET);
+	regmap_write(sirf_audio_codec->regmap,
+		AUDIO_PORT_IC_RXFIFO_INT_MSK, 0);
+	regmap_write(sirf_audio_codec->regmap, AUDIO_PORT_IC_RXFIFO_OP, 0);
+	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_PORT_IC_RXFIFO_OP,
+		AUDIO_FIFO_START, AUDIO_FIFO_START);
+	if (channels == 1)
+		regmap_update_bits(sirf_audio_codec->regmap,
+			AUDIO_PORT_IC_CODEC_RX_CTRL,
+			IC_RX_ENABLE_MONO, IC_RX_ENABLE_MONO);
+	else
+		regmap_update_bits(sirf_audio_codec->regmap,
+			AUDIO_PORT_IC_CODEC_RX_CTRL,
+			IC_RX_ENABLE_STEREO, IC_RX_ENABLE_STEREO);
+}
+
+static void sirf_audio_codec_rx_disable(struct sirf_audio_codec *sirf_audio_codec)
+{
+	regmap_update_bits(sirf_audio_codec->regmap,
+			AUDIO_PORT_IC_CODEC_RX_CTRL,
+			IC_RX_ENABLE_STEREO, ~IC_RX_ENABLE_STEREO);
+}
+
 static int sirf_audio_codec_trigger(struct snd_pcm_substream *substream,
 		int cmd,
 		struct snd_soc_dai *dai)
 {
-	int playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct snd_soc_codec *codec = dai->codec;
-	u32 val = 0;
+	struct sirf_audio_codec *sirf_audio_codec = snd_soc_codec_get_drvdata(codec);
+	int playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 
 	/*
 	 * This is a workaround, When stop playback,
@@ -295,20 +345,28 @@ static int sirf_audio_codec_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (playback) {
+			snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL0,
+				IC_HSLEN | IC_HSREN, 0);
+			sirf_audio_codec_tx_disable(sirf_audio_codec);
+		} else
+			sirf_audio_codec_rx_disable(sirf_audio_codec);
 		break;
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (playback)
-			val = IC_HSLEN | IC_HSREN;
+		if (playback) {
+			sirf_audio_codec_tx_enable(sirf_audio_codec);
+			snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL0,
+				IC_HSLEN | IC_HSREN, IC_HSLEN | IC_HSREN);
+		} else
+			sirf_audio_codec_rx_enable(sirf_audio_codec,
+				substream->runtime->channels);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (playback)
-		snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL0,
-			IC_HSLEN | IC_HSREN, val);
 	return 0;
 }
 
@@ -392,7 +450,7 @@ static const struct regmap_config sirf_audio_codec_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = AUDIO_IC_CODEC_CTRL3,
+	.max_register = AUDIO_PORT_IC_RXFIFO_INT_MSK,
 	.cache_type = REGCACHE_NONE,
 };
 
diff --git a/sound/soc/codecs/sirf-audio-codec.h b/sound/soc/codecs/sirf-audio-codec.h
index d4c187b..ba1adc0 100644
--- a/sound/soc/codecs/sirf-audio-codec.h
+++ b/sound/soc/codecs/sirf-audio-codec.h
@@ -72,4 +72,54 @@
 #define IC_RXPGAR		0x7B
 #define IC_RXPGAL		0x7B
 
+#define AUDIO_PORT_TX_FIFO_LEVEL_CHECK_MASK     0x3F
+#define AUDIO_PORT_TX_FIFO_SC_OFFSET    0
+#define AUDIO_PORT_TX_FIFO_LC_OFFSET    10
+#define AUDIO_PORT_TX_FIFO_HC_OFFSET    20
+
+#define TX_FIFO_SC(x)           (((x) & AUDIO_PORT_TX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_PORT_TX_FIFO_SC_OFFSET)
+#define TX_FIFO_LC(x)           (((x) & AUDIO_PORT_TX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_PORT_TX_FIFO_LC_OFFSET)
+#define TX_FIFO_HC(x)           (((x) & AUDIO_PORT_TX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_PORT_TX_FIFO_HC_OFFSET)
+
+#define AUDIO_PORT_RX_FIFO_LEVEL_CHECK_MASK     0x0F
+#define AUDIO_PORT_RX_FIFO_SC_OFFSET    0
+#define AUDIO_PORT_RX_FIFO_LC_OFFSET    10
+#define AUDIO_PORT_RX_FIFO_HC_OFFSET    20
+
+#define RX_FIFO_SC(x)           (((x) & AUDIO_PORT_RX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_PORT_RX_FIFO_SC_OFFSET)
+#define RX_FIFO_LC(x)           (((x) & AUDIO_PORT_RX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_PORT_RX_FIFO_LC_OFFSET)
+#define RX_FIFO_HC(x)           (((x) & AUDIO_PORT_RX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_PORT_RX_FIFO_HC_OFFSET)
+#define AUDIO_PORT_IC_CODEC_TX_CTRL		(0x00F4)
+#define AUDIO_PORT_IC_CODEC_RX_CTRL		(0x00F8)
+
+#define AUDIO_PORT_IC_TXFIFO_OP			(0x00FC)
+#define AUDIO_PORT_IC_TXFIFO_LEV_CHK		(0x0100)
+#define AUDIO_PORT_IC_TXFIFO_STS		(0x0104)
+#define AUDIO_PORT_IC_TXFIFO_INT		(0x0108)
+#define AUDIO_PORT_IC_TXFIFO_INT_MSK		(0x010C)
+
+#define AUDIO_PORT_IC_RXFIFO_OP			(0x0110)
+#define AUDIO_PORT_IC_RXFIFO_LEV_CHK		(0x0114)
+#define AUDIO_PORT_IC_RXFIFO_STS		(0x0118)
+#define AUDIO_PORT_IC_RXFIFO_INT		(0x011C)
+#define AUDIO_PORT_IC_RXFIFO_INT_MSK		(0x0120)
+
+#define AUDIO_FIFO_START		(1 << 0)
+#define AUDIO_FIFO_RESET		(1 << 1)
+
+#define AUDIO_FIFO_FULL			(1 << 0)
+#define AUDIO_FIFO_EMPTY		(1 << 1)
+#define AUDIO_FIFO_OFLOW		(1 << 2)
+#define AUDIO_FIFO_UFLOW		(1 << 3)
+
+#define IC_TX_ENABLE		(0x03)
+#define IC_RX_ENABLE_MONO	(0x01)
+#define IC_RX_ENABLE_STEREO	(0x03)
+
 #endif /*__SIRF_AUDIO_CODEC_H*/
diff --git a/sound/soc/sirf/sirf-audio-port.c b/sound/soc/sirf/sirf-audio-port.c
index b04a53f..b4afa31 100644
--- a/sound/soc/sirf/sirf-audio-port.c
+++ b/sound/soc/sirf/sirf-audio-port.c
@@ -6,60 +6,15 @@
  * Licensed under GPLv2 or later.
  */
 #include <linux/module.h>
-#include <linux/io.h>
-#include <linux/regmap.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
-#include "sirf-audio-port.h"
-
 struct sirf_audio_port {
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
 };
 
-static void sirf_audio_port_tx_enable(struct sirf_audio_port *port)
-{
-	regmap_update_bits(port->regmap, AUDIO_PORT_IC_TXFIFO_OP,
-		AUDIO_FIFO_RESET, AUDIO_FIFO_RESET);
-	regmap_write(port->regmap, AUDIO_PORT_IC_TXFIFO_INT_MSK, 0);
-	regmap_write(port->regmap, AUDIO_PORT_IC_TXFIFO_OP, 0);
-	regmap_update_bits(port->regmap, AUDIO_PORT_IC_TXFIFO_OP,
-		AUDIO_FIFO_START, AUDIO_FIFO_START);
-	regmap_update_bits(port->regmap, AUDIO_PORT_IC_CODEC_TX_CTRL,
-		IC_TX_ENABLE, IC_TX_ENABLE);
-}
-
-static void sirf_audio_port_tx_disable(struct sirf_audio_port *port)
-{
-	regmap_write(port->regmap, AUDIO_PORT_IC_TXFIFO_OP, 0);
-	regmap_update_bits(port->regmap, AUDIO_PORT_IC_CODEC_TX_CTRL,
-		IC_TX_ENABLE, ~IC_TX_ENABLE);
-}
-
-static void sirf_audio_port_rx_enable(struct sirf_audio_port *port,
-	int channels)
-{
-	regmap_update_bits(port->regmap, AUDIO_PORT_IC_RXFIFO_OP,
-		AUDIO_FIFO_RESET, AUDIO_FIFO_RESET);
-	regmap_write(port->regmap, AUDIO_PORT_IC_RXFIFO_INT_MSK, 0);
-	regmap_write(port->regmap, AUDIO_PORT_IC_RXFIFO_OP, 0);
-	regmap_update_bits(port->regmap, AUDIO_PORT_IC_RXFIFO_OP,
-		AUDIO_FIFO_START, AUDIO_FIFO_START);
-	if (channels == 1)
-		regmap_update_bits(port->regmap, AUDIO_PORT_IC_CODEC_RX_CTRL,
-			IC_RX_ENABLE_MONO, IC_RX_ENABLE_MONO);
-	else
-		regmap_update_bits(port->regmap, AUDIO_PORT_IC_CODEC_RX_CTRL,
-			IC_RX_ENABLE_STEREO, IC_RX_ENABLE_STEREO);
-}
-
-static void sirf_audio_port_rx_disable(struct sirf_audio_port *port)
-{
-	regmap_update_bits(port->regmap, AUDIO_PORT_IC_CODEC_RX_CTRL,
-			IC_RX_ENABLE_STEREO, ~IC_RX_ENABLE_STEREO);
-}
 
 static int sirf_audio_port_dai_probe(struct snd_soc_dai *dai)
 {
@@ -69,41 +24,6 @@ static int sirf_audio_port_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static int sirf_audio_port_trigger(struct snd_pcm_substream *substream, int cmd,
-	struct snd_soc_dai *dai)
-{
-	struct sirf_audio_port *port = snd_soc_dai_get_drvdata(dai);
-	int playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (playback)
-			sirf_audio_port_tx_disable(port);
-		else
-			sirf_audio_port_rx_disable(port);
-		break;
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (playback)
-			sirf_audio_port_tx_enable(port);
-		else
-			sirf_audio_port_rx_enable(port,
-				substream->runtime->channels);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static const struct snd_soc_dai_ops sirf_audio_port_dai_ops = {
-	.trigger = sirf_audio_port_trigger,
-};
-
 static struct snd_soc_dai_driver sirf_audio_port_dai = {
 	.probe = sirf_audio_port_dai_probe,
 	.name = "sirf-audio-port",
@@ -120,49 +40,22 @@ static struct snd_soc_dai_driver sirf_audio_port_dai = {
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = &sirf_audio_port_dai_ops,
 };
 
 static const struct snd_soc_component_driver sirf_audio_port_component = {
 	.name       = "sirf-audio-port",
 };
 
-static const struct regmap_config sirf_audio_port_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = AUDIO_PORT_IC_RXFIFO_INT_MSK,
-	.cache_type = REGCACHE_NONE,
-};
-
 static int sirf_audio_port_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct sirf_audio_port *port;
-	void __iomem *base;
-	struct resource *mem_res;
 
 	port = devm_kzalloc(&pdev->dev,
 			sizeof(struct sirf_audio_port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
 
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem_res) {
-		dev_err(&pdev->dev, "no mem resource?\n");
-		return -ENODEV;
-	}
-
-	base = devm_ioremap(&pdev->dev, mem_res->start,
-			resource_size(mem_res));
-	if (base == NULL)
-		return -ENOMEM;
-
-	port->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					    &sirf_audio_port_regmap_config);
-	if (IS_ERR(port->regmap))
-		return PTR_ERR(port->regmap);
-
 	ret = devm_snd_soc_register_component(&pdev->dev,
 			&sirf_audio_port_component, &sirf_audio_port_dai, 1);
 	if (ret)
diff --git a/sound/soc/sirf/sirf-audio-port.h b/sound/soc/sirf/sirf-audio-port.h
deleted file mode 100644
index f32dc54..0000000
--- a/sound/soc/sirf/sirf-audio-port.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * SiRF Audio port controllers define
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef _SIRF_AUDIO_PORT_H
-#define _SIRF_AUDIO_PORT_H
-
-#define AUDIO_PORT_TX_FIFO_LEVEL_CHECK_MASK     0x3F
-#define AUDIO_PORT_TX_FIFO_SC_OFFSET    0
-#define AUDIO_PORT_TX_FIFO_LC_OFFSET    10
-#define AUDIO_PORT_TX_FIFO_HC_OFFSET    20
-
-#define TX_FIFO_SC(x)           (((x) & AUDIO_PORT_TX_FIFO_LEVEL_CHECK_MASK) \
-				<< AUDIO_PORT_TX_FIFO_SC_OFFSET)
-#define TX_FIFO_LC(x)           (((x) & AUDIO_PORT_TX_FIFO_LEVEL_CHECK_MASK) \
-				<< AUDIO_PORT_TX_FIFO_LC_OFFSET)
-#define TX_FIFO_HC(x)           (((x) & AUDIO_PORT_TX_FIFO_LEVEL_CHECK_MASK) \
-				<< AUDIO_PORT_TX_FIFO_HC_OFFSET)
-
-#define AUDIO_PORT_RX_FIFO_LEVEL_CHECK_MASK     0x0F
-#define AUDIO_PORT_RX_FIFO_SC_OFFSET    0
-#define AUDIO_PORT_RX_FIFO_LC_OFFSET    10
-#define AUDIO_PORT_RX_FIFO_HC_OFFSET    20
-
-#define RX_FIFO_SC(x)           (((x) & AUDIO_PORT_RX_FIFO_LEVEL_CHECK_MASK) \
-				<< AUDIO_PORT_RX_FIFO_SC_OFFSET)
-#define RX_FIFO_LC(x)           (((x) & AUDIO_PORT_RX_FIFO_LEVEL_CHECK_MASK) \
-				<< AUDIO_PORT_RX_FIFO_LC_OFFSET)
-#define RX_FIFO_HC(x)           (((x) & AUDIO_PORT_RX_FIFO_LEVEL_CHECK_MASK) \
-				<< AUDIO_PORT_RX_FIFO_HC_OFFSET)
-#define AUDIO_PORT_IC_CODEC_TX_CTRL		(0x00F4)
-#define AUDIO_PORT_IC_CODEC_RX_CTRL		(0x00F8)
-
-#define AUDIO_PORT_IC_TXFIFO_OP			(0x00FC)
-#define AUDIO_PORT_IC_TXFIFO_LEV_CHK		(0x0100)
-#define AUDIO_PORT_IC_TXFIFO_STS		(0x0104)
-#define AUDIO_PORT_IC_TXFIFO_INT		(0x0108)
-#define AUDIO_PORT_IC_TXFIFO_INT_MSK		(0x010C)
-
-#define AUDIO_PORT_IC_RXFIFO_OP			(0x0110)
-#define AUDIO_PORT_IC_RXFIFO_LEV_CHK		(0x0114)
-#define AUDIO_PORT_IC_RXFIFO_STS		(0x0118)
-#define AUDIO_PORT_IC_RXFIFO_INT		(0x011C)
-#define AUDIO_PORT_IC_RXFIFO_INT_MSK		(0x0120)
-
-#define AUDIO_FIFO_START		(1 << 0)
-#define AUDIO_FIFO_RESET		(1 << 1)
-
-#define AUDIO_FIFO_FULL			(1 << 0)
-#define AUDIO_FIFO_EMPTY		(1 << 1)
-#define AUDIO_FIFO_OFLOW		(1 << 2)
-#define AUDIO_FIFO_UFLOW		(1 << 3)
-
-#define IC_TX_ENABLE		(0x03)
-#define IC_RX_ENABLE_MONO	(0x01)
-#define IC_RX_ENABLE_STEREO	(0x03)
-
-#endif /*__SIRF_AUDIO_PORT_H*/
-- 
1.7.5.4
