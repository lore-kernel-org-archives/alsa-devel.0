From: Charles Eidsness <charles.eidsness@ieee.org>
Subject: Problems Writing a Driver for an AMD Au1000 MIPS Processor
Date: Mon, 07 Jun 2004 10:27:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C47B3A.3090500@ieee.org>
Reply-To: charles.eidsness@ieee.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070402020909090304080403"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070402020909090304080403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've been trying to write an ALSA driver for the AC97 port on an 
embedded AMD au1000 MIPS processor but am having some difficulties. The 
processor's DMA controller has two buffers which automatically toggle 
back and forth once the buffer is full. My problem is that when I 
playback a wave file (just using cat xxx > /dev/dsp) it sounds choppy if 
I run the spin_unlock_irqrestore on every interrupt, it's only playing 
back half the data. But if I run the spin_unlock_irqrestore function on 
every-other interrupt and have only two periods it sounds fine. I'm 
guessing I'm handling the streaming interface with the ALSA API incorrectly.

I've attached my code and am hoping someone may be kind enough to take a 
quick look at it and let me know if anything looks incorrect. Or 
possibly point me to some documentation or another driver that may be 
useful.

Also, currently the only two devices I have are dsp and mixer, i.e. OSS 
emulation only, and I have no configuration files. The reason being that 
I would like a minimum installation but I haven't been able to find any 
documentation on what are the minimum devices / configuration files 
required. All I want is a stereo playback and single channel capture 
using an AC97 interface. Does anyone have any insite on what a minimum 
install would look like, or is there some documentation that I've missed?

Thanks!
Charles

--------------070402020909090304080403
Content-Type: text/plain;
 name="au1000.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1000.c"

/*
 *  Driver for AMD Au1000 MIPS Processor, AC'97 Sound Port
 *  Copyright (C) 2004 Charles Eidsness <charles.eidsness@ieee.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License.
 * 
 * History:
 *
 * 2004-05-04 Charles Eidsness -- Original non-working verion -- based on
 * 				  sa11xx-uda1341.c ALSA driver and the
 *				  au1000.c OSS driver.
 */

#include <linux/ioport.h>
#include <linux/interrupt.h>
#include <sound/driver.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <sound/core.h>
#include <sound/initval.h>
#include <sound/pcm.h>
#include <sound/ac97_codec.h>
#include <asm/mach-au1x00/au1000.h>
#include <asm/mach-au1x00/au1000_dma.h>

MODULE_AUTHOR("Charles Eidsness <charles.eidsness@ieee.org>");
MODULE_DESCRIPTION("Au1000 AC'97 ALSA Driver");
MODULE_LICENSE("GPL");
MODULE_CLASSES("{sound}");
MODULE_DEVICES("{{AMD,Au1000 AC'97}}");

#define chip_t au1000_t

#define PLAYBACK 0
#define CAPTURE 1
#define AC97_SLOT_3 0x01
#define AC97_SLOT_4 0x02
#define AC97_SLOT_6 0x08

//Au1000 AC97 Port Control Reisters
typedef struct au1000_ac97_reg au1000_ac97_reg_t;
struct au1000_ac97_reg {
	u32 volatile config;
	u32 volatile status;
	u32 volatile data;
	u32 volatile cmd;
	u32 volatile cntrl;
};

typedef struct audio_stream audio_stream_t;
struct audio_stream {
	int dma;
	snd_pcm_substream_t * substream;
	spinlock_t dma_lock;
	int stopped;
	int period;
	struct ac97_pcm *pcm;
	int pcm_open_flag;
	int rate_reg;
	unsigned long int dma_size;
	unsigned long int dma_start;
};

typedef struct snd_card_au1000 {
	snd_card_t *card;

	au1000_ac97_reg_t volatile *ac97_ioport;
	struct resource *ac97_res_port;
	spinlock_t ac97_lock;

	ac97_t *ac97;
	snd_pcm_t *pcm;
	audio_stream_t *stream[2];	// playback & capture
} au1000_t;

static au1000_t *au1000 = NULL;

//--------------------------- Local Functions ---------------------------------

static void
au1000_set_ac97_slots(int xmit_slots, int recv_slots)
{
	u32 volatile ac97_config = au1000->ac97_ioport->config;

	spin_lock(&au1000->ac97_lock);
	ac97_config = ac97_config & ~AC97C_XMIT_SLOTS_MASK;
	ac97_config = ac97_config & ~AC97C_RECV_SLOTS_MASK;
	ac97_config |= (xmit_slots << AC97C_XMIT_SLOTS_BIT);
	ac97_config |= (recv_slots << AC97C_RECV_SLOTS_BIT);
	au1000->ac97_ioport->config = ac97_config;
	spin_unlock(&au1000->ac97_lock);
	
	au1000->stream[PLAYBACK]->rate_reg = AC97_PCM_FRONT_DAC_RATE;
	au1000->stream[CAPTURE]->rate_reg = AC97_PCM_LR_ADC_RATE;
}

static void
au1000_dma_stop(audio_stream_t *stream)
{
	unsigned long   flags;
	if (stream->stopped)
		return;
	spin_lock_irqsave(&stream->dma_lock, flags);
	disable_dma(stream->dma);
	stream->stopped = 1;
	stream->period = 0;
	spin_unlock_irqrestore(&stream->dma_lock, flags);
}

static void 
au1000_dma_start(audio_stream_t *stream)
{
	snd_pcm_substream_t *substream = stream->substream;
	snd_pcm_runtime_t *runtime = substream->runtime;

	unsigned long int bufx_adr, bufy_adr, offset;
	unsigned long flags;

	if (!stream->stopped)
		return;

	stream->dma_size = frames_to_bytes(runtime, runtime->period_size);
	stream->dma_start = virt_to_phys(runtime->dma_area);

	offset = stream->dma_size * stream->period;
	bufx_adr = stream->dma_start + offset;

	stream->period++;
	if (stream->period == runtime->periods)
		stream->period = 0;

	offset = stream->dma_size * stream->period;
	bufy_adr = stream->dma_start + offset;

	spin_lock_irqsave(&stream->dma_lock, flags);
	init_dma(stream->dma);
	if (get_dma_active_buffer(stream->dma) == 0) {
		clear_dma_done0(stream->dma);
		set_dma_addr0(stream->dma, bufx_adr);
		set_dma_addr1(stream->dma, bufy_adr);
	} else {
		clear_dma_done1(stream->dma);
		set_dma_addr1(stream->dma, bufx_adr);
		set_dma_addr0(stream->dma, bufy_adr);
	}
	set_dma_count(stream->dma, stream->dma_size>>1);
	enable_dma_buffers(stream->dma);
	start_dma(stream->dma);
	spin_unlock_irqrestore(&stream->dma_lock, flags);

	stream->stopped = 0;

}

static irqreturn_t
au1000_dma_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	audio_stream_t *stream = (audio_stream_t *) dev_id;
	snd_pcm_substream_t *substream = stream->substream;
	snd_pcm_runtime_t *runtime = substream->runtime;
	unsigned long int offset, buf_adr;
	u32 buff_done;

	if ((buff_done = get_dma_buffer_done(stream->dma)) == 0) {
		return IRQ_NONE;
	}

	stream->period++;
	if (stream->period == runtime->periods)
		stream->period = 0;

	offset = stream->dma_size * stream->period;
	buf_adr = stream->dma_start + offset;

	spin_lock(&stream->dma_lock);
	if (buff_done == DMA_D0) {
		clear_dma_done0(stream->dma);
		set_dma_count0(stream->dma, stream->dma_size>>1);
		set_dma_addr0(stream->dma, buf_adr);
		enable_dma_buffer0(stream->dma);
	}
	if (buff_done == DMA_D1) {
		clear_dma_done1(stream->dma);
		set_dma_count1(stream->dma, stream->dma_size>>1);
		set_dma_addr1(stream->dma, buf_adr);
		enable_dma_buffer1(stream->dma);
	}
	if (buff_done == DMA_D1 | DMA_D1) {
		spin_unlock(&stream->dma_lock);
		snd_pcm_period_elapsed(substream);
		printk(KERN_ERR "Au1000 AC97 ALSA: DMA %d missed interrupt."
								,stream->dma);
		au1000_dma_stop(stream);
		au1000_dma_start(stream);
		return IRQ_HANDLED;
	}
	
	spin_unlock(&stream->dma_lock);
	snd_pcm_period_elapsed(substream);
	return IRQ_HANDLED;
}

//-------------------------- PCM Audio Streams --------------------------------

static unsigned int rates[] = {48000};
static snd_pcm_hw_constraint_list_t hw_constraints_rates = {
	.count	=  sizeof(rates) / sizeof(rates[0]),
	.list	= rates,
	.mask	= 0,
};

static snd_pcm_hardware_t snd_au1000_playback =
{
	.info			= (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BATCH),
	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
	.rates			= SNDRV_PCM_RATE_CONTINUOUS,
	.rate_min		= 48000,
	.rate_max		= 48000,
	.channels_min		= 2,
	.channels_max		= 2,
	.buffer_bytes_max	= 128*1024,
	.period_bytes_min	= 32,
	.period_bytes_max	= 128*1024,
	.periods_min		= 2,
	.periods_max		= 255,
	.fifo_size		= 16,
};

static snd_pcm_hardware_t snd_au1000_capture =
{
	.info			= (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BATCH),
	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
	.rates			= SNDRV_PCM_RATE_CONTINUOUS,
	.rate_min		= 48000,
	.rate_max		= 48000,
	.channels_min		= 1,
	.channels_max		= 1,
	.buffer_bytes_max	= 128*1024,
	.period_bytes_min	= 32,
	.period_bytes_max	= 128*1024,
	.periods_min		= 2,
	.periods_max		= 255,
	.fifo_size		= 16,
};

static int
snd_au1000_playback_open(snd_pcm_substream_t * substream)
{
	au1000->stream[PLAYBACK]->substream = substream;
	substream->private_data = au1000->stream[PLAYBACK];
	substream->runtime->hw = snd_au1000_playback;
	return (snd_pcm_hw_constraint_list(substream->runtime, 0,
		SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates) < 0);
}

static int
snd_au1000_capture_open(snd_pcm_substream_t * substream)
{
	au1000->stream[CAPTURE]->substream = substream;
	substream->private_data = au1000->stream[CAPTURE];
	substream->runtime->hw = snd_au1000_capture;
	return (snd_pcm_hw_constraint_list(substream->runtime, 0,
		SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates) < 0);

}

static int
snd_au1000_playback_close(snd_pcm_substream_t * substream)
{
	au1000->stream[PLAYBACK]->substream = NULL;
	return 0;
}

static int
snd_au1000_capture_close(snd_pcm_substream_t * substream)
{
	au1000->stream[CAPTURE]->substream = NULL;
	return 0;
}

static int
snd_au1000_hw_params(snd_pcm_substream_t * substream,
					snd_pcm_hw_params_t * hw_params)
{
	return snd_pcm_lib_malloc_pages(substream,
					params_buffer_bytes(hw_params));
}

static int
snd_au1000_hw_free(snd_pcm_substream_t * substream)
{
	return snd_pcm_lib_free_pages(substream);
}

static int
snd_au1000_prepare(snd_pcm_substream_t * substream)
{
	audio_stream_t *stream = substream->private_data;
	snd_ac97_set_rate(au1000->ac97, stream->rate_reg, substream->runtime->rate);
	stream->period = 0;
	return 0;
}

static int
snd_au1000_trigger(snd_pcm_substream_t * substream, int cmd)
{
	audio_stream_t *stream = substream->private_data;
	int err = 0;
	
	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
		au1000_dma_start(stream);
		break;
	case SNDRV_PCM_TRIGGER_STOP:
		au1000_dma_stop(stream);
		break;
	default:
		err = -EINVAL;
		break;
	}
	return err;
}

static snd_pcm_uframes_t
snd_au1000_pointer(snd_pcm_substream_t * substream)
{
	audio_stream_t *stream = substream->private_data;
	snd_pcm_runtime_t *runtime = substream->runtime;
	unsigned long location, flags;
	spin_lock_irqsave(&stream->dma_lock, flags);
	location = get_dma_residue(stream->dma);
	spin_unlock_irqrestore(&stream->dma_lock, flags);
	location = stream->dma_size - location;
	return bytes_to_frames(runtime,location);
}

static snd_pcm_ops_t snd_card_au1000_playback_ops = {
	.open			= snd_au1000_playback_open,
	.close			= snd_au1000_playback_close,
	.ioctl			= snd_pcm_lib_ioctl,
	.hw_params	        = snd_au1000_hw_params,
	.hw_free	        = snd_au1000_hw_free,
	.prepare		= snd_au1000_prepare,
	.trigger		= snd_au1000_trigger,
	.pointer		= snd_au1000_pointer,
};

static snd_pcm_ops_t snd_card_au1000_capture_ops = {
	.open			= snd_au1000_capture_open,
	.close			= snd_au1000_capture_close,
	.ioctl			= snd_pcm_lib_ioctl,
	.hw_params	        = snd_au1000_hw_params,
	.hw_free	        = snd_au1000_hw_free,
	.prepare		= snd_au1000_prepare,
	.trigger		= snd_au1000_trigger,
	.pointer		= snd_au1000_pointer,
};

static int __devinit
snd_au1000_pcm_new(void)
{
	snd_pcm_t *pcm;
	int err;
	unsigned long flags;

	 //xmit , recv
	au1000_set_ac97_slots(AC97_SLOT_3 | AC97_SLOT_4, AC97_SLOT_3);

	if ((err = snd_pcm_new(au1000->card, "AU1000 AC97 PCM", 0, 1, 1, &pcm)) < 0)
		return err;

	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
		snd_dma_continuous_data(GFP_KERNEL), 64*1024, 64*1024);

	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
		&snd_card_au1000_playback_ops);
	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
		&snd_card_au1000_capture_ops);
		
	pcm->private_data = au1000;
	pcm->info_flags = 0;
	strcpy(pcm->name, "Au1000 AC97 PCM");

	flags = claim_dma_lock();
	if ((au1000->stream[PLAYBACK]->dma = request_au1000_dma(DMA_ID_AC97C_TX,
			"AC97 TX", au1000_dma_interrupt, SA_INTERRUPT,
			au1000->stream[PLAYBACK])) < 0) {
		release_dma_lock(flags);
		return -EBUSY;
	}
	if ((au1000->stream[CAPTURE]->dma = request_au1000_dma(DMA_ID_AC97C_RX,
			"AC97 RX", au1000_dma_interrupt, SA_INTERRUPT,
			au1000->stream[CAPTURE])) < 0){
		release_dma_lock(flags);
		return -EBUSY;
	}
	// enable DMA coherency in read/write DMA channels
	set_dma_mode(au1000->stream[PLAYBACK]->dma,
		     get_dma_mode(au1000->stream[PLAYBACK]->dma) & ~DMA_NC);
	set_dma_mode(au1000->stream[CAPTURE]->dma,
		     get_dma_mode(au1000->stream[CAPTURE]->dma) & ~DMA_NC);
	release_dma_lock(flags);
	spin_lock_init(&au1000->stream[PLAYBACK]->dma_lock);
	spin_lock_init(&au1000->stream[CAPTURE]->dma_lock);
	au1000->pcm = pcm;
	return 0;
}


//-------------------------- AC97 CODEC Control -------------------------------

static unsigned short 
snd_au1000_ac97_read(ac97_t *ac97, unsigned short reg)
{
	u32 volatile cmd;
	u16 volatile data;
	int             i;

	spin_lock(au1000->ac97_lock);
//TODO: Convert to interupt driver access.
//FIXME: Once in a while, with multiple stream rading will get an incorrect
//read ---- read data is only valid for one frame, maybe this is what's causing
//the problem...
	for (i = 0; i < 0x5000; i++)
		if (!(au1000->ac97_ioport->status & AC97C_CP))
			break;
	if (i == 0x5000)
		printk(KERN_ERR "ALSA AC97: AC97 command read timeout\n");

	cmd = (u32) reg & AC97C_INDEX_MASK;
	cmd |= AC97C_READ;
	au1000->ac97_ioport->cmd = cmd;

	/* now wait for the data */
	for (i = 0; i < 0x5000; i++)
		if (!(au1000->ac97_ioport->status & AC97C_CP))
			break;
	if (i == 0x5000) {
		printk(KERN_ERR "ALSA AC97: AC97 command read timeout\n");
		return 0;
	}

	data = au1000->ac97_ioport->cmd & 0xffff;
	spin_unlock(au1000->ac97_lock);

	return data;
	
}

static void
snd_au1000_ac97_write(ac97_t *ac97, unsigned short reg, unsigned short val)
{
	u32 cmd;
	int i;
	
	spin_lock(au1000->ac97_lock);
//TODO: Convert to interupt driver access.
	for (i = 0; i < 0x5000; i++)
		if (!(au1000->ac97_ioport->status & AC97C_CP))
			break;
	if (i == 0x5000)
		printk(KERN_ERR "ALSA AC97: AC97 command write timeout\n");
	cmd = (u32) reg & AC97C_INDEX_MASK;
	cmd &= ~AC97C_READ;
	cmd |= ((u32) val << AC97C_WD_BIT);
	au1000->ac97_ioport->cmd = cmd;
	spin_unlock(au1000->ac97_lock);
}

static void
snd_au1000_ac97_free(ac97_t *ac97)
{
	au1000->ac97 = NULL;
}

static int __devinit
snd_au1000_ac97_new(void)
{
	ac97_bus_t bus, *pbus;
	ac97_t ac97;
	int err;

	if ((au1000->ac97_res_port = request_region(AC97C_CONFIG,
	       		sizeof(au1000_ac97_reg_t), "Au1x00 AC97")) == NULL) {
		snd_printk(KERN_ERR "ALSA AC97: can't grap AC97 port\n");
		return -EBUSY;
	}
	au1000->ac97_ioport = (au1000_ac97_reg_t *) au1000->ac97_res_port->start;

	spin_lock_init(&au1000->ac97_lock);

	spin_lock(au1000->ac97_lock);

	//configure pins for AC'97
	//TODO: move to board_setup.c
	au_writel(au_readl(SYS_PINFUNC) & ~0x02, SYS_PINFUNC);

	//Initialise Au1000's AC'97 Control Block
	au1000->ac97_ioport->cntrl = AC97C_RS | AC97C_CE;
	udelay(10);
	au1000->ac97_ioport->cntrl = AC97C_CE;
	udelay(10);

	//Initialise External CODEC
	//cold reset
	au1000->ac97_ioport->config = AC97C_RESET;
	udelay(1);
	au1000->ac97_ioport->config = 0x0;
	mdelay(5);

	spin_unlock(au1000->ac97_lock);

	//Initialise AC97 middle-layer
	memset(&bus, 0, sizeof(bus));
	bus.write = snd_au1000_ac97_write;
	bus.read = snd_au1000_ac97_read;
	if ((err = snd_ac97_bus(au1000->card, &bus, &pbus)) < 0)
		return err;
	memset(&ac97, 0, sizeof(ac97));
	ac97.private_data = au1000;
	ac97.private_free = snd_au1000_ac97_free;
	if ((err = snd_ac97_mixer(pbus, &ac97, &au1000->ac97)) < 0)
		return err;
	return 0;

}

//------------------------------ Setup / Destroy ------------------------------

void
snd_au1000_free(snd_card_t *card)
{

	if (au1000->ac97_res_port) {
		//put internal AC97 block into reset
		au1000->ac97_ioport->cntrl = AC97C_RS;
		au1000->ac97_ioport = NULL;
		release_resource(au1000->ac97_res_port);
		kfree_nocheck(au1000->ac97_res_port);
	}

	if (au1000->stream[PLAYBACK]->dma >= 0)
		free_au1000_dma(au1000->stream[PLAYBACK]->dma);

	if (au1000->stream[CAPTURE]->dma >= 0)
		free_au1000_dma(au1000->stream[CAPTURE]->dma);

	kfree(au1000->stream[PLAYBACK]);
	au1000->stream[PLAYBACK] = NULL;
	kfree(au1000->stream[CAPTURE]);
	au1000->stream[CAPTURE] = NULL;
	kfree(au1000);
	au1000 = NULL;

}

static int __init 
au1000_init(void)
{
	int err;

	au1000 = kmalloc(sizeof(au1000_t), GFP_KERNEL);
	if (au1000 == NULL)
		return -ENOMEM;
	au1000->stream[PLAYBACK] = kmalloc(sizeof(audio_stream_t), GFP_KERNEL);
	if (au1000->stream[PLAYBACK] == NULL)
		return -ENOMEM;
	au1000->stream[CAPTURE] = kmalloc(sizeof(audio_stream_t), GFP_KERNEL);
	if (au1000->stream[CAPTURE] == NULL)
		return -ENOMEM;
	//so that snd_au1000_free will work as intended
	au1000->stream[PLAYBACK]->dma = -1;
	au1000->stream[CAPTURE]->dma = -1;
 	au1000->ac97_res_port = NULL;
	
	au1000->card = snd_card_new(-1, "AC97", THIS_MODULE, sizeof(au1000_t));
	if (au1000->card == NULL) {
		snd_au1000_free(au1000->card);
		return -ENOMEM;
	}

	au1000->card->private_data = (au1000_t *)au1000;
	au1000->card->private_free = snd_au1000_free;

	if ((err = snd_au1000_ac97_new()) < 0 ) {
		snd_card_free(au1000->card);
		return err;
	}

	if ((err = snd_au1000_pcm_new()) < 0) {
		snd_card_free(au1000->card);
		return err;
	}

	strcpy(au1000->card->driver, "AMD-Au1000-AC97");
	strcpy(au1000->card->shortname, "Au1000-AC97");
	sprintf(au1000->card->longname, "AMD Au1000--AC97 ALSA Driver");

	if ((err = snd_card_register(au1000->card)) < 0) {
		snd_card_free(au1000->card);
		return err;
	}

	printk( KERN_INFO "ALSA AC97: Driver Initialized\n" );
	return 0;
}

static void __exit au1000_exit(void)
{
	snd_card_free(au1000->card);
}

module_init(au1000_init);
module_exit(au1000_exit);

//------------------------------------ End ------------------------------------


--------------070402020909090304080403--



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
