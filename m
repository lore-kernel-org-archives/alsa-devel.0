From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3] ASoC: davinci-mcasp: Add overrun/underrun
	event handling
Date: Wed, 12 Nov 2014 16:38:05 +0200
Message-ID: <1415803085-24143-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id E4CF4265675
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 15:38:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

An underrun (playback) event occurs when the serializer transfer
data from the XRBUF buffer to the XRSR shift register, but the
XRBUF hasn't been filled. Similarly, the overrun (capture) event
occurs when data from the XRSR shift register is transferred to
the XRBUF but it hasn't been read yet.

These events are handled as XRUN events that cause the pcm to stop.
The stream has to be explicitly restarted by the userspace which
ensures that after stopping/starting McASP the data transfer is
aligned with DMA. The other possibility was to internally stop and
start McASP without DMA even knowing about it.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Chanhes since v2:
- From interrupt handler return IRQ_HANDLED or IRQ_NONE depending on if we have
  handled event or not.

Changes since v1:
- only ack handled interrupt (over/underflow at the moment)
- Use variable to keep track of requested irq sources for future use
- print warning in case of not handled interrupt.

Regards,
Peter

 .../bindings/sound/davinci-mcasp-audio.txt         |   2 +-
 sound/soc/davinci/davinci-mcasp.c                  | 124 +++++++++++++++++++++
 sound/soc/davinci/davinci-mcasp.h                  |  11 ++
 3 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index 60ca07996458..46bc9829c71a 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -32,7 +32,7 @@ Optional properties:
 - rx-num-evt : FIFO levels.
 - sram-size-playback : size of sram to be allocated during playback
 - sram-size-capture  : size of sram to be allocated during capture
-- interrupts : Interrupt numbers for McASP, currently not used by the driver
+- interrupts : Interrupt numbers for McASP
 - interrupt-names : Known interrupt names are "tx" and "rx"
 - pinctrl-0: Should specify pin control group used for this controller.
 - pinctrl-names: Should contain only one value - "default", for more details
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 6b15a974f585..9de954a24160 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -70,6 +70,7 @@ struct davinci_mcasp {
 	void __iomem *base;
 	u32 fifo_base;
 	struct device *dev;
+	struct snd_pcm_substream *substreams[2];
 
 	/* McASP specific data */
 	int	tdm_slots;
@@ -80,6 +81,7 @@ struct davinci_mcasp {
 	u8	bclk_div;
 	u16	bclk_lrclk_ratio;
 	int	streams;
+	u32	irq_request[2];
 
 	int	sysclk_freq;
 	bool	bclk_master;
@@ -185,6 +187,10 @@ static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
 	if (mcasp_is_synchronous(mcasp))
 		mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
+
+	/* enable receive IRQs */
+	mcasp_set_bits(mcasp, DAVINCI_MCASP_EVTCTLR_REG,
+		       mcasp->irq_request[SNDRV_PCM_STREAM_CAPTURE]);
 }
 
 static void mcasp_start_tx(struct davinci_mcasp *mcasp)
@@ -214,6 +220,10 @@ static void mcasp_start_tx(struct davinci_mcasp *mcasp)
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
 	/* Release Frame Sync generator */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
+
+	/* enable transmit IRQs */
+	mcasp_set_bits(mcasp, DAVINCI_MCASP_EVTCTLX_REG,
+		       mcasp->irq_request[SNDRV_PCM_STREAM_PLAYBACK]);
 }
 
 static void davinci_mcasp_start(struct davinci_mcasp *mcasp, int stream)
@@ -228,6 +238,10 @@ static void davinci_mcasp_start(struct davinci_mcasp *mcasp, int stream)
 
 static void mcasp_stop_rx(struct davinci_mcasp *mcasp)
 {
+	/* disable IRQ sources */
+	mcasp_clr_bits(mcasp, DAVINCI_MCASP_EVTCTLR_REG,
+		       mcasp->irq_request[SNDRV_PCM_STREAM_CAPTURE]);
+
 	/*
 	 * In synchronous mode stop the TX clocks if no other stream is
 	 * running
@@ -249,6 +263,10 @@ static void mcasp_stop_tx(struct davinci_mcasp *mcasp)
 {
 	u32 val = 0;
 
+	/* disable IRQ sources */
+	mcasp_clr_bits(mcasp, DAVINCI_MCASP_EVTCTLX_REG,
+		       mcasp->irq_request[SNDRV_PCM_STREAM_PLAYBACK]);
+
 	/*
 	 * In synchronous mode keep TX clocks running if the capture stream is
 	 * still running.
@@ -276,6 +294,76 @@ static void davinci_mcasp_stop(struct davinci_mcasp *mcasp, int stream)
 		mcasp_stop_rx(mcasp);
 }
 
+static irqreturn_t davinci_mcasp_tx_irq_handler(int irq, void *data)
+{
+	struct davinci_mcasp *mcasp = (struct davinci_mcasp *)data;
+	struct snd_pcm_substream *substream;
+	u32 irq_mask = mcasp->irq_request[SNDRV_PCM_STREAM_PLAYBACK];
+	u32 handled_mask = 0;
+	u32 stat;
+
+	stat = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG);
+	if (stat & XUNDRN & irq_mask) {
+		dev_warn(mcasp->dev, "Transmit buffer underflow\n");
+		handled_mask |= XUNDRN;
+
+		substream = mcasp->substreams[SNDRV_PCM_STREAM_PLAYBACK];
+		if (substream) {
+			snd_pcm_stream_lock_irq(substream);
+			if (snd_pcm_running(substream))
+				snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+			snd_pcm_stream_unlock_irq(substream);
+		}
+	}
+
+	if (!handled_mask)
+		dev_warn(mcasp->dev, "unhandled tx event. txstat: 0x%08x\n",
+			 stat);
+
+	if (stat & XRERR)
+		handled_mask |= XRERR;
+
+	/* Ack the handled event only */
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, handled_mask);
+
+	return IRQ_RETVAL(handled_mask);
+}
+
+static irqreturn_t davinci_mcasp_rx_irq_handler(int irq, void *data)
+{
+	struct davinci_mcasp *mcasp = (struct davinci_mcasp *)data;
+	struct snd_pcm_substream *substream;
+	u32 irq_mask = mcasp->irq_request[SNDRV_PCM_STREAM_CAPTURE];
+	u32 handled_mask = 0;
+	u32 stat;
+
+	stat = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXSTAT_REG);
+	if (stat & ROVRN & irq_mask) {
+		dev_warn(mcasp->dev, "Receive buffer overflow\n");
+		handled_mask |= ROVRN;
+
+		substream = mcasp->substreams[SNDRV_PCM_STREAM_CAPTURE];
+		if (substream) {
+			snd_pcm_stream_lock_irq(substream);
+			if (snd_pcm_running(substream))
+				snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+			snd_pcm_stream_unlock_irq(substream);
+		}
+	}
+
+	if (!handled_mask)
+		dev_warn(mcasp->dev, "unhandled rx event. rxstat: 0x%08x\n",
+			 stat);
+
+	if (stat & XRERR)
+		handled_mask |= XRERR;
+
+	/* Ack the handled event only */
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXSTAT_REG, handled_mask);
+
+	return IRQ_RETVAL(handled_mask);
+}
+
 static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 					 unsigned int fmt)
 {
@@ -878,6 +966,8 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	u32 max_channels = 0;
 	int i, dir;
 
+	mcasp->substreams[substream->stream] = substream;
+
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
 		return 0;
 
@@ -916,6 +1006,8 @@ static void davinci_mcasp_shutdown(struct snd_pcm_substream *substream,
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
 
+	mcasp->substreams[substream->stream] = NULL;
+
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
 		return;
 
@@ -1266,6 +1358,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	struct resource *mem, *ioarea, *res, *dat;
 	struct davinci_mcasp_pdata *pdata;
 	struct davinci_mcasp *mcasp;
+	char *irq_name;
+	int irq;
 	int ret;
 
 	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
@@ -1346,6 +1440,36 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	mcasp->dev = &pdev->dev;
 
+	irq = platform_get_irq_byname(pdev, "rx");
+	if (irq >= 0) {
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_rx\n",
+					  dev_name(&pdev->dev));
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						davinci_mcasp_rx_irq_handler,
+						IRQF_ONESHOT, irq_name, mcasp);
+		if (ret) {
+			dev_err(&pdev->dev, "RX IRQ request failed\n");
+			goto err;
+		}
+
+		mcasp->irq_request[SNDRV_PCM_STREAM_CAPTURE] = ROVRN;
+	}
+
+	irq = platform_get_irq_byname(pdev, "tx");
+	if (irq >= 0) {
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_tx\n",
+					  dev_name(&pdev->dev));
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						davinci_mcasp_tx_irq_handler,
+						IRQF_ONESHOT, irq_name, mcasp);
+		if (ret) {
+			dev_err(&pdev->dev, "TX IRQ request failed\n");
+			goto err;
+		}
+
+		mcasp->irq_request[SNDRV_PCM_STREAM_PLAYBACK] = XUNDRN;
+	}
+
 	dat = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dat");
 	if (dat)
 		mcasp->dat_port = true;
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 9737108f0305..79dc511180bf 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -256,6 +256,7 @@
  * DAVINCI_MCASP_TXSTAT_REG - Transmitter Status Register Bits
  * DAVINCI_MCASP_RXSTAT_REG - Receiver Status Register Bits
  */
+#define XRERR		BIT(8) /* Transmit/Receive error */
 #define XRDATA		BIT(5) /* Transmit/Receive data ready */
 
 /*
@@ -285,6 +286,16 @@
 #define TXDATADMADIS	BIT(0)
 
 /*
+ * DAVINCI_MCASP_EVTCTLR_REG - Receiver Interrupt Control Register Bits
+ */
+#define ROVRN		BIT(0)
+
+/*
+ * DAVINCI_MCASP_EVTCTLX_REG - Transmitter Interrupt Control Register Bits
+ */
+#define XUNDRN		BIT(0)
+
+/*
  * DAVINCI_MCASP_W[R]FIFOCTL - Write/Read FIFO Control Register bits
  */
 #define FIFO_ENABLE	BIT(16)
-- 
2.1.3
