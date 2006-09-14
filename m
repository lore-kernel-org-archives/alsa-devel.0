From: "Takashi Iwai" <tiwai@novell.com>
Subject: Re: Driver design question
Date: Thu, 14 Sep 2006 12:29:04 +0100
Message-ID: <45095921020000C80000961F@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

>>> Lee Revell <rlrevell@joe-job.com> 09/12/06 10:27 PM >>>
> I have a device here that can play PCM, but it's a weird implementation.
> Only 2 periods of 0x2000 words per buffer are supported, and there is no
> DMA - the driver must poll a status register, and when the chip is
> ready, deliver all 0x2000 words using outw() then send an end xfer
> command.
> 
> I think I need to use an intermediate buffer, and implement copy/silence
> callbacks that write to this.  Then I plan to use a tasklet or workqueue
> to do the actual xfer of PCM data to the hardware.  A timer callback
> will periodically check whether at least 0x2000 words are in the buffer
> and if so, schedule the tasklet to drain it.

You can implement it in two ways, at least.

One is to use copy and silent callbacks.  This is pretty straightforward,
doesn't need extra buffer, but it cannot use the native mmap.  (alsa-lib
provides the mmap emulation mode, but it seems not so stable.)
Also, the buffer and period sizes are very restricitve (in your case, 0x2000
x 2 words), so many apps might not work well.
An exampleof this type is isa/sb/emu8000_pcm.c (and some of gus pcm,
IIRC).

Another is to use an intermediate buffer as you suggsted.
In this case, you do _not_ need copy and silent callbacks.  These callbacks
are the operations to copy and silent the hardware buffers.  WIth an
intermediate buffer, the copy and silent are done on this buffer, i.e. on
normal RAM.  What you need instead is the background-running copy
operation from this intermediate buffer to the hardware via outw.

This copy task could be done in the interrupt handler (or timer in your case)
if it's minimum.  If not, it'd be better to take a workq since it can sleep and
much preemptive.

> I presume this implementation cannot support mmap() as there's no random
> access to the hardware buffer.  Is this correct?

Mmap works in practice.  The driver simply shares the intermediate
buffer with user-space.

> Do I call snd_pcm_period_elapsed() from the timer, immediately before
> scheduling the tasklet, or from the tasklet, after the data has been
> transferred to the hw?

Yes, by calling snd_pcm_period_elapsed(), the actual hwptr is updated.
Then schedule workq to run copy-task from the buffer to h/w for the
appropriate size.  

> In general, does this seem like a reasonable implementation?

I don't see other possibilities.


BTW, I'll be less communicative (and don't read MLs) for a while until
the next Tuesday since I'm in a conference.


Takashi

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
