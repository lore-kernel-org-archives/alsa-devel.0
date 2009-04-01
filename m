From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sc6000: add support for SC-6600 and SC-7000
Date: Wed, 1 Apr 2009 16:22:31 +0200
Message-ID: <20090401162231.37e71124.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id B850E24417
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 17:21:00 +0200 (CEST)
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
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add support for cards based on CompuMedia ASC-9408 chipsets.
These cards were produced by Gallant.

This patch makes the OSS aedsp16 driver redundant.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/Kconfig  |    7 ++-
 sound/isa/sc6000.c |  127 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 103 insertions(+), 31 deletions(-)

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index ed798bf..f9cae35 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -188,15 +188,18 @@ config SND_ES18XX
 	  will be called snd-es18xx.
 
 config SND_SC6000
-	tristate "Gallant SC-6000, Audio Excel DSP 16"
+	tristate "Gallant SC-6000/6600/7000 and Audio Excel DSP 16"
 	depends on HAS_IOPORT
 	select SND_WSS_LIB
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	help
-	  Say Y here to include support for Gallant SC-6000 card and clones:
+	  Say Y here to include support for Gallant SC-6000, SC-6600, SC-7000
+	  cards and clones:
 	  Audio Excel DSP 16 and Zoltrix AV302.
 
+	  These cards are based on CompuMedia ASC-9308 or ASC-9408 chips.
+
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-sc6000.
 
diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index bbc5369..37210c5 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -2,6 +2,8 @@
  *  Driver for Gallant SC-6000 soundcard. This card is also known as
  *  Audio Excel DSP 16 or Zoltrix AV302.
  *  These cards use CompuMedia ASC-9308 chip + AD1848 codec.
+ *  SC-6600 and SC-7000 cards are also supported. They are based on
+ *  CompuMedia ASC-9408 chip and CS4231 codec.
  *
  *  Copyright (C) 2007 Krzysztof Helt <krzysztof.h1@wp.pl>
  *
@@ -191,7 +193,7 @@ static __devinit unsigned char sc6000_mpu_irq_to_softcfg(int mpu_irq)
 	return val;
 }
 
-static __devinit int sc6000_wait_data(char __iomem *vport)
+static int sc6000_wait_data(char __iomem *vport)
 {
 	int loop = 1000;
 	unsigned char val = 0;
@@ -206,7 +208,7 @@ static __devinit int sc6000_wait_data(char __iomem *vport)
 	return -EAGAIN;
 }
 
-static __devinit int sc6000_read(char __iomem *vport)
+static int sc6000_read(char __iomem *vport)
 {
 	if (sc6000_wait_data(vport))
 		return -EBUSY;
@@ -215,7 +217,7 @@ static __devinit int sc6000_read(char __iomem *vport)
 
 }
 
-static __devinit int sc6000_write(char __iomem *vport, int cmd)
+static int sc6000_write(char __iomem *vport, int cmd)
 {
 	unsigned char val;
 	int loop = 500000;
@@ -276,8 +278,33 @@ static int __devinit sc6000_dsp_reset(char __iomem *vport)
 }
 
 /* detection and initialization */
-static int __devinit sc6000_cfg_write(char __iomem *vport,
-				      unsigned char softcfg)
+static int __devinit sc6000_hw_cfg_write(char __iomem *vport, const int *cfg)
+{
+	if (sc6000_write(vport, COMMAND_6C) < 0) {
+		snd_printk(KERN_WARNING "CMD 0x%x: failed!\n", COMMAND_6C);
+		return -EIO;
+	}
+	if (sc6000_write(vport, COMMAND_5C) < 0) {
+		snd_printk(KERN_ERR "CMD 0x%x: failed!\n", COMMAND_5C);
+		return -EIO;
+	}
+	if (sc6000_write(vport, cfg[0]) < 0) {
+		snd_printk(KERN_ERR "DATA 0x%x: failed!\n", cfg[0]);
+		return -EIO;
+	}
+	if (sc6000_write(vport, cfg[1]) < 0) {
+		snd_printk(KERN_ERR "DATA 0x%x: failed!\n", cfg[1]);
+		return -EIO;
+	}
+	if (sc6000_write(vport, COMMAND_C5) < 0) {
+		snd_printk(KERN_ERR "CMD 0x%x: failed!\n", COMMAND_C5);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sc6000_cfg_write(char __iomem *vport, unsigned char softcfg)
 {
 
 	if (sc6000_write(vport, WRITE_MDIRQ_CFG)) {
@@ -291,7 +318,7 @@ static int __devinit sc6000_cfg_write(char __iomem *vport,
 	return 0;
 }
 
-static int __devinit sc6000_setup_board(char __iomem *vport, int config)
+static int sc6000_setup_board(char __iomem *vport, int config)
 {
 	int loop = 10;
 
@@ -334,16 +361,38 @@ static int __devinit sc6000_init_mss(char __iomem *vport, int config,
 	return 0;
 }
 
-static int __devinit sc6000_init_board(char __iomem *vport, int irq, int dma,
-					char __iomem *vmss_port, int mpu_irq)
+static void __devinit sc6000_hw_cfg_encode(char __iomem *vport, int *cfg,
+					   long xport, long xmpu,
+					   long xmss_port)
+{
+	cfg[0] = 0;
+	cfg[1] = 0;
+	if (xport == 0x240)
+		cfg[0] |= 1;
+	if (xmpu != SNDRV_AUTO_PORT) {
+		cfg[0] |= (xmpu & 0x30) >> 2;
+		cfg[1] |= 0x20;
+	}
+	if (xmss_port == 0xe80)
+		cfg[0] |= 0x10;
+	cfg[0] |= 0x40;		/* always set */
+	cfg[1] |= 0x80;		/* enable WSS system */
+	cfg[1] &= ~0x40;	/* disable IDE */
+	snd_printd("hw cfg %x, %x\n", cfg[0], cfg[1]);
+}
+
+static int __devinit sc6000_init_board(char __iomem *vport,
+					char __iomem *vmss_port, int dev)
 {
 	char answer[15];
 	char version[2];
-	int mss_config = sc6000_irq_to_softcfg(irq) |
-			 sc6000_dma_to_softcfg(dma);
+	int mss_config = sc6000_irq_to_softcfg(irq[dev]) |
+			 sc6000_dma_to_softcfg(dma[dev]);
 	int config = mss_config |
-		     sc6000_mpu_irq_to_softcfg(mpu_irq);
+		     sc6000_mpu_irq_to_softcfg(mpu_irq[dev]);
 	int err;
+	int cfg[2];
+	int old = 0;
 
 	err = sc6000_dsp_reset(vport);
 	if (err < 0) {
@@ -360,7 +409,6 @@ static int __devinit sc6000_init_board(char __iomem *vport, int irq, int dma,
 	/*
 	 * My SC-6000 card return "SC-6000" in DSPCopyright, so
 	 * if we have something different, we have to be warned.
-	 * Mine returns "SC-6000A " - KH
 	 */
 	if (strncmp("SC-6000", answer, 7))
 		snd_printk(KERN_WARNING "Warning: non SC-6000 audio card!\n");
@@ -372,13 +420,29 @@ static int __devinit sc6000_init_board(char __iomem *vport, int irq, int dma,
 	printk(KERN_INFO PFX "Detected model: %s, DSP version %d.%d\n",
 		answer, version[0], version[1]);
 
-	/*
-	 * 0x0A == (IRQ 7, DMA 1, MIRQ 0)
-	 */
-	err = sc6000_cfg_write(vport, 0x0a);
+	/* set configuration */
+	sc6000_hw_cfg_encode(vport, &cfg[0], port[dev], mpu_port[dev],
+			     mss_port[dev]);
+	if (sc6000_hw_cfg_write(vport, cfg) < 0) {
+		snd_printk(KERN_ERR "sc6000_hw_cfg_write: failed!\n");
+		return -EIO;
+	}
+	err = sc6000_setup_board(vport, config);
 	if (err < 0) {
-		snd_printk(KERN_ERR "sc6000_cfg_write: failed!\n");
-		return -EFAULT;
+		snd_printk(KERN_ERR "sc6000_setup_board: failed!\n");
+		return -ENODEV;
+	}
+
+	sc6000_dsp_reset(vport);
+	sc6000_write(vport, COMMAND_5C);
+	if (sc6000_read(vport) < 0)
+		old = 1;
+	sc6000_dsp_reset(vport);
+
+	if (!old) {
+		sc6000_write(vport, COMMAND_60);
+		sc6000_write(vport, 0x02);
+		sc6000_dsp_reset(vport);
 	}
 
 	err = sc6000_setup_board(vport, config);
@@ -386,10 +450,9 @@ static int __devinit sc6000_init_board(char __iomem *vport, int irq, int dma,
 		snd_printk(KERN_ERR "sc6000_setup_board: failed!\n");
 		return -ENODEV;
 	}
-
 	err = sc6000_init_mss(vport, config, vmss_port, mss_config);
 	if (err < 0) {
-		snd_printk(KERN_ERR "Can not initialize "
+		snd_printk(KERN_ERR "Cannot initialize "
 			   "Microsoft Sound System mode.\n");
 		return -ENODEV;
 	}
@@ -485,14 +548,14 @@ static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	struct snd_card *card;
 	struct snd_wss *chip;
 	struct snd_opl3 *opl3;
-	char __iomem *vport;
+	char __iomem **vport;
 	char __iomem *vmss_port;
 
-
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, sizeof(vport));
 	if (!card)
 		return -ENOMEM;
 
+	vport = card->private_data;
 	if (xirq == SNDRV_AUTO_IRQ) {
 		xirq = snd_legacy_find_free_irq(possible_irqs);
 		if (xirq < 0) {
@@ -517,8 +580,8 @@ static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
 		err = -EBUSY;
 		goto err_exit;
 	}
-	vport = devm_ioport_map(devptr, port[dev], 0x10);
-	if (!vport) {
+	*vport = devm_ioport_map(devptr, port[dev], 0x10);
+	if (*vport == NULL) {
 		snd_printk(KERN_ERR PFX
 			   "I/O port cannot be iomaped.\n");
 		err = -EBUSY;
@@ -533,7 +596,7 @@ static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
 		goto err_unmap1;
 	}
 	vmss_port = devm_ioport_map(devptr, mss_port[dev], 4);
-	if (!vport) {
+	if (!vmss_port) {
 		snd_printk(KERN_ERR PFX
 			   "MSS port I/O cannot be iomaped.\n");
 		err = -EBUSY;
@@ -544,7 +607,7 @@ static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
 		   port[dev], xirq, xdma,
 		   mpu_irq[dev] == SNDRV_AUTO_IRQ ? 0 : mpu_irq[dev]);
 
-	err = sc6000_init_board(vport, xirq, xdma, vmss_port, mpu_irq[dev]);
+	err = sc6000_init_board(*vport, vmss_port, dev);
 	if (err < 0)
 		goto err_unmap2;
 
@@ -552,7 +615,6 @@ static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
 			     WSS_HW_DETECT, 0, &chip);
 	if (err < 0)
 		goto err_unmap2;
-	card->private_data = chip;
 
 	err = snd_wss_pcm(chip, 0, NULL);
 	if (err < 0) {
@@ -608,6 +670,7 @@ static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	return 0;
 
 err_unmap2:
+	sc6000_setup_board(*vport, 0);
 	release_region(mss_port[dev], 4);
 err_unmap1:
 	release_region(port[dev], 0x10);
@@ -618,11 +681,17 @@ err_exit:
 
 static int __devexit snd_sc6000_remove(struct device *devptr, unsigned int dev)
 {
+	struct snd_card *card = dev_get_drvdata(devptr);
+	char __iomem **vport = card->private_data;
+
+	if (sc6000_setup_board(*vport, 0) < 0)
+		snd_printk(KERN_WARNING "sc6000_setup_board failed on exit!\n");
+
 	release_region(port[dev], 0x10);
 	release_region(mss_port[dev], 4);
 
-	snd_card_free(dev_get_drvdata(devptr));
 	dev_set_drvdata(devptr, NULL);
+	snd_card_free(card);
 	return 0;
 }
 
-- 
1.6.0.3



----------------------------------------------------------------------
Twoj znajomy gwiazda filmu XXX? Wkrec go! ;) 
Kliknij >>> http://link.interia.pl/f20f1
