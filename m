From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: Sound driver for Sega Dreamcast
Date: Sat, 12 May 2007 19:13:12 +0100
Message-ID: <92a12cdb0705121113i2f2d8c2bw825cb35b7a5cdf08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by alsa0.perex.cz (Postfix) with ESMTP id C9378245A8
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2007 20:13:15 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so1272620nzf
	for <alsa-devel@alsa-project.org>; Sat, 12 May 2007 11:13:14 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

My last email is in the archive, but seem to make it back to me - in
any case this code is better... but in case my last email didn't get
delivered anywhere, I am asking for views on what needs to be done to
get this committed.


diff -Naur ./linux-2.6.21-orig/sound/Kconfig ./linux-2.6.21/sound/Kconfig
--- ./linux-2.6.21-orig/sound/Kconfig	2007-04-26 04:08:32.000000000 +0100
+++ ./linux-2.6.21/sound/Kconfig	2007-05-07 21:20:54.000000000 +0100
@@ -64,6 +64,8 @@

 source "sound/mips/Kconfig"

+source "sound/sh/Kconfig"
+
 # the following will depend on the order of config.
 # here assuming USB is defined before ALSA
 source "sound/usb/Kconfig"
diff -Naur ./linux-2.6.21-orig/sound/Makefile ./linux-2.6.21/sound/Makefile
--- ./linux-2.6.21-orig/sound/Makefile	2007-04-26 04:08:32.000000000 +0100
+++ ./linux-2.6.21/sound/Makefile	2007-05-07 21:37:05.000000000 +0100
@@ -5,7 +5,7 @@
 obj-$(CONFIG_SOUND_PRIME) += sound_firmware.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
-obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/
usb/ sparc/ parisc/ pcmcia/ mips/ soc/
+obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/
synth/ usb/ sparc/ parisc/ pcmcia/ mips/ soc/
 obj-$(CONFIG_SND_AOA) += aoa/

 # This one must be compilable even if sound is configured out
diff -Naur ./linux-2.6.21-orig/sound/sh/aica.c ./linux-2.6.21/sound/sh/aica.c
--- ./linux-2.6.21-orig/sound/sh/aica.c	1970-01-01 01:00:00.000000000 +0100
+++ ./linux-2.6.21/sound/sh/aica.c	2007-05-12 19:10:32.000000000 +0100
@@ -0,0 +1,676 @@
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
+* it under the terms of version 2 of the GNU General Public License
as published by
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
+#include <linux/workqueue.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/info.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/dreamcast/sysasic.h>
+#include "aica.h"
+
+MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk>");
+MODULE_DESCRIPTION("Dreamcast AICA sound (pcm) driver");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("{{Yamaha/SEGA, AICA}}");
+
+/* module parameters */
+#define CARD_NAME "AICA"
+static int index = -1;
+static char *id;
+static int enable = 1;
+module_param(index, int, 0444);
+MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
+module_param(id, charp, 0444);
+MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
+module_param(enable, bool, 0644);
+MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
+
+/* Use workqueue */
+
+static struct spu_work_holder {
+	struct work_struct spu_dma_work;
+	void *sspointer;
+} spu_working;
+
+static struct workqueue_struct *aica_queue;
+
+/* Simple platform device */
+static struct platform_device *pd;
+static struct resource aica_memory_space[2] = {
+	{
+	 .name = "AICA ARM CONTROL",
+	 .start = ARM_RESET_REGISTER,
+	 .flags = IORESOURCE_MEM,
+	 .end = ARM_RESET_REGISTER + 3,
+	 },
+	{
+	 .name = "AICA Sound RAM",
+	 .start = SPU_MEMORY_BASE,
+	 .flags = IORESOURCE_MEM,
+	 .end = SPU_MEMORY_BASE + 0x200000 - 1,
+	 },
+};
+
+/* SPU specific functions */
+/* spu_write_wait - wait for G2-SH FIFO to clear */
+static inline void spu_write_wait(void)
+{
+	int time_count;
+	time_count = 0;
+	while (1) {
+		if (!(readl(G2_FIFO) & 0x11))
+			break;
+		/* To ensure hardware failure doesn't wedge kernel */
+		time_count++;
+		if (time_count > 0x10000)
+			break;
+	}
+}
+
+/* spu_memset - write to memory in SPU address space */
+static void spu_memset(uint32_t toi, uint32_t what, int length)
+{
+	int i;
+	snd_assert(length % 4 == 0, return);
+	spu_write_wait();
+	for (i = 0; i < length; i++) {
+		writel(what, toi + SPU_MEMORY_BASE);
+		toi++;
+		if (i && !(i % 8))
+			spu_write_wait();
+	}
+}
+
+/* spu_memload - write to SPU address space */
+static void spu_memload(uint32_t toi, void __iomem * from, int length)
+{
+	uint32_t __iomem *froml = from;
+	uint32_t __iomem *to = (uint32_t __iomem *) (SPU_MEMORY_BASE + toi);
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
+}
+
+/* spu_disable - set spu registers to stop sound output */
+static void spu_disable(void)
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
+	}
+}
+
+/* spu_enable - set spu registers to enable sound output */
+static void spu_enable(void)
+{
+	uint32_t regval = readl(ARM_RESET_REGISTER);
+	regval &= ~1;
+	spu_write_wait();
+	writel(regval, ARM_RESET_REGISTER);
+}
+
+/*
+ * Halt the sound processor, clear the memory,
+ * load some default ARM7 code, and then restart ARM7
+*/
+static void spu_reset(void)
+{
+	spu_disable();
+	spu_memset(0, 0, 0x200000 / 4);
+	/* Put ARM7 in endless loop */
+	ctrl_outl(0xea000002, SPU_MEMORY_BASE);
+	spu_enable();
+}
+
+/* aica_chn_start - write to spu to start playback */
+static void aica_chn_start(void)
+{
+	spu_write_wait();
+	writel(AICA_CMD_KICK | AICA_CMD_START, (uint32_t *) AICA_CONTROL_POINT);
+}
+
+/* aica_chn_halt - write to spu to halt playback */
+static void aica_chn_halt(void)
+{
+	spu_write_wait();
+	writel(AICA_CMD_KICK | AICA_CMD_STOP, (uint32_t *) AICA_CONTROL_POINT);
+}
+
+/* ALSA code below */
+static struct snd_pcm_hardware snd_pcm_aica_playback_hw = {
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
+static int aica_dma_transfer(int channels, int buffer_size,
+			     struct snd_pcm_substream *substream)
+{
+	int q, err, period_offset;
+	struct snd_card_aica *dreamcastcard;
+	struct snd_pcm_runtime *runtime;
+	err = 0;
+	dreamcastcard = substream->pcm->private_data;
+	period_offset = dreamcastcard->clicks;
+	period_offset %= (AICA_PERIOD_NUMBER / channels);
+	runtime = substream->runtime;
+	for (q = 0; q < channels; q++) {
+		err = dma_xfer(AICA_DMA_CHANNEL,
+			       (unsigned long)(runtime->dma_area +
+					       (AICA_BUFFER_SIZE * q) /
+					       channels +
+					       AICA_PERIOD_SIZE *
+					       period_offset),
+			       AICA_CHANNEL0_OFFSET + q * CHANNEL_OFFSET +
+			       AICA_PERIOD_SIZE * period_offset,
+			       buffer_size / channels, AICA_DMA_MODE);
+		if (unlikely(err < 0))
+			break;
+		dma_wait_for_completion(AICA_DMA_CHANNEL);
+	}
+	return err;
+}
+
+static void startup_aica(struct snd_card_aica *dreamcastcard)
+{
+	spu_memload(AICA_CHANNEL0_CONTROL_OFFSET,
+		    (uint8_t *) dreamcastcard->channel,
+		    sizeof(struct aica_channel));
+	aica_chn_start();
+}
+
+static void run_spu_dma(struct work_struct *work)
+{
+	int buffer_size;
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_runtime *runtime;
+	struct snd_card_aica *dreamcastcard;
+	struct spu_work_holder *holder = container_of(work, struct
spu_work_holder, spu_dma_work);
+	substream = holder-> sspointer;
+	dreamcastcard = substream->pcm->private_data;
+	runtime = substream->runtime;
+	if (unlikely(dreamcastcard->dma_check == 0)) {
+		buffer_size = frames_to_bytes(runtime, runtime->buffer_size);
+		if (runtime->channels > 1)
+			dreamcastcard->channel->flags |= 0x01;
+		aica_dma_transfer(runtime->channels, buffer_size, substream);
+		startup_aica(dreamcastcard);
+		dreamcastcard->clicks =
+		    buffer_size / (AICA_PERIOD_SIZE * runtime->channels);
+		return;
+	} else {
+		aica_dma_transfer(runtime->channels,
+				  AICA_PERIOD_SIZE * runtime->channels,
+				  substream);
+		snd_pcm_period_elapsed(dreamcastcard->substream);
+		dreamcastcard->clicks++;
+		dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
+		mod_timer(&dreamcastcard->timer, jiffies + 1);
+	}
+}
+
+static void aica_period_elapsed(unsigned long timer_var)
+{
+	/*timer fuction - so cannot sleep */
+	int play_period;
+	struct snd_pcm_runtime *runtime;
+	struct snd_pcm_substream *substream;
+	struct snd_card_aica *dreamcastcard;
+	substream = (struct snd_pcm_substream *)timer_var;
+	runtime = substream->runtime;
+	dreamcastcard = substream->pcm->private_data;
+	/* Have we played out an additional period? */
+	play_period =
+	    frames_to_bytes(runtime,
+			    readl
+			    (AICA_CONTROL_CHANNEL_SAMPLE_NUMBER)) /
+	    AICA_PERIOD_SIZE;
+	if (play_period == dreamcastcard->current_period) {
+		/* reschedule the timer */
+		mod_timer(&(dreamcastcard->timer), jiffies + 1);
+		return;
+	}
+	if (runtime->channels > 1)
+		dreamcastcard->current_period = play_period;
+	if (unlikely(dreamcastcard->dma_check == 0))
+		dreamcastcard->dma_check = 1;
+		queue_work(aica_queue, &(spu_working.spu_dma_work));
+}
+
+static void spu_begin_dma(struct snd_pcm_substream *substream)
+{
+	/* Must be atomic */
+	struct snd_card_aica *dreamcastcard;
+	struct snd_pcm_runtime *runtime;
+	runtime = substream->runtime;
+	dreamcastcard = substream->pcm->private_data;
+	/*  Use queue to do the heavy lifting */
+	spu_working.sspointer = substream;
+	INIT_WORK(&(spu_working.spu_dma_work), run_spu_dma);
+	queue_work(aica_queue, &(spu_working.spu_dma_work));
+	/* Timer may already be running */
+	if (unlikely(dreamcastcard->timer.data)) {
+		mod_timer(&dreamcastcard->timer, jiffies + 4);
+		return;
+	}
+	init_timer(&(dreamcastcard->timer));
+	dreamcastcard->timer.data = (unsigned long)substream;
+	dreamcastcard->timer.function = aica_period_elapsed;
+	dreamcastcard->timer.expires = jiffies + 4;
+	add_timer(&(dreamcastcard->timer));
+}
+
+static int snd_aicapcm_pcm_open(struct snd_pcm_substream
+				*substream)
+{
+	struct snd_pcm_runtime *runtime;
+	struct aica_channel *channel;
+	struct snd_card_aica *dreamcastcard;
+	if (!enable)
+		return -ENOENT;
+	dreamcastcard = substream->pcm->private_data;
+	channel = kmalloc(sizeof(struct aica_channel), GFP_KERNEL);
+	if (!channel)
+		return -ENOMEM;
+	/* set defaults for channel */
+	channel->sfmt = SM_8BIT;
+	channel->cmd = AICA_CMD_START;
+	channel->vol = dreamcastcard->master_volume;
+	channel->pan = 0x80;
+	channel->pos = 0;
+	channel->flags = 0;	/* default to mono */
+	dreamcastcard->channel = channel;
+	runtime = substream->runtime;
+	runtime->hw = snd_pcm_aica_playback_hw;
+	spu_enable();
+	dreamcastcard->clicks = 0;
+	dreamcastcard->current_period = 0;
+	dreamcastcard->dma_check = 0;
+	return 0;
+}
+
+static int snd_aicapcm_pcm_close(struct snd_pcm_substream
+				 *substream)
+{
+	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
+	del_timer(&dreamcastcard->timer);
+	kfree(dreamcastcard->channel);
+	spu_disable();
+	return 0;
+}
+
+static int snd_aicapcm_pcm_hw_free(struct snd_pcm_substream
+				   *substream)
+{
+	/* Free the DMA buffer */
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int snd_aicapcm_pcm_hw_params(struct snd_pcm_substream
+				     *substream, struct snd_pcm_hw_params
+				     *hw_params)
+{
+	/* Allocate a DMA buffer using ALSA built-ins */
+	return
+	    snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+}
+
+static int snd_aicapcm_pcm_prepare(struct snd_pcm_substream
+				   *substream)
+{
+	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
+	if ((substream->runtime)->format == SNDRV_PCM_FORMAT_S16_LE)
+		dreamcastcard->channel->sfmt = SM_16BIT;
+	dreamcastcard->channel->freq = substream->runtime->rate;
+	dreamcastcard->substream = substream;
+	return 0;
+}
+
+static int snd_aicapcm_pcm_trigger(struct snd_pcm_substream
+				   *substream, int cmd)
+{
+	struct snd_card_aica *dreamcastcard;
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		spu_begin_dma(substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		dreamcastcard = substream->pcm->private_data;
+		if (dreamcastcard->timer.data)
+			del_timer(&dreamcastcard->timer);
+		aica_chn_halt();
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static unsigned long snd_aicapcm_pcm_pointer(struct snd_pcm_substream
+					     *substream)
+{
+	return readl(AICA_CONTROL_CHANNEL_SAMPLE_NUMBER);
+}
+
+static struct snd_pcm_ops snd_aicapcm_playback_ops = {
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
+/* TO DO: set up to handle more than one pcm instance */
+static int __init snd_aicapcmchip(struct snd_card_aica
+				  *dreamcastcard, int pcm_index)
+{
+	struct snd_pcm *pcm;
+	int err;
+	/* AICA has no capture ability */
+	err =
+	    snd_pcm_new(dreamcastcard->card, "AICA PCM", pcm_index, 1, 0, &pcm);
+	if (unlikely(err < 0))
+		return err;
+	pcm->private_data = dreamcastcard;
+	strcpy(pcm->name, "AICA PCM");
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&snd_aicapcm_playback_ops);
+	/* Allocate the DMA buffers */
+	err =
+	    snd_pcm_lib_preallocate_pages_for_all(pcm,
+						  SNDRV_DMA_TYPE_CONTINUOUS,
+						  snd_dma_continuous_data
+						  (GFP_KERNEL),
+						  AICA_BUFFER_SIZE,
+						  AICA_BUFFER_SIZE);
+	return err;
+}
+
+/* Mixer controls */
+static int aica_pcmswitch_info(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int aica_pcmswitch_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = 1;	/* TO DO: Fix me */
+	return 0;
+}
+
+static int aica_pcmswitch_put(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	if (ucontrol->value.integer.value[0] == 1)
+		return 0;	/* TO DO: Fix me */
+	else
+		aica_chn_halt();
+	return 0;
+}
+
+static int aica_pcmvolume_info(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0xFF;
+	return 0;
+}
+
+static int aica_pcmvolume_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_card_aica *dreamcastcard;
+	dreamcastcard = kcontrol->private_data;
+	if (unlikely(!dreamcastcard->channel))
+		return -ETXTBSY;	/* we've not yet been set up */
+	ucontrol->value.integer.value[0] = dreamcastcard->channel->vol;
+	return 0;
+}
+
+static int aica_pcmvolume_put(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_card_aica *dreamcastcard;
+	dreamcastcard = kcontrol->private_data;
+	if (unlikely(!dreamcastcard->channel))
+		return -ETXTBSY;
+	if (unlikely(dreamcastcard->channel->vol ==
+		     ucontrol->value.integer.value[0]))
+		return 0;
+	dreamcastcard->channel->vol = ucontrol->value.integer.value[0];
+	dreamcastcard->master_volume = ucontrol->value.integer.value[0];
+	spu_memload(AICA_CHANNEL0_CONTROL_OFFSET,
+		    (uint8_t *) dreamcastcard->channel,
+		    sizeof(struct aica_channel));
+
+	return 1;
+}
+
+static struct snd_kcontrol_new snd_aica_pcmswitch_control __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "PCM Playback Switch",
+	.index = 0,
+	.info = aica_pcmswitch_info,
+	.get = aica_pcmswitch_get,
+	.put = aica_pcmswitch_put
+};
+
+static struct snd_kcontrol_new snd_aica_pcmvolume_control __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "PCM Playback Volume",
+	.index = 0,
+	.info = aica_pcmvolume_info,
+	.get = aica_pcmvolume_get,
+	.put = aica_pcmvolume_put
+};
+
+static int load_aica_firmware(void)
+{
+	int err;
+	const struct firmware *fw_entry;
+	err = 0;
+	spu_reset();
+	err = request_firmware(&fw_entry, "aica_firmware.bin", &pd->dev);
+	if (unlikely(err))
+		return err;
+	/* write firware into memory */
+	spu_disable();
+	spu_memload(0, fw_entry->data, fw_entry->size);
+	spu_enable();
+	release_firmware(fw_entry);
+	return err;
+}
+
+static int __devinit add_aicamixer_controls(struct snd_card_aica
+					    *dreamcastcard)
+{
+	int err;
+	err = snd_ctl_add
+	    (dreamcastcard->card,
+	     snd_ctl_new1(&snd_aica_pcmvolume_control, dreamcastcard));
+	if (unlikely(err < 0))
+		return err;
+	err = snd_ctl_add
+	    (dreamcastcard->card,
+	     snd_ctl_new1(&snd_aica_pcmswitch_control, dreamcastcard));
+	if (unlikely(err < 0))
+		return err;
+	return 0;
+}
+
+static int snd_aica_remove(struct platform_device *devptr)
+{
+	struct snd_card_aica *dreamcastcard;
+	dreamcastcard = platform_get_drvdata(devptr);
+	if (unlikely(!dreamcastcard))
+		return -ENODEV;
+	snd_card_free(dreamcastcard->card);
+	kfree(dreamcastcard);
+	platform_set_drvdata(devptr, NULL);
+	return 0;
+}
+
+static int __init snd_aica_probe(struct platform_device *devptr)
+{
+	int err;
+	struct snd_card_aica *dreamcastcard;
+	dreamcastcard = kmalloc(sizeof(struct snd_card_aica), GFP_KERNEL);
+	if (unlikely(!dreamcastcard))
+		return -ENOMEM;
+	dreamcastcard->card =
+	    snd_card_new(index, SND_AICA_DRIVER, THIS_MODULE, 0);
+	if (unlikely(!dreamcastcard->card)) {
+		kfree(dreamcastcard);
+		return -ENODEV;
+	}
+	strcpy(dreamcastcard->card->driver, "snd_aica");
+	strcpy(dreamcastcard->card->shortname, SND_AICA_DRIVER);
+	strcpy(dreamcastcard->card->longname,
+	       "Yamaha AICA Super Intelligent Sound Processor for SEGA Dreamcast");
+	/* Load the PCM 'chip' */
+	err = snd_aicapcmchip(dreamcastcard, 0);
+	if (unlikely(err < 0))
+		goto freedreamcast;
+	snd_card_set_dev(dreamcastcard->card, &devptr->dev);
+	dreamcastcard->timer.data = 0;
+	dreamcastcard->channel = NULL;
+	/* Add basic controls */
+	err = add_aicamixer_controls(dreamcastcard);
+	if (unlikely(err < 0))
+		goto freedreamcast;
+	/* Register the card with ALSA subsystem */
+	err = snd_card_register(dreamcastcard->card);
+	if (unlikely(err < 0))
+		goto freedreamcast;
+	platform_set_drvdata(devptr, dreamcastcard);
+	aica_queue = create_workqueue("aica");
+	if (unlikely(!aica_queue))
+		goto freedreamcast;
+	snd_printk
+	    ("ALSA Driver for Yamaha AICA Super Intelligent Sound Processor\n");
+	return 0;
+      freedreamcast:
+	snd_card_free(dreamcastcard->card);
+	kfree(dreamcastcard);
+	return err;
+}
+
+static struct platform_driver snd_aica_driver = {
+	.probe = snd_aica_probe,
+	.remove = snd_aica_remove,
+	.driver = {
+		   .name = SND_AICA_DRIVER},
+};
+
+static int __init aica_init(void)
+{
+	int err;
+	err = platform_driver_register(&snd_aica_driver);
+	if (unlikely(err < 0))
+		return err;
+	pd = platform_device_register_simple(SND_AICA_DRIVER, -1,
+					     aica_memory_space, 2);
+	if (unlikely(IS_ERR(pd))) {
+		platform_driver_unregister(&snd_aica_driver);
+		return PTR_ERR(pd);
+	}
+	/* Load the firmware */
+	err = load_aica_firmware();
+	if (unlikely(err < 0))
+		return err;
+
+	return 0;
+}
+
+static void __exit aica_exit(void)
+{
+	/* Destroy the aica kernel thread */
+	destroy_workqueue(aica_queue);
+	platform_device_unregister(pd);
+	platform_driver_unregister(&snd_aica_driver);
+	/* Kill any sound still playing and reset ARM7 to safe state */
+	spu_reset();
+}
+
+module_init(aica_init);
+module_exit(aica_exit);
diff -Naur ./linux-2.6.21-orig/sound/sh/aica.h ./linux-2.6.21/sound/sh/aica.h
--- ./linux-2.6.21-orig/sound/sh/aica.h	1970-01-01 01:00:00.000000000 +0100
+++ ./linux-2.6.21/sound/sh/aica.h	2007-05-07 21:47:31.000000000 +0100
@@ -0,0 +1,80 @@
+/* aica.h
+ * Header file for ALSA driver for
+ * Sega Dreamcast Yamaha AICA sound
+ * Copyright Adrian McMenamin
+ * <adrian@mcmen.demon.co.uk>
+ * 2006
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License
as published by
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
+/* AICA channels stuff */
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
+#define CHANNEL_OFFSET 0x10000
+
+#define AICA_DMA_CHANNEL 0
+#define AICA_DMA_MODE 5
+
+#define SND_AICA_DRIVER "AICA"
+
+struct aica_channel {
+	uint32_t cmd;		/* Command ID           */
+	uint32_t pos;		/* Sample position      */
+	uint32_t length;	/* Sample length        */
+	uint32_t freq;		/* Frequency            */
+	uint32_t vol;		/* Volume 0-255         */
+	uint32_t pan;		/* Pan 0-255            */
+	uint32_t sfmt;		/* Sound format         */
+	uint32_t flags;		/* Bit flags            */
+};
+
+struct snd_card_aica {
+	struct snd_card *card;
+	struct aica_channel *channel;
+	struct snd_pcm_substream *substream;
+	int clicks;
+	int current_period;
+	struct timer_list timer;
+	int master_volume;
+	int dma_check;
+};
diff -Naur ./linux-2.6.21-orig/sound/sh/Kconfig ./linux-2.6.21/sound/sh/Kconfig
--- ./linux-2.6.21-orig/sound/sh/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ ./linux-2.6.21/sound/sh/Kconfig	2007-05-07 21:28:30.000000000 +0100
@@ -0,0 +1,14 @@
+# ALSA SH drivers
+
+menu "SUPERH devices"
+	depends on SND!=n && SUPERH
+
+config SND_AICA
+	tristate "Dreamcast Yamaha AICA sound"
+	depends on SH_DREAMCAST && SND
+	select SND_PCM
+	help
+	  ALSA Sound driver for the SEGA Dreamcast console.
+
+endmenu
+
diff -Naur ./linux-2.6.21-orig/sound/sh/Makefile
./linux-2.6.21/sound/sh/Makefile
--- ./linux-2.6.21-orig/sound/sh/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ ./linux-2.6.21/sound/sh/Makefile	2007-05-07 21:34:10.000000000 +0100
@@ -0,0 +1,8 @@
+#
+# Makefile for ALSA
+#
+
+snd-aica-objs := aica.o
+
+# Toplevel Module Dependency
+obj-$(CONFIG_SND_AICA) += snd-aica.o
