From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 3/5 v4] ASoC: dwc: Use fifo depth to program FCR
Date: Thu,  7 Apr 2016 17:53:57 +0100
Message-ID: <5aa4bcb0eba226af2e78fc530ad7d0429d2c96ca.1460047238.git.joabreu@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1460047238.git.joabreu@synopsys.com>
In-Reply-To: <cover.1460047238.git.joabreu@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, architt@codeaurora.org, airlied@linux.ie, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, CARLOS.PALMINHA@synopsys.com, lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

This patch makes Designware I2S driver use the fifo
depth value to program the fifo configuration register
instead of using hardcoded values.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
---

This patch was only introduced in v4.

 sound/soc/dwc/designware_i2s.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 3effcd1..0db69b7 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -100,6 +100,7 @@ struct dw_i2s_dev {
 	struct device *dev;
 	u32 ccr;
 	u32 xfer_resolution;
+	u32 fifo_th;
 
 	/* data related to DMA transfers b/w i2s and DMAC */
 	union dw_i2s_snd_dma_data play_dma_data;
@@ -232,14 +233,16 @@ static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
 		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			i2s_write_reg(dev->i2s_base, TCR(ch_reg),
 				      dev->xfer_resolution);
-			i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
+			i2s_write_reg(dev->i2s_base, TFCR(ch_reg),
+				      dev->fifo_th - 1);
 			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
 			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
 			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
 		} else {
 			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
 				      dev->xfer_resolution);
-			i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
+			i2s_write_reg(dev->i2s_base, RFCR(ch_reg),
+				      dev->fifo_th - 1);
 			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
 			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
 			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
@@ -499,6 +502,7 @@ static int dw_configure_dai(struct dw_i2s_dev *dev,
 	 */
 	u32 comp1 = i2s_read_reg(dev->i2s_base, dev->i2s_reg_comp1);
 	u32 comp2 = i2s_read_reg(dev->i2s_base, dev->i2s_reg_comp2);
+	u32 fifo_depth = 1 << (1 + COMP1_FIFO_DEPTH_GLOBAL(comp1));
 	u32 idx;
 
 	if (dev->capability & DWC_I2S_RECORD &&
@@ -537,6 +541,7 @@ static int dw_configure_dai(struct dw_i2s_dev *dev,
 		dev->capability |= DW_I2S_SLAVE;
 	}
 
+	dev->fifo_th = fifo_depth / 2;
 	return 0;
 }
 
-- 
1.9.1
