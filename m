From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: How do I perform non-DMA transfers in an interrupt
 handler?
Date: Fri, 21 Mar 2003 13:31:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303211328090.2699-100000@pnote.perex-int.cz>
References: <3E7AFEFE.50901@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E7AFEFE.50901@student.kuleuven.ac.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 21 Mar 2003, Pieter Palmers wrote:

> Hi all,
> 
> I face the following problem: The card I'm writing a driver for (SAM9707
> based) doesn't support any form of DMA transfer. It requires you to
> transfer the PCM data through a 'rep outsw' like mechanism. It raises an
> interrupt when it needs new data. The transfer flow is as follows:
>      1) allocate buffer on card
>      2) start playback
>      3) card raises interrupt
>      4) transfer block of data in interrupt handler
>      5) wait for next interrupt -> 4
> 
> How do I implement this in ALSA? After reading the 'Writing an ALSA
> driver' document a few times, I still cannot figure out how to do this.
> Should I use the copy/silence callbacks? Or can I access the PCM buffer
> from within the interrupt handler? I'm currently using 'concept' code
> from Uros Bizjak, and the interrupt handler looks like this:
> 
> (I removed irrelevant pieces)
> 
>      substream = voice->substream;
>      runtime = substream->runtime;
> 
>      hwoff = runtime->hw_ptr_interrupt;
> 
>      hwbuf = (u16 *) runtime->dma_area;
>             hwbuf += (frames_to_bytes(runtime, hwoff) >> 1);
> 
>      /* word transfer count */
>      wcount = snd_pcm_lib_period_bytes(substream);
>      wcount >>= 1;
> 
>      /* transfer to/from sam9407 buffers */
>      if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>          sam->writeData16Burst(sam, hwbuf, wcount);
>      else
>          sam->readData16Burst(sam, hwbuf, wcount);
> 
>      snd_sam9407_command(sam, NULL, SAM_END_XFER,
>              &voice->channel, 1, NULL, 0, -1);
> 
>      /* update hardware pointer mirror */
>      voice->hwptr = runtime->hw_ptr_interrupt + runtime->period_size;
> 
>      snd_pcm_period_elapsed(substream);
> 
> But I'm not sure if this is correct.
> 
> What should I use here?
> Is there a card driver that I can refer to that uses the same mechanism?

This code is ok. It might use probably a little bit better interrupt 
resolution to sync the DMA ring buffer with hardware more precisely (I 
mean use the transfer size in interrupt less than the period size).

You don't need to use extra copy and silence when the DMA ring buffer has 
not a special sample order (something other than interleaved and 
non-interleaved).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
