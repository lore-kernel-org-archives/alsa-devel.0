From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 3/3 v3] ASoC: dwc: Unmask I2S interrupts only for enabled channels
Date: Tue,  5 Apr 2016 18:08:02 +0100
Message-ID: <409b73fe04f1bd5155a8e6be701370a4594edc52.1459875048.git.joabreu@synopsys.com>
References: <cover.1459875048.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459875048.git.joabreu@synopsys.com>
In-Reply-To: <cover.1459875048.git.joabreu@synopsys.com>
References: <cover.1459875048.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com, Vineet.Gupta1@synopsys.com, architt@codeaurora.org, airlied@linux.ie, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, Jose Abreu <Jose.Abreu@synopsys.com>
List-Id: alsa-devel@alsa-project.org

There is no need to unmask all interrupts at I2S start. This
can cause performance issues in slower platforms.

Unmask only the interrupts for the used channels.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
---

Changes v2 -> v3:
* Dropped custom platform driver, using now ALSA DMA engine
* Dropped IRQ handler for I2S
* Removed pll_config functions (as suggested by Alexey Brodkin)

No changes v1 -> v2.

 sound/soc/dwc/designware_i2s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index bff258d..3effcd1 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -147,17 +147,18 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev *dev, u32 stream)
 static void i2s_start(struct dw_i2s_dev *dev,
 		      struct snd_pcm_substream *substream)
 {
+	struct i2s_clk_config_data *config = &dev->config;
 	u32 i, irq;
 	i2s_write_reg(dev->i2s_base, IER, 1);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		for (i = 0; i < 4; i++) {
+		for (i = 0; i < (config->chan_nr / 2); i++) {
 			irq = i2s_read_reg(dev->i2s_base, IMR(i));
 			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x30);
 		}
 		i2s_write_reg(dev->i2s_base, ITER, 1);
 	} else {
-		for (i = 0; i < 4; i++) {
+		for (i = 0; i < (config->chan_nr / 2); i++) {
 			irq = i2s_read_reg(dev->i2s_base, IMR(i));
 			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x03);
 		}
-- 
1.9.1
