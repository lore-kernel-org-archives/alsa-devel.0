From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 1/4 v7] ASoC: dwc: Add helper functions to disable/enable irqs
Date: Mon, 23 May 2016 11:02:22 +0100
Message-ID: <fb4a046bc20f0e0839082527b39e7737de128367.1463996627.git.joabreu@synopsys.com>
References: <cover.1463996627.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1463996627.git.joabreu@synopsys.com>
In-Reply-To: <cover.1463996627.git.joabreu@synopsys.com>
References: <cover.1463996627.git.joabreu@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Helper functions to disable and enable the I2S interrupts were
added. Only the interrupts of the used channels are enabled.

Also, there is no need to enable irqs at dw_i2s_config(), they
are already enabled at startup.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

This patch was only introduced in v7.

 sound/soc/dwc/designware_i2s.c | 68 +++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 0db69b7..4c4f0dc 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -145,26 +145,54 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev *dev, u32 stream)
 	}
 }
 
-static void i2s_start(struct dw_i2s_dev *dev,
-		      struct snd_pcm_substream *substream)
+static inline void i2s_disable_irqs(struct dw_i2s_dev *dev, u32 stream,
+				    int chan_nr)
 {
-	struct i2s_clk_config_data *config = &dev->config;
 	u32 i, irq;
-	i2s_write_reg(dev->i2s_base, IER, 1);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		for (i = 0; i < (config->chan_nr / 2); i++) {
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		for (i = 0; i < (chan_nr / 2); i++) {
+			irq = i2s_read_reg(dev->i2s_base, IMR(i));
+			i2s_write_reg(dev->i2s_base, IMR(i), irq | 0x30);
+		}
+	} else {
+		for (i = 0; i < (chan_nr / 2); i++) {
+			irq = i2s_read_reg(dev->i2s_base, IMR(i));
+			i2s_write_reg(dev->i2s_base, IMR(i), irq | 0x03);
+		}
+	}
+}
+
+static inline void i2s_enable_irqs(struct dw_i2s_dev *dev, u32 stream,
+				   int chan_nr)
+{
+	u32 i, irq;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		for (i = 0; i < (chan_nr / 2); i++) {
 			irq = i2s_read_reg(dev->i2s_base, IMR(i));
 			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x30);
 		}
-		i2s_write_reg(dev->i2s_base, ITER, 1);
 	} else {
-		for (i = 0; i < (config->chan_nr / 2); i++) {
+		for (i = 0; i < (chan_nr / 2); i++) {
 			irq = i2s_read_reg(dev->i2s_base, IMR(i));
 			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x03);
 		}
-		i2s_write_reg(dev->i2s_base, IRER, 1);
 	}
+}
+
+static void i2s_start(struct dw_i2s_dev *dev,
+		      struct snd_pcm_substream *substream)
+{
+	struct i2s_clk_config_data *config = &dev->config;
+
+	i2s_write_reg(dev->i2s_base, IER, 1);
+	i2s_enable_irqs(dev, substream->stream, config->chan_nr);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		i2s_write_reg(dev->i2s_base, ITER, 1);
+	else
+		i2s_write_reg(dev->i2s_base, IRER, 1);
 
 	i2s_write_reg(dev->i2s_base, CER, 1);
 }
@@ -172,24 +200,14 @@ static void i2s_start(struct dw_i2s_dev *dev,
 static void i2s_stop(struct dw_i2s_dev *dev,
 		struct snd_pcm_substream *substream)
 {
-	u32 i = 0, irq;
 
 	i2s_clear_irqs(dev, substream->stream);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		i2s_write_reg(dev->i2s_base, ITER, 0);
-
-		for (i = 0; i < 4; i++) {
-			irq = i2s_read_reg(dev->i2s_base, IMR(i));
-			i2s_write_reg(dev->i2s_base, IMR(i), irq | 0x30);
-		}
-	} else {
+	else
 		i2s_write_reg(dev->i2s_base, IRER, 0);
 
-		for (i = 0; i < 4; i++) {
-			irq = i2s_read_reg(dev->i2s_base, IMR(i));
-			i2s_write_reg(dev->i2s_base, IMR(i), irq | 0x03);
-		}
-	}
+	i2s_disable_irqs(dev, substream->stream, 8);
 
 	if (!dev->active) {
 		i2s_write_reg(dev->i2s_base, CER, 0);
@@ -223,7 +241,7 @@ static int dw_i2s_startup(struct snd_pcm_substream *substream,
 
 static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
 {
-	u32 ch_reg, irq;
+	u32 ch_reg;
 	struct i2s_clk_config_data *config = &dev->config;
 
 
@@ -235,16 +253,12 @@ static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
 				      dev->xfer_resolution);
 			i2s_write_reg(dev->i2s_base, TFCR(ch_reg),
 				      dev->fifo_th - 1);
-			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
-			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
 			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
 		} else {
 			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
 				      dev->xfer_resolution);
 			i2s_write_reg(dev->i2s_base, RFCR(ch_reg),
 				      dev->fifo_th - 1);
-			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
-			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
 			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
 		}
 
-- 
1.9.1
