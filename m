From: Timur Tabi <timur@freescale.com>
Subject: Re: ASOC: Best way to get private data from machine
 driver to the other drivers?
Date: Tue, 02 Oct 2007 11:48:17 -0500
Message-ID: <47027651.3020501@freescale.com>
References: <46FD6EAA.5050801@freescale.com>	
	<1191236021.3318.41.camel@localhost.localdomain>	
	<47016B52.1060702@freescale.com>
	<1191343067.12060.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 1468D243CB
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Oct 2007 18:48:22 +0200 (CEST)
In-Reply-To: <1191343067.12060.17.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Mon, 2007-10-01 at 16:49 -0500, Timur Tabi wrote:
>> Liam Girdwood wrote:
>>
>>> Could you have a look at the V2 i.mx31 SSI driver and let me know if we
>>> need further changes for better dts support.
>> I'm trying to port the CS4270 codec driver (it's easier) to ASOC v2, and I see 
>> that you don't have snd_pcm_rate_to_rate_bit().  Where did it go?
>>
> 
> We never had a snd_pcm_rate_to_rate_bit() in the ASoC code, perhaps you
> mean something else ?

In may not be part of ASoC, but it's part of ALSA, and I need it.  It's not 
just in your repository.

sound/core/pcm_misc.c

/**
  * snd_pcm_rate_to_rate_bit - converts sample rate to SNDRV_PCM_RATE_xxx bit
  * @rate: the sample rate to convert
  *
  * Returns the SNDRV_PCM_RATE_xxx flag that corresponds to the given rate, or
  * SNDRV_PCM_RATE_KNOT for an unknown rate.
  */
unsigned int snd_pcm_rate_to_rate_bit(unsigned int rate)
{
	unsigned int i;

	for (i = 0; i < snd_pcm_known_rates.count; i++)
		if (snd_pcm_known_rates.list[i] == rate)
			return 1u << i;
	return SNDRV_PCM_RATE_KNOT;
}
EXPORT_SYMBOL(snd_pcm_rate_to_rate_bit);

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
