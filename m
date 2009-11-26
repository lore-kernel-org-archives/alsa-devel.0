From: Ondrej Zary <linux@rainbow-software.org>
Subject: snd-fm801: autodetect SF64-PCR (tuner-only) card
Date: Thu, 26 Nov 2009 21:59:43 +0100
Message-ID: <200911262159.44083.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail1-out1.atlantis.sk [80.94.52.55])
	by alsa0.perex.cz (Postfix) with ESMTP id A7FBB103861
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 21:59:53 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When primary AC97 is not found, don't fail with tons of AC97 errors.
Assume that the card is SF64-PCR (tuner-only).
This makes the SF64-PCR radio card work "out of the box".

Also fixes a bug that can cause an oops here:
	if (tea575x_tuner > 0 && (tea575x_tuner & 0x000f) < 4) {
when tea575x_tuner == 16, it passes this check and causes problems
a couple lines below:
	chip->tea.ops = &snd_fm801_tea_ops[(tea575x_tuner & 0x000f) - 1];


Tested with SF64-PCR, but I don't have any of those sound or sound+radio cards
to test if I didn't break anything.


Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-source-2.6.31-orig/sound/pci/fm801.c	2009-09-10 00:13:59.000000000 +0200
+++ linux-source-2.6.31/sound/pci/fm801.c	2009-11-26 21:19:59.000000000 +0100
@@ -55,7 +55,6 @@ static int enable[SNDRV_CARDS] = SNDRV_D
  *    1 = MediaForte 256-PCS
  *    2 = MediaForte 256-PCPR
  *    3 = MediaForte 64-PCR
- *   16 = setup tuner only (this is additional bit), i.e. SF-64-PCR FM card
  *  High 16-bits are video (radio) device number + 1
  */
 static int tea575x_tuner[SNDRV_CARDS];
@@ -67,7 +66,7 @@ MODULE_PARM_DESC(id, "ID string for the 
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable FM801 soundcard.");
 module_param_array(tea575x_tuner, int, NULL, 0444);
-MODULE_PARM_DESC(tea575x_tuner, "Enable TEA575x tuner.");
+MODULE_PARM_DESC(tea575x_tuner, "TEA575x tuner type (1 = SF256-PCS, 2=SF256-PCPR, 3=SF64-PCR).");
 
 /*
  *  Direct registers
@@ -160,7 +159,8 @@ struct fm801 {
 	unsigned int multichannel: 1,	/* multichannel support */
 		     secondary: 1;	/* secondary codec */
 	unsigned char secondary_addr;	/* address of the secondary codec */
-	unsigned int tea575x_tuner;	/* tuner flags */
+	unsigned int tea575x_tuner;	/* tuner type */
+	bool tuner_only;
 
 	unsigned short ply_ctrl; /* playback control */
 	unsigned short cap_ctrl; /* capture control */
@@ -1287,20 +1287,20 @@ static int snd_fm801_chip_init(struct fm
 {
 	unsigned short cmdw;
 
-	if (chip->tea575x_tuner & 0x0010)
-		goto __ac97_ok;
-
 	/* codec cold reset + AC'97 warm reset */
 	outw((1<<5) | (1<<6), FM801_REG(chip, CODEC_CTRL));
 	inw(FM801_REG(chip, CODEC_CTRL)); /* flush posting data */
 	udelay(100);
 	outw(0, FM801_REG(chip, CODEC_CTRL));
 
-	if (wait_for_codec(chip, 0, AC97_RESET, msecs_to_jiffies(750)) < 0) {
-		snd_printk(KERN_ERR "Primary AC'97 codec not found\n");
-		if (! resume)
-			return -EIO;
-	}
+	if (wait_for_codec(chip, 0, AC97_RESET, msecs_to_jiffies(750)) < 0)
+		if (!resume) {
+			snd_printk(KERN_ERR "Primary AC'97 codec not found, "
+					    "assume SF64-PCR (tuner-only)\n");
+			chip->tuner_only = 1;
+			chip->tea575x_tuner = 3;
+			goto __ac97_ok;
+		}
 
 	if (chip->multichannel) {
 		if (chip->secondary_addr) {
@@ -1414,21 +1414,27 @@ static int __devinit snd_fm801_create(st
 		return err;
 	}
 	chip->port = pci_resource_start(pci, 0);
-	if ((tea575x_tuner & 0x0010) == 0) {
-		if (request_irq(pci->irq, snd_fm801_interrupt, IRQF_SHARED,
-				"FM801", chip)) {
-			snd_printk(KERN_ERR "unable to grab IRQ %d\n", chip->irq);
-			snd_fm801_free(chip);
-			return -EBUSY;
-		}
-		chip->irq = pci->irq;
-		pci_set_master(pci);
+	if (request_irq(pci->irq, snd_fm801_interrupt, IRQF_SHARED,
+			"FM801", chip)) {
+		snd_printk(KERN_ERR "unable to grab IRQ %d\n", chip->irq);
+		snd_fm801_free(chip);
+		return -EBUSY;
 	}
+	chip->irq = pci->irq;
+	pci_set_master(pci);
 
 	if (pci->revision >= 0xb1)	/* FM801-AU */
 		chip->multichannel = 1;
 
 	snd_fm801_chip_init(chip, 0);
+	/* init might set tuner type */
+	tea575x_tuner = chip->tea575x_tuner;
+
+	if (chip->tuner_only) {
+		pci_clear_master(pci);
+		free_irq(chip->irq, chip);
+		chip->irq = -1;
+	}
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		snd_fm801_free(chip);
@@ -1438,7 +1444,7 @@ static int __devinit snd_fm801_create(st
 	snd_card_set_dev(card, &pci->dev);
 
 #ifdef TEA575X_RADIO
-	if (tea575x_tuner > 0 && (tea575x_tuner & 0x000f) < 4) {
+	if ((tea575x_tuner & 0x000f) > 0 && (tea575x_tuner & 0x000f) < 4) {
 		chip->tea.dev_nr = tea575x_tuner >> 16;
 		chip->tea.card = card;
 		chip->tea.freq_fixup = 10700;
@@ -1483,7 +1489,7 @@ static int __devinit snd_card_fm801_prob
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, chip->port, chip->irq);
 
-	if (tea575x_tuner[dev] & 0x0010)
+	if (chip->tuner_only)
 		goto __fm801_tuner_only;
 
 	if ((err = snd_fm801_pcm(chip, 0, NULL)) < 0) {

-- 
Ondrej Zary
