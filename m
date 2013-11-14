From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 13/20] ASoC: davinci-mcasp: Rename private
	struct and it's users (dev -> mcasp)
Date: Thu, 14 Nov 2013 11:35:29 +0200
Message-ID: <1384421737-4467-14-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id EA5D526514F
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:36:11 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Rename the private struct from davinci_audio_dev to davinci_mcasp.
Change the local use of the pointer to this struct from *dev to *mcasp.

The aim is to have better readable code for the first look since having
dev->xxxx in the code when using the local private struct is a bit
surprising.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 418 +++++++++++++++++++-------------------
 1 file changed, 209 insertions(+), 209 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index ce1607b..bd85c98 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -35,7 +35,7 @@
 #include "davinci-pcm.h"
 #include "davinci-mcasp.h"
 
-struct davinci_audio_dev {
+struct davinci_mcasp {
 	struct davinci_pcm_dma_params dma_params[2];
 	void __iomem *base;
 	struct device *dev;
@@ -107,36 +107,36 @@ static void mcasp_set_ctl_reg(void __iomem *regs, u32 val)
 		printk(KERN_ERR "GBLCTL write error\n");
 }
 
-static void mcasp_start_rx(struct davinci_audio_dev *dev)
+static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 {
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXHCLKRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXCLKRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXSERCLR);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXBUF_REG, 0);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXHCLKRST);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXCLKRST);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXSERCLR);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_RXBUF_REG, 0);
 
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXBUF_REG, 0);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_RXBUF_REG, 0);
 
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
 }
 
-static void mcasp_start_tx(struct davinci_audio_dev *dev)
+static void mcasp_start_tx(struct davinci_mcasp *mcasp)
 {
 	u8 offset = 0, i;
 	u32 cnt;
 
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXSERCLR);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG, TXSERCLR);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXBUF_REG, 0);
 
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
-	for (i = 0; i < dev->num_serializer; i++) {
-		if (dev->serial_dir[i] == TX_MODE) {
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
+	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXBUF_REG, 0);
+	for (i = 0; i < mcasp->num_serializer; i++) {
+		if (mcasp->serial_dir[i] == TX_MODE) {
 			offset = i;
 			break;
 		}
@@ -144,116 +144,116 @@ static void mcasp_start_tx(struct davinci_audio_dev *dev)
 
 	/* wait for TX ready */
 	cnt = 0;
-	while (!(mcasp_get_reg(dev->base + DAVINCI_MCASP_XRSRCTL_REG(offset)) &
+	while (!(mcasp_get_reg(mcasp->base + DAVINCI_MCASP_XRSRCTL_REG(offset)) &
 		 TXSTATE) && (cnt < 100000))
 		cnt++;
 
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXBUF_REG, 0);
 }
 
-static void davinci_mcasp_start(struct davinci_audio_dev *dev, int stream)
+static void davinci_mcasp_start(struct davinci_mcasp *mcasp, int stream)
 {
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (dev->txnumevt) {	/* enable FIFO */
-			switch (dev->version) {
+		if (mcasp->txnumevt) {	/* enable FIFO */
+			switch (mcasp->version) {
 			case MCASP_VERSION_3:
-				mcasp_clr_bits(dev->base + MCASP_VER3_WFIFOCTL,
-								FIFO_ENABLE);
-				mcasp_set_bits(dev->base + MCASP_VER3_WFIFOCTL,
-								FIFO_ENABLE);
+				mcasp_clr_bits(mcasp->base + MCASP_VER3_WFIFOCTL,
+					       FIFO_ENABLE);
+				mcasp_set_bits(mcasp->base + MCASP_VER3_WFIFOCTL,
+					       FIFO_ENABLE);
 				break;
 			default:
-				mcasp_clr_bits(dev->base +
+				mcasp_clr_bits(mcasp->base +
 					DAVINCI_MCASP_WFIFOCTL,	FIFO_ENABLE);
-				mcasp_set_bits(dev->base +
+				mcasp_set_bits(mcasp->base +
 					DAVINCI_MCASP_WFIFOCTL,	FIFO_ENABLE);
 			}
 		}
-		mcasp_start_tx(dev);
+		mcasp_start_tx(mcasp);
 	} else {
-		if (dev->rxnumevt) {	/* enable FIFO */
-			switch (dev->version) {
+		if (mcasp->rxnumevt) {	/* enable FIFO */
+			switch (mcasp->version) {
 			case MCASP_VERSION_3:
-				mcasp_clr_bits(dev->base + MCASP_VER3_RFIFOCTL,
-								FIFO_ENABLE);
-				mcasp_set_bits(dev->base + MCASP_VER3_RFIFOCTL,
-								FIFO_ENABLE);
+				mcasp_clr_bits(mcasp->base + MCASP_VER3_RFIFOCTL,
+					       FIFO_ENABLE);
+				mcasp_set_bits(mcasp->base + MCASP_VER3_RFIFOCTL,
+					       FIFO_ENABLE);
 				break;
 			default:
-				mcasp_clr_bits(dev->base +
+				mcasp_clr_bits(mcasp->base +
 					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
-				mcasp_set_bits(dev->base +
+				mcasp_set_bits(mcasp->base +
 					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
 			}
 		}
-		mcasp_start_rx(dev);
+		mcasp_start_rx(mcasp);
 	}
 }
 
-static void mcasp_stop_rx(struct davinci_audio_dev *dev)
+static void mcasp_stop_rx(struct davinci_mcasp *mcasp)
 {
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, 0);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, 0);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
 }
 
-static void mcasp_stop_tx(struct davinci_audio_dev *dev)
+static void mcasp_stop_tx(struct davinci_mcasp *mcasp)
 {
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, 0);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG, 0);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
 }
 
-static void davinci_mcasp_stop(struct davinci_audio_dev *dev, int stream)
+static void davinci_mcasp_stop(struct davinci_mcasp *mcasp, int stream)
 {
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (dev->txnumevt) {	/* disable FIFO */
-			switch (dev->version) {
+		if (mcasp->txnumevt) {	/* disable FIFO */
+			switch (mcasp->version) {
 			case MCASP_VERSION_3:
-				mcasp_clr_bits(dev->base + MCASP_VER3_WFIFOCTL,
-								FIFO_ENABLE);
+				mcasp_clr_bits(mcasp->base + MCASP_VER3_WFIFOCTL,
+					       FIFO_ENABLE);
 				break;
 			default:
-				mcasp_clr_bits(dev->base +
+				mcasp_clr_bits(mcasp->base +
 					DAVINCI_MCASP_WFIFOCTL,	FIFO_ENABLE);
 			}
 		}
-		mcasp_stop_tx(dev);
+		mcasp_stop_tx(mcasp);
 	} else {
-		if (dev->rxnumevt) {	/* disable FIFO */
-			switch (dev->version) {
+		if (mcasp->rxnumevt) {	/* disable FIFO */
+			switch (mcasp->version) {
 			case MCASP_VERSION_3:
-				mcasp_clr_bits(dev->base + MCASP_VER3_RFIFOCTL,
-								FIFO_ENABLE);
+				mcasp_clr_bits(mcasp->base + MCASP_VER3_RFIFOCTL,
+					       FIFO_ENABLE);
 			break;
 
 			default:
-				mcasp_clr_bits(dev->base +
+				mcasp_clr_bits(mcasp->base +
 					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
 			}
 		}
-		mcasp_stop_rx(dev);
+		mcasp_stop_rx(mcasp);
 	}
 }
 
 static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 					 unsigned int fmt)
 {
-	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
-	void __iomem *base = dev->base;
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
+	void __iomem *base = mcasp->base;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_B:
 	case SND_SOC_DAIFMT_AC97:
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+		mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
 		break;
 	default:
 		/* configure a full-word SYNC pulse (LRCLK) */
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
 
 		/* make 1st data bit occur one ACLK cycle after the frame sync */
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, FSXDLY(1));
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, FSRDLY(1));
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_TXFMT_REG, FSXDLY(1));
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_RXFMT_REG, FSRDLY(1));
 		break;
 	}
 
@@ -342,25 +342,25 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
 {
-	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(dai);
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
 	switch (div_id) {
 	case 0:		/* MCLK divider */
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG,
+		mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_AHCLKXCTL_REG,
 			       AHCLKXDIV(div - 1), AHCLKXDIV_MASK);
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_AHCLKRCTL_REG,
+		mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_AHCLKRCTL_REG,
 			       AHCLKRDIV(div - 1), AHCLKRDIV_MASK);
 		break;
 
 	case 1:		/* BCLK divider */
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_ACLKXCTL_REG,
+		mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_ACLKXCTL_REG,
 			       ACLKXDIV(div - 1), ACLKXDIV_MASK);
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_ACLKRCTL_REG,
+		mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_ACLKRCTL_REG,
 			       ACLKRDIV(div - 1), ACLKRDIV_MASK);
 		break;
 
 	case 2:		/* BCLK/LRCLK ratio */
-		dev->bclk_lrclk_ratio = div;
+		mcasp->bclk_lrclk_ratio = div;
 		break;
 
 	default:
@@ -373,22 +373,22 @@ static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div
 static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 				    unsigned int freq, int dir)
 {
-	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(dai);
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
 	if (dir == SND_SOC_CLOCK_OUT) {
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG, AHCLKX);
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_PDIR_REG, AHCLKX);
 	} else {
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_PDIR_REG, AHCLKX);
+		mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
+		mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
+		mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_PDIR_REG, AHCLKX);
 	}
 
 	return 0;
 }
 
-static int davinci_config_channel_size(struct davinci_audio_dev *dev,
+static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
 				       int word_length)
 {
 	u32 fmt;
@@ -405,70 +405,70 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 	 * both left and right channels), so it has to be divided by number of
 	 * tdm-slots (for I2S - divided by 2).
 	 */
-	if (dev->bclk_lrclk_ratio)
-		word_length = dev->bclk_lrclk_ratio / dev->tdm_slots;
+	if (mcasp->bclk_lrclk_ratio)
+		word_length = mcasp->bclk_lrclk_ratio / mcasp->tdm_slots;
 
 	/* mapping of the XSSZ bit-field as described in the datasheet */
 	fmt = (word_length >> 1) - 1;
 
-	if (dev->op_mode != DAVINCI_MCASP_DIT_MODE) {
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
+	if (mcasp->op_mode != DAVINCI_MCASP_DIT_MODE) {
+		mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_RXFMT_REG,
 				RXSSZ(fmt), RXSSZ(0x0F));
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
+		mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_TXFMT_REG,
 				TXSSZ(fmt), TXSSZ(0x0F));
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
+		mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_TXFMT_REG,
 				TXROT(tx_rotate), TXROT(7));
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
+		mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_RXFMT_REG,
 				RXROT(rx_rotate), RXROT(7));
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG,
+		mcasp_set_reg(mcasp->base + DAVINCI_MCASP_RXMASK_REG,
 				mask);
 	}
 
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXMASK_REG, mask);
 
 	return 0;
 }
 
-static int davinci_hw_common_param(struct davinci_audio_dev *dev, int stream,
+static int davinci_hw_common_param(struct davinci_mcasp *mcasp, int stream,
 				    int channels)
 {
 	int i;
 	u8 tx_ser = 0;
 	u8 rx_ser = 0;
 	u8 ser;
-	u8 slots = dev->tdm_slots;
+	u8 slots = mcasp->tdm_slots;
 	u8 max_active_serializers = (channels + slots - 1) / slots;
 	/* Default configuration */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
+	mcasp_set_bits(mcasp->base + DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
 
 	/* All PINS as McASP */
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_PFUNC_REG, 0x00000000);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_PFUNC_REG, 0x00000000);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_XEVTCTL_REG,
+		mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
+		mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_XEVTCTL_REG,
 				TXDATADMADIS);
 	} else {
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_REVTCTL_REG,
+		mcasp_set_reg(mcasp->base + DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
+		mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_REVTCTL_REG,
 				RXDATADMADIS);
 	}
 
-	for (i = 0; i < dev->num_serializer; i++) {
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
-					dev->serial_dir[i]);
-		if (dev->serial_dir[i] == TX_MODE &&
+	for (i = 0; i < mcasp->num_serializer; i++) {
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_XRSRCTL_REG(i),
+					mcasp->serial_dir[i]);
+		if (mcasp->serial_dir[i] == TX_MODE &&
 					tx_ser < max_active_serializers) {
-			mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
+			mcasp_set_bits(mcasp->base + DAVINCI_MCASP_PDIR_REG,
 					AXR(i));
 			tx_ser++;
-		} else if (dev->serial_dir[i] == RX_MODE &&
+		} else if (mcasp->serial_dir[i] == RX_MODE &&
 					rx_ser < max_active_serializers) {
-			mcasp_clr_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
+			mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_PDIR_REG,
 					AXR(i));
 			rx_ser++;
 		} else {
-			mcasp_mod_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
+			mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_XRSRCTL_REG(i),
 					SRMOD_INACTIVE, SRMOD_MASK);
 		}
 	}
@@ -479,127 +479,127 @@ static int davinci_hw_common_param(struct davinci_audio_dev *dev, int stream,
 		ser = rx_ser;
 
 	if (ser < max_active_serializers) {
-		dev_warn(dev->dev, "stream has more channels (%d) than are "
+		dev_warn(mcasp->dev, "stream has more channels (%d) than are "
 			"enabled in mcasp (%d)\n", channels, ser * slots);
 		return -EINVAL;
 	}
 
-	if (dev->txnumevt && stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (dev->txnumevt * tx_ser > 64)
-			dev->txnumevt = 1;
+	if (mcasp->txnumevt && stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (mcasp->txnumevt * tx_ser > 64)
+			mcasp->txnumevt = 1;
 
-		switch (dev->version) {
+		switch (mcasp->version) {
 		case MCASP_VERSION_3:
-			mcasp_mod_bits(dev->base + MCASP_VER3_WFIFOCTL, tx_ser,
+			mcasp_mod_bits(mcasp->base + MCASP_VER3_WFIFOCTL, tx_ser,
 								NUMDMA_MASK);
-			mcasp_mod_bits(dev->base + MCASP_VER3_WFIFOCTL,
-				((dev->txnumevt * tx_ser) << 8), NUMEVT_MASK);
+			mcasp_mod_bits(mcasp->base + MCASP_VER3_WFIFOCTL,
+				((mcasp->txnumevt * tx_ser) << 8), NUMEVT_MASK);
 			break;
 		default:
-			mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+			mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_WFIFOCTL,
 							tx_ser,	NUMDMA_MASK);
-			mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
-				((dev->txnumevt * tx_ser) << 8), NUMEVT_MASK);
+			mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_WFIFOCTL,
+				((mcasp->txnumevt * tx_ser) << 8), NUMEVT_MASK);
 		}
 	}
 
-	if (dev->rxnumevt && stream == SNDRV_PCM_STREAM_CAPTURE) {
-		if (dev->rxnumevt * rx_ser > 64)
-			dev->rxnumevt = 1;
-		switch (dev->version) {
+	if (mcasp->rxnumevt && stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if (mcasp->rxnumevt * rx_ser > 64)
+			mcasp->rxnumevt = 1;
+		switch (mcasp->version) {
 		case MCASP_VERSION_3:
-			mcasp_mod_bits(dev->base + MCASP_VER3_RFIFOCTL, rx_ser,
+			mcasp_mod_bits(mcasp->base + MCASP_VER3_RFIFOCTL, rx_ser,
 								NUMDMA_MASK);
-			mcasp_mod_bits(dev->base + MCASP_VER3_RFIFOCTL,
-				((dev->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
+			mcasp_mod_bits(mcasp->base + MCASP_VER3_RFIFOCTL,
+				((mcasp->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
 			break;
 		default:
-			mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+			mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_RFIFOCTL,
 							rx_ser,	NUMDMA_MASK);
-			mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
-				((dev->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
+			mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_RFIFOCTL,
+				((mcasp->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
 		}
 	}
 
 	return 0;
 }
 
-static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
+static void davinci_hw_param(struct davinci_mcasp *mcasp, int stream)
 {
 	int i, active_slots;
 	u32 mask = 0;
 
-	active_slots = (dev->tdm_slots > 31) ? 32 : dev->tdm_slots;
+	active_slots = (mcasp->tdm_slots > 31) ? 32 : mcasp->tdm_slots;
 	for (i = 0; i < active_slots; i++)
 		mask |= (1 << i);
 
-	mcasp_clr_bits(dev->base + DAVINCI_MCASP_ACLKXCTL_REG, TX_ASYNC);
+	mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_ACLKXCTL_REG, TX_ASYNC);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* bit stream is MSB first  with no delay */
 		/* DSP_B mode */
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXTDM_REG, mask);
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXORD);
+		mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXTDM_REG, mask);
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_TXFMT_REG, TXORD);
 
-		if ((dev->tdm_slots >= 2) && (dev->tdm_slots <= 32))
-			mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG,
-					FSXMOD(dev->tdm_slots), FSXMOD(0x1FF));
+		if ((mcasp->tdm_slots >= 2) && (mcasp->tdm_slots <= 32))
+			mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_TXFMCTL_REG,
+					FSXMOD(mcasp->tdm_slots), FSXMOD(0x1FF));
 		else
 			printk(KERN_ERR "playback tdm slot %d not supported\n",
-				dev->tdm_slots);
+				mcasp->tdm_slots);
 	} else {
 		/* bit stream is MSB first with no delay */
 		/* DSP_B mode */
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXORD);
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXTDM_REG, mask);
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_RXFMT_REG, RXORD);
+		mcasp_set_reg(mcasp->base + DAVINCI_MCASP_RXTDM_REG, mask);
 
-		if ((dev->tdm_slots >= 2) && (dev->tdm_slots <= 32))
-			mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG,
-					FSRMOD(dev->tdm_slots), FSRMOD(0x1FF));
+		if ((mcasp->tdm_slots >= 2) && (mcasp->tdm_slots <= 32))
+			mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_RXFMCTL_REG,
+					FSRMOD(mcasp->tdm_slots), FSRMOD(0x1FF));
 		else
 			printk(KERN_ERR "capture tdm slot %d not supported\n",
-				dev->tdm_slots);
+				mcasp->tdm_slots);
 	}
 }
 
 /* S/PDIF */
-static void davinci_hw_dit_param(struct davinci_audio_dev *dev)
+static void davinci_hw_dit_param(struct davinci_mcasp *mcasp)
 {
 	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
 	   and LSB first */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
+	mcasp_set_bits(mcasp->base + DAVINCI_MCASP_TXFMT_REG,
 						TXROT(6) | TXSSZ(15));
 
 	/* Set TX frame synch : DIT Mode, 1 bit width, internal, rising edge */
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXFMCTL_REG,
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXFMCTL_REG,
 						AFSXE | FSXMOD(0x180));
 
 	/* Set the TX tdm : for all the slots */
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXTDM_REG, 0xFFFFFFFF);
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXTDM_REG, 0xFFFFFFFF);
 
 	/* Set the TX clock controls : div = 1 and internal */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_ACLKXCTL_REG,
+	mcasp_set_bits(mcasp->base + DAVINCI_MCASP_ACLKXCTL_REG,
 						ACLKXE | TX_ASYNC);
 
-	mcasp_clr_bits(dev->base + DAVINCI_MCASP_XEVTCTL_REG, TXDATADMADIS);
+	mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_XEVTCTL_REG, TXDATADMADIS);
 
 	/* Only 44100 and 48000 are valid, both have the same setting */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXDIV(3));
+	mcasp_set_bits(mcasp->base + DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXDIV(3));
 
 	/* Enable the DIT */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_TXDITCTL_REG, DITEN);
+	mcasp_set_bits(mcasp->base + DAVINCI_MCASP_TXDITCTL_REG, DITEN);
 }
 
 static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params,
 					struct snd_soc_dai *cpu_dai)
 {
-	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
 	struct davinci_pcm_dma_params *dma_params =
-					&dev->dma_params[substream->stream];
+					&mcasp->dma_params[substream->stream];
 	int word_length;
 	u8 fifo_level;
-	u8 slots = dev->tdm_slots;
+	u8 slots = mcasp->tdm_slots;
 	u8 active_serializers;
 	int channels;
 	struct snd_interval *pcm_channels = hw_param_interval(params,
@@ -608,17 +608,17 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 
 	active_serializers = (channels + slots - 1) / slots;
 
-	if (davinci_hw_common_param(dev, substream->stream, channels) == -EINVAL)
+	if (davinci_hw_common_param(mcasp, substream->stream, channels) == -EINVAL)
 		return -EINVAL;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		fifo_level = dev->txnumevt * active_serializers;
+		fifo_level = mcasp->txnumevt * active_serializers;
 	else
-		fifo_level = dev->rxnumevt * active_serializers;
+		fifo_level = mcasp->rxnumevt * active_serializers;
 
-	if (dev->op_mode == DAVINCI_MCASP_DIT_MODE)
-		davinci_hw_dit_param(dev);
+	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
+		davinci_hw_dit_param(mcasp);
 	else
-		davinci_hw_param(dev, substream->stream);
+		davinci_hw_param(mcasp, substream->stream);
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_U8:
@@ -652,13 +652,13 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (dev->version == MCASP_VERSION_2 && !fifo_level)
+	if (mcasp->version == MCASP_VERSION_2 && !fifo_level)
 		dma_params->acnt = 4;
 	else
 		dma_params->acnt = dma_params->data_type;
 
 	dma_params->fifo_level = fifo_level;
-	davinci_config_channel_size(dev, word_length);
+	davinci_config_channel_size(mcasp, word_length);
 
 	return 0;
 }
@@ -666,29 +666,29 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 				     int cmd, struct snd_soc_dai *cpu_dai)
 {
-	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
 	int ret = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ret = pm_runtime_get_sync(dev->dev);
+		ret = pm_runtime_get_sync(mcasp->dev);
 		if (IS_ERR_VALUE(ret))
-			dev_err(dev->dev, "pm_runtime_get_sync() failed\n");
-		davinci_mcasp_start(dev, substream->stream);
+			dev_err(mcasp->dev, "pm_runtime_get_sync() failed\n");
+		davinci_mcasp_start(mcasp, substream->stream);
 		break;
 
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		davinci_mcasp_stop(dev, substream->stream);
-		ret = pm_runtime_put_sync(dev->dev);
+		davinci_mcasp_stop(mcasp, substream->stream);
+		ret = pm_runtime_put_sync(mcasp->dev);
 		if (IS_ERR_VALUE(ret))
-			dev_err(dev->dev, "pm_runtime_put_sync() failed\n");
+			dev_err(mcasp->dev, "pm_runtime_put_sync() failed\n");
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		davinci_mcasp_stop(dev, substream->stream);
+		davinci_mcasp_stop(mcasp, substream->stream);
 		break;
 
 	default:
@@ -701,9 +701,9 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
-	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(dai);
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
-	snd_soc_dai_set_dma_data(dai, substream, dev->dma_params);
+	snd_soc_dai_set_dma_data(dai, substream, mcasp->dma_params);
 	return 0;
 }
 
@@ -915,7 +915,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	struct davinci_pcm_dma_params *dma_data;
 	struct resource *mem, *ioarea, *res, *dat;
 	struct snd_platform_data *pdata;
-	struct davinci_audio_dev *dev;
+	struct davinci_mcasp *mcasp;
 	int ret;
 
 	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
@@ -923,9 +923,9 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_audio_dev),
+	mcasp = devm_kzalloc(&pdev->dev, sizeof(struct davinci_mcasp),
 			   GFP_KERNEL);
-	if (!dev)
+	if (!mcasp)
 		return	-ENOMEM;
 
 	pdata = davinci_mcasp_set_pdata_from_of(pdev);
@@ -936,7 +936,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (!mem) {
-		dev_warn(dev->dev,
+		dev_warn(mcasp->dev,
 			 "\"mpu\" mem resource not found, using index 0\n");
 		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!mem) {
@@ -960,27 +960,27 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dev->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (!dev->base) {
+	mcasp->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
+	if (!mcasp->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENOMEM;
 		goto err_release_clk;
 	}
 
-	dev->op_mode = pdata->op_mode;
-	dev->tdm_slots = pdata->tdm_slots;
-	dev->num_serializer = pdata->num_serializer;
-	dev->serial_dir = pdata->serial_dir;
-	dev->version = pdata->version;
-	dev->txnumevt = pdata->txnumevt;
-	dev->rxnumevt = pdata->rxnumevt;
-	dev->dev = &pdev->dev;
+	mcasp->op_mode = pdata->op_mode;
+	mcasp->tdm_slots = pdata->tdm_slots;
+	mcasp->num_serializer = pdata->num_serializer;
+	mcasp->serial_dir = pdata->serial_dir;
+	mcasp->version = pdata->version;
+	mcasp->txnumevt = pdata->txnumevt;
+	mcasp->rxnumevt = pdata->rxnumevt;
+	mcasp->dev = &pdev->dev;
 
 	dat = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dat");
 	if (!dat)
 		dat = mem;
 
-	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
+	dma_data = &mcasp->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->sram_pool = pdata->sram_pool;
@@ -993,7 +993,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	else
 		dma_data->channel = pdata->tx_dma_channel;
 
-	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_CAPTURE];
+	dma_data = &mcasp->dma_params[SNDRV_PCM_STREAM_CAPTURE];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->sram_pool = pdata->sram_pool;
@@ -1006,7 +1006,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	else
 		dma_data->channel = pdata->rx_dma_channel;
 
-	dev_set_drvdata(&pdev->dev, dev);
+	dev_set_drvdata(&pdev->dev, mcasp);
 	ret = snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
 					 &davinci_mcasp_dai[pdata->op_mode], 1);
 
@@ -1044,32 +1044,32 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int davinci_mcasp_suspend(struct device *dev)
 {
-	struct davinci_audio_dev *a = dev_get_drvdata(dev);
-	void __iomem *base = a->base;
+	struct davinci_mcasp *mcasp = dev_get_drvdata(dev);
+	void __iomem *base = mcasp->base;
 
-	a->context.txfmtctl = mcasp_get_reg(base + DAVINCI_MCASP_TXFMCTL_REG);
-	a->context.rxfmtctl = mcasp_get_reg(base + DAVINCI_MCASP_RXFMCTL_REG);
-	a->context.txfmt = mcasp_get_reg(base + DAVINCI_MCASP_TXFMT_REG);
-	a->context.rxfmt = mcasp_get_reg(base + DAVINCI_MCASP_RXFMT_REG);
-	a->context.aclkxctl = mcasp_get_reg(base + DAVINCI_MCASP_ACLKXCTL_REG);
-	a->context.aclkrctl = mcasp_get_reg(base + DAVINCI_MCASP_ACLKRCTL_REG);
-	a->context.pdir = mcasp_get_reg(base + DAVINCI_MCASP_PDIR_REG);
+	mcasp->context.txfmtctl = mcasp_get_reg(base + DAVINCI_MCASP_TXFMCTL_REG);
+	mcasp->context.rxfmtctl = mcasp_get_reg(base + DAVINCI_MCASP_RXFMCTL_REG);
+	mcasp->context.txfmt = mcasp_get_reg(base + DAVINCI_MCASP_TXFMT_REG);
+	mcasp->context.rxfmt = mcasp_get_reg(base + DAVINCI_MCASP_RXFMT_REG);
+	mcasp->context.aclkxctl = mcasp_get_reg(base + DAVINCI_MCASP_ACLKXCTL_REG);
+	mcasp->context.aclkrctl = mcasp_get_reg(base + DAVINCI_MCASP_ACLKRCTL_REG);
+	mcasp->context.pdir = mcasp_get_reg(base + DAVINCI_MCASP_PDIR_REG);
 
 	return 0;
 }
 
 static int davinci_mcasp_resume(struct device *dev)
 {
-	struct davinci_audio_dev *a = dev_get_drvdata(dev);
-	void __iomem *base = a->base;
-
-	mcasp_set_reg(base + DAVINCI_MCASP_TXFMCTL_REG, a->context.txfmtctl);
-	mcasp_set_reg(base + DAVINCI_MCASP_RXFMCTL_REG, a->context.rxfmtctl);
-	mcasp_set_reg(base + DAVINCI_MCASP_TXFMT_REG, a->context.txfmt);
-	mcasp_set_reg(base + DAVINCI_MCASP_RXFMT_REG, a->context.rxfmt);
-	mcasp_set_reg(base + DAVINCI_MCASP_ACLKXCTL_REG, a->context.aclkxctl);
-	mcasp_set_reg(base + DAVINCI_MCASP_ACLKRCTL_REG, a->context.aclkrctl);
-	mcasp_set_reg(base + DAVINCI_MCASP_PDIR_REG, a->context.pdir);
+	struct davinci_mcasp *mcasp = dev_get_drvdata(dev);
+	void __iomem *base = mcasp->base;
+
+	mcasp_set_reg(base + DAVINCI_MCASP_TXFMCTL_REG, mcasp->context.txfmtctl);
+	mcasp_set_reg(base + DAVINCI_MCASP_RXFMCTL_REG, mcasp->context.rxfmtctl);
+	mcasp_set_reg(base + DAVINCI_MCASP_TXFMT_REG, mcasp->context.txfmt);
+	mcasp_set_reg(base + DAVINCI_MCASP_RXFMT_REG, mcasp->context.rxfmt);
+	mcasp_set_reg(base + DAVINCI_MCASP_ACLKXCTL_REG, mcasp->context.aclkxctl);
+	mcasp_set_reg(base + DAVINCI_MCASP_ACLKRCTL_REG, mcasp->context.aclkrctl);
+	mcasp_set_reg(base + DAVINCI_MCASP_PDIR_REG, mcasp->context.pdir);
 
 	return 0;
 }
-- 
1.8.4.2
