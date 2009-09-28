From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sscape: convert to firmware loader framework
Date: Mon, 28 Sep 2009 23:08:19 +0200
Message-ID: <20090928230819.5cf9f625.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0019882865157695868=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ACA010383F
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 22:52:14 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Theodore J. Allen" <tjallen@hws.edu>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============0019882865157695868==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The conversion solves the problem that firmware size was set to 64KB
while non PnP cards have 128KB firmware files.

An additional post firmware initialization code has been moved
from the OSS driver.

---
Now, the MIDI is audible but not correct. It is not played timely.
The sscape_ctl alsa-tool is not needed any more.


 Documentation/sound/alsa/ALSA-Configuration.txt |    8 +-
 include/sound/sscape_ioctl.h                    |   21 --
 sound/isa/Kconfig                               |    8 +-
 sound/isa/sscape.c                              |  305 +++++++----------------
 4 files changed, 101 insertions(+), 241 deletions(-)
 delete mode 100644 include/sound/sscape_ioctl.h

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index 1c8eb45..cf98525 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -1631,7 +1631,7 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
   Module snd-sscape
   -----------------
 
-    Module for ENSONIQ SoundScape PnP cards.
+    Module for ENSONIQ SoundScape cards.
 
     port	- Port # (PnP setup)
     wss_port	- WSS Port # (PnP setup)
@@ -1640,9 +1640,9 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
     dma		- DMA # (PnP setup)
     dma2	- 2nd DMA # (PnP setup, -1 to disable)
 
-    This module supports multiple cards.  ISA PnP must be enabled.
-    You need sscape_ctl tool in alsa-tools package for loading
-    the microcode.
+    This module supports multiple cards.
+
+    The driver requires the firmware loader support on kernel.
 
   Module snd-sun-amd7930 (on sparc only)
   --------------------------------------
diff --git a/include/sound/sscape_ioctl.h b/include/sound/sscape_ioctl.h
deleted file mode 100644
index 0d88859..0000000
--- a/include/sound/sscape_ioctl.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#ifndef SSCAPE_IOCTL_H
-#define SSCAPE_IOCTL_H
-
-
-struct sscape_bootblock
-{
-  unsigned char code[256];
-  unsigned version;
-};
-
-#define SSCAPE_MICROCODE_SIZE  65536
-
-struct sscape_microcode
-{
-  unsigned char __user *code;
-};
-
-#define SND_SSCAPE_LOAD_BOOTB  _IOWR('P', 100, struct sscape_bootblock)
-#define SND_SSCAPE_LOAD_MCODE  _IOW ('P', 101, struct sscape_microcode)
-
-#endif
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index b90fc16..02fe81c 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -372,9 +372,9 @@ config SND_SGALAXY
 
 config SND_SSCAPE
 	tristate "Ensoniq SoundScape driver"
-	select SND_HWDEP
 	select SND_MPU401_UART
 	select SND_WSS_LIB
+	select FW_LOADER
 	help
 	  Say Y here to include support for Ensoniq SoundScape 
 	  and Ensoniq OEM soundcards.
@@ -382,7 +382,11 @@ config SND_SSCAPE
 	  The PCM audio is supported on SoundScape Classic, Elite, PnP
 	  and VIVO cards. The supported OEM cards are SPEA Media FX and
 	  Reveal SC-600.
-	  The MIDI support is very experimental.
+	  The MIDI support is very experimental and requires binary
+	  firmware files called "scope.cod" and "sndscape.co?" where the
+	  ? is digit 0, 1, 2, 3 or 4. The firmware files can be found
+	  in DOS or Windows driver packages. One has to put the firmware
+	  files into the /lib/firmware directory.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-sscape.
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index b11c35f..08389a2 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -1,5 +1,5 @@
 /*
- *   Low-level ALSA driver for the ENSONIQ SoundScape PnP
+ *   Low-level ALSA driver for the ENSONIQ SoundScape
  *   Copyright (c) by Chris Rankin
  *
  *   This driver was written in part using information obtained from
@@ -25,12 +25,12 @@
 #include <linux/err.h>
 #include <linux/isa.h>
 #include <linux/delay.h>
+#include <linux/firmware.h>
 #include <linux/pnp.h>
 #include <linux/spinlock.h>
 #include <linux/moduleparam.h>
 #include <asm/dma.h>
 #include <sound/core.h>
-#include <sound/hwdep.h>
 #include <sound/wss.h>
 #include <sound/mpu401.h>
 #include <sound/initval.h>
@@ -39,7 +39,7 @@
 
 
 MODULE_AUTHOR("Chris Rankin");
-MODULE_DESCRIPTION("ENSONIQ SoundScape PnP driver");
+MODULE_DESCRIPTION("ENSONIQ SoundScape driver");
 MODULE_LICENSE("GPL");
 
 static int index[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_IDX;
@@ -142,14 +142,12 @@ struct soundscape {
 	struct resource *wss_res;
 	struct snd_wss *chip;
 	struct snd_mpu401 *mpu;
-	struct snd_hwdep *hw;
 
 	/*
 	 * The MIDI device won't work until we've loaded
 	 * its firmware via a hardware-dependent device IOCTL
 	 */
 	spinlock_t fwlock;
-	int hw_in_use;
 	unsigned long midi_usage;
 	unsigned char midi_vol;
 };
@@ -167,12 +165,6 @@ static inline struct soundscape *get_mpu401_soundscape(struct snd_mpu401 * mpu)
 	return (struct soundscape *) (mpu->private_data);
 }
 
-static inline struct soundscape *get_hwdep_soundscape(struct snd_hwdep * hw)
-{
-	return (struct soundscape *) (hw->private_data);
-}
-
-
 /*
  * Allocates some kernel memory that we can use for DMA.
  * I think this means that the memory has to map to
@@ -438,14 +430,14 @@ static int host_startup_ack(struct soundscape *s, unsigned timeout)
  * Upload a byte-stream into the SoundScape using DMA channel A.
  */
 static int upload_dma_data(struct soundscape *s,
-                           const unsigned char __user *data,
+			   const unsigned char *data,
                            size_t size)
 {
 	unsigned long flags;
 	struct snd_dma_buffer dma;
 	int ret;
 
-	if (!get_dmabuf(&dma, PAGE_ALIGN(size)))
+	if (!get_dmabuf(&dma, PAGE_ALIGN(32 * 1024)))
 		return -ENOMEM;
 
 	spin_lock_irqsave(&s->lock, flags);
@@ -468,35 +460,17 @@ static int upload_dma_data(struct soundscape *s,
 	sscape_write_unsafe(s->io_base, GA_HMCTL_REG, sscape_read_unsafe(s->io_base, GA_HMCTL_REG) | 0x80);
 
 	/*
-	 * Upload the user's data (firmware?) to the SoundScape
+	 * Upload the firmware to the SoundScape
 	 * board through the DMA channel ...
 	 */
 	while (size != 0) {
 		unsigned long len;
 
-		/*
-		 * Apparently, copying to/from userspace can sleep.
-		 * We are therefore forbidden from holding any
-		 * spinlocks while we copy ...
-		 */
-		spin_unlock_irqrestore(&s->lock, flags);
-
-		/*
-		 * Remember that the data that we want to DMA
-		 * comes from USERSPACE. We have already verified
-		 * the userspace pointer ...
-		 */
 		len = min(size, dma.bytes);
-		len -= __copy_from_user(dma.area, data, len);
+		memcpy(dma.area, data, len);
 		data += len;
 		size -= len;
 
-		/*
-		 * Grab that spinlock again, now that we've
-		 * finished copying!
-		 */
-		spin_lock_irqsave(&s->lock, flags);
-
 		snd_dma_program(s->chip->dma1, dma.addr, len, DMA_MODE_WRITE);
 		sscape_start_dma_unsafe(s->io_base, GA_DMAA_REG);
 		if (!sscape_wait_dma_unsafe(s->io_base, GA_DMAA_REG, 5000)) {
@@ -512,6 +486,7 @@ static int upload_dma_data(struct soundscape *s,
 	} /* while */
 
 	set_host_mode_unsafe(s->io_base);
+	outb(0x0, s->io_base);
 
 	/*
 	 * Boot the board ... (I think)
@@ -537,7 +512,7 @@ _release_dma:
 	/*
 	 * NOTE!!! We are NOT holding any spinlocks at this point !!!
 	 */
-	sscape_write(s, GA_DMAA_REG, (s->ic_type == IC_ODIE ? 0x70 : 0x40));
+	sscape_write(s, GA_DMAA_REG, (s->ic_type == IC_OPUS ? 0x40 : 0x70));
 	free_dmabuf(&dma);
 
 	return ret;
@@ -547,162 +522,70 @@ _release_dma:
  * Upload the bootblock(?) into the SoundScape. The only
  * purpose of this block of code seems to be to tell
  * us which version of the microcode we should be using.
- *
- * NOTE: The boot-block data resides in USER-SPACE!!!
- *       However, we have already verified its memory
- *       addresses by the time we get here.
  */
-static int sscape_upload_bootblock(struct soundscape *sscape, struct sscape_bootblock __user *bb)
+static int sscape_upload_bootblock(struct snd_card *card)
 {
+	struct soundscape *sscape = get_card_soundscape(card);
 	unsigned long flags;
+	const struct firmware *init_fw = NULL;
 	int data = 0;
 	int ret;
 
-	ret = upload_dma_data(sscape, bb->code, sizeof(bb->code));
-
-	spin_lock_irqsave(&sscape->lock, flags);
-	if (ret == 0) {
-		data = host_read_ctrl_unsafe(sscape->io_base, 100);
-	}
-	set_midi_mode_unsafe(sscape->io_base);
-	spin_unlock_irqrestore(&sscape->lock, flags);
-
-	if (ret == 0) {
-		if (data < 0) {
-			snd_printk(KERN_ERR "sscape: timeout reading firmware version\n");
-			ret = -EAGAIN;
-		}
-		else if (__copy_to_user(&bb->version, &data, sizeof(bb->version))) {
-			ret = -EFAULT;
-		}
+	ret = request_firmware(&init_fw, "scope.cod", card->dev);
+	if (ret < 0) {
+		snd_printk(KERN_ERR "Error loading scope.cod");
+		return ret;
 	}
+	ret = upload_dma_data(sscape, init_fw->data, init_fw->size);
 
-	return ret;
-}
+	release_firmware(init_fw);
 
-/*
- * Upload the microcode into the SoundScape. The
- * microcode is 64K of data, and if we try to copy
- * it into a local variable then we will SMASH THE
- * KERNEL'S STACK! We therefore leave it in USER
- * SPACE, and save ourselves from copying it at all.
- */
-static int sscape_upload_microcode(struct soundscape *sscape,
-                                   const struct sscape_microcode __user *mc)
-{
-	unsigned long flags;
-	char __user *code;
-	int err;
-
-	/*
-	 * We are going to have to copy this data into a special
-	 * DMA-able buffer before we can upload it. We shall therefore
-	 * just check that the data pointer is valid for now.
-	 *
-	 * NOTE: This buffer is 64K long! That's WAY too big to
-	 *       copy into a stack-temporary anyway.
-	 */
-	if ( get_user(code, &mc->code) ||
-	     !access_ok(VERIFY_READ, code, SSCAPE_MICROCODE_SIZE) )
-		return -EFAULT;
+	spin_lock_irqsave(&sscape->lock, flags);
+	if (ret == 0)
+		data = host_read_ctrl_unsafe(sscape->io_base, 100);
 
-	if ((err = upload_dma_data(sscape, code, SSCAPE_MICROCODE_SIZE)) == 0) {
-		snd_printk(KERN_INFO "sscape: MIDI firmware loaded\n");
-	}
+	if (data & 0x10)
+		sscape_write_unsafe(sscape->io_base, GA_SMCFGA_REG, 0x2f);
 
-	spin_lock_irqsave(&sscape->lock, flags);
-	set_midi_mode_unsafe(sscape->io_base);
 	spin_unlock_irqrestore(&sscape->lock, flags);
 
-	initialise_mpu401(sscape->mpu);
+	data &= 0xf;
+	if (ret == 0 && data > 7) {
+		snd_printk(KERN_ERR
+				"sscape: timeout reading firmware version\n");
+		ret = -EAGAIN;
+	}
 
-	return err;
+	return (ret == 0) ? data : ret;
 }
 
 /*
- * Hardware-specific device functions, to implement special
- * IOCTLs for the SoundScape card. This is how we upload
- * the microcode into the card, for example, and so we
- * must ensure that no two processes can open this device
- * simultaneously, and that we can't open it at all if
- * someone is using the MIDI device.
+ * Upload the microcode into the SoundScape.
  */
-static int sscape_hw_open(struct snd_hwdep * hw, struct file *file)
+static int sscape_upload_microcode(struct snd_card *card, int version)
 {
-	register struct soundscape *sscape = get_hwdep_soundscape(hw);
-	unsigned long flags;
+	struct soundscape *sscape = get_card_soundscape(card);
+	const struct firmware *init_fw = NULL;
+	char name[14] = "sndscape.co0";
 	int err;
 
-	spin_lock_irqsave(&sscape->fwlock, flags);
+	name[11] = '0' + version;
 
-	if ((sscape->midi_usage != 0) || sscape->hw_in_use) {
-		err = -EBUSY;
-	} else {
-		sscape->hw_in_use = 1;
-		err = 0;
+	err = request_firmware(&init_fw, name, card->dev);
+	if (err < 0) {
+		snd_printk(KERN_ERR "Error loading sndscape.co0");
+		return err;
 	}
+	err = upload_dma_data(sscape, init_fw->data, init_fw->size);
+	if (err == 0)
+		snd_printk(KERN_INFO "MIDI firmware loaded %d KBs\n",
+				init_fw->size >> 10);
 
-	spin_unlock_irqrestore(&sscape->fwlock, flags);
-	return err;
-}
-
-static int sscape_hw_release(struct snd_hwdep * hw, struct file *file)
-{
-	register struct soundscape *sscape = get_hwdep_soundscape(hw);
-	unsigned long flags;
-
-	spin_lock_irqsave(&sscape->fwlock, flags);
-	sscape->hw_in_use = 0;
-	spin_unlock_irqrestore(&sscape->fwlock, flags);
-	return 0;
-}
-
-static int sscape_hw_ioctl(struct snd_hwdep * hw, struct file *file,
-                           unsigned int cmd, unsigned long arg)
-{
-	struct soundscape *sscape = get_hwdep_soundscape(hw);
-	int err = -EBUSY;
-
-	switch (cmd) {
-	case SND_SSCAPE_LOAD_BOOTB:
-		{
-			register struct sscape_bootblock __user *bb = (struct sscape_bootblock __user *) arg;
-
-			/*
-			 * We are going to have to copy this data into a special
-			 * DMA-able buffer before we can upload it. We shall therefore
-			 * just check that the data pointer is valid for now ...
-			 */
-			if ( !access_ok(VERIFY_READ, bb->code, sizeof(bb->code)) )
-				return -EFAULT;
-
-			/*
-			 * Now check that we can write the firmware version number too...
-			 */
-			if ( !access_ok(VERIFY_WRITE, &bb->version, sizeof(bb->version)) )
-				return -EFAULT;
-
-			err = sscape_upload_bootblock(sscape, bb);
-		}
-		break;
-
-	case SND_SSCAPE_LOAD_MCODE:
-		{
-			register const struct sscape_microcode __user *mc = (const struct sscape_microcode __user *) arg;
-
-			err = sscape_upload_microcode(sscape, mc);
-		}
-		break;
-
-	default:
-		err = -EINVAL;
-		break;
-	} /* switch */
+	release_firmware(init_fw);
 
 	return err;
 }
 
-
 /*
  * Mixer control for the SoundScape's MIDI device.
  */
@@ -920,7 +803,7 @@ static int mpu401_open(struct snd_mpu401 * mpu)
 
 		spin_lock_irqsave(&sscape->fwlock, flags);
 
-		if (sscape->hw_in_use || (sscape->midi_usage == ULONG_MAX)) {
+		if (sscape->midi_usage == ULONG_MAX) {
 			err = -EBUSY;
 		} else {
 			++(sscape->midi_usage);
@@ -1053,13 +936,6 @@ static int __devinit create_ad1845(struct snd_card *card, unsigned port,
 			}
 		}
 
-		strcpy(card->driver, "SoundScape");
-		strcpy(card->shortname, pcm->name);
-		snprintf(card->longname, sizeof(card->longname),
-			 "%s at 0x%lx, IRQ %d, DMA1 %d, DMA2 %d\n",
-			 pcm->name, chip->port, chip->irq,
-			 chip->dma1, chip->dma2);
-
 		sscape->chip = chip;
 	}
 
@@ -1162,29 +1038,6 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 		return -ENXIO;
 	}
 
-	if (sscape->type != SSCAPE_VIVO) {
-		/*
-		 * Now create the hardware-specific device so that we can
-		 * load the microcode into the on-board processor.
-		 * We cannot use the MPU-401 MIDI system until this firmware
-		 * has been loaded into the card.
-		 */
-		err = snd_hwdep_new(card, "MC68EC000", 0, &(sscape->hw));
-		if (err < 0) {
-			printk(KERN_ERR "sscape: Failed to create "
-					"firmware device\n");
-			goto _release_dma;
-		}
-		strlcpy(sscape->hw->name, "SoundScape M68K",
-			sizeof(sscape->hw->name));
-		sscape->hw->name[sizeof(sscape->hw->name) - 1] = '\0';
-		sscape->hw->iface = SNDRV_HWDEP_IFACE_SSCAPE;
-		sscape->hw->ops.open = sscape_hw_open;
-		sscape->hw->ops.release = sscape_hw_release;
-		sscape->hw->ops.ioctl = sscape_hw_ioctl;
-		sscape->hw->private_data = sscape;
-	}
-
 	/*
 	 * Tell the on-board devices where their resources are (I think -
 	 * I can't be sure without a datasheet ... So many magic values!)
@@ -1222,28 +1075,51 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 		       wss_port[dev], irq[dev]);
 		goto _release_dma;
 	}
+	strcpy(card->driver, "SoundScape");
+	strcpy(card->shortname, name);
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s at 0x%lx, IRQ %d, DMA1 %d, DMA2 %d\n",
+		 name, sscape->chip->port, sscape->chip->irq,
+		 sscape->chip->dma1, sscape->chip->dma2);
+
 #define MIDI_DEVNUM  0
 	if (sscape->type != SSCAPE_VIVO) {
-		err = create_mpu401(card, MIDI_DEVNUM, port[dev], mpu_irq[dev]);
-		if (err < 0) {
-			printk(KERN_ERR "sscape: Failed to create "
-					"MPU-401 device at 0x%lx\n",
-					port[dev]);
-			goto _release_dma;
-		}
+		err = sscape_upload_bootblock(card);
+		if (err >= 0)
+			err = sscape_upload_microcode(card, err);
+
+		if (err == 0) {
+			err = create_mpu401(card, MIDI_DEVNUM, port[dev],
+					    mpu_irq[dev]);
+			if (err < 0) {
+				printk(KERN_ERR "sscape: Failed to create "
+						"MPU-401 device at 0x%lx\n",
+						port[dev]);
+				goto _release_dma;
+			}
 
-		/*
-		 * Enable the master IRQ ...
-		 */
-		sscape_write(sscape, GA_INTENA_REG, 0x80);
-
-		/*
-		 * Initialize mixer
-		 */
-		sscape->midi_vol = 0;
-		host_write_ctrl_unsafe(sscape->io_base, CMD_SET_MIDI_VOL, 100);
-		host_write_ctrl_unsafe(sscape->io_base, 0, 100);
-		host_write_ctrl_unsafe(sscape->io_base, CMD_XXX_MIDI_VOL, 100);
+			/*
+			 * Initialize mixer
+			 */
+			spin_lock_irqsave(&sscape->lock, flags);
+			sscape->midi_vol = 0;
+			host_write_ctrl_unsafe(sscape->io_base,
+						CMD_SET_MIDI_VOL, 100);
+			host_write_ctrl_unsafe(sscape->io_base,
+						sscape->midi_vol, 100);
+			host_write_ctrl_unsafe(sscape->io_base,
+						CMD_XXX_MIDI_VOL, 100);
+			host_write_ctrl_unsafe(sscape->io_base,
+						sscape->midi_vol, 100);
+			host_write_ctrl_unsafe(sscape->io_base,
+						CMD_SET_EXTMIDI, 100);
+			host_write_ctrl_unsafe(sscape->io_base,
+						0, 100);
+			host_write_ctrl_unsafe(sscape->io_base, 80, 1);
+
+			set_midi_mode_unsafe(sscape->io_base);
+			spin_unlock_irqrestore(&sscape->lock, flags);
+		}
 	}
 
 	/*
@@ -1301,11 +1177,12 @@ static int __devinit snd_sscape_probe(struct device *pdev, unsigned int dev)
 	sscape->type = SSCAPE;
 
 	dma[dev] &= 0x03;
+	snd_card_set_dev(card, pdev);
+
 	ret = create_sscape(dev, card);
 	if (ret < 0)
 		goto _release_card;
 
-	snd_card_set_dev(card, pdev);
 	if ((ret = snd_card_register(card)) < 0) {
 		printk(KERN_ERR "sscape: Failed to register sound card\n");
 		goto _release_card;
@@ -1426,12 +1303,12 @@ static int __devinit sscape_pnp_detect(struct pnp_card_link *pcard,
 		wss_port[idx] = pnp_port_start(dev, 1);
 		dma2[idx] = pnp_dma(dev, 1);
 	}
+	snd_card_set_dev(card, &pcard->card->dev);
 
 	ret = create_sscape(idx, card);
 	if (ret < 0)
 		goto _release_card;
 
-	snd_card_set_dev(card, &pcard->card->dev);
 	if ((ret = snd_card_register(card)) < 0) {
 		printk(KERN_ERR "sscape: Failed to register sound card\n");
 		goto _release_card;
-- 
1.6.0.3

----------------------------------------------------------------------
Co godzine losujemy 15 000 z³!
http://link.interia.pl/f2376


--===============0019882865157695868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0019882865157695868==--
