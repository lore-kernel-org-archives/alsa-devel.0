From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] sun-cs4231: code improvements
Date: Sun, 2 Sep 2007 22:16:15 +0200
Message-ID: <20070902221615.b7a7deb0.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 065D124345
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Sep 2007 22:10:04 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 2 Sep 2007 22:10:03 +0200
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

This patch does some code improvements to make
driver (both code and binary) shorter.
It also make use of card->private_data pointer to
store chip information.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-2.6.23.old/sound/sparc/cs4231.c linux-2.6.23/sound/sparc/cs4231.c
--- linux-2.6.23.old/sound/sparc/cs4231.c	2007-09-02 14:02:32.000000000 +0200
+++ linux-2.6.23/sound/sparc/cs4231.c	2007-09-02 19:11:28.000000000 +0200
@@ -30,17 +30,11 @@
 
 #ifdef CONFIG_SBUS
 #define SBUS_SUPPORT
-#endif
-
-#ifdef SBUS_SUPPORT
 #include <asm/sbus.h>
 #endif
 
 #if defined(CONFIG_PCI) && defined(CONFIG_SPARC64)
 #define EBUS_SUPPORT
-#endif
-
-#ifdef EBUS_SUPPORT
 #include <linux/pci.h>
 #include <asm/ebus.h>
 #endif
@@ -339,7 +333,7 @@ static unsigned int rates[14] = {
 };
 
 static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
-	.count	= 14,
+	.count	= ARRAY_SIZE(rates),
 	.list	= rates,
 };
 
@@ -389,42 +383,34 @@ static unsigned char snd_cs4231_original
 static u8 __cs4231_readb(struct snd_cs4231 *cp, void __iomem *reg_addr)
 {
 #ifdef EBUS_SUPPORT
-	if (cp->flags & CS4231_FLAG_EBUS) {
+	if (cp->flags & CS4231_FLAG_EBUS)
 		return readb(reg_addr);
-	} else {
+	else
 #endif
 #ifdef SBUS_SUPPORT
 		return sbus_readb(reg_addr);
 #endif
-#ifdef EBUS_SUPPORT
-	}
-#endif
 }
 
 static void __cs4231_writeb(struct snd_cs4231 *cp, u8 val, void __iomem *reg_addr)
 {
 #ifdef EBUS_SUPPORT
-	if (cp->flags & CS4231_FLAG_EBUS) {
+	if (cp->flags & CS4231_FLAG_EBUS)
 		return writeb(val, reg_addr);
-	} else {
+	else
 #endif
 #ifdef SBUS_SUPPORT
 		return sbus_writeb(val, reg_addr);
 #endif
-#ifdef EBUS_SUPPORT
-	}
-#endif
 }
 
 /*
  *  Basic I/O functions
  */
 
-static void snd_cs4231_outm(struct snd_cs4231 *chip, unsigned char reg,
-		     unsigned char mask, unsigned char value)
+static void snd_cs4231_ready(struct snd_cs4231 *chip)
 {
 	int timeout;
-	unsigned char tmp;
 
 	for (timeout = 250;
 	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
@@ -434,50 +420,30 @@ static void snd_cs4231_outm(struct snd_c
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
 		snd_printdd("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
-	if (chip->calibrate_mute) {
-		chip->image[reg] &= mask;
-		chip->image[reg] |= value;
-	} else {
-		__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
-		mb();
-		tmp = (chip->image[reg] & mask) | value;
-		__cs4231_writeb(chip, tmp, CS4231P(chip, REG));
-		chip->image[reg] = tmp;
-		mb();
-	}
 }
 
 static void snd_cs4231_dout(struct snd_cs4231 *chip, unsigned char reg, unsigned char value)
 {
-	int timeout;
-
-	for (timeout = 250;
-	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
-	     timeout--)
-	     	udelay(100);
-#ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printdd("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
-#endif
+	snd_cs4231_ready(chip);
 	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
+	wmb();
 	__cs4231_writeb(chip, value, CS4231P(chip, REG));
 	mb();
 }
 
-static void snd_cs4231_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char value)
+static inline void snd_cs4231_outm(struct snd_cs4231 *chip, unsigned char reg,
+		     unsigned char mask, unsigned char value)
 {
-	int timeout;
+	unsigned char tmp = (chip->image[reg] & mask) | value;
 
-	for (timeout = 250;
-	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
-	     timeout--)
-	     	udelay(100);
-#ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printdd("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
-#endif
-	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
-	__cs4231_writeb(chip, value, CS4231P(chip, REG));
+	chip->image[reg] = tmp;
+	if (!chip->calibrate_mute)
+		snd_cs4231_dout(chip, reg, tmp);
+}
+
+static void snd_cs4231_out(struct snd_cs4231 *chip, unsigned char reg, unsigned char value)
+{
+	snd_cs4231_dout(chip, reg, value);
 	chip->image[reg] = value;
 	mb();
 }
@@ -1373,12 +1339,13 @@ static struct snd_pcm_ops snd_cs4231_cap
 	.pointer	=	snd_cs4231_capture_pointer,
 };
 
-static int __init snd_cs4231_pcm(struct snd_cs4231 *chip)
+static int __init snd_cs4231_pcm(struct snd_card *card)
 {
+	struct snd_cs4231 *chip = card->private_data;
 	struct snd_pcm *pcm;
 	int err;
 
-	if ((err = snd_pcm_new(chip->card, "CS4231", 0, 1, 1, &pcm)) < 0)
+	if ((err = snd_pcm_new(card, "CS4231", 0, 1, 1, &pcm)) < 0)
 		return err;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_cs4231_playback_ops);
@@ -1396,8 +1363,9 @@ static int __init snd_cs4231_pcm(struct 
 	return 0;
 }
 
-static int __init snd_cs4231_timer(struct snd_cs4231 *chip)
+static int __init snd_cs4231_timer(struct snd_card *card)
 {
+	struct snd_cs4231 *chip = card->private_data;
 	struct snd_timer *timer;
 	struct snd_timer_id tid;
 	int err;
@@ -1405,10 +1373,10 @@ static int __init snd_cs4231_timer(struc
 	/* Timer initialization */
 	tid.dev_class = SNDRV_TIMER_CLASS_CARD;
 	tid.dev_sclass = SNDRV_TIMER_SCLASS_NONE;
-	tid.card = chip->card->number;
+	tid.card = card->number;
 	tid.device = 0;
 	tid.subdevice = 0;
-	if ((err = snd_timer_new(chip->card, "CS4231", &tid, &timer)) < 0)
+	if ((err = snd_timer_new(card, "CS4231", &tid, &timer)) < 0)
 		return err;
 	strcpy(timer->name, "CS4231");
 	timer->private_data = chip;
@@ -1428,9 +1396,7 @@ static int snd_cs4231_info_mux(struct sn
 	static char *texts[4] = {
 		"Line", "CD", "Mic", "Mix"
 	};
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
 
-	snd_assert(chip->card != NULL, return -EINVAL);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 2;
 	uinfo->value.enumerated.items = 4;
@@ -1670,15 +1636,13 @@ CS4231_SINGLE("Line Out Switch", 0, CS42
 CS4231_SINGLE("Headphone Out Switch", 0, CS4231_PIN_CTRL, 7, 1, 1)
 };
                                         
-static int __init snd_cs4231_mixer(struct snd_cs4231 *chip)
+static int __init snd_cs4231_mixer(struct snd_card *card)
 {
-	struct snd_card *card;
+	struct snd_cs4231 *chip = card->private_data;
 	int err, idx;
 
 	snd_assert(chip != NULL && chip->pcm != NULL, return -EINVAL);
 
-	card = chip->card;
-
 	strcpy(card->mixername, chip->pcm->name);
 
 	for (idx = 0; idx < ARRAY_SIZE(snd_cs4231_controls); idx++) {
@@ -1695,6 +1659,7 @@ static int dev;
 static int __init cs4231_attach_begin(struct snd_card **rcard)
 {
 	struct snd_card *card;
+	struct snd_cs4231 *chip;
 
 	*rcard = NULL;
 
@@ -1706,28 +1671,33 @@ static int __init cs4231_attach_begin(st
 		return -ENOENT;
 	}
 
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
+			    sizeof(struct snd_cs4231));
 	if (card == NULL)
 		return -ENOMEM;
 
 	strcpy(card->driver, "CS4231");
 	strcpy(card->shortname, "Sun CS4231");
+	
+	chip = card->private_data;
+	chip->card = card;
 
 	*rcard = card;
 	return 0;
 }
 
-static int __init cs4231_attach_finish(struct snd_card *card, struct snd_cs4231 *chip)
+static int __init cs4231_attach_finish(struct snd_card *card)
 {
+	struct snd_cs4231 *chip = card->private_data;
 	int err;
 
-	if ((err = snd_cs4231_pcm(chip)) < 0)
+	if ((err = snd_cs4231_pcm(card)) < 0)
 		goto out_err;
 
-	if ((err = snd_cs4231_mixer(chip)) < 0)
+	if ((err = snd_cs4231_mixer(card)) < 0)
 		goto out_err;
 
-	if ((err = snd_cs4231_timer(chip)) < 0)
+	if ((err = snd_cs4231_timer(card)) < 0)
 		goto out_err;
 
 	if ((err = snd_card_register(card)) < 0)
@@ -1925,23 +1895,16 @@ static struct snd_device_ops snd_cs4231_
 
 static int __init snd_cs4231_sbus_create(struct snd_card *card,
 					 struct sbus_dev *sdev,
-					 int dev,
-					 struct snd_cs4231 **rchip)
+					 int dev)
 {
-	struct snd_cs4231 *chip;
+	struct snd_cs4231 *chip = card->private_data;
 	int err;
 
-	*rchip = NULL;
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
-
 	spin_lock_init(&chip->lock);
 	spin_lock_init(&chip->c_dma.sbus_info.lock);
 	spin_lock_init(&chip->p_dma.sbus_info.lock);
 	mutex_init(&chip->mce_mutex);
 	mutex_init(&chip->open_mutex);
-	chip->card = card;
 	chip->dev_u.sdev = sdev;
 	chip->regs_size = sdev->reg_addrs[0].reg_size;
 	memcpy(&chip->image, &snd_cs4231_original_image,
@@ -1992,14 +1955,12 @@ static int __init snd_cs4231_sbus_create
 		return err;
 	}
 
-	*rchip = chip;
 	return 0;
 }
 
 static int __init cs4231_sbus_attach(struct sbus_dev *sdev)
 {
 	struct resource *rp = &sdev->resource[0];
-	struct snd_cs4231 *cp;
 	struct snd_card *card;
 	int err;
 
@@ -2013,12 +1974,12 @@ static int __init cs4231_sbus_attach(str
 		(unsigned long long)rp->start,
 		sdev->irqs[0]);
 
-	if ((err = snd_cs4231_sbus_create(card, sdev, dev, &cp)) < 0) {
+	if ((err = snd_cs4231_sbus_create(card, sdev, dev)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
-	return cs4231_attach_finish(card, cp);
+	return cs4231_attach_finish(card);
 }
 #endif
 
@@ -2105,24 +2066,17 @@ static struct snd_device_ops snd_cs4231_
 
 static int __init snd_cs4231_ebus_create(struct snd_card *card,
 					 struct linux_ebus_device *edev,
-					 int dev,
-					 struct snd_cs4231 **rchip)
+					 int dev)
 {
-	struct snd_cs4231 *chip;
+	struct snd_cs4231 *chip = card->private_data;
 	int err;
 
-	*rchip = NULL;
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
-
 	spin_lock_init(&chip->lock);
 	spin_lock_init(&chip->c_dma.ebus_info.lock);
 	spin_lock_init(&chip->p_dma.ebus_info.lock);
 	mutex_init(&chip->mce_mutex);
 	mutex_init(&chip->open_mutex);
 	chip->flags |= CS4231_FLAG_EBUS;
-	chip->card = card;
 	chip->dev_u.pdev = edev->bus->self;
 	memcpy(&chip->image, &snd_cs4231_original_image,
 	       sizeof(snd_cs4231_original_image));
@@ -2192,14 +2146,12 @@ static int __init snd_cs4231_ebus_create
 		return err;
 	}
 
-	*rchip = chip;
 	return 0;
 }
 
 static int __init cs4231_ebus_attach(struct linux_ebus_device *edev)
 {
 	struct snd_card *card;
-	struct snd_cs4231 *chip;
 	int err;
 
 	err = cs4231_attach_begin(&card);
@@ -2211,12 +2163,12 @@ static int __init cs4231_ebus_attach(str
 		edev->resource[0].start,
 		edev->irqs[0]);
 
-	if ((err = snd_cs4231_ebus_create(card, edev, dev, &chip)) < 0) {
+	if ((err = snd_cs4231_ebus_create(card, edev, dev)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
-	return cs4231_attach_finish(card, chip);
+	return cs4231_attach_finish(card);
 }
 #endif
