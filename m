From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: snd_pcsp locking mess
Date: Thu, 21 Aug 2008 12:06:07 +0400
Message-ID: <48AD21EF.8010906@aknet.ru>
References: <20080518172258.D0DFB108060@picon.linux-foundation.org>	<4830737B.70108@aknet.ru>	<s5hve1ac05g.wl%tiwai@suse.de>	<4831B260.1060802@aknet.ru>	<s5hhccrx2ey.wl%tiwai@suse.de>	<4835D774.3070306@aknet.ru>	<s5hprrduwdk.wl%tiwai@suse.de>	<483C10E7.7070203@aknet.ru>
	<s5h4p8jbvaj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C8172445F
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 10:04:54 +0200 (CEST)
In-Reply-To: <s5h4p8jbvaj.wl%tiwai@suse.de>
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

Hello.

Takashi Iwai wrote:
> Maybe codes tell better than words.  The below is my untested patch.
I finally got around to have a
look at the patch and gave it
some testing.
I think it is the best solution
for what we currently have, but
I see a few simplifications to
it if some simple changes to the
alsa core are done.

1. We can have only one sync point
instead of many, and that should
be the stop callback. It is not
possible right now because the stop
callback can be asynchronous. This
can be solved by providing the separate
callback to be called from snd_pcm_period_elapsed().
I already proposed this a few years
ago and made a patch, but it was
rejected in favour of the current
excessive locking we have in pcsp.
But now as we are at simplifying
it, I wonder if that idea can be
re-evaluated. Note that the change
was not intrusive at all. The new
callback was optional. If it is
not provided, then the old logic
applies.

2.
>>> +/*
>>> > > + * Force to stop and sync the stream
>>> > > + */
>>> > > +void pcsp_sync_stop(struct snd_pcsp *chip)
>>> > > +{
>>> > > +	local_irq_disable();
>> > So what will happen if the timer callback
>> > is executing on another CPU at that point?
> That doesn't matter, because this irqsave is needed just for
> i8253_lock in pcsp_stop_playing() (as it doesn't save irq).
local_irq_disable() can be avoided
as well by introducing the separate
async stop callback.

3. The AB/BA locking can be avoided
without the use of the softirq I think.
Right now snd_pcm_period_elapsed()
takes the pcm_stream_lock() because
it calls the stop callback which needs
that lock. But, having the separate
stop callback, snd_pcm_period_elapsed()
may probably just take some other lock
for its internal needs, and take the
pcm_stream_lock() only if the separate
stop callback is not provided.

The above changes look fairly simple,
and I even had the patch for 1 already.
The changes to snd-pcsp will became
much simpler with them I beleive.
And having the possibility to provide
a separate callback for the IRQ context
looks like the really must-have thing
to me from the very beginning. I even
remember the old OSS callbacks which
were passed the flag to indicate whether
or not they are called from an IRQ
context. I prefer the separate callback
to the flag, but in alsa there is currently
neither.
