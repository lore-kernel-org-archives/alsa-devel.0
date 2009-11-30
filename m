From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/2] opti-miro: separate comon probing code
Date: Mon, 30 Nov 2009 07:45:47 +0100
Message-ID: <20091130074547.e6e1383b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8270920425464205110=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 665EC2435A
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 07:43:36 +0100 (CET)
Received: from poczta.interia.pl (mi04.poczta.interia.pl [10.217.12.4])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id A8ED9106959
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 07:43:35 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id DE3DD36B0FC
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 07:43:34 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

--===============8270920425464205110==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Separate common probing code in order to use it
for PnP probing.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/opti9xx/miro.c |  273 +++++++++++++++++++++++++---------------------
 1 files changed, 147 insertions(+), 126 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index e374869..c67bc3c 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1142,28 +1142,39 @@ __skip_mpu:
 	return 0;
 }
 
+static int __devinit snd_miro_opti_check(struct snd_miro *chip)
+{
+	unsigned char value;
+
+	chip->res_mc_base = request_region(chip->mc_base, chip->mc_base_size,
+					   "OPTi9xx MC");
+	if (chip->res_mc_base == NULL)
+		return -ENOMEM;
+
+	value = snd_miro_read(chip, OPTi9XX_MC_REG(1));
+	if (value != 0xff && value != inb(chip->mc_base + OPTi9XX_MC_REG(1)))
+		if (value == snd_miro_read(chip, OPTi9XX_MC_REG(1)))
+			return 0;
+
+	release_and_free_resource(chip->res_mc_base);
+	chip->res_mc_base = NULL;
+
+	return -ENODEV;
+}
+
 static int __devinit snd_card_miro_detect(struct snd_card *card,
 					  struct snd_miro *chip)
 {
 	int i, err;
-	unsigned char value;
 
 	for (i = OPTi9XX_HW_82C929; i <= OPTi9XX_HW_82C924; i++) {
 
 		if ((err = snd_miro_init(chip, i)) < 0)
 			return err;
 
-		if ((chip->res_mc_base = request_region(chip->mc_base, chip->mc_base_size, "OPTi9xx MC")) == NULL)
-			continue;
-
-		value = snd_miro_read(chip, OPTi9XX_MC_REG(1));
-		if ((value != 0xff) && (value != inb(chip->mc_base + 1)))
-			if (value == snd_miro_read(chip, OPTi9XX_MC_REG(1)))
-				return 1;
-
-		release_and_free_resource(chip->res_mc_base);
-		chip->res_mc_base = NULL;
-
+		err = snd_miro_opti_check(chip);
+		if (err == 0)
+			return 1;
 	}
 
 	return -ENODEV;
@@ -1234,151 +1245,69 @@ static void snd_card_miro_free(struct snd_card *card)
 	release_and_free_resource(miro->res_mc_base);
 }
 
-static int __devinit snd_miro_match(struct device *devptr, unsigned int n)
-{
-	return 1;
-}
-
-static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
+static int __devinit snd_miro_probe(struct snd_card *card)
 {
-	static long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
-	static long possible_mpu_ports[] = {0x330, 0x300, 0x310, 0x320, -1};
-	static int possible_irqs[] = {11, 9, 10, 7, -1};
-	static int possible_mpu_irqs[] = {10, 5, 9, 7, -1};
-	static int possible_dma1s[] = {3, 1, 0, -1};
-	static int possible_dma2s[][2] = {{1,-1}, {0,-1}, {-1,-1}, {0,-1}};
-
 	int error;
-	struct snd_miro *miro;
+	struct snd_miro *miro = card->private_data;
 	struct snd_wss *codec;
 	struct snd_timer *timer;
-	struct snd_card *card;
 	struct snd_pcm *pcm;
 	struct snd_rawmidi *rmidi;
 
-	error = snd_card_create(index, id, THIS_MODULE,
-				sizeof(struct snd_miro), &card);
-	if (error < 0)
-		return error;
-
-	card->private_free = snd_card_miro_free;
-	miro = card->private_data;
-
-	error = snd_card_miro_detect(card, miro);
-	if (error < 0) {
-		snd_card_free(card);
-		snd_printk(KERN_ERR "unable to detect OPTi9xx chip\n");
-		return -ENODEV;
+	if (!miro->res_mc_base) {
+		miro->res_mc_base = request_region(miro->mc_base,
+						miro->mc_base_size,
+						"miro (OPTi9xx MC)");
+		if (miro->res_mc_base == NULL) {
+			snd_printk(KERN_ERR "request for OPTI9xx MC failed\n");
+			return -ENOMEM;
+		}
 	}
 
-	if ((error = snd_card_miro_aci_detect(card, miro)) < 0) {
+	error = snd_card_miro_aci_detect(card, miro);
+	if (error < 0) {
 		snd_card_free(card);
 		snd_printk(KERN_ERR "unable to detect aci chip\n");
 		return -ENODEV;
 	}
 
-	/* init proc interface */
-	snd_miro_proc_init(card, miro);
-
-
-	if (! miro->res_mc_base &&
-	    (miro->res_mc_base = request_region(miro->mc_base, miro->mc_base_size,
-						"miro (OPTi9xx MC)")) == NULL) {
-		snd_card_free(card);
-		snd_printk(KERN_ERR "request for OPTI9xx MC failed\n");
-		return -ENOMEM;
-	}
-
 	miro->wss_base = port;
+	miro->mpu_port = mpu_port;
 	miro->irq = irq;
 	miro->mpu_irq = mpu_irq;
 	miro->dma1 = dma1;
 	miro->dma2 = dma2;
 
-	if (miro->wss_base == SNDRV_AUTO_PORT) {
-		if ((miro->wss_base = snd_legacy_find_free_ioport(possible_ports, 4)) < 0) {
-			snd_card_free(card);
-			snd_printk(KERN_ERR "unable to find a free WSS port\n");
-			return -EBUSY;
-		}
-	}
-
-	if (mpu_port == SNDRV_AUTO_PORT) {
-		mpu_port = snd_legacy_find_free_ioport(possible_mpu_ports, 2);
-		if (mpu_port < 0) {
-			snd_card_free(card);
-			snd_printk(KERN_ERR "unable to find a free MPU401 port\n");
-			return -EBUSY;
-		}
-	}
-	miro->mpu_port = mpu_port;
-
-	if (miro->irq == SNDRV_AUTO_IRQ) {
-		if ((miro->irq = snd_legacy_find_free_irq(possible_irqs)) < 0) {
-			snd_card_free(card);
-			snd_printk(KERN_ERR "unable to find a free IRQ\n");
-			return -EBUSY;
-		}
-	}
-	if (miro->mpu_irq == SNDRV_AUTO_IRQ) {
-		if ((miro->mpu_irq = snd_legacy_find_free_irq(possible_mpu_irqs)) < 0) {
-			snd_card_free(card);
-			snd_printk(KERN_ERR "unable to find a free MPU401 IRQ\n");
-			return -EBUSY;
-		}
-	}
-	if (miro->dma1 == SNDRV_AUTO_DMA) {
-		if ((miro->dma1 = snd_legacy_find_free_dma(possible_dma1s)) < 0) {
-			snd_card_free(card);
-			snd_printk(KERN_ERR "unable to find a free DMA1\n");
-			return -EBUSY;
-		}
-	}
-	if (miro->dma2 == SNDRV_AUTO_DMA) {
-		if ((miro->dma2 = snd_legacy_find_free_dma(possible_dma2s[miro->dma1 % 4])) < 0) {
-			snd_card_free(card);
-			snd_printk(KERN_ERR "unable to find a free DMA2\n");
-			return -EBUSY;
-		}
-	}
+	/* init proc interface */
+	snd_miro_proc_init(card, miro);
 
 	error = snd_miro_configure(miro);
-	if (error) {
-		snd_card_free(card);
+	if (error)
 		return error;
-	}
 
 	error = snd_wss_create(card, miro->wss_base + 4, -1,
-				miro->irq, miro->dma1, miro->dma2,
-				WSS_HW_AD1845, 0, &codec);
-	if (error < 0) {
-		snd_card_free(card);
+			       miro->irq, miro->dma1, miro->dma2,
+			       WSS_HW_DETECT, 0, &codec);
+	if (error < 0)
 		return error;
-	}
 
 	error = snd_wss_pcm(codec, 0, &pcm);
-	if (error < 0)  {
-		snd_card_free(card);
+	if (error < 0)
 		return error;
-	}
+
 	error = snd_wss_mixer(codec);
-	if (error < 0) {
-		snd_card_free(card);
+	if (error < 0)
 		return error;
-	}
+
 	error = snd_wss_timer(codec, 0, &timer);
-	if (error < 0) {
-		snd_card_free(card);
+	if (error < 0)
 		return error;
-	}
 
 	miro->pcm = pcm;
 
 	error = snd_miro_mixer(card, miro);
-	if (error < 0) {
-		snd_card_free(card);
+	if (error < 0)
 		return error;
-	}
 
 	if (miro->aci->aci_vendor == 'm') {
 		/* It looks like a miro sound card. */
@@ -1425,20 +1354,111 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 	if (fm_port > 0 && fm_port != SNDRV_AUTO_PORT) {
 		struct snd_opl3 *opl3 = NULL;
 		struct snd_opl4 *opl4;
+
 		if (snd_opl4_create(card, fm_port, fm_port - 8,
 				    2, &opl3, &opl4) < 0)
 			snd_printk(KERN_WARNING "no OPL4 device at 0x%lx\n",
 				   fm_port);
 	}
 
-	if ((error = snd_set_aci_init_values(miro)) < 0) {
-		snd_card_free(card);
+	error = snd_set_aci_init_values(miro);
+	if (error < 0)
                 return error;
+
+	return snd_card_register(card);
+}
+
+static int __devinit snd_miro_isa_match(struct device *devptr, unsigned int n)
+{
+	return 1;
+}
+
+static int __devinit snd_miro_isa_probe(struct device *devptr, unsigned int n)
+{
+	static long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
+	static long possible_mpu_ports[] = {0x330, 0x300, 0x310, 0x320, -1};
+	static int possible_irqs[] = {11, 9, 10, 7, -1};
+	static int possible_mpu_irqs[] = {10, 5, 9, 7, -1};
+	static int possible_dma1s[] = {3, 1, 0, -1};
+	static int possible_dma2s[][2] = { {1, -1}, {0, -1}, {-1, -1},
+					   {0, -1} };
+
+	int error;
+	struct snd_miro *miro;
+	struct snd_card *card;
+
+	error = snd_card_create(index, id, THIS_MODULE,
+				sizeof(struct snd_miro), &card);
+	if (error < 0)
+		return error;
+
+	card->private_free = snd_card_miro_free;
+	miro = card->private_data;
+
+	error = snd_card_miro_detect(card, miro);
+	if (error < 0) {
+		snd_card_free(card);
+		snd_printk(KERN_ERR "unable to detect OPTi9xx chip\n");
+		return -ENODEV;
+	}
+
+	if (port == SNDRV_AUTO_PORT) {
+		port = snd_legacy_find_free_ioport(possible_ports, 4);
+		if (port < 0) {
+			snd_card_free(card);
+			snd_printk(KERN_ERR "unable to find a free WSS port\n");
+			return -EBUSY;
+		}
+	}
+
+	if (mpu_port == SNDRV_AUTO_PORT) {
+		mpu_port = snd_legacy_find_free_ioport(possible_mpu_ports, 2);
+		if (mpu_port < 0) {
+			snd_card_free(card);
+			snd_printk(KERN_ERR
+				   "unable to find a free MPU401 port\n");
+			return -EBUSY;
+		}
+	}
+
+	if (irq == SNDRV_AUTO_IRQ) {
+		irq = snd_legacy_find_free_irq(possible_irqs);
+		if (irq < 0) {
+			snd_card_free(card);
+			snd_printk(KERN_ERR "unable to find a free IRQ\n");
+			return -EBUSY;
+		}
+	}
+	if (mpu_irq == SNDRV_AUTO_IRQ) {
+		mpu_irq = snd_legacy_find_free_irq(possible_mpu_irqs);
+		if (mpu_irq < 0) {
+			snd_card_free(card);
+			snd_printk(KERN_ERR
+				   "unable to find a free MPU401 IRQ\n");
+			return -EBUSY;
+		}
+	}
+	if (dma1 == SNDRV_AUTO_DMA) {
+		dma1 = snd_legacy_find_free_dma(possible_dma1s);
+		if (dma1 < 0) {
+			snd_card_free(card);
+			snd_printk(KERN_ERR "unable to find a free DMA1\n");
+			return -EBUSY;
+		}
+	}
+	if (dma2 == SNDRV_AUTO_DMA) {
+		dma2 = snd_legacy_find_free_dma(possible_dma2s[dma1 % 4]);
+		if (dma2 < 0) {
+			snd_card_free(card);
+			snd_printk(KERN_ERR "unable to find a free DMA2\n");
+			return -EBUSY;
+		}
 	}
 
 	snd_card_set_dev(card, devptr);
 
-	if ((error = snd_card_register(card))) {
+	error = snd_miro_probe(card);
+	if (error < 0) {
 		snd_card_free(card);
 		return error;
 	}
@@ -1447,7 +1467,8 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 	return 0;
 }
 
-static int __devexit snd_miro_remove(struct device *devptr, unsigned int dev)
+static int __devexit snd_miro_isa_remove(struct device *devptr,
+					 unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(devptr));
 	dev_set_drvdata(devptr, NULL);
@@ -1457,9 +1478,9 @@ static int __devexit snd_miro_remove(struct device *devptr, unsigned int dev)
 #define DEV_NAME "miro"
 
 static struct isa_driver snd_miro_driver = {
-	.match		= snd_miro_match,
-	.probe		= snd_miro_probe,
-	.remove		= __devexit_p(snd_miro_remove),
+	.match		= snd_miro_isa_match,
+	.probe		= snd_miro_isa_probe,
+	.remove		= __devexit_p(snd_miro_isa_remove),
 	/* FIXME: suspend/resume */
 	.driver		= {
 		.name	= DEV_NAME
-- 
1.6.4


----------------------------------------------------------------------
Wygraj pobyt w Alpach dla ca³ej rodziny
Kliknij >>> http://link.interia.pl/f2446


--===============8270920425464205110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8270920425464205110==--
