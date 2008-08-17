From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opl3sa2: drop snd_card pointer from the
 snd_opl3sa2 structure
Date: Sun, 17 Aug 2008 20:01:14 +0200
Message-ID: <20080817200114.691a99d4.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 4E84D24362
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Aug 2008 19:55:19 +0200 (CEST)
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

Remove card pointer from the snd_opl3sa2
structure and break circular reference
snd_card->snd_opl3sa2->snd_card.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
A very small opl3sa2 clean up.

diff -urp linux-ref/sound/isa/opl3sa2.c linux-2.6/sound/isa/opl3sa2.c
--- linux-ref/sound/isa/opl3sa2.c	2008-08-14 00:05:30.000000000 +0200
+++ linux-2.6/sound/isa/opl3sa2.c	2008-08-15 12:30:58.000000000 +0200
@@ -124,7 +124,6 @@ static int pnpc_registered;
 #define OPL3SA2_PM_D3	(OPL3SA2_PM_ADOWN|OPL3SA2_PM_PSV|OPL3SA2_PM_PDN|OPL3SA2_PM_PDX)
 
 struct snd_opl3sa2 {
-	struct snd_card *card;
 	int version;		/* 2 or 3 */
 	unsigned long port;	/* control port */
 	struct resource *res_port; /* control port resource */
@@ -222,14 +221,13 @@ static void snd_opl3sa2_write(struct snd
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
-static int __devinit snd_opl3sa2_detect(struct snd_opl3sa2 *chip)
+static int __devinit snd_opl3sa2_detect(struct snd_card *card)
 {
-	struct snd_card *card;
+	struct snd_opl3sa2 *chip = card->private_data;
 	unsigned long port;
 	unsigned char tmp, tmp1;
 	char str[2];
 
-	card = chip->card;
 	port = chip->port;
 	if ((chip->res_port = request_region(port, 2, "OPL3-SA control")) == NULL) {
 		snd_printk(KERN_ERR PFX "can't grab port 0x%lx\n", port);
@@ -298,12 +296,14 @@ static int __devinit snd_opl3sa2_detect(
 static irqreturn_t snd_opl3sa2_interrupt(int irq, void *dev_id)
 {
 	unsigned short status;
-	struct snd_opl3sa2 *chip = dev_id;
+	struct snd_card *card = dev_id;
+	struct snd_opl3sa2 *chip;
 	int handled = 0;
 
-	if (chip == NULL || chip->card == NULL)
+	if (card == NULL || card->private_data == NULL)
 		return IRQ_NONE;
 
+	chip = card->private_data;
 	status = snd_opl3sa2_read(chip, OPL3SA2_IRQ_STATUS);
 
 	if (status & 0x20) {
@@ -327,8 +327,10 @@ static irqreturn_t snd_opl3sa2_interrupt
 		snd_opl3sa2_read(chip, OPL3SA2_MASTER_RIGHT);
 		snd_opl3sa2_read(chip, OPL3SA2_MASTER_LEFT);
 		if (chip->master_switch && chip->master_volume) {
-			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE, &chip->master_switch->id);
-			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE, &chip->master_volume->id);
+			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+					&chip->master_switch->id);
+			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+					&chip->master_volume->id);
 		}
 	}
 	return IRQ_RETVAL(handled);
@@ -512,9 +514,9 @@ static void snd_opl3sa2_master_free(stru
 	chip->master_volume = NULL;
 }
 
-static int __devinit snd_opl3sa2_mixer(struct snd_opl3sa2 *chip)
+static int __devinit snd_opl3sa2_mixer(struct snd_card *card)
 {
-	struct snd_card *card = chip->card;
+	struct snd_opl3sa2 *chip = card->private_data;
 	struct snd_ctl_elem_id id1, id2;
 	struct snd_kcontrol *kctl;
 	unsigned int idx;
@@ -650,7 +652,6 @@ static struct snd_card *snd_opl3sa2_card
 	chip = card->private_data;
 	spin_lock_init(&chip->reg_lock);
 	chip->irq = -1;
-	chip->card = card;
 	card->private_free = snd_opl3sa2_free;
 	return card;
 }
@@ -672,9 +673,12 @@ static int __devinit snd_opl3sa2_probe(s
 	xdma2 = dma2[dev];
 	if (xdma2 < 0)
 		chip->single_dma = 1;
-	if ((err = snd_opl3sa2_detect(chip)) < 0)
+	err = snd_opl3sa2_detect(card);
+	if (err < 0)
 		return err;
-	if (request_irq(xirq, snd_opl3sa2_interrupt, IRQF_DISABLED, "OPL3-SA2", chip)) {
+	err = request_irq(xirq, snd_opl3sa2_interrupt, IRQF_DISABLED,
+			  "OPL3-SA2", card);
+	if (err) {
 		snd_printk(KERN_ERR PFX "can't grab IRQ %d\n", xirq);
 		return -ENODEV;
 	}
@@ -694,7 +698,8 @@ static int __devinit snd_opl3sa2_probe(s
 	err = snd_wss_mixer(wss);
 	if (err < 0)
 		return err;
-	if ((err = snd_opl3sa2_mixer(chip)) < 0)
+	err = snd_opl3sa2_mixer(card);
+	if (err < 0)
 		return err;
 	err = snd_wss_timer(wss, 0, NULL);
 	if (err < 0)

---------------------------------------------------------------------- 	
Prosty kredyt na wszystkie potrzeby. 
Od 1000 zl do 120 000 zl. 
Bez poreczycieli i zabezpieczen >>> http://link.interia.pl/f1edf
