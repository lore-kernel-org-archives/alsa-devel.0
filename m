From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 1/2] snd-ad1816a: remove useless struct
	snd_card_ad1816a
Date: Sun, 19 Aug 2012 23:27:19 +0200
Message-ID: <201208192327.19752.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 66D7A265D12
 for <alsa-devel@alsa-project.org>; Sun, 19 Aug 2012 22:57:59 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Massimo Piccioni <dafastidio@libero.it>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

struct snd_card_ad1816a is only set but the values are never used then.
Removing it allows struct snd_card's private_data to be used for
struct snd_ad1816a, simplifying the code.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

diff --git a/include/sound/ad1816a.h b/include/sound/ad1816a.h
index d010858..62da41e 100644
--- a/include/sound/ad1816a.h
+++ b/include/sound/ad1816a.h
@@ -165,7 +165,7 @@ struct snd_ad1816a {
 
 extern int snd_ad1816a_create(struct snd_card *card, unsigned long port,
 			      int irq, int dma1, int dma2,
-			      struct snd_ad1816a **chip);
+			      struct snd_ad1816a *chip);
 
 extern int snd_ad1816a_pcm(struct snd_ad1816a *chip, int device, struct snd_pcm **rpcm);
 extern int snd_ad1816a_mixer(struct snd_ad1816a *chip);
diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 94b83b6..1a374e6 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -63,11 +63,6 @@ MODULE_PARM_DESC(enable, "Enable ad1816a based soundcard.");
 module_param_array(clockfreq, int, NULL, 0444);
 MODULE_PARM_DESC(clockfreq, "Clock frequency for ad1816a driver (default = 0).");
 
-struct snd_card_ad1816a {
-	struct pnp_dev *dev;
-	struct pnp_dev *devmpu;
-};
-
 static struct pnp_card_device_id snd_ad1816a_pnpids[] = {
 	/* Analog Devices AD1815 */
 	{ .id = "ADS7150", .devs = { { .id = "ADS7150" }, { .id = "ADS7151" } } },
@@ -99,25 +94,16 @@ MODULE_DEVICE_TABLE(pnp_card, snd_ad1816a_pnpids);
 #define	DRIVER_NAME	"snd-card-ad1816a"
 
 
-static int __devinit snd_card_ad1816a_pnp(int dev, struct snd_card_ad1816a *acard,
-					  struct pnp_card_link *card,
+static int __devinit snd_card_ad1816a_pnp(int dev, struct pnp_card_link *card,
 					  const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
 	int err;
 
-	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->dev == NULL)
+	pdev = pnp_request_card_device(card, id->devs[0].id, NULL);
+	if (pdev == NULL)
 		return -EBUSY;
 
-	acard->devmpu = pnp_request_card_device(card, id->devs[1].id, NULL);
-	if (acard->devmpu == NULL) {
-		mpu_port[dev] = -1;
-		snd_printk(KERN_WARNING PFX "MPU401 device busy, skipping.\n");
-	}
-
-	pdev = acard->dev;
-
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		printk(KERN_ERR PFX "AUDIO PnP configure failure\n");
@@ -130,16 +116,17 @@ static int __devinit snd_card_ad1816a_pnp(int dev, struct snd_card_ad1816a *acar
 	dma2[dev] = pnp_dma(pdev, 1);
 	irq[dev] = pnp_irq(pdev, 0);
 
-	if (acard->devmpu == NULL)
+	pdev = pnp_request_card_device(card, id->devs[1].id, NULL);
+	if (pdev == NULL) {
+		mpu_port[dev] = -1;
+		snd_printk(KERN_WARNING PFX "MPU401 device busy, skipping.\n");
 		return 0;
-
-	pdev = acard->devmpu;
+	}
 
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		printk(KERN_ERR PFX "MPU401 PnP configure failure\n");
 		mpu_port[dev] = -1;
-		acard->devmpu = NULL;
 	} else {
 		mpu_port[dev] = pnp_port_start(pdev, 0);
 		mpu_irq[dev] = pnp_irq(pdev, 0);
@@ -153,18 +140,17 @@ static int __devinit snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard
 {
 	int error;
 	struct snd_card *card;
-	struct snd_card_ad1816a *acard;
 	struct snd_ad1816a *chip;
 	struct snd_opl3 *opl3;
 	struct snd_timer *timer;
 
 	error = snd_card_create(index[dev], id[dev], THIS_MODULE,
-				sizeof(struct snd_card_ad1816a), &card);
+				sizeof(struct snd_ad1816a), &card);
 	if (error < 0)
 		return error;
-	acard = card->private_data;
+	chip = card->private_data;
 
-	if ((error = snd_card_ad1816a_pnp(dev, acard, pcard, pid))) {
+	if ((error = snd_card_ad1816a_pnp(dev, pcard, pid))) {
 		snd_card_free(card);
 		return error;
 	}
@@ -174,7 +160,7 @@ static int __devinit snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard
 					irq[dev],
 					dma1[dev],
 					dma2[dev],
-					&chip)) < 0) {
+					chip)) < 0) {
 		snd_card_free(card);
 		return error;
 	}
diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index 177eed3..de5cc1c 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -548,7 +548,6 @@ static int snd_ad1816a_free(struct snd_ad1816a *chip)
 		snd_dma_disable(chip->dma2);
 		free_dma(chip->dma2);
 	}
-	kfree(chip);
 	return 0;
 }
 
@@ -573,19 +572,13 @@ static const char __devinit *snd_ad1816a_chip_id(struct snd_ad1816a *chip)
 
 int __devinit snd_ad1816a_create(struct snd_card *card,
 				 unsigned long port, int irq, int dma1, int dma2,
-				 struct snd_ad1816a **rchip)
+				 struct snd_ad1816a *chip)
 {
         static struct snd_device_ops ops = {
 		.dev_free =	snd_ad1816a_dev_free,
 	};
 	int error;
-	struct snd_ad1816a *chip;
 
-	*rchip = NULL;
-
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
 	chip->irq = -1;
 	chip->dma1 = -1;
 	chip->dma2 = -1;
@@ -631,7 +624,6 @@ int __devinit snd_ad1816a_create(struct snd_card *card,
 		return error;
 	}
 
-	*rchip = chip;
 	return 0;
 }
 

-- 
Ondrej Zary
