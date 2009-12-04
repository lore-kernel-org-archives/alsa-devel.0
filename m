From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opti93x: set MC indirect registers base from
	PnP data
Date: Fri, 4 Dec 2009 18:30:18 +0100
Message-ID: <20091204183018.a13a110c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id BAF37103811
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 18:28:10 +0100 (CET)
Received: from poczta.interia.pl (mi02.poczta.interia.pl [10.217.12.2])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id DBC2142FFCE
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 18:28:09 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 213712BC101
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 18:28:08 +0100 (CET)
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

The PnP data on the OPTI931 and OPTI933 contains io port
range for the MC indirect registers. Use the PnP range
instead of hardwired value 0xE0E.

Also, request region of MC indirect registers so it is
marked as used to other drivers (this was missing previously).
---
This is the second version of the patch. The request_region() is called
in a single place now.

 sound/isa/opti9xx/opti92x-ad1848.c |  112 +++++++++++++++++++++--------------
 1 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index d08c389..8c88401 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -135,6 +135,8 @@ struct snd_opti9xx {
 	unsigned long mc_base_size;
 #ifdef OPTi93X
 	unsigned long mc_indir_index;
+	unsigned long mc_indir_size;
+	struct resource *res_mc_indir;
 	struct snd_wss *codec;
 #endif	/* OPTi93X */
 	unsigned long pwd_reg;
@@ -231,7 +233,10 @@ static int __devinit snd_opti9xx_init(struct snd_opti9xx *chip,
 	case OPTi9XX_HW_82C931:
 	case OPTi9XX_HW_82C933:
 		chip->mc_base = (hardware == OPTi9XX_HW_82C930) ? 0xf8f : 0xf8d;
-		chip->mc_indir_index = 0xe0e;
+		if (!chip->mc_indir_index) {
+			chip->mc_indir_index = 0xe0e;
+			chip->mc_indir_size = 2;
+		}
 		chip->password = 0xe4;
 		chip->pwd_reg = 0;
 		break;
@@ -560,57 +565,69 @@ static irqreturn_t snd_opti93x_interrupt(int irq, void *dev_id)
 
 #endif /* OPTi93X */
 
-static int __devinit snd_card_opti9xx_detect(struct snd_card *card,
-					     struct snd_opti9xx *chip)
+static int __devinit snd_opti9xx_read_check(struct snd_opti9xx *chip)
 {
-	int i, err;
+	unsigned char value;
+#ifdef OPTi93X
+	unsigned long flags;
+#endif
 
+	chip->res_mc_base = request_region(chip->mc_base, chip->mc_base_size,
+					   "OPTi9xx MC");
+	if (chip->res_mc_base == NULL)
+		return -EBUSY;
 #ifndef OPTi93X
-	for (i = OPTi9XX_HW_82C928; i < OPTi9XX_HW_82C930; i++) {
-		unsigned char value;
+	value = snd_opti9xx_read(chip, OPTi9XX_MC_REG(1));
+	if (value != 0xff && value != inb(chip->mc_base + OPTi9XX_MC_REG(1)))
+		if (value == snd_opti9xx_read(chip, OPTi9XX_MC_REG(1)))
+			return 0;
+#else	/* OPTi93X */
+	chip->res_mc_indir = request_region(chip->mc_indir_index,
+					    chip->mc_indir_size,
+					    "OPTi93x MC");
+	if (chip->res_mc_indir == NULL)
+		return -EBUSY;
 
-		if ((err = snd_opti9xx_init(chip, i)) < 0)
-			return err;
+	spin_lock_irqsave(&chip->lock, flags);
+	outb(chip->password, chip->mc_base + chip->pwd_reg);
+	outb(((chip->mc_indir_index & 0x1f0) >> 4), chip->mc_base);
+	spin_unlock_irqrestore(&chip->lock, flags);
 
-		if ((chip->res_mc_base = request_region(chip->mc_base, chip->mc_base_size, "OPTi9xx MC")) == NULL)
-			continue;
+	value = snd_opti9xx_read(chip, OPTi9XX_MC_REG(7));
+	snd_opti9xx_write(chip, OPTi9XX_MC_REG(7), 0xff - value);
+	if (snd_opti9xx_read(chip, OPTi9XX_MC_REG(7)) == 0xff - value)
+		return 0;
 
-		value = snd_opti9xx_read(chip, OPTi9XX_MC_REG(1));
-		if ((value != 0xff) && (value != inb(chip->mc_base + 1)))
-			if (value == snd_opti9xx_read(chip, OPTi9XX_MC_REG(1)))
-				return 1;
+	release_and_free_resource(chip->res_mc_indir);
+	chip->res_mc_indir = NULL;
+#endif	/* OPTi93X */
+	release_and_free_resource(chip->res_mc_base);
+	chip->res_mc_base = NULL;
 
-		release_and_free_resource(chip->res_mc_base);
-		chip->res_mc_base = NULL;
+	return -ENODEV;
+}
 
-	}
-#else	/* OPTi93X */
-	for (i = OPTi9XX_HW_82C931; i >= OPTi9XX_HW_82C930; i--) {
-		unsigned long flags;
-		unsigned char value;
+static int __devinit snd_card_opti9xx_detect(struct snd_card *card,
+					     struct snd_opti9xx *chip)
+{
+	int i, err;
 
-		if ((err = snd_opti9xx_init(chip, i)) < 0)
+#ifndef OPTi93X
+	for (i = OPTi9XX_HW_82C928; i < OPTi9XX_HW_82C930; i++) {
+#else
+	for (i = OPTi9XX_HW_82C931; i >= OPTi9XX_HW_82C930; i--) {
+#endif
+		err = snd_opti9xx_init(chip, i);
+		if (err < 0)
 			return err;
 
-		if ((chip->res_mc_base = request_region(chip->mc_base, chip->mc_base_size, "OPTi9xx MC")) == NULL)
-			continue;
-
-		spin_lock_irqsave(&chip->lock, flags);
-		outb(chip->password, chip->mc_base + chip->pwd_reg);
-		outb(((chip->mc_indir_index & (1 << 8)) >> 4) |
-			((chip->mc_indir_index & 0xf0) >> 4), chip->mc_base);
-		spin_unlock_irqrestore(&chip->lock, flags);
-
-		value = snd_opti9xx_read(chip, OPTi9XX_MC_REG(7));
-		snd_opti9xx_write(chip, OPTi9XX_MC_REG(7), 0xff - value);
-		if (snd_opti9xx_read(chip, OPTi9XX_MC_REG(7)) == 0xff - value)
+		err = snd_opti9xx_read_check(chip);
+		if (err == 0)
 			return 1;
-
-		release_and_free_resource(chip->res_mc_base);
-		chip->res_mc_base = NULL;
+#ifdef OPTi93X
+		chip->mc_indir_index = 0;
+#endif
 	}
-#endif	/* OPTi93X */
-
 	return -ENODEV;
 }
 
@@ -639,6 +656,8 @@ static int __devinit snd_card_opti9xx_pnp(struct snd_opti9xx *chip,
 #ifdef OPTi93X
 	port = pnp_port_start(pdev, 0) - 4;
 	fm_port = pnp_port_start(pdev, 1) + 8;
+	chip->mc_indir_index = pnp_port_start(pdev, 3) + 2;
+	chip->mc_indir_size = pnp_port_len(pdev, 3) - 2;
 #else
 	if (pid->driver_data != 0x0924)
 		port = pnp_port_start(pdev, 1);
@@ -669,7 +688,7 @@ static int __devinit snd_card_opti9xx_pnp(struct snd_opti9xx *chip,
 static void snd_card_opti9xx_free(struct snd_card *card)
 {
 	struct snd_opti9xx *chip = card->private_data;
-        
+
 	if (chip) {
 #ifdef OPTi93X
 		struct snd_wss *codec = chip->codec;
@@ -677,6 +696,7 @@ static void snd_card_opti9xx_free(struct snd_card *card)
 			disable_irq(codec->irq);
 			free_irq(codec->irq, codec);
 		}
+		release_and_free_resource(chip->res_mc_indir);
 #endif
 		release_and_free_resource(chip->res_mc_base);
 	}
@@ -696,11 +716,6 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 	struct snd_rawmidi *rmidi;
 	struct snd_hwdep *synth;
 
-	if (! chip->res_mc_base &&
-	    (chip->res_mc_base = request_region(chip->mc_base, chip->mc_base_size,
-						"OPTi9xx MC")) == NULL)
-		return -ENOMEM;
-
 #if defined(CS4231) || defined(OPTi93X)
 	xdma2 = dma2;
 #else
@@ -954,6 +969,13 @@ static int __devinit snd_opti9xx_pnp_probe(struct pnp_card_link *pcard,
 	}
 	if (hw <= OPTi9XX_HW_82C930)
 		chip->mc_base -= 0x80;
+
+	error = snd_opti9xx_read_check(chip);
+	if (error) {
+		snd_printk(KERN_ERR "OPTI chip not found\n");
+		snd_card_free(card);
+		return error;
+	}
 	snd_card_set_dev(card, &pcard->card->dev);
 	if ((error = snd_opti9xx_probe(card)) < 0) {
 		snd_card_free(card);
-- 
1.6.4


----------------------------------------------------------------------
Zbieraj punkty - wygrywaj nagrody!
Kliknij >>> http://link.interia.pl/f24a8
