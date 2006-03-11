From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: pointer callback in pcm
Date: Sat, 11 Mar 2006 18:47:28 +0000
Message-ID: <44131B40.9080100@superbug.co.uk>
References: <1141942882.10937.5.camel@localhost.localdomain>	 <1141952015.13319.90.camel@mindpipe>	 <1142020261.9246.3.camel@localhost.localdomain>	 <4412B17F.7080200@superbug.co.uk>	 <1142076452.9496.8.camel@localhost.localdomain>	 <4412F001.5020404@superbug.co.uk> <1142098225.9496.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142098225.9496.25.camel@localhost.localdomain>
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
Cc: Lee Revell <rlrevell@joe-job.com>, Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> On Sat, 2006-03-11 at 15:42 +0000, James Courtier-Dutton wrote:
>
>
>   
>> 2) start DMA transfer of one period.
>>     Which period you copy is the important bit here. At this point the 
>> hardware will have played 1 period, so you replace the period that has 
>> just played, not the period that is about to be played.
>>     
>
> I am just sitting down to write this code now, but where in the dma
> buffer should I look for this period. The relevant code at the moment
> looks like this:
>
> dma_xfer(0, runtime->dma_area + (0x1000 * dreamcastcard->clicks),
> 0x11000 + (0x1000 * dreamcastcard->clicks), 0x1000, 5);
>
>
> (clicks is always equal to the period that has just played out ie the
> code does this
>
> Get interrupt
> Reset interrupt flag on ARM7 side
> dma transfer
> clicks++
> if (clicks == 8) clicks = 0
> call pcm_elapsed
> return with acknowledge interrupt
>
>
> The hardware buffer begins at 0x11000 in the ARM7 space and each period
> is 0x1000 in size - but I am rather assuming you can rely on the DMA
> buffer (8 periods long) being filled up at 8 period intervals -is that
> right?
>
>
>   
Ok, I looked at the code now, and there are a few things that need fixing.
1)

static snd_pcm_hardware_t snd_pcm_aica_playback_hw = {

	.info = 		(SNDRV_PCM_INFO_NONINTERLEAVED),
	.formats = 		(SNDRV_PCM_FMTBIT_S8|SNDRV_PCM_FMTBIT_U8|SNDRV_PCM_FMTBIT_S16_LE|SNDRV_PCM_FMTBIT_IMA_ADPCM),
	.rates =		SNDRV_PCM_RATE_8000_48000,
        .rate_min =         	8000,
        .rate_max =         	48000,
        .channels_min =     	1,
        .channels_max =     	1,
        .buffer_bytes_max = 	32768,
        .period_bytes_min = 	4096,
        .period_bytes_max = 	4096,
        .periods_min =      	1,
        .periods_max =      	8,
};

If the card can only do 8 periods, make .periods_min = 8,
Can the card handle all these formats and rates in hardware.
Is it really only a mono sound channel?
You will need to set the .buffer_bytes_min as well.


2)
static snd_pcm_uframes_t snd_aicapcm_pcm_pointer(snd_pcm_substream_t 
*substream)

{
	return readl(0xa0810004 + 4);
}

What sort of values should this return during playback?
Add a printk to log some of them.
The value should be in "frames" and not "bytes"
Use the ALSA function bytes_to_frames(runtime, value) to automatically 
do the adjustments from bytes to frames.
If the returned value is just period number, then you will have to 
multiply it up to the "frames" scale.
In case you missed it in the docs. "Frames" are units of samples 
equivalent to all the bytes needed to play one PCM sample in all channels.
E.g. 16 bit Stereo sound takes 4 bytes per sample for all channels. This 
equals 1 frame.
16 bit mono takes 2 bytes per sample for all channels. This equals 1 frame.


James



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
