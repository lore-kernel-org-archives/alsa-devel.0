From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Fw: writing audiowerk driver (philips saa7146a), some questions
Date: Fri, 31 May 2002 14:05:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003201c208a3$d8e06030$0400a8c0@martijn>
References: <001801c2088f$71693120$0400a8c0@martijn> <s5hg008h829.wl@alsa2.suse.de>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >  - should i use the normal double buffered aproach or does having
> >  more than 2 buffers have advantages?
>
> most of pci drivers use a linear contigous buffer for pcm (per
> stream).
> the scatter-gather buffer is not supported yet on alsa (as a mid/high
> level layer -- it would be possible if you write all on the low-level
> layer).
> the buffer is accessed directly via mmap as long as it's supported.
>
>
> >  - what is normally called the latency of an audio interface for output?
> >  is this the total size of the buffers or (in the case of double
buffered
> > io)
> >  only one buffer? i'm thinking it is the total buffer size and this
would
> >  make using more than 2 buffers have a better latency/interrupt response
> >  time ratio, right?
>
> but if you have double buffer, isn't it difficult to handle mmap?
> also i don't think double-buffer (that i'm not sure whether you mean
> here "period" in the sense of alsa, or really double-buffering as in
> graphics) leads to better latency.  of course my guess may be wrong.

i did not mean two buffers actually, perhaps the alsa term is period? with
double buffering i meant having the saa7146 interrupt at half buffer.

the saa7146 uses a single contiguous buffer, optionally using an mmu (so
then the buffer is not actually contiguous in physical memory).

thus, having more than two periods is advantageous?

> >  - should setting the buffer size and number be done on modules loading
> >  or should it be possible to change it after that? the saa7146 doesn't
need
> >  contiguous memory since it has a mmu.
>
> the buffer size and numbers are specified by each application.
> at set-up stage, an application and driver commnucate with each other
> to find the preferable condition.  the driver answers the hardware
> restriction to the application which inquires the condition.
> then the hardware is "prepared" actually, by calling prepare
> callback.
>
> in most cases, the hardawre restriction (condition) can be described
> in snd_pcm_hardware_t struct, which is passed to the runtime instance
> at open callback.  the struct contains most of important conditions,
> such as supported formats, rates, channels, max buffers, etc.
> also, you can define more complicated conditions, if necessary.
>

so if the application can set the buffer at set-up stage, it is best to
allocate
buffer memory at that time?

> >  - does alsa allow varipitch? i think the new rme cards are supposed to
> >  have this feature and the audiowerk8 has it, i.e. it can change its
> > sampling
> >  rate from about 37700 to 58200 hz while running in 1hz increments.
> >  this allows for sync to video/tape/midi or whatever. or it allows for
the
> >  sample rate to be adjusted when receiving audio using rtp.
>
> basically no (at least not tested).  but i think it's not too
> difficult to support it.  we can assign a control per pcm.
> you'll need to change runtime->rate dynamically according to the
> current rate, so that the tick interrupt handler calculates the time
> properly.

again, i am not (yet) familiar with alsa, so i am not sure what
runtime->rate is
or what you mean with the tick interrupt handler (where can i find
documentation
on this?), but i think 'pitch' is meant as a deviation from the nominal
sample rate
and setting a large deviation can be thought of as a bad dac/adc?

> >  - the audiowerk8 uses three dma channels: one for input and two for
output.
> >  should i just wake a process that is blocking on a read() from the
input
> > dma
> >  interrupt or should i wait until all three dma channels are ready and
then
> >  unblock all read()/write() processes? should unblocking the processes
be
> >  done
> >  from bottom half?
>
> it's a job of alsa's high-level layer.
> the lowlevel routines don't have to handle sleep()/wakeup().
> just call snd_pcm_period_elapsed() in the interrupts routine when the
> certain amount of samples have been processed.

is there any documentation on this?

--martijn




_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
