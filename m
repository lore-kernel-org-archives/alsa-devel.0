From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/2] opti9xx: remove snd_opti9xx fields
Date: Wed, 2 Dec 2009 18:13:42 +0100
Message-ID: <20091202181342.c7815915.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8990547949421459273=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 8694710380E
	for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2009 18:11:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============8990547949421459273==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove snd_opti9xx fields which are indirect arguments to
the snd_opti9xx_configure(). Pass these values as function
arguments.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/opti9xx/opti92x-ad1848.c |  118 ++++++++++++++----------------------
 1 files changed, 45 insertions(+), 73 deletions(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 7c97ca8..a4247f7 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -141,16 +141,6 @@ struct snd_opti9xx {
 
 	spinlock_t lock;
 
-	long wss_base;
-	int irq;
-	int dma1;
-	int dma2;
-
-	long fm_port;
-
-	long mpu_port;
-	int mpu_irq;
-
 #ifdef CONFIG_PNP
 	struct pnp_dev *dev;
 	struct pnp_dev *devmpu;
@@ -216,14 +206,6 @@ static int __devinit snd_opti9xx_init(struct snd_opti9xx *chip,
 
 	spin_lock_init(&chip->lock);
 
-	chip->wss_base = -1;
-	chip->irq = -1;
-	chip->dma1 = -1;
-	chip->dma2 = -1;
-	chip->fm_port = -1;
-	chip->mpu_port = -1;
-	chip->mpu_irq = -1;
-
 	switch (hardware) {
 #ifndef OPTi93X
 	case OPTi9XX_HW_82C928:
@@ -348,7 +330,10 @@ static void snd_opti9xx_write(struct snd_opti9xx *chip, unsigned char reg,
 		(snd_opti9xx_read(chip, reg) & ~(mask)) | ((value) & (mask)))
 
 
-static int __devinit snd_opti9xx_configure(struct snd_opti9xx *chip)
+static int __devinit snd_opti9xx_configure(struct snd_opti9xx *chip,
+					   long wss_base,
+					   int irq, int dma1, int dma2,
+					   long mpu_port, int mpu_irq)
 {
 	unsigned char wss_base_bits;
 	unsigned char irq_bits;
@@ -416,7 +401,7 @@ static int __devinit snd_opti9xx_configure(struct snd_opti9xx *chip)
 		return -EINVAL;
 	}
 
-	switch (chip->wss_base) {
+	switch (wss_base) {
 	case 0x530:
 		wss_base_bits = 0x00;
 		break;
@@ -430,14 +415,13 @@ static int __devinit snd_opti9xx_configure(struct snd_opti9xx *chip)
 		wss_base_bits = 0x02;
 		break;
 	default:
-		snd_printk(KERN_WARNING "WSS port 0x%lx not valid\n",
-			   chip->wss_base);
+		snd_printk(KERN_WARNING "WSS port 0x%lx not valid\n", wss_base);
 		goto __skip_base;
 	}
 	snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(1), wss_base_bits << 4, 0x30);
 
 __skip_base:
-	switch (chip->irq) {
+	switch (irq) {
 //#ifdef OPTi93X
 	case 5:
 		irq_bits = 0x05;
@@ -456,11 +440,11 @@ __skip_base:
 		irq_bits = 0x04;
 		break;
 	default:
-		snd_printk(KERN_WARNING "WSS irq # %d not valid\n", chip->irq);
+		snd_printk(KERN_WARNING "WSS irq # %d not valid\n", irq);
 		goto __skip_resources;
 	}
 
-	switch (chip->dma1) {
+	switch (dma1) {
 	case 0:
 		dma_bits = 0x01;
 		break;
@@ -471,38 +455,36 @@ __skip_base:
 		dma_bits = 0x03;
 		break;
 	default:
-		snd_printk(KERN_WARNING "WSS dma1 # %d not valid\n",
-			   chip->dma1);
+		snd_printk(KERN_WARNING "WSS dma1 # %d not valid\n", dma1);
 		goto __skip_resources;
 	}
 
 #if defined(CS4231) || defined(OPTi93X)
-	if (chip->dma1 == chip->dma2) {
+	if (dma1 == dma2) {
 		snd_printk(KERN_ERR "don't want to share dmas\n");
 		return -EBUSY;
 	}
 
-	switch (chip->dma2) {
+	switch (dma2) {
 	case 0:
 	case 1:
 		break;
 	default:
-		snd_printk(KERN_WARNING "WSS dma2 # %d not valid\n",
-			   chip->dma2);
+		snd_printk(KERN_WARNING "WSS dma2 # %d not valid\n", dma2);
 		goto __skip_resources;
 	}
 	dma_bits |= 0x04;
 #endif	/* CS4231 || OPTi93X */
 
 #ifndef OPTi93X
-	 outb(irq_bits << 3 | dma_bits, chip->wss_base);
+	 outb(irq_bits << 3 | dma_bits, wss_base);
 #else /* OPTi93X */
 	snd_opti9xx_write(chip, OPTi9XX_MC_REG(3), (irq_bits << 3 | dma_bits));
 #endif /* OPTi93X */
 
 __skip_resources:
 	if (chip->hardware > OPTi9XX_HW_82C928) {
-		switch (chip->mpu_port) {
+		switch (mpu_port) {
 		case 0:
 		case -1:
 			break;
@@ -520,12 +502,11 @@ __skip_resources:
 			break;
 		default:
 			snd_printk(KERN_WARNING
-				   "MPU-401 port 0x%lx not valid\n",
-				chip->mpu_port);
+				   "MPU-401 port 0x%lx not valid\n", mpu_port);
 			goto __skip_mpu;
 		}
 
-		switch (chip->mpu_irq) {
+		switch (mpu_irq) {
 		case 5:
 			mpu_irq_bits = 0x02;
 			break;
@@ -540,12 +521,12 @@ __skip_resources:
 			break;
 		default:
 			snd_printk(KERN_WARNING "MPU-401 irq # %d not valid\n",
-				chip->mpu_irq);
+				   mpu_irq);
 			goto __skip_mpu;
 		}
 
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(6),
-			(chip->mpu_port <= 0) ? 0x00 :
+			(mpu_port <= 0) ? 0x00 :
 				0x80 | mpu_port_bits << 5 | mpu_irq_bits << 3,
 			0xf8);
 	}
@@ -704,6 +685,7 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 {
 	static long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
 	int error;
+	int xdma2;
 	struct snd_opti9xx *chip = card->private_data;
 	struct snd_wss *codec;
 #ifdef CS4231
@@ -718,39 +700,33 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 						"OPTi9xx MC")) == NULL)
 		return -ENOMEM;
 
-	chip->wss_base = port;
-	chip->fm_port = fm_port;
-	chip->mpu_port = mpu_port;
-	chip->irq = irq;
-	chip->mpu_irq = mpu_irq;
-	chip->dma1 = dma1;
 #if defined(CS4231) || defined(OPTi93X)
-	chip->dma2 = dma2;
+	xdma2 = dma2;
 #else
-	chip->dma2 = -1;
+	xdma2 = -1;
 #endif
 
-	if (chip->wss_base == SNDRV_AUTO_PORT) {
-		chip->wss_base = snd_legacy_find_free_ioport(possible_ports, 4);
-		if (chip->wss_base < 0) {
+	if (port == SNDRV_AUTO_PORT) {
+		port = snd_legacy_find_free_ioport(possible_ports, 4);
+		if (port < 0) {
 			snd_printk(KERN_ERR "unable to find a free WSS port\n");
 			return -EBUSY;
 		}
 	}
-	error = snd_opti9xx_configure(chip);
+	error = snd_opti9xx_configure(chip, port, irq, dma1, xdma2,
+				      mpu_port, mpu_irq);
 	if (error)
 		return error;
 
 #ifdef OPTi93X
-	error = request_irq(chip->irq, snd_opti93x_interrupt,
+	error = request_irq(irq, snd_opti93x_interrupt,
 			    IRQF_DISABLED, DEV_NAME" - WSS", chip);
 	if (error < 0) {
-		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", chip->irq);
+		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", irq);
 		return error;
 	}
 #endif
-	error = snd_wss_create(card, chip->wss_base + 4, -1,
-			       chip->irq, chip->dma1, chip->dma2,
+	error = snd_wss_create(card, port + 4, -1, irq, dma1, xdma2,
 #ifdef OPTi93X
 			       WSS_HW_OPTI93X, WSS_HWSHARE_IRQ,
 #else
@@ -759,7 +735,7 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 			       &codec);
 	if (error < 0) {
 #ifdef OPTi93X
-		free_irq(chip->irq, chip);
+		free_irq(irq, chip);
 #endif
 		return error;
 	}
@@ -781,24 +757,24 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 	sprintf(card->shortname, "OPTi %s", card->driver);
 #if defined(CS4231) || defined(OPTi93X)
 	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d&%d",
-		card->shortname, pcm->name, chip->wss_base + 4,
-		chip->irq, chip->dma1, chip->dma2);
+		card->shortname, pcm->name, port + 4, irq, dma1, xdma2);
 #else
 	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",
-		card->shortname, pcm->name, chip->wss_base + 4,
-		chip->irq, chip->dma1);
+		card->shortname, pcm->name, port + 4, irq, dma1);
 #endif	/* CS4231 || OPTi93X */
 
-	if (chip->mpu_port <= 0 || chip->mpu_port == SNDRV_AUTO_PORT)
+	if (mpu_port <= 0 || mpu_port == SNDRV_AUTO_PORT)
 		rmidi = NULL;
-	else
-		if ((error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
-				chip->mpu_port, 0, chip->mpu_irq, IRQF_DISABLED,
-				&rmidi)))
+	else {
+		error = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
+				mpu_port, 0, mpu_irq, IRQF_DISABLED,
+				&rmidi);
+		if (error)
 			snd_printk(KERN_WARNING "no MPU-401 device at 0x%lx?\n",
-				   chip->mpu_port);
+				   mpu_port);
+	}
 
-	if (chip->fm_port > 0 && chip->fm_port != SNDRV_AUTO_PORT) {
+	if (fm_port > 0 && fm_port != SNDRV_AUTO_PORT) {
 		struct snd_opl3 *opl3 = NULL;
 #ifndef OPTi93X
 		if (chip->hardware == OPTi9XX_HW_82C928 ||
@@ -808,9 +784,7 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 			/* assume we have an OPL4 */
 			snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(2),
 					       0x20, 0x20);
-			if (snd_opl4_create(card,
-					    chip->fm_port,
-					    chip->fm_port - 8,
+			if (snd_opl4_create(card, fm_port, fm_port - 8,
 					    2, &opl3, &opl4) < 0) {
 				/* no luck, use OPL3 instead */
 				snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(2),
@@ -818,12 +792,10 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 			}
 		}
 #endif	/* !OPTi93X */
-		if (!opl3 && snd_opl3_create(card,
-					     chip->fm_port,
-					     chip->fm_port + 2,
+		if (!opl3 && snd_opl3_create(card, fm_port, fm_port + 2,
 					     OPL3_HW_AUTO, 0, &opl3) < 0) {
 			snd_printk(KERN_WARNING "no OPL device at 0x%lx-0x%lx\n",
-				   chip->fm_port, chip->fm_port + 4 - 1);
+				   fm_port, fm_port + 4 - 1);
 		}
 		if (opl3) {
 			error = snd_opl3_hwdep_new(opl3, 0, 1, &synth);
-- 
1.6.4

----------------------------------------------------------------------
Do³aduj swój telefon!
Sprawdz >>> http://link.interia.pl/f24c2


--===============8990547949421459273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8990547949421459273==--
