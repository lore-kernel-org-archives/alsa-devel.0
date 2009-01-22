From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] Turtle Beach Multisound Classic/Pinnacle
	driver (2nd rev)
Date: Thu, 22 Jan 2009 10:32:08 +0100
Message-ID: <20090122103208.b86be6ab.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 39EB4103880
	for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2009 10:29:14 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This is driver for Turtle Beach Multisound cards:
Classic, Fiji and Pinnacle.

Tested pcm playback and recording and MIDI playback
on Multisound Pinnacle.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
The list of improvements since the previously posted driver:

- CS clean up
- fixed 8-bit sample audio playback and recording
- fixed recording formats
- correctly request shared memory region
- ioremap memory region once instead before each access
- single module per driver/removed common module
- reduced midi code as it was copied from mpu401 driver
  and is redundant now
- various clean ups and code reductions

Not tested:
1. Classic card (no hardware)
2. Classic card PnP detection (tested only on the Pinnacle) (no hardware)
3. Digital input/output
4. External MIDI input/output

I would be grateful for testing and reporting any of these.

Best regards,
Krzysztof

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 660beb4..2d6ce32 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -411,5 +411,36 @@ config SND_WAVEFRONT_FIRMWARE_IN_KERNEL
 	  you need to install the firmware files from the
 	  alsa-firmware package.
 
+config SND_MSND_PINNACLE
+	tristate "Turtle Beach MultiSound Pinnacle/Fiji driver"
+	depends on X86
+	select FW_LOADER
+	select SND_MPU401_UART
+	select SND_PCM
+	help
+	  Say Y to include support for Turtle Beach MultiSound Pinnacle/
+	  Fiji soundcards.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-msnd-pinnacle.
+
+config SND_MSND_CLASSIC
+	tristate "Support for Turtle Beach MultiSound Classic, Tahiti, Monterey"
+	depends on X86
+	select FW_LOADER
+	select SND_MPU401_UART
+	select SND_PCM
+	help
+	  Say M here if you have a Turtle Beach MultiSound Classic, Tahiti or
+	  Monterey (not for the Pinnacle or Fiji).
+
+	  See <file:Documentation/sound/oss/MultiSound> for important information
+	  about this driver.  Note that it has been discontinued, but the
+	  Voyetra Turtle Beach knowledge base entry for it is still available
+	  at <http://www.turtlebeach.com/site/kb_ftp/790.asp>.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-msnd-classic.
+
 endif	# SND_ISA
 
diff --git a/sound/isa/Makefile b/sound/isa/Makefile
index 63af13d..beb96ec 100644
--- a/sound/isa/Makefile
+++ b/sound/isa/Makefile
@@ -26,5 +26,5 @@ obj-$(CONFIG_SND_SC6000) += snd-sc6000.o
 obj-$(CONFIG_SND_SGALAXY) += snd-sgalaxy.o
 obj-$(CONFIG_SND_SSCAPE) += snd-sscape.o
 
-obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ gus/ opti9xx/ \
-		     sb/ wavefront/ wss/
+obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ gus/ msnd/ \
+		     opti9xx/ sb/ wavefront/ wss/
diff --git a/sound/isa/msnd/Makefile b/sound/isa/msnd/Makefile
new file mode 100644
index 0000000..41f278f
--- /dev/null
+++ b/sound/isa/msnd/Makefile
@@ -0,0 +1,10 @@
+
+snd-msnd-pinnacle-objs := msnd_pinnacle.o msnd_pinnacle_mixer.o \
+			  msnd.o msnd_midi.o
+snd-msnd-classic-objs := msnd_classic.o msnd_pinnacle_mixer.o \
+			 msnd.o msnd_midi.o
+
+# Toplevel Module Dependency
+obj-$(CONFIG_SND_MSND_PINNACLE) += snd-msnd-pinnacle.o
+obj-$(CONFIG_SND_MSND_CLASSIC) += snd-msnd-classic.o
+
diff --git a/sound/isa/msnd/msnd.c b/sound/isa/msnd/msnd.c
new file mode 100644
index 0000000..5326834
--- /dev/null
+++ b/sound/isa/msnd/msnd.c
@@ -0,0 +1,192 @@
+/*********************************************************************
+ *
+ * 2002/06/30 Karsten Wiese:
+ *	removed kernel-version dependencies.
+ *	ripped from linux kernel 2.4.18 (OSS Implementation) by me.
+ *	In the OSS Version, this file is compiled to a separate MODULE,
+ *	that is used by the pinnacle and the classic driver.
+ *	since there is no classic driver for alsa yet (i dont have a classic
+ *	& writing one blindfold is difficult) this file's object is statically
+ *	linked into the pinnacle-driver-module for now.	look for the string
+ *		"uncomment this to make this a module again"
+ *	to do guess what.
+ *
+ * the following is a copy of the 2.4.18 OSS FREE file-heading comment:
+ *
+ * msnd.c - Driver Base
+ *
+ * Turtle Beach MultiSound Sound Card Driver for Linux
+ *
+ * Copyright (C) 1998 Andrew Veliath
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ ********************************************************************/
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include "msnd.h"
+
+#define LOGNAME			"msnd"
+
+
+void snd_msnd_init_queue(void *base, int start, int size)
+{
+	writew(PCTODSP_BASED(start), base + JQS_wStart);
+	writew(PCTODSP_OFFSET(size) - 1, base + JQS_wSize);
+	writew(0, base + JQS_wHead);
+	writew(0, base + JQS_wTail);
+}
+
+static int snd_msnd_wait_TXDE(struct snd_msnd *dev)
+{
+	unsigned int io = dev->io;
+	int timeout = 1000;
+
+	while (timeout-- > 0)
+		if (inb(io + HP_ISR) & HPISR_TXDE)
+			return 0;
+
+	return -EIO;
+}
+
+static int snd_msnd_wait_HC0(struct snd_msnd *dev)
+{
+	unsigned int io = dev->io;
+	int timeout = 1000;
+
+	while (timeout-- > 0)
+		if (!(inb(io + HP_CVR) & HPCVR_HC))
+			return 0;
+
+	return -EIO;
+}
+
+int snd_msnd_send_dsp_cmd(struct snd_msnd *dev, u8 cmd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (snd_msnd_wait_HC0(dev) == 0) {
+		outb(cmd, dev->io + HP_CVR);
+		spin_unlock_irqrestore(&dev->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	snd_printd(LOGNAME ": Send DSP command timeout\n");
+
+	return -EIO;
+}
+
+int snd_msnd_send_word(struct snd_msnd *dev, unsigned char high,
+		   unsigned char mid, unsigned char low)
+{
+	unsigned int io = dev->io;
+
+	if (snd_msnd_wait_TXDE(dev) == 0) {
+		outb(high, io + HP_TXH);
+		outb(mid, io + HP_TXM);
+		outb(low, io + HP_TXL);
+		return 0;
+	}
+
+	snd_printd(LOGNAME ": Send host word timeout\n");
+
+	return -EIO;
+}
+
+int snd_msnd_upload_host(struct snd_msnd *dev, const u8 *bin, int len)
+{
+	int i;
+
+	if (len % 3 != 0) {
+		snd_printk(LOGNAME ": Upload host data not multiple of 3!\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < len; i += 3)
+		if (snd_msnd_send_word(dev, bin[i], bin[i + 1], bin[i + 2]))
+			return -EIO;
+
+	inb(dev->io + HP_RXL);
+	inb(dev->io + HP_CVR);
+
+	return 0;
+}
+
+int snd_msnd_enable_irq(struct snd_msnd *dev)
+{
+	unsigned long flags;
+
+	if (dev->irq_ref++)
+		return 0;
+
+	snd_printd(LOGNAME ": Enabling IRQ\n");
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (snd_msnd_wait_TXDE(dev) == 0) {
+		outb(inb(dev->io + HP_ICR) | HPICR_TREQ, dev->io + HP_ICR);
+		if (dev->type == msndClassic)
+			outb(dev->irqid, dev->io + HP_IRQM);
+
+		outb(inb(dev->io + HP_ICR) & ~HPICR_TREQ, dev->io + HP_ICR);
+		outb(inb(dev->io + HP_ICR) | HPICR_RREQ, dev->io + HP_ICR);
+		enable_irq(dev->irq);
+		snd_msnd_init_queue(dev->DSPQ, dev->dspq_data_buff,
+				    dev->dspq_buff_size);
+		spin_unlock_irqrestore(&dev->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	snd_printd(LOGNAME ": Enable IRQ failed\n");
+
+	return -EIO;
+}
+
+int snd_msnd_disable_irq(struct snd_msnd *dev)
+{
+	unsigned long flags;
+
+	if (--dev->irq_ref > 0)
+		return 0;
+
+	if (dev->irq_ref < 0)
+		snd_printd(LOGNAME ": IRQ ref count is %d\n", dev->irq_ref);
+
+	snd_printd(LOGNAME ": Disabling IRQ\n");
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (snd_msnd_wait_TXDE(dev) == 0) {
+		outb(inb(dev->io + HP_ICR) & ~HPICR_RREQ, dev->io + HP_ICR);
+		if (dev->type == msndClassic)
+			outb(HPIRQ_NONE, dev->io + HP_IRQM);
+		disable_irq(dev->irq);
+		spin_unlock_irqrestore(&dev->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	snd_printd(LOGNAME ": Disable IRQ failed\n");
+
+	return -EIO;
+}
+
diff --git a/sound/isa/msnd/msnd.h b/sound/isa/msnd/msnd.h
new file mode 100644
index 0000000..018b672
--- /dev/null
+++ b/sound/isa/msnd/msnd.h
@@ -0,0 +1,293 @@
+/*********************************************************************
+ *
+ * msnd.h
+ *
+ * Turtle Beach MultiSound Sound Card Driver for Linux
+ *
+ * Some parts of this header file were derived from the Turtle Beach
+ * MultiSound Driver Development Kit.
+ *
+ * Copyright (C) 1998 Andrew Veliath
+ * Copyright (C) 1993 Turtle Beach Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ ********************************************************************/
+#ifndef __MSND_H
+#define __MSND_H
+
+#define DEFSAMPLERATE		44100
+#define DEFSAMPLESIZE		SNDRV_PCM_FORMAT_S16
+#define DEFCHANNELS		1
+
+#define SRAM_BANK_SIZE		0x8000
+#define SRAM_CNTL_START		0x7F00
+#define SMA_STRUCT_START	0x7F40
+
+#define DSP_BASE_ADDR		0x4000
+#define DSP_BANK_BASE		0x4000
+
+#define AGND			0x01
+#define SIGNAL			0x02
+
+#define EXT_DSP_BIT_DCAL	0x0001
+#define EXT_DSP_BIT_MIDI_CON	0x0002
+
+#define BUFFSIZE		0x8000
+#define HOSTQ_SIZE		0x40
+
+#define DAP_BUFF_SIZE		0x2400
+
+#define DAPQ_STRUCT_SIZE	0x10
+#define DARQ_STRUCT_SIZE	0x10
+#define DAPQ_BUFF_SIZE		(3 * 0x10)
+#define DARQ_BUFF_SIZE		(3 * 0x10)
+#define MODQ_BUFF_SIZE		0x400
+
+#define DAPQ_DATA_BUFF		0x6C00
+#define DARQ_DATA_BUFF		0x6C30
+#define MODQ_DATA_BUFF		0x6C60
+#define MIDQ_DATA_BUFF		0x7060
+
+#define DAPQ_OFFSET		SRAM_CNTL_START
+#define DARQ_OFFSET		(SRAM_CNTL_START + 0x08)
+#define MODQ_OFFSET		(SRAM_CNTL_START + 0x10)
+#define MIDQ_OFFSET		(SRAM_CNTL_START + 0x18)
+#define DSPQ_OFFSET		(SRAM_CNTL_START + 0x20)
+
+#define	HP_ICR			0x00
+#define	HP_CVR			0x01
+#define	HP_ISR			0x02
+#define	HP_IVR			0x03
+#define HP_NU			0x04
+#define HP_INFO			0x04
+#define	HP_TXH			0x05
+#define	HP_RXH			0x05
+#define	HP_TXM			0x06
+#define	HP_RXM			0x06
+#define	HP_TXL			0x07
+#define	HP_RXL			0x07
+
+#define HP_ICR_DEF		0x00
+#define HP_CVR_DEF		0x12
+#define HP_ISR_DEF		0x06
+#define HP_IVR_DEF		0x0f
+#define HP_NU_DEF		0x00
+
+#define	HP_IRQM			0x09
+
+#define	HPR_BLRC		0x08
+#define	HPR_SPR1		0x09
+#define	HPR_SPR2		0x0A
+#define	HPR_TCL0		0x0B
+#define	HPR_TCL1		0x0C
+#define	HPR_TCL2		0x0D
+#define	HPR_TCL3		0x0E
+#define	HPR_TCL4		0x0F
+
+#define	HPICR_INIT		0x80
+#define HPICR_HM1		0x40
+#define HPICR_HM0		0x20
+#define HPICR_HF1		0x10
+#define HPICR_HF0		0x08
+#define	HPICR_TREQ		0x02
+#define	HPICR_RREQ		0x01
+
+#define HPCVR_HC		0x80
+
+#define	HPISR_HREQ		0x80
+#define HPISR_DMA		0x40
+#define HPISR_HF3		0x10
+#define HPISR_HF2		0x08
+#define	HPISR_TRDY		0x04
+#define	HPISR_TXDE		0x02
+#define	HPISR_RXDF		0x01
+
+#define	HPIO_290		0
+#define	HPIO_260		1
+#define	HPIO_250		2
+#define	HPIO_240		3
+#define	HPIO_230		4
+#define	HPIO_220		5
+#define	HPIO_210		6
+#define	HPIO_3E0		7
+
+#define	HPMEM_NONE		0
+#define	HPMEM_B000		1
+#define	HPMEM_C800		2
+#define	HPMEM_D000		3
+#define	HPMEM_D400		4
+#define	HPMEM_D800		5
+#define	HPMEM_E000		6
+#define	HPMEM_E800		7
+
+#define	HPIRQ_NONE		0
+#define HPIRQ_5			1
+#define HPIRQ_7			2
+#define HPIRQ_9			3
+#define HPIRQ_10		4
+#define HPIRQ_11		5
+#define HPIRQ_12		6
+#define HPIRQ_15		7
+
+#define	HIMT_PLAY_DONE		0x00
+#define	HIMT_RECORD_DONE	0x01
+#define	HIMT_MIDI_EOS		0x02
+#define	HIMT_MIDI_OUT		0x03
+
+#define	HIMT_MIDI_IN_UCHAR	0x0E
+#define	HIMT_DSP		0x0F
+
+#define	HDEX_BASE	       	0x92
+#define	HDEX_PLAY_START		(0 + HDEX_BASE)
+#define	HDEX_PLAY_STOP		(1 + HDEX_BASE)
+#define	HDEX_PLAY_PAUSE		(2 + HDEX_BASE)
+#define	HDEX_PLAY_RESUME	(3 + HDEX_BASE)
+#define	HDEX_RECORD_START	(4 + HDEX_BASE)
+#define	HDEX_RECORD_STOP	(5 + HDEX_BASE)
+#define	HDEX_MIDI_IN_START 	(6 + HDEX_BASE)
+#define	HDEX_MIDI_IN_STOP	(7 + HDEX_BASE)
+#define	HDEX_MIDI_OUT_START	(8 + HDEX_BASE)
+#define	HDEX_MIDI_OUT_STOP	(9 + HDEX_BASE)
+#define	HDEX_AUX_REQ		(10 + HDEX_BASE)
+
+#define HIWORD(l)		((u16)((((u32)(l)) >> 16) & 0xFFFF))
+#define LOWORD(l)		((u16)(u32)(l))
+#define HIBYTE(w)		((u8)(((u16)(w) >> 8) & 0xFF))
+#define LOBYTE(w)		((u8)(w))
+#define MAKELONG(low, hi)	((long)(((u16)(low))|(((u32)((u16)(hi)))<<16)))
+#define MAKEWORD(low, hi)	((u16)(((u8)(low))|(((u16)((u8)(hi)))<<8)))
+
+#define PCTODSP_OFFSET(w)	(u16)((w)/2)
+#define PCTODSP_BASED(w)	(u16)(((w)/2) + DSP_BASE_ADDR)
+#define DSPTOPC_BASED(w)	(((w) - DSP_BASE_ADDR) * 2)
+
+#ifdef SLOWIO
+#  undef outb
+#  undef inb
+#  define outb			outb_p
+#  define inb			inb_p
+#endif
+
+/* JobQueueStruct */
+#define JQS_wStart		0x00
+#define JQS_wSize		0x02
+#define JQS_wHead		0x04
+#define JQS_wTail		0x06
+#define JQS__size		0x08
+
+/* DAQueueDataStruct */
+#define DAQDS_wStart		0x00
+#define DAQDS_wSize		0x02
+#define DAQDS_wFormat		0x04
+#define DAQDS_wSampleSize	0x06
+#define DAQDS_wChannels		0x08
+#define DAQDS_wSampleRate	0x0A
+#define DAQDS_wIntMsg		0x0C
+#define DAQDS_wFlags		0x0E
+#define DAQDS__size		0x10
+
+/* Generic FIFO * /
+typedef struct {
+	size_t n, len;
+	char *data;
+	int head, tail;
+} msnd_fifo;  */
+
+
+
+struct snd_msnd {
+	void			*mappedbase;
+	int			play_period_bytes;
+	int			playLimit;
+	int			playPeriods;
+	int 			playDMAPos;
+	int			banksPlayed;
+	int 			captureDMAPos;
+	int			capturePeriodBytes;
+	int			captureLimit;
+	int			capturePeriods;
+	struct snd_card		*card;
+	void			*msndmidi_mpu;
+	struct snd_rawmidi	*rmidi;
+
+	/* Hardware resources */
+	long io;
+	int memid, irqid;
+	int irq, irq_ref;
+	unsigned long base;
+
+	/* Motorola 56k DSP SMA */
+	void		*SMA;
+	void		*DAPQ;
+	void		*DARQ;
+	void		*MODQ;
+	void		*MIDQ;
+	void		*DSPQ;
+	int dspq_data_buff, dspq_buff_size;
+
+	/* State variables */
+	enum { msndClassic, msndPinnacle } type;
+	mode_t mode;
+	unsigned long flags;
+#define F_RESETTING			0
+#define F_HAVEDIGITAL			1
+#define F_AUDIO_WRITE_INUSE		2
+#define F_WRITING			3
+#define F_WRITEBLOCK			4
+#define F_WRITEFLUSH			5
+#define F_AUDIO_READ_INUSE		6
+#define F_READING			7
+#define F_READBLOCK			8
+#define F_EXT_MIDI_INUSE		9
+#define F_HDR_MIDI_INUSE		10
+#define F_DISABLE_WRITE_NDELAY		11
+	spinlock_t lock;
+	spinlock_t mixer_lock;
+	int nresets;
+	unsigned recsrc;
+#define LEVEL_ENTRIES 32
+	int left_levels[LEVEL_ENTRIES];
+	int right_levels[LEVEL_ENTRIES];
+	int calibrate_signal;
+	int play_sample_size, play_sample_rate, play_channels;
+	int play_ndelay;
+	int capture_sample_size, capture_sample_rate, capture_channels;
+	int capture_ndelay;
+	u8 bCurrentMidiPatch;
+
+	int last_playbank, last_recbank;
+	struct snd_pcm_substream *playback_substream;
+	struct snd_pcm_substream *capture_substream;
+
+};
+
+void snd_msnd_init_queue(void *base, int start, int size);
+
+int snd_msnd_send_dsp_cmd(struct snd_msnd *chip, u8 cmd);
+int snd_msnd_send_word(struct snd_msnd *chip,
+			   unsigned char high,
+			   unsigned char mid,
+			   unsigned char low);
+int snd_msnd_upload_host(struct snd_msnd *chip,
+			     const u8 *bin, int len);
+int snd_msnd_enable_irq(struct snd_msnd *chip);
+int snd_msnd_disable_irq(struct snd_msnd *chip);
+
+
+int snd_msndmidi_new(struct snd_card *card, int device);
+void snd_msndmidi_input_read(void *mpu);
+
+#endif /* __MSND_H */
diff --git a/sound/isa/msnd/msnd_classic.c b/sound/isa/msnd/msnd_classic.c
new file mode 100644
index 0000000..3b23a09
--- /dev/null
+++ b/sound/isa/msnd/msnd_classic.c
@@ -0,0 +1,3 @@
+/* The work is in msnd_pinnacle.c, just define MSND_CLASSIC before it. */
+#define MSND_CLASSIC
+#include "msnd_pinnacle.c"
diff --git a/sound/isa/msnd/msnd_classic.h b/sound/isa/msnd/msnd_classic.h
new file mode 100644
index 0000000..48cce62
--- /dev/null
+++ b/sound/isa/msnd/msnd_classic.h
@@ -0,0 +1,159 @@
+/*********************************************************************
+ *
+ * msnd_classic.h
+ *
+ * Turtle Beach MultiSound Sound Card Driver for Linux
+ *
+ * Some parts of this header file were derived from the Turtle Beach
+ * MultiSound Driver Development Kit.
+ *
+ * Copyright (C) 1998 Andrew Veliath
+ * Copyright (C) 1993 Turtle Beach Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ ********************************************************************/
+#ifndef __MSND_CLASSIC_H
+#define __MSND_CLASSIC_H
+
+#define DSP_NUMIO				0x10
+
+#define	HP_MEMM					0x08
+
+#define	HP_BITM					0x0E
+#define	HP_WAIT					0x0D
+#define	HP_DSPR					0x0A
+#define	HP_PROR					0x0B
+#define	HP_BLKS					0x0C
+
+#define	HPPRORESET_OFF				0
+#define HPPRORESET_ON				1
+
+#define HPDSPRESET_OFF				0
+#define HPDSPRESET_ON				1
+
+#define HPBLKSEL_0				0
+#define HPBLKSEL_1				1
+
+#define HPWAITSTATE_0				0
+#define HPWAITSTATE_1				1
+
+#define HPBITMODE_16				0
+#define HPBITMODE_8				1
+
+#define	HIDSP_INT_PLAY_UNDER			0x00
+#define	HIDSP_INT_RECORD_OVER			0x01
+#define	HIDSP_INPUT_CLIPPING			0x02
+#define	HIDSP_MIDI_IN_OVER			0x10
+#define	HIDSP_MIDI_OVERRUN_ERR  0x13
+
+#define	HDEXAR_CLEAR_PEAKS			1
+#define	HDEXAR_IN_SET_POTS			2
+#define	HDEXAR_AUX_SET_POTS			3
+#define	HDEXAR_CAL_A_TO_D			4
+#define	HDEXAR_RD_EXT_DSP_BITS			5
+
+#define TIME_PRO_RESET_DONE			0x028A
+#define TIME_PRO_SYSEX				0x0040
+#define TIME_PRO_RESET				0x0032
+
+#define DAR_BUFF_SIZE				0x2000
+
+#define MIDQ_BUFF_SIZE				0x200
+#define DSPQ_BUFF_SIZE				0x40
+
+#define DSPQ_DATA_BUFF				0x7260
+
+#define MOP_SYNTH				0x10
+#define MOP_EXTOUT				0x32
+#define MOP_EXTTHRU				0x02
+#define MOP_OUTMASK				0x01
+
+#define MIP_EXTIN				0x01
+#define MIP_SYNTH				0x00
+#define MIP_INMASK				0x32
+
+/* Classic SMA Common Data */
+#define SMA_wCurrPlayBytes			0x0000
+#define SMA_wCurrRecordBytes			0x0002
+#define SMA_wCurrPlayVolLeft			0x0004
+#define SMA_wCurrPlayVolRight			0x0006
+#define SMA_wCurrInVolLeft			0x0008
+#define SMA_wCurrInVolRight			0x000a
+#define SMA_wUser_3				0x000c
+#define SMA_wUser_4				0x000e
+#define SMA_dwUser_5				0x0010
+#define SMA_dwUser_6				0x0014
+#define SMA_wUser_7				0x0018
+#define SMA_wReserved_A				0x001a
+#define SMA_wReserved_B				0x001c
+#define SMA_wReserved_C				0x001e
+#define SMA_wReserved_D				0x0020
+#define SMA_wReserved_E				0x0022
+#define SMA_wReserved_F				0x0024
+#define SMA_wReserved_G				0x0026
+#define SMA_wReserved_H				0x0028
+#define SMA_wCurrDSPStatusFlags			0x002a
+#define SMA_wCurrHostStatusFlags		0x002c
+#define SMA_wCurrInputTagBits			0x002e
+#define SMA_wCurrLeftPeak			0x0030
+#define SMA_wCurrRightPeak			0x0032
+#define SMA_wExtDSPbits				0x0034
+#define SMA_bExtHostbits			0x0036
+#define SMA_bBoardLevel				0x0037
+#define SMA_bInPotPosRight			0x0038
+#define SMA_bInPotPosLeft			0x0039
+#define SMA_bAuxPotPosRight			0x003a
+#define SMA_bAuxPotPosLeft			0x003b
+#define SMA_wCurrMastVolLeft			0x003c
+#define SMA_wCurrMastVolRight			0x003e
+#define SMA_bUser_12				0x0040
+#define SMA_bUser_13				0x0041
+#define SMA_wUser_14				0x0042
+#define SMA_wUser_15				0x0044
+#define SMA_wCalFreqAtoD			0x0046
+#define SMA_wUser_16				0x0048
+#define SMA_wUser_17				0x004a
+#define SMA__size				0x004c
+
+#ifdef HAVE_DSPCODEH
+#  include "msndperm.c"
+#  include "msndinit.c"
+#  define PERMCODE		msndperm
+#  define INITCODE		msndinit
+#  define PERMCODESIZE		sizeof(msndperm)
+#  define INITCODESIZE		sizeof(msndinit)
+#else
+#  ifndef CONFIG_MSNDCLAS_INIT_FILE
+#    define CONFIG_MSNDCLAS_INIT_FILE "turtlebeach/msndinit.bin"
+#  endif
+#  ifndef CONFIG_MSNDCLAS_PERM_FILE
+#    define CONFIG_MSNDCLAS_PERM_FILE "turtlebeach/msndperm.bin"
+#  endif
+#  define PERMCODEFILE		CONFIG_MSNDCLAS_PERM_FILE
+#  define INITCODEFILE		CONFIG_MSNDCLAS_INIT_FILE
+#  define PERMCODE		dspini
+#  define INITCODE		permini
+#  define PERMCODESIZE		sizeof_dspini
+#  define INITCODESIZE		sizeof_permini
+#endif
+#define LONGNAME		"MultiSound (Classic/Monterey/Tahiti)"
+
+/* functions from external mixer file */
+void snd_msndmix_setup(struct snd_msnd *chip);
+unsigned long snd_msndmix_force_recsrc(struct snd_msnd *chip, int recsrc);
+int __devinit snd_msndmix_new(struct snd_card *card);
+
+#endif /* __MSND_CLASSIC_H */
diff --git a/sound/isa/msnd/msnd_midi.c b/sound/isa/msnd/msnd_midi.c
new file mode 100644
index 0000000..5f633c1
--- /dev/null
+++ b/sound/isa/msnd/msnd_midi.c
@@ -0,0 +1,178 @@
+/*
+ *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
+ *  Routines for control of MPU-401 in UART mode
+ *
+ *  MPU-401 supports UART mode which is not capable generate transmit
+ *  interrupts thus output is done via polling. Also, if irq < 0, then
+ *  input is done also via polling. Do not expect good performance.
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <sound/core.h>
+#include <sound/rawmidi.h>
+
+#include "msnd.h"
+
+#define MSNDMIDI_MODE_BIT_INPUT		0
+#define MSNDMIDI_MODE_BIT_OUTPUT		1
+#define MSNDMIDI_MODE_BIT_INPUT_TRIGGER	2
+#define MSNDMIDI_MODE_BIT_OUTPUT_TRIGGER	3
+
+struct snd_msndmidi {
+	struct snd_msnd *dev;
+
+	unsigned long mode;		/* MSNDMIDI_MODE_XXXX */
+
+	struct snd_rawmidi_substream *substream_input;
+
+	spinlock_t input_lock;
+};
+
+/*
+ * input/output open/close - protected by open_mutex in rawmidi.c
+ */
+static int snd_msndmidi_input_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_msndmidi *mpu;
+
+	snd_printdd("snd_msndmidi_input_open()\n");
+
+	mpu = substream->rmidi->private_data;
+
+	mpu->substream_input = substream;
+
+	snd_msnd_enable_irq(mpu->dev);
+
+	snd_msnd_send_dsp_cmd(mpu->dev, HDEX_MIDI_IN_START);
+	set_bit(MSNDMIDI_MODE_BIT_INPUT, &mpu->mode);
+	return 0;
+}
+
+static int snd_msndmidi_input_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_msndmidi *mpu;
+
+	mpu = substream->rmidi->private_data;
+	snd_msnd_send_dsp_cmd(mpu->dev, HDEX_MIDI_IN_STOP);
+	clear_bit(MSNDMIDI_MODE_BIT_INPUT, &mpu->mode);
+	mpu->substream_input = NULL;
+	snd_msnd_disable_irq(mpu->dev);
+	return 0;
+}
+
+static void snd_msndmidi_input_drop(struct snd_msndmidi *mpu)
+{
+	u16 tail;
+
+	tail = readw(mpu->dev->MIDQ + JQS_wTail);
+	writew(tail, mpu->dev->MIDQ + JQS_wHead);
+}
+
+/*
+ * trigger input
+ */
+static void snd_msndmidi_input_trigger(struct snd_rawmidi_substream *substream,
+					int up)
+{
+	unsigned long flags;
+	struct snd_msndmidi *mpu;
+
+	snd_printdd("snd_msndmidi_input_trigger(, %i)\n", up);
+
+	mpu = substream->rmidi->private_data;
+	spin_lock_irqsave(&mpu->input_lock, flags);
+	if (up) {
+		if (!test_and_set_bit(MSNDMIDI_MODE_BIT_INPUT_TRIGGER,
+				      &mpu->mode))
+			snd_msndmidi_input_drop(mpu);
+	} else {
+		clear_bit(MSNDMIDI_MODE_BIT_INPUT_TRIGGER, &mpu->mode);
+	}
+	spin_unlock_irqrestore(&mpu->input_lock, flags);
+	if (up)
+		snd_msndmidi_input_read(mpu);
+}
+
+void snd_msndmidi_input_read(void *mpuv)
+{
+	unsigned long flags;
+	struct snd_msndmidi *mpu = mpuv;
+	void *pwMIDQData = mpu->dev->mappedbase + MIDQ_DATA_BUFF;
+
+	spin_lock_irqsave(&mpu->input_lock, flags);
+	while (readw(mpu->dev->MIDQ + JQS_wTail) !=
+	       readw(mpu->dev->MIDQ + JQS_wHead)) {
+		u16 wTmp, val;
+		val = readw(pwMIDQData + 2 * readw(mpu->dev->MIDQ + JQS_wHead));
+
+			if (test_bit(MSNDMIDI_MODE_BIT_INPUT_TRIGGER,
+				     &mpu->mode))
+				snd_rawmidi_receive(mpu->substream_input,
+						    (unsigned char *)&val, 1);
+
+		wTmp = readw(mpu->dev->MIDQ + JQS_wHead) + 1;
+		if (wTmp > readw(mpu->dev->MIDQ + JQS_wSize))
+			writew(0,  mpu->dev->MIDQ + JQS_wHead);
+		else
+			writew(wTmp,  mpu->dev->MIDQ + JQS_wHead);
+	}
+	spin_unlock_irqrestore(&mpu->input_lock, flags);
+}
+
+static struct snd_rawmidi_ops snd_msndmidi_input = {
+	.open =		snd_msndmidi_input_open,
+	.close =	snd_msndmidi_input_close,
+	.trigger =	snd_msndmidi_input_trigger,
+};
+
+static void snd_msndmidi_free(struct snd_rawmidi *rmidi)
+{
+	struct snd_msndmidi *mpu = rmidi->private_data;
+	kfree(mpu);
+}
+
+int snd_msndmidi_new(struct snd_card *card, int device)
+{
+	struct snd_msnd *chip = card->private_data;
+	struct snd_msndmidi *mpu;
+	struct snd_rawmidi *rmidi;
+	int err;
+
+	err = snd_rawmidi_new(card, "MSND-MIDI", device, 1, 1, &rmidi);
+	if (err < 0)
+		return err;
+	mpu = kcalloc(1, sizeof(*mpu), GFP_KERNEL);
+	if (mpu == NULL) {
+		snd_device_free(card, rmidi);
+		return -ENOMEM;
+	}
+	mpu->dev = chip;
+	chip->msndmidi_mpu = mpu;
+	rmidi->private_data = mpu;
+	rmidi->private_free = snd_msndmidi_free;
+	spin_lock_init(&mpu->input_lock);
+	strcpy(rmidi->name, "MSND MIDI");
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+			    &snd_msndmidi_input);
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+	return 0;
+}
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
new file mode 100644
index 0000000..788b1ad
--- /dev/null
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -0,0 +1,1787 @@
+/*********************************************************************
+ *
+ * Linux multisound pinnacle/fiji driver for ALSA.
+ *
+ * 2002/06/30 Karsten Wiese:
+ *	for now this is only used to build a pinnacle / fiji driver.
+ *	the OSS parent of this code is designed to also support
+ *	the multisound classic via the file msnd_classic.c.
+ *	to make it easier for some brave heart to implemt classic
+ *	support in alsa, i left all the MSND_CLASSIC tokens in this file.
+ *	but for now this untested & undone.
+ *
+ *
+ * ripped from linux kernel 2.4.18 by Karsten Wiese.
+ *
+ * the following is a copy of the 2.4.18 OSS FREE file-heading comment:
+ *
+ * Turtle Beach MultiSound Sound Card Driver for Linux
+ * msnd_pinnacle.c / msnd_classic.c
+ *
+ * -- If MSND_CLASSIC is defined:
+ *
+ *     -> driver for Turtle Beach Classic/Monterey/Tahiti
+ *
+ * -- Else
+ *
+ *     -> driver for Turtle Beach Pinnacle/Fiji
+ *
+ * 12-3-2000  Modified IO port validation  Steve Sycamore
+ *
+ * Copyright (C) 1998 Andrew Veliath
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ ********************************************************************/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/firmware.h>
+#include <linux/isa.h>
+#include <linux/isapnp.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/asound.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/mpu401.h>
+
+#ifdef MSND_CLASSIC
+# ifndef __alpha__
+#  define SLOWIO
+# endif
+#endif
+#include "msnd.h"
+#ifdef MSND_CLASSIC
+#  include "msnd_classic.h"
+#  define LOGNAME			"msnd_classic"
+#else
+#  include "msnd_pinnacle.h"
+#  define LOGNAME			"snd_msnd_pinnacle"
+#endif
+
+#ifdef CONFIG_MSNDCLAS_HAVE_BOOT
+#  define HAVE_DSPCODEH
+#endif
+
+static inline long get_play_delay_jiffies(struct snd_msnd *chip, long size)
+{
+	long tmp = (size * HZ * chip->play_sample_size) / 8;
+	return tmp / (chip->play_sample_rate * chip->play_channels);
+}
+
+static inline long get_rec_delay_jiffies(struct snd_msnd *chip, long size)
+{
+	long tmp = (size * HZ * chip->capture_sample_size) / 8;
+	return tmp / (chip->capture_sample_rate * chip->capture_channels);
+}
+
+#ifndef HAVE_DSPCODEH
+static const u8			*dspini, *permini;
+static int			sizeof_dspini, sizeof_permini;
+#endif
+
+static int snd_msnd_dsp_full_reset(struct snd_card *card);
+
+int snd_msnd_send_dsp_cmd_chk(struct snd_msnd *chip, u8 cmd)
+{
+	if (snd_msnd_send_dsp_cmd(chip, cmd) == 0)
+		return 0;
+	snd_msnd_dsp_full_reset(chip->card);
+	return snd_msnd_send_dsp_cmd(chip, cmd);
+}
+
+static void snd_msnd_play_reset_queue(struct snd_msnd *chip,
+				      unsigned int pcm_periods,
+				      unsigned int pcm_count)
+{
+	int	n;
+	void	*pDAQ = chip->mappedbase + DAPQ_DATA_BUFF;
+
+	chip->last_playbank = -1;
+	chip->playLimit = pcm_count * (pcm_periods - 1);
+	chip->playPeriods = pcm_periods;
+	writew(PCTODSP_OFFSET(0 * DAQDS__size), chip->DAPQ + JQS_wHead);
+	writew(PCTODSP_OFFSET(0 * DAQDS__size), chip->DAPQ + JQS_wTail);
+
+	chip->play_period_bytes = pcm_count;
+
+	for (n = 0; n < pcm_periods; ++n, pDAQ += DAQDS__size) {
+		writew(PCTODSP_BASED((u32)(pcm_count * (n % pcm_periods))),
+			pDAQ + DAQDS_wStart);
+		writew(0, pDAQ + DAQDS_wSize);
+		writew(1, pDAQ + DAQDS_wFormat);
+		writew(chip->play_sample_size, pDAQ + DAQDS_wSampleSize);
+		writew(chip->play_channels, pDAQ + DAQDS_wChannels);
+		writew(chip->play_sample_rate, pDAQ + DAQDS_wSampleRate);
+		writew(HIMT_PLAY_DONE * 0x100 + n, pDAQ + DAQDS_wIntMsg);
+		writew(n, pDAQ + DAQDS_wFlags);
+	}
+}
+
+static void snd_msnd_capture_reset_queue(struct snd_msnd *chip,
+					 unsigned int pcm_periods,
+					 unsigned int pcm_count)
+{
+	int		n;
+	void		*pDAQ;
+	/* unsigned long	flags; */
+
+	/* snd_msnd_init_queue(chip->DARQ, DARQ_DATA_BUFF, DARQ_BUFF_SIZE); */
+
+	chip->last_recbank = 2;
+	chip->captureLimit = pcm_count * (pcm_periods - 1);
+	chip->capturePeriods = pcm_periods;
+	writew(PCTODSP_OFFSET(0 * DAQDS__size), chip->DARQ + JQS_wHead);
+	writew(PCTODSP_OFFSET(chip->last_recbank * DAQDS__size),
+		chip->DARQ + JQS_wTail);
+
+	/* Critical section: bank 1 access. this is how the OSS driver does it:
+	spin_lock_irqsave(&chip->lock, flags);
+	outb(HPBLKSEL_1, chip->io + HP_BLKS);
+	memset_io(chip->mappedbase, 0, DAR_BUFF_SIZE * 3);
+	outb(HPBLKSEL_0, chip->io + HP_BLKS);
+	spin_unlock_irqrestore(&chip->lock, flags);*/
+
+	chip->capturePeriodBytes = pcm_count;
+	snd_printdd("snd_msnd_capture_reset_queue() %i\n", pcm_count);
+
+	pDAQ = chip->mappedbase + DARQ_DATA_BUFF;
+
+	for (n = 0; n < pcm_periods; ++n, pDAQ += DAQDS__size) {
+		u32 tmp = pcm_count * (n % pcm_periods);
+
+		writew(PCTODSP_BASED(tmp + 0x3000), pDAQ + DAQDS_wStart);
+		writew(pcm_count, pDAQ + DAQDS_wSize);
+		writew(1, pDAQ + DAQDS_wFormat);
+		writew(chip->capture_sample_size, pDAQ + DAQDS_wSampleSize);
+		writew(chip->capture_channels, pDAQ + DAQDS_wChannels);
+		writew(chip->capture_sample_rate, pDAQ + DAQDS_wSampleRate);
+		writew(HIMT_RECORD_DONE * 0x100 + n, pDAQ + DAQDS_wIntMsg);
+		writew(n, pDAQ + DAQDS_wFlags);
+	}
+}
+
+static void dsp_write_flush(struct snd_msnd *chip)
+{
+	if (!(chip->mode & FMODE_WRITE) || !test_bit(F_WRITING, &chip->flags))
+		return;
+	set_bit(F_WRITEFLUSH, &chip->flags);
+/*	interruptible_sleep_on_timeout(
+		&chip->writeflush,
+		get_play_delay_jiffies(&chip, chip->DAPF.len));*/
+	clear_bit(F_WRITEFLUSH, &chip->flags);
+	if (!signal_pending(current))
+		schedule_timeout_interruptible(
+			get_play_delay_jiffies(chip, chip->play_period_bytes));
+	clear_bit(F_WRITING, &chip->flags);
+}
+
+static void dsp_halt(struct snd_msnd *chip, struct file *file)
+{
+	if ((file ? file->f_mode : chip->mode) & FMODE_READ) {
+		clear_bit(F_READING, &chip->flags);
+		snd_msnd_send_dsp_cmd_chk(chip, HDEX_RECORD_STOP);
+		snd_msnd_disable_irq(chip);
+		if (file) {
+			snd_printd(LOGNAME ": Stopping read for %p\n", file);
+			chip->mode &= ~FMODE_READ;
+		}
+		clear_bit(F_AUDIO_READ_INUSE, &chip->flags);
+	}
+	if ((file ? file->f_mode : chip->mode) & FMODE_WRITE) {
+		if (test_bit(F_WRITING, &chip->flags)) {
+			dsp_write_flush(chip);
+			snd_msnd_send_dsp_cmd_chk(chip, HDEX_PLAY_STOP);
+		}
+		snd_msnd_disable_irq(chip);
+		if (file) {
+			snd_printd(LOGNAME ": Stopping write for %p\n", file);
+			chip->mode &= ~FMODE_WRITE;
+		}
+		clear_bit(F_AUDIO_WRITE_INUSE, &chip->flags);
+	}
+}
+
+#ifdef NO0
+static int dsp_release(struct file *file)
+{
+	dsp_halt(file);
+	return 0;
+}
+#endif
+
+
+static void set_default_audio_parameters(struct snd_msnd *chip)
+{
+	chip->play_sample_size = DEFSAMPLESIZE;
+	chip->play_sample_rate = DEFSAMPLERATE;
+	chip->play_channels = DEFCHANNELS;
+	chip->capture_sample_size = DEFSAMPLESIZE;
+	chip->capture_sample_rate = DEFSAMPLERATE;
+	chip->capture_channels = DEFCHANNELS;
+}
+
+
+static int snd_msnd_DARQ(struct snd_msnd *chip, int bank)
+{
+	int /*size, n,*/ timeout = 3;
+	u16 wTmp;
+	/* void *DAQD; */
+
+	/* Increment the tail and check for queue wrap */
+	wTmp = readw(chip->DARQ + JQS_wTail) + PCTODSP_OFFSET(DAQDS__size);
+	if (wTmp > readw(chip->DARQ + JQS_wSize))
+		wTmp = 0;
+	while (wTmp == readw(chip->DARQ + JQS_wHead) && timeout--)
+		udelay(1);
+
+	if (chip->capturePeriods == 2) {
+		void *pDAQ = chip->mappedbase + DARQ_DATA_BUFF +
+			     bank * DAQDS__size + DAQDS_wStart;
+		unsigned short offset = 0x3000 + chip->capturePeriodBytes;
+
+		if (readw(pDAQ) != PCTODSP_BASED(0x3000))
+			offset = 0x3000;
+		writew(PCTODSP_BASED(offset), pDAQ);
+	}
+
+	writew(wTmp, chip->DARQ + JQS_wTail);
+
+	/* Get our digital audio queue struct
+	DAQD = bank * DAQDS__size + chip->mappedbase + DARQ_DATA_BUFF;
+
+	/ * Get length of data * /
+	size = readw(DAQD + DAQDS_wSize);
+
+	/ * Read data from the head (unprotected bank 1 access okay
+	   since this is only called inside an interrupt) * /
+	outb(HPBLKSEL_1, chip->io + HP_BLKS);
+	if ((n = msnd_fifo_write(
+		&chip->DARF,
+		(char *)(chip->base + bank * DAR_BUFF_SIZE),
+		size, 0)) <= 0) {
+		outb(HPBLKSEL_0, chip->io + HP_BLKS);
+		return n;
+	}
+	outb(HPBLKSEL_0, chip->io + HP_BLKS);
+	*/
+
+	return 1;
+}
+
+static int  snd_msnd_DAPQ(struct snd_msnd *chip, int start)
+{
+	u16	DAPQ_tail;
+	int	protect = start, nbanks = 0;
+	void	*DAQD;
+	static int play_banks_submitted;
+	/* unsigned long flags;
+	spin_lock_irqsave(&chip->lock, flags); not necessary */
+
+	DAPQ_tail = readw(chip->DAPQ + JQS_wTail);
+	while (DAPQ_tail != readw(chip->DAPQ + JQS_wHead) || start) {
+		int bank_num = DAPQ_tail / PCTODSP_OFFSET(DAQDS__size);
+
+		if (start) {
+			start = 0;
+			play_banks_submitted = 0;
+		}
+
+		/* Get our digital audio queue struct */
+		DAQD = bank_num * DAQDS__size + chip->mappedbase +
+			DAPQ_DATA_BUFF;
+
+		/* Write size of this bank */
+		writew(chip->play_period_bytes, DAQD + DAQDS_wSize);
+		if (play_banks_submitted < 3)
+			++play_banks_submitted;
+		else if (chip->playPeriods == 2) {
+			unsigned short offset = chip->play_period_bytes;
+
+			if (readw(DAQD + DAQDS_wStart) != PCTODSP_BASED(0x0))
+				offset = 0;
+
+			writew(PCTODSP_BASED(offset), DAQD + DAQDS_wStart);
+		}
+		++nbanks;
+
+		/* Then advance the tail */
+		/*
+		if (protect)
+			snd_printd("B %X %lX\n", bank_num, xtime.tv_usec);
+		*/
+
+		DAPQ_tail = (++bank_num % 3) * PCTODSP_OFFSET(DAQDS__size);
+		writew(DAPQ_tail, chip->DAPQ + JQS_wTail);
+		/* Tell the DSP to play the bank */
+		snd_msnd_send_dsp_cmd(chip, HDEX_PLAY_START);
+		if (protect)
+			if (2 == bank_num)
+				break;
+	}
+	/*
+	if (protect)
+		snd_printd("%lX\n", xtime.tv_usec);
+	*/
+	/* spin_unlock_irqrestore(&chip->lock, flags); not necessary */
+	return nbanks;
+}
+
+
+static void snd_msnd_eval_dsp_msg(struct snd_msnd *chip, u16 wMessage)
+{
+	switch (HIBYTE(wMessage)) {
+	case HIMT_PLAY_DONE: {
+		#ifdef CONFIG_SND_DEBUG0
+		if (chip->banksPlayed < 3)
+			snd_printd("%08X: HIMT_PLAY_DONE: %i\n",
+				(unsigned)jiffies, LOBYTE(wMessage));
+		#endif
+
+		if (chip->last_playbank == LOBYTE(wMessage)) {
+			snd_printd("chip.last_playbank == LOBYTE(wMessage)\n");
+			break;
+		}
+		chip->banksPlayed++;
+
+		if (test_bit(F_WRITING, &chip->flags))
+			snd_msnd_DAPQ(chip, 0);
+
+		chip->last_playbank = LOBYTE(wMessage);
+		chip->playDMAPos += chip->play_period_bytes;
+		if (chip->playDMAPos > chip->playLimit)
+			chip->playDMAPos = 0;
+		snd_pcm_period_elapsed(chip->playback_substream);
+
+		break;
+	}
+	case HIMT_RECORD_DONE:
+		if (chip->last_recbank == LOBYTE(wMessage))
+			break;
+		chip->last_recbank = LOBYTE(wMessage);
+		chip->captureDMAPos += chip->capturePeriodBytes;
+		if (chip->captureDMAPos > (chip->captureLimit))
+			chip->captureDMAPos = 0;
+
+		if (test_bit(F_READING, &chip->flags))
+			snd_msnd_DARQ(chip, chip->last_recbank);
+
+		snd_pcm_period_elapsed(chip->capture_substream);
+		break;
+
+	case HIMT_DSP:
+		switch (LOBYTE(wMessage)) {
+#ifndef MSND_CLASSIC
+		case HIDSP_PLAY_UNDER:
+#endif
+		case HIDSP_INT_PLAY_UNDER:
+			snd_printd(LOGNAME ": Play underflow %i\n",
+				chip->banksPlayed);
+			if (chip->banksPlayed > 2)
+				clear_bit(F_WRITING, &chip->flags);
+			break;
+
+		case HIDSP_INT_RECORD_OVER:
+			snd_printd(LOGNAME ": Record overflow\n");
+			clear_bit(F_READING, &chip->flags);
+			break;
+
+		default:
+			snd_printd(LOGNAME ": DSP message %d 0x%02x\n",
+			LOBYTE(wMessage), LOBYTE(wMessage));
+			break;
+		}
+		break;
+
+	case HIMT_MIDI_IN_UCHAR:
+		if (chip->msndmidi_mpu)
+			snd_msndmidi_input_read(chip->msndmidi_mpu);
+		break;
+
+	default:
+		snd_printd(LOGNAME ": HIMT message %d 0x%02x\n",
+			HIBYTE(wMessage), HIBYTE(wMessage));
+		break;
+	}
+}
+
+irqreturn_t snd_msnd_interrupt(int irq, void *dev_id)
+{
+	struct snd_msnd *chip = dev_id;
+	void *pwDSPQData = chip->mappedbase + DSPQ_DATA_BUFF;
+
+	/* Send ack to DSP */
+	/* inb(chip->io + HP_RXL); */
+
+	/* Evaluate queued DSP messages */
+	while (readw(chip->DSPQ + JQS_wTail) != readw(chip->DSPQ + JQS_wHead)) {
+		u16 wTmp;
+
+		snd_msnd_eval_dsp_msg(chip,
+			readw(pwDSPQData + 2 * readw(chip->DSPQ + JQS_wHead)));
+
+		wTmp = readw(chip->DSPQ + JQS_wHead) + 1;
+		if (wTmp > readw(chip->DSPQ + JQS_wSize))
+			writew(0, chip->DSPQ + JQS_wHead);
+		else
+			writew(wTmp, chip->DSPQ + JQS_wHead);
+	}
+	/* Send ack to DSP */
+	inb(chip->io + HP_RXL);
+	return IRQ_HANDLED;
+}
+
+
+static int snd_msnd_reset_dsp(long io, unsigned char *info)
+{
+	int timeout = 100;
+
+	outb(HPDSPRESET_ON, io + HP_DSPR);
+	msleep(1);
+#ifndef MSND_CLASSIC
+	if (info)
+		*info = inb(io + HP_INFO);
+#endif
+	outb(HPDSPRESET_OFF, io + HP_DSPR);
+	msleep(1);
+	while (timeout-- > 0) {
+		if (inb(io + HP_CVR) == HP_CVR_DEF)
+			return 0;
+		msleep(1);
+	}
+	snd_printk(KERN_ERR LOGNAME ": Cannot reset DSP\n");
+
+	return -EIO;
+}
+
+static int __devinit snd_msnd_probe(struct snd_card *card)
+{
+	struct snd_msnd *chip = card->private_data;
+	unsigned char info;
+#ifndef MSND_CLASSIC
+	char *xv, *rev = NULL;
+	char *pin = "TB Pinnacle", *fiji = "TB Fiji";
+	char *pinfiji = "TB Pinnacle/Fiji";
+#endif
+
+	if (!request_region(chip->io, DSP_NUMIO, "probing")) {
+		snd_printk(KERN_ERR LOGNAME ": I/O port conflict\n");
+		return -ENODEV;
+	}
+
+	if (snd_msnd_reset_dsp(chip->io, &info) < 0) {
+		release_region(chip->io, DSP_NUMIO);
+		return -ENODEV;
+	}
+
+#ifdef MSND_CLASSIC
+	strcpy(card->shortname, "Classic/Tahiti/Monterey");
+	printk(KERN_INFO LOGNAME ": %s, "
+#else
+	switch (info >> 4) {
+	case 0xf:
+		xv = "<= 1.15";
+		break;
+	case 0x1:
+		xv = "1.18/1.2";
+		break;
+	case 0x2:
+		xv = "1.3";
+		break;
+	case 0x3:
+		xv = "1.4";
+		break;
+	default:
+		xv = "unknown";
+		break;
+	}
+
+	switch (info & 0x7) {
+	case 0x0:
+		rev = "I";
+		strcpy(card->shortname, pin);
+		break;
+	case 0x1:
+		rev = "F";
+		strcpy(card->shortname, pin);
+		break;
+	case 0x2:
+		rev = "G";
+		strcpy(card->shortname, pin);
+		break;
+	case 0x3:
+		rev = "H";
+		strcpy(card->shortname, pin);
+		break;
+	case 0x4:
+		rev = "E";
+		strcpy(card->shortname, fiji);
+		break;
+	case 0x5:
+		rev = "C";
+		strcpy(card->shortname, fiji);
+		break;
+	case 0x6:
+		rev = "D";
+		strcpy(card->shortname, fiji);
+		break;
+	case 0x7:
+		rev = "A-B (Fiji) or A-E (Pinnacle)";
+		strcpy(card->shortname, pinfiji);
+		break;
+	}
+	printk(KERN_INFO LOGNAME ": %s revision %s, Xilinx version %s, "
+#endif /* MSND_CLASSIC */
+	       "I/O 0x%lx-0x%lx, IRQ %d, memory mapped to 0x%lX-0x%lX\n",
+	       card->shortname,
+#ifndef MSND_CLASSIC
+	       rev, xv,
+#endif
+	       chip->io, chip->io + DSP_NUMIO - 1,
+	       chip->irq,
+	       chip->base, chip->base + 0x7fff);
+
+	strcpy(card->longname, "Turtle Beach Multisound Pinnacle");
+	release_region(chip->io, DSP_NUMIO);
+	return 0;
+}
+
+static int snd_msnd_init_sma(struct snd_msnd *chip)
+{
+	static int initted;
+	u16 mastVolLeft, mastVolRight;
+	unsigned long flags;
+
+#ifdef MSND_CLASSIC
+	outb(chip->memid, chip->io + HP_MEMM);
+#endif
+	outb(HPBLKSEL_0, chip->io + HP_BLKS);
+	/* Motorola 56k shared memory base */
+	chip->SMA = chip->mappedbase + SMA_STRUCT_START;
+
+	if (initted) {
+		mastVolLeft = readw(chip->SMA + SMA_wCurrMastVolLeft);
+		mastVolRight = readw(chip->SMA + SMA_wCurrMastVolRight);
+	} else
+		mastVolLeft = mastVolRight = 0;
+	memset_io(chip->mappedbase, 0, 0x8000);
+
+	/* Critical section: bank 1 access */
+	spin_lock_irqsave(&chip->lock, flags);
+	outb(HPBLKSEL_1, chip->io + HP_BLKS);
+	memset_io(chip->mappedbase, 0, 0x8000);
+	outb(HPBLKSEL_0, chip->io + HP_BLKS);
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	/* Digital audio play queue */
+	chip->DAPQ = chip->mappedbase + DAPQ_OFFSET;
+	snd_msnd_init_queue(chip->DAPQ, DAPQ_DATA_BUFF, DAPQ_BUFF_SIZE);
+
+	/* Digital audio record queue */
+	chip->DARQ = chip->mappedbase + DARQ_OFFSET;
+	snd_msnd_init_queue(chip->DARQ, DARQ_DATA_BUFF, DARQ_BUFF_SIZE);
+
+	/* MIDI out queue */
+	chip->MODQ = chip->mappedbase + MODQ_OFFSET;
+	snd_msnd_init_queue(chip->MODQ, MODQ_DATA_BUFF, MODQ_BUFF_SIZE);
+
+	/* MIDI in queue */
+	chip->MIDQ = chip->mappedbase + MIDQ_OFFSET;
+	snd_msnd_init_queue(chip->MIDQ, MIDQ_DATA_BUFF, MIDQ_BUFF_SIZE);
+
+	/* DSP -> host message queue */
+	chip->DSPQ = chip->mappedbase + DSPQ_OFFSET;
+	snd_msnd_init_queue(chip->DSPQ, DSPQ_DATA_BUFF, DSPQ_BUFF_SIZE);
+
+	/* Setup some DSP values */
+#ifndef MSND_CLASSIC
+	writew(1, chip->SMA + SMA_wCurrPlayFormat);
+	writew(chip->play_sample_size, chip->SMA + SMA_wCurrPlaySampleSize);
+	writew(chip->play_channels, chip->SMA + SMA_wCurrPlayChannels);
+	writew(chip->play_sample_rate, chip->SMA + SMA_wCurrPlaySampleRate);
+#endif
+	writew(chip->play_sample_rate, chip->SMA + SMA_wCalFreqAtoD);
+	writew(mastVolLeft, chip->SMA + SMA_wCurrMastVolLeft);
+	writew(mastVolRight, chip->SMA + SMA_wCurrMastVolRight);
+#ifndef MSND_CLASSIC
+	writel(0x00010000, chip->SMA + SMA_dwCurrPlayPitch);
+	writel(0x00000001, chip->SMA + SMA_dwCurrPlayRate);
+#endif
+	writew(0x303, chip->SMA + SMA_wCurrInputTagBits);
+
+	initted = 1;
+
+	return 0;
+}
+
+
+static int __devinit snd_msnd_calibrate_adc(struct snd_msnd *chip, u16 srate)
+{
+	snd_printd("snd_msnd_calibrate_adc(%i)\n", srate);
+	writew(srate, chip->SMA + SMA_wCalFreqAtoD);
+	if (chip->calibrate_signal == 0)
+		writew(readw(chip->SMA + SMA_wCurrHostStatusFlags)
+		       | 0x0001, chip->SMA + SMA_wCurrHostStatusFlags);
+	else
+		writew(readw(chip->SMA + SMA_wCurrHostStatusFlags)
+		       & ~0x0001, chip->SMA + SMA_wCurrHostStatusFlags);
+	if (snd_msnd_send_word(chip, 0, 0, HDEXAR_CAL_A_TO_D) == 0 &&
+	    snd_msnd_send_dsp_cmd_chk(chip, HDEX_AUX_REQ) == 0) {
+		schedule_timeout_interruptible(msecs_to_jiffies(333));
+		return 0;
+	}
+	printk(KERN_WARNING LOGNAME ": ADC calibration failed\n");
+	return -EIO;
+}
+
+static int upload_dsp_code(struct snd_card *card)
+{
+	struct snd_msnd *chip = card->private_data;
+#ifndef HAVE_DSPCODEH
+	const struct firmware *init_fw = NULL, *perm_fw = NULL;
+#endif
+	int err;
+
+	outb(HPBLKSEL_0, chip->io + HP_BLKS);
+#ifndef HAVE_DSPCODEH
+
+	err = request_firmware(&init_fw, INITCODEFILE, card->dev);
+	if (err < 0) {
+		printk(KERN_ERR LOGNAME ": Error loading " INITCODEFILE);
+		goto cleanup1;
+	}
+	err = request_firmware(&perm_fw, PERMCODEFILE, card->dev);
+	if (err < 0) {
+		printk(KERN_ERR LOGNAME ": Error loading " PERMCODEFILE);
+		goto cleanup;
+	}
+	INITCODE = init_fw->data;
+	INITCODESIZE = init_fw->size;
+	PERMCODE = perm_fw->data;
+	PERMCODESIZE = perm_fw->size;
+#endif
+	memcpy_toio(chip->mappedbase, PERMCODE, PERMCODESIZE);
+	if (snd_msnd_upload_host(chip, INITCODE, INITCODESIZE) < 0) {
+		printk(KERN_WARNING LOGNAME ": Error uploading to DSP\n");
+		err = -ENODEV;
+		goto cleanup;
+	}
+#ifdef HAVE_DSPsleep
+	printk(KERN_INFO LOGNAME ": DSP firmware uploaded (resident)\n");
+#else
+	printk(KERN_INFO LOGNAME ": DSP firmware uploaded\n");
+#endif
+	err = 0;
+
+cleanup:
+#ifndef HAVE_DSPCODEH
+	release_firmware(perm_fw);
+cleanup1:
+	release_firmware(init_fw);
+#endif
+	return err;
+}
+
+#ifdef MSND_CLASSIC
+static void reset_proteus(struct snd_msnd *chip)
+{
+	outb(HPPRORESET_ON, chip->io + HP_PROR);
+	msleep(TIME_PRO_RESET);
+	outb(HPPRORESET_OFF, chip->io + HP_PROR);
+	msleep(TIME_PRO_RESET_DONE);
+}
+#endif
+
+static int snd_msnd_initialize(struct snd_card *card)
+{
+	struct snd_msnd *chip = card->private_data;
+	int err, timeout;
+
+#ifdef MSND_CLASSIC
+	outb(HPWAITSTATE_0, chip->io + HP_WAIT);
+	outb(HPBITMODE_16, chip->io + HP_BITM);
+
+	reset_proteus(chip);
+#endif
+	err = snd_msnd_init_sma(chip);
+	if (err < 0) {
+		printk(KERN_WARNING LOGNAME ": Cannot initialize SMA\n");
+		return err;
+	}
+
+	err = snd_msnd_reset_dsp(chip->io, NULL);
+	if (err < 0)
+		return err;
+
+	err = upload_dsp_code(card);
+	if (err < 0) {
+		printk(KERN_WARNING LOGNAME ": Cannot upload DSP code\n");
+		return err;
+	}
+
+	timeout = 200;
+
+	while (readw(chip->mappedbase)) {
+		msleep(1);
+		if (!timeout--) {
+			snd_printd(LOGNAME ": DSP reset timeout\n");
+			return -EIO;
+		}
+	}
+
+	snd_msndmix_setup(chip);
+	return 0;
+}
+
+static int snd_msnd_dsp_full_reset(struct snd_card *card)
+{
+	struct snd_msnd *chip = card->private_data;
+	int rv;
+
+	if (test_bit(F_RESETTING, &chip->flags) || ++chip->nresets > 10)
+		return 0;
+
+	set_bit(F_RESETTING, &chip->flags);
+	dsp_halt(chip, NULL);		/* Unconditionally halt */
+
+	rv = snd_msnd_initialize(card);
+	if (rv)
+		printk(KERN_WARNING LOGNAME ": DSP reset failed\n");
+	snd_msndmix_force_recsrc(chip, 0);
+	clear_bit(F_RESETTING, &chip->flags);
+	return rv;
+}
+
+static int snd_msnd_dev_free(struct snd_device *device)
+{
+	snd_printd("snd_msnd_chip_free()\n");
+	return 0;
+}
+
+static struct snd_pcm_hardware snd_msnd_playback = {
+	.info =			SNDRV_PCM_INFO_MMAP |
+				SNDRV_PCM_INFO_INTERLEAVED |
+				SNDRV_PCM_INFO_MMAP_VALID,
+	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_48000,
+	.rate_min =		8000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		2,
+	.buffer_bytes_max =	0x3000,
+	.period_bytes_min =	0x40,
+	.period_bytes_max =	0x1800,
+	.periods_min =		2,
+	.periods_max =		3,
+	.fifo_size =		0,
+};
+
+static struct snd_pcm_hardware snd_msnd_capture = {
+	.info =			SNDRV_PCM_INFO_MMAP |
+				SNDRV_PCM_INFO_INTERLEAVED |
+				SNDRV_PCM_INFO_MMAP_VALID,
+	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_48000,
+	.rate_min =		8000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		2,
+	.buffer_bytes_max =	0x3000,
+	.period_bytes_min =	0x40,
+	.period_bytes_max =	0x1800,
+	.periods_min =		2,
+	.periods_max =		3,
+	.fifo_size =		0,
+};
+
+
+static unsigned int rates[] = {
+	8000, 11025, 16000, 22050, 32000, 44100, 48000
+};
+
+static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list = rates,
+	.mask = 0,
+};
+
+static int snd_msnd_playback_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+
+	set_bit(F_AUDIO_WRITE_INUSE, &chip->flags);
+	clear_bit(F_WRITING, &chip->flags);
+	snd_msnd_enable_irq(chip);
+
+	runtime->dma_area = chip->mappedbase;
+	runtime->dma_bytes = 0x3000;
+
+	chip->playback_substream = substream;
+	runtime->hw = snd_msnd_playback;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &hw_constraints_rates);
+	return 0;
+}
+
+static int snd_msnd_playback_close(struct snd_pcm_substream *substream)
+{
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+
+	snd_msnd_disable_irq(chip);
+	clear_bit(F_AUDIO_WRITE_INUSE, &chip->flags);
+	return 0;
+}
+
+
+static int snd_msnd_playback_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	int	i;
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+	void	*pDAQ =	chip->mappedbase + DAPQ_DATA_BUFF;
+
+	chip->play_sample_size = snd_pcm_format_width(params_format(params));
+	chip->play_channels = params_channels(params);
+	chip->play_sample_rate = params_rate(params);
+
+	for (i = 0; i < 3; ++i, pDAQ += DAQDS__size) {
+		writew(chip->play_sample_size, pDAQ + DAQDS_wSampleSize);
+		writew(chip->play_channels, pDAQ + DAQDS_wChannels);
+		writew(chip->play_sample_rate, pDAQ + DAQDS_wSampleRate);
+	}
+	/* dont do this here:
+	 * snd_msnd_calibrate_adc(chip->play_sample_rate);
+	 */
+
+	return 0;
+}
+
+static int snd_msnd_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+	unsigned int pcm_size = snd_pcm_lib_buffer_bytes(substream);
+	unsigned int pcm_count = snd_pcm_lib_period_bytes(substream);
+	unsigned int pcm_periods = pcm_size / pcm_count;
+
+	snd_msnd_play_reset_queue(chip, pcm_periods, pcm_count);
+	chip->playDMAPos = 0;
+	return 0;
+}
+
+static int snd_msnd_playback_trigger(struct snd_pcm_substream *substream,
+				     int cmd)
+{
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+	int	result = 0;
+
+	if (cmd == SNDRV_PCM_TRIGGER_START) {
+		snd_printdd("snd_msnd_playback_trigger(START)\n");
+		chip->banksPlayed = 0;
+		set_bit(F_WRITING, &chip->flags);
+		snd_msnd_DAPQ(chip, 1);
+	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
+		snd_printdd("snd_msnd_playback_trigger(STop)\n");
+		/* interrupt diagnostic, comment this out later */
+		clear_bit(F_WRITING, &chip->flags);
+		snd_msnd_send_dsp_cmd(chip, HDEX_PLAY_STOP);
+	} else {
+		snd_printd("snd_msnd_playback_trigger(?????)\n");
+		result = -EINVAL;
+	}
+
+	snd_printdd("snd_msnd_playback_trigger() ENDE\n");
+	return result;
+}
+
+static snd_pcm_uframes_t
+snd_msnd_playback_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+
+	return bytes_to_frames(substream->runtime, chip->playDMAPos);
+}
+
+
+static struct snd_pcm_ops snd_msnd_playback_ops = {
+	.open =		snd_msnd_playback_open,
+	.close =	snd_msnd_playback_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_msnd_playback_hw_params,
+	.prepare =	snd_msnd_playback_prepare,
+	.trigger =	snd_msnd_playback_trigger,
+	.pointer =	snd_msnd_playback_pointer,
+};
+
+static int snd_msnd_capture_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+
+	set_bit(F_AUDIO_READ_INUSE, &chip->flags);
+	snd_msnd_enable_irq(chip);
+	runtime->dma_area = chip->mappedbase + 0x3000;
+	runtime->dma_bytes = 0x3000;
+	memset(runtime->dma_area, 0, runtime->dma_bytes);
+	chip->capture_substream = substream;
+	runtime->hw = snd_msnd_capture;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &hw_constraints_rates);
+	return 0;
+}
+
+static int snd_msnd_capture_close(struct snd_pcm_substream *substream)
+{
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+
+	snd_msnd_disable_irq(chip);
+	clear_bit(F_AUDIO_READ_INUSE, &chip->flags);
+	return 0;
+}
+
+static int snd_msnd_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+	unsigned int pcm_size = snd_pcm_lib_buffer_bytes(substream);
+	unsigned int pcm_count = snd_pcm_lib_period_bytes(substream);
+	unsigned int pcm_periods = pcm_size / pcm_count;
+
+	snd_msnd_capture_reset_queue(chip, pcm_periods, pcm_count);
+	chip->captureDMAPos = 0;
+	return 0;
+}
+
+static int snd_msnd_capture_trigger(struct snd_pcm_substream *substream,
+				    int cmd)
+{
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+
+	if (cmd == SNDRV_PCM_TRIGGER_START) {
+		chip->last_recbank = -1;
+		set_bit(F_READING, &chip->flags);
+		if (snd_msnd_send_dsp_cmd_chk(chip, HDEX_RECORD_START) == 0)
+			return 0;
+
+		clear_bit(F_READING, &chip->flags);
+	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
+		clear_bit(F_READING, &chip->flags);
+		snd_msnd_send_dsp_cmd(chip, HDEX_RECORD_STOP);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+
+static snd_pcm_uframes_t
+snd_msnd_capture_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+
+	return bytes_to_frames(runtime, chip->captureDMAPos);
+}
+
+
+static int snd_msnd_capture_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	int		i;
+	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
+	void		*pDAQ = chip->mappedbase + DARQ_DATA_BUFF;
+
+	chip->capture_sample_size = snd_pcm_format_width(params_format(params));
+	chip->capture_channels = params_channels(params);
+	chip->capture_sample_rate = params_rate(params);
+
+	for (i = 0; i < 3; ++i, pDAQ += DAQDS__size) {
+		writew(chip->capture_sample_size, pDAQ + DAQDS_wSampleSize);
+		writew(chip->capture_channels, pDAQ + DAQDS_wChannels);
+		writew(chip->capture_sample_rate, pDAQ + DAQDS_wSampleRate);
+	}
+	return 0;
+}
+
+
+static struct snd_pcm_ops snd_msnd_capture_ops = {
+	.open =		snd_msnd_capture_open,
+	.close =	snd_msnd_capture_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_msnd_capture_hw_params,
+	.prepare =	snd_msnd_capture_prepare,
+	.trigger =	snd_msnd_capture_trigger,
+	.pointer =	snd_msnd_capture_pointer,
+};
+
+
+int snd_msnd_pcm(struct snd_card *card, int device, struct snd_pcm **rpcm)
+{
+	struct snd_msnd *chip = card->private_data;
+	struct snd_pcm	*pcm;
+	int err;
+
+	err = snd_pcm_new(card, "MSNDPINNACLE", device, 1, 1, &pcm);
+	if (err < 0)
+		return err;
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_msnd_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_msnd_capture_ops);
+
+	pcm->private_data = chip;
+	strcpy(pcm->name, "Hurricane");
+
+
+	if (rpcm)
+		*rpcm = pcm;
+	return 0;
+}
+
+/*
+ * ALSA callback function, called when attempting to open the MIDI device.
+ */
+static int snd_msnd_mpu401_open(struct snd_mpu401 *mpu)
+{
+	snd_msnd_enable_irq(mpu->private_data);
+	snd_msnd_send_dsp_cmd(mpu->private_data, HDEX_MIDI_IN_START);
+	return 0;
+}
+
+static void snd_msnd_mpu401_close(struct snd_mpu401 *mpu)
+{
+	snd_msnd_send_dsp_cmd(mpu->private_data, HDEX_MIDI_IN_STOP);
+	snd_msnd_disable_irq(mpu->private_data);
+}
+
+static long mpu_io[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
+static int mpu_irq[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_IRQ;
+
+static int __devinit snd_msnd_attach(struct snd_card *card)
+{
+	struct snd_msnd *chip = card->private_data;
+	int err;
+	static struct snd_device_ops ops = {
+		.dev_free =      snd_msnd_dev_free,
+		};
+
+	err = request_irq(chip->irq, snd_msnd_interrupt, 0, card->shortname,
+			  chip);
+	if (err < 0) {
+		printk(KERN_ERR LOGNAME ": Couldn't grab IRQ %d\n", chip->irq);
+		return err;
+	}
+	request_region(chip->io, DSP_NUMIO, card->shortname);
+
+	if (!request_mem_region(chip->base, BUFFSIZE, card->shortname)) {
+		printk(KERN_ERR LOGNAME
+			": unable to grab memory region 0x%lx-0x%lx\n",
+			chip->base, chip->base + BUFFSIZE - 1);
+		release_region(chip->io, DSP_NUMIO);
+		free_irq(chip->irq, chip);
+		return -EBUSY;
+	}
+	chip->mappedbase = ioremap(chip->base, 0x8000);
+	if (!chip->mappedbase) {
+		printk(KERN_ERR LOGNAME
+			": unable to map memory region 0x%lx-0x%lx\n",
+			chip->base, chip->base + BUFFSIZE - 1);
+		err = -EIO;
+		goto err_release_region;
+	}
+	chip->mappedbase = ioremap(chip->base, 0x8000);
+
+	err = snd_msnd_dsp_full_reset(card);
+	if (err < 0)
+		goto err_release_region;
+
+	/* Register device */
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0)
+		goto err_release_region;
+
+	err = snd_msnd_pcm(card, 0, NULL);
+	if (err < 0) {
+		printk(KERN_ERR LOGNAME ": error creating new PCM device\n");
+		goto err_release_region;
+	}
+
+	err = snd_msndmix_new(card);
+	if (err < 0) {
+		printk(KERN_ERR LOGNAME ": error creating new Mixer device\n");
+		goto err_release_region;
+	}
+
+
+	if (mpu_io[0] != SNDRV_AUTO_PORT) {
+		struct snd_mpu401 *mpu;
+
+		err = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
+					  mpu_io[0],
+					  MPU401_MODE_INPUT |
+					  MPU401_MODE_OUTPUT,
+					  mpu_irq[0], IRQF_DISABLED,
+					  &chip->rmidi);
+		if (err < 0) {
+			printk(KERN_ERR LOGNAME
+				": error creating new Midi device\n");
+			goto err_release_region;
+		}
+		mpu = chip->rmidi->private_data;
+
+		mpu->open_input = snd_msnd_mpu401_open;
+		mpu->close_input = snd_msnd_mpu401_close;
+		mpu->private_data = chip;
+	}
+
+	disable_irq(chip->irq);
+	snd_msnd_calibrate_adc(chip, chip->play_sample_rate);
+	snd_msndmix_force_recsrc(chip, 0);
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto err_release_region;
+
+	return 0;
+
+err_release_region:
+	if (chip->mappedbase)
+		iounmap(chip->mappedbase);
+	release_mem_region(chip->base, BUFFSIZE);
+	release_region(chip->io, DSP_NUMIO);
+	free_irq(chip->irq, chip);
+	return err;
+}
+
+
+static void __devexit snd_msnd_unload(struct snd_card *card)
+{
+	struct snd_msnd *chip = card->private_data;
+
+	iounmap(chip->mappedbase);
+	release_mem_region(chip->base, BUFFSIZE);
+	release_region(chip->io, DSP_NUMIO);
+	free_irq(chip->irq, chip);
+	snd_card_free(card);
+}
+
+#ifndef MSND_CLASSIC
+
+/* Pinnacle/Fiji Logical Device Configuration */
+
+static int __devinit snd_msnd_write_cfg(int cfg, int reg, int value)
+{
+	outb(reg, cfg);
+	outb(value, cfg + 1);
+	if (value != inb(cfg + 1)) {
+		printk(KERN_ERR LOGNAME ": snd_msnd_write_cfg: I/O error\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+static int __devinit snd_msnd_write_cfg_io0(int cfg, int num, u16 io)
+{
+	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
+		return -EIO;
+	if (snd_msnd_write_cfg(cfg, IREG_IO0_BASEHI, HIBYTE(io)))
+		return -EIO;
+	if (snd_msnd_write_cfg(cfg, IREG_IO0_BASELO, LOBYTE(io)))
+		return -EIO;
+	return 0;
+}
+
+static int __devinit snd_msnd_write_cfg_io1(int cfg, int num, u16 io)
+{
+	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
+		return -EIO;
+	if (snd_msnd_write_cfg(cfg, IREG_IO1_BASEHI, HIBYTE(io)))
+		return -EIO;
+	if (snd_msnd_write_cfg(cfg, IREG_IO1_BASELO, LOBYTE(io)))
+		return -EIO;
+	return 0;
+}
+
+static int __devinit snd_msnd_write_cfg_irq(int cfg, int num, u16 irq)
+{
+	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
+		return -EIO;
+	if (snd_msnd_write_cfg(cfg, IREG_IRQ_NUMBER, LOBYTE(irq)))
+		return -EIO;
+	if (snd_msnd_write_cfg(cfg, IREG_IRQ_TYPE, IRQTYPE_EDGE))
+		return -EIO;
+	return 0;
+}
+
+static int __devinit snd_msnd_write_cfg_mem(int cfg, int num, int mem)
+{
+	u16 wmem;
+
+	mem >>= 8;
+	wmem = (u16)(mem & 0xfff);
+	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
+		return -EIO;
+	if (snd_msnd_write_cfg(cfg, IREG_MEMBASEHI, HIBYTE(wmem)))
+		return -EIO;
+	if (snd_msnd_write_cfg(cfg, IREG_MEMBASELO, LOBYTE(wmem)))
+		return -EIO;
+	if (wmem && snd_msnd_write_cfg(cfg, IREG_MEMCONTROL,
+				       MEMTYPE_HIADDR | MEMTYPE_16BIT))
+		return -EIO;
+	return 0;
+}
+
+static int __devinit snd_msnd_activate_logical(int cfg, int num)
+{
+	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
+		return -EIO;
+	if (snd_msnd_write_cfg(cfg, IREG_ACTIVATE, LD_ACTIVATE))
+		return -EIO;
+	return 0;
+}
+
+static int __devinit snd_msnd_write_cfg_logical(int cfg, int num, u16 io0,
+						u16 io1, u16 irq, int mem)
+{
+	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
+		return -EIO;
+	if (snd_msnd_write_cfg_io0(cfg, num, io0))
+		return -EIO;
+	if (snd_msnd_write_cfg_io1(cfg, num, io1))
+		return -EIO;
+	if (snd_msnd_write_cfg_irq(cfg, num, irq))
+		return -EIO;
+	if (snd_msnd_write_cfg_mem(cfg, num, mem))
+		return -EIO;
+	if (snd_msnd_activate_logical(cfg, num))
+		return -EIO;
+	return 0;
+}
+
+static int __devinit snd_msnd_pinnacle_cfg_reset(int cfg)
+{
+	int i;
+
+	/* Reset devices if told to */
+	printk(KERN_INFO LOGNAME ": Resetting all devices\n");
+	for (i = 0; i < 4; ++i)
+		if (snd_msnd_write_cfg_logical(cfg, i, 0, 0, 0, 0))
+			return -EIO;
+
+	return 0;
+}
+#endif
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
+
+module_param_array(index, int, NULL, S_IRUGO);
+MODULE_PARM_DESC(index, "Index value for msnd_pinnacle soundcard.");
+module_param_array(id, charp, NULL, S_IRUGO);
+MODULE_PARM_DESC(id, "ID string for msnd_pinnacle soundcard.");
+
+static long io[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
+static int irq[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_IRQ;
+static long mem[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
+
+static long cfg[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
+
+#ifndef MSND_CLASSIC
+/* Extra Peripheral Configuration (Default: Disable) */
+static long ide_io0[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
+static long ide_io1[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
+static int ide_irq[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_IRQ;
+
+static long joystick_io[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
+/* If we have the digital daugherboard... */
+static int digital[SNDRV_CARDS] __devinitdata;
+
+/* Extra Peripheral Configuration */
+static int reset[SNDRV_CARDS] __devinitdata;
+#endif
+
+static int write_ndelay[SNDRV_CARDS] __devinitdata =
+						{ [0 ... (SNDRV_CARDS-1)] = 1 };
+
+#ifdef CONFIG_PNP
+static int isapnp[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_ENABLE_PNP;
+#endif
+
+#ifdef MODULE
+MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
+MODULE_DESCRIPTION("Turtle Beach " LONGNAME " Linux Driver");
+MODULE_LICENSE("GPL");
+#ifndef HAVE_DSPCODEH
+MODULE_FIRMWARE(INITCODEFILE);
+MODULE_FIRMWARE(PERMCODEFILE);
+#endif
+
+static int calibrate_signal __devinitdata;
+
+module_param_array(io, long, NULL, S_IRUGO);
+MODULE_PARM_DESC(io, "IO port #");
+module_param_array(irq, int, NULL, S_IRUGO);
+module_param_array(mem, long, NULL, S_IRUGO);
+module_param_array(write_ndelay, int, NULL, S_IRUGO);
+module_param(calibrate_signal, int, S_IRUGO);
+#ifndef MSND_CLASSIC
+module_param_array(digital, int, NULL, S_IRUGO);
+module_param_array(cfg, long, NULL, S_IRUGO);
+module_param_array(reset, int, 0, S_IRUGO);
+module_param_array(mpu_io, long, NULL, S_IRUGO);
+module_param_array(mpu_irq, int, NULL, S_IRUGO);
+module_param_array(ide_io0, long, NULL, S_IRUGO);
+module_param_array(ide_io1, long, NULL, S_IRUGO);
+module_param_array(ide_irq, int, NULL, S_IRUGO);
+module_param_array(joystick_io, long, NULL, S_IRUGO);
+#ifdef CONFIG_PNP
+module_param_array(isapnp, bool, NULL, 0444);
+MODULE_PARM_DESC(isapnp, "ISA PnP detection for specified soundcard.");
+#endif
+#endif
+
+#else /* not a module */
+
+static int
+calibrate_signal __devinitdata;
+#endif /* MODULE */
+
+
+static int __devinit snd_msnd_isa_match(struct device *pdev, unsigned int i)
+{
+	if (io[i] == SNDRV_AUTO_PORT)
+		return 0;
+
+	if (irq[i] == SNDRV_AUTO_PORT || mem[i] == SNDRV_AUTO_PORT) {
+		printk(KERN_WARNING LOGNAME ": io, irq and mem must be set\n");
+		return 0;
+	}
+
+#ifdef MSND_CLASSIC
+	if (!(io[i] == 0x290 ||
+	      io[i] == 0x260 ||
+	      io[i] == 0x250 ||
+	      io[i] == 0x240 ||
+	      io[i] == 0x230 ||
+	      io[i] == 0x220 ||
+	      io[i] == 0x210 ||
+	      io[i] == 0x3e0)) {
+		printk(KERN_ERR LOGNAME ": \"io\" - DSP I/O base must be set "
+			" to 0x210, 0x220, 0x230, 0x240, 0x250, 0x260, 0x290, "
+			"or 0x3E0\n");
+		return 0;
+	}
+#else
+	if (io[i] < 0x100 || io[i] > 0x3e0 || (io[i] % 0x10) != 0) {
+		printk(KERN_ERR LOGNAME
+			": \"io\" - DSP I/O base must within the range 0x100 "
+			"to 0x3E0 and must be evenly divisible by 0x10\n");
+		return 0;
+	}
+#endif /* MSND_CLASSIC */
+
+	if (!(irq[i] == 5 ||
+	      irq[i] == 7 ||
+	      irq[i] == 9 ||
+	      irq[i] == 10 ||
+	      irq[i] == 11 ||
+	      irq[i] == 12)) {
+		printk(KERN_ERR LOGNAME
+			": \"irq\" - must be set to 5, 7, 9, 10, 11 or 12\n");
+		return 0;
+	}
+
+	if (!(mem[i] == 0xb0000 ||
+	      mem[i] == 0xc8000 ||
+	      mem[i] == 0xd0000 ||
+	      mem[i] == 0xd8000 ||
+	      mem[i] == 0xe0000 ||
+	      mem[i] == 0xe8000)) {
+		printk(KERN_ERR LOGNAME ": \"mem\" - must be set to "
+		       "0xb0000, 0xc8000, 0xd0000, 0xd8000, 0xe0000 or "
+		       "0xe8000\n");
+		return 0;
+	}
+
+#ifndef MSND_CLASSIC
+	if (cfg[i] == SNDRV_AUTO_PORT) {
+		printk(KERN_INFO LOGNAME ": Assuming PnP mode\n");
+	} else if (cfg[i] != 0x250 && cfg[i] != 0x260 && cfg[i] != 0x270) {
+		printk(KERN_INFO LOGNAME
+			": Config port must be 0x250, 0x260 or 0x270 "
+			"(or unspecified for PnP mode)\n");
+		return 0;
+	}
+#endif /* MSND_CLASSIC */
+
+	return 1;
+}
+
+static int __devinit snd_msnd_isa_probe(struct device *pdev, unsigned int idx)
+{
+	int err;
+	struct snd_card *card;
+	struct snd_msnd *chip;
+
+	if (isapnp[idx] || cfg[idx] == SNDRV_AUTO_PORT) {
+		printk(KERN_INFO LOGNAME ": Assuming PnP mode\n");
+		return -ENODEV;
+	}
+
+	card = snd_card_new(index[idx], id[idx], THIS_MODULE,
+			    sizeof(struct snd_msnd));
+	if (!card)
+		return -ENOMEM;
+
+	snd_card_set_dev(card, pdev);
+	chip = card->private_data;
+	chip->card = card;
+
+#ifdef MSND_CLASSIC
+	switch (irq[idx]) {
+	case 5:
+		chip->irqid = HPIRQ_5; break;
+	case 7:
+		chip->irqid = HPIRQ_7; break;
+	case 9:
+		chip->irqid = HPIRQ_9; break;
+	case 10:
+		chip->irqid = HPIRQ_10; break;
+	case 11:
+		chip->irqid = HPIRQ_11; break;
+	case 12:
+		chip->irqid = HPIRQ_12; break;
+	}
+
+	switch (mem[idx]) {
+	case 0xb0000:
+		chip->memid = HPMEM_B000; break;
+	case 0xc8000:
+		chip->memid = HPMEM_C800; break;
+	case 0xd0000:
+		chip->memid = HPMEM_D000; break;
+	case 0xd8000:
+		chip->memid = HPMEM_D800; break;
+	case 0xe0000:
+		chip->memid = HPMEM_E000; break;
+	case 0xe8000:
+		chip->memid = HPMEM_E800; break;
+	}
+#else
+	printk(KERN_INFO LOGNAME ": Non-PnP mode: configuring at port 0x%lx\n",
+			cfg[idx]);
+
+	if (!request_region(cfg[idx], 2, "Pinnacle/Fiji Config")) {
+		printk(KERN_ERR LOGNAME ": Config port 0x%lx conflict\n",
+			   cfg[idx]);
+		snd_card_free(card);
+		return -EIO;
+	}
+	if (reset[idx])
+		if (snd_msnd_pinnacle_cfg_reset(cfg[idx])) {
+			err = -EIO;
+			goto cfg_error;
+		}
+
+	/* DSP */
+	err = snd_msnd_write_cfg_logical(cfg[idx], 0,
+					 io[idx], 0,
+					 irq[idx], mem[idx]);
+
+	if (err)
+		goto cfg_error;
+
+	/* The following are Pinnacle specific */
+
+	/* MPU */
+	if (mpu_io[idx] != SNDRV_AUTO_PORT
+	    && mpu_irq[idx] != SNDRV_AUTO_IRQ) {
+		printk(KERN_INFO LOGNAME
+		       ": Configuring MPU to I/O 0x%lx IRQ %d\n",
+		       mpu_io[idx], mpu_irq[idx]);
+		err = snd_msnd_write_cfg_logical(cfg[idx], 1,
+						 mpu_io[idx], 0,
+						 mpu_irq[idx], 0);
+
+		if (err)
+			goto cfg_error;
+	}
+
+	/* IDE */
+	if (ide_io0[idx] != SNDRV_AUTO_PORT
+	    && ide_io1[idx] != SNDRV_AUTO_PORT
+	    && ide_irq[idx] != SNDRV_AUTO_IRQ) {
+		printk(KERN_INFO LOGNAME
+		       ": Configuring IDE to I/O 0x%lx, 0x%lx IRQ %d\n",
+		       ide_io0[idx], ide_io1[idx], ide_irq[idx]);
+		err = snd_msnd_write_cfg_logical(cfg[idx], 2,
+						 ide_io0[idx], ide_io1[idx],
+						 ide_irq[idx], 0);
+
+		if (err)
+			goto cfg_error;
+	}
+
+	/* Joystick */
+	if (joystick_io[idx] != SNDRV_AUTO_PORT) {
+		printk(KERN_INFO LOGNAME
+		       ": Configuring joystick to I/O 0x%lx\n",
+		       joystick_io[idx]);
+		err = snd_msnd_write_cfg_logical(cfg[idx], 3,
+						 joystick_io[idx], 0,
+						 0, 0);
+
+		if (err)
+			goto cfg_error;
+	}
+	release_region(cfg[idx], 2);
+
+#endif /* MSND_CLASSIC */
+
+	set_default_audio_parameters(chip);
+#ifdef MSND_CLASSIC
+	chip->type = msndClassic;
+#else
+	chip->type = msndPinnacle;
+#endif
+	chip->io = io[idx];
+	chip->irq = irq[idx];
+	chip->base = mem[idx];
+
+	chip->calibrate_signal = calibrate_signal ? 1 : 0;
+	chip->recsrc = 0;
+	chip->dspq_data_buff = DSPQ_DATA_BUFF;
+	chip->dspq_buff_size = DSPQ_BUFF_SIZE;
+	if (write_ndelay[idx])
+		clear_bit(F_DISABLE_WRITE_NDELAY, &chip->flags);
+	else
+		set_bit(F_DISABLE_WRITE_NDELAY, &chip->flags);
+#ifndef MSND_CLASSIC
+	if (digital[idx])
+		set_bit(F_HAVEDIGITAL, &chip->flags);
+#endif
+	spin_lock_init(&chip->lock);
+	err = snd_msnd_probe(card);
+	if (err < 0) {
+		printk(KERN_ERR LOGNAME ": Probe failed\n");
+		snd_card_free(card);
+		return err;
+	}
+
+	err = snd_msnd_attach(card);
+	if (err < 0) {
+		printk(KERN_ERR LOGNAME ": Attach failed\n");
+		snd_card_free(card);
+		return err;
+	}
+	dev_set_drvdata(pdev, card);
+
+	return 0;
+
+#ifndef MSND_CLASSIC
+cfg_error:
+	release_region(cfg[idx], 2);
+	snd_card_free(card);
+	return err;
+#endif
+}
+
+static int __devexit snd_msnd_isa_remove(struct device *pdev, unsigned int dev)
+{
+	snd_msnd_unload(dev_get_drvdata(pdev));
+	dev_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+#define DEV_NAME "msnd-pinnacle"
+
+static struct isa_driver snd_msnd_driver = {
+	.match		= snd_msnd_isa_match,
+	.probe		= snd_msnd_isa_probe,
+	.remove		= __devexit_p(snd_msnd_isa_remove),
+	/* FIXME: suspend, resume */
+	.driver		= {
+		.name	= DEV_NAME
+	},
+};
+
+#ifdef CONFIG_PNP
+static int __devinit snd_msnd_pnp_detect(struct pnp_card_link *pcard,
+					 const struct pnp_card_device_id *pid)
+{
+	static int idx;
+	struct pnp_dev *pnp_dev;
+	struct pnp_dev *mpu_dev;
+	struct snd_card *card;
+	struct snd_msnd *chip;
+	int ret;
+
+	for ( ; idx < SNDRV_CARDS; idx++) {
+		if (isapnp[idx])
+			break;
+	}
+	if (idx >= SNDRV_CARDS)
+		return -ENODEV;
+
+	/*
+	 * Check that we still have room for another sound card ...
+	 */
+	pnp_dev = pnp_request_card_device(pcard, pid->devs[0].id, NULL);
+	if (!pnp_dev)
+		return -ENODEV;
+
+	mpu_dev = pnp_request_card_device(pcard, pid->devs[1].id, NULL);
+	if (!mpu_dev)
+		return -ENODEV;
+
+	if (!pnp_is_active(pnp_dev) && pnp_activate_dev(pnp_dev) < 0) {
+		printk(KERN_INFO "msnd_pinnacle: device is inactive\n");
+		return -EBUSY;
+	}
+
+	if (!pnp_is_active(mpu_dev) && pnp_activate_dev(mpu_dev) < 0) {
+		printk(KERN_INFO "msnd_pinnacle: MPU device is inactive\n");
+		return -EBUSY;
+	}
+
+	/*
+	 * Create a new ALSA sound card entry, in anticipation
+	 * of detecting our hardware ...
+	 */
+	card = snd_card_new(index[idx], id[idx], THIS_MODULE,
+			    sizeof(struct snd_msnd));
+	if (!card)
+		return -ENOMEM;
+
+	chip = card->private_data;
+	chip->card = card;
+	snd_card_set_dev(card, &pcard->card->dev);
+
+	/*
+	 * Read the correct parameters off the ISA PnP bus ...
+	 */
+	io[idx] = pnp_port_start(pnp_dev, 0);
+	irq[idx] = pnp_irq(pnp_dev, 0);
+	mem[idx] = pnp_mem_start(pnp_dev, 0);
+	mpu_io[idx] = pnp_port_start(mpu_dev, 0);
+	mpu_irq[idx] = pnp_irq(mpu_dev, 0);
+
+	set_default_audio_parameters(chip);
+#ifdef MSND_CLASSIC
+	chip->type = msndClassic;
+#else
+	chip->type = msndPinnacle;
+#endif
+	chip->io = io[idx];
+	chip->irq = irq[idx];
+	chip->base = mem[idx];
+
+	chip->calibrate_signal = calibrate_signal ? 1 : 0;
+	chip->recsrc = 0;
+	chip->dspq_data_buff = DSPQ_DATA_BUFF;
+	chip->dspq_buff_size = DSPQ_BUFF_SIZE;
+	if (write_ndelay[idx])
+		clear_bit(F_DISABLE_WRITE_NDELAY, &chip->flags);
+	else
+		set_bit(F_DISABLE_WRITE_NDELAY, &chip->flags);
+#ifndef MSND_CLASSIC
+	if (digital[idx])
+		set_bit(F_HAVEDIGITAL, &chip->flags);
+#endif
+	spin_lock_init(&chip->lock);
+	ret = snd_msnd_probe(card);
+	if (ret < 0) {
+		printk(KERN_ERR LOGNAME ": Probe failed\n");
+		goto _release_card;
+	}
+
+	ret = snd_msnd_attach(card);
+	if (ret < 0) {
+		printk(KERN_ERR LOGNAME ": Attach failed\n");
+		goto _release_card;
+	}
+
+	pnp_set_card_drvdata(pcard, card);
+	++idx;
+	return 0;
+
+_release_card:
+	snd_card_free(card);
+	return ret;
+}
+
+static void __devexit snd_msnd_pnp_remove(struct pnp_card_link *pcard)
+{
+	snd_msnd_unload(pnp_get_card_drvdata(pcard));
+	pnp_set_card_drvdata(pcard, NULL);
+}
+
+static int isa_registered;
+static int pnp_registered;
+
+static struct pnp_card_device_id msnd_pnpids[] = {
+	/* Pinnacle PnP */
+	{ .id = "BVJ0440", .devs = { { "TBS0000" }, { "TBS0001" } } },
+	{ .id = "" }	/* end */
+};
+
+MODULE_DEVICE_TABLE(pnp_card, msnd_pnpids);
+
+static struct pnp_card_driver msnd_pnpc_driver = {
+	.flags = PNP_DRIVER_RES_DO_NOT_CHANGE,
+	.name = "msnd_pinnacle",
+	.id_table = msnd_pnpids,
+	.probe = snd_msnd_pnp_detect,
+	.remove = __devexit_p(snd_msnd_pnp_remove),
+};
+#endif /* CONFIG_PNP */
+
+static int __init snd_msnd_init(void)
+{
+	int err;
+
+	err = isa_register_driver(&snd_msnd_driver, SNDRV_CARDS);
+#ifdef CONFIG_PNP
+	if (!err)
+		isa_registered = 1;
+
+	err = pnp_register_card_driver(&msnd_pnpc_driver);
+	if (!err)
+		pnp_registered = 1;
+
+	if (isa_registered)
+		err = 0;
+#endif
+	return err;
+}
+
+static void __exit snd_msnd_exit(void)
+{
+#ifdef CONFIG_PNP
+	if (pnp_registered)
+		pnp_unregister_card_driver(&msnd_pnpc_driver);
+	if (isa_registered)
+#endif
+		isa_unregister_driver(&snd_msnd_driver);
+}
+
+module_init(snd_msnd_init);
+module_exit(snd_msnd_exit);
+
diff --git a/sound/isa/msnd/msnd_pinnacle.h b/sound/isa/msnd/msnd_pinnacle.h
new file mode 100644
index 0000000..d1ddbb8
--- /dev/null
+++ b/sound/isa/msnd/msnd_pinnacle.h
@@ -0,0 +1,222 @@
+/*********************************************************************
+ *
+ * msnd_pinnacle.h
+ *
+ * Turtle Beach MultiSound Sound Card Driver for Linux
+ *
+ * Some parts of this header file were derived from the Turtle Beach
+ * MultiSound Driver Development Kit.
+ *
+ * Copyright (C) 1998 Andrew Veliath
+ * Copyright (C) 1993 Turtle Beach Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ ********************************************************************/
+#ifndef __MSND_PINNACLE_H
+#define __MSND_PINNACLE_H
+
+#define DSP_NUMIO				0x08
+
+#define IREG_LOGDEVICE				0x07
+#define IREG_ACTIVATE				0x30
+#define LD_ACTIVATE				0x01
+#define LD_DISACTIVATE				0x00
+#define IREG_EECONTROL				0x3F
+#define IREG_MEMBASEHI				0x40
+#define IREG_MEMBASELO				0x41
+#define IREG_MEMCONTROL				0x42
+#define IREG_MEMRANGEHI				0x43
+#define IREG_MEMRANGELO				0x44
+#define MEMTYPE_8BIT				0x00
+#define MEMTYPE_16BIT				0x02
+#define MEMTYPE_RANGE				0x00
+#define MEMTYPE_HIADDR				0x01
+#define IREG_IO0_BASEHI				0x60
+#define IREG_IO0_BASELO				0x61
+#define IREG_IO1_BASEHI				0x62
+#define IREG_IO1_BASELO				0x63
+#define IREG_IRQ_NUMBER				0x70
+#define IREG_IRQ_TYPE				0x71
+#define IRQTYPE_HIGH				0x02
+#define IRQTYPE_LOW				0x00
+#define IRQTYPE_LEVEL				0x01
+#define IRQTYPE_EDGE				0x00
+
+#define	HP_DSPR					0x04
+#define	HP_BLKS					0x04
+
+#define HPDSPRESET_OFF				2
+#define HPDSPRESET_ON				0
+
+#define HPBLKSEL_0				2
+#define HPBLKSEL_1				3
+
+#define	HIMT_DAT_OFF				0x03
+
+#define	HIDSP_PLAY_UNDER			0x00
+#define	HIDSP_INT_PLAY_UNDER			0x01
+#define	HIDSP_SSI_TX_UNDER  			0x02
+#define HIDSP_RECQ_OVERFLOW			0x08
+#define HIDSP_INT_RECORD_OVER			0x09
+#define HIDSP_SSI_RX_OVERFLOW			0x0a
+
+#define	HIDSP_MIDI_IN_OVER			0x10
+
+#define	HIDSP_MIDI_FRAME_ERR			0x11
+#define	HIDSP_MIDI_PARITY_ERR			0x12
+#define	HIDSP_MIDI_OVERRUN_ERR			0x13
+
+#define HIDSP_INPUT_CLIPPING			0x20
+#define	HIDSP_MIX_CLIPPING			0x30
+#define HIDSP_DAT_IN_OFF			0x21
+
+#define	HDEXAR_SET_ANA_IN			0
+#define	HDEXAR_CLEAR_PEAKS			1
+#define	HDEXAR_IN_SET_POTS			2
+#define	HDEXAR_AUX_SET_POTS			3
+#define	HDEXAR_CAL_A_TO_D			4
+#define	HDEXAR_RD_EXT_DSP_BITS			5
+
+#define	HDEXAR_SET_SYNTH_IN			4
+#define	HDEXAR_READ_DAT_IN			5
+#define	HDEXAR_MIC_SET_POTS			6
+#define	HDEXAR_SET_DAT_IN			7
+
+#define HDEXAR_SET_SYNTH_48			8
+#define HDEXAR_SET_SYNTH_44			9
+
+#define TIME_PRO_RESET_DONE			0x028A
+#define TIME_PRO_SYSEX				0x001E
+#define TIME_PRO_RESET				0x0032
+
+#define DAR_BUFF_SIZE				0x1000
+
+#define MIDQ_BUFF_SIZE				0x800
+#define DSPQ_BUFF_SIZE				0x5A0
+
+#define DSPQ_DATA_BUFF				0x7860
+
+#define MOP_WAVEHDR				0
+#define MOP_EXTOUT				1
+#define MOP_HWINIT				0xfe
+#define MOP_NONE				0xff
+#define MOP_MAX					1
+
+#define MIP_EXTIN				0
+#define MIP_WAVEHDR				1
+#define MIP_HWINIT				0xfe
+#define MIP_MAX					1
+
+/* Pinnacle/Fiji SMA Common Data */
+#define SMA_wCurrPlayBytes			0x0000
+#define SMA_wCurrRecordBytes			0x0002
+#define SMA_wCurrPlayVolLeft			0x0004
+#define SMA_wCurrPlayVolRight			0x0006
+#define SMA_wCurrInVolLeft			0x0008
+#define SMA_wCurrInVolRight			0x000a
+#define SMA_wCurrMHdrVolLeft			0x000c
+#define SMA_wCurrMHdrVolRight			0x000e
+#define SMA_dwCurrPlayPitch			0x0010
+#define SMA_dwCurrPlayRate			0x0014
+#define SMA_wCurrMIDIIOPatch			0x0018
+#define SMA_wCurrPlayFormat			0x001a
+#define SMA_wCurrPlaySampleSize			0x001c
+#define SMA_wCurrPlayChannels			0x001e
+#define SMA_wCurrPlaySampleRate			0x0020
+#define SMA_wCurrRecordFormat			0x0022
+#define SMA_wCurrRecordSampleSize		0x0024
+#define SMA_wCurrRecordChannels			0x0026
+#define SMA_wCurrRecordSampleRate		0x0028
+#define SMA_wCurrDSPStatusFlags			0x002a
+#define SMA_wCurrHostStatusFlags		0x002c
+#define SMA_wCurrInputTagBits			0x002e
+#define SMA_wCurrLeftPeak			0x0030
+#define SMA_wCurrRightPeak			0x0032
+#define SMA_bMicPotPosLeft			0x0034
+#define SMA_bMicPotPosRight			0x0035
+#define SMA_bMicPotMaxLeft			0x0036
+#define SMA_bMicPotMaxRight			0x0037
+#define SMA_bInPotPosLeft			0x0038
+#define SMA_bInPotPosRight			0x0039
+#define SMA_bAuxPotPosLeft			0x003a
+#define SMA_bAuxPotPosRight			0x003b
+#define SMA_bInPotMaxLeft			0x003c
+#define SMA_bInPotMaxRight			0x003d
+#define SMA_bAuxPotMaxLeft			0x003e
+#define SMA_bAuxPotMaxRight			0x003f
+#define SMA_bInPotMaxMethod			0x0040
+#define SMA_bAuxPotMaxMethod			0x0041
+#define SMA_wCurrMastVolLeft			0x0042
+#define SMA_wCurrMastVolRight			0x0044
+#define SMA_wCalFreqAtoD			0x0046
+#define SMA_wCurrAuxVolLeft			0x0048
+#define SMA_wCurrAuxVolRight			0x004a
+#define SMA_wCurrPlay1VolLeft			0x004c
+#define SMA_wCurrPlay1VolRight			0x004e
+#define SMA_wCurrPlay2VolLeft			0x0050
+#define SMA_wCurrPlay2VolRight			0x0052
+#define SMA_wCurrPlay3VolLeft			0x0054
+#define SMA_wCurrPlay3VolRight			0x0056
+#define SMA_wCurrPlay4VolLeft			0x0058
+#define SMA_wCurrPlay4VolRight			0x005a
+#define SMA_wCurrPlay1PeakLeft			0x005c
+#define SMA_wCurrPlay1PeakRight			0x005e
+#define SMA_wCurrPlay2PeakLeft			0x0060
+#define SMA_wCurrPlay2PeakRight			0x0062
+#define SMA_wCurrPlay3PeakLeft			0x0064
+#define SMA_wCurrPlay3PeakRight			0x0066
+#define SMA_wCurrPlay4PeakLeft			0x0068
+#define SMA_wCurrPlay4PeakRight			0x006a
+#define SMA_wCurrPlayPeakLeft			0x006c
+#define SMA_wCurrPlayPeakRight			0x006e
+#define SMA_wCurrDATSR				0x0070
+#define SMA_wCurrDATRXCHNL			0x0072
+#define SMA_wCurrDATTXCHNL			0x0074
+#define SMA_wCurrDATRXRate			0x0076
+#define SMA_dwDSPPlayCount			0x0078
+#define SMA__size				0x007c
+
+#ifdef HAVE_DSPCODEH
+#  include "pndsperm.c"
+#  include "pndspini.c"
+#  define PERMCODE		pndsperm
+#  define INITCODE		pndspini
+#  define PERMCODESIZE		sizeof(pndsperm)
+#  define INITCODESIZE		sizeof(pndspini)
+#else
+#  ifndef CONFIG_MSNDPIN_INIT_FILE
+#    define CONFIG_MSNDPIN_INIT_FILE "turtlebeach/pndspini.bin"
+#  endif
+#  ifndef CONFIG_MSNDPIN_PERM_FILE
+#    define CONFIG_MSNDPIN_PERM_FILE "turtlebeach/pndsperm.bin"
+#  endif
+#  define PERMCODEFILE		CONFIG_MSNDPIN_PERM_FILE
+#  define INITCODEFILE		CONFIG_MSNDPIN_INIT_FILE
+#  define PERMCODE		dspini
+#  define INITCODE		permini
+#  define PERMCODESIZE		sizeof_dspini
+#  define INITCODESIZE		sizeof_permini
+#endif
+#define LONGNAME		"MultiSound (Pinnacle/Fiji)"
+
+int snd_msnd_send_dsp_cmd_chk(struct snd_msnd *chip, register u8 cmd);
+
+/* functions from external mixer file */
+void snd_msndmix_setup(struct snd_msnd *chip);
+unsigned long snd_msndmix_force_recsrc(struct snd_msnd *chip, int recsrc);
+int __devinit snd_msndmix_new(struct snd_card *card);
+
+#endif /* __MSND_PINNACLE_H */
diff --git a/sound/isa/msnd/msnd_pinnacle_mixer.c b/sound/isa/msnd/msnd_pinnacle_mixer.c
new file mode 100644
index 0000000..3f26aac
--- /dev/null
+++ b/sound/isa/msnd/msnd_pinnacle_mixer.c
@@ -0,0 +1,345 @@
+/***************************************************************************
+			  msnd_pinnacle_mixer.c  -  description
+			     -------------------
+    begin		: Fre Jun 7 2002
+    copyright 		: (C) 2002 by karsten wiese
+    email		: annabellesgarden@yahoo.de
+ ***************************************************************************/
+
+/***************************************************************************
+ *							      		   *
+ *   This program is free software; you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation; either version 2 of the License, or     *
+ *   (at your option) any later version.				   *
+ *									   *
+ ***************************************************************************/
+
+#include <linux/io.h>
+
+#include <sound/core.h>
+#include <sound/control.h>
+#include "msnd.h"
+#include "msnd_pinnacle.h"
+
+
+#define MSND_MIXER_VOLUME	0
+#define MSND_MIXER_PCM		1
+#define MSND_MIXER_AUX		2	/* Input source 1  (aux1) */
+#define MSND_MIXER_IMIX		3	/*  Recording monitor  */
+#define MSND_MIXER_SYNTH	4
+#define MSND_MIXER_SPEAKER	5
+#define MSND_MIXER_LINE		6
+#define MSND_MIXER_MIC		7
+#define MSND_MIXER_RECLEV	11	/* Recording level */
+#define MSND_MIXER_IGAIN	12	/* Input gain */
+#define MSND_MIXER_OGAIN	13	/* Output gain */
+#define MSND_MIXER_DIGITAL	17	/* Digital (input) 1 */
+
+/*	Device mask bits	*/
+
+#define MSND_MASK_VOLUME	(1 << MSND_MIXER_VOLUME)
+#define MSND_MASK_SYNTH		(1 << MSND_MIXER_SYNTH)
+#define MSND_MASK_PCM		(1 << MSND_MIXER_PCM)
+#define MSND_MASK_SPEAKER	(1 << MSND_MIXER_SPEAKER)
+#define MSND_MASK_LINE		(1 << MSND_MIXER_LINE)
+#define MSND_MASK_MIC		(1 << MSND_MIXER_MIC)
+#define MSND_MASK_IMIX		(1 << MSND_MIXER_IMIX)
+#define MSND_MASK_RECLEV	(1 << MSND_MIXER_RECLEV)
+#define MSND_MASK_IGAIN		(1 << MSND_MIXER_IGAIN)
+#define MSND_MASK_OGAIN		(1 << MSND_MIXER_OGAIN)
+#define MSND_MASK_AUX		(1 << MSND_MIXER_AUX)
+#define MSND_MASK_DIGITAL	(1 << MSND_MIXER_DIGITAL)
+
+static int snd_msndmix_info_mux(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[3] = {
+		"Analog", "MASS", "SPDIF",
+	};
+	struct snd_msnd *chip = snd_kcontrol_chip(kcontrol);
+	unsigned items = test_bit(F_HAVEDIGITAL, &chip->flags) ? 3 : 2;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = items;
+	if (uinfo->value.enumerated.item >= items)
+		uinfo->value.enumerated.item = items - 1;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_msndmix_get_mux(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_msnd *chip = snd_kcontrol_chip(kcontrol);
+	/* MSND_MASK_IMIX is the default */
+	ucontrol->value.enumerated.item[0] = 0;
+
+	if (chip->recsrc & MSND_MASK_SYNTH) {
+		ucontrol->value.enumerated.item[0] = 1;
+	} else if ((chip->recsrc & MSND_MASK_DIGITAL) &&
+		 test_bit(F_HAVEDIGITAL, &chip->flags)) {
+		ucontrol->value.enumerated.item[0] = 2;
+	}
+
+
+	return 0;
+}
+
+static int snd_msndmix_set_mux(struct snd_msnd *chip, int val)
+{
+	unsigned newrecsrc;
+	int change;
+	unsigned char msndbyte;
+
+	switch (val) {
+	case 0:
+		newrecsrc = MSND_MASK_IMIX;
+		msndbyte = HDEXAR_SET_ANA_IN;
+		break;
+	case 1:
+		newrecsrc = MSND_MASK_SYNTH;
+		msndbyte = HDEXAR_SET_SYNTH_IN;
+		break;
+	case 2:
+		newrecsrc = MSND_MASK_DIGITAL;
+		msndbyte = HDEXAR_SET_DAT_IN;
+		break;
+	default:
+		return -EINVAL;
+	}
+	change  = newrecsrc != chip->recsrc;
+	if (change) {
+		change = 0;
+		if (!snd_msnd_send_word(chip, 0, 0, msndbyte))
+			if (!snd_msnd_send_dsp_cmd_chk(chip, HDEX_AUX_REQ)) {
+				chip->recsrc = newrecsrc;
+				change = 1;
+			}
+	}
+	return change;
+}
+
+
+static int snd_msndmix_put_mux(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_msnd *msnd = snd_kcontrol_chip(kcontrol);
+	return snd_msndmix_set_mux(msnd, ucontrol->value.enumerated.item[0]);
+}
+
+
+static int snd_msndmix_volume_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 100;
+	return 0;
+}
+
+static int snd_msndmix_volume_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_msnd *msnd = snd_kcontrol_chip(kcontrol);
+	int addr = kcontrol->private_value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&msnd->mixer_lock, flags);
+	ucontrol->value.integer.value[0] = msnd->left_levels[addr] * 100;
+	ucontrol->value.integer.value[0] /= 0xFFFF;
+	ucontrol->value.integer.value[1] = msnd->right_levels[addr] * 100;
+	ucontrol->value.integer.value[1] /= 0xFFFF;
+	spin_unlock_irqrestore(&msnd->mixer_lock, flags);
+	return 0;
+}
+
+
+#define update_volm(a, b)						\
+	do {								\
+		writew((dev->left_levels[a] >> 1) *			\
+		       readw(dev->SMA + SMA_wCurrMastVolLeft) / 0xffff,	\
+		       dev->SMA + SMA_##b##Left);			\
+		writew((dev->right_levels[a] >> 1)  *			\
+		       readw(dev->SMA + SMA_wCurrMastVolRight) / 0xffff, \
+		       dev->SMA + SMA_##b##Right);			\
+	} while (0);
+
+#define update_potm(d, s, ar)						\
+	do {								\
+		writeb((dev->left_levels[d] >> 8) *			\
+		       readw(dev->SMA + SMA_wCurrMastVolLeft) / 0xffff, \
+		       dev->SMA + SMA_##s##Left);			\
+		writeb((dev->right_levels[d] >> 8) *			\
+		       readw(dev->SMA + SMA_wCurrMastVolRight) / 0xffff, \
+		       dev->SMA + SMA_##s##Right);			\
+		if (snd_msnd_send_word(dev, 0, 0, ar) == 0)		\
+			snd_msnd_send_dsp_cmd_chk(dev, HDEX_AUX_REQ);	\
+	} while (0);
+
+#define update_pot(d, s, ar)						\
+	do {								\
+		writeb(dev->left_levels[d] >> 8,			\
+		       dev->SMA + SMA_##s##Left);			\
+		writeb(dev->right_levels[d] >> 8,			\
+		       dev->SMA + SMA_##s##Right);			\
+		if (snd_msnd_send_word(dev, 0, 0, ar) == 0)		\
+			snd_msnd_send_dsp_cmd_chk(dev, HDEX_AUX_REQ);	\
+	} while (0);
+
+
+static int snd_msndmix_set(struct snd_msnd *dev, int d, int left, int right)
+{
+	int bLeft, bRight;
+	int wLeft, wRight;
+	int updatemaster = 0;
+
+	if (d >= LEVEL_ENTRIES)
+		return -EINVAL;
+
+	bLeft = left * 0xff / 100;
+	wLeft = left * 0xffff / 100;
+
+	bRight = right * 0xff / 100;
+	wRight = right * 0xffff / 100;
+
+	dev->left_levels[d] = wLeft;
+	dev->right_levels[d] = wRight;
+
+	switch (d) {
+		/* master volume unscaled controls */
+	case MSND_MIXER_LINE:			/* line pot control */
+		/* scaled by IMIX in digital mix */
+		writeb(bLeft, dev->SMA + SMA_bInPotPosLeft);
+		writeb(bRight, dev->SMA + SMA_bInPotPosRight);
+		if (snd_msnd_send_word(dev, 0, 0, HDEXAR_IN_SET_POTS) == 0)
+			snd_msnd_send_dsp_cmd_chk(dev, HDEX_AUX_REQ);
+		break;
+#ifndef MSND_CLASSIC
+	case MSND_MIXER_MIC:			/* mic pot control */
+		/* scaled by IMIX in digital mix */
+		writeb(bLeft, dev->SMA + SMA_bMicPotPosLeft);
+		writeb(bRight, dev->SMA + SMA_bMicPotPosRight);
+		if (snd_msnd_send_word(dev, 0, 0, HDEXAR_MIC_SET_POTS) == 0)
+			snd_msnd_send_dsp_cmd_chk(dev, HDEX_AUX_REQ);
+		break;
+#endif
+	case MSND_MIXER_VOLUME:		/* master volume */
+		writew(wLeft, dev->SMA + SMA_wCurrMastVolLeft);
+		writew(wRight, dev->SMA + SMA_wCurrMastVolRight);
+		/* fall through */
+
+	case MSND_MIXER_AUX:			/* aux pot control */
+		/* scaled by master volume */
+		/* fall through */
+
+		/* digital controls */
+	case MSND_MIXER_SYNTH:			/* synth vol (dsp mix) */
+	case MSND_MIXER_PCM:			/* pcm vol (dsp mix) */
+	case MSND_MIXER_IMIX:			/* input monitor (dsp mix) */
+		/* scaled by master volume */
+		updatemaster = 1;
+		break;
+
+	default:
+		return 0;
+	}
+
+	if (updatemaster) {
+		/* update master volume scaled controls */
+		update_volm(MSND_MIXER_PCM, wCurrPlayVol);
+		update_volm(MSND_MIXER_IMIX, wCurrInVol);
+#ifndef MSND_CLASSIC
+		update_volm(MSND_MIXER_SYNTH, wCurrMHdrVol);
+#endif
+		update_potm(MSND_MIXER_AUX, bAuxPotPos, HDEXAR_AUX_SET_POTS);
+	}
+
+	return 0;
+}
+
+static int snd_msndmix_volume_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_msnd *msnd = snd_kcontrol_chip(kcontrol);
+	int change, addr = kcontrol->private_value;
+	int left, right;
+	unsigned long flags;
+
+	left = ucontrol->value.integer.value[0] % 101;
+	right = ucontrol->value.integer.value[1] % 101;
+	spin_lock_irqsave(&msnd->mixer_lock, flags);
+	change = msnd->left_levels[addr] != left
+		|| msnd->right_levels[addr] != right;
+	snd_msndmix_set(msnd, addr, left, right);
+	spin_unlock_irqrestore(&msnd->mixer_lock, flags);
+	return change;
+}
+
+
+#define DUMMY_VOLUME(xname, xindex, addr) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
+  .info = snd_msndmix_volume_info, \
+  .get = snd_msndmix_volume_get, .put = snd_msndmix_volume_put, \
+  .private_value = addr }
+
+
+static struct snd_kcontrol_new snd_msnd_controls[] = {
+DUMMY_VOLUME("Master Volume", 0, MSND_MIXER_VOLUME),
+DUMMY_VOLUME("PCM Volume", 0, MSND_MIXER_PCM),
+DUMMY_VOLUME("Aux Volume", 0, MSND_MIXER_AUX),
+DUMMY_VOLUME("Line Volume", 0, MSND_MIXER_LINE),
+DUMMY_VOLUME("Mic Volume", 0, MSND_MIXER_MIC),
+DUMMY_VOLUME("Monitor",	0, MSND_MIXER_IMIX),
+{
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Capture Source",
+	.info = snd_msndmix_info_mux,
+	.get = snd_msndmix_get_mux,
+	.put = snd_msndmix_put_mux,
+}
+};
+
+
+int __devinit snd_msndmix_new(struct snd_card *card)
+{
+	struct snd_msnd *chip = card->private_data;
+	unsigned int idx;
+	int err;
+
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+	spin_lock_init(&chip->mixer_lock);
+	strcpy(card->mixername, "MSND Pinnacle Mixer");
+
+	for (idx = 0; idx < ARRAY_SIZE(snd_msnd_controls); idx++)
+		err = snd_ctl_add(card,
+				  snd_ctl_new1(snd_msnd_controls + idx, chip));
+		if (err < 0)
+			return err;
+
+	return 0;
+}
+
+void snd_msndmix_setup(struct snd_msnd *dev)
+{
+	update_pot(MSND_MIXER_LINE, bInPotPos, HDEXAR_IN_SET_POTS);
+	update_potm(MSND_MIXER_AUX, bAuxPotPos, HDEXAR_AUX_SET_POTS);
+	update_volm(MSND_MIXER_PCM, wCurrPlayVol);
+	update_volm(MSND_MIXER_IMIX, wCurrInVol);
+#ifndef MSND_CLASSIC
+	update_pot(MSND_MIXER_MIC, bMicPotPos, HDEXAR_MIC_SET_POTS);
+	update_volm(MSND_MIXER_SYNTH, wCurrMHdrVol);
+#endif
+
+}
+
+unsigned long snd_msndmix_force_recsrc(struct snd_msnd *dev, int recsrc)
+{
+	dev->recsrc = -1;
+	return snd_msndmix_set_mux(dev, recsrc);
+}
+


----------------------------------------------------------------------
Sprawdz, co wyswietlaja kina w Twoim miescie!
http://link.interia.pl/f2028
