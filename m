From: Rene Herman <rene.herman@gmail.com>
Subject: Re: isa_bus: es1688
Date: Sun, 18 Feb 2007 20:26:13 +0100
Message-ID: <45D8A855.4090505@gmail.com>
References: <45D2B99B.7000706@gmail.com>	<45D2BAB8.50102@gmail.com>	<s5h8xf0dij1.wl%tiwai@suse.de>	<45D3F422.4060200@gmail.com>
	<s5hvei3abiw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090701050401040300010009"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hvei3abiw.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090701050401040300010009
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 02/15/2007 12:46 PM, Takashi Iwai wrote:

>> Thank you. Question -- would you allow me to seperate the legacy probing 
>> code into its own function as per the attached?
> 
> That looks fine.  The resultant code will be the same by compiler's
> optimization.  But, please fold lines in 80 chars for the newly added
> code :)

Okay. After folding the new code, es1688 only had two lines >80 left, so 
did those as well.

===
es1688: separate out the legacy probing code into its own function.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
===

Rene.

--------------090701050401040300010009
Content-Type: text/plain;
 name="es1688_legacy_probe.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es1688_legacy_probe.diff"

diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index f7d0c5f..786438c 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -77,13 +77,48 @@ static int __devinit snd_es1688_match(st
 	return enable[n];
 }
 
-static int __devinit snd_es1688_probe(struct device *dev, unsigned int n)
+static int __devinit snd_es1688_legacy_create(struct snd_card *card, 
+		struct device *dev, unsigned int n, struct snd_es1688 **rchip)
 {
-	static unsigned long possible_ports[] = {0x220, 0x240, 0x260};
+	static long possible_ports[] = {0x220, 0x240, 0x260};
 	static int possible_irqs[] = {5, 9, 10, 7, -1};
 	static int possible_dmas[] = {1, 3, 0, -1};
-	int i, xirq, xdma;
 
+	int i, error;
+
+	if (irq[n] == SNDRV_AUTO_IRQ) {
+		irq[n] = snd_legacy_find_free_irq(possible_irqs);
+		if (irq[n] < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free IRQ\n",
+				dev->bus_id);
+			return -EBUSY;
+		}
+	}
+	if (dma8[n] == SNDRV_AUTO_DMA) {
+		dma8[n] = snd_legacy_find_free_dma(possible_dmas);
+		if (dma8[n] < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free DMA\n",
+				dev->bus_id);
+			return -EBUSY;
+		}
+	}
+
+	if (port[n] != SNDRV_AUTO_PORT)
+		return snd_es1688_create(card, port[n], mpu_port[n], irq[n],
+				mpu_irq[n], dma8[n], ES1688_HW_AUTO, rchip);
+
+	i = 0;
+	do {
+		port[n] = possible_ports[i];
+		error = snd_es1688_create(card, port[n], mpu_port[n], irq[n],
+				mpu_irq[n], dma8[n], ES1688_HW_AUTO, rchip);
+	} while (error < 0 && ++i < ARRAY_SIZE(possible_ports)); 
+
+	return error;
+}
+
+static int __devinit snd_es1688_probe(struct device *dev, unsigned int n)
+{
 	struct snd_card *card;
 	struct snd_es1688 *chip;
 	struct snd_opl3 *opl3;
@@ -94,33 +129,7 @@ static int __devinit snd_es1688_probe(st
 	if (!card)
 		return -EINVAL;
 
-	error = -EBUSY;
-
-	xirq = irq[n];
-	if (xirq == SNDRV_AUTO_IRQ) {
-		xirq = snd_legacy_find_free_irq(possible_irqs);
-		if (xirq < 0) {
-			snd_printk(KERN_ERR "%s: unable to find a free IRQ\n", dev->bus_id);
-			goto out;
-		}
-	}
-
-	xdma = dma8[n];
-	if (xdma == SNDRV_AUTO_DMA) {
-		xdma = snd_legacy_find_free_dma(possible_dmas);
-		if (xdma < 0) {
-			snd_printk(KERN_ERR "%s: unable to find a free DMA\n", dev->bus_id);
-			goto out;
-		}
-	}
-
-	if (port[n] == SNDRV_AUTO_PORT)
-		for (i = 0; i < ARRAY_SIZE(possible_ports) && error < 0; i++)
-			error = snd_es1688_create(card, possible_ports[i], mpu_port[n],
-					xirq, mpu_irq[n], xdma, ES1688_HW_AUTO, &chip);
-	else
-		error = snd_es1688_create(card, port[n], mpu_port[n],
-				xirq, mpu_irq[n], xdma, ES1688_HW_AUTO, &chip);
+	error = snd_es1688_legacy_create(card, dev, n, &chip);
 	if (error < 0)
 		goto out;
 
@@ -134,19 +143,24 @@ static int __devinit snd_es1688_probe(st
 
 	strcpy(card->driver, "ES1688");
 	strcpy(card->shortname, pcm->name);
-	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i", pcm->name, chip->port, xirq, xdma);
+	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i", pcm->name,
+		chip->port, chip->irq, chip->dma8);
 
-	if (snd_opl3_create(card, chip->port, chip->port + 2, OPL3_HW_OPL3, 0, &opl3) < 0)
-		printk(KERN_WARNING "%s: opl3 not detected at 0x%lx\n", dev->bus_id, chip->port);
+	if (snd_opl3_create(card, chip->port, chip->port + 2,
+			OPL3_HW_OPL3, 0, &opl3) < 0)
+		printk(KERN_WARNING "%s: opl3 not detected at 0x%lx\n",
+			dev->bus_id, chip->port);
 	else {
 		error =	snd_opl3_hwdep_new(opl3, 0, 1, NULL);
 		if (error < 0)
 			goto out;
 	}
 
-	if (mpu_irq[n] >= 0 && mpu_irq[n] != SNDRV_AUTO_IRQ && chip->mpu_port > 0) {
-		error = snd_mpu401_uart_new(card, 0, MPU401_HW_ES1688, chip->mpu_port,
-				0, mpu_irq[n], IRQF_DISABLED, NULL);
+	if (mpu_irq[n] >= 0 && mpu_irq[n] != SNDRV_AUTO_IRQ &&
+			chip->mpu_port > 0) {
+		error = snd_mpu401_uart_new(card, 0, MPU401_HW_ES1688,
+				chip->mpu_port, 0,
+				mpu_irq[n], IRQF_DISABLED, NULL);
 		if (error < 0)
 			goto out;
 	}

--------------090701050401040300010009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------090701050401040300010009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------090701050401040300010009--
