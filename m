From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Fri, 10 Dec 2004 02:35:48 +0100
Message-ID: <20041210023548.5042f406@mango.fruits.de>
References: <20041209180706.GA11397@elte.hu>
	<200412091819.iB9IJiLX013123@localhost.localdomain>
	<20041209183342.GB13132@elte.hu>
	<20041209220741.7562b6a0@mango.fruits.de>
	<1102626628.21688.11.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1102626628.21688.11.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 09 Dec 2004 16:10:28 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2004-12-09 at 22:07 +0100, Florian Schmidt wrote:
> > On Thu, 9 Dec 2004 19:33:42 +0100
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > cleanest would be to somehow make this part of ALSA, just like xrun info
> > > is part of ALSA (the two are related as well). But there are other
> > > details too i guess: a single audio device can have separate interrupts
> > > (for playback and capture?) - in that case which one should ALSA return?
> > 
> > Well, possibly ALSA could keep the timestamps for each substream around?
> > And the ioctl should get parametrized with the substream # so it returns
> > the most current irq timestamp for the selected substream.
> > 
> 
> Doesn't ALSA already do this?  IIRC when you call snd_pcm_period_elapsed
> in the ALSA irq handler the PCM stream is timestamped.

To what kind of timestamp do you refer here? We need a timestamp
relative to a clock that jackd can use, too. Like for example TSC or
RTC. 

Just to give a rundown on the subject to the alsa-devel people. On
jackit-devel we are currently faced with the problem of estimating the
times at which the irq's for the soundcard were actually raised [to be
able to map arbitrary other times to the framecount of the frame
actually sounding at that moment]. For this we timestamp the time that
jackd is actually woken and try to estimate the real irq time from that.

Of course a much better estimate can be achieved if the scheduling
latencies which might occur between raising the IRQ and waking jackd are
eliminated. The earliest place such a timestamp can be taken is in the
top half irq handler.

So it would be very useful, if, for example, the top half irq handler of
the alsa driver would timestamp each IRQ with i.e. a TSC timestamp and
expose this timestamp to the application in userspace.

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
