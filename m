From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] Audigy LS support.
Date: Thu, 27 May 2004 20:17:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40B63EBD.6060407@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020107090903040600080009"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net [194.217.242.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA30537
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2004 21:17:01 +0200
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-31.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BTQN8-000B1S-0V
	for alsa-devel@alsa-project.org; Thu, 27 May 2004 20:16:58 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020107090903040600080009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is my first go at Audigy LS support.
It can play sound to the front speakers.
Only one mixer volume control does anything, that is the "Front Volume" 
control in alsamixer.

I attach 2 files. One is a new audigyls.c, and the other is a patch to 
get alsa-driver to build with it.

audigyls.c should be added to directory ./alsa-driver/pci/emu10k1/

Support for more output channels will be added later, but this is just a 
proof of concept, so that other people wishing to write audigyls drivers 
for other operating systems can make a start.

Cheers
James

--------------020107090903040600080009
Content-Type: text/plain;
 name="audigyls.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigyls.diff.txt"

Index: alsa-driver/pci/Kconfig
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/Kconfig,v
retrieving revision 1.19
diff -u -r1.19 Kconfig
--- alsa-driver/pci/Kconfig	24 May 2004 13:27:31 -0000	1.19
+++ alsa-driver/pci/Kconfig	27 May 2004 18:35:31 -0000
@@ -26,6 +26,14 @@
 	  Say 'Y' or 'M' to include support for Sound Blaster Live Dell
 	  OEM version.
 
+config SND_AUDIGYLS
+	tristate "SB Audigy LS"
+	depends on SND
+	select SND_AC97_CODEC
+	help
+	  Say 'Y' or 'M' to include support for Sound Blaster Live Dell
+	  OEM version.
+
 config SND_ATIIXP_MODEM
 	tristate "ATI IXP 150/200/250 Modem"
 	depends on SND
Index: alsa-driver/pci/emu10k1/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/Makefile,v
retrieving revision 1.6
diff -u -r1.6 Makefile
--- alsa-driver/pci/emu10k1/Makefile	14 May 2004 13:42:49 -0000	1.6
+++ alsa-driver/pci/emu10k1/Makefile	27 May 2004 18:35:31 -0000
@@ -6,8 +6,10 @@
 include $(SND_TOPDIR)/Makefile.conf
 
 snd-emu10k1x-objs := emu10k1x.o
+snd-audigyls-objs := audigyls.o
 
 obj-$(CONFIG_SND_EMU10K1X) += snd-emu10k1x.o
+obj-$(CONFIG_SND_AUDIGYLS) += snd-audigyls.o
 
 export-objs  := emu10k1_main.o
 

--------------020107090903040600080009
Content-Type: text/x-csrc;
 name="audigyls.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigyls.c"

/*
 *  Copyright (c) by James Courtier-Dutton <James@superbug.demon.co.uk>
 *  Driver AUDIGYLS chips
 *
 *  BUGS:
 *    --
 *
 *  TODO:
 *    Surround and Center/LFE playback.
 *    Capture.
 *    SPDIF playback.
 *    Other rates apart from 48khz.
 *    MIDI
 *    --
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 */
#include <sound/driver.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/pci.h>
#include <linux/slab.h>
#include <linux/moduleparam.h>
#include <sound/core.h>
#include <sound/initval.h>
#include <sound/pcm.h>
#include <sound/ac97_codec.h>
#include <sound/info.h>

MODULE_AUTHOR("James Courtier-Dutton <James@superbug.demon.co.uk>");
MODULE_DESCRIPTION("AUDIGYLS");
MODULE_LICENSE("GPL");
MODULE_CLASSES("{sound}");
MODULE_DEVICES("{{Creative SB Audigy LS}");

// module parameters (see "Module Parameters")
static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
static int boot_devs;

module_param_array(index, int, boot_devs, 0444);
MODULE_PARM_DESC(index, "Index value for the AUDIGYLS soundcard.");
MODULE_PARM_SYNTAX(index, SNDRV_INDEX_DESC);
module_param_array(id, charp, boot_devs, 0444);
MODULE_PARM_DESC(id, "ID string for the AUDIGYLS soundcard.");
MODULE_PARM_SYNTAX(id, SNDRV_ID_DESC);
module_param_array(enable, bool, boot_devs, 0444);
MODULE_PARM_DESC(enable, "Enable the AUDIGYLS soundcard.");
MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);


/************************************************************************************************/
/* PCI function 0 registers, address = <val> + PCIBASE0						*/
/************************************************************************************************/

#define PTR			0x00		/* Indexed register set pointer register	*/
						/* NOTE: The CHANNELNUM and ADDRESS words can	*/
						/* be modified independently of each other.	*/

#define DATA			0x04		/* Indexed register set data register		*/

#define IPR			0x08		/* Global interrupt pending register		*/
						/* Clear pending interrupts by writing a 1 to	*/
						/* the relevant bits and zero to the other bits	*/
#define IPR_CH_0_LOOP           0x00000800      /* Channel 0 loop                               */
#define IPR_CH_0_HALF_LOOP      0x00000100      /* Channel 0 half loop                          */

#define INTE			0x0c		/* Interrupt enable register			*/
#define INTE_CH_0_LOOP          0x00000800      /* Channel 0 loop                               */
#define INTE_CH_0_HALF_LOOP     0x00000100      /* Channel 0 half loop                          */

#define HCFG			0x14		/* Hardware config register			*/

#define HCFG_LOCKSOUNDCACHE	0x00000008	/* 1 = Cancel bustmaster accesses to soundcache */
						/* NOTE: This should generally never be used.  	*/
#define HCFG_AUDIOENABLE	0x00000001	/* 0 = CODECs transmit zero-valued samples	*/
						/* Should be set to 1 when the EMU10K1 is	*/
						/* completely initialized.			*/

/********************************************************************************************************/
/* Audigy LS pointer-offset register set, accessed through the PTR and DATA registers                     */
/********************************************************************************************************/
                                                                                                                           
#define AC97DATA		0x1c		/* AC97 register set data register (16 bit)	*/

#define AC97ADDRESS		0x1e		/* AC97 register set address register (8 bit)	*/

#define SPCS0			0x41		/* SPDIF output Channel Status 0 register	*/

#define SPCS_CLKACCYMASK	0x30000000	/* Clock accuracy				*/
#define SPCS_CLKACCY_1000PPM	0x00000000	/* 1000 parts per million			*/
#define SPCS_CLKACCY_50PPM	0x10000000	/* 50 parts per million				*/
#define SPCS_CLKACCY_VARIABLE	0x20000000	/* Variable accuracy				*/
#define SPCS_SAMPLERATEMASK	0x0f000000	/* Sample rate					*/
#define SPCS_SAMPLERATE_44	0x00000000	/* 44.1kHz sample rate				*/
#define SPCS_SAMPLERATE_48	0x02000000	/* 48kHz sample rate				*/
#define SPCS_SAMPLERATE_32	0x03000000	/* 32kHz sample rate				*/
#define SPCS_CHANNELNUMMASK	0x00f00000	/* Channel number				*/
#define SPCS_CHANNELNUM_UNSPEC	0x00000000	/* Unspecified channel number			*/
#define SPCS_CHANNELNUM_LEFT	0x00100000	/* Left channel					*/
#define SPCS_CHANNELNUM_RIGHT	0x00200000	/* Right channel				*/
#define SPCS_SOURCENUMMASK	0x000f0000	/* Source number				*/
#define SPCS_SOURCENUM_UNSPEC	0x00000000	/* Unspecified source number			*/
#define SPCS_GENERATIONSTATUS	0x00008000	/* Originality flag (see IEC-958 spec)		*/
#define SPCS_CATEGORYCODEMASK	0x00007f00	/* Category code (see IEC-958 spec)		*/
#define SPCS_MODEMASK		0x000000c0	/* Mode (see IEC-958 spec)			*/
#define SPCS_EMPHASISMASK	0x00000038	/* Emphasis					*/
#define SPCS_EMPHASIS_NONE	0x00000000	/* No emphasis					*/
#define SPCS_EMPHASIS_50_15	0x00000008	/* 50/15 usec 2 channel				*/
#define SPCS_COPYRIGHT		0x00000004	/* Copyright asserted flag -- do not modify	*/
#define SPCS_NOTAUDIODATA	0x00000002	/* 0 = Digital audio, 1 = not audio		*/
#define SPCS_PROFESSIONAL	0x00000001	/* 0 = Consumer (IEC-958), 1 = pro (AES3-1992)	*/

#define PLAYBACK_VOLUME         0x6a            /* Playback volume per voice */

#define chip_t audigyls_t

typedef struct snd_audigyls_voice audigyls_voice_t;
typedef struct snd_audigyls audigyls_t;
typedef struct snd_audigyls_pcm audigyls_pcm_t;

struct snd_audigyls_voice {
	audigyls_t *emu;
	int number;
	int use;
	void (*interrupt)(audigyls_t *emu, audigyls_voice_t *pvoice);
  
	audigyls_pcm_t *epcm;
};

struct snd_audigyls_pcm {
	audigyls_t *emu;
	snd_pcm_substream_t *substream;
	audigyls_voice_t *voice;
	unsigned short running;
};

// definition of the chip-specific record
struct snd_audigyls {
	snd_card_t *card;
	struct pci_dev *pci;

	unsigned long port;
	struct resource *res_port;
	int irq;

	unsigned int revision;		/* chip revision */
	unsigned int serial;            /* serial number */
	unsigned short model;		/* subsystem id */

	spinlock_t emu_lock;
	spinlock_t voice_lock;

	ac97_t *ac97;
	snd_pcm_t *pcm;

	audigyls_voice_t voices[3];

	struct snd_dma_device dma_dev;
	struct snd_dma_buffer buffer;
        snd_kcontrol_t *ctl_front_volume;
};

#define audigyls_t_magic        0xa15a4501
#define audigyls_pcm_t_magic	0xa15a4502

/* hardware definition */
static snd_pcm_hardware_t snd_audigyls_playback_hw = {
	.info =			(SNDRV_PCM_INFO_MMAP | 
				 SNDRV_PCM_INFO_INTERLEAVED |
				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
				 SNDRV_PCM_INFO_MMAP_VALID),
	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
	.rates =		SNDRV_PCM_RATE_48000,
	.rate_min =		48000,
	.rate_max =		48000,
	.channels_min =		2,
	.channels_max =		2,
	.buffer_bytes_max =	(32*1024),
	.period_bytes_min =	64,
	.period_bytes_max =	(16*1024),
	.periods_min =		2,
	.periods_max =		16,
	.fifo_size =		0,
};

static unsigned int snd_audigyls_ptr_read(audigyls_t * emu, 
					  unsigned int reg, 
					  unsigned int chn)
{
	unsigned long flags;
	unsigned int regptr, val;
  
	regptr = (reg << 16) | chn;

	spin_lock_irqsave(&emu->emu_lock, flags);
	outl(regptr, emu->port + PTR);
	val = inl(emu->port + DATA);
	spin_unlock_irqrestore(&emu->emu_lock, flags);
	return val;
}

static void snd_audigyls_ptr_write(audigyls_t *emu, 
				   unsigned int reg, 
				   unsigned int chn, 
				   unsigned int data)
{
	unsigned int regptr;
	unsigned long flags;

	regptr = (reg << 16) | chn;

	spin_lock_irqsave(&emu->emu_lock, flags);
	outl(regptr, emu->port + PTR);
	outl(data, emu->port + DATA);
	spin_unlock_irqrestore(&emu->emu_lock, flags);
}

static void snd_audigyls_intr_enable(audigyls_t *emu, unsigned int intrenb)
{
	unsigned long flags;
	unsigned int enable;
  
	spin_lock_irqsave(&emu->emu_lock, flags);
	enable = inl(emu->port + INTE) | intrenb;
	outl(enable, emu->port + INTE);
	spin_unlock_irqrestore(&emu->emu_lock, flags);
}

static int voice_alloc(audigyls_t *emu, audigyls_voice_t **rvoice)
{
	audigyls_voice_t *voice;
	int idx;

	*rvoice = NULL;
	for (idx = 0; idx < 3; idx ++) {
		voice = &emu->voices[idx];
		if (voice->use)
			continue;
		voice->use = 1;
		*rvoice = voice;
		return 0;
	}
	return -ENOMEM;
}

static int snd_audigyls_voice_alloc(audigyls_t *emu, audigyls_voice_t **rvoice)
{
	unsigned long flags;
	int result;
  
	snd_assert(rvoice != NULL, return -EINVAL);

	spin_lock_irqsave(&emu->voice_lock, flags);
  
	result = voice_alloc(emu, rvoice);

	spin_unlock_irqrestore(&emu->voice_lock, flags);
  
	return result;
}

static int snd_audigyls_voice_free(audigyls_t *emu, audigyls_voice_t *pvoice)
{
	unsigned long flags;
  
	snd_assert(pvoice != NULL, return -EINVAL);
	spin_lock_irqsave(&emu->voice_lock, flags);

	pvoice->interrupt = NULL;
	pvoice->use = 0;
	pvoice->epcm = NULL;

	spin_unlock_irqrestore(&emu->voice_lock, flags);
	return 0;
}

static void snd_audigyls_pcm_free_substream(snd_pcm_runtime_t *runtime)
{
	audigyls_pcm_t *epcm = snd_magic_cast(audigyls_pcm_t, runtime->private_data, return);
  
	if (epcm)
		snd_magic_kfree(epcm);
}

static void snd_audigyls_pcm_interrupt(audigyls_t *emu, audigyls_voice_t *voice)
{
	audigyls_pcm_t *epcm;
  
	if ((epcm = voice->epcm) == NULL)
		return;
	if (epcm->substream == NULL)
		return;
	snd_pcm_period_elapsed(epcm->substream);
}

/* open callback */
static int snd_audigyls_playback_open(snd_pcm_substream_t *substream)
{
	audigyls_t *chip = snd_pcm_substream_chip(substream);
	audigyls_pcm_t *epcm;
	snd_pcm_runtime_t *runtime = substream->runtime;

	epcm = snd_magic_kcalloc(audigyls_pcm_t, 0, GFP_KERNEL);
	if (epcm == NULL)
		return -ENOMEM;
	epcm->emu = chip;
	epcm->substream = substream;
  
	runtime->private_data = epcm;
	runtime->private_free = snd_audigyls_pcm_free_substream;
  
	runtime->hw = snd_audigyls_playback_hw;

	return 0;
}

/* close callback */
static int snd_audigyls_playback_close(snd_pcm_substream_t *substream)
{
	return 0;
}

/* hw_params callback */
static int snd_audigyls_pcm_hw_params(snd_pcm_substream_t *substream,
				      snd_pcm_hw_params_t * hw_params)
{
	int err;
	snd_pcm_runtime_t *runtime = substream->runtime;
	audigyls_pcm_t *epcm = snd_magic_cast(audigyls_pcm_t, runtime->private_data, return -ENXIO);

	if (! epcm->voice) {
		if ((err = snd_audigyls_voice_alloc(epcm->emu, &epcm->voice)) < 0)
			return err;
		epcm->voice->epcm = epcm;
		epcm->voice->interrupt = snd_audigyls_pcm_interrupt;
	}

	return snd_pcm_lib_malloc_pages(substream,
					params_buffer_bytes(hw_params));
}

/* hw_free callback */
static int snd_audigyls_pcm_hw_free(snd_pcm_substream_t *substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	audigyls_pcm_t *epcm;

	if (runtime->private_data == NULL)
		return 0;
	epcm = snd_magic_cast(audigyls_pcm_t, runtime->private_data, return -ENXIO);

	if (epcm->voice) {
		snd_audigyls_voice_free(epcm->emu, epcm->voice);
		epcm->voice = NULL;
	}

	return snd_pcm_lib_free_pages(substream);
}

/* prepare callback */
static int snd_audigyls_pcm_prepare(snd_pcm_substream_t *substream)
{
	audigyls_t *emu = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	audigyls_pcm_t *epcm = snd_magic_cast(audigyls_pcm_t, runtime->private_data, return -ENXIO);
	int voice = epcm->voice->number;

	snd_audigyls_ptr_write(emu, 0x00, voice, 0);
	snd_audigyls_ptr_write(emu, 0x01, voice, 0);
	snd_audigyls_ptr_write(emu, 0x02, voice, 0);
	snd_audigyls_ptr_write(emu, 0x04, voice, runtime->dma_addr);
	snd_audigyls_ptr_write(emu, 0x05, voice, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
	snd_audigyls_ptr_write(emu, 0x06, voice, 0);
	snd_audigyls_ptr_write(emu, 0x07, voice, 0);
	snd_audigyls_ptr_write(emu, 0x08, voice, 0);
        snd_audigyls_ptr_write(emu, 0x67, 0x0, 0x76543210); /* FIXME: What is this */
	snd_audigyls_ptr_write(emu, 0x75, voice, 0x11); /* Routing of some sort */

	return 0;
}

/* trigger callback */
static int snd_audigyls_pcm_trigger(snd_pcm_substream_t *substream,
				    int cmd)
{
	audigyls_t *emu = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	audigyls_pcm_t *epcm = snd_magic_cast(audigyls_pcm_t, runtime->private_data, return -ENXIO);
	int channel = epcm->voice->number;
	int result = 0;

	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
		snd_audigyls_ptr_write(emu, 0x40, 0, snd_audigyls_ptr_read(emu, 0x40, 0)|(0x1<<channel));
	        //snd_audigyls_ptr_write(emu, 0x75, 0, 0x11); 
		epcm->running = 1;
		break;
	case SNDRV_PCM_TRIGGER_STOP:
		snd_audigyls_ptr_write(emu, 0x40, 0, snd_audigyls_ptr_read(emu, 0x40, 0) & ~(0x1<<channel));
	        snd_audigyls_ptr_write(emu, 0x75, 0, 0x0); 
		epcm->running = 0;
		break;
	default:
		result = -EINVAL;
		break;
	}
	return result;
}

/* pointer callback */
static snd_pcm_uframes_t
snd_audigyls_pcm_pointer(snd_pcm_substream_t *substream)
{
	audigyls_t *emu = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	audigyls_pcm_t *epcm = snd_magic_cast(audigyls_pcm_t, runtime->private_data, return -ENXIO);
	snd_pcm_uframes_t ptr, ptr1, ptr2 = 0;
	int channel = epcm->voice->number;

	if (!epcm->running)
		return 0;

	//  printk("pointer: %08X %08X\n", 
	//	 snd_audigyls_ptr_read(emu, 0x06, channel),  /* 0x06 is Playback pointer. */
	//	 snd_audigyls_ptr_read(emu, 0x12, channel)); /* 0x12 is Capture pointer */
	ptr1 = snd_audigyls_ptr_read(emu, 0x06, channel);
	ptr2 = bytes_to_frames(runtime, ptr1);
	//ptr = bytes_to_frames(runtime, snd_audigyls_ptr_read(emu, 0x06, channel));
	ptr=ptr2;
        if (ptr >= runtime->buffer_size)
		ptr -= runtime->buffer_size;
	//printk("ptr1 = 0x%lx, ptr2=0x%lx, ptr=0x%lx, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr1, ptr2, ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate);

	return ptr;
}

/* operators */
static snd_pcm_ops_t snd_audigyls_playback_ops = {
	.open =        snd_audigyls_playback_open,
	.close =       snd_audigyls_playback_close,
	.ioctl =       snd_pcm_lib_ioctl,
	.hw_params =   snd_audigyls_pcm_hw_params,
	.hw_free =     snd_audigyls_pcm_hw_free,
	.prepare =     snd_audigyls_pcm_prepare,
	.trigger =     snd_audigyls_pcm_trigger,
	.pointer =     snd_audigyls_pcm_pointer,
};

static unsigned short snd_audigyls_ac97_read(ac97_t *ac97,
					     unsigned short reg)
{
	audigyls_t *emu = snd_magic_cast(audigyls_t, ac97->private_data, return -ENXIO);
	unsigned long flags;
	unsigned short val;
  
	spin_lock_irqsave(&emu->emu_lock, flags);
	outb(reg, emu->port + AC97ADDRESS);
	val = inw(emu->port + AC97DATA);
	spin_unlock_irqrestore(&emu->emu_lock, flags);
	return val;
}

static void snd_audigyls_ac97_write(ac97_t *ac97,
				    unsigned short reg, unsigned short val)
{
	audigyls_t *emu = snd_magic_cast(audigyls_t, ac97->private_data, return);
	unsigned long flags;
  
	spin_lock_irqsave(&emu->emu_lock, flags);
	outb(reg, emu->port + AC97ADDRESS);
	outw(val, emu->port + AC97DATA);
	spin_unlock_irqrestore(&emu->emu_lock, flags);
}

static int snd_audigyls_ac97(audigyls_t *chip)
{
	ac97_bus_t bus, *pbus;
	ac97_t ac97;
	int err;
  
	memset(&bus, 0, sizeof(bus));
	bus.write = snd_audigyls_ac97_write;
	bus.read = snd_audigyls_ac97_read;
	if ((err = snd_ac97_bus(chip->card, &bus, &pbus)) < 0)
		return err;
	memset(&ac97, 0, sizeof(ac97));
	ac97.private_data = chip;
	return snd_ac97_mixer(pbus, &ac97, &chip->ac97);
}

static int snd_audigyls_free(audigyls_t *chip)
{
	snd_audigyls_ptr_write(chip, 0x40, 0, 0);
	// disable interrupts
	outl(0, chip->port + INTE);
	// disable audio
	outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG);

	// release the i/o port
	if (chip->res_port) {
		release_resource(chip->res_port);
		kfree_nocheck(chip->res_port);
	}
	// release the irq
	if (chip->irq >= 0)
		free_irq(chip->irq, (void *)chip);
	// release the data
	snd_magic_kfree(chip);
	return 0;
}

static int snd_audigyls_dev_free(snd_device_t *device)
{
	audigyls_t *chip = snd_magic_cast(audigyls_t,
					  device->device_data, return -ENXIO);
	return snd_audigyls_free(chip);
}

static irqreturn_t snd_audigyls_interrupt(int irq, void *dev_id,
					  struct pt_regs *regs)
{
	unsigned int status;

	audigyls_t *chip = snd_magic_cast(audigyls_t, dev_id, return IRQ_NONE);
	int i;
	int mask;
        unsigned int stat76;

	spin_lock(&chip->emu_lock);

	status = inl(chip->port + IPR);

	// call updater, unlock before it
	spin_unlock(&chip->emu_lock);
  
	if (! status)
		return IRQ_NONE;

	mask = IPR_CH_0_LOOP|IPR_CH_0_HALF_LOOP;
	for(i = 0; i < 3; i++) {
		audigyls_voice_t *pvoice = chip->voices;
		if(status & mask) {
                        stat76 = snd_audigyls_ptr_read(chip, 0x76, i);
			if(pvoice->use && pvoice->interrupt)
				pvoice->interrupt(chip, pvoice);
                        snd_audigyls_ptr_write(chip, 0x76, i, stat76);
		}
		pvoice++;
		mask <<= 1;
	}
	spin_lock(&chip->emu_lock);
	// acknowledge the interrupt if necessary
	outl(status, chip->port+IPR);

	spin_unlock(&chip->emu_lock);

	//	printk(KERN_INFO "interrupt %08x\n", status);

	return IRQ_HANDLED;
}

static void snd_audigyls_pcm_free(snd_pcm_t *pcm)
{
	audigyls_t *emu = snd_magic_cast(audigyls_t, pcm->private_data, return);
	emu->pcm = NULL;
	snd_pcm_lib_preallocate_free_for_all(pcm);
}

static int __devinit snd_audigyls_pcm(audigyls_t *emu, int device, snd_pcm_t **rpcm)
{
	snd_pcm_t *pcm;
	snd_pcm_substream_t *substream;
	int err;
  
	if (rpcm)
		*rpcm = NULL;
  
	if ((err = snd_pcm_new(emu->card, "audigyls", device, 3, 0, &pcm)) < 0)
		return err;
  
	pcm->private_data = emu;
	pcm->private_free = snd_audigyls_pcm_free;
  
	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_audigyls_playback_ops);
	//  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_audigyls_capture_ops);

	pcm->info_flags = 0;
	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
	strcpy(pcm->name, "AUDIGYLS");
	emu->pcm = pcm;

	for(substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; 
	    substream; 
	    substream = substream->next)
		if ((err = snd_pcm_lib_preallocate_pages(substream, 
							 SNDRV_DMA_TYPE_DEV, 
							 snd_dma_pci_data(emu->pci), 
							 32*1024, 32*1024)) < 0)
			return err;

	/*
	  for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; 
	  substream; 
	  substream = substream->next)
	  snd_pcm_lib_preallocate_pages(substream, 
	  SNDRV_DMA_TYPE_DEV, 
	  snd_dma_pci_data(emu->pci), 
	  64*1024, 64*1024);
	*/
  
	if (rpcm)
		*rpcm = pcm;
  
	return 0;
}

static int __devinit snd_audigyls_create(snd_card_t *card,
					 struct pci_dev *pci,
					 audigyls_t **rchip)
{
	audigyls_t *chip;
	int err;
	int ch;
	static snd_device_ops_t ops = {
		.dev_free = snd_audigyls_dev_free,
	};
  
	*rchip = NULL;
  
	if ((err = pci_enable_device(pci)) < 0)
		return err;
	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
		printk(KERN_ERR "error to set 28bit mask DMA\n");
		return -ENXIO;
	}
  
	chip = snd_magic_kcalloc(audigyls_t, 0, GFP_KERNEL);
	if (chip == NULL)
		return -ENOMEM;
  
	chip->card = card;
	chip->pci = pci;
	chip->irq = -1;

	spin_lock_init(&chip->emu_lock);
	spin_lock_init(&chip->voice_lock);
  
	chip->port = pci_resource_start(pci, 0);
	if ((chip->res_port = request_region(chip->port, 8,
					     "My Chip")) == NULL) { 
		snd_audigyls_free(chip);
		printk(KERN_ERR "cannot allocate the port\n");
		return -EBUSY;
	}

	if (request_irq(pci->irq, snd_audigyls_interrupt,
			SA_INTERRUPT|SA_SHIRQ, "AUDIGYLS",
			(void *)chip)) {
		snd_audigyls_free(chip);
		printk(KERN_ERR "cannot grab irq\n");
		return -EBUSY;
	}
	chip->irq = pci->irq;
  
	memset(&chip->dma_dev, 0, sizeof(chip->dma_dev));
	chip->dma_dev.type = SNDRV_DMA_TYPE_DEV;
	chip->dma_dev.dev = snd_dma_pci_data(pci);
  
	if(snd_dma_alloc_pages(&chip->dma_dev, 32 * 1024, &chip->buffer) < 0) {
		snd_audigyls_free(chip);
		return -ENOMEM;
	}

	pci_set_master(pci);
	/* read revision & serial */
	pci_read_config_byte(pci, PCI_REVISION_ID, (char *)&chip->revision);
	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
	printk(KERN_INFO "Model %04x Rev %08x Serial %08x\n", chip->model,
	       chip->revision, chip->serial);

	outl(0, chip->port + INTE);

	for(ch = 0; ch < 3; ch++) {
		chip->voices[ch].emu = chip;
		chip->voices[ch].number = ch;
	}

	/*
	 *  Init to 0x02109204 :
	 *  Clock accuracy    = 0     (1000ppm)
	 *  Sample Rate       = 2     (48kHz)
	 *  Audio Channel     = 1     (Left of 2)
	 *  Source Number     = 0     (Unspecified)
	 *  Generation Status = 1     (Original for Cat Code 12)
	 *  Cat Code          = 12    (Digital Signal Mixer)
	 *  Mode              = 0     (Mode 0)
	 *  Emphasis          = 0     (None)
	 *  CP                = 1     (Copyright unasserted)
	 *  AN                = 0     (Audio data)
	 *  P                 = 0     (Consumer)
	 */
#if 0
	snd_audigyls_ptr_write(chip, SPCS0, 0,
			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
			       SPCS_GENERATIONSTATUS | 0x00001200 |
			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
	snd_audigyls_ptr_write(chip, SPCS1, 0,
			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
			       SPCS_GENERATIONSTATUS | 0x00001200 |
			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
	snd_audigyls_ptr_write(chip, SPCS2, 0,
			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
			       SPCS_GENERATIONSTATUS | 0x00001200 |
			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
#endif
/* Select analogue output */
        //snd_audigyls_ptr_write(chip, 0x41, 0, 0x70f); // ???
	snd_audigyls_ptr_write(chip, 0x45, 0, 0);
        //snd_audigyls_ptr_write(chip, 0x65, 0, 0x1000);
	snd_audigyls_ptr_write(chip, 0x72, 0, 0xf0f003f);

	snd_audigyls_ptr_write(chip, 0x71, 0, 0xf0000000);
	//snd_audigyls_ptr_write(chip, 0x61, 0, 0x0);
	//snd_audigyls_ptr_write(chip, 0x62, 0, 0x0);
	snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME, 0, 0x30303030);

	outl(0, chip->port+0x18);
	snd_audigyls_intr_enable(chip, 0x105);

	outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);

	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
				  chip, &ops)) < 0) {
		snd_audigyls_free(chip);
		return err;
	}
	*rchip = chip;
	return 0;
}

static void snd_audigyls_proc_reg_read32(snd_info_entry_t *entry, 
				       snd_info_buffer_t * buffer)
{
	audigyls_t *emu = snd_magic_cast(audigyls_t, entry->private_data, return);
	unsigned long value;
	unsigned long flags;
	int i;
	snd_iprintf(buffer, "Registers:\n\n");
	for(i = 0; i < 0x20; i+=4) {
		spin_lock_irqsave(&emu->emu_lock, flags);
		value = inl(emu->port + i);
		spin_unlock_irqrestore(&emu->emu_lock, flags);
		snd_iprintf(buffer, "Register %02X: %08lX\n", i, value);
	}
}

static void snd_audigyls_proc_reg_read16(snd_info_entry_t *entry, 
				       snd_info_buffer_t * buffer)
{
	audigyls_t *emu = snd_magic_cast(audigyls_t, entry->private_data, return);
        unsigned int value;
	unsigned long flags;
	int i;
	snd_iprintf(buffer, "Registers:\n\n");
	for(i = 0; i < 0x20; i+=2) {
		spin_lock_irqsave(&emu->emu_lock, flags);
		value = inw(emu->port + i);
		spin_unlock_irqrestore(&emu->emu_lock, flags);
		snd_iprintf(buffer, "Register %02X: %04X\n", i, value);
	}
}

static void snd_audigyls_proc_reg_read8(snd_info_entry_t *entry, 
				       snd_info_buffer_t * buffer)
{
	audigyls_t *emu = snd_magic_cast(audigyls_t, entry->private_data, return);
	unsigned int value;
	unsigned long flags;
	int i;
	snd_iprintf(buffer, "Registers:\n\n");
	for(i = 0; i < 0x20; i+=1) {
		spin_lock_irqsave(&emu->emu_lock, flags);
		value = inb(emu->port + i);
		spin_unlock_irqrestore(&emu->emu_lock, flags);
		snd_iprintf(buffer, "Register %02X: %02X\n", i, value);
	}
}

static void snd_audigyls_proc_reg_read1(snd_info_entry_t *entry, 
				       snd_info_buffer_t * buffer)
{
	audigyls_t *emu = snd_magic_cast(audigyls_t, entry->private_data, return);
	unsigned long value;
	int i,j;

	snd_iprintf(buffer, "Registers\n");
	for(i = 0; i < 0x40; i++) {
		snd_iprintf(buffer, "%02X: ",i);
		for (j = 0; j < 4; j++) {
                  value = snd_audigyls_ptr_read(emu, i, j);
		  snd_iprintf(buffer, "%08lX ", value);
                }
	        snd_iprintf(buffer, "\n");
	}
}

static void snd_audigyls_proc_reg_read2(snd_info_entry_t *entry, 
				       snd_info_buffer_t * buffer)
{
	audigyls_t *emu = snd_magic_cast(audigyls_t, entry->private_data, return);
	unsigned long value;
	int i,j;

	snd_iprintf(buffer, "Registers\n");
	for(i = 0x40; i < 0x80; i++) {
		snd_iprintf(buffer, "%02X: ",i);
		for (j = 0; j < 4; j++) {
                  value = snd_audigyls_ptr_read(emu, i, j);
		  snd_iprintf(buffer, "%08lX ", value);
                }
	        snd_iprintf(buffer, "\n");
	}
}

static int __devinit snd_audigyls_proc_init(audigyls_t * emu)
{
	snd_info_entry_t *entry;
	
	if(! snd_card_proc_new(emu->card, "audigyls_reg32", &entry))
		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read32);
	if(! snd_card_proc_new(emu->card, "audigyls_reg16", &entry))
		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read16);
	if(! snd_card_proc_new(emu->card, "audigyls_reg8", &entry))
		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read8);
	if(! snd_card_proc_new(emu->card, "audigyls_regs1", &entry))
		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read1);
	if(! snd_card_proc_new(emu->card, "audigyls_regs2", &entry))
		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read2);
	return 0;
}

static int snd_audigyls_front_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
{
        uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
        uinfo->count = 2;
        uinfo->value.integer.min = 0;
        uinfo->value.integer.max = 255;
        return 0;
}

static int snd_audigyls_front_volume_get(snd_kcontrol_t * kcontrol,
                                       snd_ctl_elem_value_t * ucontrol)
{
        audigyls_t *emu = snd_kcontrol_chip(kcontrol);
        unsigned int value;

        value = snd_audigyls_ptr_read(emu, PLAYBACK_VOLUME, 0);
        ucontrol->value.integer.value[0] = 0xff - ((value >> 24) & 0xff); /* Left */
        ucontrol->value.integer.value[1] = 0xff - ((value >> 16) & 0xff); /* Right */
        return 0;
}
                                                                                                                           
static int snd_audigyls_front_volume_put(snd_kcontrol_t * kcontrol,
                                       snd_ctl_elem_value_t * ucontrol)
{
        audigyls_t *emu = snd_kcontrol_chip(kcontrol);
        unsigned int value;
        value = snd_audigyls_ptr_read(emu, PLAYBACK_VOLUME, 0);
        value = value & 0xffff;
        value = value | ((0xff - ucontrol->value.integer.value[0]) << 24) | ((0xff - ucontrol->value.integer.value[1]) << 16);
        snd_audigyls_ptr_write(emu, PLAYBACK_VOLUME, 0, value);
        return 1;
}

static snd_kcontrol_new_t snd_audigyls_front_volume_control =
{
        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
        .name =         "Front Volume",
        .info =         snd_audigyls_front_volume_info,
        .get =          snd_audigyls_front_volume_get,
        .put =          snd_audigyls_front_volume_put
};


static int __devinit snd_audigyls_mixer(audigyls_t *emu)
{
        int err;
        snd_kcontrol_t *kctl;
        snd_card_t *card = emu->card;
        if ((kctl = emu->ctl_front_volume = snd_ctl_new1(&snd_audigyls_front_volume_control, emu)) == NULL)
                return -ENOMEM;
        if ((err = snd_ctl_add(card, kctl)))
                return err;

        return 0;
}


static int __devinit snd_audigyls_probe(struct pci_dev *pci,
					const struct pci_device_id *pci_id)
{
	static int dev;
	snd_card_t *card;
	audigyls_t *chip;
	int err;

	if (dev >= SNDRV_CARDS)
		return -ENODEV;
	if (!enable[dev]) {
		dev++;
		return -ENOENT;
	}

	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
	if (card == NULL)
		return -ENOMEM;

	if ((err = snd_audigyls_create(card, pci, &chip)) < 0) {
		snd_card_free(card);
		return err;
	}

	if ((err = snd_audigyls_pcm(chip, 0, NULL)) < 0) {
		snd_card_free(card);
		return err;
	}

	if ((err = snd_audigyls_ac97(chip)) < 0) {
		snd_card_free(card);
		return err;
	}
#if 1

	if ((err = snd_audigyls_mixer(chip)) < 0) {
		snd_card_free(card);
		return err;
	}
#endif

	snd_audigyls_proc_init(chip);

	strcpy(card->driver, "SB Audigy LS");
	strcpy(card->shortname, "AUDIGYLS");
	sprintf(card->longname, "%s at 0x%lx irq %i",
		card->shortname, chip->port, chip->irq);

	if ((err = snd_card_register(card)) < 0) {
		snd_card_free(card);
		return err;
	}

	pci_set_drvdata(pci, card);
	dev++;
	return 0;
}

static void __devexit snd_audigyls_remove(struct pci_dev *pci)
{
	snd_card_free(pci_get_drvdata(pci));
	pci_set_drvdata(pci, NULL);
}

// PCI IDs
static struct pci_device_id snd_audigyls_ids[] = {
	{ 0x1102, 0x0007, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },	/* Audigy LS */
	{ 0, }
};
MODULE_DEVICE_TABLE(pci, snd_audigyls_ids);

// pci_driver definition
static struct pci_driver driver = {
	.name = "AudigyLS",
	.id_table = snd_audigyls_ids,
	.probe = snd_audigyls_probe,
	.remove = __devexit_p(snd_audigyls_remove),
};

// initialization of the module
static int __init alsa_card_audigyls_init(void)
{
	int err;

	if ((err = pci_module_init(&driver)) > 0)
		return err;

	return 0;
}

// clean up the module
static void __exit alsa_card_audigyls_exit(void)
{
	pci_unregister_driver(&driver);
}

module_init(alsa_card_audigyls_init)
module_exit(alsa_card_audigyls_exit)
     
EXPORT_NO_SYMBOLS; /* for old kernels only */

--------------020107090903040600080009--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
