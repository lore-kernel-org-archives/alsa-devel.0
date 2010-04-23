From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] snd-es1968: Make hardware volume buttons
	an input device (rev2)
Date: Fri, 23 Apr 2010 05:26:43 -0400
Message-ID: <1272014803-10706-2-git-send-email-hdegoede@redhat.com>
References: <1272014803-10706-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.versatel.nl (smtp4.versatel.nl [62.58.50.91])
	by alsa0.perex.cz (Postfix) with ESMTP id BBD12244C0
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 11:21:22 +0200 (CEST)
In-Reply-To: <1272014803-10706-1-git-send-email-hdegoede@redhat.com>
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

The hardware volume handling code in essence just detects key presses, and
then does some hardcoded modification of the master volume based on which key
is pressed.

Clearly the right thing to do here is just report these keypresses to
userspace and let userspace decide what to with them.

This patch adds a Kconfig option which when enabled reports the volume
buttons as keypresses using an input device. When enabled this option
also gets rid of the ugly direct ac97 writes from the tasklet, the ac97lock
and the need for using a tasklet in general.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/Kconfig  |   10 ++++
 sound/pci/es1968.c |  128 +++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 128 insertions(+), 10 deletions(-)

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 2bca3d6..ff66821 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -501,6 +501,16 @@ config SND_ES1968
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-es1968.
 
+config SND_ES1968_INPUT
+	bool "Enable input device for es1968 volume buttons"
+	depends on SND_ES1968
+	depends on INPUT=y || INPUT=SND_ES1968
+	help
+	  If you say Y here, you will get an input device which reports
+	  keypresses for the volume buttons connected to the es1968 chip.
+	  If you say N the buttons will directly control the master volume.
+	  It is recommended to say Y.
+
 config SND_FM801
 	tristate "ForteMedia FM801"
 	select SND_OPL3_LIB
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index a11f453..738d92a 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -104,6 +104,7 @@
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
+#include <linux/input.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -517,14 +518,9 @@ struct es1968 {
 
 	/* ALSA Stuff */
 	struct snd_ac97 *ac97;
-	struct snd_kcontrol *master_switch; /* for h/w volume control */
-	struct snd_kcontrol *master_volume;
-
 	struct snd_rawmidi *rmidi;
 
 	spinlock_t reg_lock;
-	spinlock_t ac97_lock;
-	struct tasklet_struct hwvol_tq;
 	unsigned int in_suspend;
 
 	/* Maestro Stuff */
@@ -547,6 +543,16 @@ struct es1968 {
 #ifdef SUPPORT_JOYSTICK
 	struct gameport *gameport;
 #endif
+
+#ifdef CONFIG_SND_ES1968_INPUT
+	struct input_dev *input_dev;
+	char phys[64];			/* physical device path */
+#else
+	struct snd_kcontrol *master_switch; /* for h/w volume control */
+	struct snd_kcontrol *master_volume;
+	spinlock_t ac97_lock;
+	struct tasklet_struct hwvol_tq;
+#endif
 };
 
 static irqreturn_t snd_es1968_interrupt(int irq, void *dev_id);
@@ -632,28 +638,38 @@ static int snd_es1968_ac97_wait_poll(struct es1968 *chip)
 static void snd_es1968_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
 {
 	struct es1968 *chip = ac97->private_data;
+#ifndef CONFIG_SND_ES1968_INPUT
 	unsigned long flags;
+#endif
 
 	snd_es1968_ac97_wait(chip);
 
 	/* Write the bus */
+#ifndef CONFIG_SND_ES1968_INPUT
 	spin_lock_irqsave(&chip->ac97_lock, flags);
+#endif
 	outw(val, chip->io_port + ESM_AC97_DATA);
 	/*msleep(1);*/
 	outb(reg, chip->io_port + ESM_AC97_INDEX);
 	/*msleep(1);*/
+#ifndef CONFIG_SND_ES1968_INPUT
 	spin_unlock_irqrestore(&chip->ac97_lock, flags);
+#endif
 }
 
 static unsigned short snd_es1968_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
 	u16 data = 0;
 	struct es1968 *chip = ac97->private_data;
+#ifndef CONFIG_SND_ES1968_INPUT
 	unsigned long flags;
+#endif
 
 	snd_es1968_ac97_wait(chip);
 
+#ifndef CONFIG_SND_ES1968_INPUT
 	spin_lock_irqsave(&chip->ac97_lock, flags);
+#endif
 	outb(reg | 0x80, chip->io_port + ESM_AC97_INDEX);
 	/*msleep(1);*/
 
@@ -661,7 +677,9 @@ static unsigned short snd_es1968_ac97_read(struct snd_ac97 *ac97, unsigned short
 		data = inw(chip->io_port + ESM_AC97_DATA);
 		/*msleep(1);*/
 	}
+#ifndef CONFIG_SND_ES1968_INPUT
 	spin_unlock_irqrestore(&chip->ac97_lock, flags);
+#endif
 
 	return data;
 }
@@ -1874,13 +1892,17 @@ static void snd_es1968_update_pcm(struct es1968 *chip, struct esschan *es)
 	}
 }
 
-/*
- */
+/* The hardware volume works by incrementing / decrementing 2 counters
+   (without wrap around) in response to volume button presses and then
+   generating an interrupt. The pair of counters is stored in bits 1-3 and 5-7
+   of a byte wide register. The meaning of bits 0 and 4 is unknown. */
 static void es1968_update_hw_volume(unsigned long private_data)
 {
 	struct es1968 *chip = (struct es1968 *) private_data;
 	int x, val;
+#ifndef CONFIG_SND_ES1968_INPUT
 	unsigned long flags;
+#endif
 
 	/* Figure out which volume control button was pushed,
 	   based on differences from the default register
@@ -1895,6 +1917,7 @@ static void es1968_update_hw_volume(unsigned long private_data)
 	if (chip->in_suspend)
 		return;
 
+#ifndef CONFIG_SND_ES1968_INPUT
 	if (! chip->master_switch || ! chip->master_volume)
 		return;
 
@@ -1937,6 +1960,35 @@ static void es1968_update_hw_volume(unsigned long private_data)
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
 
 /*
@@ -1953,7 +2005,11 @@ static irqreturn_t snd_es1968_interrupt(int irq, void *dev_id)
 	outw(inw(chip->io_port + 4) & 1, chip->io_port + 4);
 
 	if (event & ESM_HWVOL_IRQ)
+#ifdef CONFIG_SND_ES1968_INPUT
+		es1968_update_hw_volume((unsigned long)chip);
+#else
 		tasklet_schedule(&chip->hwvol_tq); /* we'll do this later */
+#endif
 
 	/* else ack 'em all, i imagine */
 	outb(0xFF, chip->io_port + 0x1A);
@@ -1993,7 +2049,9 @@ snd_es1968_mixer(struct es1968 *chip)
 {
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
+#ifndef CONFIG_SND_ES1968_INPUT
 	struct snd_ctl_elem_id elem_id;
+#endif
 	int err;
 	static struct snd_ac97_bus_ops ops = {
 		.write = snd_es1968_ac97_write,
@@ -2009,6 +2067,7 @@ snd_es1968_mixer(struct es1968 *chip)
 	if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97)) < 0)
 		return err;
 
+#ifndef CONFIG_SND_ES1968_INPUT
 	/* attach master switch / volumes for h/w volume control */
 	memset(&elem_id, 0, sizeof(elem_id));
 	elem_id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
@@ -2018,6 +2077,7 @@ snd_es1968_mixer(struct es1968 *chip)
 	elem_id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	strcpy(elem_id.name, "Master Playback Volume");
 	chip->master_volume = snd_ctl_find_id(chip->card, &elem_id);
+#endif
 
 	return 0;
 }
@@ -2474,8 +2534,49 @@ static inline int snd_es1968_create_gameport(struct es1968 *chip, int dev) { ret
 static inline void snd_es1968_free_gameport(struct es1968 *chip) { }
 #endif
 
+#ifdef CONFIG_SND_ES1968_INPUT
+static int __devinit snd_es1968_input_register(struct es1968 *chip)
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
+#endif /* CONFIG_SND_ES1968_INPUT */
+
 static int snd_es1968_free(struct es1968 *chip)
 {
+#ifdef CONFIG_SND_ES1968_INPUT
+	if (chip->input_dev)
+		input_unregister_device(chip->input_dev);
+#endif
+
 	if (chip->io_port) {
 		if (chip->irq >= 0)
 			synchronize_irq(chip->irq);
@@ -2486,8 +2587,6 @@ static int snd_es1968_free(struct es1968 *chip)
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
 	snd_es1968_free_gameport(chip);
-	chip->master_switch = NULL;
-	chip->master_volume = NULL;
 	pci_release_regions(chip->pci);
 	pci_disable_device(chip->pci);
 	kfree(chip);
@@ -2558,9 +2657,11 @@ static int __devinit snd_es1968_create(struct snd_card *card,
 	spin_lock_init(&chip->substream_lock);
 	INIT_LIST_HEAD(&chip->buf_list);
 	INIT_LIST_HEAD(&chip->substream_list);
-	spin_lock_init(&chip->ac97_lock);
 	mutex_init(&chip->memory_mutex);
+#ifndef CONFIG_SND_ES1968_INPUT
+	spin_lock_init(&chip->ac97_lock);
 	tasklet_init(&chip->hwvol_tq, es1968_update_hw_volume, (unsigned long)chip);
+#endif
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
@@ -2713,6 +2814,13 @@ static int __devinit snd_es1968_probe(struct pci_dev *pci,
 
 	snd_es1968_create_gameport(chip, dev);
 
+#ifdef CONFIG_SND_ES1968_INPUT
+	err = snd_es1968_input_register(chip);
+	if (err)
+		snd_printk(KERN_WARNING "Input device registration "
+			"failed with error %i", err);
+#endif
+
 	snd_es1968_start_irq(chip);
 
 	chip->clock = clock[dev];
-- 
1.7.0.1
