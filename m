From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] snd-maestro3: Make hardware volume buttons
	an input device (rev2)
Date: Fri, 23 Apr 2010 05:26:42 -0400
Message-ID: <1272014803-10706-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.versatel.nl (smtp4.versatel.nl [62.58.50.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E33D244BF
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 11:21:22 +0200 (CEST)
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
Cc: Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

While working on the sound suspend / resume problems with my laptop
I noticed that the hardware volume handling code in essence just detects
key presses, and then does some hardcoded modification of the master volume
based on which key is pressed.

This made me think that clearly the right thing to do here is just report
these keypresses to userspace and let userspace decide what to with them.

This patch adds a Kconfig option which when enabled reports the volume
buttons as keypresses using an input device. When enabled this option
also gets rid of the ugly direct ac97 writes from the tasklet, the ac97lock
and the need for using a tasklet in general.

As an added bonus the keys now work identical to volume keys on a (usb)
keyboard with multimedia keys, providing visual feedback of the volume
level change, and a better range of the volume control (with a properly
configured desktop environment).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/Kconfig    |   10 ++++
 sound/pci/maestro3.c |  116 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 351654c..2bca3d6 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -655,6 +655,16 @@ config SND_MAESTRO3
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-maestro3.
 
+config SND_MAESTRO3_INPUT
+	bool "Enable input device for maestro3 volume buttons"
+	depends on SND_MAESTRO3
+	depends on INPUT=y || INPUT=SND_MAESTRO3
+	help
+	  If you say Y here, you will get an input device which reports
+	  keypresses for the volume buttons connected to the maestro3 chip.
+	  If you say N the buttons will directly control the master volume.
+	  It is recommended to say Y.
+
 config SND_MIXART
 	tristate "Digigram miXart"
 	select SND_HWDEP
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 0ed634a..1070250 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -41,6 +41,7 @@
 #include <linux/vmalloc.h>
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
+#include <linux/input.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -844,11 +845,17 @@ struct snd_m3 {
 	struct m3_dma *substreams;
 
 	spinlock_t reg_lock;
-	spinlock_t ac97_lock;
 
+#ifdef CONFIG_SND_MAESTRO3_INPUT
+	struct input_dev *input_dev;
+	char phys[64];			/* physical device path */
+#else
+	spinlock_t ac97_lock;
 	struct snd_kcontrol *master_switch;
 	struct snd_kcontrol *master_volume;
 	struct tasklet_struct hwvol_tq;
+#endif
+
 	unsigned int in_suspend;
 
 #ifdef CONFIG_PM
@@ -1606,7 +1613,9 @@ static void snd_m3_update_hw_volume(unsigned long private_data)
 {
 	struct snd_m3 *chip = (struct snd_m3 *) private_data;
 	int x, val;
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	unsigned long flags;
+#endif
 
 	/* Figure out which volume control button was pushed,
 	   based on differences from the default register
@@ -1632,6 +1641,7 @@ static void snd_m3_update_hw_volume(unsigned long private_data)
 	if (chip->in_suspend)
 		return;
 
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	if (!chip->master_switch || !chip->master_volume)
 		return;
 
@@ -1677,6 +1687,35 @@ static void snd_m3_update_hw_volume(unsigned long private_data)
 		break;
 	}
 	spin_unlock_irqrestore(&chip->ac97_lock, flags);
+#else
+	if (!chip->input_dev)
+		return;
+
+	val = 0;
+	switch (x) {
+	case 0x88:
+		/* The counters have not changed, yet we've received a HV
+		   interrupt. According to tests run by various people this
+		   happens when pressing the mute button. */
+		val = KEY_MUTE;
+		break;
+	case 0xaa:
+		/* counters increased by 1 -> volume up */
+		val = KEY_VOLUMEUP;
+		break;
+	case 0x66:
+		/* counters decreased by 1 -> volume down */
+		val = KEY_VOLUMEDOWN;
+		break;
+	}
+
+	if (val) {
+		input_report_key(chip->input_dev, val, 1);
+		input_sync(chip->input_dev);
+		input_report_key(chip->input_dev, val, 0);
+		input_sync(chip->input_dev);
+	}
+#endif
 }
 
 static irqreturn_t snd_m3_interrupt(int irq, void *dev_id)
@@ -1691,7 +1730,11 @@ static irqreturn_t snd_m3_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (status & HV_INT_PENDING)
+#ifdef CONFIG_SND_MAESTRO3_INPUT
+		snd_m3_update_hw_volume((unsigned long)chip);
+#else
 		tasklet_schedule(&chip->hwvol_tq);
+#endif
 
 	/*
 	 * ack an assp int if its running
@@ -1957,18 +2000,24 @@ static unsigned short
 snd_m3_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
 	struct snd_m3 *chip = ac97->private_data;
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	unsigned long flags;
+#endif
 	unsigned short data = 0xffff;
 
 	if (snd_m3_ac97_wait(chip))
 		goto fail;
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	spin_lock_irqsave(&chip->ac97_lock, flags);
+#endif
 	snd_m3_outb(chip, 0x80 | (reg & 0x7f), CODEC_COMMAND);
 	if (snd_m3_ac97_wait(chip))
 		goto fail_unlock;
 	data = snd_m3_inw(chip, CODEC_DATA);
 fail_unlock:
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	spin_unlock_irqrestore(&chip->ac97_lock, flags);
+#endif
 fail:
 	return data;
 }
@@ -1977,14 +2026,20 @@ static void
 snd_m3_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
 {
 	struct snd_m3 *chip = ac97->private_data;
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	unsigned long flags;
+#endif
 
 	if (snd_m3_ac97_wait(chip))
 		return;
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	spin_lock_irqsave(&chip->ac97_lock, flags);
+#endif
 	snd_m3_outw(chip, val, CODEC_DATA);
 	snd_m3_outb(chip, reg & 0x7f, CODEC_COMMAND);
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	spin_unlock_irqrestore(&chip->ac97_lock, flags);
+#endif
 }
 
 
@@ -2091,7 +2146,9 @@ static int __devinit snd_m3_mixer(struct snd_m3 *chip)
 {
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	struct snd_ctl_elem_id elem_id;
+#endif
 	int err;
 	static struct snd_ac97_bus_ops ops = {
 		.write = snd_m3_ac97_write,
@@ -2111,6 +2168,7 @@ static int __devinit snd_m3_mixer(struct snd_m3 *chip)
 	schedule_timeout_uninterruptible(msecs_to_jiffies(100));
 	snd_ac97_write(chip->ac97, AC97_PCM, 0);
 
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	memset(&elem_id, 0, sizeof(elem_id));
 	elem_id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	strcpy(elem_id.name, "Master Playback Switch");
@@ -2119,6 +2177,7 @@ static int __devinit snd_m3_mixer(struct snd_m3 *chip)
 	elem_id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	strcpy(elem_id.name, "Master Playback Volume");
 	chip->master_volume = snd_ctl_find_id(chip->card, &elem_id);
+#endif
 
 	return 0;
 }
@@ -2398,6 +2457,11 @@ static int snd_m3_free(struct snd_m3 *chip)
 	struct m3_dma *s;
 	int i;
 
+#ifdef CONFIG_SND_MAESTRO3_INPUT
+	if (chip->input_dev)
+		input_unregister_device(chip->input_dev);
+#endif
+
 	if (chip->substreams) {
 		spin_lock_irq(&chip->reg_lock);
 		for (i = 0; i < chip->num_substreams; i++) {
@@ -2524,6 +2588,41 @@ static int m3_resume(struct pci_dev *pci)
 }
 #endif /* CONFIG_PM */
 
+#ifdef CONFIG_SND_MAESTRO3_INPUT
+static int __devinit snd_m3_input_register(struct snd_m3 *chip)
+{
+	struct input_dev *input_dev;
+	int err;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENOMEM;
+
+	snprintf(chip->phys, sizeof(chip->phys), "pci-%s/input0",
+		 pci_name(chip->pci));
+
+	input_dev->name = chip->card->driver;
+	input_dev->phys = chip->phys;
+	input_dev->id.bustype = BUS_PCI;
+	input_dev->id.vendor  = chip->pci->vendor;
+	input_dev->id.product = chip->pci->device;
+	input_dev->dev.parent = &chip->pci->dev;
+
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(KEY_MUTE, input_dev->keybit);
+	__set_bit(KEY_VOLUMEDOWN, input_dev->keybit);
+	__set_bit(KEY_VOLUMEUP, input_dev->keybit);
+
+	err = input_register_device(input_dev);
+	if (err) {
+		input_free_device(input_dev);
+		return err;
+	}
+
+	chip->input_dev = input_dev;
+	return 0;
+}
+#endif /* CONFIG_INPUT */
 
 /*
  */
@@ -2567,7 +2666,9 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 	}
 
 	spin_lock_init(&chip->reg_lock);
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	spin_lock_init(&chip->ac97_lock);
+#endif
 
 	switch (pci->device) {
 	case PCI_DEVICE_ID_ESS_ALLEGRO:
@@ -2650,7 +2751,9 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 
 	snd_m3_hv_init(chip);
 
+#ifndef CONFIG_SND_MAESTRO3_INPUT
 	tasklet_init(&chip->hwvol_tq, snd_m3_update_hw_volume, (unsigned long)chip);
+#endif
 
 	if (request_irq(pci->irq, snd_m3_interrupt, IRQF_SHARED,
 			card->driver, chip)) {
@@ -2682,7 +2785,16 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 
 	if ((err = snd_m3_pcm(chip, 0)) < 0)
 		return err;
-    
+
+#ifdef CONFIG_SND_MAESTRO3_INPUT
+	if (chip->hv_config & HV_CTRL_ENABLE) {
+		err = snd_m3_input_register(chip);
+		if (err)
+			snd_printk(KERN_WARNING "Input device registration "
+				"failed with error %i", err);
+	}
+#endif
+
 	snd_m3_enable_ints(chip);
 	snd_m3_assp_continue(chip);
 
-- 
1.7.0.1
