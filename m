From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: problems writing pcm driver
Date: Wed, 22 Aug 2007 02:54:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0708220214470.30669@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0708201250360.30669@shell2.speakeasy.net>
	<s5hd4xhkytk.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0708210907460.30669@shell2.speakeasy.net>
	<s5hd4xgj5u3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.sea5.speakeasy.net (mail2.sea5.speakeasy.net
	[69.17.117.4]) by alsa0.perex.cz (Postfix) with ESMTP id 1BDCA103803
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 11:54:32 +0200 (CEST)
In-Reply-To: <s5hd4xgj5u3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Aug 2007, Takashi Iwai wrote:
> > On Tue, 21 Aug 2007, Takashi Iwai wrote:
> > > At Mon, 20 Aug 2007 13:47:48 -0700 (PDT),
> > > Trent Piepho wrote:
> > > > Atomicity:
> > > > trigger, pointer, and ack are atomic with respect to themselves.  e.g., two
> > > > copies of the trigger callback can't be running at the same time.  That much
> > > > is clear.  But are they atomic with respect to each other?  Can the trigger
> > > > callback run at the same time as the pointer callback?  How about the atomic
> > > > callbacks with respect to the non-atomic ones?  Can trigger run at the same
> > > > time as prepare?
> > >
> > > No, these callbacks are exclusive.  In principle, they are called with
> > > substream->lock spinlock already held by the PCM core, so they cannot
> > > be called at the same time as long as belonging to the same PCM
> > > substream instance.
> >
> > The driver writing howto says for hw_params, "is that this callback is
> > non-atomic (schedulable)."
> >
> > If it's non-atomic, that would mean to me that it can be called multiple
> > times at once, and at the same time as other callbacks.  But, you're saying
> > that's not the case?
>
> No, in that context, non-atomic means schedulable.  That is, the
> function can get scheduled safely.  It's outside the spinlock.

I see, it's not the normal definition of atomic:
http://en.wikipedia.org/wiki/Atomic_operations

I suggest something like "schedulable" or "process context".  When I see "X
is not atomic" I think that means I need to code the function to be
re-entrant.

> About the concurrent access: since the PCM substream instance is
> exclusive, all PCM callbacks are also basically exclusive.  Even open
> and close are already protected via mutex in PCM core.  Thus they
> cannot be called simultaneously for the same substream instance.  (For
> different substreams, they can be called.)

Speaking of open, does one need to worry about the same pcm device being
opened multiple times?  I see code in the open callback of the bt87x driver
and the cx88-alsa driver that checks if the chip has already been opened
using atomic bit ops.  I'm guessing this is correct the bt87x driver, which
has two substreams of which only one can be used at one time.  But in the
cx88-alsa driver, which has only one substream, it is unnecessary.

I've figured out one of my problems, and it looks like it's not my fault.

I tried running arecord piped to aplay, both using the ca0106 driver, and
it works ok.  Very few overruns.  So this operation with this buffer size
_can_ be done.
arecord -v -D hw:0,0 -f DAT --buffer-size=512 | aplay -D hw:0,1 --buffer-size=512

So, I do the same thing with the device I'm working on, running arecord on
hw:1,0, but it doesn't work so well!  It's ok for a minute or two, but then
I start getting a lot of overruns.  I thought it was my driver, but then I
noticed something.

Once the overruns start, they were consistently about 3.5 seconds apart.
If I increased the arecord buffer size to 1024, they were 7 seconds apart,
at 2048 they were 13 seconds apart.

When I recorded and played back using the ca0106 card, both the ADC and DAC
were probably using the same master clock signal and the rates were locked.
But the other card was using a different clock and must have been producing
data faster than the ca0106 would play it.  After a while the pipe buffer
would fill up and arecord would block too long waiting for aplay to consume
its data, and there would be an overrun.  That empties the driver's pcm
buffer, but not the pipe between arecord and aplay.  So as soon as the pcm
buffer fills up, another overrun.  Each time the pcm buffer doubles in
size, it takes twice as long to fill up, and the time between overruns
doubles.
