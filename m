From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: How do I perform non-DMA transfers in an interrupt
 handler?
Date: Fri, 21 Mar 2003 13:53:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E7B0B58.8010900@student.kuleuven.ac.be>
References: <Pine.LNX.4.44.0303211328090.2699-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

>On Fri, 21 Mar 2003, Pieter Palmers wrote:
>
>  
>
>>Hi all,
>>
>>I face the following problem: The card I'm writing a driver for (SAM9707
>>based) doesn't support any form of DMA transfer. It requires you to
>>transfer the PCM data through a 'rep outsw' like mechanism. It raises an
>>interrupt when it needs new data. The transfer flow is as follows:
>>     1) allocate buffer on card
>>     2) start playback
>>     3) card raises interrupt
>>     4) transfer block of data in interrupt handler
>>     5) wait for next interrupt -> 4
>>
>>How do I implement this in ALSA? After reading the 'Writing an ALSA
>>driver' document a few times, I still cannot figure out how to do this.
>>Should I use the copy/silence callbacks? Or can I access the PCM buffer
>>from within the interrupt handler? I'm currently using 'concept' code
>>from Uros Bizjak, and the interrupt handler looks like this:
>>
>>(I removed irrelevant pieces)
>>
>>     substream = voice->substream;
>>     runtime = substream->runtime;
>>
>>     hwoff = runtime->hw_ptr_interrupt;
>>
>>     hwbuf = (u16 *) runtime->dma_area;
>>            hwbuf += (frames_to_bytes(runtime, hwoff) >> 1);
>>
>>     /* word transfer count */
>>     wcount = snd_pcm_lib_period_bytes(substream);
>>     wcount >>= 1;
>>
>>     /* transfer to/from sam9407 buffers */
>>     if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>         sam->writeData16Burst(sam, hwbuf, wcount);
>>     else
>>         sam->readData16Burst(sam, hwbuf, wcount);
>>
>>     snd_sam9407_command(sam, NULL, SAM_END_XFER,
>>             &voice->channel, 1, NULL, 0, -1);
>>
>>     /* update hardware pointer mirror */
>>     voice->hwptr = runtime->hw_ptr_interrupt + runtime->period_size;
>>
>>     snd_pcm_period_elapsed(substream);
>>
>>But I'm not sure if this is correct.
>>
>>What should I use here?
>>Is there a card driver that I can refer to that uses the same mechanism?
>>    
>>
>
>This code is ok. It might use probably a little bit better interrupt 
>resolution to sync the DMA ring buffer with hardware more precisely (I 
>mean use the transfer size in interrupt less than the period size).
>
Currently I'm trying to get it working. Later on I'll optimize the 
transfers, but the SAM is a pretty strange chip.
Maybe you have some suggestions on how to implement this...

This is a piece of my conversation with Gerd Rausch, the OSS driver 
developer for the SAM based cards:

|        Pieter> Let me rephrase the question: if I end a transfer with 
an END_XFER
|        Pieter> command after e.g. 1024 words, will the firmware raise 
another interrupt
|        Pieter> to retrieve the next block of data? Or am I supposed to 
transfer blocks
|        Pieter> of 8192 words at once?
|
|    I ran a few tests today, with a result you might not appreciate:
|    I tried to figure out how picky the firmware is about the correct
|    amount of data transferred.
|    And the result I've got was:
|    It is very picky !
|    You need to allocate exactly the number of words you are intending to
|    transfer plus the additional magic 16 words overhead.
|    Then, with each interrupt incoming, you need to finish the transfer
|    with exactly one END_XFER and wait for the next interrupt.
|    Every other combination you listed did not work.

The background on this is that you allocate a buffer of e.g. 8192 words 
on the card. You then open the channel and start playback. The card then 
raises interrupts when it needs data. The question presented above is 
how much data is to be transfered each time the SAM raises interrupt.

I currently fixed the driver parameters like this:
    static snd_pcm_hardware_t snd_sam9407_playback =
    {
        (...)
        .buffer_bytes_max =    SAM_MAX_BUFFER_SIZE << 1,
        .period_bytes_min =    ((SAM_MAX_BUFFER_SIZE) << 1),
        .period_bytes_max =    ((SAM_MAX_BUFFER_SIZE) << 1),
        (...)
    };
in an attempt to get things working.

The documentation on the card & its firmware is very incomplete (almost 
absent) and all knowledge is obtained by Trial&Error(TM) and reverse 
engineering windows drivers. So my first priority is getting ANY output 
from the card. In a next step I'll try and optimize it.

>
>You don't need to use extra copy and silence when the DMA ring buffer has 
>not a special sample order (something other than interleaved and 
>non-interleaved).
>
>  
>
OK

Thanks!

Pieter





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
