From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Migration from 0.5 to 0.9?
Date: Mon, 08 Apr 2002 16:10:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CB1B2ED.5030103@superbug.demon.co.uk>
References: <1017927701.1777.12.camel@lel1.sthlm.i3micro.se> <s5hd6xame8v.wl@alsa2.suse.de>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.93])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA02185
	for <alsa-devel@alsa-project.org>; Mon, 8 Apr 2002 17:11:18 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Leif Lindholm <leif.lindholm@i3micro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At 04 Apr 2002 15:41:36 +0200,
>Leif Lindholm wrote:
>
>>Hello
>>
>>I'm working on a set-top-box based on the National Semiconductor SC1200
>>Geode integrated microprocessor.
>>
>>National have been nice enough to write an Alsa-driver for the built-in
>>AC97-controller/audio thingy - unfortunetaly it is written for 0.5.10b.
>>
>>So now I need to modify this one to use with 0.9.
>>
>>Can someone give me a few tips/hints or is there possibly a document
>>about this that I failed to google up?
>>
>
>unfortunatley (as always :) there is no documentation about the kernel
>stuff yet.
>since you have already a working 0.5.x driver, it's not too difficult,
>though. 
>
>as far as i can remember..
>
>- renaming
>
>	fragment -> period
>	channel -> stream
>	voice -> channel
>	snd_pcm_subchannel -> snd_pcm_substream
>
>- renaming of constants
>
>	generally:
>		SND_XXX -> SNDRV_XXX
>
>	some other changes, too: e.g.
>		SND_PCM_TRIGGER_GO -> SNDDRV_PCM_TRIGGER_START
>
>- snd_assert() is used instead of snd_debug_check()
>  (note that the argument is opposite, assert(x) means that "x" is true .)
>
>- no longer difference of stream/blocking modes
>
>- general hardware information is stored in snd_pcm_hardware_t
>  and passed to the runtime struct in open().
>  the information is intuitive, look at other sources.
>
>- abstracted ops.
>
>	open(substream)
>		- open the device
>		- copy the substream->runtime->hw parameter
>		  (not pass the pointer)
>		- set up the constraints (if any)
>
>	hw_params(substream, hw_params)
>		- allocate a buffer
>		  usually via snd_pcm_lib_malloc_pages
>
>	prepare(substream)
>		- set up the hardware parameters (like 0.5.x)
>
>		  note that parameters in runtime struct are
>		  stored in frames, not in bytes.
>		  there are functions, snd_pcm_lib_buffer_bytes()
>		  and snd_pcm_lib_period_bytes()
>
>	trigger(substream, cmd)
>		- start, stop, pause (like 0.5.x)
>
>	pointer(substream)
>		- returns the current pointer where the hw refers.
>		  (in frames!)
>
>	hw_free(substream)
>		- free the buffer
>		  usually via snd_pcm_lib_free_pages(substream)
>
>	close(substream)
>		- close the device, clean up.
>
>	copy, silence
>		- needed only if you don't (can't) use mmap.
>
>  they are defiend in snd_pcm_ops_t struct and set up in
>  pcm initizliation routine via snd_pcm_set_ops().
>
>- when the interrupt occurs at period (fragment), call
>
>	snd_pcm_period_elapsed(substream)
>
>  just once per interrupt.
>
>- no longer snd-xxx functions for allocating port, dma and irqs.
>  you need to use standard functions.
>  for releasing struct resources *, you have to use kfree_nocheck()
>  to avoid malloc-wrapper.
>
>- definitions of pci id table, probe(), remove() (suspend() and
>  remove() if possible) on struct pci_driver.
>  
>- finally and best way - look at drivers on a same chip of both 0.5.x
>  and 0.9.0, and compare them :)
>
>
>
>Takashi
>
This is a very good start at some documentation!

In case Leif does not understand the concept of a frame, here is what I 
understand by it.

Audio stream is 16 bit samples, 2 channels = 4 bytes (2 bytes of each 
sample, and 2 channel=2*2) = 1 frame
Audio stream is 16 bit samples, 6 channels = 12 bytes = 1 frame
Audio stream is 8 bit samples, 2 channels = 2 bytes = 1 frame

So, no matter what the sample bits, or number of channels, there is 
always 1 frame.
If the stream is 48000 Hz, it will contain 48000 frames.
If the stream is 44100 Hz, it will contain 44100 frames.

If the stream is 48000 Hz, 16 bit samples, 6 channels 5.1(surround) 
audio, it will contain 48000 frames.

Hopefully, by these examples, you get an idea of what a frame is.

Cheers
James
