From: Matthew Foster <matt@breakcode.com>
Subject: Re: Qustions on dmix - aplay - hw_ptr - appl_ptr
Date: Sun, 22 Apr 2007 21:06:35 -0700
Message-ID: <001e01c7855c$ca01f5c0$5e05e140$@com>
References: <000601c78113$87ffabb0$97ff0310$@com>
	<s5habx5hlrf.wl%tiwai@suse.de>
Reply-To: matt@breakcode.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C0768243B6
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 06:07:12 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a25so1217816pyi
	for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2007 21:07:11 -0700 (PDT)
In-Reply-To: <s5habx5hlrf.wl%tiwai@suse.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ok I am just tracking the hw_ptr and I keep track of the last value of the
hw_ptr and transfer the difference between the two. 

I also solved another problem where I wasn't waiting for my device buffer to
drain in the open callback. In my open callback I was querying my device
buffer to set the max_buf_size variable and if I didn't wait for the
previous data to transfer out it would report the wrong value. 

However I am still stumped on a problem where if the file size aplay tries
to play is smaller than our buffer (64KB) it randomly plays sometimes and
randomly there is silence. If I modify the file to be at least 64KB it plays
fine. Here is my HW params setup:

  Runtime->hw.buffer_bytes_max = (1024 *64); //The size of our non-HW buffer
  runtime->hw.period_bytes_min = runtime->hw.buffer_bytes_max/2;
  runtime->hw.period_bytes_max = runtime->hw.buffer_bytes_max/2;
  runtime->hw.periods_min = 2;
  runtime->hw.periods_max = 2;

I have tried playing around the these values to only get unpredictable
playback results. Sometimes playback would sound all messed up or corrupted.
Perhaps I don't understand how these values are used. Also if I run aplay
over and over fast enough with these smaller clips I can prevent the driver
from ever calling the close callback function and this results in only
hearing part of this clip sometimes and silence for the majority of the time
I keep trying to run aplay quickly over and over. 

Is there any way for me to avoid this un-predictable behavior with these
smaller clips? I am leaning towards a setup issue or something but I am
definitely stumped. Any help on this would be GREATLY appreciated. Thanks so
much!

Matthew Foster


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Wednesday, April 18, 2007 6:10 AM
To: matt@breakcode.com
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Qustions on dmix - aplay - hw_ptr - appl_ptr

At Tue, 17 Apr 2007 10:12:07 -0700,
Matthew Foster wrote:
> 
> I am a driver developer that is new to ALSA. I have read the tutorial as
an
> example on how to write an ALSA driver. I appreciate the documentation you
> have provided online. I was wondering if you might have time to possibly
> answer a question. I am having trouble understanding things in the
> memory/buffer management area. 
> 
>  I am not writing a driver for a PCI device, I am writing a driver that
acts
> as an interface from the ALSA to a render device. So I essentially have a
> circular buffer I am transferring the ALSA data to.  I set up the ALSA
> buffer like this:
> 
> snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
> snd_dma_continuous_data(GFP_KERNEL),
> ALSA_BUF_SIZE, ALSA_BUF_SIZE)) < 0);
> 
> And later on in my driver after open is called I have a buffer polling
loop
> that does the period notification and constantly monitors my render
(ouput)
> buffer. I have my asound.conf setup like this:
> 
>     pcm.mix {
>         type dmix
>         ipc_key 1024
>         slave {
>         pcm "hw:0,0"
>             rate 48000
>         }
>     }
> 
>     pcm.!default {
>         type plug
>         slave.pcm "mix"
>     }
> 
> This is to enable the dmix plugin so I can run aplay more than once and
have
> the two streams mixed in.  
> 
> The problem I am having is that it seems that when I run aplay like this:
> "aplay close.wav" I only see this pointer moving:
> 
> substream->runtime->status->hw_ptrbir
> 
> And if I run aplay like this: "aplay -D plughw:0,0 close.wav" I only see
> this pointer moving:
> 
> substream->runtime->control->appl_ptr
> 
> This seems odd to me and currently in my code I just check which pointer
> moves and use that to calculate how much data I need to write to my render
> device. This is so I can support both use cases.

The behavior of dmix is somehow special.  It mmaps a buffer to
multiple instances and runs continuously without XRUN check as long as
clients are connected.  Dmix assumes the driver running a la DMA.
That is, hw_ptr can be constantly updated in a ring buffer.  Since it
disables the XRUN check by adjusting stop_threshold, appl_ptr is
meaningless here. 

Thus, for supporting dmix on your device, you may need to ignore
appl_ptr and simply transfer the period-size chunk at each time.

Currently, the support of non-DMA style hardwares is poor on ALSA,
which I'd like to improve in near future.  At least, we should provide
a proper framework.

> Another major problem is that when I play a short wav file 25KB or so and
> use the dmix "aplay close.wav" it randomly doesn't play at sometimes. Also
> if I run "aplay close.wav" and then very quickly run "aplay close.wav"
again
> at the same prompt I get corruption of the data which produces screeching.
> In the case where I run aplay one right after the other I notice that the
> hw_ptr moves differently (less) than if I run it, wait, run again. 

Possibly depending on the behavior above?

> I am also noticing also that when I do the aplay over and over quickly
that
> these values change (get lower) in my snd_pcm_prepare callback:
> 
>   chip_data->buf_size        = snd_pcm_lib_buffer_bytes(substream);
> 
>   chip_data->period_buf_size = snd_pcm_lib_period_bytes(substream);
> 
> It seems like those value should remain constant, and I use those values
to
> calculate later in my polling thread to notify of a period lapse. It's
> almost like the runtime is telling me the period has changed and the
buffer
> size has changed. But this only happens in this case with a short wav file
> and running aplay over and over quickly. 

This sounds odd.  Do you call snd_pcm_lib_malloc() in hw_params
callback? 


Takashi
