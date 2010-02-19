From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opti92x: use PnP data to select Master Control
	port
Date: Fri, 19 Feb 2010 19:59:45 +0100
Message-ID: <20100219195945.79cd53ab.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id C2F9024512
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 19:56:05 +0100 (CET)
Received: from poczta.interia.pl (mi03.poczta.interia.pl [10.217.12.3])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id 1BCC31EF70E
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 19:56:00 +0100 (CET)
Received: from krzysio.dom.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 68D503E384E
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 19:55:55 +0100 (CET)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The Master Control port (MC) is available as the last
PnP resource (OPT005). Use this value instead fo guessing.

Also, add some comments to the code.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/opti9xx/miro.c           |    2 +-
 sound/isa/opti9xx/opti92x-ad1848.c |  120 +++++++++++++++++++++++-------------
 2 files changed, 79 insertions(+), 43 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index b865e45..5913717 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1558,7 +1558,7 @@ static int __devinit snd_card_miro_pnp(struct snd_miro *chip,
 
 	err = pnp_activate_dev(devmc);
 	if (err < 0) {
-		snd_printk(KERN_ERR "OPL syntg pnp configure failure: %d\n",
+		snd_printk(KERN_ERR "MC pnp configure failure: %d\n",
 				    err);
 		return err;
 	}
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index a4af53b..becd90d 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -144,12 +144,8 @@ struct snd_opti9xx {
 
 	spinlock_t lock;
 
+	long wss_base;
 	int irq;
-
-#ifdef CONFIG_PNP
-	struct pnp_dev *dev;
-	struct pnp_dev *devmpu;
-#endif	/* CONFIG_PNP */
 };
 
 static int snd_opti9xx_pnp_is_probed;
@@ -159,12 +155,17 @@ static int snd_opti9xx_pnp_is_probed;
 static struct pnp_card_device_id snd_opti9xx_pnpids[] = {
 #ifndef OPTi93X
 	/* OPTi 82C924 */
-	{ .id = "OPT0924", .devs = { { "OPT0000" }, { "OPT0002" } }, .driver_data = 0x0924 },
+	{ .id = "OPT0924",
+	  .devs = { { "OPT0000" }, { "OPT0002" }, { "OPT0005" } },
+	  .driver_data = 0x0924 },
 	/* OPTi 82C925 */
-	{ .id = "OPT0925", .devs = { { "OPT9250" }, { "OPT0002" } }, .driver_data = 0x0925 },
+	{ .id = "OPT0925",
+	  .devs = { { "OPT9250" }, { "OPT0002" }, { "OPT0005" } },
+	  .driver_data = 0x0925 },
 #else
 	/* OPTi 82C931/3 */
-	{ .id = "OPT0931", .devs = { { "OPT9310" }, { "OPT0002" } }, .driver_data = 0x0931 },
+	{ .id = "OPT0931", .devs = { { "OPT9310" }, { "OPT0002" } },
+	  .driver_data = 0x0931 },
 #endif	/* OPTi93X */
 	{ .id = "" }
 };
@@ -207,24 +208,34 @@ static int __devinit snd_opti9xx_init(struct snd_opti9xx *chip,
 	chip->hardware = hardware;
 	strcpy(chip->name, snd_opti9xx_names[hardware]);
 
-	chip->mc_base_size = opti9xx_mc_size[hardware];  
-
 	spin_lock_init(&chip->lock);
 
 	chip->irq = -1;
 
+#ifndef OPTi93X
+#ifdef CONFIG_PNP
+	if (isapnp && chip->mc_base)
+		/* PnP resource gives the least 10 bits */
+		chip->mc_base |= 0xc00;
+#endif	/* CONFIG_PNP */
+	else {
+		chip->mc_base = 0xf8c;
+		chip->mc_base_size = opti9xx_mc_size[hardware];
+	}
+#else
+		chip->mc_base_size = opti9xx_mc_size[hardware];
+#endif
+
 	switch (hardware) {
 #ifndef OPTi93X
 	case OPTi9XX_HW_82C928:
 	case OPTi9XX_HW_82C929:
-		chip->mc_base = 0xf8c;
 		chip->password = (hardware == OPTi9XX_HW_82C928) ? 0xe2 : 0xe3;
 		chip->pwd_reg = 3;
 		break;
 
 	case OPTi9XX_HW_82C924:
 	case OPTi9XX_HW_82C925:
-		chip->mc_base = 0xf8c;
 		chip->password = 0xe5;
 		chip->pwd_reg = 3;
 		break;
@@ -292,7 +303,7 @@ static unsigned char snd_opti9xx_read(struct snd_opti9xx *chip,
 	spin_unlock_irqrestore(&chip->lock, flags);
 	return retval;
 }
-	
+
 static void snd_opti9xx_write(struct snd_opti9xx *chip, unsigned char reg,
 			      unsigned char value)
 {
@@ -341,7 +352,7 @@ static void snd_opti9xx_write(struct snd_opti9xx *chip, unsigned char reg,
 
 
 static int __devinit snd_opti9xx_configure(struct snd_opti9xx *chip,
-					   long wss_base,
+					   long port,
 					   int irq, int dma1, int dma2,
 					   long mpu_port, int mpu_irq)
 {
@@ -354,16 +365,23 @@ static int __devinit snd_opti9xx_configure(struct snd_opti9xx *chip,
 	switch (chip->hardware) {
 #ifndef OPTi93X
 	case OPTi9XX_HW_82C924:
+		/* opti 929 mode (?), OPL3 clock output, audio enable */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(4), 0xf0, 0xfc);
+		/* enable wave audio */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(6), 0x02, 0x02);
 
 	case OPTi9XX_HW_82C925:
+		/* enable WSS mode */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(1), 0x80, 0x80);
+		/* OPL3 FM synthesis */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(2), 0x00, 0x20);
+		/* disable Sound Blaster IRQ and DMA */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(3), 0xf0, 0xff);
 #ifdef CS4231
+		/* cs4231/4248 fix enabled */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(5), 0x02, 0x02);
 #else
+		/* cs4231/4248 fix disabled */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(5), 0x00, 0x02);
 #endif	/* CS4231 */
 		break;
@@ -411,21 +429,26 @@ static int __devinit snd_opti9xx_configure(struct snd_opti9xx *chip,
 		return -EINVAL;
 	}
 
-	switch (wss_base) {
-	case 0x530:
+	/* PnP resource says it decodes only 10 bits of address */
+	switch (port & 0x3ff) {
+	case 0x130:
+		chip->wss_base = 0x530;
 		wss_base_bits = 0x00;
 		break;
-	case 0x604:
+	case 0x204:
+		chip->wss_base = 0x604;
 		wss_base_bits = 0x03;
 		break;
-	case 0xe80:
+	case 0x280:
+		chip->wss_base = 0xe80;
 		wss_base_bits = 0x01;
 		break;
-	case 0xf40:
+	case 0x340:
+		chip->wss_base = 0xf40;
 		wss_base_bits = 0x02;
 		break;
 	default:
-		snd_printk(KERN_WARNING "WSS port 0x%lx not valid\n", wss_base);
+		snd_printk(KERN_WARNING "WSS port 0x%lx not valid\n", port);
 		goto __skip_base;
 	}
 	snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(1), wss_base_bits << 4, 0x30);
@@ -487,7 +510,7 @@ __skip_base:
 #endif	/* CS4231 || OPTi93X */
 
 #ifndef OPTi93X
-	 outb(irq_bits << 3 | dma_bits, wss_base);
+	 outb(irq_bits << 3 | dma_bits, chip->wss_base);
 #else /* OPTi93X */
 	snd_opti9xx_write(chip, OPTi9XX_MC_REG(3), (irq_bits << 3 | dma_bits));
 #endif /* OPTi93X */
@@ -729,15 +752,15 @@ static int __devinit snd_card_opti9xx_pnp(struct snd_opti9xx *chip,
 {
 	struct pnp_dev *pdev;
 	int err;
+	struct pnp_dev *devmpu;
+#ifndef OPTi93X
+	struct pnp_dev *devmc;
+#endif
 
-	chip->dev = pnp_request_card_device(card, pid->devs[0].id, NULL);
-	if (chip->dev == NULL)
+	pdev = pnp_request_card_device(card, pid->devs[0].id, NULL);
+	if (pdev == NULL)
 		return -EBUSY;
 
-	chip->devmpu = pnp_request_card_device(card, pid->devs[1].id, NULL);
-
-	pdev = chip->dev;
-
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "AUDIO pnp configure failure: %d\n", err);
@@ -750,9 +773,24 @@ static int __devinit snd_card_opti9xx_pnp(struct snd_opti9xx *chip,
 	chip->mc_indir_index = pnp_port_start(pdev, 3) + 2;
 	chip->mc_indir_size = pnp_port_len(pdev, 3) - 2;
 #else
-	if (pid->driver_data != 0x0924)
-		port = pnp_port_start(pdev, 1);
+	devmc = pnp_request_card_device(card, pid->devs[2].id, NULL);
+	if (devmc == NULL)
+		return -EBUSY;
+
+	err = pnp_activate_dev(devmc);
+	if (err < 0) {
+		snd_printk(KERN_ERR "MC pnp configure failure: %d\n", err);
+		return err;
+	}
+
+	port = pnp_port_start(pdev, 1);
 	fm_port = pnp_port_start(pdev, 2) + 8;
+	/*
+	 * The MC(0) is never accessed and card does not
+	 * include it in the PnP resource range. OPTI93x include it.
+	 */
+	chip->mc_base = pnp_port_start(devmc, 0) - 1;
+	chip->mc_base_size = pnp_port_len(devmc, 0) + 1;
 #endif	/* OPTi93X */
 	irq = pnp_irq(pdev, 0);
 	dma1 = pnp_dma(pdev, 0);
@@ -760,16 +798,16 @@ static int __devinit snd_card_opti9xx_pnp(struct snd_opti9xx *chip,
 	dma2 = pnp_dma(pdev, 1);
 #endif	/* CS4231 || OPTi93X */
 
-	pdev = chip->devmpu;
-	if (pdev && mpu_port > 0) {
-		err = pnp_activate_dev(pdev);
+	devmpu = pnp_request_card_device(card, pid->devs[1].id, NULL);
+
+	if (devmpu && mpu_port > 0) {
+		err = pnp_activate_dev(devmpu);
 		if (err < 0) {
-			snd_printk(KERN_ERR "AUDIO pnp configure failure\n");
+			snd_printk(KERN_ERR "MPU401 pnp configure failure\n");
 			mpu_port = -1;
-			chip->devmpu = NULL;
 		} else {
-			mpu_port = pnp_port_start(pdev, 0);
-			mpu_irq = pnp_irq(pdev, 0);
+			mpu_port = pnp_port_start(devmpu, 0);
+			mpu_irq = pnp_irq(devmpu, 0);
 		}
 	}
 	return pid->driver_data;
@@ -824,7 +862,7 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 	if (error)
 		return error;
 
-	error = snd_wss_create(card, port + 4, -1, irq, dma1, xdma2,
+	error = snd_wss_create(card, chip->wss_base + 4, -1, irq, dma1, xdma2,
 #ifdef OPTi93X
 			       WSS_HW_OPTI93X, WSS_HWSHARE_IRQ,
 #else
@@ -865,10 +903,11 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 	sprintf(card->shortname, "OPTi %s", card->driver);
 #if defined(CS4231) || defined(OPTi93X)
 	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d&%d",
-		card->shortname, pcm->name, port + 4, irq, dma1, xdma2);
+		card->shortname, pcm->name,
+		chip->wss_base + 4, irq, dma1, xdma2);
 #else
 	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",
-		card->shortname, pcm->name, port + 4, irq, dma1);
+		card->shortname, pcm->name, chip->wss_base + 4, irq, dma1);
 #endif	/* CS4231 || OPTi93X */
 
 	if (mpu_port <= 0 || mpu_port == SNDRV_AUTO_PORT)
@@ -1062,9 +1101,6 @@ static int __devinit snd_opti9xx_pnp_probe(struct pnp_card_link *pcard,
 		snd_card_free(card);
 		return error;
 	}
-	if (hw <= OPTi9XX_HW_82C930)
-		chip->mc_base -= 0x80;
-
 	error = snd_opti9xx_read_check(chip);
 	if (error) {
 		snd_printk(KERN_ERR "OPTI chip not found\n");
-- 
1.6.4


----------------------------------------------------------------------
Codziennie 11 tys. ofert pracy
Sprawdz >>> http://link.interia.pl/f25ac
