From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 20 Dec 2007 08:24:35 -0600
Message-ID: <476A7B23.2040905@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<20071220040633.GA6732@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A7F9247F4
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 16:39:43 +0100 (CET)
In-Reply-To: <20071220040633.GA6732@lixom.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Olof Johansson wrote:

>> +static struct of_device_id mpc8610_ids[] = {
>> +	{ .type = "soc", },
>> +	{}
> 
> Please scan based on compatible instead of device_type.

I was just following the example from another board file.  However, the 'soc' 
node in the device tree does not have a compatible property, so I don't how to 
change this.

>> +config SND_SOC_MPC8610
>> +	bool "ALSA SoC support for the MPC8610 SOC"
>> +	depends on SND_SOC #&& MPC8610_HPCD
>> +	default y #if MPC8610
>> +	help
>> +	  Say Y if you want to add support for codecs attached to the SSI
>> +          device on an MPC8610.
> 
> Don't default configs to 'y'. Also, what's with the commented-out
> dependencies and if?

Sorry, that was a development change that I forgot to put back.  The "y #" 
should be deleted.


>> + * ssi_stx_phys: bus address of SSI STX register
>> + * ssi_srx_phys: bus address of SSI SRX register
>> + * dma_channel: pointer to the DMA channel's registers
>> + * irq: IRQ for this DMA channel
>> + * assigned: set to 1 if that DMA channel is assigned to a substream
>> + */
> 
> This goes for the whole patch: You've got good documentation, but it's
> not in docbook format. Please reformat it since it should be a pretty
> simple thing to do.

Ok.

>> +static int fsl_dma_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
>> +	struct snd_pcm *pcm)
>> +{
>> +	static u64 fsl_dma_dmamask = 0xffffffff;
>> +	int ret;
>> +
>> +	if (!card->dev->dma_mask)
>> +		card->dev->dma_mask = &fsl_dma_dmamask;
> 
> I haven't read how your channel allocation works, but providing a
> pointer to a local static variable is a bit fishy no matter what.

I just copied this code from another module.  All the ALSA drivers do this, 
but I'll look into it and see if it can't be done different.  I make no 
promises, though!

> Do you ever anticipate having other dma users on the system, such as
> memcpy offload? You'll probably need allocation support for channels
> when that day comes (I ended up writing a simple library for dma channel
> management for that very reason on my platform).

Yes, I plan on updating this driver to work with the standard Freescale "Elo" 
device driver, but that will have to wait until that code is in the kernel and 
stabilized.  The SSI is limited in which DMA channels it can use, anyway.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
