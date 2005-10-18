From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] Reduce interrupt latency in sound/pci/via82xx.c
Date: Tue, 18 Oct 2005 14:42:10 +0200
Message-ID: <200510181442.11185.annabellesgarden@yahoo.de>
References: <200509121418.05184.annabellesgarden@yahoo.de> <200509262052.38990.annabellesgarden@yahoo.de> <s5h7jd0f904.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_j2OVDAIST0Sm2r9"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jd0f904.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_j2OVDAIST0Sm2r9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Donnerstag, 29. September 2005 12:44 schrieb Takashi Iwai:
> >  
> >  static struct pci_device_id snd_via82xx_ids[] = {
> > -	{ 0x1106, 0x3058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA686, },	/* 686A */
> > -	{ 0x1106, 0x3059, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA8233, },	/* VT8233 */
> > +	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA686, },	/* 686A */
> > +	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA8233, },	/* VT8233 */
> >  	{ 0, }
> >  };
> 
> I like to keep the numbers here to check the support PCI IDs easier
> from the driver code.  I don't think changing this to PCI_* would
> improve the readability.
> The only drawback to use the numbers is possible typos, though.

hmm, symbolic names make it easier to grep/cscope the tree
for occurrences of the IDs.
So in this patch the structures are initialized symbolically
plus the hex-IDs are there as comment.

> > +	/* check status for each stream */
> > +	intr_mask = chip->intr_mask;
> > +	spin_lock(&chip->reg_lock);
> > +	status = inl(VIAREG(chip, SGD_SHADOW));
> > +	for (i = 0; i < chip->num_devs;
> > +	     i++, intr_mask >>= 4, status >>= 4) {
> > +		viadev_t *viadev = &chip->devs[i];
> > +		snd_pcm_substream_t *substream;
> > +		unsigned char c_status;
> > +		while (!(intr_mask & 3)) {
> > +			intr_mask >>= 4;
> > +			status >>= 4;
> > +		}
> 
> It'd be better to have a new field in viadev struct to indicate the
> shift bits rather than this loop.  The loop looks ad-hoc.

Done.
> 
> Also, could you use tabs instead of spaces, as mentioned in
> CodingStyle?

KMail fooled me once again. Better now?

Interrupt return macro for 2.4 compatibility is also there.

      Karsten

--Boundary-00=_j2OVDAIST0Sm2r9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="via82xx_fast_pointer.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via82xx_fast_pointer.4.patch"

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






--- linux-2.6.14-rc4/sound/pci/via82xx.c	2005-10-18 14:20:24.000000000 +0200
+++ linux-2.6.14-rc4-rt7-kw/sound/pci/via82xx.c	2005-10-18 14:20:24.000000000 +0200
@@ -41,6 +41,9 @@
  *	  device for applications.
  *	- clean up the code, separate low-level initialization
  *	  routines for each chipset.
+ *
+ * Sep. 26, 2005	Karsten Wiese <annabellesgarden@yahoo.de>
+ *	- Optimize position calculation for the 823x chips. 
  */
 
 #include <sound/driver.h>
@@ -130,6 +133,7 @@
 /* common offsets */
 #define VIA_REG_OFFSET_STATUS		0x00	/* byte - channel status */
 #define   VIA_REG_STAT_ACTIVE		0x80	/* RO */
+#define   VIA8233_SHADOW_STAT_ACTIVE	0x08	/* RO */
 #define   VIA_REG_STAT_PAUSED		0x40	/* RO */
 #define   VIA_REG_STAT_TRIGGER_QUEUED	0x08	/* RO */
 #define   VIA_REG_STAT_STOPPED		0x04	/* RWC */
@@ -328,6 +332,9 @@
 	unsigned int fragsize;
 	unsigned int bufsize;
 	unsigned int bufsize2;
+	int hwptr_done;		/* processed frame position in the buffer */
+	int in_interrupt;
+	int shadow_shift;
 };
 
 
@@ -393,8 +400,10 @@
 };
 
 static struct pci_device_id snd_via82xx_ids[] = {
-	{ 0x1106, 0x3058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA686, },	/* 686A */
-	{ 0x1106, 0x3059, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA8233, },	/* VT8233 */
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA686, },	/* 686A */
+	/*	0x1106			0x3058										*/
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_CARD_VIA8233, },	/* VT8233 */
+	/*	0x1106			0x3059										*/
 	{ 0, }
 };
 
@@ -548,7 +557,7 @@
 {
 	via82xx_t *chip = ac97->private_data;
 	unsigned int xval;
-	
+
 	xval = !ac97->num ? VIA_REG_AC97_CODEC_ID_PRIMARY : VIA_REG_AC97_CODEC_ID_SECONDARY;
 	xval <<= VIA_REG_AC97_CODEC_ID_SHIFT;
 	xval |= reg << VIA_REG_AC97_CMD_SHIFT;
@@ -596,14 +605,15 @@
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
@@ -622,18 +632,81 @@
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
 	spin_unlock(&chip->reg_lock);
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(IRQ_HANDLED);
+}
+
+/*
+ *  Interrupt handler
+ */
+static irqreturn_t snd_via8233_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	via82xx_t *chip = dev_id;
+	unsigned int status;
+	unsigned int i;
+	irqreturn_t irqreturn = IRQ_NONE;
+
+
+	/* check status for each stream */
+	spin_lock(&chip->reg_lock);
+	status = inl(VIAREG(chip, SGD_SHADOW));
+
+	for (i = 0; i < chip->num_devs; i++) {
+		viadev_t *viadev = &chip->devs[i];
+		snd_pcm_substream_t *substream;
+		unsigned char c_status, shadow_status;
+
+		shadow_status = (status >> viadev->shadow_shift) & (VIA8233_SHADOW_STAT_ACTIVE|VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG);
+		c_status = shadow_status & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG);
+		if (!c_status)
+			continue;
+
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
+			if (shadow_status & VIA8233_SHADOW_STAT_ACTIVE)
+				viadev->in_interrupt |= VIA_REG_STAT_ACTIVE;
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
+	return IRQ_RETVAL(irqreturn);
 }
 
 /*
@@ -699,6 +772,8 @@
 	size = viadev->idx_table[idx].size;
 	base = viadev->idx_table[idx].offset;
 	res = base + size - count;
+	if (res >= viadev->bufsize)
+		res -= viadev->bufsize;
 
 	/* check the validity of the calculated position */
 	if (size < count) {
@@ -728,9 +803,6 @@
 			}
 		}
 	}
-	viadev->lastpos = res; /* remember the last position */
-	if (res >= viadev->bufsize)
-		res -= viadev->bufsize;
 	return res;
 }
 
@@ -758,6 +830,7 @@
 	else /* CURR_PTR holds the address + 8 */
 		idx = ((ptr - (unsigned int)viadev->table.addr) / 8 - 1) % viadev->tbl_entries;
 	res = calc_linear_pos(viadev, idx, count);
+	viadev->lastpos = res; /* remember the last position */
 	spin_unlock(&chip->reg_lock);
 
 	return bytes_to_frames(substream->runtime, res);
@@ -771,30 +844,44 @@
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
@@ -1239,9 +1326,10 @@
 };
 
 
-static void init_viadev(via82xx_t *chip, int idx, unsigned int reg_offset, int direction)
+static void init_viadev(via82xx_t *chip, int idx, unsigned int reg_offset, int shadow_pos, int direction)
 {
 	chip->devs[idx].reg_offset = reg_offset;
+	chip->devs[idx].shadow_shift = shadow_pos * 4;
 	chip->devs[idx].direction = direction;
 	chip->devs[idx].port = chip->port + reg_offset;
 }
@@ -1271,9 +1359,9 @@
 	chip->pcms[0] = pcm;
 	/* set up playbacks */
 	for (i = 0; i < 4; i++)
-		init_viadev(chip, i, 0x10 * i, 0);
+		init_viadev(chip, i, 0x10 * i, i, 0);
 	/* capture */
-	init_viadev(chip, chip->capture_devno, VIA_REG_CAPTURE_8233_STATUS, 1);
+	init_viadev(chip, chip->capture_devno, VIA_REG_CAPTURE_8233_STATUS, 6, 1);
 
 	if ((err = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
 							 snd_dma_pci_data(chip->pci), 64*1024, 128*1024)) < 0)
@@ -1289,9 +1377,9 @@
 	strcpy(pcm->name, chip->card->shortname);
 	chip->pcms[1] = pcm;
 	/* set up playback */
-	init_viadev(chip, chip->multi_devno, VIA_REG_MULTPLAY_STATUS, 0);
+	init_viadev(chip, chip->multi_devno, VIA_REG_MULTPLAY_STATUS, 4, 0);
 	/* set up capture */
-	init_viadev(chip, chip->capture_devno + 1, VIA_REG_CAPTURE_8233_STATUS + 0x10, 1);
+	init_viadev(chip, chip->capture_devno + 1, VIA_REG_CAPTURE_8233_STATUS + 0x10, 7, 1);
 
 	if ((err = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
 						         snd_dma_pci_data(chip->pci), 64*1024, 128*1024)) < 0)
@@ -1324,9 +1412,9 @@
 	strcpy(pcm->name, chip->card->shortname);
 	chip->pcms[0] = pcm;
 	/* set up playback */
-	init_viadev(chip, chip->multi_devno, VIA_REG_MULTPLAY_STATUS, 0);
+	init_viadev(chip, chip->multi_devno, VIA_REG_MULTPLAY_STATUS, 4, 0);
 	/* capture */
-	init_viadev(chip, chip->capture_devno, VIA_REG_CAPTURE_8233_STATUS, 1);
+	init_viadev(chip, chip->capture_devno, VIA_REG_CAPTURE_8233_STATUS, 6, 1);
 
 	if ((err = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
 							 snd_dma_pci_data(chip->pci), 64*1024, 128*1024)) < 0)
@@ -1345,7 +1433,7 @@
 	strcpy(pcm->name, chip->card->shortname);
 	chip->pcms[1] = pcm;
 	/* set up playback */
-	init_viadev(chip, chip->playback_devno, 0x30, 0);
+	init_viadev(chip, chip->playback_devno, 0x30, 3, 0);
 
 	if ((err = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
 							 snd_dma_pci_data(chip->pci), 64*1024, 128*1024)) < 0)
@@ -1375,8 +1463,8 @@
 	pcm->private_data = chip;
 	strcpy(pcm->name, chip->card->shortname);
 	chip->pcms[0] = pcm;
-	init_viadev(chip, 0, VIA_REG_PLAYBACK_STATUS, 0);
-	init_viadev(chip, 1, VIA_REG_CAPTURE_STATUS, 1);
+	init_viadev(chip, 0, VIA_REG_PLAYBACK_STATUS, 0, 0);
+	init_viadev(chip, 1, VIA_REG_CAPTURE_STATUS, 0, 1);
 
 	if ((err = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
 							 snd_dma_pci_data(chip->pci), 64*1024, 128*1024)) < 0)
@@ -2084,7 +2172,10 @@
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

--Boundary-00=_j2OVDAIST0Sm2r9--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
