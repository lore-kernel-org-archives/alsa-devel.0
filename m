From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] sscape: driver extension to 2nd DMA and WSS
	port (2nd rev)
Date: Mon, 17 Sep 2007 15:44:47 +0200
Message-ID: <20070917154447.debbbd3e.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DEBE103863
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 15:37:28 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so1005519nfd
	for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2007 06:37:27 -0700 (PDT)
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

This patch adds second DMA channel and WSS port settings 
to the sscape driver. Also, it adds internal card type setting.
The Ensoniq SoundScape VIVO PnP id is added but not handled
yet.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This version does not change names of existing parameters.

diff -urp linux-2.6.23.orig/sound/isa/sscape.c linux-2.6.23/sound/isa/sscape.c
--- linux-2.6.23.orig/sound/isa/sscape.c	2007-09-16 14:40:05.000000000 +0200
+++ linux-2.6.23/sound/isa/sscape.c	2007-09-17 15:34:41.341902699 +0200
@@ -45,10 +45,12 @@ MODULE_LICENSE("GPL");
 
 static int index[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_IDX;
 static char* id[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_STR;
-static long port[SNDRV_CARDS] __devinitdata = { [0 ... (SNDRV_CARDS-1)] = SNDRV_AUTO_PORT };
+static long port[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
+static long wss_port[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
 static int irq[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_IRQ;
 static int mpu_irq[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_IRQ;
 static int dma[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_DMA;
+static int dma2[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_DMA;
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index number for SoundScape soundcard");
@@ -59,6 +61,9 @@ MODULE_PARM_DESC(id, "Description for So
 module_param_array(port, long, NULL, 0444);
 MODULE_PARM_DESC(port, "Port # for SoundScape driver.");
 
+module_param_array(wss_port, long, NULL, 0444);
+MODULE_PARM_DESC(wss_port, "WSS Port # for SoundScape driver.");
+
 module_param_array(irq, int, NULL, 0444);
 MODULE_PARM_DESC(irq, "IRQ # for SoundScape driver.");
 
@@ -68,12 +73,16 @@ MODULE_PARM_DESC(mpu_irq, "MPU401 IRQ # 
 module_param_array(dma, int, NULL, 0444);
 MODULE_PARM_DESC(dma, "DMA # for SoundScape driver.");
 
+module_param_array(dma2, int, NULL, 0444);
+MODULE_PARM_DESC(dma2, "DMA2 # for SoundScape driver.");
+
 #ifdef CONFIG_PNP
 static int isa_registered;
 static int pnp_registered;
 
 static struct pnp_card_device_id sscape_pnpids[] = {
-	{ .id = "ENS3081", .devs = { { "ENS0000" } } },
+	{ .id = "ENS3081", .devs = { { "ENS0000" } } }, /* Soundscape PnP */
+	{ .id = "ENS4081", .devs = { { "ENS1011" } } },	/* VIVO90 */
 	{ .id = "" }	/* end */
 };
 
@@ -124,11 +133,18 @@ enum GA_REG {
 #define AD1845_FREQ_SEL_MSB    0x16
 #define AD1845_FREQ_SEL_LSB    0x17
 
+enum card_type {
+	SSCAPE,
+	SSCAPE_PNP,
+	SSCAPE_VIVO,
+};
+
 struct soundscape {
 	spinlock_t lock;
 	unsigned io_base;
 	int codec_type;
 	int ic_type;
+	enum card_type type;
 	struct resource *io_res;
 	struct snd_cs4231 *chip;
 	struct snd_mpu401 *mpu;
@@ -522,7 +538,7 @@ static int upload_dma_data(struct sounds
 		ret = -EAGAIN;
 	}
 
-	_release_dma:
+_release_dma:
 	/*
 	 * NOTE!!! We are NOT holding any spinlocks at this point !!!
 	 */
@@ -995,21 +1011,20 @@ static void ad1845_capture_format(struct
  * try to support at least some of the extra bits by overriding
  * some of the CS4231 callback.
  */
-static int __devinit create_ad1845(struct snd_card *card, unsigned port, int irq, int dma1)
+static int __devinit create_ad1845(struct snd_card *card, unsigned port,
+				   int irq, int dma1, int dma2)
 {
 	register struct soundscape *sscape = get_card_soundscape(card);
 	struct snd_cs4231 *chip;
 	int err;
 
-#define CS4231_SHARE_HARDWARE  (CS4231_HWSHARE_DMA1 | CS4231_HWSHARE_DMA2)
-	/*
-	 * The AD1845 PCM device is only half-duplex, and so
-	 * we only give it one DMA channel ...
-	 */
-	if ((err = snd_cs4231_create(card,
-				     port, -1, irq, dma1, dma1,
-				     CS4231_HW_DETECT,
-				     CS4231_HWSHARE_DMA1, &chip)) == 0) {
+	if (dma1 == dma2)
+		dma2 = -1;
+
+	err = snd_cs4231_create(card,
+				port, -1, irq, dma1, dma2,
+				CS4231_HW_DETECT, CS4231_HWSHARE_DMA1, &chip);
+	if (!err) {
 		unsigned long flags;
 		struct snd_pcm *pcm;
 
@@ -1070,8 +1085,9 @@ static int __devinit create_ad1845(struc
 		strcpy(card->driver, "SoundScape");
 		strcpy(card->shortname, pcm->name);
 		snprintf(card->longname, sizeof(card->longname),
-		         "%s at 0x%lx, IRQ %d, DMA %d\n",
-		         pcm->name, chip->port, chip->irq, chip->dma1);
+			 "%s at 0x%lx, IRQ %d, DMA1 %d, DMA2 %d\n",
+			 pcm->name, chip->port, chip->irq,
+			 chip->dma1, chip->dma2);
 		chip->set_playback_format = ad1845_playback_format;
 		chip->set_capture_format = ad1845_capture_format;
 		sscape->chip = chip;
@@ -1086,9 +1102,8 @@ static int __devinit create_ad1845(struc
  * Create an ALSA soundcard entry for the SoundScape, using
  * the given list of port, IRQ and DMA resources.
  */
-static int __devinit create_sscape(int dev, struct snd_card **rcardp)
+static int __devinit create_sscape(int dev, struct snd_card *card)
 {
-	struct snd_card *card;
 	register struct soundscape *sscape;
 	register unsigned dma_cfg;
 	unsigned irq_cfg;
@@ -1126,21 +1141,12 @@ static int __devinit create_sscape(int d
 	/*
 	 * Grab both DMA channels (OK, only one for now) ...
 	 */
-	if ((err = request_dma(dma[dev], "SoundScape")) < 0) {
+	err = request_dma(dma[dev], "SoundScape");
+	if (err < 0) {
 		snd_printk(KERN_ERR "sscape: can't grab DMA %d\n", dma[dev]);
 		goto _release_region;
 	}
 
-	/*
-	 * Create a new ALSA sound card entry, in anticipation
-	 * of detecting our hardware ...
-	 */
-	if ((card = snd_card_new(index[dev], id[dev], THIS_MODULE,
-				 sizeof(struct soundscape))) == NULL) {
-		err = -ENOMEM;
-		goto _release_dma;
-	}
-
 	sscape = get_card_soundscape(card);
 	spin_lock_init(&sscape->lock);
 	spin_lock_init(&sscape->fwlock);
@@ -1150,11 +1156,11 @@ static int __devinit create_sscape(int d
 	if (!detect_sscape(sscape)) {
 		printk(KERN_ERR "sscape: hardware not detected at 0x%x\n", sscape->io_base);
 		err = -ENODEV;
-		goto _release_card;
+		goto _release_dma;
 	}
 
 	printk(KERN_INFO "sscape: hardware detected at 0x%x, using IRQ %d, DMA %d\n",
-	                 sscape->io_base, irq[dev], dma[dev]);
+			 sscape->io_base, irq[dev], dma[dev]);
 
 	/*
 	 * Now create the hardware-specific device so that we can
@@ -1164,7 +1170,7 @@ static int __devinit create_sscape(int d
 	 */
 	if ((err = snd_hwdep_new(card, "MC68EC000", 0, &(sscape->hw))) < 0) {
 		printk(KERN_ERR "sscape: Failed to create firmware device\n");
-		goto _release_card;
+		goto _release_dma;
 	}
 	strlcpy(sscape->hw->name, "SoundScape M68K", sizeof(sscape->hw->name));
 	sscape->hw->name[sizeof(sscape->hw->name) - 1] = '\0';
@@ -1197,7 +1203,8 @@ static int __devinit create_sscape(int d
 	sscape_write_unsafe(sscape->io_base,
 	                    GA_INTCFG_REG, 0xf0 | (mpu_irq_cfg << 2) | mpu_irq_cfg);
 	sscape_write_unsafe(sscape->io_base,
-	                    GA_CDCFG_REG, 0x09 | DMA_8BIT | (dma[dev] << 4) | (irq_cfg << 1));
+			    GA_CDCFG_REG, 0x09 | DMA_8BIT
+			    | (dma[dev] << 4) | (irq_cfg << 1));
 
 	spin_unlock_irqrestore(&sscape->lock, flags);
 
@@ -1205,16 +1212,18 @@ static int __devinit create_sscape(int d
 	 * We have now enabled the codec chip, and so we should
 	 * detect the AD1845 device ...
 	 */
-	if ((err = create_ad1845(card, CODEC_IO(xport), irq[dev], dma[dev])) < 0) {
-		printk(KERN_ERR "sscape: No AD1845 device at 0x%x, IRQ %d\n",
-		                CODEC_IO(xport), irq[dev]);
-		goto _release_card;
+	err = create_ad1845(card, wss_port[dev], irq[dev],
+			    dma[dev], dma2[dev]);
+	if (err < 0) {
+		printk(KERN_ERR "sscape: No AD1845 device at 0x%lx, IRQ %d\n",
+		       wss_port[dev], irq[dev]);
+		goto _release_dma;
 	}
 #define MIDI_DEVNUM  0
 	if ((err = create_mpu401(card, MIDI_DEVNUM, MPU401_IO(xport), mpu_irq[dev])) < 0) {
 		printk(KERN_ERR "sscape: Failed to create MPU-401 device at 0x%x\n",
 		                MPU401_IO(xport));
-		goto _release_card;
+		goto _release_dma;
 	}
 
 	/*
@@ -1237,17 +1246,13 @@ static int __devinit create_sscape(int d
 	 *       function now that our "constructor" has completed.
 	 */
 	card->private_free = soundscape_free;
-	*rcardp = card;
 
 	return 0;
 
-	_release_card:
-	snd_card_free(card);
-
-	_release_dma:
+_release_dma:
 	free_dma(dma[dev]);
 
-	_release_region:
+_release_region:
 	release_and_free_resource(io_res);
 
 	return err;
@@ -1276,19 +1281,33 @@ static int __devinit snd_sscape_match(st
 static int __devinit snd_sscape_probe(struct device *pdev, unsigned int dev)
 {
 	struct snd_card *card;
+	struct soundscape *sscape;
 	int ret;
 
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
+			    sizeof(struct soundscape));
+	if (!card)
+		return -ENOMEM;
+
+	sscape = get_card_soundscape(card);
+	sscape->type = SSCAPE;
+
 	dma[dev] &= 0x03;
-	ret = create_sscape(dev, &card);
+	ret = create_sscape(dev, card);
 	if (ret < 0)
-		return ret;
+		goto _release_card;
+
 	snd_card_set_dev(card, pdev);
 	if ((ret = snd_card_register(card)) < 0) {
 		printk(KERN_ERR "sscape: Failed to register sound card\n");
-		return ret;
+		goto _release_card;
 	}
 	dev_set_drvdata(pdev, card);
 	return 0;
+
+_release_card:
+	snd_card_free(card);
+	return ret;
 }
 
 static int __devexit snd_sscape_remove(struct device *devptr, unsigned int dev)
@@ -1325,6 +1344,7 @@ static int __devinit sscape_pnp_detect(s
 	static int idx = 0;
 	struct pnp_dev *dev;
 	struct snd_card *card;
+	struct soundscape *sscape;
 	int ret;
 
 	/*
@@ -1366,26 +1386,56 @@ static int __devinit sscape_pnp_detect(s
 	}
 
 	/*
+	 * Create a new ALSA sound card entry, in anticipation
+	 * of detecting our hardware ...
+	 */
+	card = snd_card_new(index[idx], id[idx], THIS_MODULE,
+			    sizeof(struct soundscape));
+	if (!card)
+		return -ENOMEM;
+
+	sscape = get_card_soundscape(card);
+
+	/*
+	 * Identify card model ...
+	 */
+	if (!strncmp("ENS4081", pid->id, 7))
+		sscape->type = SSCAPE_VIVO;
+	else
+		sscape->type = SSCAPE_PNP;
+
+	/* VIVO fails for now */
+	if (sscape->type == SSCAPE_VIVO) {
+		ret = -ENODEV;
+		goto _release_card;
+	}
+
+	/*
 	 * Read the correct parameters off the ISA PnP bus ...
 	 */
 	port[idx] = pnp_port_start(dev, 0);
 	irq[idx] = pnp_irq(dev, 0);
 	mpu_irq[idx] = pnp_irq(dev, 1);
 	dma[idx] = pnp_dma(dev, 0) & 0x03;
+	dma2[idx] = dma[idx];
+	wss_port[idx] = CODEC_IO(port[idx]);
 
-	ret = create_sscape(idx, &card);
+	ret = create_sscape(idx, card);
 	if (ret < 0)
-		return ret;
+		goto _release_card;
+
 	snd_card_set_dev(card, &pcard->card->dev);
 	if ((ret = snd_card_register(card)) < 0) {
 		printk(KERN_ERR "sscape: Failed to register sound card\n");
-		snd_card_free(card);
-		return ret;
+		goto _release_card;
 	}
 
 	pnp_set_card_drvdata(pcard, card);
 	++idx;
+	return 0;
 
+_release_card:
+	snd_card_free(card);
 	return ret;
 }
