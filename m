From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v5 2/7] ASoC: sirf: Add SiRF audio port driver
	is used by SiRF internal audio codec
Date: Wed,  5 Mar 2014 10:36:22 +0800
Message-ID: <1393986987-20505-3-git-send-email-rongjun.ying@csr.com>
References: <1393986987-20505-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 2732126586A
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 03:37:26 +0100 (CET)
Received: by mail-pd0-f181.google.com with SMTP id p10so402893pdj.26
 for <alsa-devel@alsa-project.org>; Tue, 04 Mar 2014 18:37:25 -0800 (PST)
In-Reply-To: <1393986987-20505-1-git-send-email-rongjun.ying@csr.com>
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

This driver is used by SIRF internal audio codec.
Use dedicated SiRF audio port TXFIFO and RXFIFO
Supports two DMA channels for SiRF audio port TXFIFO and RXFIFO
The audio port like as audio bus such as i2s.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
 .../devicetree/bindings/sound/sirf-audio-port.txt  |   20 ++
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/sirf/Kconfig                             |    9 +
 sound/soc/sirf/Makefile                            |    3 +
 sound/soc/sirf/sirf-audio-port.c                   |  194 ++++++++++++++++++++
 sound/soc/sirf/sirf-audio-port.h                   |   62 +++++++
 7 files changed, 290 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-audio-port.txt
 create mode 100644 sound/soc/sirf/Kconfig
 create mode 100644 sound/soc/sirf/Makefile
 create mode 100644 sound/soc/sirf/sirf-audio-port.c
 create mode 100644 sound/soc/sirf/sirf-audio-port.h

diff --git a/Documentation/devicetree/bindings/sound/sirf-audio-port.txt b/Documentation/devicetree/bindings/sound/sirf-audio-port.txt
new file mode 100644
index 0000000..1f66de3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sirf-audio-port.txt
@@ -0,0 +1,20 @@
+* SiRF SoC audio port
+
+Required properties:
+- compatible: "sirf,audio-port"
+- reg: Base address and size entries:
+- dmas: List of DMA controller phandle and DMA request line ordered pairs.
+- dma-names: Identifier string for each DMA request line in the dmas property.
+  These strings correspond 1:1 with the ordered pairs in dmas.
+
+  One of the DMA channels will be responsible for transmission (should be
+  named "tx") and one for reception (should be named "rx").
+
+Example:
+
+audioport: audioport@b0040000 {
+	compatible = "sirf,audio-port";
+	reg = <0xb0040000 0x10000>;
+	dmas = <&dmac1 3>, <&dmac1 8>;
+	dma-names = "rx", "tx";
+};
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index d62ce48..0060b31 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -50,6 +50,7 @@ source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/sirf/Kconfig"
 source "sound/soc/spear/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 62a1822..5f1df02 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
+obj-$(CONFIG_SND_SOC)	+= sirf/
 obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
new file mode 100644
index 0000000..5b5407f
--- /dev/null
+++ b/sound/soc/sirf/Kconfig
@@ -0,0 +1,9 @@
+config SND_SOC_SIRF
+	tristate "SoC Audio for the SiRF SoC chips"
+	depends on ARCH_SIRF || COMPILE_TEST
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+
+config SND_SOC_SIRF_AUDIO_PORT
+	select REGMAP_MMIO
+	tristate
+
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
new file mode 100644
index 0000000..fb012c8
--- /dev/null
+++ b/sound/soc/sirf/Makefile
@@ -0,0 +1,3 @@
+snd-soc-sirf-audio-port-objs := sirf-audio-port.o
+
+obj-$(CONFIG_SND_SOC_SIRF_AUDIO_PORT) += snd-soc-sirf-audio-port.o
diff --git a/sound/soc/sirf/sirf-audio-port.c b/sound/soc/sirf/sirf-audio-port.c
new file mode 100644
index 0000000..b04a53f
--- /dev/null
+++ b/sound/soc/sirf/sirf-audio-port.c
@@ -0,0 +1,194 @@
+/*
+ * SiRF Audio port driver
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+
+#include "sirf-audio-port.h"
+
+struct sirf_audio_port {
+	struct regmap *regmap;
+	struct snd_dmaengine_dai_dma_data playback_dma_data;
+	struct snd_dmaengine_dai_dma_data capture_dma_data;
+};
+
+static void sirf_audio_port_tx_enable(struct sirf_audio_port *port)
+{
+	regmap_update_bits(port->regmap, AUDIO_PORT_IC_TXFIFO_OP,
+		AUDIO_FIFO_RESET, AUDIO_FIFO_RESET);
+	regmap_write(port->regmap, AUDIO_PORT_IC_TXFIFO_INT_MSK, 0);
+	regmap_write(port->regmap, AUDIO_PORT_IC_TXFIFO_OP, 0);
+	regmap_update_bits(port->regmap, AUDIO_PORT_IC_TXFIFO_OP,
+		AUDIO_FIFO_START, AUDIO_FIFO_START);
+	regmap_update_bits(port->regmap, AUDIO_PORT_IC_CODEC_TX_CTRL,
+		IC_TX_ENABLE, IC_TX_ENABLE);
+}
+
+static void sirf_audio_port_tx_disable(struct sirf_audio_port *port)
+{
+	regmap_write(port->regmap, AUDIO_PORT_IC_TXFIFO_OP, 0);
+	regmap_update_bits(port->regmap, AUDIO_PORT_IC_CODEC_TX_CTRL,
+		IC_TX_ENABLE, ~IC_TX_ENABLE);
+}
+
+static void sirf_audio_port_rx_enable(struct sirf_audio_port *port,
+	int channels)
+{
+	regmap_update_bits(port->regmap, AUDIO_PORT_IC_RXFIFO_OP,
+		AUDIO_FIFO_RESET, AUDIO_FIFO_RESET);
+	regmap_write(port->regmap, AUDIO_PORT_IC_RXFIFO_INT_MSK, 0);
+	regmap_write(port->regmap, AUDIO_PORT_IC_RXFIFO_OP, 0);
+	regmap_update_bits(port->regmap, AUDIO_PORT_IC_RXFIFO_OP,
+		AUDIO_FIFO_START, AUDIO_FIFO_START);
+	if (channels == 1)
+		regmap_update_bits(port->regmap, AUDIO_PORT_IC_CODEC_RX_CTRL,
+			IC_RX_ENABLE_MONO, IC_RX_ENABLE_MONO);
+	else
+		regmap_update_bits(port->regmap, AUDIO_PORT_IC_CODEC_RX_CTRL,
+			IC_RX_ENABLE_STEREO, IC_RX_ENABLE_STEREO);
+}
+
+static void sirf_audio_port_rx_disable(struct sirf_audio_port *port)
+{
+	regmap_update_bits(port->regmap, AUDIO_PORT_IC_CODEC_RX_CTRL,
+			IC_RX_ENABLE_STEREO, ~IC_RX_ENABLE_STEREO);
+}
+
+static int sirf_audio_port_dai_probe(struct snd_soc_dai *dai)
+{
+	struct sirf_audio_port *port = snd_soc_dai_get_drvdata(dai);
+	snd_soc_dai_init_dma_data(dai, &port->playback_dma_data,
+			&port->capture_dma_data);
+	return 0;
+}
+
+static int sirf_audio_port_trigger(struct snd_pcm_substream *substream, int cmd,
+	struct snd_soc_dai *dai)
+{
+	struct sirf_audio_port *port = snd_soc_dai_get_drvdata(dai);
+	int playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (playback)
+			sirf_audio_port_tx_disable(port);
+		else
+			sirf_audio_port_rx_disable(port);
+		break;
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (playback)
+			sirf_audio_port_tx_enable(port);
+		else
+			sirf_audio_port_rx_enable(port,
+				substream->runtime->channels);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops sirf_audio_port_dai_ops = {
+	.trigger = sirf_audio_port_trigger,
+};
+
+static struct snd_soc_dai_driver sirf_audio_port_dai = {
+	.probe = sirf_audio_port_dai_probe,
+	.name = "sirf-audio-port",
+	.id = 0,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &sirf_audio_port_dai_ops,
+};
+
+static const struct snd_soc_component_driver sirf_audio_port_component = {
+	.name       = "sirf-audio-port",
+};
+
+static const struct regmap_config sirf_audio_port_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = AUDIO_PORT_IC_RXFIFO_INT_MSK,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int sirf_audio_port_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct sirf_audio_port *port;
+	void __iomem *base;
+	struct resource *mem_res;
+
+	port = devm_kzalloc(&pdev->dev,
+			sizeof(struct sirf_audio_port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem_res) {
+		dev_err(&pdev->dev, "no mem resource?\n");
+		return -ENODEV;
+	}
+
+	base = devm_ioremap(&pdev->dev, mem_res->start,
+			resource_size(mem_res));
+	if (base == NULL)
+		return -ENOMEM;
+
+	port->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					    &sirf_audio_port_regmap_config);
+	if (IS_ERR(port->regmap))
+		return PTR_ERR(port->regmap);
+
+	ret = devm_snd_soc_register_component(&pdev->dev,
+			&sirf_audio_port_component, &sirf_audio_port_dai, 1);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, port);
+	return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+}
+
+static const struct of_device_id sirf_audio_port_of_match[] = {
+	{ .compatible = "sirf,audio-port", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sirf_audio_port_of_match);
+
+static struct platform_driver sirf_audio_port_driver = {
+	.driver = {
+		.name = "sirf-audio-port",
+		.owner = THIS_MODULE,
+		.of_match_table = sirf_audio_port_of_match,
+	},
+	.probe = sirf_audio_port_probe,
+};
+
+module_platform_driver(sirf_audio_port_driver);
+
+MODULE_DESCRIPTION("SiRF Audio Port driver");
+MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/sirf/sirf-audio-port.h b/sound/soc/sirf/sirf-audio-port.h
new file mode 100644
index 0000000..f32dc54
--- /dev/null
+++ b/sound/soc/sirf/sirf-audio-port.h
@@ -0,0 +1,62 @@
+/*
+ * SiRF Audio port controllers define
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef _SIRF_AUDIO_PORT_H
+#define _SIRF_AUDIO_PORT_H
+
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
+#endif /*__SIRF_AUDIO_PORT_H*/
-- 
1.7.5.4
