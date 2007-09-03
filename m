From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] sun-cs4231: code improvements (2nd version)
Date: Mon, 3 Sep 2007 18:41:44 +0200
Message-ID: <20070903184144.54dcfbe4.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 615D72437C
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 18:35:36 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 3 Sep 2007 18:35:26 +0200
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

Do I understand correctly, that lines:

if ((err = function()) < 0) 

are passe now?
They are so abudant in the alsa code, that I thought it is some kind of template code.

I can clean up drivers according to the checkpatch.pl script if it helps (above problem, long lines, etc).

diff -urp linux-2.6.23.old/sound/sparc/cs4231.c linux-2.6.23/sound/sparc/cs4231.c
--- linux-2.6.23.old/sound/sparc/cs4231.c	2007-09-02 14:02:32.000000000 +0200
+++ linux-2.6.23/sound/sparc/cs4231.c	2007-09-03 15:56:03.000000000 +0200
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
 
@@ -389,116 +383,85 @@ static unsigned char snd_cs4231_original
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
 	     timeout--)
 	     	udelay(100);
-#ifdef CONFIG_SND_DEBUG
-	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printdd("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
-#endif
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
+	snd_cs4231_ready(chip);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printdd("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
+		snd_printdd("out: auto calibration time out - reg = 0x%x, "
+			    "value = 0x%x\n",
+			    reg, value);
 #endif
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
+static void snd_cs4231_out(struct snd_cs4231 *chip, unsigned char reg,
+			   unsigned char value)
+{
+	snd_cs4231_dout(chip, reg, value);
 	chip->image[reg] = value;
 	mb();
 }
 
 static unsigned char snd_cs4231_in(struct snd_cs4231 *chip, unsigned char reg)
 {
-	int timeout;
-	unsigned char ret;
-
-	for (timeout = 250;
-	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
-	     timeout--)
-	     	udelay(100);
+	snd_cs4231_ready(chip);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printdd("in: auto calibration time out - reg = 0x%x\n", reg);
+		snd_printdd("in: auto calibration time out - reg = 0x%x\n",
+			    reg);
 #endif
 	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
 	mb();
-	ret = __cs4231_readb(chip, CS4231P(chip, REG));
-	return ret;
+	return __cs4231_readb(chip, CS4231P(chip, REG));
 }
 
 /*
@@ -517,7 +480,7 @@ static void snd_cs4231_busy_wait(struct 
 	for (timeout = 500;
 	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
 	     timeout--)
-	     	udelay(1000);
+		msleep(1);
 }
 
 static void snd_cs4231_mce_up(struct snd_cs4231 *chip)
@@ -526,8 +489,7 @@ static void snd_cs4231_mce_up(struct snd
 	int timeout;
 
 	spin_lock_irqsave(&chip->lock, flags);
-	for (timeout = 250; timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT); timeout--)
-		udelay(100);
+	snd_cs4231_ready(chip);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
 		snd_printdd("mce_up - auto calibration time out (0)\n");
@@ -565,8 +527,8 @@ static void snd_cs4231_mce_down(struct s
 
 	/* calibration process */
 
-	for (timeout = 500; timeout > 0 && (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0; timeout--)
-		udelay(100);
+	snd_cs4231_ready(chip);
+	snd_cs4231_ready(chip);
 	if ((snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0) {
 		snd_printd("cs4231_mce_down - auto calibration time out (1)\n");
 		spin_unlock_irqrestore(&chip->lock, flags);
@@ -1058,11 +1020,6 @@ static int snd_cs4231_playback_hw_params
 	return 0;
 }
 
-static int snd_cs4231_playback_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int snd_cs4231_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
@@ -1100,11 +1057,6 @@ static int snd_cs4231_capture_hw_params(
 	return 0;
 }
 
-static int snd_cs4231_capture_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int snd_cs4231_capture_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
@@ -1182,10 +1134,6 @@ static snd_pcm_uframes_t snd_cs4231_capt
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
-/*
-
- */
-
 static int __init snd_cs4231_probe(struct snd_cs4231 *chip)
 {
 	unsigned long flags;
@@ -1356,7 +1304,7 @@ static struct snd_pcm_ops snd_cs4231_pla
 	.close		=	snd_cs4231_playback_close,
 	.ioctl		=	snd_pcm_lib_ioctl,
 	.hw_params	=	snd_cs4231_playback_hw_params,
-	.hw_free	=	snd_cs4231_playback_hw_free,
+	.hw_free	=	snd_pcm_lib_free_pages,
 	.prepare	=	snd_cs4231_playback_prepare,
 	.trigger	=	snd_cs4231_trigger,
 	.pointer	=	snd_cs4231_playback_pointer,
@@ -1367,18 +1315,20 @@ static struct snd_pcm_ops snd_cs4231_cap
 	.close		=	snd_cs4231_capture_close,
 	.ioctl		=	snd_pcm_lib_ioctl,
 	.hw_params	=	snd_cs4231_capture_hw_params,
-	.hw_free	=	snd_cs4231_capture_hw_free,
+	.hw_free	=	snd_pcm_lib_free_pages,
 	.prepare	=	snd_cs4231_capture_prepare,
 	.trigger	=	snd_cs4231_trigger,
 	.pointer	=	snd_cs4231_capture_pointer,
 };
 
-static int __init snd_cs4231_pcm(struct snd_cs4231 *chip)
+static int __init snd_cs4231_pcm(struct snd_card *card)
 {
+	struct snd_cs4231 *chip = card->private_data;
 	struct snd_pcm *pcm;
 	int err;
 
-	if ((err = snd_pcm_new(chip->card, "CS4231", 0, 1, 1, &pcm)) < 0)
+	err = snd_pcm_new(card, "CS4231", 0, 1, 1, &pcm);
+	if (err < 0)
 		return err;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_cs4231_playback_ops);
@@ -1396,8 +1346,9 @@ static int __init snd_cs4231_pcm(struct 
 	return 0;
 }
 
-static int __init snd_cs4231_timer(struct snd_cs4231 *chip)
+static int __init snd_cs4231_timer(struct snd_card *card)
 {
+	struct snd_cs4231 *chip = card->private_data;
 	struct snd_timer *timer;
 	struct snd_timer_id tid;
 	int err;
@@ -1405,10 +1356,11 @@ static int __init snd_cs4231_timer(struc
 	/* Timer initialization */
 	tid.dev_class = SNDRV_TIMER_CLASS_CARD;
 	tid.dev_sclass = SNDRV_TIMER_SCLASS_NONE;
-	tid.card = chip->card->number;
+	tid.card = card->number;
 	tid.device = 0;
 	tid.subdevice = 0;
-	if ((err = snd_timer_new(chip->card, "CS4231", &tid, &timer)) < 0)
+	err = snd_timer_new(card, "CS4231", &tid, &timer);
+	if (err < 0)
 		return err;
 	strcpy(timer->name, "CS4231");
 	timer->private_data = chip;
@@ -1428,9 +1380,7 @@ static int snd_cs4231_info_mux(struct sn
 	static char *texts[4] = {
 		"Line", "CD", "Mic", "Mix"
 	};
-	struct snd_cs4231 *chip = snd_kcontrol_chip(kcontrol);
 
-	snd_assert(chip->card != NULL, return -EINVAL);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 2;
 	uinfo->value.enumerated.items = 4;
@@ -1670,21 +1620,19 @@ CS4231_SINGLE("Line Out Switch", 0, CS42
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
-		if ((err = snd_ctl_add(card,
-				       snd_ctl_new1(&snd_cs4231_controls[idx],
-						    chip))) < 0)
+		err = snd_ctl_add(card,
+				 snd_ctl_new1(&snd_cs4231_controls[idx], chip));
+		if (err < 0)
 			return err;
 	}
 	return 0;
@@ -1695,6 +1643,7 @@ static int dev;
 static int __init cs4231_attach_begin(struct snd_card **rcard)
 {
 	struct snd_card *card;
+	struct snd_cs4231 *chip;
 
 	*rcard = NULL;
 
@@ -1706,31 +1655,40 @@ static int __init cs4231_attach_begin(st
 		return -ENOENT;
 	}
 
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
+			    sizeof(struct snd_cs4231));
 	if (card == NULL)
 		return -ENOMEM;
 
 	strcpy(card->driver, "CS4231");
 	strcpy(card->shortname, "Sun CS4231");
 
+	chip = card->private_data;
+	chip->card = card;
+
 	*rcard = card;
 	return 0;
 }
 
-static int __init cs4231_attach_finish(struct snd_card *card, struct snd_cs4231 *chip)
+static int __init cs4231_attach_finish(struct snd_card *card)
 {
+	struct snd_cs4231 *chip = card->private_data;
 	int err;
 
-	if ((err = snd_cs4231_pcm(chip)) < 0)
+	err = snd_cs4231_pcm(card);
+	if (err < 0)
 		goto out_err;
 
-	if ((err = snd_cs4231_mixer(chip)) < 0)
+	err = snd_cs4231_mixer(card);
+	if (err < 0)
 		goto out_err;
 
-	if ((err = snd_cs4231_timer(chip)) < 0)
+	err = snd_cs4231_timer(card);
+	if (err < 0)
 		goto out_err;
 
-	if ((err = snd_card_register(card)) < 0)
+	err = snd_card_register(card);
+	if (err < 0)
 		goto out_err;
 
 	chip->next = cs4231_list;
@@ -1925,23 +1883,16 @@ static struct snd_device_ops snd_cs4231_
 
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
@@ -1992,14 +1943,12 @@ static int __init snd_cs4231_sbus_create
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
 
@@ -2013,12 +1962,13 @@ static int __init cs4231_sbus_attach(str
 		(unsigned long long)rp->start,
 		sdev->irqs[0]);
 
-	if ((err = snd_cs4231_sbus_create(card, sdev, dev, &cp)) < 0) {
+	err = snd_cs4231_sbus_create(card, sdev, dev);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
-	return cs4231_attach_finish(card, cp);
+	return cs4231_attach_finish(card);
 }
 #endif
 
@@ -2105,24 +2055,17 @@ static struct snd_device_ops snd_cs4231_
 
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
@@ -2192,14 +2135,12 @@ static int __init snd_cs4231_ebus_create
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
@@ -2211,12 +2152,13 @@ static int __init cs4231_ebus_attach(str
 		edev->resource[0].start,
 		edev->irqs[0]);
 
-	if ((err = snd_cs4231_ebus_create(card, edev, dev, &chip)) < 0) {
+	err = snd_cs4231_ebus_create(card, edev, dev);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
-	return cs4231_attach_finish(card, chip);
+	return cs4231_attach_finish(card);
 }
 #endif
