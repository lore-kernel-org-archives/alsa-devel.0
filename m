From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: ca0106 Digital Output at 44.1kHz
Date: Wed, 21 May 2008 00:32:19 +1000
Message-ID: <1211293939.3811.20.camel@localhost>
References: <1205410524.8486.274.camel@localhost>
	<47E4E00C.2010108@superbug.co.uk> <1206445721.3683.45.camel@localhost>
	<4807B8A5.3080807@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-X5cctbPCO4CF/e2eZDND"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 250C6248AA
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 16:32:25 +0200 (CEST)
In-Reply-To: <4807B8A5.3080807@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-X5cctbPCO4CF/e2eZDND
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Further to this old discussion of 44.1kHz on ca0106 cards,

I have implemented a patch that 'works for me' on my mythtv box. It
allows me to play 44.1kHz to SPDIF digital output.

I only need one 'device', e.g. hw:0,0 . Just as well, I can only manage
to get output from hw:0,0 on SPDIF on my Sound Blaster Audigy Value!
card.

I never received any reply from Creative on my NDA request. I followed
up with Phillip Williams, who forwarded my query to corporate, but
didn't receive a reply from that. I need to follow up again.

Anyway, I have a patch. I have based it upon the current Ubuntu kernel
2.6.22-14.52. I have attached the patch with respect to the original
file, and the complete modified file. I think I have more work to do
before it can be merged, such as re-basing the patch on latest git. (I
had problems accessing git tonight, so I'll try again when fixed.)

I implemented a constraint system to restrict the available sampling
frequencies in accordance with the rules previously determined (you may
select one or more channels in 44.1kHz, XOR you may select one or more
channels in any of 48kHz, 96kHz and 192kHz).

The problem is to decide when a device has its sampling frequency
'allocated'. At the moment, the patch uses the 'running' (true between
triggering RUN and triggering STOP) variable to determine if the device
is in use. This definition probably allows a race condition between
testing the constraint and triggering the RUN. I need some help here to
figure out a more robust scheme, as I don't understand the internals of
the ALSA PCM layer yet.

Once we have figured out how to deal with the sampling frequencies, I'll
deal with the sampling format in the same way.

Anyway, I submit the patch to the list for review and comment.

Ben Stanley.



On Thu, 2008-04-17 at 21:52 +0100, James Courtier-Dutton wrote:
> Ben Stanley wrote:
> > 
> > So, could we then change the number of channels available depending upon
> > which card is detected? It doesn't seem to make sense to make things
> > available to the user via the driver that they can't plug something into
> > on their particular model card. I guess that to do this I would have to
> > know how many digital output channels are supported by each card. I
> > downloaded the user manuals for a few of the cards; I only got the
> > impression that each card supported one digital output. Do you know
> > which card you tested for multiple outputs?
> 
> Unfortunately the datasheets do not give me card specific details. Only 
> how to program the ca0106 chip. The GPIO etc. for each card is 
> determined by trial and error.
> 
> > 
> > Now, the Creative Labs user documentation gives me the impression that I
> > can use the analog output channels at the same time as the digital
> > output channel. That also doesn't appear to agree with how the driver is
> > written. I am currently under the impression that the driver is written
> > to allow 4 stereo analog channels or 4 digital channels. At least that
> > is how things look when configuring things using alsamixer. Perhaps I am
> > confused and should go and look at the GPIO that you mentioned above.
> 
> This particular sound card can output to both analog and digital 
> channels. The sound is simply duplicated to both. I disabled it 
> happening at the same time mainly due to what happens when AC3 or DTS is 
> output to the digital. One would not want that send to the analog outputs!
> 
> > 
> >>> Details:
> >>>
> >>> The card I have is characterised by the following:
> >>> http://www.soundblaster.com/products/product.asp?category=1&subcategory=205&product=14189
> >>> Model: SB0570
> >>> serial: 100a1102
> >>> Also known as: Sound Blaster Audigy SE
> >>>
> >>> During initial testing, I noticed that 44.1kHz playback was not
> >>> implemented. Subsequent testing shows that speaker-test works fine with
> >>> 48kHz, 96kHz and 192kHz. (I only tested 16bit output so far.)
> >>>
> >>> I noticed in the source code that 44.1k was explicitly disabled. I added
> >>> code in snd_ca0106_pcm_prepare_playback to set up this rate for S/PDIF
> >>> output as per the comments in ca0106.h . Initial tests using hw:0,0 at
> >>> 44.1kHz produced recognisable signals with some noisy corruption. Later
> >>> I accidentally discovered that serially opening hw:0,2 , hw:0,1 and
> >>> hw:0,0  at 44.1kHz then produces perfectly good 44.1kHz sampled digital
> >>> audio output. Removing hw:0,1 or hw:0,2 from this sequence causes noisy
> >>> corruption. It seems that channels 0-2 in reg40 must all be set to the
> >>> same sampling frequency for S/PDIF to work where 44.1kHz is concerned.
> >>> Conversely, to sucessfully output 48kHz again, I have to open hw:0,2 ,
> >>> hw:0,1 and hw:0,0 at 48kHz to restore proper output. I do not have such
> >>> troubles with 96kHz and 192kHz, for which it suffices to just open
> >>> hw:0,0 at the relevant sampling rate.
> >>>   
> >> The ca0106 can do 44.1kHz for digital output ONLY.
> >> The ca0106 cannot output 44.1kHz to the DACs so it will only work in 
> >> Digital mode.
> >> It is a hardware restriction. You are correct, all the inputs and 
> >> outputs have to be at the same rate.
> > 
> > So far I haven't considered 'inputs', although I do now have the digital
> > I/O module so that I can get digital signals into the card. I suspect I
> > can only generate 44.1kHz and 48kHz sampled input signals to test with.
> > 
> > So for my card where only one output channel appears to be available
> > (can you tell from the doc if this is true?), then I would just slave
> > the other hardware channels to hw:0,0 settings. However, on other cards
> > where the other channels are in fact available, how do you enforce the
> > restriction that all the channels must have the same sampling frequency
> > within the ALSA model?
> > 
> > I'm just trying to plan how I would fix this properly within the driver.
> 
> You could set the driver to fix to the rate of the first opened device, 
> and only when all devices have been closed could the rate change again.
> This is unfortunately not at all intuitive for the user. I would 
> therefore add a global mixer control to set 44.1 or 48kHz. The user 
> could then decide which to use. 44.1 would mean 44.1, 88.2 etc.
> 48 would mean 48, 96, 192.
> 
> By the way, the spdif output on the ca0106 works well at 96kHz also.
> 
> > 
> >>
> >>> Anyway, this is speculation. I'd love to have the docs. I haven't tried
> >>> to get them. Is it likely/unlikely that I would get them?
> >>>
> >>>   
> >> You can sign an open-source NDA and get the datasheets.
> >> It lets me write drivers like the current ca0106 and E-Mu drivers.
> >> If you are interested in a NDA, priv-email me.
> > 
> > I have applied to Creative's 'Partnership' program and faxed off the
> > forms last week. I've written user-space drivers for custom wire-wrapped
> > logic + PAL glued hardware before, but not for modern chips, or coded
> > for kernel space. Anyway, there's a first time for everything :-)
> 
> Good luck. Who are you talking to?
> 
> 
> James
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-X5cctbPCO4CF/e2eZDND
Content-Disposition: attachment; filename=ca0106_main.c
Content-Type: text/x-csrc; name=ca0106_main.c; charset=utf-8
Content-Transfer-Encoding: 7bit

/*
 *  Copyright (c) 2004 James Courtier-Dutton <James@superbug.demon.co.uk>
 *  Driver CA0106 chips. e.g. Sound Blaster Audigy LS and Live 24bit
 *  Version: 0.0.23
 *
 *  FEATURES currently supported:
 *    Front, Rear and Center/LFE.
 *    Surround40 and Surround51.
 *    Capture from MIC an LINE IN input.
 *    SPDIF digital playback of PCM stereo and AC3/DTS works.
 *    (One can use a standard mono mini-jack to one RCA plugs cable.
 *     or one can use a standard stereo mini-jack to two RCA plugs cable.
 *     Plug one of the RCA plugs into the Coax input of the external decoder/receiver.)
 *    ( In theory one could output 3 different AC3 streams at once, to 3 different SPDIF outputs. )
 *    Notes on how to capture sound:
 *      The AC97 is used in the PLAYBACK direction.
 *      The output from the AC97 chip, instead of reaching the speakers, is fed into the Philips 1361T ADC.
 *      So, to record from the MIC, set the MIC Playback volume to max,
 *      unmute the MIC and turn up the MASTER Playback volume.
 *      So, to prevent feedback when capturing, minimise the "Capture feedback into Playback" volume.
 *   
 *    The only playback controls that currently do anything are: -
 *    Analog Front
 *    Analog Rear
 *    Analog Center/LFE
 *    SPDIF Front
 *    SPDIF Rear
 *    SPDIF Center/LFE
 *   
 *    For capture from Mic in or Line in.
 *    Digital/Analog ( switch must be in Analog mode for CAPTURE. )
 * 
 *    CAPTURE feedback into PLAYBACK
 * 
 *  Changelog:
 *    Support interrupts per period.
 *    Removed noise from Center/LFE channel when in Analog mode.
 *    Rename and remove mixer controls.
 *  0.0.6
 *    Use separate card based DMA buffer for periods table list.
 *  0.0.7
 *    Change remove and rename ctrls into lists.
 *  0.0.8
 *    Try to fix capture sources.
 *  0.0.9
 *    Fix AC3 output.
 *    Enable S32_LE format support.
 *  0.0.10
 *    Enable playback 48000 and 96000 rates. (Rates other that these do not work, even with "plug:front".)
 *  0.0.11
 *    Add Model name recognition.
 *  0.0.12
 *    Correct interrupt timing. interrupt at end of period, instead of in the middle of a playback period.
 *    Remove redundent "voice" handling.
 *  0.0.13
 *    Single trigger call for multi channels.
 *  0.0.14
 *    Set limits based on what the sound card hardware can do.
 *    playback periods_min=2, periods_max=8
 *    capture hw constraints require period_size = n * 64 bytes.
 *    playback hw constraints require period_size = n * 64 bytes.
 *  0.0.15
 *    Minor updates.
 *  0.0.16
 *    Implement 192000 sample rate.
 *  0.0.17
 *    Add support for SB0410 and SB0413.
 *  0.0.18
 *    Modified Copyright message.
 *  0.0.19
 *    Finally fix support for SB Live 24 bit. SB0410 and SB0413.
 *    The output codec needs resetting, otherwise all output is muted.
 *  0.0.20
 *    Merge "pci_disable_device(pci);" fixes.
 *  0.0.21
 *    Add 4 capture channels. (SPDIF only comes in on channel 0. )
 *    Add SPDIF capture using optional digital I/O module for SB Live 24bit. (Analog capture does not yet work.)
 *  0.0.22
 *    Add support for MSI K8N Diamond Motherboard with onboard SB Live 24bit without AC97. From kiksen, bug #901
 *  0.0.23
 *    Implement support for Line-in capture on SB Live 24bit.
 *
 *  BUGS:
 *    Some stability problems when unloading the snd-ca0106 kernel module.
 *    --
 *
 *  TODO:
 *    4 Capture channels, only one implemented so far.
 *    Other capture rates apart from 48khz not implemented.
 *    MIDI
 *    --
 *  GENERAL INFO:
 *    Model: SB0310
 *    P17 Chip: CA0106-DAT
 *    AC97 Codec: STAC 9721
 *    ADC: Philips 1361T (Stereo 24bit)
 *    DAC: WM8746EDS (6-channel, 24bit, 192Khz)
 *
 *  GENERAL INFO:
 *    Model: SB0410
 *    P17 Chip: CA0106-DAT
 *    AC97 Codec: None
 *    ADC: WM8775EDS (4 Channel)
 *    DAC: CS4382 (114 dB, 24-Bit, 192 kHz, 8-Channel D/A Converter with DSD Support)
 *    SPDIF Out control switches between Mic in and SPDIF out.
 *    No sound out or mic input working yet.
 * 
 *  GENERAL INFO:
 *    Model: SB0413
 *    P17 Chip: CA0106-DAT
 *    AC97 Codec: None.
 *    ADC: Unknown
 *    DAC: Unknown
 *    Trying to handle it like the SB0410.
 *
 *  This code was initally based on code from ALSA's emu10k1x.c which is:
 *  Copyright (c) by Francisco Moraes <fmoraes@nc.rr.com>
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
#include <linux/delay.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/pci.h>
#include <linux/slab.h>
#include <linux/moduleparam.h>
#include <linux/dma-mapping.h>
#include <sound/core.h>
#include <sound/initval.h>
#include <sound/pcm.h>
#include <sound/ac97_codec.h>
#include <sound/info.h>

MODULE_AUTHOR("James Courtier-Dutton <James@superbug.demon.co.uk>");
MODULE_DESCRIPTION("CA0106");
MODULE_LICENSE("GPL");
MODULE_SUPPORTED_DEVICE("{{Creative,SB CA0106 chip}}");

// module parameters (see "Module Parameters")
static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
static uint subsystem[SNDRV_CARDS]; /* Force card subsystem model */

module_param_array(index, int, NULL, 0444);
MODULE_PARM_DESC(index, "Index value for the CA0106 soundcard.");
module_param_array(id, charp, NULL, 0444);
MODULE_PARM_DESC(id, "ID string for the CA0106 soundcard.");
module_param_array(enable, bool, NULL, 0444);
MODULE_PARM_DESC(enable, "Enable the CA0106 soundcard.");
module_param_array(subsystem, uint, NULL, 0444);
MODULE_PARM_DESC(subsystem, "Force card subsystem model.");

#define MODULE_NAME  "snd-ca0106"

#include "ca0106.h"

static struct snd_ca0106_details ca0106_chip_details[] = {
	 /* AudigyLS[SB0310] */
	 { .serial = 0x10021102,
	   .name   = "AudigyLS [SB0310]",
	   .ac97   = 1 } , 
	 /* Unknown AudigyLS that also says SB0310 on it */
	 { .serial = 0x10051102,
	   .name   = "AudigyLS [SB0310b]",
	   .ac97   = 1 } ,
	 /* New Sound Blaster Live! 7.1 24bit. This does not have an AC97. 53SB041000001 */
	 { .serial = 0x10061102,
	   .name   = "Live! 7.1 24bit [SB0410]",
	   .gpio_type = 1,
	   .i2c_adc = 1 } ,
	 /* New Dell Sound Blaster Live! 7.1 24bit. This does not have an AC97.  */
	 { .serial = 0x10071102,
	   .name   = "Live! 7.1 24bit [SB0413]",
	   .gpio_type = 1,
	   .i2c_adc = 1 } ,
	 /* New Audigy SE. Has a different DAC. */
	 /* SB0570:
	  * CTRL:CA0106-DAT
	  * ADC: WM8775EDS
	  * DAC: WM8768GEDS
	  */
	 { .serial = 0x100a1102,
	   .name   = "Audigy SE [SB0570]",
	   .gpio_type = 1,
	   .i2c_adc = 1,
	   .spi_dac = 1 } ,
	 /* New Audigy LS. Has a different DAC. */
	 /* SB0570:
	  * CTRL:CA0106-DAT
	  * ADC: WM8775EDS
	  * DAC: WM8768GEDS
	  */
	 { .serial = 0x10111102,
	   .name   = "Audigy SE OEM [SB0570a]",
	   .gpio_type = 1,
	   .i2c_adc = 1,
	   .spi_dac = 1 } ,
	 /* MSI K8N Diamond Motherboard with onboard SB Live 24bit without AC97 */
	 /* SB0438
	  * CTRL:CA0106-DAT
	  * ADC: WM8775SEDS
	  * DAC: CS4382-KQZ
	  */
	 { .serial = 0x10091462,
	   .name   = "MSI K8N Diamond MB [SB0438]",
	   .gpio_type = 2,
	   .i2c_adc = 1 } ,
	 /* Shuttle XPC SD31P which has an onboard Creative Labs
	  * Sound Blaster Live! 24-bit EAX
	  * high-definition 7.1 audio processor".
	  * Added using info from andrewvegan in alsa bug #1298
	  */
	 { .serial = 0x30381297,
	   .name   = "Shuttle XPC SD31P [SD31P]",
	   .gpio_type = 1,
	   .i2c_adc = 1 } ,
	/* Shuttle XPC SD11G5 which has an onboard Creative Labs
	 * Sound Blaster Live! 24-bit EAX
	 * high-definition 7.1 audio processor".
	 * Fixes ALSA bug#1600
         */
	{ .serial = 0x30411297,
	  .name = "Shuttle XPC SD11G5 [SD11G5]",
	  .gpio_type = 1,
	  .i2c_adc = 1 } ,
	 { .serial = 0,
	   .name   = "AudigyLS [Unknown]" }
};

/* hardware definition */
static struct snd_pcm_hardware snd_ca0106_playback_hw = {
	.info =			(SNDRV_PCM_INFO_MMAP | 
				 SNDRV_PCM_INFO_INTERLEAVED |
				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
				 SNDRV_PCM_INFO_MMAP_VALID),
	.formats =		SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
	.rates =		(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
				 SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000),
	.rate_min =		44100,
	.rate_max =		192000,
	.channels_min =		2,  //1,
	.channels_max =		2,  //6,
	.buffer_bytes_max =	((65536 - 64) * 8),
	.period_bytes_min =	64,
	.period_bytes_max =	(65536 - 64),
	.periods_min =		2,
	.periods_max =		8,
	.fifo_size =		0,
};

static struct snd_pcm_hardware snd_ca0106_capture_hw = {
	.info =			(SNDRV_PCM_INFO_MMAP | 
				 SNDRV_PCM_INFO_INTERLEAVED |
				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
				 SNDRV_PCM_INFO_MMAP_VALID),
	.formats =		SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
	.rates =		(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
				 SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000),
	.rate_min =		44100,
	.rate_max =		192000,
	.channels_min =		2,
	.channels_max =		2,
	.buffer_bytes_max =	((65536 - 64) * 8),
	.period_bytes_min =	64,
	.period_bytes_max =	(65536 - 64),
	.periods_min =		2,
	.periods_max =		2,
	.fifo_size =		0,
};

static unsigned int all_spdif_playback_rates[] =
	{44100, 48000, 96000, 192000};

static int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
                                 struct snd_pcm_hw_rule *rule)
{
	struct snd_ca0106 *chip = rule->private;
	int chi, any_44100 = 0, any_non_44100 = 0, mask = 0;
	struct snd_ca0106_channel *chp = 0;
	struct snd_pcm_runtime *runtime;
	snd_assert(chip != NULL, return -EINVAL);
	
	if (chip->spdif_enable) {
		for (chi = 0; chi < 4; ++chi ) {
			chp = &(chip->playback_channels[chi]);
			if (!chp->use) continue;
			snd_assert(chp->epcm != NULL, return -EINVAL);
			if (!chp->epcm->running) continue;
			snd_assert(chp->epcm->substream != NULL, return -EINVAL);
			snd_assert(chp->epcm->substream->runtime != NULL, return -EINVAL);
			runtime = chp->epcm->substream->runtime;
			snd_printd("snd_hw_rule_playback_rate: ch=%d, rate=%d.\n",chi,runtime->rate);
			any_44100 += runtime->rate == 44100;
			any_non_44100 += runtime->rate != 44100;
		}
		if (any_44100 && any_non_44100)
			printk(KERN_ERR MODULE_NAME ": Detected 44100Hz and other rates in use simultaneously.\n");
		if (any_44100)
			mask = 0x1;
		else if (any_non_44100)
			mask = 0xE;
		else
			mask = 0xF;
	} else {
		// 44100Hz is not supported for DAC (FIXME Why?)
		mask = 0xE;
	}
	snd_printd("snd_hw_rule_playback_rate: any_44100=%d, any_non_44100=%d, mask=0x%X, spdif=%d\n",any_44100,any_non_44100,mask,chip->spdif_enable);
	return snd_interval_list(hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE),
		ARRAY_SIZE(all_spdif_playback_rates), all_spdif_playback_rates, mask);
}

unsigned int snd_ca0106_ptr_read(struct snd_ca0106 * emu, 
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

void snd_ca0106_ptr_write(struct snd_ca0106 *emu, 
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

int snd_ca0106_spi_write(struct snd_ca0106 * emu,
				   unsigned int data)
{
	unsigned int reset, set;
	unsigned int reg, tmp;
	int n, result;
	reg = SPI;
	if (data > 0xffff) /* Only 16bit values allowed */
		return 1;
	tmp = snd_ca0106_ptr_read(emu, reg, 0);
	reset = (tmp & ~0x3ffff) | 0x20000; /* Set xxx20000 */
	set = reset | 0x10000; /* Set xxx1xxxx */
	snd_ca0106_ptr_write(emu, reg, 0, reset | data);
	tmp = snd_ca0106_ptr_read(emu, reg, 0); /* write post */
	snd_ca0106_ptr_write(emu, reg, 0, set | data);
	result = 1;
	/* Wait for status bit to return to 0 */
	for (n = 0; n < 100; n++) {
		udelay(10);
		tmp = snd_ca0106_ptr_read(emu, reg, 0);
		if (!(tmp & 0x10000)) {
			result = 0;
			break;
		}
	}
	if (result) /* Timed out */
		return 1;
	snd_ca0106_ptr_write(emu, reg, 0, reset | data);
	tmp = snd_ca0106_ptr_read(emu, reg, 0); /* Write post */
	return 0;
}

/* The ADC does not support i2c read, so only write is implemented */
int snd_ca0106_i2c_write(struct snd_ca0106 *emu,
				u32 reg,
				u32 value)
{
	u32 tmp;
	int timeout = 0;
	int status;
	int retry;
	if ((reg > 0x7f) || (value > 0x1ff)) {
		snd_printk(KERN_ERR "i2c_write: invalid values.\n");
		return -EINVAL;
	}

	tmp = reg << 25 | value << 16;
	// snd_printk("I2C-write:reg=0x%x, value=0x%x\n", reg, value);
	/* Not sure what this I2C channel controls. */
	/* snd_ca0106_ptr_write(emu, I2C_D0, 0, tmp); */

	/* This controls the I2C connected to the WM8775 ADC Codec */
	snd_ca0106_ptr_write(emu, I2C_D1, 0, tmp);

	for (retry = 0; retry < 10; retry++) {
		/* Send the data to i2c */
		//tmp = snd_ca0106_ptr_read(emu, I2C_A, 0);
		//tmp = tmp & ~(I2C_A_ADC_READ|I2C_A_ADC_LAST|I2C_A_ADC_START|I2C_A_ADC_ADD_MASK);
		tmp = 0;
		tmp = tmp | (I2C_A_ADC_LAST|I2C_A_ADC_START|I2C_A_ADC_ADD);
		snd_ca0106_ptr_write(emu, I2C_A, 0, tmp);

		/* Wait till the transaction ends */
		while (1) {
			status = snd_ca0106_ptr_read(emu, I2C_A, 0);
                	//snd_printk("I2C:status=0x%x\n", status);
			timeout++;
			if ((status & I2C_A_ADC_START) == 0)
				break;

			if (timeout > 1000)
				break;
		}
		//Read back and see if the transaction is successful
		if ((status & I2C_A_ADC_ABORT) == 0)
			break;
	}

	if (retry == 10) {
		snd_printk(KERN_ERR "Writing to ADC failed!\n");
		return -EINVAL;
	}
    
    	return 0;
}


static void snd_ca0106_intr_enable(struct snd_ca0106 *emu, unsigned int intrenb)
{
	unsigned long flags;
	unsigned int enable;
  
	spin_lock_irqsave(&emu->emu_lock, flags);
	enable = inl(emu->port + INTE) | intrenb;
	outl(enable, emu->port + INTE);
	spin_unlock_irqrestore(&emu->emu_lock, flags);
}

static void snd_ca0106_intr_disable(struct snd_ca0106 *emu, unsigned int intrenb)
{
	unsigned long flags;
	unsigned int enable;
  
	spin_lock_irqsave(&emu->emu_lock, flags);
	enable = inl(emu->port + INTE) & ~intrenb;
	outl(enable, emu->port + INTE);
	spin_unlock_irqrestore(&emu->emu_lock, flags);
}


static void snd_ca0106_pcm_free_substream(struct snd_pcm_runtime *runtime)
{
	kfree(runtime->private_data);
}

/* open_playback callback */
static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substream,
						int channel_id)
{
	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
        struct snd_ca0106_channel *channel = &(chip->playback_channels[channel_id]);
	struct snd_ca0106_pcm *epcm;
	struct snd_pcm_runtime *runtime = substream->runtime;
	int err;

	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);

	if (epcm == NULL)
		return -ENOMEM;
	epcm->emu = chip;
	epcm->substream = substream;
        epcm->channel_id=channel_id;
  
	runtime->private_data = epcm;
	runtime->private_free = snd_ca0106_pcm_free_substream;
  
	runtime->hw = snd_ca0106_playback_hw;

        channel->emu = chip;
        channel->number = channel_id;

	channel->use = 1;

        snd_printd("open_playback: channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
        //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
	channel->epcm = epcm;
	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
                return err;
	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
                return err;
 	if ((err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
                       hw_rule_playback_rate, (void*)chip, SNDRV_PCM_HW_PARAM_RATE,
                       -1)) < 0)
                 return err;
#if 0
 	// FIXME Add constraints to deal with the format.
 	if (chip->output_frequency_reservation_count == 0) {
 		chip->output_frequency_is_44100 = runtime->rate == 44100;
 	} else if (chip->output_frequency_is_44100 && runtime->rate != 44100)
 		return -EINVAL;
 	if (chip->playback_channels_open_count && chip->output_format != runtime->format)
 		return -EINVAL;
#endif
 	
	return 0;
}

/* close callback */
static int snd_ca0106_pcm_close_playback(struct snd_pcm_substream *substream)
{
	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
	struct snd_pcm_runtime *runtime = substream->runtime;
        struct snd_ca0106_pcm *epcm = runtime->private_data;
	chip->playback_channels[epcm->channel_id].use = 0;

 	snd_printd("close_playback.\n");
 
	/* FIXME: maybe zero others */
	return 0;
}

static int snd_ca0106_pcm_open_playback_front(struct snd_pcm_substream *substream)
{
	return snd_ca0106_pcm_open_playback_channel(substream, PCM_FRONT_CHANNEL);
}

static int snd_ca0106_pcm_open_playback_center_lfe(struct snd_pcm_substream *substream)
{
	return snd_ca0106_pcm_open_playback_channel(substream, PCM_CENTER_LFE_CHANNEL);
}

static int snd_ca0106_pcm_open_playback_unknown(struct snd_pcm_substream *substream)
{
	return snd_ca0106_pcm_open_playback_channel(substream, PCM_UNKNOWN_CHANNEL);
}

static int snd_ca0106_pcm_open_playback_rear(struct snd_pcm_substream *substream)
{
	return snd_ca0106_pcm_open_playback_channel(substream, PCM_REAR_CHANNEL);
}

/* open_capture callback */
static int snd_ca0106_pcm_open_capture_channel(struct snd_pcm_substream *substream,
					       int channel_id)
{
	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
        struct snd_ca0106_channel *channel = &(chip->capture_channels[channel_id]);
	struct snd_ca0106_pcm *epcm;
	struct snd_pcm_runtime *runtime = substream->runtime;
	int err;

	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
	if (epcm == NULL) {
		snd_printk(KERN_ERR "open_capture_channel: failed epcm alloc\n");
		return -ENOMEM;
        }
	epcm->emu = chip;
	epcm->substream = substream;
        epcm->channel_id=channel_id;
  
	runtime->private_data = epcm;
	runtime->private_free = snd_ca0106_pcm_free_substream;
  
	runtime->hw = snd_ca0106_capture_hw;

        channel->emu = chip;
        channel->number = channel_id;

	channel->use = 1;
        //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
        //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
        channel->epcm = epcm;
	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
                return err;
	//snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
                return err;
	return 0;
}

/* close callback */
static int snd_ca0106_pcm_close_capture(struct snd_pcm_substream *substream)
{
	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
	struct snd_pcm_runtime *runtime = substream->runtime;
        struct snd_ca0106_pcm *epcm = runtime->private_data;
	chip->capture_channels[epcm->channel_id].use = 0;
	/* FIXME: maybe zero others */
	return 0;
}

static int snd_ca0106_pcm_open_0_capture(struct snd_pcm_substream *substream)
{
	return snd_ca0106_pcm_open_capture_channel(substream, 0);
}

static int snd_ca0106_pcm_open_1_capture(struct snd_pcm_substream *substream)
{
	return snd_ca0106_pcm_open_capture_channel(substream, 1);
}

static int snd_ca0106_pcm_open_2_capture(struct snd_pcm_substream *substream)
{
	return snd_ca0106_pcm_open_capture_channel(substream, 2);
}

static int snd_ca0106_pcm_open_3_capture(struct snd_pcm_substream *substream)
{
	return snd_ca0106_pcm_open_capture_channel(substream, 3);
}

/* hw_params callback */
static int snd_ca0106_pcm_hw_params_playback(struct snd_pcm_substream *substream,
				      struct snd_pcm_hw_params *hw_params)
{
	return snd_pcm_lib_malloc_pages(substream,
					params_buffer_bytes(hw_params));
}

/* hw_free callback */
static int snd_ca0106_pcm_hw_free_playback(struct snd_pcm_substream *substream)
{
	return snd_pcm_lib_free_pages(substream);
}

/* hw_params callback */
static int snd_ca0106_pcm_hw_params_capture(struct snd_pcm_substream *substream,
				      struct snd_pcm_hw_params *hw_params)
{
	return snd_pcm_lib_malloc_pages(substream,
					params_buffer_bytes(hw_params));
}

/* hw_free callback */
static int snd_ca0106_pcm_hw_free_capture(struct snd_pcm_substream *substream)
{
	return snd_pcm_lib_free_pages(substream);
}

/* prepare playback callback */
static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
{
	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
	struct snd_pcm_runtime *runtime = substream->runtime, *runtimei = 0;
	struct snd_ca0106_pcm *epcm = runtime->private_data;
	struct snd_ca0106_channel *chp = 0;
	int channel = epcm->channel_id, chi, any_44100 = 0, any_non_44100 = 0;
	u32 *table_base = (u32 *)(emu->buffer.area+(8*16*channel));
	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
	u32 hcfg_mask = HCFG_PLAYBACK_S32_LE;
	u32 hcfg_set = 0x00000000;
	u32 hcfg;
	//u32 reg40_mask = 0x30000 << (channel<<1);
	u32 reg40_mask = 0xFF0000;
	u32 reg40_set = 0;
	u32 reg40;
	/* FIXME: Depending on mixer selection of SPDIF out or not, select the spdif rate or the DAC rate. */
//	u32 reg71_mask = 0x03030000 ; /* Global. Set SPDIF rate. We only support 44100 to spdif, not to DAC. */
	u32 reg71_mask;
	u32 reg71_shift;
	u32 reg71_set = 0;
	u32 reg71;
	int i;
	if (emu->spdif_enable) {
		reg71_shift = 24; /* SPDIF Output Rate */
	} else {
		reg71_shift = 16; /* I2S Output Rate */
	}
	reg71_mask = 0x3 << reg71_shift;
	
        snd_printd("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
        //snd_printd("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
	//snd_printd("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
 	// We are forced to build the settings for all the channels
 	for (chi = 0; chi < 4; ++chi ) {
 		chp = &(emu->playback_channels[chi]);
 		if (!chp->use) continue;
 		snd_assert(chp->epcm != NULL, return -EINVAL);
		if (chi != channel && !chp->epcm->running) continue;
 		snd_assert(chp->epcm->substream != NULL, return -EINVAL);
 		snd_assert(chp->epcm->substream->runtime != NULL, return -EINVAL);
 		runtimei = chp->epcm->substream->runtime;
 		any_44100 += runtimei->rate == 44100;
 		any_non_44100 += runtimei->rate != 44100;
 		/* Rate can be set per channel. */
 		/* reg40 control host to fifo */
 		/* reg71 controls DAC rate. */
 		switch (runtimei->rate) {
 		case 44100:
 			/* We only support 44100 to spdif, not to DAC. (FIXME WHY?)*/
 			if (emu->spdif_enable) {
 				reg40_set |= 0x550000; /* When using 44100, all channels must be set to that speed. */
 				reg71_set |= 0x1 << reg71_shift;
 				break;
 			} else {
 				printk(KERN_ERR MODULE_NAME "prepare_playback: 44100Hz is invalid for DAC.\n");
 			}
 	        case 48000:
 			//reg40_set = 0;
 			//reg71_set = 0; 
 			break;
 		case 96000:
 			reg40_set |= 0x20000 << (chi<<1);
 			reg71_set |= 0x2 << reg71_shift;
 			break;
 		case 192000:
 			reg40_set |= 0x30000 << (chi<<1);
 			reg71_set |= 0x3 << reg71_shift;
 			break;
 		default:
			printk(KERN_ERR MODULE_NAME "prepare_playback: Bad sampling frequency %d.\n",runtimei->rate);
 		}
  	}
	snd_printd("prepare_playback: any_44100=%d, any_non_44100=%d, spdif=%d.\n",any_44100,any_non_44100,emu->spdif_enable);
	/* Format is a global setting */
	/* FIXME: Only let the first channel accessed set this. */
	switch (runtime->format) {
	case SNDRV_PCM_FORMAT_S16_LE:
		hcfg_set = 0;
		break;
	case SNDRV_PCM_FORMAT_S32_LE:
		hcfg_set = HCFG_PLAYBACK_S32_LE;
		break;
	default:
		hcfg_set = 0;
		break;
	}
	hcfg = inl(emu->port + HCFG) ;
	hcfg = (hcfg & ~hcfg_mask) | hcfg_set;
	outl(hcfg, emu->port + HCFG);
	reg40 = snd_ca0106_ptr_read(emu, 0x40, 0);
        snd_printd("ca0106: old reg40=%x\n", reg40);
	reg40 = (reg40 & ~reg40_mask) | reg40_set;
	snd_ca0106_ptr_write(emu, 0x40, 0, reg40);
        snd_printd("ca0106: new reg40=%x\n", reg40);
	reg71 = snd_ca0106_ptr_read(emu, 0x71, 0);
        snd_printd("ca0106: old reg71=%x\n", reg71);
	reg71 = (reg71 & ~reg71_mask) | reg71_set;
	snd_ca0106_ptr_write(emu, 0x71, 0, reg71);
        snd_printd("ca0106: new reg71=%x\n", reg71);

	/* FIXME: Check emu->buffer.size before actually writing to it. */
        for(i=0; i < runtime->periods; i++) {
		table_base[i*2] = runtime->dma_addr + (i * period_size_bytes);
		table_base[i*2+1] = period_size_bytes << 16;
	}
 
	snd_ca0106_ptr_write(emu, PLAYBACK_LIST_ADDR, channel, emu->buffer.addr+(8*16*channel));
	snd_ca0106_ptr_write(emu, PLAYBACK_LIST_SIZE, channel, (runtime->periods - 1) << 19);
	snd_ca0106_ptr_write(emu, PLAYBACK_LIST_PTR, channel, 0);
	snd_ca0106_ptr_write(emu, PLAYBACK_DMA_ADDR, channel, runtime->dma_addr);
	snd_ca0106_ptr_write(emu, PLAYBACK_PERIOD_SIZE, channel, frames_to_bytes(runtime, runtime->period_size)<<16); // buffer size in bytes
	/* FIXME  test what 0 bytes does. */
	snd_ca0106_ptr_write(emu, PLAYBACK_PERIOD_SIZE, channel, 0); // buffer size in bytes
	snd_ca0106_ptr_write(emu, PLAYBACK_POINTER, channel, 0);
	snd_ca0106_ptr_write(emu, 0x07, channel, 0x0);
	snd_ca0106_ptr_write(emu, 0x08, channel, 0);
        snd_ca0106_ptr_write(emu, PLAYBACK_MUTE, 0x0, 0x0); /* Unmute output */
#if 0
	snd_ca0106_ptr_write(emu, SPCS0, 0,
			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
			       SPCS_GENERATIONSTATUS | 0x00001200 |
			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT );
	}
#endif

	return 0;
}

/* prepare capture callback */
static int snd_ca0106_pcm_prepare_capture(struct snd_pcm_substream *substream)
{
	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_ca0106_pcm *epcm = runtime->private_data;
	int channel = epcm->channel_id;
	u32 hcfg_mask = HCFG_CAPTURE_S32_LE;
	u32 hcfg_set = 0x00000000;
	u32 hcfg;
	u32 over_sampling=0x2;
	u32 reg71_mask = 0x0000c000 ; /* Global. Set ADC rate. */
	u32 reg71_set = 0;
	u32 reg71;
	
        snd_printd("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
        //snd_printd("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
	//snd_printd("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
	/* reg71 controls ADC rate. */
	switch (runtime->rate) {
	case 44100:
		reg71_set = 0x00004000;
		break;
        case 48000:
		reg71_set = 0; 
		break;
	case 96000:
		reg71_set = 0x00008000;
		over_sampling=0xa;
		break;
	case 192000:
		reg71_set = 0x0000c000; 
		over_sampling=0xa;
		break;
	default:
		reg71_set = 0; 
		break;
	}
	/* Format is a global setting */
	/* FIXME: Only let the first channel accessed set this. */
	switch (runtime->format) {
	case SNDRV_PCM_FORMAT_S16_LE:
		hcfg_set = 0;
		break;
	case SNDRV_PCM_FORMAT_S32_LE:
		hcfg_set = HCFG_CAPTURE_S32_LE;
		break;
	default:
		hcfg_set = 0;
		break;
	}
	hcfg = inl(emu->port + HCFG) ;
	hcfg = (hcfg & ~hcfg_mask) | hcfg_set;
	outl(hcfg, emu->port + HCFG);
	reg71 = snd_ca0106_ptr_read(emu, 0x71, 0);
	reg71 = (reg71 & ~reg71_mask) | reg71_set;
	snd_ca0106_ptr_write(emu, 0x71, 0, reg71);
        if (emu->details->i2c_adc == 1) { /* The SB0410 and SB0413 use I2C to control ADC. */
	        snd_ca0106_i2c_write(emu, ADC_MASTER, over_sampling); /* Adjust the over sampler to better suit the capture rate. */
	}


        snd_printd("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
	snd_ca0106_ptr_write(emu, 0x13, channel, 0);
	snd_ca0106_ptr_write(emu, CAPTURE_DMA_ADDR, channel, runtime->dma_addr);
	snd_ca0106_ptr_write(emu, CAPTURE_BUFFER_SIZE, channel, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
	snd_ca0106_ptr_write(emu, CAPTURE_POINTER, channel, 0);

	return 0;
}

/* trigger_playback callback */
static int snd_ca0106_pcm_trigger_playback(struct snd_pcm_substream *substream,
				    int cmd)
{
	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
	struct snd_pcm_runtime *runtime;
	struct snd_ca0106_pcm *epcm;
	int channel;
	int result = 0;
        struct snd_pcm_substream *s;
	u32 basic = 0;
	u32 extended = 0;
	int running=0;

	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
		running=1;
		break;
	case SNDRV_PCM_TRIGGER_STOP:
	default:
		running=0;
		break;
	}
        snd_pcm_group_for_each_entry(s, substream) {
		runtime = s->runtime;
		epcm = runtime->private_data;
		channel = epcm->channel_id;
		//snd_printk("channel=%d\n",channel);
		epcm->running = running;
		basic |= (0x1<<channel);
		extended |= (0x10<<channel);
                snd_pcm_trigger_done(s, substream);
        }
	//snd_printk("basic=0x%x, extended=0x%x\n",basic, extended);

	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
		snd_ca0106_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_ca0106_ptr_read(emu, EXTENDED_INT_MASK, 0) | (extended));
		snd_ca0106_ptr_write(emu, BASIC_INTERRUPT, 0, snd_ca0106_ptr_read(emu, BASIC_INTERRUPT, 0)|(basic));
		break;
	case SNDRV_PCM_TRIGGER_STOP:
		snd_ca0106_ptr_write(emu, BASIC_INTERRUPT, 0, snd_ca0106_ptr_read(emu, BASIC_INTERRUPT, 0) & ~(basic));
		snd_ca0106_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_ca0106_ptr_read(emu, EXTENDED_INT_MASK, 0) & ~(extended));
		break;
	default:
		result = -EINVAL;
		break;
	}
	return result;
}

/* trigger_capture callback */
static int snd_ca0106_pcm_trigger_capture(struct snd_pcm_substream *substream,
				    int cmd)
{
	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_ca0106_pcm *epcm = runtime->private_data;
	int channel = epcm->channel_id;
	int result = 0;

	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
		snd_ca0106_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_ca0106_ptr_read(emu, EXTENDED_INT_MASK, 0) | (0x110000<<channel));
		snd_ca0106_ptr_write(emu, BASIC_INTERRUPT, 0, snd_ca0106_ptr_read(emu, BASIC_INTERRUPT, 0)|(0x100<<channel));
		epcm->running = 1;
		break;
	case SNDRV_PCM_TRIGGER_STOP:
		snd_ca0106_ptr_write(emu, BASIC_INTERRUPT, 0, snd_ca0106_ptr_read(emu, BASIC_INTERRUPT, 0) & ~(0x100<<channel));
		snd_ca0106_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_ca0106_ptr_read(emu, EXTENDED_INT_MASK, 0) & ~(0x110000<<channel));
		epcm->running = 0;
		break;
	default:
		result = -EINVAL;
		break;
	}
	return result;
}

/* pointer_playback callback */
static snd_pcm_uframes_t
snd_ca0106_pcm_pointer_playback(struct snd_pcm_substream *substream)
{
	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_ca0106_pcm *epcm = runtime->private_data;
	snd_pcm_uframes_t ptr, ptr1, ptr2,ptr3,ptr4 = 0;
	int channel = epcm->channel_id;

	if (!epcm->running)
		return 0;

	ptr3 = snd_ca0106_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
	ptr1 = snd_ca0106_ptr_read(emu, PLAYBACK_POINTER, channel);
	ptr4 = snd_ca0106_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
	if (ptr3 != ptr4) ptr1 = snd_ca0106_ptr_read(emu, PLAYBACK_POINTER, channel);
	ptr2 = bytes_to_frames(runtime, ptr1);
	ptr2+= (ptr4 >> 3) * runtime->period_size;
	ptr=ptr2;
        if (ptr >= runtime->buffer_size)
		ptr -= runtime->buffer_size;
	//printk("ptr1 = 0x%lx, ptr2=0x%lx, ptr=0x%lx, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr1, ptr2, ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate);

	return ptr;
}

/* pointer_capture callback */
static snd_pcm_uframes_t
snd_ca0106_pcm_pointer_capture(struct snd_pcm_substream *substream)
{
	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_ca0106_pcm *epcm = runtime->private_data;
	snd_pcm_uframes_t ptr, ptr1, ptr2 = 0;
	int channel = channel=epcm->channel_id;

	if (!epcm->running)
		return 0;

	ptr1 = snd_ca0106_ptr_read(emu, CAPTURE_POINTER, channel);
	ptr2 = bytes_to_frames(runtime, ptr1);
	ptr=ptr2;
        if (ptr >= runtime->buffer_size)
		ptr -= runtime->buffer_size;
	//printk("ptr1 = 0x%lx, ptr2=0x%lx, ptr=0x%lx, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr1, ptr2, ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate);

	return ptr;
}

/* operators */
static struct snd_pcm_ops snd_ca0106_playback_front_ops = {
	.open =        snd_ca0106_pcm_open_playback_front,
	.close =       snd_ca0106_pcm_close_playback,
	.ioctl =       snd_pcm_lib_ioctl,
	.hw_params =   snd_ca0106_pcm_hw_params_playback,
	.hw_free =     snd_ca0106_pcm_hw_free_playback,
	.prepare =     snd_ca0106_pcm_prepare_playback,
	.trigger =     snd_ca0106_pcm_trigger_playback,
	.pointer =     snd_ca0106_pcm_pointer_playback,
};

static struct snd_pcm_ops snd_ca0106_capture_0_ops = {
	.open =        snd_ca0106_pcm_open_0_capture,
	.close =       snd_ca0106_pcm_close_capture,
	.ioctl =       snd_pcm_lib_ioctl,
	.hw_params =   snd_ca0106_pcm_hw_params_capture,
	.hw_free =     snd_ca0106_pcm_hw_free_capture,
	.prepare =     snd_ca0106_pcm_prepare_capture,
	.trigger =     snd_ca0106_pcm_trigger_capture,
	.pointer =     snd_ca0106_pcm_pointer_capture,
};

static struct snd_pcm_ops snd_ca0106_capture_1_ops = {
	.open =        snd_ca0106_pcm_open_1_capture,
	.close =       snd_ca0106_pcm_close_capture,
	.ioctl =       snd_pcm_lib_ioctl,
	.hw_params =   snd_ca0106_pcm_hw_params_capture,
	.hw_free =     snd_ca0106_pcm_hw_free_capture,
	.prepare =     snd_ca0106_pcm_prepare_capture,
	.trigger =     snd_ca0106_pcm_trigger_capture,
	.pointer =     snd_ca0106_pcm_pointer_capture,
};

static struct snd_pcm_ops snd_ca0106_capture_2_ops = {
	.open =        snd_ca0106_pcm_open_2_capture,
	.close =       snd_ca0106_pcm_close_capture,
	.ioctl =       snd_pcm_lib_ioctl,
	.hw_params =   snd_ca0106_pcm_hw_params_capture,
	.hw_free =     snd_ca0106_pcm_hw_free_capture,
	.prepare =     snd_ca0106_pcm_prepare_capture,
	.trigger =     snd_ca0106_pcm_trigger_capture,
	.pointer =     snd_ca0106_pcm_pointer_capture,
};

static struct snd_pcm_ops snd_ca0106_capture_3_ops = {
	.open =        snd_ca0106_pcm_open_3_capture,
	.close =       snd_ca0106_pcm_close_capture,
	.ioctl =       snd_pcm_lib_ioctl,
	.hw_params =   snd_ca0106_pcm_hw_params_capture,
	.hw_free =     snd_ca0106_pcm_hw_free_capture,
	.prepare =     snd_ca0106_pcm_prepare_capture,
	.trigger =     snd_ca0106_pcm_trigger_capture,
	.pointer =     snd_ca0106_pcm_pointer_capture,
};

static struct snd_pcm_ops snd_ca0106_playback_center_lfe_ops = {
        .open =         snd_ca0106_pcm_open_playback_center_lfe,
        .close =        snd_ca0106_pcm_close_playback,
        .ioctl =        snd_pcm_lib_ioctl,
        .hw_params =    snd_ca0106_pcm_hw_params_playback,
        .hw_free =      snd_ca0106_pcm_hw_free_playback,
        .prepare =      snd_ca0106_pcm_prepare_playback,     
        .trigger =      snd_ca0106_pcm_trigger_playback,  
        .pointer =      snd_ca0106_pcm_pointer_playback, 
};

static struct snd_pcm_ops snd_ca0106_playback_unknown_ops = {
        .open =         snd_ca0106_pcm_open_playback_unknown,
        .close =        snd_ca0106_pcm_close_playback,
        .ioctl =        snd_pcm_lib_ioctl,
        .hw_params =    snd_ca0106_pcm_hw_params_playback,
        .hw_free =      snd_ca0106_pcm_hw_free_playback,
        .prepare =      snd_ca0106_pcm_prepare_playback,     
        .trigger =      snd_ca0106_pcm_trigger_playback,  
        .pointer =      snd_ca0106_pcm_pointer_playback, 
};

static struct snd_pcm_ops snd_ca0106_playback_rear_ops = {
        .open =         snd_ca0106_pcm_open_playback_rear,
        .close =        snd_ca0106_pcm_close_playback,
        .ioctl =        snd_pcm_lib_ioctl,
        .hw_params =    snd_ca0106_pcm_hw_params_playback,
		.hw_free =      snd_ca0106_pcm_hw_free_playback,
        .prepare =      snd_ca0106_pcm_prepare_playback,     
        .trigger =      snd_ca0106_pcm_trigger_playback,  
        .pointer =      snd_ca0106_pcm_pointer_playback, 
};


static unsigned short snd_ca0106_ac97_read(struct snd_ac97 *ac97,
					     unsigned short reg)
{
	struct snd_ca0106 *emu = ac97->private_data;
	unsigned long flags;
	unsigned short val;

	spin_lock_irqsave(&emu->emu_lock, flags);
	outb(reg, emu->port + AC97ADDRESS);
	val = inw(emu->port + AC97DATA);
	spin_unlock_irqrestore(&emu->emu_lock, flags);
	return val;
}

static void snd_ca0106_ac97_write(struct snd_ac97 *ac97,
				    unsigned short reg, unsigned short val)
{
	struct snd_ca0106 *emu = ac97->private_data;
	unsigned long flags;
  
	spin_lock_irqsave(&emu->emu_lock, flags);
	outb(reg, emu->port + AC97ADDRESS);
	outw(val, emu->port + AC97DATA);
	spin_unlock_irqrestore(&emu->emu_lock, flags);
}

static int snd_ca0106_ac97(struct snd_ca0106 *chip)
{
	struct snd_ac97_bus *pbus;
	struct snd_ac97_template ac97;
	int err;
	static struct snd_ac97_bus_ops ops = {
		.write = snd_ca0106_ac97_write,
		.read = snd_ca0106_ac97_read,
	};
  
	if ((err = snd_ac97_bus(chip->card, 0, &ops, NULL, &pbus)) < 0)
		return err;
	pbus->no_vra = 1; /* we don't need VRA */

	memset(&ac97, 0, sizeof(ac97));
	ac97.private_data = chip;
	ac97.scaps = AC97_SCAP_NO_SPDIF;
	return snd_ac97_mixer(pbus, &ac97, &chip->ac97);
}

static int snd_ca0106_free(struct snd_ca0106 *chip)
{
	if (chip->res_port != NULL) {    /* avoid access to already used hardware */
		// disable interrupts
		snd_ca0106_ptr_write(chip, BASIC_INTERRUPT, 0, 0);
		outl(0, chip->port + INTE);
		snd_ca0106_ptr_write(chip, EXTENDED_INT_MASK, 0, 0);
		udelay(1000);
		// disable audio
		//outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG);
		outl(0, chip->port + HCFG);
		/* FIXME: We need to stop and DMA transfers here.
		 *        But as I am not sure how yet, we cannot from the dma pages.
		 * So we can fix: snd-malloc: Memory leak?  pages not freed = 8
		 */
	}
	// release the data
#if 1
	if (chip->buffer.area)
		snd_dma_free_pages(&chip->buffer);
#endif

	// release the i/o port
	release_and_free_resource(chip->res_port);

	// release the irq
	if (chip->irq >= 0)
		free_irq(chip->irq, chip);
	pci_disable_device(chip->pci);
	kfree(chip);
	return 0;
}

static int snd_ca0106_dev_free(struct snd_device *device)
{
	struct snd_ca0106 *chip = device->device_data;
	return snd_ca0106_free(chip);
}

static irqreturn_t snd_ca0106_interrupt(int irq, void *dev_id)
{
	unsigned int status;

	struct snd_ca0106 *chip = dev_id;
	int i;
	int mask;
        unsigned int stat76;
	struct snd_ca0106_channel *pchannel;

	status = inl(chip->port + IPR);
	if (! status)
		return IRQ_NONE;

        stat76 = snd_ca0106_ptr_read(chip, EXTENDED_INT, 0);
	//snd_printk("interrupt status = 0x%08x, stat76=0x%08x\n", status, stat76);
	//snd_printk("ptr=0x%08x\n",snd_ca0106_ptr_read(chip, PLAYBACK_POINTER, 0));
        mask = 0x11; /* 0x1 for one half, 0x10 for the other half period. */
	for(i = 0; i < 4; i++) {
		pchannel = &(chip->playback_channels[i]);
		if (stat76 & mask) {
/* FIXME: Select the correct substream for period elapsed */
			if(pchannel->use) {
				snd_pcm_period_elapsed(pchannel->epcm->substream);
				//printk(KERN_INFO "interrupt [%d] used\n", i);
                        }
		}
	        //printk(KERN_INFO "channel=%p\n",pchannel);
	        //printk(KERN_INFO "interrupt stat76[%d] = %08x, use=%d, channel=%d\n", i, stat76, pchannel->use, pchannel->number);
		mask <<= 1;
	}
        mask = 0x110000; /* 0x1 for one half, 0x10 for the other half period. */
	for(i = 0; i < 4; i++) {
		pchannel = &(chip->capture_channels[i]);
		if (stat76 & mask) {
/* FIXME: Select the correct substream for period elapsed */
			if(pchannel->use) {
				snd_pcm_period_elapsed(pchannel->epcm->substream);
				//printk(KERN_INFO "interrupt [%d] used\n", i);
                        }
		}
	        //printk(KERN_INFO "channel=%p\n",pchannel);
	        //printk(KERN_INFO "interrupt stat76[%d] = %08x, use=%d, channel=%d\n", i, stat76, pchannel->use, pchannel->number);
		mask <<= 1;
	}

        snd_ca0106_ptr_write(chip, EXTENDED_INT, 0, stat76);

	if (chip->midi.dev_id &&
	    (status & (chip->midi.ipr_tx|chip->midi.ipr_rx))) {
		if (chip->midi.interrupt)
			chip->midi.interrupt(&chip->midi, status);
		else
			chip->midi.interrupt_disable(&chip->midi, chip->midi.tx_enable | chip->midi.rx_enable);
	}

	// acknowledge the interrupt if necessary
	outl(status, chip->port+IPR);

	return IRQ_HANDLED;
}

static int __devinit snd_ca0106_pcm(struct snd_ca0106 *emu, int device, struct snd_pcm **rpcm)
{
	struct snd_pcm *pcm;
	struct snd_pcm_substream *substream;
	int err;
  
	if (rpcm)
		*rpcm = NULL;
	if ((err = snd_pcm_new(emu->card, "ca0106", device, 1, 1, &pcm)) < 0)
		return err;
  
	pcm->private_data = emu;

	switch (device) {
	case 0:
	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ca0106_playback_front_ops);
	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ca0106_capture_0_ops);
          break;
	case 1:
	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ca0106_playback_rear_ops);
	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ca0106_capture_1_ops);
          break;
	case 2:
	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ca0106_playback_center_lfe_ops);
	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ca0106_capture_2_ops);
          break;
	case 3:
	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_ca0106_playback_unknown_ops);
	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_ca0106_capture_3_ops);
          break;
        }

	pcm->info_flags = 0;
	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
	strcpy(pcm->name, "CA0106");
	emu->pcm = pcm;

	for(substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; 
	    substream; 
	    substream = substream->next) {
		if ((err = snd_pcm_lib_preallocate_pages(substream, 
							 SNDRV_DMA_TYPE_DEV, 
							 snd_dma_pci_data(emu->pci), 
							 64*1024, 64*1024)) < 0) /* FIXME: 32*1024 for sound buffer, between 32and64 for Periods table. */
			return err;
	}

	for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; 
	      substream; 
	      substream = substream->next) {
 		if ((err = snd_pcm_lib_preallocate_pages(substream, 
	                                           SNDRV_DMA_TYPE_DEV, 
	                                           snd_dma_pci_data(emu->pci), 
	                                           64*1024, 64*1024)) < 0)
			return err;
	}
  
	if (rpcm)
		*rpcm = pcm;
  
	return 0;
}

static unsigned int spi_dac_init[] = {
	0x00ff,
	0x02ff,
	0x0400,
	0x0520,
	0x0620, /* Set 24 bit. Was 0x0600 */
	0x08ff,
	0x0aff,
	0x0cff,
	0x0eff,
	0x10ff,
	0x1200,
	0x1400,
	0x1480,
	0x1800,
	0x1aff,
	0x1cff,
	0x1e00,
	0x0530,
	0x0602,
	0x0622,
	0x1400,
};

static unsigned int i2c_adc_init[][2] = {
	{ 0x17, 0x00 }, /* Reset */
	{ 0x07, 0x00 }, /* Timeout */
	{ 0x0b, 0x22 },  /* Interface control */
	{ 0x0c, 0x22 },  /* Master mode control */
	{ 0x0d, 0x08 },  /* Powerdown control */
	{ 0x0e, 0xcf },  /* Attenuation Left  0x01 = -103dB, 0xff = 24dB */
	{ 0x0f, 0xcf },  /* Attenuation Right 0.5dB steps */
	{ 0x10, 0x7b },  /* ALC Control 1 */
	{ 0x11, 0x00 },  /* ALC Control 2 */
	{ 0x12, 0x32 },  /* ALC Control 3 */
	{ 0x13, 0x00 },  /* Noise gate control */
	{ 0x14, 0xa6 },  /* Limiter control */
	{ 0x15, ADC_MUX_LINEIN },  /* ADC Mixer control */
};

static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
					 struct pci_dev *pci,
					 struct snd_ca0106 **rchip)
{
	struct snd_ca0106 *chip;
	struct snd_ca0106_details *c;
	int err;
	int ch;
	static struct snd_device_ops ops = {
		.dev_free = snd_ca0106_dev_free,
	};
  
	*rchip = NULL;
  
	if ((err = pci_enable_device(pci)) < 0)
		return err;
	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0 ||
	    pci_set_consistent_dma_mask(pci, DMA_32BIT_MASK) < 0) {
		printk(KERN_ERR "error to set 32bit mask DMA\n");
		pci_disable_device(pci);
		return -ENXIO;
	}
  
	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
	if (chip == NULL) {
		pci_disable_device(pci);
		return -ENOMEM;
	}
  
	chip->card = card;
	chip->pci = pci;
	chip->irq = -1;

	spin_lock_init(&chip->emu_lock);
  
	chip->port = pci_resource_start(pci, 0);
	if ((chip->res_port = request_region(chip->port, 0x20,
					     "snd_ca0106")) == NULL) { 
		snd_ca0106_free(chip);
		printk(KERN_ERR "cannot allocate the port\n");
		return -EBUSY;
	}

	if (request_irq(pci->irq, snd_ca0106_interrupt,
			IRQF_SHARED, "snd_ca0106", chip)) {
		snd_ca0106_free(chip);
		printk(KERN_ERR "cannot grab irq\n");
		return -EBUSY;
	}
	chip->irq = pci->irq;
  
 	/* This stores the periods table. */ 
	if(snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci), 1024, &chip->buffer) < 0) {
		snd_ca0106_free(chip);
		return -ENOMEM;
	}

	pci_set_master(pci);
	/* read revision & serial */
	pci_read_config_byte(pci, PCI_REVISION_ID, &chip->revision);
	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
#if 1
	printk(KERN_INFO "snd-ca0106: Model %04x Rev %08x Serial %08x\n", chip->model,
	       chip->revision, chip->serial);
 	printk(KERN_INFO MODULE_NAME ": 44100Hz capable rev C. Ben Stanley " __DATE__ ".\n" );
#endif
	strcpy(card->driver, "CA0106");
	strcpy(card->shortname, "CA0106");

	for (c = ca0106_chip_details; c->serial; c++) {
		if (subsystem[dev]) {
			if (c->serial == subsystem[dev])
				break;
		} else if (c->serial == chip->serial)
			break;
	}
	chip->details = c;
	if (subsystem[dev]) {
		printk(KERN_INFO "snd-ca0106: Sound card name=%s, subsystem=0x%x. Forced to subsystem=0x%x\n",
                        c->name, chip->serial, subsystem[dev]);
	}

	sprintf(card->longname, "%s at 0x%lx irq %i",
		c->name, chip->port, chip->irq);

	outl(0, chip->port + INTE);

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
	snd_ca0106_ptr_write(chip, SPCS0, 0,
				chip->spdif_bits[0] =
				SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
				SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
				SPCS_GENERATIONSTATUS | 0x00001200 |
				0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
	/* Only SPCS1 has been tested */
	snd_ca0106_ptr_write(chip, SPCS1, 0,
				chip->spdif_bits[1] =
				SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
				SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
				SPCS_GENERATIONSTATUS | 0x00001200 |
				0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
	snd_ca0106_ptr_write(chip, SPCS2, 0,
				chip->spdif_bits[2] =
				SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
				SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
				SPCS_GENERATIONSTATUS | 0x00001200 |
				0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
	snd_ca0106_ptr_write(chip, SPCS3, 0,
				chip->spdif_bits[3] =
				SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
				SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
				SPCS_GENERATIONSTATUS | 0x00001200 |
				0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);

        snd_ca0106_ptr_write(chip, PLAYBACK_MUTE, 0, 0x00fc0000);
        snd_ca0106_ptr_write(chip, CAPTURE_MUTE, 0, 0x00fc0000);

        /* Write 0x8000 to AC97_REC_GAIN to mute it. */
        outb(AC97_REC_GAIN, chip->port + AC97ADDRESS);
        outw(0x8000, chip->port + AC97DATA);
#if 0
	snd_ca0106_ptr_write(chip, SPCS0, 0, 0x2108006);
	snd_ca0106_ptr_write(chip, 0x42, 0, 0x2108006);
	snd_ca0106_ptr_write(chip, 0x43, 0, 0x2108006);
	snd_ca0106_ptr_write(chip, 0x44, 0, 0x2108006);
#endif

	//snd_ca0106_ptr_write(chip, SPDIF_SELECT2, 0, 0xf0f003f); /* OSS drivers set this. */
	/* Analog or Digital output */
	snd_ca0106_ptr_write(chip, SPDIF_SELECT1, 0, 0xf);
	snd_ca0106_ptr_write(chip, SPDIF_SELECT2, 0, 0x000f0000); /* 0x0b000000 for digital, 0x000b0000 for analog, from win2000 drivers. Use 0x000f0000 for surround71 */
	chip->spdif_enable = 0; /* Set digital SPDIF output off */
	//snd_ca0106_ptr_write(chip, 0x45, 0, 0); /* Analogue out */
	//snd_ca0106_ptr_write(chip, 0x45, 0, 0xf00); /* Digital out */

	snd_ca0106_ptr_write(chip, CAPTURE_CONTROL, 0, 0x40c81000); /* goes to 0x40c80000 when doing SPDIF IN/OUT */
	snd_ca0106_ptr_write(chip, CAPTURE_CONTROL, 1, 0xffffffff); /* (Mute) CAPTURE feedback into PLAYBACK volume. Only lower 16 bits matter. */
	snd_ca0106_ptr_write(chip, CAPTURE_CONTROL, 2, 0x30300000); /* SPDIF IN Volume */
	snd_ca0106_ptr_write(chip, CAPTURE_CONTROL, 3, 0x00700000); /* SPDIF IN Volume, 0x70 = (vol & 0x3f) | 0x40 */
	snd_ca0106_ptr_write(chip, PLAYBACK_ROUTING1, 0, 0x32765410);
	snd_ca0106_ptr_write(chip, PLAYBACK_ROUTING2, 0, 0x76767676);
	snd_ca0106_ptr_write(chip, CAPTURE_ROUTING1, 0, 0x32765410);
	snd_ca0106_ptr_write(chip, CAPTURE_ROUTING2, 0, 0x76767676);
	for(ch = 0; ch < 4; ch++) {
		snd_ca0106_ptr_write(chip, CAPTURE_VOLUME1, ch, 0x30303030); /* Only high 16 bits matter */
		snd_ca0106_ptr_write(chip, CAPTURE_VOLUME2, ch, 0x30303030);
		//snd_ca0106_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0x40404040); /* Mute */
		//snd_ca0106_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0x40404040); /* Mute */
		snd_ca0106_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0xffffffff); /* Mute */
		snd_ca0106_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0xffffffff); /* Mute */
	}
	if (chip->details->i2c_adc == 1) {
	        /* Select MIC, Line in, TAD in, AUX in */
	        snd_ca0106_ptr_write(chip, CAPTURE_SOURCE, 0x0, 0x333300e4);
		/* Default to CAPTURE_SOURCE to i2s in */
		chip->capture_source = 3;
	} else if (chip->details->ac97 == 1) {
	        /* Default to AC97 in */
	        snd_ca0106_ptr_write(chip, CAPTURE_SOURCE, 0x0, 0x444400e4);
		/* Default to CAPTURE_SOURCE to AC97 in */
		chip->capture_source = 4;
	} else {
	        /* Select MIC, Line in, TAD in, AUX in */
	        snd_ca0106_ptr_write(chip, CAPTURE_SOURCE, 0x0, 0x333300e4);
		/* Default to Set CAPTURE_SOURCE to i2s in */
		chip->capture_source = 3;
	}

        if (chip->details->gpio_type == 2) { /* The SB0438 use GPIO differently. */
		/* FIXME: Still need to find out what the other GPIO bits do. E.g. For digital spdif out. */
		outl(0x0, chip->port+GPIO);
		//outl(0x00f0e000, chip->port+GPIO); /* Analog */
		outl(0x005f5301, chip->port+GPIO); /* Analog */
	} else if (chip->details->gpio_type == 1) { /* The SB0410 and SB0413 use GPIO differently. */
		/* FIXME: Still need to find out what the other GPIO bits do. E.g. For digital spdif out. */
		outl(0x0, chip->port+GPIO);
		//outl(0x00f0e000, chip->port+GPIO); /* Analog */
		outl(0x005f5301, chip->port+GPIO); /* Analog */
	} else {
		outl(0x0, chip->port+GPIO);
		outl(0x005f03a3, chip->port+GPIO); /* Analog */
		//outl(0x005f02a2, chip->port+GPIO);   /* SPDIF */
	}
	snd_ca0106_intr_enable(chip, 0x105); /* Win2000 uses 0x1e0 */

	//outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
	//outl(0x00001409, chip->port+HCFG); /* 0x1000 causes AC3 to fails. Maybe it effects 24 bit output. */
	//outl(0x00000009, chip->port+HCFG);
	outl(HCFG_AC97 | HCFG_AUDIOENABLE, chip->port+HCFG); /* AC97 2.0, Enable outputs. */

        if (chip->details->i2c_adc == 1) { /* The SB0410 and SB0413 use I2C to control ADC. */
		int size, n;

		size = ARRAY_SIZE(i2c_adc_init);
                //snd_printk("I2C:array size=0x%x\n", size);
		for (n=0; n < size; n++) {
			snd_ca0106_i2c_write(chip, i2c_adc_init[n][0], i2c_adc_init[n][1]);
		}
		for (n=0; n < 4; n++) {
			chip->i2c_capture_volume[n][0]= 0xcf;
			chip->i2c_capture_volume[n][1]= 0xcf;
		}
		chip->i2c_capture_source=2; /* Line in */
	        //snd_ca0106_i2c_write(chip, ADC_MUX, ADC_MUX_LINEIN); /* Enable Line-in capture. MIC in currently untested. */
	}
        if (chip->details->spi_dac == 1) { /* The SB0570 use SPI to control DAC. */
		int size, n;

		size = ARRAY_SIZE(spi_dac_init);
		for (n=0; n < size; n++)
			snd_ca0106_spi_write(chip, spi_dac_init[n]);
	}

	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
				  chip, &ops)) < 0) {
		snd_ca0106_free(chip);
		return err;
	}
	*rchip = chip;
	return 0;
}


static void ca0106_midi_interrupt_enable(struct snd_ca_midi *midi, int intr)
{
	snd_ca0106_intr_enable((struct snd_ca0106 *)(midi->dev_id), intr);
}

static void ca0106_midi_interrupt_disable(struct snd_ca_midi *midi, int intr)
{
	snd_ca0106_intr_disable((struct snd_ca0106 *)(midi->dev_id), intr);
}

static unsigned char ca0106_midi_read(struct snd_ca_midi *midi, int idx)
{
	return (unsigned char)snd_ca0106_ptr_read((struct snd_ca0106 *)(midi->dev_id),
						  midi->port + idx, 0);
}

static void ca0106_midi_write(struct snd_ca_midi *midi, int data, int idx)
{
	snd_ca0106_ptr_write((struct snd_ca0106 *)(midi->dev_id), midi->port + idx, 0, data);
}

static struct snd_card *ca0106_dev_id_card(void *dev_id)
{
	return ((struct snd_ca0106 *)dev_id)->card;
}

static int ca0106_dev_id_port(void *dev_id)
{
	return ((struct snd_ca0106 *)dev_id)->port;
}

static int __devinit snd_ca0106_midi(struct snd_ca0106 *chip, unsigned int channel)
{
	struct snd_ca_midi *midi;
	char *name;
	int err;

	if (channel == CA0106_MIDI_CHAN_B) {
		name = "CA0106 MPU-401 (UART) B";
		midi =  &chip->midi2;
		midi->tx_enable = INTE_MIDI_TX_B;
		midi->rx_enable = INTE_MIDI_RX_B;
		midi->ipr_tx = IPR_MIDI_TX_B;
		midi->ipr_rx = IPR_MIDI_RX_B;
		midi->port = MIDI_UART_B_DATA;
	} else {
		name = "CA0106 MPU-401 (UART)";
		midi =  &chip->midi;
		midi->tx_enable = INTE_MIDI_TX_A;
		midi->rx_enable = INTE_MIDI_TX_B;
		midi->ipr_tx = IPR_MIDI_TX_A;
		midi->ipr_rx = IPR_MIDI_RX_A;
		midi->port = MIDI_UART_A_DATA;
	}

	midi->reset = CA0106_MPU401_RESET;
	midi->enter_uart = CA0106_MPU401_ENTER_UART;
	midi->ack = CA0106_MPU401_ACK;

	midi->input_avail = CA0106_MIDI_INPUT_AVAIL;
	midi->output_ready = CA0106_MIDI_OUTPUT_READY;

	midi->channel = channel;

	midi->interrupt_enable = ca0106_midi_interrupt_enable;
	midi->interrupt_disable = ca0106_midi_interrupt_disable;

	midi->read = ca0106_midi_read;
	midi->write = ca0106_midi_write;

	midi->get_dev_id_card = ca0106_dev_id_card;
	midi->get_dev_id_port = ca0106_dev_id_port;

	midi->dev_id = chip;
	
	if ((err = ca_midi_init(chip, midi, 0, name)) < 0)
		return err;

	return 0;
}


static int __devinit snd_ca0106_probe(struct pci_dev *pci,
					const struct pci_device_id *pci_id)
{
	static int dev;
	struct snd_card *card;
	struct snd_ca0106 *chip;
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

	if ((err = snd_ca0106_create(dev, card, pci, &chip)) < 0) {
		snd_card_free(card);
		return err;
	}

	if ((err = snd_ca0106_pcm(chip, 0, NULL)) < 0) {
		snd_card_free(card);
		return err;
	}
	if ((err = snd_ca0106_pcm(chip, 1, NULL)) < 0) {
		snd_card_free(card);
		return err;
	}
	if ((err = snd_ca0106_pcm(chip, 2, NULL)) < 0) {
		snd_card_free(card);
		return err;
	}
	if ((err = snd_ca0106_pcm(chip, 3, NULL)) < 0) {
		snd_card_free(card);
		return err;
	}
        if (chip->details->ac97 == 1) { /* The SB0410 and SB0413 do not have an AC97 chip. */
		if ((err = snd_ca0106_ac97(chip)) < 0) {
			snd_card_free(card);
			return err;
		}
	}
	if ((err = snd_ca0106_mixer(chip)) < 0) {
		snd_card_free(card);
		return err;
	}

	snd_printdd("ca0106: probe for MIDI channel A ...");
	if ((err = snd_ca0106_midi(chip,CA0106_MIDI_CHAN_A)) < 0) {
		snd_card_free(card);
		snd_printdd(" failed, err=0x%x\n",err);
		return err;
	}
	snd_printdd(" done.\n");

#ifdef CONFIG_PROC_FS
	snd_ca0106_proc_init(chip);
#endif

	snd_card_set_dev(card, &pci->dev);

	if ((err = snd_card_register(card)) < 0) {
		snd_card_free(card);
		return err;
	}

	pci_set_drvdata(pci, card);
	dev++;
	return 0;
}

static void __devexit snd_ca0106_remove(struct pci_dev *pci)
{
	snd_card_free(pci_get_drvdata(pci));
	pci_set_drvdata(pci, NULL);
}

// PCI IDs
static struct pci_device_id snd_ca0106_ids[] = {
	{ 0x1102, 0x0007, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },	/* Audigy LS or Live 24bit */
	{ 0, }
};
MODULE_DEVICE_TABLE(pci, snd_ca0106_ids);

// pci_driver definition
static struct pci_driver driver = {
	.name = "CA0106",
	.id_table = snd_ca0106_ids,
	.probe = snd_ca0106_probe,
	.remove = __devexit_p(snd_ca0106_remove),
};

// initialization of the module
static int __init alsa_card_ca0106_init(void)
{
	return pci_register_driver(&driver);
}

// clean up the module
static void __exit alsa_card_ca0106_exit(void)
{
	pci_unregister_driver(&driver);
}

module_init(alsa_card_ca0106_init)
module_exit(alsa_card_ca0106_exit)

--=-X5cctbPCO4CF/e2eZDND
Content-Disposition: attachment; filename=ca0106_44100Hz_from_ubuntu_2.6.22.patch
Content-Type: text/x-patch; name=ca0106_44100Hz_from_ubuntu_2.6.22.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- orig/linux-source-2.6.22-2.6.22/sound/pci/ca0106/ca0106_main.c	2007-07-09 09:32:17.000000000 +1000
+++ ben/linux-source-2.6.22-2.6.22/sound/pci/ca0106/ca0106_main.c	2008-05-21 00:14:05.000000000 +1000
@@ -165,6 +165,8 @@
 module_param_array(subsystem, uint, NULL, 0444);
 MODULE_PARM_DESC(subsystem, "Force card subsystem model.");
 
+#define MODULE_NAME  "snd-ca0106"
+
 #include "ca0106.h"
 
 static struct snd_ca0106_details ca0106_chip_details[] = {
@@ -247,9 +249,9 @@
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
-	.rates =		(SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000),
-	.rate_min =		48000,
+	.rates =		(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000),
+	.rate_min =		44100,
 	.rate_max =		192000,
 	.channels_min =		2,  //1,
 	.channels_max =		2,  //6,
@@ -281,6 +283,48 @@
 	.fifo_size =		0,
 };
 
+static unsigned int all_spdif_playback_rates[] =
+	{44100, 48000, 96000, 192000};
+
+static int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
+                                 struct snd_pcm_hw_rule *rule)
+{
+	struct snd_ca0106 *chip = rule->private;
+	int chi, any_44100 = 0, any_non_44100 = 0, mask = 0;
+	struct snd_ca0106_channel *chp = 0;
+	struct snd_pcm_runtime *runtime;
+	snd_assert(chip != NULL, return -EINVAL);
+	
+	if (chip->spdif_enable) {
+		for (chi = 0; chi < 4; ++chi ) {
+			chp = &(chip->playback_channels[chi]);
+			if (!chp->use) continue;
+			snd_assert(chp->epcm != NULL, return -EINVAL);
+			if (!chp->epcm->running) continue;
+			snd_assert(chp->epcm->substream != NULL, return -EINVAL);
+			snd_assert(chp->epcm->substream->runtime != NULL, return -EINVAL);
+			runtime = chp->epcm->substream->runtime;
+			snd_printd("snd_hw_rule_playback_rate: ch=%d, rate=%d.\n",chi,runtime->rate);
+			any_44100 += runtime->rate == 44100;
+			any_non_44100 += runtime->rate != 44100;
+		}
+		if (any_44100 && any_non_44100)
+			printk(KERN_ERR MODULE_NAME ": Detected 44100Hz and other rates in use simultaneously.\n");
+		if (any_44100)
+			mask = 0x1;
+		else if (any_non_44100)
+			mask = 0xE;
+		else
+			mask = 0xF;
+	} else {
+		// 44100Hz is not supported for DAC (FIXME Why?)
+		mask = 0xE;
+	}
+	snd_printd("snd_hw_rule_playback_rate: any_44100=%d, any_non_44100=%d, mask=0x%X, spdif=%d\n",any_44100,any_non_44100,mask,chip->spdif_enable);
+	return snd_interval_list(hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE),
+		ARRAY_SIZE(all_spdif_playback_rates), all_spdif_playback_rates, mask);
+}
+
 unsigned int snd_ca0106_ptr_read(struct snd_ca0106 * emu, 
 					  unsigned int reg, 
 					  unsigned int chn)
@@ -455,13 +499,28 @@
         channel->number = channel_id;
 
 	channel->use = 1;
-        //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
+
+        snd_printd("open_playback: channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
         //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
 	channel->epcm = epcm;
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
                 return err;
 	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
                 return err;
+ 	if ((err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+                       hw_rule_playback_rate, (void*)chip, SNDRV_PCM_HW_PARAM_RATE,
+                       -1)) < 0)
+                 return err;
+#if 0
+ 	// FIXME Add constraints to deal with the format.
+ 	if (chip->output_frequency_reservation_count == 0) {
+ 		chip->output_frequency_is_44100 = runtime->rate == 44100;
+ 	} else if (chip->output_frequency_is_44100 && runtime->rate != 44100)
+ 		return -EINVAL;
+ 	if (chip->playback_channels_open_count && chip->output_format != runtime->format)
+ 		return -EINVAL;
+#endif
+ 	
 	return 0;
 }
 
@@ -472,6 +531,9 @@
 	struct snd_pcm_runtime *runtime = substream->runtime;
         struct snd_ca0106_pcm *epcm = runtime->private_data;
 	chip->playback_channels[epcm->channel_id].use = 0;
+
+ 	snd_printd("close_playback.\n");
+ 
 	/* FIXME: maybe zero others */
 	return 0;
 }
@@ -598,51 +660,77 @@
 static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 {
 	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_pcm_runtime *runtime = substream->runtime, *runtimei = 0;
 	struct snd_ca0106_pcm *epcm = runtime->private_data;
-	int channel = epcm->channel_id;
+	struct snd_ca0106_channel *chp = 0;
+	int channel = epcm->channel_id, chi, any_44100 = 0, any_non_44100 = 0;
 	u32 *table_base = (u32 *)(emu->buffer.area+(8*16*channel));
 	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
 	u32 hcfg_mask = HCFG_PLAYBACK_S32_LE;
 	u32 hcfg_set = 0x00000000;
 	u32 hcfg;
-	u32 reg40_mask = 0x30000 << (channel<<1);
+	//u32 reg40_mask = 0x30000 << (channel<<1);
+	u32 reg40_mask = 0xFF0000;
 	u32 reg40_set = 0;
 	u32 reg40;
 	/* FIXME: Depending on mixer selection of SPDIF out or not, select the spdif rate or the DAC rate. */
-	u32 reg71_mask = 0x03030000 ; /* Global. Set SPDIF rate. We only support 44100 to spdif, not to DAC. */
+//	u32 reg71_mask = 0x03030000 ; /* Global. Set SPDIF rate. We only support 44100 to spdif, not to DAC. */
+	u32 reg71_mask;
+	u32 reg71_shift;
 	u32 reg71_set = 0;
 	u32 reg71;
 	int i;
-	
-        //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
-        //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
-	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
-	/* Rate can be set per channel. */
-	/* reg40 control host to fifo */
-	/* reg71 controls DAC rate. */
-	switch (runtime->rate) {
-	case 44100:
-		reg40_set = 0x10000 << (channel<<1);
-		reg71_set = 0x01010000; 
-		break;
-        case 48000:
-		reg40_set = 0;
-		reg71_set = 0; 
-		break;
-	case 96000:
-		reg40_set = 0x20000 << (channel<<1);
-		reg71_set = 0x02020000; 
-		break;
-	case 192000:
-		reg40_set = 0x30000 << (channel<<1);
-		reg71_set = 0x03030000; 
-		break;
-	default:
-		reg40_set = 0;
-		reg71_set = 0; 
-		break;
+	if (emu->spdif_enable) {
+		reg71_shift = 24; /* SPDIF Output Rate */
+	} else {
+		reg71_shift = 16; /* I2S Output Rate */
 	}
+	reg71_mask = 0x3 << reg71_shift;
+	
+        snd_printd("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
+        //snd_printd("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
+	//snd_printd("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
+ 	// We are forced to build the settings for all the channels
+ 	for (chi = 0; chi < 4; ++chi ) {
+ 		chp = &(emu->playback_channels[chi]);
+ 		if (!chp->use) continue;
+ 		snd_assert(chp->epcm != NULL, return -EINVAL);
+		if (chi != channel && !chp->epcm->running) continue;
+ 		snd_assert(chp->epcm->substream != NULL, return -EINVAL);
+ 		snd_assert(chp->epcm->substream->runtime != NULL, return -EINVAL);
+ 		runtimei = chp->epcm->substream->runtime;
+ 		any_44100 += runtimei->rate == 44100;
+ 		any_non_44100 += runtimei->rate != 44100;
+ 		/* Rate can be set per channel. */
+ 		/* reg40 control host to fifo */
+ 		/* reg71 controls DAC rate. */
+ 		switch (runtimei->rate) {
+ 		case 44100:
+ 			/* We only support 44100 to spdif, not to DAC. (FIXME WHY?)*/
+ 			if (emu->spdif_enable) {
+ 				reg40_set |= 0x550000; /* When using 44100, all channels must be set to that speed. */
+ 				reg71_set |= 0x1 << reg71_shift;
+ 				break;
+ 			} else {
+ 				printk(KERN_ERR MODULE_NAME "prepare_playback: 44100Hz is invalid for DAC.\n");
+ 			}
+ 	        case 48000:
+ 			//reg40_set = 0;
+ 			//reg71_set = 0; 
+ 			break;
+ 		case 96000:
+ 			reg40_set |= 0x20000 << (chi<<1);
+ 			reg71_set |= 0x2 << reg71_shift;
+ 			break;
+ 		case 192000:
+ 			reg40_set |= 0x30000 << (chi<<1);
+ 			reg71_set |= 0x3 << reg71_shift;
+ 			break;
+ 		default:
+			printk(KERN_ERR MODULE_NAME "prepare_playback: Bad sampling frequency %d.\n",runtimei->rate);
+ 		}
+  	}
+	snd_printd("prepare_playback: any_44100=%d, any_non_44100=%d, spdif=%d.\n",any_44100,any_non_44100,emu->spdif_enable);
 	/* Format is a global setting */
 	/* FIXME: Only let the first channel accessed set this. */
 	switch (runtime->format) {
@@ -660,11 +748,15 @@
 	hcfg = (hcfg & ~hcfg_mask) | hcfg_set;
 	outl(hcfg, emu->port + HCFG);
 	reg40 = snd_ca0106_ptr_read(emu, 0x40, 0);
+        snd_printd("ca0106: old reg40=%x\n", reg40);
 	reg40 = (reg40 & ~reg40_mask) | reg40_set;
 	snd_ca0106_ptr_write(emu, 0x40, 0, reg40);
+        snd_printd("ca0106: new reg40=%x\n", reg40);
 	reg71 = snd_ca0106_ptr_read(emu, 0x71, 0);
+        snd_printd("ca0106: old reg71=%x\n", reg71);
 	reg71 = (reg71 & ~reg71_mask) | reg71_set;
 	snd_ca0106_ptr_write(emu, 0x71, 0, reg71);
+        snd_printd("ca0106: new reg71=%x\n", reg71);
 
 	/* FIXME: Check emu->buffer.size before actually writing to it. */
         for(i=0; i < runtime->periods; i++) {
@@ -710,9 +802,9 @@
 	u32 reg71_set = 0;
 	u32 reg71;
 	
-        //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
-        //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
-	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
+        snd_printd("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
+        //snd_printd("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
+	//snd_printd("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
 	/* reg71 controls ADC rate. */
 	switch (runtime->rate) {
 	case 44100:
@@ -757,7 +849,7 @@
 	}
 
 
-        //printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
+        snd_printd("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
 	snd_ca0106_ptr_write(emu, 0x13, channel, 0);
 	snd_ca0106_ptr_write(emu, CAPTURE_DMA_ADDR, channel, runtime->dma_addr);
 	snd_ca0106_ptr_write(emu, CAPTURE_BUFFER_SIZE, channel, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
@@ -1300,6 +1392,7 @@
 #if 1
 	printk(KERN_INFO "snd-ca0106: Model %04x Rev %08x Serial %08x\n", chip->model,
 	       chip->revision, chip->serial);
+ 	printk(KERN_INFO MODULE_NAME ": 44100Hz capable rev C. Ben Stanley " __DATE__ ".\n" );
 #endif
 	strcpy(card->driver, "CA0106");
 	strcpy(card->shortname, "CA0106");

--=-X5cctbPCO4CF/e2eZDND
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-X5cctbPCO4CF/e2eZDND--
