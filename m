From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 5/7] snd-atmel-ac97c: enable interrupts to
	catch events for error reporting
Date: Tue, 24 Mar 2009 13:47:48 +0100
Message-ID: <1237898870-15780-6-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1237898870-15780-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-4-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-5-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 313AC103834
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 13:47:53 +0100 (CET)
In-Reply-To: <1237898870-15780-5-git-send-email-hans-christian.egtvedt@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch will enable interrupts from AC97C and report about error
conditions that occurs.

On channel A both overrun and underrun will be enabled depending if
playback and/or capture are enabled. On the control channel the overrun
interrupt is enabled.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 sound/atmel/ac97c.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 9748225..7c7521b 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -66,6 +66,7 @@ struct atmel_ac97c {
 	/* Serialize access to opened variable */
 	spinlock_t			lock;
 	void __iomem			*regs;
+	int				irq;
 	int				opened;
 	int				reset_pin;
 };
@@ -335,8 +336,16 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 		return -EINVAL;
 	}
 
+	/* Enable underrun interrupt on channel A */
+	word |= AC97C_CSR_UNRUN;
+
 	ac97c_writel(chip, CAMR, word);
 
+	/* Enable channel A event interrupt */
+	word = ac97c_readl(chip, IMR);
+	word |= AC97C_SR_CAEVT;
+	ac97c_writel(chip, IER, word);
+
 	/* set variable rate if needed */
 	if (runtime->rate != 48000) {
 		word = ac97c_readl(chip, MR);
@@ -402,8 +411,16 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 		return -EINVAL;
 	}
 
+	/* Enable overrun interrupt on channel A */
+	word |= AC97C_CSR_OVRUN;
+
 	ac97c_writel(chip, CAMR, word);
 
+	/* Enable channel A event interrupt */
+	word = ac97c_readl(chip, IMR);
+	word |= AC97C_SR_CAEVT;
+	ac97c_writel(chip, IER, word);
+
 	/* set variable rate if needed */
 	if (runtime->rate != 48000) {
 		word = ac97c_readl(chip, MR);
@@ -554,6 +571,43 @@ static struct snd_pcm_ops atmel_ac97_capture_ops = {
 	.pointer	= atmel_ac97c_capture_pointer,
 };
 
+static irqreturn_t atmel_ac97c_interrupt(int irq, void *dev)
+{
+	struct atmel_ac97c	*chip  = (struct atmel_ac97c *)dev;
+	irqreturn_t		retval = IRQ_NONE;
+	u32			sr     = ac97c_readl(chip, SR);
+	u32			casr   = ac97c_readl(chip, CASR);
+	u32			cosr   = ac97c_readl(chip, COSR);
+
+	if (sr & AC97C_SR_CAEVT) {
+		dev_info(&chip->pdev->dev, "channel A event%s%s%s%s%s%s\n",
+				casr & AC97C_CSR_OVRUN   ? " OVRUN"   : "",
+				casr & AC97C_CSR_RXRDY   ? " RXRDY"   : "",
+				casr & AC97C_CSR_UNRUN   ? " UNRUN"   : "",
+				casr & AC97C_CSR_TXEMPTY ? " TXEMPTY" : "",
+				casr & AC97C_CSR_TXRDY   ? " TXRDY"   : "",
+				!casr                    ? " NONE"    : "");
+		retval = IRQ_HANDLED;
+	}
+
+	if (sr & AC97C_SR_COEVT) {
+		dev_info(&chip->pdev->dev, "codec channel event%s%s%s%s%s\n",
+				cosr & AC97C_CSR_OVRUN   ? " OVRUN"   : "",
+				cosr & AC97C_CSR_RXRDY   ? " RXRDY"   : "",
+				cosr & AC97C_CSR_TXEMPTY ? " TXEMPTY" : "",
+				cosr & AC97C_CSR_TXRDY   ? " TXRDY"   : "",
+				!cosr                    ? " NONE"    : "");
+		retval = IRQ_HANDLED;
+	}
+
+	if (retval == IRQ_NONE) {
+		dev_err(&chip->pdev->dev, "spurious interrupt sr 0x%08x "
+				"casr 0x%08x cosr 0x%08x\n", sr, casr, cosr);
+	}
+
+	return retval;
+}
+
 static int __devinit atmel_ac97c_pcm_new(struct atmel_ac97c *chip)
 {
 	struct snd_pcm		*pcm;
@@ -701,6 +755,7 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 		.read	= atmel_ac97c_read,
 	};
 	int				retval;
+	int				irq;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
@@ -714,6 +769,12 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_dbg(&pdev->dev, "could not get irq\n");
+		return -ENXIO;
+	}
+
 	pclk = clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(pclk)) {
 		dev_dbg(&pdev->dev, "no peripheral clock\n");
@@ -730,6 +791,13 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 
 	chip = get_chip(card);
 
+	retval = request_irq(irq, atmel_ac97c_interrupt, 0, "AC97C", chip);
+	if (retval) {
+		dev_dbg(&pdev->dev, "unable to request irq %d\n", irq);
+		goto err_request_irq;
+	}
+	chip->irq = irq;
+
 	spin_lock_init(&chip->lock);
 
 	strcpy(card->driver, "Atmel AC97C");
@@ -758,6 +826,10 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 
 	snd_card_set_dev(card, &pdev->dev);
 
+	/* Enable overrun interrupt from codec channel */
+	ac97c_writel(chip, COMR, AC97C_CSR_OVRUN);
+	ac97c_writel(chip, IER, ac97c_readl(chip, IMR) | AC97C_SR_COEVT);
+
 	retval = snd_ac97_bus(card, 0, &ops, chip, &chip->ac97_bus);
 	if (retval) {
 		dev_dbg(&pdev->dev, "could not register on ac97 bus\n");
@@ -820,7 +892,7 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 	retval = snd_card_register(card);
 	if (retval) {
 		dev_dbg(&pdev->dev, "could not register sound card\n");
-		goto err_ac97_bus;
+		goto err_dma;
 	}
 
 	platform_set_drvdata(pdev, card);
@@ -847,6 +919,8 @@ err_ac97_bus:
 
 	iounmap(chip->regs);
 err_ioremap:
+	free_irq(irq, chip);
+err_request_irq:
 	snd_card_free(card);
 err_snd_card_new:
 	clk_disable(pclk);
@@ -898,6 +972,7 @@ static int __devexit atmel_ac97c_remove(struct platform_device *pdev)
 	clk_disable(chip->pclk);
 	clk_put(chip->pclk);
 	iounmap(chip->regs);
+	free_irq(chip->irq, chip);
 
 	if (test_bit(DMA_RX_CHAN_PRESENT, &chip->flags))
 		dma_release_channel(chip->dma.rx_chan);
-- 
1.5.6.3
