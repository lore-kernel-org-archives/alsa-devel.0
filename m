From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hardware channel mixing
Date: Sun, 05 Sep 2004 14:39:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094409562.4445.22.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
	 <1094260793.3727.19.camel@localhost>
	 <1094340528.6575.527.camel@krustophenia.net>
	 <1094353379.2044.86.camel@localhost>
	 <1094360766.6575.636.camel@krustophenia.net>
	 <1094407924.1989.32.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094407924.1989.32.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2004-09-05 at 14:12, Manuel Jander wrote:
> Hi Lee,
> 
> On Sun, 2004-09-05 at 01:06, Lee Revell wrote:
> > On Sat, 2004-09-04 at 23:02, Manuel Jander wrote:
> > > Hi Lee,
> > > 
> > > On Sat, 2004-09-04 at 19:28, Lee Revell wrote:
> > > > On Fri, 2004-09-03 at 21:19, Manuel Jander wrote:
> > > > > Hi,
> > > > > 
> > > > > [snip]
> > > > It certainly can, works great for capture.  I can record 8 channels at
> > > > 32 frames, it works perfectly.  I suspect I could record more but
> > > > there's some kind of mixer settings bug.
> > > 
> > > Using one single DMA channel ?
> > > 
> > 
> > Yes.  Although, this is a unique feature of the FX8010 capture device. 
> > For capture there is only a single DMA channel for the FX8010 and you
> > set bits in a hardware register to select which of the the 64 FX8010
> > outputs you want to record.  The hardware imposes some sanity, there is
> > a fixed table of allowed buffer sizes, and the number of channels record
> > must be a power of two.
> > 
> > The playback hardware does not work this way.  You can only do one mono
> > PCM stream per DMA channel.  My proposal would still use one DMA channel
> > per mono PCM, but where the driver currently will only allocate voices
> > one or two at a time (which is two or three with the extra voice), this
> > would use 17 voices - 16 "data channels" and the "control channel" aka
> > the extra voice.
> 
> That sounds completely reasonable.
> 

I should add that this is not my idea, Jaroslav suggested it a while
back.  But I agree that this smells like an incomplete hardware spec. 
There are some world-class reverse engineers on this list... ;-)

> > > > > . I
> > > > > think more than 4 or 6 interleaved channels per DMA is not very sane.
> > > > 
> > > > Why?  It's more efficient than handling them in chunks of 4.  This would
> > > > be intended for use by the sound server, in this case jackd; you would
> > > > launch jackd with an 8 channel input and 8 channel output device,
> > > > corresponding to the analog ins and outs on the hardware.  With 16 or 32
> > > > channels the rest are just FX buses.  And this all lives in hardware.
> > > 
> > > No need to handle them in chunks of specifically 4. But using more than
> > > one single DMA channel to relieve the CPU. If not, it would be better
> > > using programmed I/O instead of DMA.
> > > 
> > 
> > I am not sure I understand.  How would it tax the CPU more heavily?  You
> > end up doing more work at each interrupt, but you have fewer interrupts.
> 
> If the IRQ's are fired at a lower rate (fewer IRQ per time unit), you
> will have less processing overhead at the cost of higher latency.
> Handling a period elapsed event takes CPU time. If there are fewer of
> those events, or fewer channels packed into each period that means more
> time for each period. Unfortunately we are limited by a maximal period
> size of only 4KiB on x86's. Making them bigger is out of question.
> Its a matter of tradeoff between how many IRQ you can handle per second
> and how low you want the latency to be.
> 
> I did some calculation, which yield that with 64 channels, 4KiB of
> period size at 44100Hz 16bits would trigger one IRQ each 725us approx.
> That is not that bad after all. On low end machine maybe this could
> cause xruns, but i guess that trying it out would give a definite
> answer.

The FX8010 is fixed at 48000Hz so it's one irq every 666 usecs.  This is
rock solid on my 600Mhz C3 with Ingo's latest VP patches, I cannot
produce an xrun no matter how I punish the machine.

I don't think that the machine breaks a sweat from an irq every 666
usecs, the timer interrupt fires every 1000, and there's very little
work to be done in the interrupt handler assuming you use mmap().  I
think a too low period size is bad due to cache thrashing, andthere's no
point in using a latency too low to be perceptible, but the more
frequent interrupts do not seem to bother it at all.  Right now I am
trying to determine the physical limits of the hardware, I will worry
about what is practical later ;-).

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
