From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 2/3] maestro3: Add HW volume button support
Date: Thu, 21 Apr 2005 22:08:54 +0300 (EEST)
Message-ID: <20050421190854.5D0177A@kuori.saunalahti.fi>
Content-Type: text
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Add support for hardware volume buttons.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 maestro3.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 103 insertions(+), 4 deletions(-)

diff -urN linux/sound/pci/maestro3.c linux/sound/pci/maestro3.c
--- linux/sound/pci/maestro3.c	2005-04-21 21:43:47.000000000 +0300
+++ linux/sound/pci/maestro3.c	2005-04-21 21:43:56.000000000 +0300
@@ -851,7 +851,12 @@
 	m3_dma_t *substreams;
 
 	spinlock_t reg_lock;
+	spinlock_t ac97_lock;
 
+	snd_kcontrol_t *master_switch;
+	snd_kcontrol_t *master_volume;
+	struct tasklet_struct hwvol_tq;
+	
 #ifdef CONFIG_PM
 	u16 *suspend_mem;
 #endif
@@ -1565,6 +1570,68 @@
 	}
 }
 
+static void snd_m3_update_hw_volume(unsigned long private_data)
+{
+	m3_t *chip = (m3_t *) private_data;
+	int x, val;
+	unsigned long flags;
+
+	/* Figure out which volume control button was pushed,
+	   based on differences from the default register
+	   values. */
+	x = inb(chip->iobase + SHADOW_MIX_REG_VOICE) & 0xee;
+
+	/* Reset the volume control registers. */
+	outb(0x88, chip->iobase + SHADOW_MIX_REG_VOICE);
+	outb(0x88, chip->iobase + HW_VOL_COUNTER_VOICE);
+	outb(0x88, chip->iobase + SHADOW_MIX_REG_MASTER);
+	outb(0x88, chip->iobase + HW_VOL_COUNTER_MASTER);
+
+	if (!chip->master_switch || !chip->master_volume)
+		return;
+
+	/* FIXME: we can't call snd_ac97_* functions since here is in tasklet. */
+	spin_lock_irqsave(&chip->ac97_lock, flags);
+
+	val = chip->ac97->regs[AC97_MASTER_VOL];
+	switch (x) {
+	case 0x88:
+		/* mute */
+		val ^= 0x8000;
+		chip->ac97->regs[AC97_MASTER_VOL] = val;
+		outw(val, chip->iobase + CODEC_DATA);
+		outb(AC97_MASTER_VOL, chip->iobase + CODEC_COMMAND);
+		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &chip->master_switch->id);
+		break;
+	case 0xaa:
+		/* volume up */
+		if ((val & 0x7f) > 0)
+			val--;
+		if ((val & 0x7f00) > 0)
+			val -= 0x0100;
+		chip->ac97->regs[AC97_MASTER_VOL] = val;
+		outw(val, chip->iobase + CODEC_DATA);
+		outb(AC97_MASTER_VOL, chip->iobase + CODEC_COMMAND);
+		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &chip->master_volume->id);
+		break;
+	case 0x66:
+		/* volume down */
+		if ((val & 0x7f) < 0x1f)
+			val++;
+		if ((val & 0x7f00) < 0x1f00)
+			val += 0x0100;
+		chip->ac97->regs[AC97_MASTER_VOL] = val;
+		outw(val, chip->iobase + CODEC_DATA);
+		outb(AC97_MASTER_VOL, chip->iobase + CODEC_COMMAND);
+		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &chip->master_volume->id);
+		break;
+	}
+	spin_unlock_irqrestore(&chip->ac97_lock, flags);
+}
+
 static irqreturn_t
 snd_m3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -1576,7 +1643,10 @@
 
 	if (status == 0xff)
 		return IRQ_NONE;
-   
+
+	if (status & HV_INT_PENDING)
+		tasklet_hi_schedule(&chip->hwvol_tq);
+
 	/*
 	 * ack an assp int if its running
 	 * and has an int pending
@@ -1842,24 +1912,32 @@
 snd_m3_ac97_read(ac97_t *ac97, unsigned short reg)
 {
 	m3_t *chip = ac97->private_data;
+	unsigned long flags;
+	unsigned short data;
 
 	if (snd_m3_ac97_wait(chip))
 		return 0xffff;
+	spin_lock_irqsave(&chip->ac97_lock, flags);
 	snd_m3_outb(chip, 0x80 | (reg & 0x7f), CODEC_COMMAND);
 	if (snd_m3_ac97_wait(chip))
 		return 0xffff;
-	return snd_m3_inw(chip, CODEC_DATA);
+	data = snd_m3_inw(chip, CODEC_DATA);
+	spin_unlock_irqrestore(&chip->ac97_lock, flags);
+	return data;
 }
 
 static void
 snd_m3_ac97_write(ac97_t *ac97, unsigned short reg, unsigned short val)
 {
 	m3_t *chip = ac97->private_data;
+	unsigned long flags;
 
 	if (snd_m3_ac97_wait(chip))
 		return;
+	spin_lock_irqsave(&chip->ac97_lock, flags);
 	snd_m3_outw(chip, val, CODEC_DATA);
 	snd_m3_outb(chip, reg & 0x7f, CODEC_COMMAND);
+	spin_unlock_irqrestore(&chip->ac97_lock, flags);
 }
 
 
@@ -1968,6 +2046,7 @@
 {
 	ac97_bus_t *pbus;
 	ac97_template_t ac97;
+	snd_ctl_elem_id_t id;
 	int err;
 	static ac97_bus_ops_t ops = {
 		.write = snd_m3_ac97_write,
@@ -1988,6 +2067,15 @@
 	schedule_timeout(HZ / 10);
 	snd_ac97_write(chip->ac97, AC97_PCM, 0);
 
+	memset(&id, 0, sizeof(id));
+	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	strcpy(id.name, "Master Playback Switch");
+	chip->master_switch = snd_ctl_find_id(chip->card, &id);
+	memset(&id, 0, sizeof(id));
+	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	strcpy(id.name, "Master Playback Volume");
+	chip->master_volume = snd_ctl_find_id(chip->card, &id);
+
 	return 0;
 }
 
@@ -2293,6 +2381,7 @@
 snd_m3_chip_init(m3_t *chip)
 {
 	struct pci_dev *pcidev = chip->pci;
+	unsigned long io = chip->iobase;
 	u32 n;
 	u16 w;
 	u8 t; /* makes as much sense as 'n', no? */
@@ -2304,7 +2393,8 @@
 	pci_write_config_word(pcidev, PCI_LEGACY_AUDIO_CTRL, w);
 
 	pci_read_config_dword(pcidev, PCI_ALLEGRO_CONFIG, &n);
-	n &= REDUCED_DEBOUNCE;
+	n &= ~HV_BUTTON_FROM_GD;
+	n |= HV_CTRL_ENABLE | REDUCED_DEBOUNCE;
 	n |= PM_CTRL_ENABLE | CLK_DIV_BY_49 | USE_PCI_TIMING;
 	pci_write_config_dword(pcidev, PCI_ALLEGRO_CONFIG, n);
 
@@ -2332,6 +2422,12 @@
 
 	outb(RUN_ASSP, chip->iobase + ASSP_CONTROL_B); 
 
+	outb(0x00, io + HARDWARE_VOL_CTRL);
+	outb(0x88, io + SHADOW_MIX_REG_VOICE);
+	outb(0x88, io + HW_VOL_COUNTER_VOICE);
+	outb(0x88, io + SHADOW_MIX_REG_MASTER);
+	outb(0x88, io + HW_VOL_COUNTER_MASTER);
+
 	return 0;
 } 
 
@@ -2341,7 +2437,7 @@
 	unsigned long io = chip->iobase;
 
 	/* TODO: MPU401 not supported yet */
-	outw(ASSP_INT_ENABLE /*| MPU401_INT_ENABLE*/, io + HOST_INT_CTRL);
+	outw(ASSP_INT_ENABLE | HV_INT_ENABLE /*| MPU401_INT_ENABLE*/, io + HOST_INT_CTRL);
 	outb(inb(io + ASSP_CONTROL_C) | ASSP_HOST_INT_ENABLE,
 	     io + ASSP_CONTROL_C);
 }
@@ -2593,6 +2689,9 @@
 		return err;
 	}
 
+	spin_lock_init(&chip->ac97_lock);
+	tasklet_init(&chip->hwvol_tq, snd_m3_update_hw_volume, (unsigned long)chip);
+
 	if ((err = snd_m3_mixer(chip)) < 0)
 		return err;
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
