From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 09:20:46 +0200
Message-ID: <20070918092046.f52e8877.krzysztof.h1@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
	<20070917234739.a674bf7b.krzysztof.h1@gmail.com>
	<Pine.LNX.4.58.0709171522360.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 8096124460
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 09:13:25 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so2495852mue
	for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2007 00:13:24 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0709171522360.27377@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, devel <alsa-devel@alsa-project.org>, Rene@alsa-project.org, Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Sep 2007 18:18:27 -0700 (PDT)
Trent Piepho <xyzzy@speakeasy.org> wrote:


> It looks like one needs to have the lock to access (read or write) any of
> the "indirect" registers.  For example, in order to read from
> AD1848_TEST_INIT, one must first write the index into the REGSEL register,
> then read from the REG register.  If another thread tried to concurrently
> read or write a different indirect register, it would modify the index.
> 

Right.

> >
> > No, the loop never had the 250ms delay. The whole loop (all iterations) was 250ms delay.
> 
> That's what I said.  It obviously didn't have a 250 ms delay, or open()
> would take four minutes.  Note that the delay was not 250 ms total either,
> it would loop forever until ACI went down.
> 
> for(time = 250; time > 0 ; ) time = schedule_timeout(time);
> 
> Unless you set the task state first, that line is an infinite busy loop.
> 

This may be not true. If you compare schedule_timeout() with cpu_relax()
you will see that schedule_timeout() is slower. I am not expert on this,
but I think that the schedule_timeout() switches tasks and returns
which is not busy waiting (like userland sleep(0) function does).
It would make it close to the cpu_relax().

 This could be original intention of Jeff Garzik's change.

> > > I looked at the ad1848 datasheet, and it says the auto-calibration should take
> > > about 384 samples (or ~128, which I think is the time it takes ACI to go low
> > > when auto-calibration is not on).  That would be 70 ms at the high end and
> > > typically more like 3 ms.
> >
> > The smallest value for ad1848 is over 7ms (from experiments).
> > It is about 384 samples at 48kHz.
> 
> You said before that it took 3 jiffies on a 1000 Hz kernel.  I guess
> auto-calibration is always on when MCE goes down?  It looks like it should
> only take 128 samples when MCE goes down and auto-calibration isn't done.
> 

It was for CS4231 chip which is faster. On the CS4231 it is 3 jiffies. You confused
these two chips here.

> snd_ad1848_in() already calls snd_ad1848_wait(), so it seems like it
> would be redundant.
> 

The whole waiting for the busy bit is redundant because any next operation (in or out)
will wait for it anyway.

> Obviously from a latency point of view the optimal value would be to poll
> as fast as possible.  Which is the worst from an efficiency point of view.

No, you can poll at maximum speed and call cpu_relax() after each poll.
This will provide the least latency with little overhead. It is probably
overkill if waiting is in the range 7 to 70 ms (it will be thousand of polls).

> So you make a trade off.  If 90% of the time it's done by 2.9 ms, then
> waiting 3 ms means you have very little extra latency 90% of the time and
> only poll once 90% of the time.
> 

The waiting of 3ms does not mean that you do it 90% of time. It depends
on frequency so if someone plays 44kHz files (which gives delay above 3ms) it will
be penalized by additional 2ms (6ms instead of 4ms) of latency 100% of time.

> > The whole point of sleep before loop is to make this first iteration outside the loop
> > so it is not obscured by any special condition.
> 
> I'm well aware of that.  By delaying first, then checking, it's no longer
> necessary to have an extra delay before the loop.

The original idea was to make this first waiting longer than loop granularity.
7ms before the loop than 1ms granularity inside the loop.
Rene Herman was against it so he changed it to be the same as 1ms inside
the loop.

Regards,
Krzysztof
