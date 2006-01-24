From: "Ash Willis" <ashwillis@programmer.net>
Subject: [PATCH] ALS300(+)
Date: Tue, 24 Jan 2006 18:03:14 -0500
Message-ID: <200601242303.k0ON3EX20911@cal1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

This is a patch to add Avance Logic ALS300 and ALS300+ support.
It covers playback and capture but legacy devices are not yet implemented.

I have the datasheet for the ALS300 chip and was given permission to distri=
bute it if anyone is interested.

Ash Willis

diff -Naur alsa-driver-orig/pci/Kconfig alsa-driver/pci/Kconfig
--- alsa-driver-orig/pci/Kconfig 2006-01-24 21:39:43.000000000 +0000
+++ alsa-driver/pci/Kconfig 2006-01-24 22:41:36.000000000 +0000
@@ -170,5 +170,15 @@
    To compile this driver as a module, choose M here: the module
    will be called snd-riptide
=20
+config SND_ALS300
+        tristate "Avance Logic ALS300/ALS300+"
+        depends on SND
+        select SND_PCM
+        help
+          Say 'Y' or 'M' to include support for Avance Logic ALS300/ALS300+
+
+          To compile this driver as a module, choose M here: the module
+          will be called snd-als300
+
 endmenu
=20
diff -Naur alsa-driver-orig/pci/Makefile alsa-driver/pci/Makefile
--- alsa-driver-orig/pci/Makefile 2006-01-24 21:39:43.000000000 +0000
+++ alsa-driver/pci/Makefile 2006-01-24 22:41:32.000000000 +0000
@@ -9,6 +9,9 @@
 # ALSA extra code
 #
=20
+snd-als300-objs :=3D als300.o
+obj-$(CONFIG_SND_ALS300) +=3D snd-als300.o
+
 clean-files :=3D ad1889.c bt87x.c intel8x0.c maestro3.c
=20
 obj-$(CONFIG_SND) +=3D pdplus/ echoaudio/ riptide/ asihpi/
diff -Naur alsa-driver-orig/pci/als300.c alsa-driver/pci/als300.c
--- alsa-driver-orig/pci/als300.c 1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver/pci/als300.c 2006-01-24 22:42:04.000000000 +0000
@@ -0,0 +1,813 @@
+/*
+ *  als300.c - driver for Avance Logic ALS300/ALS300+ soundcards.
+ *  Copyright (C) 2005 by Ash Willis <ashwillis@programmer.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 U=
SA
+ *
+ *  TODO
+ *  4 channel playback for ALS300+
+ *  gameport
+ *  mpu401
+ *  opl3
+ *
+ *  NOTES
+ *  The BLOCK_COUNTER registers for the ALS300(+) return a figure related =
to
+ *  the position in the current period, NOT the whole buffer. It is import=
ant
+ *  to know which period we are in so we can calculate the correct pointer.
+ *  This is why we always use 2 periods. We can then use a flip-flop varia=
ble
+ *  to keep track of what period we are in.
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+
+#include <asm/io.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#define SNDRV_GET_ID
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/ac97_codec.h>
+#include <sound/opl3.h>
+
+/* snd_als300_set_irq_flag */
+#define IRQ_DISABLE  0
+#define IRQ_ENABLE  1
+
+/* I/O port layout */
+#define AC97_ACCESS  0x00
+#define AC97_READ  0x04
+#define AC97_STATUS  0x06
+#define   AC97_DATA_AVAIL  (1<<6)
+#define   AC97_BUSY   (1<<7)
+#define ALS300_IRQ_STATUS 0x07  /* ALS300 Only */
+#define   IRQ_PLAYBACK   (1<<3)
+#define   IRQ_CAPTURE   (1<<2)
+#define GCR_DATA  0x08
+#define GCR_INDEX  0x0C
+#define ALS300P_DRAM_IRQ_STATUS 0x0D  /* ALS300+ Only */
+#define MPU_IRQ_STATUS  0x0E  /* ALS300 Rev. E+, ALS300+ */
+#define ALS300P_IRQ_STATUS 0x0F  /* ALS300+ Only */
+
+/* General Control Registers */
+#define PLAYBACK_START  0x80
+#define PLAYBACK_END  0x81
+#define PLAYBACK_CONTROL 0x82
+#define   TRANSFER_START  (1<<16)
+#define   FIFO_PAUSE   (1<<17)
+#define RECORD_START  0x83
+#define RECORD_END  0x84
+#define RECORD_CONTROL  0x85
+#define DRAM_WRITE_CONTROL 0x8B
+#define   WRITE_TRANS_START  (1<<16)
+#define   DRAM_MODE_2   (1<<17)
+#define MISC_CONTROL  0x8C
+#define   IRQ_SET_BIT   (1<<15)
+#define   VMUTE_NORMAL   (1<<20)
+#define   MMUTE_NORMAL   (1<<21)
+#define MUS_VOC_VOL  0x8E
+#define PLAYBACK_BLOCK_COUNTER 0x9A
+#define RECORD_BLOCK_COUNTER 0x9B
+
+#define DEBUG_CALLS 1
+#define DEBUG_PLAY_REC 1
+
+#if DEBUG_CALLS
+#define snd_als300_dbgcalls(format, args...) printk(format, ##args)
+#define snd_als300_dbgcallenter() printk(KERN_ERR "--> %s\n", __FUNCTION__)
+#define snd_als300_dbgcallleave() printk(KERN_ERR "<-- %s\n", __FUNCTION__)
+#else
+#define snd_als300_dbgcalls(format, args...)
+#define snd_als300_dbgcallenter()
+#define snd_als300_dbgcallleave()
+#endif
+
+#if DEBUG_PLAY_REC
+#define snd_als300_dbgplay(format, args...) printk(KERN_ERR format, ##args)
+#else
+#define snd_als300_dbgplay(format, args...)
+#endif=20=20
+
+enum {DEVICE_ALS300, DEVICE_ALS300_PLUS};
+
+MODULE_AUTHOR("Ash Willis <ashwillis@programmer.net>");
+MODULE_DESCRIPTION("Avance Logic ALS300");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("{{Avance Logic,ALS300},{Avance Logic,ALS300+}}");
+
+static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
+
+typedef struct snd_als300 als300_t;
+struct snd_als300 {
+ unsigned long port;
+ spinlock_t reg_lock;
+ snd_card_t *card;
+ struct pci_dev *pci;
+
+	snd_pcm_t *pcm;
+	snd_pcm_substream_t *playback_substream;
+	snd_pcm_substream_t *capture_substream;
+
+	ac97_t *ac97;
+	opl3_t *opl3;
+
+ struct resource *res_port;
+
+ int irq;
+
+ int chip_type; /* ALS300 or ALS300+ */
+
+ char revision;=20
+};
+
+typedef struct snd_als300_substream_private_data als300_substream_data_t;
+struct snd_als300_substream_private_data {
+ int period_flipflop;
+ int control_register;
+ int block_counter_register;
+};
+
+static struct pci_device_id snd_als300_ids[] =3D {
+	{ 0x4005, 0x0300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_ALS300 },
+	{ 0x4005, 0x0308, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_ALS300_PLUS },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, snd_als300_ids);
+
+static inline u32 snd_als300_gcr_read(unsigned long port, unsigned short r=
eg)
+{
+ outb(reg, port+GCR_INDEX);
+ return inl(port+GCR_DATA);
+}
+
+static inline void snd_als300_gcr_write(unsigned long port,
+      unsigned short reg, u32 val)
+{
+ outb(reg, port+GCR_INDEX);
+ outl(val, port+GCR_DATA);
+}
+
+/* Enable/Disable Interrupts */
+static void snd_als300_set_irq_flag(als300_t *chip, int cmd)
+{
+ u32 tmp =3D snd_als300_gcr_read(chip->port, MISC_CONTROL);
+ snd_als300_dbgcallenter();
+=20
+ /* boolean XOR check, since old vs. new hardware have
+    directly reversed bit setting for ENABLE and DISABLE.
+    ALS300+ acts like newer versions of ALS300 */
+ if (((chip->revision > 5 || chip->chip_type =3D=3D DEVICE_ALS300_PLUS) ^
+        (cmd =3D=3D IRQ_ENABLE)) =3D=3D 0)
+  tmp |=3D IRQ_SET_BIT;
+ else
+  tmp &=3D ~IRQ_SET_BIT;
+ snd_als300_gcr_write(chip->port, MISC_CONTROL, tmp);
+ snd_als300_dbgcallleave();
+}
+
+static int snd_als300_free(als300_t *chip)
+{
+ snd_als300_dbgcallenter();
+ snd_als300_set_irq_flag(chip, IRQ_DISABLE);
+ if (chip->irq >=3D 0)
+  free_irq(chip->irq, (void *)chip);
+ pci_release_regions(chip->pci);
+ pci_disable_device(chip->pci);
+        kfree(chip);
+ snd_als300_dbgcallleave();
+ return 0;
+}
+
+static int snd_als300_dev_free(snd_device_t *device)
+{
+ als300_t *chip =3D device->device_data;
+ return snd_als300_free(chip);
+}
+
+static irqreturn_t snd_als300_interrupt(int irq, void *dev_id,
+						struct pt_regs *regs)
+{
+	u8 status;
+	als300_t *chip =3D dev_id;
+	als300_substream_data_t *data;
+	status =3D inb(chip->port+ALS300_IRQ_STATUS);
+
+ if (!status) /* shared IRQ, for different device?? Exit ASAP! */
+  return IRQ_NONE;
+
+ /* ACK everything ASAP */
+ outb(status, chip->port+ALS300_IRQ_STATUS);
+ if (status & IRQ_PLAYBACK) {
+  if (chip->pcm && chip->playback_substream) {
+   data =3D chip->playback_substream->runtime->private_data;
+   data->period_flipflop ^=3D 1;
+			snd_pcm_period_elapsed(chip->playback_substream);
+			snd_als300_dbgplay("IRQ_PLAYBACK\n");
+		}
+	}
+	if (status & IRQ_CAPTURE) {
+		if (chip->pcm && chip->capture_substream) {
+			data =3D chip->capture_substream->runtime->private_data;
+			data->period_flipflop ^=3D 1;
+			snd_pcm_period_elapsed(chip->capture_substream);
+			snd_als300_dbgplay("IRQ_CAPTURE\n");
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t snd_als300plus_interrupt(int irq, void *dev_id,
+						struct pt_regs *regs)
+{
+	u8 general, mpu, dram;
+	als300_t *chip =3D dev_id;
+	als300_substream_data_t *data;
+=09
+	general =3D inb(chip->port+ALS300P_IRQ_STATUS);
+ mpu =3D inb(chip->port+MPU_IRQ_STATUS);
+ dram =3D inb(chip->port+ALS300P_DRAM_IRQ_STATUS);
+
+ /* shared IRQ, for different device?? Exit ASAP! */
+ if ((general =3D=3D 0) && ((mpu & 0x80) =3D=3D 0) && ((dram & 0x01) =3D=
=3D 0))
+  return IRQ_NONE;
+
+ if (general & IRQ_PLAYBACK) {
+  if (chip->pcm && chip->playback_substream) {
+   outb(IRQ_PLAYBACK, chip->port+ALS300P_IRQ_STATUS);
+			data =3D chip->playback_substream->runtime->private_data;
+			data->period_flipflop ^=3D 1;
+			snd_pcm_period_elapsed(chip->playback_substream);
+			snd_als300_dbgplay("IRQ_PLAYBACK\n");
+		}
+	}
+	if (general & IRQ_CAPTURE) {
+  if (chip->pcm && chip->capture_substream) {
+   outb(IRQ_CAPTURE, chip->port+ALS300P_IRQ_STATUS);
+   data =3D chip->capture_substream->runtime->private_data;
+   data->period_flipflop ^=3D 1;
+   snd_pcm_period_elapsed(chip->capture_substream);
+   snd_als300_dbgplay("IRQ_CAPTURE\n");
+  }
+ }
+ /* FIXME: Ack other interrupt types. Not important right now as
+  * those other devices aren't enabled. */
+ return IRQ_HANDLED;
+}
+
+static void __devexit snd_als300_remove(struct pci_dev *pci)
+{
+ snd_als300_dbgcallenter();
+ snd_card_free(pci_get_drvdata(pci));
+ pci_set_drvdata(pci, NULL);
+ snd_als300_dbgcallleave();
+}
+
+static unsigned short snd_als300_ac97_read(ac97_t *ac97, unsigned short re=
g)
+{
+	int i;
+	als300_t *chip =3D ac97->private_data;
+
+	for (i =3D 0; i < 1000; i++) {
+		if ((inb(chip->port+AC97_STATUS) & (AC97_BUSY)) =3D=3D 0)
+			break;
+		udelay(10);
+	}
+	outl((reg << 24) | (1 << 31), chip->port+AC97_ACCESS);
+
+	for (i =3D 0; i < 1000; i++) {
+		if ((inb(chip->port+AC97_STATUS) & (AC97_DATA_AVAIL)) !=3D 0)
+			break;
+		udelay(10);
+	}
+	return inw(chip->port+AC97_READ);
+}
+
+static void snd_als300_ac97_write(ac97_t *ac97,
+    unsigned short reg, unsigned short val)
+{
+ int i;
+ als300_t *chip =3D ac97->private_data;
+
+ for (i =3D 0; i < 1000; i++) {
+  if ((inb(chip->port+AC97_STATUS) & (AC97_BUSY)) =3D=3D 0)
+   break;
+  udelay(10);
+ }
+ outl((reg << 24) | val, chip->port+AC97_ACCESS);
+}
+
+static int snd_als300_ac97(als300_t *chip)
+{
+ ac97_bus_t *bus;
+ ac97_template_t ac97;
+ int err;
+ static ac97_bus_ops_t ops =3D {
+  .write =3D snd_als300_ac97_write,
+  .read =3D snd_als300_ac97_read,
+ };
+
+ snd_als300_dbgcallenter();
+ if ((err =3D snd_ac97_bus(chip->card, 0, &ops, NULL, &bus)) < 0)
+  return err;
+
+	memset(&ac97, 0, sizeof(ac97));
+	ac97.private_data =3D chip;
+
+	snd_als300_dbgcallleave();
+	return snd_ac97_mixer(bus, &ac97, &chip->ac97);
+}
+
+/* hardware definition
+ *
+ * In AC97 mode, we always use 48k/16bit/stereo.
+ * Any request to change data type is ignored by
+ * the card when it is running outside of legacy
+ * mode.
+ */
+static snd_pcm_hardware_t snd_als300_playback_hw =3D
+{
+ .info =3D   (SNDRV_PCM_INFO_MMAP |
+    SNDRV_PCM_INFO_INTERLEAVED |
+    SNDRV_PCM_INFO_PAUSE |
+    SNDRV_PCM_INFO_MMAP_VALID),
+ .formats =3D  SNDRV_PCM_FMTBIT_S16,
+ .rates =3D  SNDRV_PCM_RATE_48000,
+ .rate_min =3D  48000,
+ .rate_max =3D  48000,
+ .channels_min =3D  2,
+ .channels_max =3D  2,
+ .buffer_bytes_max =3D 64 * 1024,
+ .period_bytes_min =3D 64,
+ .period_bytes_max =3D 32 * 1024,
+ .periods_min =3D  2,
+ .periods_max =3D  2,
+};
+
+static snd_pcm_hardware_t snd_als300_capture_hw =3D
+{
+	.info =3D			(SNDRV_PCM_INFO_MMAP |
+				SNDRV_PCM_INFO_INTERLEAVED |
+				SNDRV_PCM_INFO_PAUSE |
+				SNDRV_PCM_INFO_MMAP_VALID),
+	.formats =3D		SNDRV_PCM_FMTBIT_S16,
+	.rates =3D		SNDRV_PCM_RATE_48000,
+	.rate_min =3D		48000,
+	.rate_max =3D		48000,
+	.channels_min =3D		2,
+	.channels_max =3D		2,
+	.buffer_bytes_max =3D	64 * 1024,
+	.period_bytes_min =3D	64,
+	.period_bytes_max =3D	32 * 1024,
+	.periods_min =3D		2,
+ .periods_max =3D  2,
+};
+
+static int snd_als300_playback_open(snd_pcm_substream_t *substream)
+{
+ als300_t *chip =3D snd_pcm_substream_chip(substream);
+ snd_pcm_runtime_t *runtime =3D substream->runtime;
+ als300_substream_data_t *data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+
+ snd_als300_dbgcallenter();
+ chip->playback_substream =3D substream;
+ runtime->hw =3D snd_als300_playback_hw;
+ runtime->private_data =3D data;
+ data->control_register =3D PLAYBACK_CONTROL;
+ data->block_counter_register =3D PLAYBACK_BLOCK_COUNTER;
+ snd_als300_dbgcallleave();
+ return 0;
+}
+
+static int snd_als300_playback_close(snd_pcm_substream_t *substream)
+{
+ als300_t *chip =3D snd_pcm_substream_chip(substream);
+ als300_substream_data_t *data =3D substream->runtime->private_data;
+
+ snd_als300_dbgcallenter();
+ kfree(data);
+ chip->playback_substream =3D NULL;
+ snd_pcm_lib_free_pages(substream);
+ snd_als300_dbgcallleave();
+	return 0;
+}
+
+static int snd_als300_capture_open(snd_pcm_substream_t *substream)
+{
+ als300_t *chip =3D snd_pcm_substream_chip(substream);
+ snd_pcm_runtime_t *runtime =3D substream->runtime;
+ als300_substream_data_t *data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+=20
+ snd_als300_dbgcallenter();
+ chip->capture_substream =3D substream;
+ runtime->hw =3D snd_als300_capture_hw;
+ runtime->private_data =3D data;
+ data->control_register =3D RECORD_CONTROL;
+ data->block_counter_register =3D RECORD_BLOCK_COUNTER;
+ snd_als300_dbgcallleave();
+ return 0;
+}
+
+static int snd_als300_capture_close(snd_pcm_substream_t *substream)
+{
+ als300_t *chip =3D snd_pcm_substream_chip(substream);
+ als300_substream_data_t *data =3D substream->runtime->private_data;
+
+	snd_als300_dbgcallenter();
+	kfree(data);
+	chip->capture_substream =3D NULL;
+	snd_pcm_lib_free_pages(substream);
+	snd_als300_dbgcallleave();
+	return 0;
+}
+
+static int snd_als300_pcm_hw_params(snd_pcm_substream_t *substream,
+					snd_pcm_hw_params_t * hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream,
+     params_buffer_bytes(hw_params));
+}
+
+static int snd_als300_pcm_hw_free(snd_pcm_substream_t *substream)
+{
+ return snd_pcm_lib_free_pages(substream);
+}
+
+static int snd_als300_playback_prepare(snd_pcm_substream_t *substream)
+{
+ u32 tmp;
+ unsigned long flags;
+ als300_t *chip =3D snd_pcm_substream_chip(substream);
+ snd_pcm_runtime_t *runtime =3D substream->runtime;
+ unsigned short period_bytes =3D snd_pcm_lib_period_bytes(substream);
+ unsigned short buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
+=09
+	snd_als300_dbgcallenter();
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	tmp =3D snd_als300_gcr_read(chip->port, PLAYBACK_CONTROL);
+	tmp &=3D ~TRANSFER_START;
+
+	snd_als300_dbgplay("Period bytes: %d Buffer bytes %d\n", period_bytes, bu=
ffer_bytes);
+=20
+ /* set block size */
+ tmp &=3D 0xffff0000;
+ tmp |=3D period_bytes - 1;
+ snd_als300_gcr_write(chip->port, PLAYBACK_CONTROL, tmp);
+ snd_als300_gcr_write(chip->port, PLAYBACK_START,
+     runtime->dma_addr);
+ snd_als300_gcr_write(chip->port, PLAYBACK_END,
+     runtime->dma_addr + buffer_bytes - 1);
+ spin_unlock_irqrestore(&chip->reg_lock, flags);
+ snd_als300_dbgcallleave();
+ return 0;
+}
+
+static int snd_als300_capture_prepare(snd_pcm_substream_t *substream)
+{
+	u32 tmp;
+	unsigned long flags;
+	als300_t *chip =3D snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime =3D substream->runtime;
+	unsigned short period_bytes =3D snd_pcm_lib_period_bytes(substream);
+	unsigned short buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
+=09
+	snd_als300_dbgcallenter();
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	tmp =3D snd_als300_gcr_read(chip->port, RECORD_CONTROL);
+	tmp &=3D ~TRANSFER_START;
+
+	snd_als300_dbgplay("Period bytes: %d Buffer bytes %d\n", period_bytes, bu=
ffer_bytes);
+=09
+	/* set block size */
+	tmp &=3D 0xffff0000;
+	tmp |=3D period_bytes - 1;
+	snd_als300_gcr_write(chip->port, RECORD_CONTROL, tmp);
+ snd_als300_gcr_write(chip->port, RECORD_START,
+     runtime->dma_addr);
+ snd_als300_gcr_write(chip->port, RECORD_END,
+     runtime->dma_addr + buffer_bytes - 1);
+ spin_unlock_irqrestore(&chip->reg_lock, flags);
+ snd_als300_dbgcallleave();
+ return 0;
+}
+
+static int snd_als300_trigger(snd_pcm_substream_t *substream, int cmd)
+{
+ als300_t *chip =3D snd_pcm_substream_chip(substream);
+ u32 tmp;
+ unsigned long flags;
+ als300_substream_data_t *data =3D substream->runtime->private_data;
+ unsigned short reg =3D data->control_register;
+ int ret =3D 0;
+
+ snd_als300_dbgcallenter();
+ spin_lock_irqsave(&chip->reg_lock, flags);
+ switch (cmd) {
+ case SNDRV_PCM_TRIGGER_START:
+  tmp =3D snd_als300_gcr_read(chip->port, reg);
+  data->period_flipflop =3D 1;
+  snd_als300_gcr_write(chip->port, reg, tmp | TRANSFER_START);
+  snd_als300_dbgplay("TRIGGER START\n");
+  break;
+ case SNDRV_PCM_TRIGGER_STOP:
+  tmp =3D snd_als300_gcr_read(chip->port, reg);
+  snd_als300_gcr_write(chip->port, reg, tmp & ~TRANSFER_START);
+  snd_als300_dbgplay("TRIGGER STOP\n");
+  break;
+ case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+  tmp =3D snd_als300_gcr_read(chip->port, reg);
+  snd_als300_gcr_write(chip->port, reg, tmp | FIFO_PAUSE);
+  snd_als300_dbgplay("TRIGGER PAUSE\n");
+  break;
+ case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+  tmp =3D snd_als300_gcr_read(chip->port, reg);
+  snd_als300_gcr_write(chip->port, reg, tmp & ~FIFO_PAUSE);
+  snd_als300_dbgplay("TRIGGER RELEASE\n");
+  break;
+ default:
+  snd_als300_dbgplay("TRIGGER INVALID\n");
+  ret =3D -EINVAL;
+ }
+ spin_unlock_irqrestore(&chip->reg_lock, flags);
+ snd_als300_dbgcallleave();
+ return ret;
+}
+
+static snd_pcm_uframes_t snd_als300_pointer(snd_pcm_substream_t *substream)
+{
+ u16 current_ptr;
+ unsigned long flags;
+ als300_t *chip =3D snd_pcm_substream_chip(substream);
+ als300_substream_data_t *data =3D substream->runtime->private_data;
+ unsigned short period_bytes =3D snd_pcm_lib_period_bytes(substream);
+=20
+ snd_als300_dbgcallenter();
+ spin_lock_irqsave(&chip->reg_lock, flags);
+ current_ptr =3D (u16) snd_als300_gcr_read(chip->port,
+     data->block_counter_register) + 4;
+ spin_unlock_irqrestore(&chip->reg_lock, flags);
+ if (current_ptr > period_bytes)
+  current_ptr =3D 0;
+ else
+  current_ptr =3D period_bytes - current_ptr;
+
+ if (data->period_flipflop =3D=3D 0)
+  current_ptr +=3D period_bytes;
+ snd_als300_dbgplay("Pointer (bytes): %d\n", current_ptr);
+ snd_als300_dbgcallleave();
+ return bytes_to_frames(substream->runtime, current_ptr);
+}
+
+static snd_pcm_ops_t snd_als300_playback_ops =3D {
+ .open =3D  snd_als300_playback_open,
+ .close =3D snd_als300_playback_close,
+ .ioctl =3D snd_pcm_lib_ioctl,
+ .hw_params =3D snd_als300_pcm_hw_params,
+ .hw_free =3D snd_als300_pcm_hw_free,
+ .prepare =3D snd_als300_playback_prepare,
+ .trigger =3D snd_als300_trigger,
+ .pointer =3D snd_als300_pointer,
+};
+
+static snd_pcm_ops_t snd_als300_capture_ops =3D {
+ .open =3D  snd_als300_capture_open,
+ .close =3D snd_als300_capture_close,
+ .ioctl =3D snd_pcm_lib_ioctl,
+ .hw_params =3D snd_als300_pcm_hw_params,
+ .hw_free =3D snd_als300_pcm_hw_free,
+ .prepare =3D snd_als300_capture_prepare,
+ .trigger =3D snd_als300_trigger,
+ .pointer =3D snd_als300_pointer,
+};
+
+static int __devinit snd_als300_new_pcm(als300_t *chip)
+{
+ snd_pcm_t *pcm;
+ int err;
+
+ snd_als300_dbgcallenter();
+ if ((err =3D snd_pcm_new(chip->card, chip->card->shortname, 0, 1, 1, &pcm=
)) < 0)
+  return err;
+ pcm->private_data =3D chip;
+ strcpy(pcm->name, chip->card->shortname);
+ chip->pcm =3D pcm;
+
+ /* set operators */
+ snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+    &snd_als300_playback_ops);
+ snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+    &snd_als300_capture_ops);
+
+ /* pre-allocation of buffers */
+ snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+ snd_dma_pci_data(chip->pci), 64*1024, 64*1024);
+ snd_als300_dbgcallleave();
+ return 0;
+}
+
+static void snd_als300_init(als300_t *chip)
+{
+ unsigned long flags;
+ u32 tmp;
+=20
+ snd_als300_dbgcallenter();
+ spin_lock_irqsave(&chip->reg_lock, flags);
+ chip->revision =3D (snd_als300_gcr_read(chip->port, MISC_CONTROL) >> 16) =
& 0x0000000F;
+ /* Setup DRAM */
+ tmp =3D snd_als300_gcr_read(chip->port, DRAM_WRITE_CONTROL);
+ snd_als300_gcr_write(chip->port, DRAM_WRITE_CONTROL,
+      (tmp | DRAM_MODE_2)
+      & ~WRITE_TRANS_START);
+
+ /* Enable IRQ output */
+ snd_als300_set_irq_flag(chip, IRQ_ENABLE);
+
+ /* Unmute hardware devices so their outputs get routed to
+  * the onboard mixer */
+ tmp =3D snd_als300_gcr_read(chip->port, MISC_CONTROL);
+ snd_als300_gcr_write(chip->port, MISC_CONTROL,
+   tmp | VMUTE_NORMAL | MMUTE_NORMAL);
+
+ /* Reset volumes */
+ snd_als300_gcr_write(chip->port, MUS_VOC_VOL, 0);
+
+ /* Make sure playback transfer is stopped */
+ tmp =3D snd_als300_gcr_read(chip->port, PLAYBACK_CONTROL);
+ snd_als300_gcr_write(chip->port, PLAYBACK_CONTROL,
+   tmp & ~TRANSFER_START);
+ spin_unlock_irqrestore(&chip->reg_lock, flags);
+ snd_als300_dbgcallleave();
+}
+
+static int __devinit snd_als300_create(snd_card_t *card,
+        struct pci_dev *pci, int chip_type,
+                      als300_t **rchip)
+{
+ als300_t *chip;
+ void *irq_handler;
+ int err;
+
+ static snd_device_ops_t ops =3D {
+  .dev_free =3D snd_als300_dev_free,
+ };
+ *rchip =3D NULL;
+
+ snd_als300_dbgcallenter();
+ if ((err =3D pci_enable_device(pci)) < 0)
+  return err;
+=20
+ if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
+  pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0)
+ {
+  printk(KERN_ERR "error setting 28bit DMA mask\n");
+  pci_disable_device(pci);
+  return -ENXIO;
+ }
+ pci_set_master(pci);
+
+ chip =3D kzalloc(sizeof(*chip), GFP_KERNEL);
+ if (chip =3D=3D NULL) {
+  pci_disable_device(pci);
+  return -ENOMEM;
+ }
+
+ chip->card =3D card;
+ chip->pci =3D pci;
+ chip->irq =3D -1;
+ chip->chip_type =3D chip_type;
+ spin_lock_init(&chip->reg_lock);
+
+ if ((err =3D pci_request_regions(pci, "ALS300")) < 0) {
+  kfree(chip);
+  pci_disable_device(pci);
+  return err;
+ }
+ chip->port =3D pci_resource_start(pci, 0);
+
+ if (chip->chip_type =3D=3D DEVICE_ALS300_PLUS)
+  irq_handler =3D snd_als300plus_interrupt;
+ else
+  irq_handler =3D snd_als300_interrupt;
+
+ if (request_irq(pci->irq, irq_handler, SA_INTERRUPT|SA_SHIRQ, card->short=
name, (void *)chip)) {
+  snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+  snd_als300_free(chip);
+  return -EBUSY;
+ }
+ chip->irq =3D pci->irq;
+
+
+ snd_als300_init(chip);
+
+ if (snd_als300_ac97(chip) < 0) {
+  snd_printk(KERN_WARNING "Could not create ac97\n");
+  snd_card_free(card);
+  return err;
+ }
+
+ if ((err =3D snd_als300_new_pcm(chip)) < 0) {
+  snd_printk(KERN_WARNING "Could not create PCM\n");
+  snd_card_free(card);
+  return err;
+ }
+
+ if ((err =3D snd_device_new(card, SNDRV_DEV_LOWLEVEL,
+      chip, &ops)) < 0) {
+  snd_als300_free(chip);
+  return err;
+ }
+
+ snd_card_set_dev(card, &pci->dev);
+
+ *rchip =3D chip;
+ snd_als300_dbgcallleave();
+ return 0;
+}
+
+static int __devinit snd_als300_probe(struct pci_dev *pci,
+                             const struct pci_device_id *pci_id)
+{
+ static int dev;
+ snd_card_t *card;
+ als300_t *chip;
+ int err, chip_type;
+
+ if (dev >=3D SNDRV_CARDS)
+  return -ENODEV;
+ if (!enable[dev]) {
+  dev++;
+  return -ENOENT;
+ }
+
+ card =3D snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+
+ if (card =3D=3D NULL)
+  return -ENOMEM;
+
+ chip_type =3D pci_id->driver_data;
+
+ if ((err =3D snd_als300_create(card, pci, chip_type, &chip)) < 0) {
+  snd_card_free(card);
+  return err;
+ }
+
+ strcpy(card->driver, "ALS300");
+ if (chip->chip_type =3D=3D DEVICE_ALS300_PLUS)
+  /* don't know much about ALS300+ yet, print revision number for now */
+  sprintf(card->shortname, "ALS300+ (Rev. %d)", chip->revision);
+ else
+  sprintf(card->shortname, "ALS300 (Rev. %c)", 'A' + chip->revision - 1);
+ sprintf(card->longname, "%s at 0x%lx irq %i",
+    card->shortname, chip->port, chip->irq);
+
+ if ((err =3D snd_card_register(card)) < 0)
+ {
+  snd_card_free(card);
+  return err;
+ }
+ pci_set_drvdata(pci, card);
+ dev++;
+ return 0;
+}
+
+static struct pci_driver driver =3D {
+ .name =3D "ALS300",
+ .id_table =3D snd_als300_ids,
+ .probe =3D snd_als300_probe,
+ .remove =3D __devexit_p(snd_als300_remove),
+};
+
+static int __init alsa_card_als300_init(void)
+{
+ return pci_module_init(&driver);
+}
+
+static void __exit alsa_card_als300_exit(void)
+{
+ pci_unregister_driver(&driver);
+}
+
+module_init(alsa_card_als300_init)
+module_exit(alsa_card_als300_exit)
+


--=20
___________________________________________________
Play 100s of games for FREE! http://games.mail.com/



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
