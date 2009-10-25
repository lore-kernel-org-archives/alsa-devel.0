From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/2] es18xx: remove snd_audiodrive structure
Date: Sun, 25 Oct 2009 11:10:01 +0100
Message-ID: <20091025111001.ebef2a07.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id A98282443F
	for <alsa-devel@alsa-project.org>; Sun, 25 Oct 2009 10:52:55 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove intermediate snd_audiodrive structure between
snd_card structure and snd_es18xx. This reduces size of
source code and binary driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/es18xx.c |   71 ++++++++++++++++++---------------------------------
 1 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 160752b..5cf42b4 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -139,10 +139,6 @@ struct snd_es18xx {
 #ifdef CONFIG_PM
 	unsigned char pm_reg;
 #endif
-};
-
-struct snd_audiodrive {
-	struct snd_es18xx *chip;
 #ifdef CONFIG_PNP
 	struct pnp_dev *dev;
 	struct pnp_dev *devc;
@@ -755,8 +751,7 @@ static int snd_es18xx_playback_trigger(struct snd_pcm_substream *substream,
 static irqreturn_t snd_es18xx_interrupt(int irq, void *dev_id)
 {
 	struct snd_card *card = dev_id;
-	struct snd_audiodrive *acard = card->private_data;
-	struct snd_es18xx *chip = acard->chip;
+	struct snd_es18xx *chip = card->private_data;
 	unsigned char status;
 
 	if (chip->caps & ES18XX_CONTROL) {
@@ -1699,8 +1694,7 @@ static struct snd_pcm_ops snd_es18xx_capture_ops = {
 static int __devinit snd_es18xx_pcm(struct snd_card *card, int device,
 				    struct snd_pcm **rpcm)
 {
-	struct snd_audiodrive *acard = card->private_data;
-	struct snd_es18xx *chip = acard->chip;
+	struct snd_es18xx *chip = card->private_data;
         struct snd_pcm *pcm;
 	char str[16];
 	int err;
@@ -1742,8 +1736,7 @@ static int __devinit snd_es18xx_pcm(struct snd_card *card, int device,
 #ifdef CONFIG_PM
 static int snd_es18xx_suspend(struct snd_card *card, pm_message_t state)
 {
-	struct snd_audiodrive *acard = card->private_data;
-	struct snd_es18xx *chip = acard->chip;
+	struct snd_es18xx *chip = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
@@ -1760,8 +1753,7 @@ static int snd_es18xx_suspend(struct snd_card *card, pm_message_t state)
 
 static int snd_es18xx_resume(struct snd_card *card)
 {
-	struct snd_audiodrive *acard = card->private_data;
-	struct snd_es18xx *chip = acard->chip;
+	struct snd_es18xx *chip = card->private_data;
 
 	/* restore PM register, we won't wake till (not 0x07) i/o activity though */
 	snd_es18xx_write(chip, ES18XX_PM, chip->pm_reg ^= ES18XX_PM_FM);
@@ -1773,8 +1765,7 @@ static int snd_es18xx_resume(struct snd_card *card)
 
 static int snd_es18xx_free(struct snd_card *card)
 {
-	struct snd_audiodrive *acard = card->private_data;
-	struct snd_es18xx *chip = acard->chip;
+	struct snd_es18xx *chip = card->private_data;
 
 	release_and_free_resource(chip->res_port);
 	release_and_free_resource(chip->res_ctrl_port);
@@ -1789,7 +1780,6 @@ static int snd_es18xx_free(struct snd_card *card)
 		disable_dma(chip->dma2);
 		free_dma(chip->dma2);
 	}
-	kfree(chip);
 	return 0;
 }
 
@@ -1802,19 +1792,14 @@ static int __devinit snd_es18xx_new_device(struct snd_card *card,
 					   unsigned long port,
 					   unsigned long mpu_port,
 					   unsigned long fm_port,
-					   int irq, int dma1, int dma2,
-					   struct snd_es18xx ** rchip)
+					   int irq, int dma1, int dma2)
 {
-        struct snd_es18xx *chip;
+	struct snd_es18xx *chip = card->private_data;
 	static struct snd_device_ops ops = {
 		.dev_free =	snd_es18xx_dev_free,
         };
 	int err;
 
-	*rchip = NULL;
-        chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
  	spin_lock_init(&chip->mixer_lock);
  	spin_lock_init(&chip->ctrl_lock);
@@ -1865,14 +1850,12 @@ static int __devinit snd_es18xx_new_device(struct snd_card *card,
 		snd_es18xx_free(card);
 		return err;
 	}
-        *rchip = chip;
         return 0;
 }
 
 static int __devinit snd_es18xx_mixer(struct snd_card *card)
 {
-	struct snd_audiodrive *acard = card->private_data;
-	struct snd_es18xx *chip = acard->chip;
+	struct snd_es18xx *chip = card->private_data;
 	int err;
 	unsigned int idx;
 
@@ -2074,11 +2057,11 @@ static int __devinit snd_audiodrive_pnp_init_main(int dev, struct pnp_dev *pdev)
 	return 0;
 }
 
-static int __devinit snd_audiodrive_pnp(int dev, struct snd_audiodrive *acard,
+static int __devinit snd_audiodrive_pnp(int dev, struct snd_es18xx *chip,
 					struct pnp_dev *pdev)
 {
-	acard->dev = pdev;
-	if (snd_audiodrive_pnp_init_main(dev, acard->dev) < 0)
+	chip->dev = pdev;
+	if (snd_audiodrive_pnp_init_main(dev, chip->dev) < 0)
 		return -EBUSY;
 	return 0;
 }
@@ -2104,26 +2087,26 @@ static struct pnp_card_device_id snd_audiodrive_pnpids[] = {
 
 MODULE_DEVICE_TABLE(pnp_card, snd_audiodrive_pnpids);
 
-static int __devinit snd_audiodrive_pnpc(int dev, struct snd_audiodrive *acard,
+static int __devinit snd_audiodrive_pnpc(int dev, struct snd_es18xx *chip,
 					struct pnp_card_link *card,
 					const struct pnp_card_device_id *id)
 {
-	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->dev == NULL)
+	chip->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
+	if (chip->dev == NULL)
 		return -EBUSY;
 
-	acard->devc = pnp_request_card_device(card, id->devs[1].id, NULL);
-	if (acard->devc == NULL)
+	chip->devc = pnp_request_card_device(card, id->devs[1].id, NULL);
+	if (chip->devc == NULL)
 		return -EBUSY;
 
 	/* Control port initialization */
-	if (pnp_activate_dev(acard->devc) < 0) {
+	if (pnp_activate_dev(chip->devc) < 0) {
 		snd_printk(KERN_ERR PFX "PnP control configure failure (out of resources?)\n");
 		return -EAGAIN;
 	}
 	snd_printdd("pnp: port=0x%llx\n",
-			(unsigned long long)pnp_port_start(acard->devc, 0));
-	if (snd_audiodrive_pnp_init_main(dev, acard->dev) < 0)
+			(unsigned long long)pnp_port_start(chip->devc, 0));
+	if (snd_audiodrive_pnp_init_main(dev, chip->dev) < 0)
 		return -EBUSY;
 
 	return 0;
@@ -2139,24 +2122,20 @@ static int __devinit snd_audiodrive_pnpc(int dev, struct snd_audiodrive *acard,
 static int snd_es18xx_card_new(int dev, struct snd_card **cardp)
 {
 	return snd_card_create(index[dev], id[dev], THIS_MODULE,
-			       sizeof(struct snd_audiodrive), cardp);
+			       sizeof(struct snd_es18xx), cardp);
 }
 
 static int __devinit snd_audiodrive_probe(struct snd_card *card, int dev)
 {
-	struct snd_audiodrive *acard = card->private_data;
-	struct snd_es18xx *chip;
+	struct snd_es18xx *chip = card->private_data;
 	struct snd_opl3 *opl3;
 	int err;
 
-	if ((err = snd_es18xx_new_device(card,
-					 port[dev],
-					 mpu_port[dev],
-					 fm_port[dev],
-					 irq[dev], dma1[dev], dma2[dev],
-					 &chip)) < 0)
+	err = snd_es18xx_new_device(card,
+				    port[dev], mpu_port[dev], fm_port[dev],
+				    irq[dev], dma1[dev], dma2[dev]);
+	if (err < 0)
 		return err;
-	acard->chip = chip;
 
 	sprintf(card->driver, "ES%x", chip->version);
 	
-- 
1.6.0.3


 
----------------------------------------------------------------------
Nie dla nich ciepla praca za biurkiem.
Sprawdz >>> http://link.interia.pl/f2383
