From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2] ASoC: jz4740: Add jz4780 support
Date: Mon, 9 Mar 2015 11:23:44 +0000
Message-ID: <1425900224-52026-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: lars@metafoo.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Zubair.Kakakhel@imgtec.com
List-Id: alsa-devel@alsa-project.org

The jz4780 and jz4740 have very similar i2s blocks.

The slight difference is in Rx/Tx fifos.
And the bitclocks for input/output are different.

This patch adds jz4780 support to the driver

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
Patch based on 4.0-rc3
Tested on the MIPS Creator CI20.

V1 - > V2
Removed SND_DMAENGINE_PCM_FLAG_NO_RESIDUE as it is handled by dma driver
Added a check for symmetric_rates flag for jz4780
---
 .../bindings/sound/ingenic,jz4740-i2s.txt          |  2 +-
 sound/soc/jz4740/jz4740-i2s.c                      | 58 +++++++++++++++++++---
 2 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt b/Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
index b414333..b623d50 100644
--- a/Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
@@ -1,7 +1,7 @@
 Ingenic JZ4740 I2S controller
 
 Required properties:
-- compatible : "ingenic,jz4740-i2s"
+- compatible : "ingenic,jz4740-i2s" or "ingenic,jz4780-i2s"
 - reg : I2S registers location and length
 - clocks : AIC and I2S PLL clock specifiers.
 - clock-names: "aic" and "i2s"
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 07f7781..08eb823 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -58,6 +58,12 @@
 
 #define JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 12
 #define JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 8
+#define JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
+#define JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
+#define JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_MASK \
+			(0xf << JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET)
+#define JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_MASK \
+			(0x1f <<  JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET)
 
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
@@ -79,6 +85,7 @@
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
 
 #define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
+#define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
 #define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
 #define JZ_AIC_I2S_FMT_MSB BIT(0)
 
@@ -87,6 +94,13 @@
 #define JZ_AIC_CLK_DIV_MASK 0xf
 #define I2SDIV_DV_SHIFT 8
 #define I2SDIV_DV_MASK (0xf << I2SDIV_DV_SHIFT)
+#define I2SDIV_IDV_SHIFT 8
+#define I2SDIV_IDV_MASK (0xf << I2SDIV_IDV_SHIFT)
+
+enum jz47xx_i2s_version {
+	JZ_I2S_JZ4740,
+	JZ_I2S_JZ4780,
+};
 
 struct jz4740_i2s {
 	struct resource *mem;
@@ -98,6 +112,8 @@ struct jz4740_i2s {
 
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
+
+	enum jz47xx_i2s_version version;
 };
 
 static inline uint32_t jz4740_i2s_read(const struct jz4740_i2s *i2s,
@@ -267,13 +283,22 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 			ctrl |= JZ_AIC_CTRL_MONO_TO_STEREO;
 		else
 			ctrl &= ~JZ_AIC_CTRL_MONO_TO_STEREO;
+
+		div_reg &= ~I2SDIV_DV_MASK;
+		div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
 	} else {
 		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
 		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
+
+		if (i2s->version >= JZ_I2S_JZ4780) {
+			div_reg &= ~I2SDIV_IDV_MASK;
+			div_reg |= (div - 1) << I2SDIV_IDV_SHIFT;
+		} else {
+			div_reg &= ~I2SDIV_DV_MASK;
+			div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
+		}
 	}
 
-	div_reg &= ~I2SDIV_DV_MASK;
-	div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div_reg);
 
@@ -369,11 +394,19 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
 		&i2s->capture_dma_data);
 
-	conf = (7 << JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
-		(8 << JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
-		JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
-		JZ_AIC_CONF_I2S |
-		JZ_AIC_CONF_INTERNAL_CODEC;
+	if (i2s->version >= JZ_I2S_JZ4780) {
+		conf = (7 << JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
+			(8 << JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
+			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
+			JZ_AIC_CONF_I2S |
+			JZ_AIC_CONF_INTERNAL_CODEC;
+	} else {
+		conf = (7 << JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
+			(8 << JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
+			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
+			JZ_AIC_CONF_I2S |
+			JZ_AIC_CONF_INTERNAL_CODEC;
+	}
 
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
@@ -428,7 +461,8 @@ static const struct snd_soc_component_driver jz4740_i2s_component = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_of_matches[] = {
-	{ .compatible = "ingenic,jz4740-i2s" },
+	{ .compatible = "ingenic,jz4740-i2s", .data = (void *)JZ_I2S_JZ4740 },
+	{ .compatible = "ingenic,jz4780-i2s", .data = (void *)JZ_I2S_JZ4780 },
 	{ /* sentinel */ }
 };
 #endif
@@ -438,11 +472,16 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	struct jz4740_i2s *i2s;
 	struct resource *mem;
 	int ret;
+	const struct of_device_id *match;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
 		return -ENOMEM;
 
+	match = of_match_device(jz4740_of_matches, &pdev->dev);
+	if (match)
+		i2s->version = (enum jz47xx_i2s_version)match->data;
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2s->base = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(i2s->base))
@@ -460,6 +499,9 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2s);
 
+	if (i2s->version >= JZ_I2S_JZ4780)
+		jz4740_i2s_dai.symmetric_rates = 0;
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 		&jz4740_i2s_component, &jz4740_i2s_dai, 1);
 	if (ret)
-- 
1.9.1
