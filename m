From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: AICA driver for dreamcast
Date: Sun, 28 May 2006 19:40:46 +0100
Message-ID: <1148841646.9224.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-R62YD8RDtdFUkX6ezsaS"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk
	[81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id C10CE18F
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 20:40:57 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org, linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-R62YD8RDtdFUkX6ezsaS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Back again on this - taking advantage of the long weekend here in the
UK :)

It's been a few weeks since I touched the code and a lot of that time
has been taken up with other problems with the Dreamcast DMA which are
not directly related to the sound.

But this appears to work. But I'd be grateful for comments before I post
another patch with a request it is applied.



--=-R62YD8RDtdFUkX6ezsaS
Content-Disposition: attachment; filename=aica.c
Content-Type: text/x-csrc; name=aica.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

/*
* This code is licenced under 
* the General Public Licence
* version 2
*
* Copyright Adrian McMenamin 2005, 2006
* <adrian@mcmen.demon.co.uk>
* See also http://newgolddream.dyndns.info/cgi-bin/cvsweb
* 
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of version 2 of the GNU General Public License as published by
* the Free Software Foundation.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*
*/


#include <linux/init.h>
#include <linux/jiffies.h>
#include <linux/slab.h>
#include <linux/time.h>
#include <linux/wait.h>
#include <linux/moduleparam.h>
#include <linux/platform_device.h>
#include <linux/firmware.h>
#include <linux/timer.h>
#include <linux/delay.h>
#include <linux/workqueue.h>
#include <sound/driver.h>
#include <sound/core.h>
#include <sound/control.h>
#include <sound/pcm.h>
#include <sound/initval.h>
#include <sound/info.h>
#include <asm/io.h>
#include <asm/dma.h>
#include <asm/dreamcast/sysasic.h>
#include "aica.h"

MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk>");
MODULE_DESCRIPTION("Dreamcast AICA sound (pcm) driver");
MODULE_LICENSE("GPL");
MODULE_SUPPORTED_DEVICE("{{Yamaha/SEGA, AICA}}");

/* module parameters */
#define CARD_NAME "AICA"

static int index = -1;
static char *id;
static int enable = 1;

module_param(index, int, 0444);
MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
module_param(id, charp, 0444);
MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
module_param(enable, bool, 0644);
MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");

/* Spinlocks */
static DEFINE_SPINLOCK(spu_memlock);


/* Simple platform device */
static struct platform_device *pd;
static struct resource aica_memory_space[2] = {
	{
	 .name = "AICA ARM CONTROL",
	 .start = ARM_RESET_REGISTER,
	 .flags = IORESOURCE_MEM,
	 .end = ARM_RESET_REGISTER + 4,
	 },
	{
	 .name = "AICA Sound RAM",
	 .start = SPU_MEMORY_BASE,
	 .flags = IORESOURCE_MEM,
	 .end = SPU_MEMORY_BASE + 0x200000,
	 },
};

/* SPU specific functions */
/* spu_write_wait - wait for G2-SH FIFO to clear */
static inline void spu_write_wait(void)
{
	int time_count;
	time_count = 0;
	while (1) {
		if (!(readl(G2_FIFO) & 0x11))
			break;
		/* To ensure hardware failure doesn't wedge kernel */
		time_count++;
		if (time_count > 0x10000)
			break;
	}
}

/* spu_memset - write to memory in SPU address space */
static void spu_memset(uint32_t toi, void __iomem * what, int length)
{
	uint32_t *to = (uint32_t *) (SPU_MEMORY_BASE + toi);
	int i;
	snd_assert(length % 4 == 0, return);
	spu_write_wait();
	for (i = 0; i < length; i++) {
		spin_lock(&spu_memlock);
		writel(what, to);
		spin_unlock(&spu_memlock);
		to++;
		if (i && !(i % 8))
			spu_write_wait();
	}
}

/* spu_memload - write to SPU address space */
static void spu_memload(uint32_t toi, void __iomem * from, int length)
{
	uint32_t __iomem *froml = from;
	uint32_t __iomem *to =
	    (uint32_t __iomem *) (SPU_MEMORY_BASE + toi);
	int i, val;
	if (length % 4)
		length = (length / 4) + 1;
	else
		length = length / 4;
	spu_write_wait();
	for (i = 0; i < length; i++) {
		val = *froml;
		spin_lock(&spu_memlock);
		writel(val, to);
		spin_unlock(&spu_memlock);
		froml++;
		to++;
		if (i && !(i % 8))
			spu_write_wait();
	}
}

/* spu_disable - set spu registers to stop sound output */
static void spu_disable(void)
{
	int i;
	uint32_t regval;
	spu_write_wait();
	regval = readl(ARM_RESET_REGISTER);
	regval |= 1;
	spu_write_wait();
	spin_lock(&spu_memlock);
	writel(regval, ARM_RESET_REGISTER);
	spin_unlock(&spu_memlock);
	for (i = 0; i < 64; i++) {
		spu_write_wait();
		regval = readl(SPU_REGISTER_BASE + (i * 0x80));
		regval = (regval & ~0x4000) | 0x8000;
		spu_write_wait();
		spin_lock(&spu_memlock);
		writel(regval, SPU_REGISTER_BASE + (i * 0x80));
		spin_unlock(&spu_memlock);
	}
}

/* spu_enable - set spu registers to enable sound output */
static void spu_enable(void)
{
	uint32_t regval = readl(ARM_RESET_REGISTER);
	regval &= ~1;
	spu_write_wait();
	spin_lock(&spu_memlock);
	writel(regval, ARM_RESET_REGISTER);
	spin_unlock(&spu_memlock);
}

/* Halt the sound processor,
   clear the memory,
   load some default ARM7 code,
   and then restart ARM7
*/
static void spu_init(void)
{
	spu_disable();
	spu_memset(0, 0, 0x200000 / 4);
	/* Put ARM7 in endless loop */
	ctrl_outl(0xea000002, SPU_MEMORY_BASE);
	spu_enable();
	schedule();
}

/* aica_chn_start - write to spu to start playback */
inline static void aica_chn_start(void)
{
	spu_write_wait();
	spin_lock(&spu_memlock);
	writel(AICA_CMD_KICK | AICA_CMD_START,
	       (uint32_t *) AICA_CONTROL_POINT);
	spin_unlock(&spu_memlock);
}

/* aica_chn_halt - write to spu to halt playback */
inline static void aica_chn_halt(void)
{
	spu_write_wait();
	spin_lock(&spu_memlock);
	writel(AICA_CMD_KICK | AICA_CMD_STOP,
	       (uint32_t *) AICA_CONTROL_POINT);
	spin_unlock(&spu_memlock);
}

/* ALSA code below */
static struct snd_pcm_hardware snd_pcm_aica_playback_hw = {
	.info = (SNDRV_PCM_INFO_NONINTERLEAVED),.formats =
	    (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
	     SNDRV_PCM_FMTBIT_IMA_ADPCM),
	.rates = SNDRV_PCM_RATE_8000_48000,
	.rate_min = 8000,.rate_max = 48000,
	.channels_min = 1,
	.channels_max = 2,
	.buffer_bytes_max = AICA_BUFFER_SIZE,
	.period_bytes_min = AICA_PERIOD_SIZE,
	.period_bytes_max = AICA_PERIOD_SIZE,
	.periods_min = AICA_PERIOD_NUMBER,
	.periods_max = AICA_PERIOD_NUMBER,
};

static int aica_dma_transfer(int channels, int buffer_size,
			     struct snd_pcm_substream *substream)
{
	int q, err, period_offset;
	struct snd_card_aica *dreamcastcard;
	struct snd_pcm_runtime *runtime;
	dreamcastcard = substream->pcm->private_data;
	period_offset = dreamcastcard->clicks;
	period_offset %= (AICA_PERIOD_NUMBER / channels);
	runtime = substream->runtime;
	for (q = 0; q < channels; q++) {
		err = dma_xfer(AICA_DMA_CHANNEL,
			       runtime->dma_area +
			       (AICA_BUFFER_SIZE * q) / channels +
			       AICA_PERIOD_SIZE * period_offset,
			       AICA_CHANNEL0_OFFSET + q * CHANNEL_OFFSET +
			       AICA_PERIOD_SIZE * period_offset,
			       buffer_size / channels, AICA_DMA_MODE);
		if (err < 0)
			break;
		dma_wait_for_completion(AICA_DMA_CHANNEL);
	}
	return err;
}

static void aica_period_elapsed(unsigned long timer_var)
{
	int transferred;
	int play_period;
	int dma_countout;
	int err;
	struct snd_pcm_runtime *runtime;
	struct snd_pcm_substream *substream;
	struct snd_card_aica *dreamcastcard;
	substream = (struct snd_pcm_substream *) timer_var;
	runtime = substream->runtime;
	dreamcastcard = substream->pcm->private_data;
	/* Have we played out an additional period? */
	play_period =
	    frames_to_bytes(runtime,
			    readl
			    (AICA_CONTROL_CHANNEL_SAMPLE_NUMBER)) /
	    AICA_PERIOD_SIZE;
	if (play_period == dreamcastcard->current_period) {
		/* reschedule the timer */
		dreamcastcard->timer.expires = jiffies + 1;
		add_timer(&(dreamcastcard->timer));
		return;
	}
	if (runtime->channels > 1)
		dreamcastcard->current_period = play_period;
	aica_dma_transfer(runtime->channels,
			  AICA_PERIOD_SIZE * runtime->channels, substream);
	snd_pcm_period_elapsed(dreamcastcard->substream);
	dreamcastcard->clicks++;
	dreamcastcard->clicks %= AICA_PERIOD_NUMBER;
	dreamcastcard->timer.expires = jiffies + 1;
	add_timer(&(dreamcastcard->timer));

}

static int snd_aicapcm_pcm_open(struct snd_pcm_substream
				*substream)
{
	struct snd_pcm_runtime *runtime;
	struct aica_channel *channel;
	struct snd_card_aica *dreamcastcard;
	if (!enable)
		return -ENOENT;
	dreamcastcard = substream->pcm->private_data;
	channel = kmalloc(sizeof(struct aica_channel), GFP_KERNEL);
	if (!channel)
		return -ENOMEM;
	/* set defaults for channel */
	channel->sfmt = SM_8BIT;
	channel->cmd = AICA_CMD_START;
	channel->vol = dreamcastcard->master_volume;
	channel->pan = 0x80;
	channel->pos = 0;
	channel->flags = 0;	/* default to mono */
	dreamcastcard->channel = channel;
	runtime = substream->runtime;
	runtime->hw = snd_pcm_aica_playback_hw;
	spu_enable();
	dreamcastcard->clicks = 0;
	dreamcastcard->current_period = 0;
	return 0;
}

static int snd_aicapcm_pcm_close(struct snd_pcm_substream
				 *substream)
{
	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
	del_timer(&dreamcastcard->timer);
	kfree(dreamcastcard->channel);
	spu_disable();
	return 0;
}

static int snd_aicapcm_pcm_hw_free(struct snd_pcm_substream
				   *substream)
{
	/* Free the DMA buffer */
	return snd_pcm_lib_free_pages(substream);
}

static int snd_aicapcm_pcm_hw_params(struct snd_pcm_substream
				     *substream, struct snd_pcm_hw_params
				     *hw_params)
{
	/* Allocate a DMA buffer using ALSA built-ins */
	return
	    snd_pcm_lib_malloc_pages(substream,
				     params_buffer_bytes(hw_params));
}

static int snd_aicapcm_pcm_prepare(struct snd_pcm_substream
				   *substream)
{

	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
	if ((substream->runtime)->format == SNDRV_PCM_FORMAT_S16_LE)
		dreamcastcard->channel->sfmt = SM_16BIT;
	dreamcastcard->channel->freq = substream->runtime->rate;
	dreamcastcard->substream = substream;
	return 0;
}

static void startup_aica(struct snd_card_aica *dreamcastcard)
{
	spu_memload(AICA_CHANNEL0_CONTROL_OFFSET,
		    (uint8_t *) dreamcastcard->channel,
		    sizeof(struct aica_channel));
	aica_chn_start();
	return;
}



static void spu_begin_dma(struct snd_pcm_substream *substream)
{
	int buffer_size;
	struct snd_pcm_runtime *runtime;
	long dma_flags;
	struct snd_card_aica *dreamcastcard;
	dreamcastcard = substream->pcm->private_data;
	runtime = substream->runtime;
	buffer_size = frames_to_bytes(runtime, runtime->buffer_size);
	if (runtime->channels > 1)
		dreamcastcard->channel->flags |= 0x01;
	aica_dma_transfer(runtime->channels, buffer_size, substream);
	dreamcastcard->clicks =
	    buffer_size / (AICA_PERIOD_SIZE * runtime->channels);
	startup_aica(dreamcastcard);
	/* Timer may already be running - if so delete it */
	if (dreamcastcard->timer.data)
		del_timer(&dreamcastcard->timer);
	init_timer(&(dreamcastcard->timer));
	dreamcastcard->timer.data = (unsigned long) substream;
	dreamcastcard->timer.function = aica_period_elapsed;
	dreamcastcard->timer.expires = jiffies + 4;
	add_timer(&(dreamcastcard->timer));
}



static int snd_aicapcm_pcm_trigger(struct snd_pcm_substream
				   *substream, int cmd)
{
	struct snd_card_aica *dreamcastcard;
	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
		spu_begin_dma(substream);
		break;
	case SNDRV_PCM_TRIGGER_STOP:
		dreamcastcard = substream->pcm->private_data;
		if (dreamcastcard->timer.data)
			del_timer(&dreamcastcard->timer);
		aica_chn_halt();
		break;
	default:
		return -EINVAL;
	}
	return 0;
}

static unsigned long snd_aicapcm_pcm_pointer(struct snd_pcm_substream
					     *substream)
{
	return readl(AICA_CONTROL_CHANNEL_SAMPLE_NUMBER);
}

static struct snd_pcm_ops snd_aicapcm_playback_ops = {
	.open = snd_aicapcm_pcm_open,
	.close = snd_aicapcm_pcm_close,
	.ioctl = snd_pcm_lib_ioctl,
	.hw_params = snd_aicapcm_pcm_hw_params,
	.hw_free = snd_aicapcm_pcm_hw_free,
	.prepare = snd_aicapcm_pcm_prepare,
	.trigger = snd_aicapcm_pcm_trigger,
	.pointer = snd_aicapcm_pcm_pointer,
};

/* TO DO: set up to handle more than one pcm instance */
static int __init snd_aicapcmchip(struct snd_card_aica
				  *dreamcastcard, int pcm_index)
{
	struct snd_pcm *pcm;
	int err;
	/* AICA has no capture ability */
	if ((err =
	     snd_pcm_new(dreamcastcard->card, "AICA PCM", pcm_index, 1, 0,
			 &pcm)) < 0)
		return err;
	pcm->private_data = dreamcastcard;
	strcpy(pcm->name, "AICA PCM");
	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
			&snd_aicapcm_playback_ops);
	/* Allocate the DMA buffers */
	err =
	    snd_pcm_lib_preallocate_pages_for_all(pcm,
						  SNDRV_DMA_TYPE_CONTINUOUS,
						  snd_dma_continuous_data
						  (GFP_KERNEL),
						  AICA_BUFFER_SIZE,
						  AICA_BUFFER_SIZE);
	return err;
}

/* Mixer controls */
static int aica_pcmswitch_info(struct snd_kcontrol *kcontrol,
			       struct snd_ctl_elem_info *uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
	uinfo->count = 1;
	uinfo->value.integer.min = 0;
	uinfo->value.integer.max = 1;
	return 0;
}

static int aica_pcmswitch_get(struct snd_kcontrol *kcontrol,
			      struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.integer.value[0] = 1;	/* TO DO: Fix me */
	return 0;
}

static int aica_pcmswitch_put(struct snd_kcontrol *kcontrol,
			      struct snd_ctl_elem_value *ucontrol)
{
	if (ucontrol->value.integer.value[0] == 1)
		return 0;	/* TO DO: Fix me */
	else
		aica_chn_halt();
	return 0;
}

static int aica_pcmvolume_info(struct snd_kcontrol *kcontrol,
			       struct snd_ctl_elem_info *uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
	uinfo->count = 1;
	uinfo->value.integer.min = 0;
	uinfo->value.integer.max = 0xFF;
	return 0;
}

static int aica_pcmvolume_get(struct snd_kcontrol *kcontrol,
			      struct snd_ctl_elem_value *ucontrol)
{
	struct snd_card_aica *dreamcastcard;
	dreamcastcard = kcontrol->private_data;
	if (!dreamcastcard->channel)
		return -ETXTBSY;	/* we've not yet been set up */
	ucontrol->value.integer.value[0] = dreamcastcard->channel->vol;
	return 0;
}

static int aica_pcmvolume_put(struct snd_kcontrol *kcontrol,
			      struct snd_ctl_elem_value *ucontrol)
{
	struct snd_card_aica *dreamcastcard;
	dreamcastcard = kcontrol->private_data;
	if (!dreamcastcard->channel) {
		snd_printk("No channel yet\n");
		return -ETXTBSY;	/* too soon */
	} else
	    if (dreamcastcard->channel->vol ==
		ucontrol->value.integer.value[0])
		return 0;
	else {
		dreamcastcard->channel->vol =
		    ucontrol->value.integer.value[0];
		dreamcastcard->master_volume =
		    ucontrol->value.integer.value[0];
		spu_memload(AICA_CHANNEL0_CONTROL_OFFSET,
			    (uint8_t *) dreamcastcard->channel,
			    sizeof(struct aica_channel));
	}
	return 1;
}

static struct snd_kcontrol_new snd_aica_pcmswitch_control __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "PCM Playback Switch",
	.index = 0,
	.info = aica_pcmswitch_info,
	.get = aica_pcmswitch_get,
	.put = aica_pcmswitch_put
};
static struct snd_kcontrol_new snd_aica_pcmvolume_control __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "PCM Playback Volume",
	.index = 0,.info = aica_pcmvolume_info,
	.get = aica_pcmvolume_get,
	.put = aica_pcmvolume_put
};
static int remove_dreamcastcard(struct device *dreamcast_device)
{
	struct snd_card_aica *dreamcastcard =
	    dreamcast_device->driver_data;
	snd_card_free(dreamcastcard->card);
	kfree(dreamcastcard);
	return 0;
}

static struct device_driver aica_driver = {
	.name = "AICA",.bus = &platform_bus_type,
	.remove = remove_dreamcastcard,
};

/* Fill up the members of the embedded device structure */
static void populate_dreamcastaicadev(struct device *dev)
{
	dev->bus = &platform_bus_type;
	dev->driver = &aica_driver;
	driver_register(dev->driver);
	device_bind_driver(dev);
}

static int load_aica_firmware()
{
	int err;
	err = 0;
	spu_init();
	const struct firmware *fw_entry;
	err = request_firmware(&fw_entry, "aica_firmware.bin", &pd->dev);
	if (err)
		return err;
	/* write firware into memory */
	spu_disable();
	spu_memload(0, fw_entry->data, fw_entry->size);
	spu_enable();
	release_firmware(fw_entry);
	return err;
}

static int __devinit add_aicamixer_controls(struct snd_card_aica
					    *dreamcastcard)
{
	int err;
	err = snd_ctl_add
	    (dreamcastcard->card,
	     snd_ctl_new1(&snd_aica_pcmvolume_control, dreamcastcard));
	if (err < 0) {
		snd_printk
		    ("AICA sound: Could not add PCM volume control\n");
		return err;
	}
	err = snd_ctl_add
	    (dreamcastcard->card,
	     snd_ctl_new1(&snd_aica_pcmswitch_control, dreamcastcard));
	if (err < 0) {
		snd_printk
		    ("AICA sound: Could not add PCM switch control\n");
		return err;
	}
	return 0;
}

static int __init aica_init(void)
{
	int err;
	struct snd_card_aica *dreamcastcard;
	/* Are we in a Dreamcast at all? */
	if (!mach_is_dreamcast())
		return -ENODEV;

	dreamcastcard = kmalloc(sizeof(struct snd_card_aica), GFP_KERNEL);
	if (!dreamcastcard)
		return -ENOMEM;
	dreamcastcard->card = snd_card_new(index, "AICA", THIS_MODULE, 0);
	if (!dreamcastcard->card) {
		kfree(dreamcastcard);
		return -ENODEV;
	}
	strcpy(dreamcastcard->card->driver, "snd_aica");
	strcpy(dreamcastcard->card->shortname, "AICA");
	strcpy(dreamcastcard->card->longname,
	       "Yamaha AICA Super Intelligent Sound Processor for SEGA Dreamcast");
	/* Load the PCM 'chip' */
	err = snd_aicapcmchip(dreamcastcard, 0);
	if (err < 0)
		goto freedreamcast;
	pd = platform_device_register_simple(dreamcastcard->card->driver,
					     -1, aica_memory_space, 2);
	if (IS_ERR(pd)) {
		err = PTR_ERR(pd);
		goto freepcm;
	}
	populate_dreamcastaicadev(&pd->dev);
	snd_card_set_dev(dreamcastcard->card, &pd->dev);
	pd->dev.driver_data = dreamcastcard;
	dreamcastcard->timer.data = 0;
	dreamcastcard->channel = NULL;
	/* Load the firmware */
	err = load_aica_firmware();
	if (err < 0)
		goto freedreamcast;
	/* Add basic controls */
	err = add_aicamixer_controls(dreamcastcard);
	if (err < 0)
		goto freedreamcast;
	/* Register the card with ALSA subsystem */
	err = snd_card_register(dreamcastcard->card);
	if (err < 0)
		goto freedreamcast;
	snd_printk
	    ("ALSA Driver for Yamaha AICA Super Intelligent Sound Processor\n");
	return 0;
      freepcm:
      freedreamcast:
	snd_card_free(dreamcastcard->card);
	if (pd) {
		struct device_driver *drv = (&pd->dev)->driver;
		device_release_driver(&pd->dev);
		driver_unregister(drv);
		platform_device_unregister(pd);
		pd = NULL;
	}
	kfree(dreamcastcard);
	return err;
}

static void __exit aica_exit(void)
{
	struct device_driver *drv = (&pd->dev)->driver;
	device_release_driver(&pd->dev);
	driver_unregister(drv);
	platform_device_unregister(pd);
	/* Kill any sound still playing and reset ARM7 to safe state */
	spu_init();
	return;
}

module_init(aica_init);
module_exit(aica_exit);

--=-R62YD8RDtdFUkX6ezsaS
Content-Disposition: attachment; filename=aica.h
Content-Type: text/x-chdr; name=aica.h; charset=UTF-8
Content-Transfer-Encoding: 7bit

/* aica.h
 * Header file for ALSA driver for
 * Sega Dreamcast Yamaha AICA sound
 * Copyright Adrian McMenamin
 * <adrian@mcmen.demon.co.uk>
 * 2006
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of version 2 of the GNU General Public License as published by
 * the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

/* SPU memory and register constants etc */
#define G2_FIFO 0xa05f688c
#define SPU_MEMORY_BASE 0xA0800000
#define ARM_RESET_REGISTER 0xA0702C00
#define SPU_REGISTER_BASE 0xA0700000



/* AICA channels stuff */

#define AICA_CONTROL_POINT 0xA0810000
#define AICA_CONTROL_CHANNEL_SAMPLE_NUMBER 0xA0810008
#define AICA_CHANNEL0_CONTROL_OFFSET 0x10004

/* Command values */
#define AICA_CMD_KICK 0x80000000
#define AICA_CMD_NONE 0
#define AICA_CMD_START 1
#define AICA_CMD_STOP 2
#define AICA_CMD_VOL 3

/* Sound modes */
#define SM_8BIT		1
#define SM_16BIT	0
#define SM_ADPCM	2

/* Buffer and period size */
#define AICA_BUFFER_SIZE 0x8000
#define AICA_PERIOD_SIZE 0x800
#define AICA_PERIOD_NUMBER 16

#define AICA_CHANNEL0_OFFSET 0x11000
#define AICA_CHANNEL1_OFFSET 0x21000
#define CHANNEL_OFFSET 0x10000

#define AICA_DMA_CHANNEL 0
#define AICA_DMA_MODE 5


struct aica_channel {
	uint32_t cmd;		/* Command ID           */
	uint32_t pos;		/* Sample position      */
	uint32_t length;	/* Sample length        */
	uint32_t freq;		/* Frequency            */
	uint32_t vol;		/* Volume 0-255         */
	uint32_t pan;		/* Pan 0-255            */
	uint32_t sfmt;		/* Sound format         */
	uint32_t flags;		/* Bit flags            */
};


struct snd_card_aica {
	struct snd_card *card;
	struct aica_channel *channel;
	snd_pcm_substream_t *substream;
	int clicks;
	int current_period;
	struct timer_list timer;
	int master_volume;
	struct work_struct work;
	struct work_struct work2;
	struct workqueue_struct *workqueue;
};



--=-R62YD8RDtdFUkX6ezsaS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-R62YD8RDtdFUkX6ezsaS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-R62YD8RDtdFUkX6ezsaS--
