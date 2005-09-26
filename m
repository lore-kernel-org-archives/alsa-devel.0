From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] Reduce interrupt latency in sound/pci/via82xx.c
Date: Mon, 26 Sep 2005 20:52:38 +0200
Message-ID: <200509262052.38990.annabellesgarden@yahoo.de>
References: <200509121418.05184.annabellesgarden@yahoo.de> <4325FA70.3090702@superbug.co.uk> <200509131318.25702.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2NEODCE9aQxLS4g"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200509131318.25702.annabellesgarden@yahoo.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_2NEODCE9aQxLS4g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Dienstag, 13. September 2005 13:18 schrieb Karsten Wiese:
> another strategy to solve the ((value & 0xffffff) == 0) situation,
> when not in interrupt would look like:
> 	int c_status = inb(VIADEV_REG(viadev, OFFSET_STATUS))
> 	if (c_status & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG))
> 		we have finished the period
> 	else
> 		we are still at the start of the period,
> 		interrupt routine has just run,
> 		use last interrupt position

Attached patch implements above idea and works fine here.

      Karsten

--Boundary-00=_2NEODCE9aQxLS4g
Content-Type: message/rfc822;
  name="patch-snd-via82xx-noloop"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-snd-via82xx-noloop"

From: Karsten Wiese <annabellesgarden@yahoo.de>


Reduce interrupt latency in sound/pci/via82xx.c


The change only affects the via823x kind of chips.
Here the  via8233_pcm_pointer_hw() function
(named snd_via8233_pcm_pointer() before)
needed to loop until a non zero position is red from the chip.

Measurements have shown that more than 200 loops are typically needed on
an Athlon64. 
As io-reads cost many cycles, those loops sum up huge.
via8233_pcm_pointer_hw() runs either in interrupt or with interrupts
disabled. So it introduces significant interrupt latency.

The patch introduces a calculated position value hwptr_done,
that is updated by the interrupt routine when a period is completed.
It is only used, if the 823x chip returns a zero position, which can't
be interpreted reliably.

Further optimisation is applied on the 8233 chip's interrupt routine:
Only the SGD_SHADOW is read, as it contains all infos needed.
We ommit ~5 more register reads that way.


Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>






--- linux-2.6.13/sound/pci/via82xx.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-RT-kw/sound/pci/via82xx.c	2005-09-26 20:30:38.000000000 +0200
@@ -41,6 +41,9 @@
  *	  device for applications.
  *	- clean up the code, separate low-level initialization
  *	  routines for each chipset.
+ *
+ * Sep. 26, 2005	Karsten Wiese <annabellesgarden@yahoo.de>
+ *	- Optimize position calculation for the 823x chips. 
  */
 
 #include <sound/driver.h>
@@ -336,6 +339,8 @@
 	unsigned int fragsize;
 	unsigned int bufsize;
 	unsigned int bufsize2;
+	int hwptr_done;		/* processed frame position in the buffer */
+	int in_interrupt;
 };
 
 
@@ -401,8 +406,8 @@
 };
 
 static struct pci_device_id snd_via82xx_ids[] = {
-	{ 0x1106, 0x3058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA686, },	/* 686A */
-	{ 0x1106, 0x3059, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA8233, },	/* VT8233 */
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA686, },	/* 686A */
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA8233, },	/* VT8233 */
 	{ 0, }
 };
 
@@ -556,7 +561,7 @@
 {
 	via82xx_t *chip = ac97->private_data;
 	unsigned int xval;
-	
+
 	xval = !ac97->num ? VIA_REG_AC97_CODEC_ID_PRIMARY : VIA_REG_AC97_CODEC_ID_SECONDARY;
 	xval <<= VIA_REG_AC97_CODEC_ID_SHIFT;
 	xval |= reg << VIA_REG_AC97_CMD_SHIFT;
@@ -604,14 +609,15 @@
 	outb(0x00, VIADEV_REG(viadev, OFFSET_TYPE)); /* for via686 */
 	// outl(0, VIADEV_REG(viadev, OFFSET_CURR_PTR));
 	viadev->lastpos = 0;
+	viadev->hwptr_done = 0;
 }
 
 
 /*
  *  Interrupt handler
+ *  Used for 686 and 8233A
  */
-
-static irqreturn_t snd_via82xx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t snd_via686_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	via82xx_t *chip = dev_id;
 	unsigned int status;
@@ -630,13 +636,23 @@
 	for (i = 0; i < chip->num_devs; i++) {
 		viadev_t *viadev = &chip->devs[i];
 		unsigned char c_status = inb(VIADEV_REG(viadev, OFFSET_STATUS));
-		c_status &= (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG|VIA_REG_STAT_STOPPED);
-		if (! c_status)
+		if (! (c_status & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG|VIA_REG_STAT_STOPPED)))
 			continue;
 		if (viadev->substream && viadev->running) {
+			/*
+			 * Update hwptr_done based on 'period elapsed'
+			 * interrupts. We'll use it, when the chip returns 0 
+			 * for OFFSET_CURR_COUNT.
+			 */
+			if (c_status & VIA_REG_STAT_EOL)
+				viadev->hwptr_done = 0;
+			else
+				viadev->hwptr_done += viadev->fragsize;
+			viadev->in_interrupt = c_status;
 			spin_unlock(&chip->reg_lock);
 			snd_pcm_period_elapsed(viadev->substream);
 			spin_lock(&chip->reg_lock);
+			viadev->in_interrupt = 0;
 		}
 		outb(c_status, VIADEV_REG(viadev, OFFSET_STATUS)); /* ack */
 	}
@@ -645,6 +661,61 @@
 }
 
 /*
+ *  Interrupt handler
+ */
+static irqreturn_t snd_via8233_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	via82xx_t *chip = dev_id;
+	unsigned int status;
+	unsigned int i;
+	unsigned int intr_mask;
+	irqreturn_t irqreturn = IRQ_NONE;
+
+
+	/* check status for each stream */
+	intr_mask = chip->intr_mask;
+	spin_lock(&chip->reg_lock);
+	status = inl(VIAREG(chip, SGD_SHADOW));
+	for (i = 0; i < chip->num_devs;
+	     i++, intr_mask >>= 4, status >>= 4) {
+		viadev_t *viadev = &chip->devs[i];
+		snd_pcm_substream_t *substream;
+		unsigned char c_status;
+		while (!(intr_mask & 3)) {
+			intr_mask >>= 4;
+			status >>= 4;
+		}
+		c_status = status & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG);
+		if (!c_status)
+			continue;
+		c_status |= ((status & 8) << 4);		// ACTIVE Flag
+		substream = viadev->substream;
+		if (substream && viadev->running) {
+			/*
+			 * Update hwptr_done based on 'period elapsed'
+			 * interrupts. We'll use it, when the chip returns 0 
+			 * for OFFSET_CURR_COUNT.
+			 */
+			if (c_status & VIA_REG_STAT_EOL)
+				viadev->hwptr_done = 0;
+			else
+				viadev->hwptr_done += viadev->fragsize;
+			viadev->in_interrupt = c_status;
+			spin_unlock(&chip->reg_lock);
+
+			snd_pcm_period_elapsed(substream);
+
+			spin_lock(&chip->reg_lock);
+			viadev->in_interrupt = 0;
+		}
+		outb(c_status, VIADEV_REG(viadev, OFFSET_STATUS)); /* ack */
+		irqreturn = IRQ_HANDLED;
+	}
+	spin_unlock(&chip->reg_lock);
+	return irqreturn;
+}
+
+/*
  *  PCM callbacks
  */
 
@@ -705,6 +776,8 @@
 	size = viadev->idx_table[idx].size;
 	base = viadev->idx_table[idx].offset;
 	res = base + size - count;
+	if (res >= viadev->bufsize)
+		res -= viadev->bufsize;
 
 	/* check the validity of the calculated position */
 	if (size < count) {
@@ -734,9 +807,6 @@
 			}
 		}
 	}
-	viadev->lastpos = res; /* remember the last position */
-	if (res >= viadev->bufsize)
-		res -= viadev->bufsize;
 	return res;
 }
 
@@ -764,6 +834,7 @@
 	else /* CURR_PTR holds the address + 8 */
 		idx = ((ptr - (unsigned int)viadev->table.addr) / 8 - 1) % viadev->tbl_entries;
 	res = calc_linear_pos(viadev, idx, count);
+	viadev->lastpos = res; /* remember the last position */
 	spin_unlock(&chip->reg_lock);
 
 	return bytes_to_frames(substream->runtime, res);
@@ -777,36 +848,49 @@
 	via82xx_t *chip = snd_pcm_substream_chip(substream);
 	viadev_t *viadev = (viadev_t *)substream->runtime->private_data;
 	unsigned int idx, count, res;
-	int timeout = 5000;
+	int status;
 	
 	snd_assert(viadev->tbl_entries, return 0);
-	if (!(inb(VIADEV_REG(viadev, OFFSET_STATUS)) & VIA_REG_STAT_ACTIVE))
-		return 0;
+
 	spin_lock(&chip->reg_lock);
-	do {
-		count = inl(VIADEV_REG(viadev, OFFSET_CURR_COUNT));
-		/* some mobos read 0 count */
-		if ((count & 0xffffff) || ! viadev->running)
-			break;
-	} while (--timeout);
-	if (! timeout)
-		snd_printd(KERN_ERR "zero position is read\n");
-	idx = count >> 24;
-	if (idx >= viadev->tbl_entries) {
+	count = inl(VIADEV_REG(viadev, OFFSET_CURR_COUNT));
+	status = viadev->in_interrupt;
+	if (!status)
+		status = inb(VIADEV_REG(viadev, OFFSET_STATUS));
+
+	if (!(status & VIA_REG_STAT_ACTIVE)) {
+		res = 0;
+		goto unlock;
+	}
+	if (count & 0xffffff) {
+		idx = count >> 24;
+		if (idx >= viadev->tbl_entries) {
 #ifdef POINTER_DEBUG
-		printk("fail: invalid idx = %i/%i\n", idx, viadev->tbl_entries);
+			printk("fail: invalid idx = %i/%i\n", idx, viadev->tbl_entries);
 #endif
-		res = viadev->lastpos;
+			res = viadev->lastpos;
+		} else {
+			count &= 0xffffff;
+			res = calc_linear_pos(viadev, idx, count);
+		}
 	} else {
-		count &= 0xffffff;
-		res = calc_linear_pos(viadev, idx, count);
-	}
+		res = viadev->hwptr_done;
+		if (!viadev->in_interrupt) {
+			if (status & VIA_REG_STAT_EOL) {
+				res = 0;
+			} else
+				if (status & VIA_REG_STAT_FLAG) {
+					res += viadev->fragsize;
+				}
+		}
+	}			    
+unlock:
+	viadev->lastpos = res;
 	spin_unlock(&chip->reg_lock);
 
 	return bytes_to_frames(substream->runtime, res);
 }
 
-
 /*
  * hw_params callback:
  * allocate the buffer and build up the buffer description table
@@ -2089,7 +2173,10 @@
 		return err;
 	}
 	chip->port = pci_resource_start(pci, 0);
-	if (request_irq(pci->irq, snd_via82xx_interrupt, SA_INTERRUPT|SA_SHIRQ,
+	if (request_irq(pci->irq,
+			chip_type == TYPE_VIA8233 ?
+			snd_via8233_interrupt :	snd_via686_interrupt,
+			SA_INTERRUPT|SA_SHIRQ,
 			card->driver, (void *)chip)) {
 		snd_printk("unable to grab IRQ %d\n", pci->irq);
 		snd_via82xx_free(chip);

--Boundary-00=_2NEODCE9aQxLS4g--

		
___________________________________________________________ 
Was denken Sie über E-Mail? Wir hören auf Ihre Meinung: http://surveylink.yahoo.com/wix/p0379378.aspx



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
