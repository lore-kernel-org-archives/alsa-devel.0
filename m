From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 22/24] sound/pci: coding style fixes: via82xx
Date: Tue, 9 Sep 2008 06:02:26 +0400
Message-ID: <20080909020226.GY6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
	by alsa0.perex.cz (Postfix) with ESMTP id E119E103844
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 04:02:31 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so727328eyc.56
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 19:02:31 -0700 (PDT)
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
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/via82xx.c       |   76 ++++++++++++++++++++++----------------------
 sound/pci/via82xx_modem.c |   60 ++++++++++++++++++------------------
 2 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 1aafe95..8a84cb2 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -43,10 +43,10 @@
  *	  routines for each chipset.
  *
  * Sep. 26, 2005	Karsten Wiese <annabellesgarden@yahoo.de>
- *	- Optimize position calculation for the 823x chips. 
+ *	- Optimize position calculation for the 823x chips.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -146,7 +146,7 @@ module_param(enable, bool, 0444);
 #define   VIA_REG_CTRL_TERMINATE	0x40	/* WO */
 #define   VIA_REG_CTRL_AUTOSTART	0x20
 #define   VIA_REG_CTRL_PAUSE		0x08	/* RW */
-#define   VIA_REG_CTRL_INT_STOP		0x04		
+#define   VIA_REG_CTRL_INT_STOP		0x04
 #define   VIA_REG_CTRL_INT_EOL		0x02
 #define   VIA_REG_CTRL_INT_FLAG		0x01
 #define   VIA_REG_CTRL_RESET		0x01	/* RW - probably reset? undocumented */
@@ -310,7 +310,7 @@ DEFINE_VIA_REGSET(CAPTURE_8233, 0x60);
 struct snd_via_sg_table {
 	unsigned int offset;
 	unsigned int size;
-} ;
+};
 
 #define VIA_TABLE_SIZE	255
 #define VIA_MAX_BUFSIZE	(1<<24)
@@ -431,9 +431,9 @@ static int build_via_table(struct viadev *dev, struct snd_pcm_substream *substre
 					&dev->table) < 0)
 			return -ENOMEM;
 	}
-	if (! dev->idx_table) {
+	if (!dev->idx_table) {
 		dev->idx_table = kmalloc(sizeof(*dev->idx_table) * VIA_TABLE_SIZE, GFP_KERNEL);
-		if (! dev->idx_table)
+		if (!dev->idx_table)
 			return -ENOMEM;
 	}
 
@@ -459,14 +459,14 @@ static int build_via_table(struct viadev *dev, struct snd_pcm_substream *substre
 			((u32 *)dev->table.area)[idx << 1] = cpu_to_le32(addr);
 			r = snd_pcm_sgbuf_get_chunk_size(substream, ofs, rest);
 			rest -= r;
-			if (! rest) {
+			if (!rest) {
 				if (i == periods - 1)
 					flag = VIA_TBL_BIT_EOL; /* buffer boundary */
 				else
 					flag = VIA_TBL_BIT_FLAG; /* period boundary */
 			} else
 				flag = 0; /* period continues to the next */
-			// printk("via: tbl %d: at %d  size %d (rest %d)\n", idx, ofs, r, rest);
+			/* printk("via: tbl %d: at %d  size %d (rest %d)\n", idx, ofs, r, rest); */
 			((u32 *)dev->table.area)[(idx<<1) + 1] = cpu_to_le32(r | flag);
 			dev->idx_table[idx].offset = ofs;
 			dev->idx_table[idx].size = r;
@@ -502,17 +502,17 @@ static inline unsigned int snd_via82xx_codec_xread(struct via82xx *chip)
 {
 	return inl(VIAREG(chip, AC97));
 }
- 
+
 static inline void snd_via82xx_codec_xwrite(struct via82xx *chip, unsigned int val)
 {
 	outl(val, VIAREG(chip, AC97));
 }
- 
+
 static int snd_via82xx_codec_ready(struct via82xx *chip, int secondary)
 {
 	unsigned int timeout = 1000;	/* 1ms */
 	unsigned int val;
-	
+
 	while (timeout-- > 0) {
 		udelay(1);
 		if (!((val = snd_via82xx_codec_xread(chip)) & VIA_REG_AC97_BUSY))
@@ -522,14 +522,14 @@ static int snd_via82xx_codec_ready(struct via82xx *chip, int secondary)
 		   secondary, snd_via82xx_codec_xread(chip));
 	return -EIO;
 }
- 
+
 static int snd_via82xx_codec_valid(struct via82xx *chip, int secondary)
 {
 	unsigned int timeout = 1000;	/* 1ms */
 	unsigned int val, val1;
 	unsigned int stat = !secondary ? VIA_REG_AC97_PRIMARY_VALID :
 					 VIA_REG_AC97_SECONDARY_VALID;
-	
+
 	while (timeout-- > 0) {
 		val = snd_via82xx_codec_xread(chip);
 		val1 = val & (VIA_REG_AC97_BUSY | stat);
@@ -539,7 +539,7 @@ static int snd_via82xx_codec_valid(struct via82xx *chip, int secondary)
 	}
 	return -EIO;
 }
- 
+
 static void snd_via82xx_codec_wait(struct snd_ac97 *ac97)
 {
 	struct via82xx *chip = ac97->private_data;
@@ -602,7 +602,7 @@ static void snd_via82xx_channel_reset(struct via82xx *chip, struct viadev *viade
 	/* clear interrupts */
 	outb(0x03, VIADEV_REG(viadev, OFFSET_STATUS));
 	outb(0x00, VIADEV_REG(viadev, OFFSET_TYPE)); /* for via686 */
-	// outl(0, VIADEV_REG(viadev, OFFSET_CURR_PTR));
+	/* outl(0, VIADEV_REG(viadev, OFFSET_CURR_PTR)); */
 	viadev->lastpos = 0;
 	viadev->hwptr_done = 0;
 }
@@ -619,7 +619,7 @@ static irqreturn_t snd_via686_interrupt(int irq, void *dev_id)
 	unsigned int i;
 
 	status = inl(VIAREG(chip, SGD_SHADOW));
-	if (! (status & chip->intr_mask)) {
+	if (!(status & chip->intr_mask)) {
 		if (chip->rmidi)
 			/* check mpu401 interrupt */
 			return snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data);
@@ -631,12 +631,12 @@ static irqreturn_t snd_via686_interrupt(int irq, void *dev_id)
 	for (i = 0; i < chip->num_devs; i++) {
 		struct viadev *viadev = &chip->devs[i];
 		unsigned char c_status = inb(VIADEV_REG(viadev, OFFSET_STATUS));
-		if (! (c_status & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG|VIA_REG_STAT_STOPPED)))
+		if (!(c_status & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG|VIA_REG_STAT_STOPPED)))
 			continue;
 		if (viadev->substream && viadev->running) {
 			/*
 			 * Update hwptr_done based on 'period elapsed'
-			 * interrupts. We'll use it, when the chip returns 0 
+			 * interrupts. We'll use it, when the chip returns 0
 			 * for OFFSET_CURR_COUNT.
 			 */
 			if (c_status & VIA_REG_STAT_EOL)
@@ -685,7 +685,7 @@ static irqreturn_t snd_via8233_interrupt(int irq, void *dev_id)
 		if (substream && viadev->running) {
 			/*
 			 * Update hwptr_done based on 'period elapsed'
-			 * interrupts. We'll use it, when the chip returns 0 
+			 * interrupts. We'll use it, when the chip returns 0
 			 * for OFFSET_CURR_COUNT.
 			 */
 			if (c_status & VIA_REG_STAT_EOL)
@@ -783,7 +783,7 @@ static inline unsigned int calc_linear_pos(struct viadev *viadev, unsigned int i
 			   (int)size, (int)count);
 		res = viadev->lastpos;
 	} else {
-		if (! count) {
+		if (!count) {
 			/* Some mobos report count = 0 on the DMA boundary,
 			 * i.e. count = size indeed.
 			 * Let's check whether this step is above the expected size.
@@ -855,7 +855,7 @@ static snd_pcm_uframes_t snd_via8233_pcm_pointer(struct snd_pcm_substream *subst
 	struct viadev *viadev = substream->runtime->private_data;
 	unsigned int idx, count, res;
 	int status;
-	
+
 	if (snd_BUG_ON(!viadev->tbl_entries))
 		return 0;
 
@@ -865,7 +865,7 @@ static snd_pcm_uframes_t snd_via8233_pcm_pointer(struct snd_pcm_substream *subst
 	if (!status)
 		status = inb(VIADEV_REG(viadev, OFFSET_STATUS));
 
-	/* An apparent bug in the 8251 is worked around by sending a 
+	/* An apparent bug in the 8251 is worked around by sending a
 	 * REG_CTRL_START. */
 	if (chip->revision == VIA_REV_8251 && (status & VIA_REG_STAT_EOL))
 		snd_via82xx_pcm_trigger(substream, SNDRV_PCM_TRIGGER_START);
@@ -896,7 +896,7 @@ static snd_pcm_uframes_t snd_via8233_pcm_pointer(struct snd_pcm_substream *subst
 					res += viadev->fragsize;
 				}
 		}
-	}			    
+	}
 unlock:
 	viadev->lastpos = res;
 	spin_unlock(&chip->reg_lock);
@@ -1166,7 +1166,7 @@ static int snd_via82xx_pcm_open(struct via82xx *chip, struct viadev *viadev,
 	struct via_rate_lock *ratep;
 
 	runtime->hw = snd_via82xx_hw;
-	
+
 	/* set the hw rate condition */
 	ratep = &chip->rates[viadev->direction];
 	spin_lock_irq(&ratep->lock);
@@ -1185,7 +1185,7 @@ static int snd_via82xx_pcm_open(struct via82xx *chip, struct viadev *viadev,
 				     SNDRV_PCM_RATE_8000_48000);
 		runtime->hw.rate_min = 8000;
 		runtime->hw.rate_max = 48000;
-	} else if (! ratep->rate) {
+	} else if (!ratep->rate) {
 		int idx = viadev->direction ? AC97_RATES_ADC : AC97_RATES_FRONT_DAC;
 		runtime->hw.rates = chip->ac97->rates[idx];
 		snd_pcm_limit_hw_rates(runtime);
@@ -1276,11 +1276,11 @@ static int snd_via82xx_pcm_close(struct snd_pcm_substream *substream)
 	ratep = &chip->rates[viadev->direction];
 	spin_lock_irq(&ratep->lock);
 	ratep->used--;
-	if (! ratep->used)
+	if (!ratep->used)
 		ratep->rate = 0;
 	spin_unlock_irq(&ratep->lock);
-	if (! ratep->rate) {
-		if (! viadev->direction) {
+	if (!ratep->rate) {
+		if (!viadev->direction) {
 			snd_ac97_update_power(chip->ac97,
 					      AC97_PCM_FRONT_DAC_RATE, 0);
 			snd_ac97_update_power(chip->ac97,
@@ -1457,7 +1457,7 @@ static int __devinit snd_via8233a_pcm_new(struct via82xx *chip)
 					      64*1024, VIA_MAX_BUFSIZE);
 
 	/* SPDIF supported? */
-	if (! ac97_can_spdif(chip->ac97))
+	if (!ac97_can_spdif(chip->ac97))
 		return 0;
 
 	/* PCM #1:  DXS3 playback (for spdif) */
@@ -1921,7 +1921,7 @@ static int __devinit snd_via8233_init_misc(struct via82xx *chip)
 		memset(&sid, 0, sizeof(sid));
 		strcpy(sid.name, "PCM Playback Volume");
 		sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-		if (! snd_ctl_find_id(chip->card, &sid)) {
+		if (!snd_ctl_find_id(chip->card, &sid)) {
 			snd_printd(KERN_INFO "Using DXS as PCM Playback\n");
 			err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_via8233_pcmdxs_volume_control, chip));
 			if (err < 0)
@@ -2026,7 +2026,7 @@ static void snd_via82xx_proc_read(struct snd_info_entry *entry,
 {
 	struct via82xx *chip = entry->private_data;
 	int i;
-	
+
 	snd_iprintf(buffer, "%s\n\n", chip->card->longname);
 	for (i = 0; i < 0xa0; i += 4) {
 		snd_iprintf(buffer, "%02x: %08x\n", i, inl(chip->port + i));
@@ -2037,7 +2037,7 @@ static void __devinit snd_via82xx_proc_init(struct via82xx *chip)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(chip->card, "via82xx", &entry))
+	if (!snd_card_proc_new(chip->card, "via82xx", &entry))
 		snd_info_set_text_ops(entry, chip, snd_via82xx_proc_read);
 }
 
@@ -2057,7 +2057,7 @@ static int snd_via82xx_chip_init(struct via82xx *chip)
 		pci_write_config_byte(chip->pci, VIA_FUNC_ENABLE, 0);
 #endif
 	pci_read_config_byte(chip->pci, VIA_ACLINK_STAT, &pval);
-	if (! (pval & VIA_ACLINK_C00_READY)) { /* codec not ready? */
+	if (!(pval & VIA_ACLINK_C00_READY)) { /* codec not ready? */
 		/* deassert ACLink reset, force SYNC */
 		pci_write_config_byte(chip->pci, VIA_ACLINK_CTRL,
 				      VIA_ACLINK_CTRL_ENABLE |
@@ -2078,7 +2078,7 @@ static int snd_via82xx_chip_init(struct via82xx *chip)
 		pci_write_config_byte(chip->pci, VIA_ACLINK_CTRL, VIA_ACLINK_CTRL_INIT);
 		udelay(100);
 	}
-	
+
 	/* Make sure VRA is enabled, in case we didn't do a
 	 * complete codec reset, above */
 	pci_read_config_byte(chip->pci, VIA_ACLINK_CTRL, &pval);
@@ -2239,7 +2239,7 @@ static int snd_via82xx_free(struct via82xx *chip)
 
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
- __end_hw:
+__end_hw:
 	release_and_free_resource(chip->mpu_res);
 	pci_release_regions(chip->pci);
 
@@ -2477,7 +2477,7 @@ static int __devinit snd_via82xx_probe(struct pci_dev *pci,
 		err = -EINVAL;
 		goto __error;
 	}
-		
+
 	if ((err = snd_via82xx_create(card, pci, chip_type, pci->revision,
 				      ac97_clock, &chip)) < 0)
 		goto __error;
@@ -2493,7 +2493,7 @@ static int __devinit snd_via82xx_probe(struct pci_dev *pci,
 		if (chip_type == TYPE_VIA8233A) {
 			if ((err = snd_via8233a_pcm_new(chip)) < 0)
 				goto __error;
-			// chip->dxs_fixed = 1; /* FIXME: use 48k for DXS #3? */
+			/* chip->dxs_fixed = 1;  FIXME: use 48k for DXS #3? */
 		} else {
 			if ((err = snd_via8233_pcm_new(chip)) < 0)
 				goto __error;
@@ -2527,7 +2527,7 @@ static int __devinit snd_via82xx_probe(struct pci_dev *pci,
 	pci_set_drvdata(pci, card);
 	return 0;
 
- __error:
+__error:
 	snd_card_free(card);
 	return err;
 }
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 5bd79d2..833f56e 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -31,7 +31,7 @@
  *      modems.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -90,7 +90,7 @@ module_param(enable, bool, 0444);
 #define   VIA_REG_CTRL_TERMINATE	0x40	/* WO */
 #define   VIA_REG_CTRL_AUTOSTART	0x20
 #define   VIA_REG_CTRL_PAUSE		0x08	/* RW */
-#define   VIA_REG_CTRL_INT_STOP		0x04		
+#define   VIA_REG_CTRL_INT_STOP		0x04
 #define   VIA_REG_CTRL_INT_EOL		0x02
 #define   VIA_REG_CTRL_INT_FLAG		0x01
 #define   VIA_REG_CTRL_RESET		0x01	/* RW - probably reset? undocumented */
@@ -212,7 +212,7 @@ DEFINE_VIA_REGSET(MI, 0x50);
 struct snd_via_sg_table {
 	unsigned int offset;
 	unsigned int size;
-} ;
+};
 
 #define VIA_TABLE_SIZE	255
 
@@ -291,9 +291,9 @@ static int build_via_table(struct viadev *dev, struct snd_pcm_substream *substre
 					&dev->table) < 0)
 			return -ENOMEM;
 	}
-	if (! dev->idx_table) {
+	if (!dev->idx_table) {
 		dev->idx_table = kmalloc(sizeof(*dev->idx_table) * VIA_TABLE_SIZE, GFP_KERNEL);
-		if (! dev->idx_table)
+		if (!dev->idx_table)
 			return -ENOMEM;
 	}
 
@@ -321,14 +321,14 @@ static int build_via_table(struct viadev *dev, struct snd_pcm_substream *substre
 			if (rest < r)
 				r = rest;
 			rest -= r;
-			if (! rest) {
+			if (!rest) {
 				if (i == periods - 1)
 					flag = VIA_TBL_BIT_EOL; /* buffer boundary */
 				else
 					flag = VIA_TBL_BIT_FLAG; /* period boundary */
 			} else
 				flag = 0; /* period continues to the next */
-			// printk("via: tbl %d: at %d  size %d (rest %d)\n", idx, ofs, r, rest);
+			/* printk("via: tbl %d: at %d  size %d (rest %d)\n", idx, ofs, r, rest); */
 			((u32 *)dev->table.area)[(idx<<1) + 1] = cpu_to_le32(r | flag);
 			dev->idx_table[idx].offset = ofs;
 			dev->idx_table[idx].size = r;
@@ -363,17 +363,17 @@ static inline unsigned int snd_via82xx_codec_xread(struct via82xx_modem *chip)
 {
 	return inl(VIAREG(chip, AC97));
 }
- 
+
 static inline void snd_via82xx_codec_xwrite(struct via82xx_modem *chip, unsigned int val)
 {
 	outl(val, VIAREG(chip, AC97));
 }
- 
+
 static int snd_via82xx_codec_ready(struct via82xx_modem *chip, int secondary)
 {
 	unsigned int timeout = 1000;	/* 1ms */
 	unsigned int val;
-	
+
 	while (timeout-- > 0) {
 		udelay(1);
 		if (!((val = snd_via82xx_codec_xread(chip)) & VIA_REG_AC97_BUSY))
@@ -383,14 +383,14 @@ static int snd_via82xx_codec_ready(struct via82xx_modem *chip, int secondary)
 		   secondary, snd_via82xx_codec_xread(chip));
 	return -EIO;
 }
- 
+
 static int snd_via82xx_codec_valid(struct via82xx_modem *chip, int secondary)
 {
 	unsigned int timeout = 1000;	/* 1ms */
 	unsigned int val, val1;
 	unsigned int stat = !secondary ? VIA_REG_AC97_PRIMARY_VALID :
 					 VIA_REG_AC97_SECONDARY_VALID;
-	
+
 	while (timeout-- > 0) {
 		val = snd_via82xx_codec_xread(chip);
 		val1 = val & (VIA_REG_AC97_BUSY | stat);
@@ -400,7 +400,7 @@ static int snd_via82xx_codec_valid(struct via82xx_modem *chip, int secondary)
 	}
 	return -EIO;
 }
- 
+
 static void snd_via82xx_codec_wait(struct snd_ac97 *ac97)
 {
 	struct via82xx_modem *chip = ac97->private_data;
@@ -416,10 +416,10 @@ static void snd_via82xx_codec_write(struct snd_ac97 *ac97,
 {
 	struct via82xx_modem *chip = ac97->private_data;
 	unsigned int xval;
-	if(reg == AC97_GPIO_STATUS) {
+	if (reg == AC97_GPIO_STATUS) {
 		outl(val, VIAREG(chip, GPI_STATUS));
 		return;
-	}	
+	}
 	xval = !ac97->num ? VIA_REG_AC97_CODEC_ID_PRIMARY : VIA_REG_AC97_CODEC_ID_SECONDARY;
 	xval <<= VIA_REG_AC97_CODEC_ID_SHIFT;
 	xval |= reg << VIA_REG_AC97_CMD_SHIFT;
@@ -466,7 +466,7 @@ static void snd_via82xx_channel_reset(struct via82xx_modem *chip, struct viadev
 	/* clear interrupts */
 	outb(0x03, VIADEV_REG(viadev, OFFSET_STATUS));
 	outb(0x00, VIADEV_REG(viadev, OFFSET_TYPE)); /* for via686 */
-	// outl(0, VIADEV_REG(viadev, OFFSET_CURR_PTR));
+	/* outl(0, VIADEV_REG(viadev, OFFSET_CURR_PTR)); */
 	viadev->lastpos = 0;
 }
 
@@ -482,7 +482,7 @@ static irqreturn_t snd_via82xx_interrupt(int irq, void *dev_id)
 	unsigned int i;
 
 	status = inl(VIAREG(chip, SGD_SHADOW));
-	if (! (status & chip->intr_mask)) {
+	if (!(status & chip->intr_mask)) {
 		return IRQ_NONE;
 	}
 // _skip_sgd:
@@ -493,7 +493,7 @@ static irqreturn_t snd_via82xx_interrupt(int irq, void *dev_id)
 		struct viadev *viadev = &chip->devs[i];
 		unsigned char c_status = inb(VIADEV_REG(viadev, OFFSET_STATUS));
 		c_status &= (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG|VIA_REG_STAT_STOPPED);
-		if (! c_status)
+		if (!c_status)
 			continue;
 		if (viadev->substream && viadev->running) {
 			spin_unlock(&chip->reg_lock);
@@ -583,7 +583,7 @@ static inline unsigned int calc_linear_pos(struct viadev *viadev, unsigned int i
 				   "using last valid pointer\n");
 			res = viadev->lastpos;
 		} else {
-			if (! count)
+			if (!count)
 				/* bogus count 0 on the DMA boundary? */
 				res = viadev->idx_table[idx].offset;
 			else
@@ -744,7 +744,7 @@ static int snd_via82xx_modem_pcm_open(struct via82xx_modem *chip, struct viadev
         };
 
 	runtime->hw = snd_via82xx_hw;
-	
+
         if ((err = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 					      &hw_constraints_rates)) < 0)
                 return err;
@@ -918,7 +918,7 @@ static void snd_via82xx_proc_read(struct snd_info_entry *entry, struct snd_info_
 {
 	struct via82xx_modem *chip = entry->private_data;
 	int i;
-	
+
 	snd_iprintf(buffer, "%s\n\n", chip->card->longname);
 	for (i = 0; i < 0xa0; i += 4) {
 		snd_iprintf(buffer, "%02x: %08x\n", i, inl(chip->port + i));
@@ -929,7 +929,7 @@ static void __devinit snd_via82xx_proc_init(struct via82xx_modem *chip)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(chip->card, "via82xx", &entry))
+	if (!snd_card_proc_new(chip->card, "via82xx", &entry))
 		snd_info_set_text_ops(entry, chip, snd_via82xx_proc_read);
 }
 
@@ -944,13 +944,13 @@ static int snd_via82xx_chip_init(struct via82xx_modem *chip)
 	unsigned char pval;
 
 	pci_read_config_byte(chip->pci, VIA_MC97_CTRL, &pval);
-	if((pval & VIA_MC97_CTRL_INIT) != VIA_MC97_CTRL_INIT) {
+	if ((pval & VIA_MC97_CTRL_INIT) != VIA_MC97_CTRL_INIT) {
 		pci_write_config_byte(chip->pci, 0x44, pval|VIA_MC97_CTRL_INIT);
 		udelay(100);
 	}
 
 	pci_read_config_byte(chip->pci, VIA_ACLINK_STAT, &pval);
-	if (! (pval & VIA_ACLINK_C00_READY)) { /* codec not ready? */
+	if (!(pval & VIA_ACLINK_C00_READY)) { /* codec not ready? */
 		/* deassert ACLink reset, force SYNC */
 		pci_write_config_byte(chip->pci, VIA_ACLINK_CTRL,
 				      VIA_ACLINK_CTRL_ENABLE |
@@ -970,7 +970,7 @@ static int snd_via82xx_chip_init(struct via82xx_modem *chip)
 		pci_write_config_byte(chip->pci, VIA_ACLINK_CTRL, VIA_ACLINK_CTRL_INIT);
 		udelay(100);
 	}
-	
+
 	pci_read_config_byte(chip->pci, VIA_ACLINK_CTRL, &pval);
 	if ((pval & VIA_ACLINK_CTRL_INIT) != VIA_ACLINK_CTRL_INIT) {
 		/* ACLink on, deassert ACLink reset, VSR, SGD data out */
@@ -1009,7 +1009,7 @@ static int snd_via82xx_chip_init(struct via82xx_modem *chip)
       __ac97_ok2:
 
 	/* route FM trap to IRQ, disable FM trap */
-	// pci_write_config_byte(chip->pci, VIA_FM_NMI_CTRL, 0);
+	/* pci_write_config_byte(chip->pci, VIA_FM_NMI_CTRL, 0); */
 	/* disable all GPI interrupts */
 	outl(0, VIAREG(chip, GPI_INTR));
 
@@ -1078,7 +1078,7 @@ static int snd_via82xx_free(struct via82xx_modem *chip)
 	for (i = 0; i < chip->num_devs; i++)
 		snd_via82xx_channel_reset(chip, &chip->devs[i]);
 
-      __end_hw:
+__end_hw:
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
 	pci_release_regions(chip->pci);
@@ -1182,7 +1182,7 @@ static int __devinit snd_via82xx_probe(struct pci_dev *pci,
 		err = -EINVAL;
 		goto __error;
 	}
-		
+
 	if ((err = snd_via82xx_create(card, pci, chip_type, pci->revision,
 				      ac97_clock, &chip)) < 0)
 		goto __error;
@@ -1190,7 +1190,7 @@ static int __devinit snd_via82xx_probe(struct pci_dev *pci,
 	if ((err = snd_via82xx_mixer_new(chip)) < 0)
 		goto __error;
 
-	if ((err = snd_via686_pcm_new(chip)) < 0 )
+	if ((err = snd_via686_pcm_new(chip)) < 0)
 		goto __error;
 
 	/* disable interrupts */
@@ -1209,7 +1209,7 @@ static int __devinit snd_via82xx_probe(struct pci_dev *pci,
 	pci_set_drvdata(pci, card);
 	return 0;
 
- __error:
+__error:
 	snd_card_free(card);
 	return err;
 }
