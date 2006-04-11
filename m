From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Adding a new architecture to alsa-driver
Date: Mon, 10 Apr 2006 21:13:36 -0400
Message-ID: <1144718017.18918.6.camel@mindpipe>
References: <1144510532.10642.1.camel@localhost.localdomain>
	 <1144512218.22490.146.camel@mindpipe>
	 <1144542208.10642.9.camel@localhost.localdomain>
	 <1144545416.22490.184.camel@mindpipe>
	 <1144706767.9278.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144706767.9278.11.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-04-10 at 23:06 +0100, Adrian McMenamin wrote:
> On Sat, 2006-04-08 at 21:16 -0400, Lee Revell wrote:
> > c_opts="-mno-space-regs -mfast-indirect-calls -mschedule=7200
> > -mdisable-fpregs"
> 
> 
> I have tried this patch and it doesn't work. Essentially the aica card
> isn't picked up. I think this has something to do with aclocal.m4 or
> something similar.
> 
> To be honest I've hit a brick wall and any help at all would be welcome.
> 
> 

Adrian,

OK, here's the working (I think) patch against ALSA CVS.

I could not figure out how to add a new arch while leaving the driver in
alsa-driver, so this adds it to alsa-kernel.

Lee

diff -Nru alsa-kernel/Kconfig alsa-kernel2/Kconfig
--- alsa-kernel/Kconfig	2005-11-29 09:48:41.000000000 -0500
+++ alsa-kernel2/Kconfig	2006-04-10 19:15:34.000000000 -0400
@@ -74,6 +74,8 @@
 
 source "sound/parisc/Kconfig"
 
+source "sound/sh/Kconfig"
+
 endmenu
 
 menu "Open Sound System"
diff -Nru alsa-kernel/Makefile alsa-kernel2/Makefile
--- alsa-kernel/Makefile	2005-03-22 03:50:46.000000000 -0500
+++ alsa-kernel2/Makefile	2006-04-10 19:08:32.000000000 -0400
@@ -4,7 +4,7 @@
 obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
-obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/
+obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/ sh/
 
 ifeq ($(CONFIG_SND),y)
   obj-y += last.o
diff -Nru alsa-kernel/sh/Kconfig alsa-kernel2/sh/Kconfig
--- alsa-kernel/sh/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ alsa-kernel2/sh/Kconfig	2006-04-10 18:59:59.000000000 -0400
@@ -0,0 +1,16 @@
+menu "SH (Super-H) devices"
+	depends on SND!=n && SUPERH
+
+config SND_AICA
+	tristate "Yamaha AICA sound for SEGA Dreamcast"
+	depends on SND
+	depends on SH_DREAMCAST
+	select SND_PCM
+	help
+	  Say Y here to include support for sound on your SEGA Dreamcast
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-aica.
+
+endmenu
+
diff -Nru alsa-kernel/sh/Makefile alsa-kernel2/sh/Makefile
--- alsa-kernel/sh/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ alsa-kernel2/sh/Makefile	2006-04-10 18:59:59.000000000 -0400
@@ -0,0 +1,2 @@
+  snd-aica-objs := aica.o
+  obj-$(CONFIG_SND_AICA) += snd-aica.o
diff -Nru alsa-kernel/sh/aica.c alsa-kernel2/sh/aica.c
--- alsa-kernel/sh/aica.c	1969-12-31 19:00:00.000000000 -0500
+++ alsa-kernel2/sh/aica.c	2006-04-10 18:59:59.000000000 -0400
@@ -0,0 +1,802 @@
+/*
+* This code is licenced under 
+* the General Public Licence
+* version 2
+*
+* Copyright Adrian McMenamin 2005, 2006
+* <adrian@mcmen.demon.co.uk>
+* See also http://newgolddream.dyndns.info/cgi-bin/cvsweb
+* 
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of version 2 of the GNU General Public License as published by
+* the Free Software Foundation.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*
+*/
+
+
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include <linux/wait.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/firmware.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <asm-sh/io.h>
+#include <asm-sh/dma.h>
+#include <asm-sh/dreamcast/sysasic.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/info.h>
+#include "aica.h"
+
+
+MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk>");
+MODULE_DESCRIPTION("Dreamcast AICA sound (pcm) driver");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("{{Yamaha/SEGA, AICA}}");
+
+/* module parameters */
+#define CARD_NAME "AICA"
+
+static int index = 0;
+static char *id = "0";
+static int enable= 1;
+
+module_param(index, int, 0444);
+MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
+module_param(id, charp, 0444);
+MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
+module_param(enable, bool, 0644);
+MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
+
+
+/* SPU specific functions */
+
+inline void spu_write_wait()
+{
+	while (1) {
+		if (!(readl(G2_FIFO) & 0x11))
+			break;
+	}
+
+	return;
+}
+
+
+
+static void spu_memset(uint32_t toi, unsigned long what, int length)
+{
+	uint32_t *to = (uint32_t *) (SPU_MEMORY_BASE + toi);
+	int i;
+
+	if (length % 4)
+		length = (length / 4) + 1;
+	else
+		length = length / 4;
+	spu_write_wait();
+	for (i = 0; i < length; i++) {
+		writel(what, to);
+		to++;
+		if (i && !(i % 8))
+			spu_write_wait();
+	}
+	return;
+}
+
+static void spu_memload(uint32_t toi, uint8_t * from, int length)
+{
+	uint32_t *froml = (uint32_t *) from;
+	uint32_t *to = (uint32_t *) (SPU_MEMORY_BASE + toi);
+	int i, val;
+	if (length % 4)
+		length = (length / 4) + 1;
+	else
+		length = length / 4;
+	spu_write_wait();
+	for (i = 0; i < length; i++) {
+		val = *froml;
+		writel(val, to);
+		froml++;
+		to++;
+		if (i && !(i % 8))
+			spu_write_wait();
+	}
+	return;
+
+}
+
+static void spu_disable()
+{
+	int i;
+	uint32_t regval;
+	spu_write_wait();
+	regval = readl(ARM_RESET_REGISTER);
+	regval |= 1;
+	spu_write_wait();
+	writel(regval, ARM_RESET_REGISTER);
+	for (i = 0; i < 64; i++) {
+		spu_write_wait();
+		regval = readl(SPU_REGISTER_BASE + (i * 0x80));
+		regval = (regval & ~0x4000) | 0x8000;
+		spu_write_wait();
+		writel(regval, SPU_REGISTER_BASE + (i * 0x80));
+
+	}
+
+}
+
+
+static void spu_enable()
+{
+	uint32_t regval = readl(ARM_RESET_REGISTER);
+	regval &= ~1;
+	spu_write_wait();
+	writel(regval, ARM_RESET_REGISTER);
+	return;
+
+}
+
+
+/* Halt the sound processor,
+   clear the memory,
+   load some default ARM7 code,
+   and then restart ARM7
+*/
+static int spu_init()
+{
+
+	spu_disable();
+	spu_memset(0, 0, 0x200000 / 4);
+	*(uint32_t *) SPU_MEMORY_BASE = 0xea000002;
+	spu_enable();
+	schedule();
+	return 0;
+}
+
+
+
+static aica_channel_t *channel;
+
+inline static void aica_chn_start()
+{
+	spu_write_wait();
+	writel(AICA_CMD_KICK | AICA_CMD_START,
+	       (uint32_t *) AICA_CONTROL_POINT);
+
+}
+
+inline static void aica_chn_halt()
+{
+	spu_write_wait();
+	writel(AICA_CMD_KICK | AICA_CMD_STOP,
+	       (uint32_t *) AICA_CONTROL_POINT);
+
+}
+
+
+/* ALSA code below */
+
+static snd_pcm_hardware_t snd_pcm_aica_playback_hw = {
+
+	.info = (SNDRV_PCM_INFO_NONINTERLEAVED),
+	.formats =
+	    (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
+	     SNDRV_PCM_FMTBIT_IMA_ADPCM),
+	.rates = SNDRV_PCM_RATE_8000_48000,
+	.rate_min = 8000,
+	.rate_max = 48000,
+	.channels_min = 1,
+	.channels_max = 2,
+	.buffer_bytes_max = AICA_BUFFER_SIZE,
+	.period_bytes_min = AICA_PERIOD_SIZE,
+	.period_bytes_max = AICA_PERIOD_SIZE,
+	.periods_min = AICA_PERIOD_NUMBER,
+	.periods_max = AICA_PERIOD_NUMBER,
+};
+
+/* There is only one sound card on a Dreamcast */
+static snd_card_aica_t *dreamcastcard = NULL;
+static struct platform_device *pd = NULL;
+
+
+
+
+static int stereo_buffer_transfer(snd_pcm_substream_t * substream,
+				  int buffer_size, int period)
+{
+	int transferred;
+	snd_pcm_runtime_t *runtime;
+	int period_offset;
+	period_offset = period;
+	period_offset %= (AICA_PERIOD_NUMBER / 2);
+	runtime = substream->runtime;
+
+	//snd_printk("period is 0x%X, period_offset is 0x%X, buffer_size is 0x%X\n", period, period_offset, buffer_size);
+	/* transfer left and then right */
+	dma_xfer(0,
+		 runtime->dma_area + (AICA_PERIOD_SIZE * period_offset),
+		 AICA_CHANNEL0_OFFSET + (AICA_PERIOD_SIZE * period_offset),
+		 buffer_size / 2, 5);
+	/* wait for completion */
+	do {
+		udelay(5);
+		transferred = get_dma_residue(0);
+	}
+	while (transferred < buffer_size / 2);
+	dma_xfer(0,
+		 AICA_BUFFER_SIZE / 2 + runtime->dma_area +
+		 (AICA_PERIOD_SIZE * period_offset),
+		 AICA_CHANNEL1_OFFSET + (AICA_PERIOD_SIZE * period_offset),
+		 buffer_size / 2, 5);
+	/* have to wait again */
+	do {
+		udelay(5);
+		transferred = get_dma_residue(0);
+	}
+	while (transferred < buffer_size / 2);
+	return 0;
+}
+
+
+
+
+void aica_period_elapsed(unsigned long timer_var)
+{
+	int transferred;
+	int play_period;
+	snd_pcm_runtime_t *runtime;
+	runtime = (dreamcastcard->substream)->runtime;
+
+	/* Have we played out an additional period? */
+	play_period =
+	    frames_to_bytes(runtime,
+			    readl
+			    (AICA_CONTROL_CHANNEL_SAMPLE_NUMBER)) /
+	    AICA_PERIOD_SIZE;
+	if (play_period == dreamcastcard->current_period) {
+		dreamcastcard->timer.expires = jiffies + 1;
+		add_timer(&(dreamcastcard->timer));
+		return;
+	}
+	if (runtime->channels > 1) {
+		dreamcastcard->current_period = play_period;	/*TO DO: Work out why this doesn't work for 1 channel */
+
+		stereo_buffer_transfer(dreamcastcard->substream,
+				       AICA_PERIOD_SIZE * 2,
+				       dreamcastcard->clicks);
+	} else {
+		dma_xfer(0,
+			 runtime->dma_area +
+			 (AICA_PERIOD_SIZE * dreamcastcard->clicks),
+			 AICA_CHANNEL0_OFFSET +
+			 (AICA_PERIOD_SIZE * dreamcastcard->clicks),
+			 AICA_PERIOD_SIZE, 5);
+		do {
+			/* Try to fine tune the delay to keep it as short as possible */
+			udelay(5);
+			/* get_dma_residue reports residue until completion when it reports total bytes transferred */
+			transferred = get_dma_residue(0);
+		}
+		while (transferred < AICA_PERIOD_SIZE);
+	}
+
+	snd_pcm_period_elapsed(dreamcastcard->substream);
+	dreamcastcard->clicks++;
+	dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
+	/* reschedule the timer */
+	dreamcastcard->timer.expires = jiffies + 1;
+	add_timer(&(dreamcastcard->timer));
+	return;
+}
+
+static int snd_aicapcm_pcm_open(snd_pcm_substream_t * substream)
+{
+	if (!enable) return -ENOENT;
+	
+	channel = kmalloc(sizeof(aica_channel_t), GFP_KERNEL);
+	if (!channel)
+		return -ENOMEM;
+	/* set defaults for channel */
+	channel->sfmt = SM_8BIT;
+	channel->cmd = AICA_CMD_START;
+	channel->vol = dreamcastcard->master_volume;
+	channel->pan = 0x80;
+	channel->pos = 0;
+	channel->flags = 0;	/* default to mono */
+	snd_pcm_runtime_t *runtime;
+	runtime = substream->runtime;
+	runtime->hw = snd_pcm_aica_playback_hw;
+	spu_enable();
+	dreamcastcard->clicks = 0;
+	dreamcastcard->current_period = 0;
+	return 0;
+
+}
+
+static int snd_aicapcm_pcm_close(snd_pcm_substream_t * substream)
+{
+	del_timer(&dreamcastcard->timer);
+	kfree(channel);
+	spu_disable();
+	return 0;
+}
+
+static int snd_aicapcm_pcm_hw_free(snd_pcm_substream_t * substream)
+{
+	/* Free the DMA buffer */
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int snd_aicapcm_pcm_hw_params(snd_pcm_substream_t * substream,
+				     snd_pcm_hw_params_t * hw_params)
+{
+	/* Allocate a DMA buffer using ALSA built-ins */
+	return
+	    snd_pcm_lib_malloc_pages(substream,
+				     params_buffer_bytes(hw_params));
+}
+
+static int snd_aicapcm_pcm_prepare(snd_pcm_substream_t * substream)
+{
+
+	/* Set up the playback */
+	/* basic settings to test working */
+	if ((substream->runtime)->format == SNDRV_PCM_FORMAT_S16_LE)
+		channel->sfmt = SM_16BIT;
+	channel->freq = substream->runtime->rate;
+	dreamcastcard->substream = substream;
+	return 0;
+}
+
+
+static void startup_aica()
+{
+	spu_memload(AICA_CHANNEL0_CONTROL_OFFSET, (uint8_t *) channel,
+		    sizeof(aica_channel_t));
+	aica_chn_start();
+	return;
+}
+
+
+static void spu_begin_dma(snd_pcm_substream_t * substream)
+{
+	int buffer_size;
+	snd_pcm_runtime_t *runtime;
+	runtime = substream->runtime;
+	buffer_size = frames_to_bytes(runtime, runtime->buffer_size);
+	if (runtime->channels == 1)
+		dma_xfer(0, runtime->dma_area, AICA_CHANNEL0_OFFSET,
+			 buffer_size, 5);
+	else {
+		int transfer_status;
+		channel->flags |= 0x01;
+		transfer_status =
+		    stereo_buffer_transfer(substream, buffer_size, 0);
+		if (transfer_status != 0)
+			return;
+		dreamcastcard->clicks =
+		    buffer_size / (AICA_PERIOD_SIZE * runtime->channels);
+	}
+	startup_aica();
+	init_timer(&(dreamcastcard->timer));
+	dreamcastcard->timer.function = aica_period_elapsed;
+
+
+	dreamcastcard->timer.expires = jiffies + 4;
+	add_timer(&(dreamcastcard->timer));
+	return;
+}
+
+static int snd_aicapcm_pcm_trigger(snd_pcm_substream_t * substream,
+				   int cmd)
+{
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		spu_begin_dma(substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		aica_chn_halt();
+		break;
+	default:
+		return -EINVAL;
+	}
+
+
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_aicapcm_pcm_pointer(snd_pcm_substream_t *
+						 substream)
+{
+	return readl(AICA_CONTROL_CHANNEL_SAMPLE_NUMBER);
+
+}
+
+
+static snd_pcm_ops_t snd_aicapcm_playback_ops = {
+	.open = snd_aicapcm_pcm_open,
+	.close = snd_aicapcm_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_aicapcm_pcm_hw_params,
+	.hw_free = snd_aicapcm_pcm_hw_free,
+	.prepare = snd_aicapcm_pcm_prepare,
+	.trigger = snd_aicapcm_pcm_trigger,
+	.pointer = snd_aicapcm_pcm_pointer,
+};
+
+
+static int snd_aicapcm_free(snd_card_aica_t * dreamcastcard)
+{
+	release_mem_region(ARM_RESET_REGISTER, 0x4);
+	release_mem_region(SPU_MEMORY_BASE, 0x200000);
+	return 0;
+}
+
+/*	Set up the PCM playback device
+	card is pointer to the overall AICA device
+	pcm_index is number of PCM instances - 1
+
+	TO DO: set up to handle more than one pcm instance
+*/
+
+
+static int __init snd_aicapcmchip(snd_card_aica_t * dreamcastcard,
+				  int pcm_index)
+{
+	snd_pcm_t *pcm;
+	int err;
+
+	/* Can we lock the memory */
+
+	if (request_mem_region(ARM_RESET_REGISTER, 4, "AICA ARM control")
+	    == NULL)
+		return -ENOMEM;
+	if (request_mem_region(SPU_MEMORY_BASE, 0x200000, "AICA Sound RAM")
+	    == NULL) {
+		release_mem_region(ARM_RESET_REGISTER, 0x4);
+		return -ENOMEM;
+	}
+
+	/* AICA has no capture ability */
+	if ((err =
+	     snd_pcm_new(dreamcastcard->card, "AICA PCM", pcm_index, 1, 0,
+			 &pcm)) < 0)
+		return err;
+	pcm->private_data = dreamcastcard;
+	dreamcastcard->card->private_data = pcm;
+	strcpy(pcm->name, "AICA PCM");
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_aicapcm_playback_ops);
+
+	/* Allocate the DMA buffers */
+	err =
+	    snd_pcm_lib_preallocate_pages_for_all(pcm,
+						  SNDRV_DMA_TYPE_CONTINUOUS,
+						  snd_dma_continuous_data
+						  (GFP_KERNEL),
+						  AICA_BUFFER_SIZE,
+						  AICA_BUFFER_SIZE);
+
+	return err;
+}
+
+/* Mixer controls */
+static int aica_pcmswitch_info(snd_kcontrol_t * kcontrol,
+			       snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int aica_pcmswitch_get(snd_kcontrol_t * kcontrol,
+			      snd_ctl_elem_value_t * ucontrol)
+{
+	ucontrol->value.integer.value[0] = 1;	/* TO DO: Fix me */
+	return 0;
+}
+
+static int aica_pcmswitch_put(snd_kcontrol_t * kcontrol,
+			      snd_ctl_elem_value_t * ucontrol)
+{
+	if (ucontrol->value.integer.value[0] == 1)
+		return 0;	/* TO DO: Fix me */
+	else
+		aica_chn_halt();
+	return 0;
+}
+
+
+
+
+static int aica_pcmvolume_info(snd_kcontrol_t * kcontrol,
+			       snd_ctl_elem_info_t * uinfo)
+{
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0xFF;
+
+	return 0;
+}
+
+static int aica_pcmvolume_get(snd_kcontrol_t * kcontrol,
+			      snd_ctl_elem_value_t * ucontrol)
+{
+	if (!channel)
+		return -ETXTBSY;	/* we've not yet been set up */
+	ucontrol->value.integer.value[0] = channel->vol;
+	return 0;
+}
+
+static int aica_pcmvolume_put(snd_kcontrol_t * kcontrol,
+			      snd_ctl_elem_value_t * ucontrol)
+{
+	if (!channel) {
+		snd_printk("No channel yet\n");
+		return -ETXTBSY;	/* too soon */
+	}
+
+	else if (channel->vol == ucontrol->value.integer.value[0])
+		return 0;
+
+	else {
+		channel->vol = ucontrol->value.integer.value[0];
+		dreamcastcard->master_volume = ucontrol->value.integer.value[0];
+		spu_memload(AICA_CHANNEL0_CONTROL_OFFSET,
+			    (uint8_t *) channel, sizeof(aica_channel_t));
+	}
+	return 1;
+}
+
+
+static snd_kcontrol_new_t snd_aica_masterswitch_control __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Playback Switch",
+	.info = aica_pcmswitch_info,
+	.get = aica_pcmswitch_get,
+	.put = aica_pcmswitch_put
+};
+
+static snd_kcontrol_new_t snd_aica_pcmswitch_control __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "PCM Playback Switch",
+	.index = 0,
+	.info = aica_pcmswitch_info,
+	.get = aica_pcmswitch_get,
+	.put = aica_pcmswitch_put
+};
+
+
+static snd_kcontrol_new_t snd_aica_mastervolume_control __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Playback Volume",
+	.info = aica_pcmvolume_info,
+	.get = aica_pcmvolume_get,
+	.put = aica_pcmvolume_put
+};
+
+static snd_kcontrol_new_t snd_aica_pcmvolume_control __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "PCM Playback Volume",
+	.index = 0,
+	.info = aica_pcmvolume_info,
+	.get = aica_pcmvolume_get,
+	.put = aica_pcmvolume_put
+};
+
+
+
+static struct device_driver aica_driver = {
+	.name = "AICA",
+	.bus = &platform_bus_type,
+};
+
+
+/* Fill up the members of the embedded device structure */
+
+static void populate_dreamcastaicadev(struct device *dev)
+{
+	dev->bus = &platform_bus_type;
+	dev->driver = &aica_driver;
+	driver_register(dev->driver);
+	device_bind_driver(dev);
+}
+
+static int load_aica_firmware()
+{
+	int err;
+	err = 0;
+	spu_init();
+	const struct firmware *fw_entry;
+	err = request_firmware(&fw_entry, "aica_firmware.bin", &pd->dev);
+	if (err)
+		return err;
+	/* write firware into memory */
+	spu_disable();
+	spu_memload(0, fw_entry->data, fw_entry->size);
+	spu_enable();
+	release_firmware(fw_entry);
+	return err;
+}
+
+static int __devinit add_aicamixer_controls()
+{
+	int err;
+	err = snd_ctl_add
+	     (dreamcastcard->card,
+	      snd_ctl_new1(&snd_aica_pcmvolume_control,
+			   dreamcastcard));
+	     if (err < 0){
+		snd_printk("pcmvolume failed\n");
+		return err;
+	     }
+	    
+	    err= snd_ctl_add
+	     (dreamcastcard->card,
+	      snd_ctl_new1(&snd_aica_pcmswitch_control,
+			   dreamcastcard));
+	     if (err < 0){
+		snd_printk("pcmswitch failed\n");
+		return err;
+	     }
+
+	    
+	    err = snd_ctl_add
+	     (dreamcastcard->card,
+	      snd_ctl_new1(&snd_aica_mastervolume_control,
+			   dreamcastcard));
+	     if (err < 0){
+		snd_printk("mastervolume failed\n");
+		return err;
+	     }
+
+	    
+	    err = snd_ctl_add
+	     (dreamcastcard->card,
+	      snd_ctl_new1(&snd_aica_masterswitch_control,
+			   dreamcastcard));
+	     if (err < 0){
+		snd_printk("masterswitch failed\n");
+		return err;
+	     }
+
+	    
+	  
+	/* succeeded */
+	return 0;
+}
+
+
+
+static int __init aica_init(void)
+{
+
+
+	int err;
+	int idx;
+
+	/* Are we in a Dreamcast at all? */
+	if (!mach_is_dreamcast())
+		return -ENODEV;
+	dreamcastcard = kmalloc(sizeof(snd_card_aica_t), GFP_KERNEL);
+	if (!dreamcastcard)
+		return -ENOMEM;
+	dreamcastcard->card = NULL;
+	/* Can only be one real device on a Dreamcast
+	   but we might have the dummy or some other driver loaded */
+	for (idx = 0; idx < SNDRV_CARDS; idx++) {
+		dreamcastcard->card =
+		    snd_card_new(idx, "AICA", THIS_MODULE, 0);
+		if (dreamcastcard->card)
+			break;
+	}
+	if (!dreamcastcard->card) {
+		kfree(dreamcastcard);
+		return -ENODEV;
+	}
+	strcpy(dreamcastcard->card->driver, "snd_card_aica");
+	strcpy(dreamcastcard->card->shortname, "AICA");
+	strcpy(dreamcastcard->card->longname,
+	       "Yamaha AICA Super Intelligent Sound Processor for SEGA Dreamcast");
+
+	/* Load the PCM 'chip' */
+	if ((err = snd_aicapcmchip(dreamcastcard, 0)) < 0)
+		goto freedreamcast;
+
+
+	pd = platform_device_register_simple(dreamcastcard->card->driver,
+					     -1, NULL, 0);
+
+	if (IS_ERR(pd)) {
+		err = -ENODEV;
+		goto freepcm;
+	}
+
+	populate_dreamcastaicadev(&pd->dev);
+	snd_card_set_dev(dreamcastcard->card, &pd->dev);
+	/* Register the card with ALSA subsystem */
+	if ((err = snd_card_register(dreamcastcard->card)) < 0)
+		goto freepcm;
+
+	/* Load the firmware */
+	err = load_aica_firmware();
+
+	if (err)
+		goto freepcm;
+
+
+	/* Add basic controls */
+	if (add_aicamixer_controls() < 0) goto freepcm;
+
+	snd_printk
+	    ("ALSA Driver for Yamaha AICA Super Intelligent Sound Processor on slot %d\n",
+	     idx);
+
+	return 0;
+
+      freepcm:
+	snd_aicapcm_free(dreamcastcard);
+
+      freedreamcast:
+	snd_card_free(dreamcastcard->card);
+
+	if (pd) {
+		struct device_driver *drv = (&pd->dev)->driver;
+		device_release_driver(&pd->dev);
+		driver_unregister(drv);
+		platform_device_unregister(pd);
+		pd = NULL;
+	}
+	kfree(dreamcastcard);
+	return err;
+
+
+}
+
+static void __exit aica_exit(void)
+{
+
+	if (likely(dreamcastcard->card)) {
+		snd_aicapcm_free(dreamcastcard);
+		snd_card_free(dreamcastcard->card);
+		kfree(dreamcastcard);
+		if (likely(pd)) {
+			struct device_driver *drv = (&pd->dev)->driver;
+			device_release_driver(&pd->dev);
+			driver_unregister(drv);
+			platform_device_unregister(pd);
+		}
+
+	}
+	/* Kill any sound still playing and reset ARM7 to safe state */
+	spu_init();
+
+
+	return;
+}
+
+
+module_init(aica_init);
+module_exit(aica_exit);
diff -Nru alsa-kernel/sh/aica.h alsa-kernel2/sh/aica.h
--- alsa-kernel/sh/aica.h	1969-12-31 19:00:00.000000000 -0500
+++ alsa-kernel2/sh/aica.h	2006-04-10 18:59:59.000000000 -0400
@@ -0,0 +1,79 @@
+/* aica.h
+ * Header file for ALSA driver for
+ * Sega Dreamcast Yamaha AICA sound
+ * Copyright Adrian McMenamin
+ * <adrian@mcmen.demon.co.uk>
+ * 2006
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+/* SPU memory and register constants etc */
+#define G2_FIFO 0xa05f688c
+#define SPU_MEMORY_BASE 0xA0800000
+#define ARM_RESET_REGISTER 0xA0702C00
+#define SPU_REGISTER_BASE 0xA0700000
+
+
+
+/* AICA channels stuff */
+
+#define AICA_CONTROL_POINT 0xA0810000
+#define AICA_CONTROL_CHANNEL_SAMPLE_NUMBER 0xA0810008
+#define AICA_CHANNEL0_CONTROL_OFFSET 0x10004
+
+/* Command values */
+#define AICA_CMD_KICK 0x80000000
+#define AICA_CMD_NONE 0
+#define AICA_CMD_START 1
+#define AICA_CMD_STOP 2
+#define AICA_CMD_VOL 3
+
+/* Sound modes */
+#define SM_8BIT		1
+#define SM_16BIT	0
+#define SM_ADPCM	2
+
+/* Buffer and period size */
+#define AICA_BUFFER_SIZE 0x8000
+#define AICA_PERIOD_SIZE 0x800
+#define AICA_PERIOD_NUMBER 16
+
+#define AICA_CHANNEL0_OFFSET 0x11000
+#define AICA_CHANNEL1_OFFSET 0x21000
+
+
+typedef struct {
+	snd_card_t *card;
+	snd_pcm_substream_t *substream;
+	int clicks;
+	int current_period;
+	struct timer_list timer;
+	int master_volume;
+
+} snd_card_aica_t;
+
+
+
+typedef struct aica_channel {
+	uint32_t cmd;		/* Command ID           */
+	uint32_t pos;		/* Sample position      */
+	uint32_t length;	/* Sample length        */
+	uint32_t freq;		/* Frequency            */
+	uint32_t vol;		/* Volume 0-255         */
+	uint32_t pan;		/* Pan 0-255            */
+	uint32_t sfmt;		/* Sound format         */
+	uint32_t flags;		/* Bit flags            */
+} aica_channel_t;
diff -Nru alsa-driver/Makefile alsa-driver2/Makefile
--- alsa-driver/Makefile	2005-11-17 06:15:20.000000000 -0500
+++ alsa-driver2/Makefile	2006-04-08 21:14:22.000000000 -0400
@@ -6,7 +6,7 @@
 ifneq ($(KERNELRELEASE),)
 # call from 2.6 kernel build system
 
-obj-m += acore/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/
+obj-m += acore/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ sh/
 
 else
 
@@ -99,6 +99,9 @@
 ifeq (y,$(CONFIG_PARISC))
 SUBDIRS  += parisc
 endif
+ifeq (y,$(CONFIG_SUPERH))
+SUBDIRS  += sh 
+endif
 CSUBDIRS += include test utils
 
 KCONFIG_FILES = $(shell find $(SND_TOPDIR) -name Kconfig) $(shell find $(SND_TOPDIR)/alsa-kernel/ -name Kconfig)
diff -Nru alsa-driver/configure.in alsa-driver2/configure.in
--- alsa-driver/configure.in	2006-03-29 11:52:47.000000000 -0500
+++ alsa-driver2/configure.in	2006-04-08 21:13:18.000000000 -0400
@@ -872,6 +872,8 @@
 	fprintf(file, "amba");
 #elif defined(CONFIG_PARISC)
 	fprintf(file, "parisc");
+#elif defined(CONFIG_SUPERH)
+	fprintf(file, "sh");
 #elif defined(CONFIG_MVIAC3_2)
 	fprintf(file, "viac3_2");
 #else
@@ -1117,6 +1119,11 @@
     c_opts="-mno-space-regs -mfast-indirect-calls -mschedule=7200 -mdisable-fpregs"
     test "$CONFIG_ISA" = "probe" && CONFIG_ISA=
     ;;
+  sh)
+    ARCH=sh
+    c_opts="-mno-space-regs -mfast-indirect-calls -mschedule=7200 -mdisable-fpregs"
+    test "$CONFIG_ISA" = "probe" && CONFIG_ISA=
+    ;;
   viac3_2)
     ARCH=i386
     if $KCC -march=c3-2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then
@@ -1259,6 +1266,7 @@
 AC_SUBST(CONFIG_ISA)
 AC_SUBST(CONFIG_ISA_DMA_API)
 AC_SUBST(CONFIG_PARISC)
+AC_SUBST(CONFIG_SUPERH)
 test "$CONFIG_ISA" = "y" && AC_DEFINE(CONFIG_SND_ISA)
 
 dnl Check for SMP...
diff -Nru alsa-driver/sh/Makefile alsa-driver2/sh/Makefile
--- alsa-driver/sh/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver2/sh/Makefile	2006-04-10 19:01:28.000000000 -0400
@@ -0,0 +1,10 @@
+ifndef SND_TOPDIR
+SND_TOPDIR=..
+endif
+
+include $(SND_TOPDIR)/toplevel.config
+include $(SND_TOPDIR)/Makefile.conf
+
+include $(SND_TOPDIR)/alsa-kernel/sh/Makefile
+
+include $(SND_TOPDIR)/Rules.make
diff -Nru alsa-driver/sh/aica.c alsa-driver2/sh/aica.c
--- alsa-driver/sh/aica.c	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver2/sh/aica.c	2006-04-10 19:02:31.000000000 -0400
@@ -0,0 +1,3 @@
+#include "../alsa-kernel/sh/aica.c"
+EXPORT_NO_SYMBOLS;
+




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
