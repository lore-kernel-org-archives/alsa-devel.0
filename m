From: "Pedro I. Sanchez" <psanchez@fosstel.com>
Subject: Re: ASoC: at91sam9260-PCM1808/TAS5709-based board
	driver
Date: Tue, 25 Aug 2009 15:46:14 -0400
Message-ID: <4A943F86.5000601@fosstel.com>
References: <4A7DB844.3030303@fosstel.com>	<9e4733910908090635j29db4ebn64f92c2176f3cb85@mail.gmail.com>	<9e4733910908090637g4b9eaf19ud1b46de354664df2@mail.gmail.com>	<4A81BB75.3070405@fosstel.com>	<20090811224132.GB4691@sirena.org.uk>	<4A94200D.6080707@fosstel.com>
	<20090825182934.GA4317@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a2s40.a2hosting.com (a2s40.a2hosting.com [74.126.24.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 6105A243AA
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 21:46:55 +0200 (CEST)
Received: from [207.35.173.122] (helo=[192.168.215.229])
	by a2s40.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <psanchez@fosstel.com>)
	id 1Mg1yh-0001Ad-3N
	for alsa-devel@alsa-project.org; Tue, 25 Aug 2009 15:46:47 -0400
In-Reply-To: <20090825182934.GA4317@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Aug 25, 2009 at 01:31:57PM -0400, Pedro I. Sanchez wrote:
> 
>> The TAS5709 is a playback-slave-only device The SSC is therefore put in 
>> master mode and I can see the SSC clock signals (SCLK and LRCLK) on the 
>> scope when playing a sound file. I can also see the activity on the data 
>> line. But unfortunately, there is no sound, just a speaker Hisss when I 
>> play a file. I doubled checked all the volume levels to ensure they are 
>> not mutted.
> 
> Is there any control in the CODEC?  If so you should check that it is
> set up properly.
> 

There are registers to mute/unmute channels and master volume. For the 
time being I am using my pcm_prepare function to write directly to those 
registers to ensure that they are not muted when a sound file is played.

I haven't "mastered" the definitions of sound controls in ALSA yet, I'll 
do that later.

>> However, I noticed that the duty cycle of the SSC clocks is not 50% as I 
>> would expect it to be. There seem to be much more bits on one channel 
>> than in the other (my sample file is stereo, 16 bits, 44.1 MHz). The 
>> sample clock illustrations in the TAS5709 all have the same number of 
>> bits per channel, but it doesn't say explicitly that this is mandatory. 
>>  From my understanding of the I2S spec, this is not.
> 
>> The TAS5709 is supposed to detect the clock and data rates 
>> automatically. Do you know if this non-50% duty cycle could be the 
>> reason for the lack of sound? Is there a way to force it to be 50%?
> 
> If the CODEC is trying to work out what the sample and clock rates are
> automatically then it does seem reasonable that any oddities in the
> clocks that it's given might confuse it somehow - for example, causing
> it to expect more bit clocks than it's actually getting which would
> cause it to fail to clock in enough data to do a conversion.
> 
> I'd expect that appropriate configuration of the clock dividers for the
> SSC it's possible to make it generate more normal looking clocks, I
> don't think anyone ever optimised the divider configuration when the
> AT91SAM9G20-EK was running the SSC in master mode.

Indeed, as I change the dividers the duty cycle changes. But I am out of 
logic now on how to find the right values. It seems that a high degree 
of black magic is required to find them. This is the code that I am 
using in the machine driver to set them up:

	/* set the MCK divider for BCLK */
	ret = snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_CMR_DIV, cmr_div);
	if (ret < 0)
		return ret;

	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
		/* set the BCLK divider for DACLRC */
		ret = snd_soc_dai_set_clkdiv(cpu_dai,
						ATMEL_SSC_TCMR_PERIOD, period);
	} else {
		/* set the BCLK divider for ADCLRC */
		ret = snd_soc_dai_set_clkdiv(cpu_dai,
						ATMEL_SSC_RCMR_PERIOD, period);
	}
	if (ret < 0)
		return ret;


The big quest for me now is to figure out what "cmr_div" and "period" 
have to be. They must be different for each sample rate. Any pointers 
would be appreciated.

Thanks,

--
Pedro

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
