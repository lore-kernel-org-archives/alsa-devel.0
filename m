From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/2] es1688: allocate snd_es1688 structure as a
 part of snd_card structure
Date: Sun, 9 May 2010 20:35:44 +0200
Message-ID: <20100509203544.29996998.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6232459998451126805=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpo.poczta.interia.pl (smtpo.poczta.interia.pl
	[217.74.65.205]) by alsa0.perex.cz (Postfix) with ESMTP id 5B0F3244D2
	for <alsa-devel@alsa-project.org>;
	Sun,  9 May 2010 20:34:38 +0200 (CEST)
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

--===============6232459998451126805==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Allocate the snd_es1688 during the snd_card allocation.
This allows to remove the card pointer from the snd_es1688 structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This is the second version. It removes kfree(chip) as well.

>> Allocate the snd_es1688 during the snd_card allocation.
>> This allows to remove the card pointer from the snd_es1688 structure.

> Any other merit?

There is no real purpose of this change aside saving one allocation, 
removing one pointer from the structure and making code shorter.

 include/sound/es1688.h        |   10 ++++----
 sound/isa/es1688/es1688.c     |   23 ++++++++++++---------
 sound/isa/es1688/es1688_lib.c |   44 +++++++++++++---------------------------
 sound/isa/gus/gusextreme.c    |   26 +++++++++++++-----------
 4 files changed, 46 insertions(+), 57 deletions(-)

diff --git a/include/sound/es1688.h b/include/sound/es1688.h
index 10fcf14..4c29572 100644
--- a/include/sound/es1688.h
+++ b/include/sound/es1688.h
@@ -44,7 +44,6 @@ struct snd_es1688 {
 	unsigned char pad;
 	unsigned int dma_size;
 
-	struct snd_card *card;
 	struct snd_pcm *pcm;
 	struct snd_pcm_substream *playback_substream;
 	struct snd_pcm_substream *capture_substream;
@@ -108,14 +107,15 @@ struct snd_es1688 {
 void snd_es1688_mixer_write(struct snd_es1688 *chip, unsigned char reg, unsigned char data);
 
 int snd_es1688_create(struct snd_card *card,
+		      struct snd_es1688 *chip,
 		      unsigned long port,
 		      unsigned long mpu_port,
 		      int irq,
 		      int mpu_irq,
 		      int dma8,
-		      unsigned short hardware,
-		      struct snd_es1688 ** rchip);
-int snd_es1688_pcm(struct snd_es1688 *chip, int device, struct snd_pcm ** rpcm);
-int snd_es1688_mixer(struct snd_es1688 *chip);
+		      unsigned short hardware);
+int snd_es1688_pcm(struct snd_card *card, struct snd_es1688 *chip, int device,
+		   struct snd_pcm **rpcm);
+int snd_es1688_mixer(struct snd_card *card, struct snd_es1688 *chip);
 
 #endif /* __SOUND_ES1688_H */
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index 07df201..2816794 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -79,8 +79,8 @@ static int __devinit snd_es1688_match(struct device *dev, unsigned int n)
 	return enable[n];
 }
 
-static int __devinit snd_es1688_legacy_create(struct snd_card *card, 
-		struct device *dev, unsigned int n, struct snd_es1688 **rchip)
+static int __devinit snd_es1688_legacy_create(struct snd_card *card,
+		struct snd_es1688 *chip, struct device *dev, unsigned int n)
 {
 	static long possible_ports[] = {0x220, 0x240, 0x260};
 	static int possible_irqs[] = {5, 9, 10, 7, -1};
@@ -104,14 +104,14 @@ static int __devinit snd_es1688_legacy_create(struct snd_card *card,
 	}
 
 	if (port[n] != SNDRV_AUTO_PORT)
-		return snd_es1688_create(card, port[n], mpu_port[n], irq[n],
-				mpu_irq[n], dma8[n], ES1688_HW_AUTO, rchip);
+		return snd_es1688_create(card, chip, port[n], mpu_port[n],
+				irq[n], mpu_irq[n], dma8[n], ES1688_HW_AUTO);
 
 	i = 0;
 	do {
 		port[n] = possible_ports[i];
-		error = snd_es1688_create(card, port[n], mpu_port[n], irq[n],
-				mpu_irq[n], dma8[n], ES1688_HW_AUTO, rchip);
+		error = snd_es1688_create(card, chip, port[n], mpu_port[n],
+				irq[n], mpu_irq[n], dma8[n], ES1688_HW_AUTO);
 	} while (error < 0 && ++i < ARRAY_SIZE(possible_ports));
 
 	return error;
@@ -125,19 +125,22 @@ static int __devinit snd_es1688_probe(struct device *dev, unsigned int n)
 	struct snd_pcm *pcm;
 	int error;
 
-	error = snd_card_create(index[n], id[n], THIS_MODULE, 0, &card);
+	error = snd_card_create(index[n], id[n], THIS_MODULE,
+				sizeof(struct snd_es1688), &card);
 	if (error < 0)
 		return error;
 
-	error = snd_es1688_legacy_create(card, dev, n, &chip);
+	chip = card->private_data;
+
+	error = snd_es1688_legacy_create(card, chip, dev, n);
 	if (error < 0)
 		goto out;
 
-	error = snd_es1688_pcm(chip, 0, &pcm);
+	error = snd_es1688_pcm(card, chip, 0, &pcm);
 	if (error < 0)
 		goto out;
 
-	error = snd_es1688_mixer(chip);
+	error = snd_es1688_mixer(card, chip);
 	if (error < 0)
 		goto out;
 
diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index c76bb00..fdd4404 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -620,7 +620,6 @@ static int snd_es1688_free(struct snd_es1688 *chip)
 		disable_dma(chip->dma8);
 		free_dma(chip->dma8);
 	}
-	kfree(chip);
 	return 0;
 }
 
@@ -638,23 +637,20 @@ static const char *snd_es1688_chip_id(struct snd_es1688 *chip)
 }
 
 int snd_es1688_create(struct snd_card *card,
+		      struct snd_es1688 *chip,
 		      unsigned long port,
 		      unsigned long mpu_port,
 		      int irq,
 		      int mpu_irq,
 		      int dma8,
-		      unsigned short hardware,
-		      struct snd_es1688 **rchip)
+		      unsigned short hardware)
 {
 	static struct snd_device_ops ops = {
 		.dev_free =	snd_es1688_dev_free,
 	};
                                 
-	struct snd_es1688 *chip;
 	int err;
 
-	*rchip = NULL;
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	chip->irq = -1;
@@ -662,25 +658,21 @@ int snd_es1688_create(struct snd_card *card,
 	
 	if ((chip->res_port = request_region(port + 4, 12, "ES1688")) == NULL) {
 		snd_printk(KERN_ERR "es1688: can't grab port 0x%lx\n", port + 4);
-		snd_es1688_free(chip);
 		return -EBUSY;
 	}
 	if (request_irq(irq, snd_es1688_interrupt, IRQF_DISABLED, "ES1688", (void *) chip)) {
 		snd_printk(KERN_ERR "es1688: can't grab IRQ %d\n", irq);
-		snd_es1688_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = irq;
 	if (request_dma(dma8, "ES1688")) {
 		snd_printk(KERN_ERR "es1688: can't grab DMA8 %d\n", dma8);
-		snd_es1688_free(chip);
 		return -EBUSY;
 	}
 	chip->dma8 = dma8;
 
 	spin_lock_init(&chip->reg_lock);
 	spin_lock_init(&chip->mixer_lock);
-	chip->card = card;
 	chip->port = port;
 	mpu_port &= ~0x000f;
 	if (mpu_port < 0x300 || mpu_port > 0x330)
@@ -689,23 +681,16 @@ int snd_es1688_create(struct snd_card *card,
 	chip->mpu_irq = mpu_irq;
 	chip->hardware = hardware;
 
-	if ((err = snd_es1688_probe(chip)) < 0) {
-		snd_es1688_free(chip);
+	err = snd_es1688_probe(chip);
+	if (err < 0)
 		return err;
-	}
-	if ((err = snd_es1688_init(chip, 1)) < 0) {
-		snd_es1688_free(chip);
-		return err;
-	}
 
-	/* Register device */
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_es1688_free(chip);
+	err = snd_es1688_init(chip, 1);
+	if (err < 0)
 		return err;
-	}
 
-	*rchip = chip;
-	return 0;
+	/* Register device */
+	return snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 }
 
 static struct snd_pcm_ops snd_es1688_playback_ops = {
@@ -730,12 +715,14 @@ static struct snd_pcm_ops snd_es1688_capture_ops = {
 	.pointer =		snd_es1688_capture_pointer,
 };
 
-int snd_es1688_pcm(struct snd_es1688 * chip, int device, struct snd_pcm ** rpcm)
+int snd_es1688_pcm(struct snd_card *card, struct snd_es1688 *chip,
+		   int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if ((err = snd_pcm_new(chip->card, "ESx688", device, 1, 1, &pcm)) < 0)
+	err = snd_pcm_new(card, "ESx688", device, 1, 1, &pcm);
+	if (err < 0)
 		return err;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_es1688_playback_ops);
@@ -1009,18 +996,15 @@ static unsigned char snd_es1688_init_table[][2] = {
 	{ ES1688_REC_DEV, 0x17 }
 };
                                         
-int snd_es1688_mixer(struct snd_es1688 *chip)
+int snd_es1688_mixer(struct snd_card *card, struct snd_es1688 *chip)
 {
-	struct snd_card *card;
 	unsigned int idx;
 	int err;
 	unsigned char reg, val;
 
-	if (snd_BUG_ON(!chip || !chip->card))
+	if (snd_BUG_ON(!chip || !card))
 		return -EINVAL;
 
-	card = chip->card;
-
 	strcpy(card->mixername, snd_es1688_chip_id(chip));
 
 	for (idx = 0; idx < ARRAY_SIZE(snd_es1688_controls); idx++) {
diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index 65e4b18..008e8e5 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -95,7 +95,7 @@ static int __devinit snd_gusextreme_match(struct device *dev, unsigned int n)
 }
 
 static int __devinit snd_gusextreme_es1688_create(struct snd_card *card,
-		struct device *dev, unsigned int n, struct snd_es1688 **rchip)
+		struct snd_es1688 *chip, struct device *dev, unsigned int n)
 {
 	static long possible_ports[] = {0x220, 0x240, 0x260};
 	static int possible_irqs[] = {5, 9, 10, 7, -1};
@@ -119,14 +119,14 @@ static int __devinit snd_gusextreme_es1688_create(struct snd_card *card,
 	}
 
 	if (port[n] != SNDRV_AUTO_PORT)
-		return snd_es1688_create(card, port[n], mpu_port[n], irq[n],
-				mpu_irq[n], dma8[n], ES1688_HW_1688, rchip);
+		return snd_es1688_create(card, chip, port[n], mpu_port[n],
+				irq[n], mpu_irq[n], dma8[n], ES1688_HW_1688);
 
 	i = 0;
 	do {
 		port[n] = possible_ports[i];
-		error = snd_es1688_create(card, port[n], mpu_port[n], irq[n],
-				mpu_irq[n], dma8[n], ES1688_HW_1688, rchip);
+		error = snd_es1688_create(card, chip, port[n], mpu_port[n],
+				irq[n], mpu_irq[n], dma8[n], ES1688_HW_1688);
 	} while (error < 0 && ++i < ARRAY_SIZE(possible_ports));
 
 	return error;
@@ -206,9 +206,8 @@ static int __devinit snd_gusextreme_detect(struct snd_gus_card *gus,
 	return 0;
 }
 
-static int __devinit snd_gusextreme_mixer(struct snd_es1688 *chip)
+static int __devinit snd_gusextreme_mixer(struct snd_card *card)
 {
-	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id1, id2;
 	int error;
 
@@ -241,17 +240,20 @@ static int __devinit snd_gusextreme_probe(struct device *dev, unsigned int n)
 	struct snd_opl3 *opl3;
 	int error;
 
-	error = snd_card_create(index[n], id[n], THIS_MODULE, 0, &card);
+	error = snd_card_create(index[n], id[n], THIS_MODULE,
+				sizeof(struct snd_es1688), &card);
 	if (error < 0)
 		return error;
 
+	es1688 = card->private_data;
+
 	if (mpu_port[n] == SNDRV_AUTO_PORT)
 		mpu_port[n] = 0;
 
 	if (mpu_irq[n] > 15)
 		mpu_irq[n] = -1;
 
-	error = snd_gusextreme_es1688_create(card, dev, n, &es1688);
+	error = snd_gusextreme_es1688_create(card, es1688, dev, n);
 	if (error < 0)
 		goto out;
 
@@ -280,11 +282,11 @@ static int __devinit snd_gusextreme_probe(struct device *dev, unsigned int n)
 	}
 	gus->codec_flag = 1;
 
-	error = snd_es1688_pcm(es1688, 0, NULL);
+	error = snd_es1688_pcm(card, es1688, 0, NULL);
 	if (error < 0)
 		goto out;
 
-	error = snd_es1688_mixer(es1688);
+	error = snd_es1688_mixer(card, es1688);
 	if (error < 0)
 		goto out;
 
@@ -300,7 +302,7 @@ static int __devinit snd_gusextreme_probe(struct device *dev, unsigned int n)
 	if (error < 0)
 		goto out;
 
-	error = snd_gusextreme_mixer(es1688);
+	error = snd_gusextreme_mixer(card);
 	if (error < 0)
 		goto out;
 
-- 
1.6.4


----------------------------------------------------------------------
Sprawdź jak dać rodzinie poczucie bezpieczeństwa.
http://clk.tradedoubler.com/click?p=191431&a=1694818&g=18733532


--===============6232459998451126805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6232459998451126805==--
