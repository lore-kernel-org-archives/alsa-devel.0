From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 1/1] axi-i2s: set period size register
Date: Fri, 24 Aug 2018 18:04:30 +0200
Message-ID: <20180824160430.10222-2-luca@lucaceresoli.net>
References: <20180824160430.10222-1-luca@lucaceresoli.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824160430.10222-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The default value of the PERIOD_LEN register is 0 and results in
axi-i2s keeping TLAST always asserted in its AXI Stream output.

When the AXI Stream is sent to a Xilinx AXI-DMA, this results in the
DMA generating an interrupt flood and ALSA produce a corrupted
recording. This is because AXI-DMA raises an interrupt whenever TLAST
is active.

Fix by setting the PERIOD_LEN register as soon as the period is
known. This way TLAST is emitted once per period, and the DMA raises
interrupts correctly.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 sound/soc/adi/axi-i2s.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
index 4c23381727a1..af581a313a40 100644
--- a/sound/soc/adi/axi-i2s.c
+++ b/sound/soc/adi/axi-i2s.c
@@ -24,6 +24,7 @@
 #define AXI_I2S_REG_CTRL	0x04
 #define AXI_I2S_REG_CLK_CTRL	0x08
 #define AXI_I2S_REG_STATUS	0x10
+#define AXI_I2S_REG_PERIOD_LEN	0x18
 
 #define AXI_I2S_REG_RX_FIFO	0x28
 #define AXI_I2S_REG_TX_FIFO	0x2C
@@ -101,6 +102,17 @@ static int axi_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int axi_i2s_prepare(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned int period_bytes = snd_pcm_lib_period_bytes(substream);
+
+	/* adi_i2s counts 32-bit words, thus divide bytes by 4 */
+	return regmap_write(i2s->regmap, AXI_I2S_REG_PERIOD_LEN,
+			    (period_bytes / 4) - 1);
+}
+
 static int axi_i2s_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
@@ -147,6 +159,7 @@ static const struct snd_soc_dai_ops axi_i2s_dai_ops = {
 	.shutdown = axi_i2s_shutdown,
 	.trigger = axi_i2s_trigger,
 	.hw_params = axi_i2s_hw_params,
+	.prepare = axi_i2s_prepare,
 };
 
 static struct snd_soc_dai_driver axi_i2s_dai = {
@@ -175,7 +188,7 @@ static const struct regmap_config axi_i2s_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = AXI_I2S_REG_STATUS,
+	.max_register = AXI_I2S_REG_PERIOD_LEN,
 };
 
 static int axi_i2s_probe(struct platform_device *pdev)
-- 
2.17.1
