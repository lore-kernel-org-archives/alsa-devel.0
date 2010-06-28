From: David Dillow <dave@thedillows.org>
Subject: Re: [PATCH] ALSA: pcm_lib: avoid timing jitter in
 snd_pcm_read/write()
Date: Mon, 28 Jun 2010 01:21:31 -0400
Message-ID: <1277702491.2438.173.camel@obelisk.thedillows.org>
References: <1277590400.2438.15.camel@obelisk.thedillows.org>
	<AANLkTil91moJgRh51QFgvSFd47MzQxzxty1H2RzKK5nF@mail.gmail.com>
	<1277648967.2438.32.camel@obelisk.thedillows.org>
	<alpine.LNX.2.00.1006271942500.15497@eeebox2.perex-int.cz>
	<1277678773.2438.103.camel@obelisk.thedillows.org>
	<AANLkTimO0L-JL3zVg_ZzU7kWK6ez0CwwlR839K_X7MGz@mail.gmail.com>
	<1277690630.2438.149.camel@obelisk.thedillows.org>
	<AANLkTillC6b8uGRt9GFyq81M9KNxEneeTsdU6b6UfaSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amavis-smtp.knology.net (amavis-smtp.knology.net [75.76.199.6])
	by alsa0.perex.cz (Postfix) with ESMTP id A20F310389A
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 07:21:36 +0200 (CEST)
In-Reply-To: <AANLkTillC6b8uGRt9GFyq81M9KNxEneeTsdU6b6UfaSw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-06-28 at 11:13 +0800, Raymond Yau wrote:
> 2010/6/28 David Dillow <dave@thedillows.org>

> On Mon, 2010-06-28 at 08:37 +0800, Raymond Yau wrote:
> > 2010/6/28 David Dillow <dave@thedillows.org>
> > > Perhaps documentation that recommends setting avail_min to 1 when using
> > > read/write to avoid this issue would be helpful, in lieu of changing the
> > > ALSA code or giving concrete guarantees.

> > Refer to
> >
> http://article.gmane.org/gmane.linux.alsa.devel/69333/match=avail_min
> >
> > avail_min cannot be less than period size , however set_avail_min() di not
> > return any error when the value is less than period size and this mislead
> > the programmers to believe that they can set avail_min to 1
>         
>         
> >They used to be able to, and it would work. You likely cannot get
> >latency that low, but anyone that was expecting for that to magically
> >change the way hardware works is fooling themselves. avail_min is like
> >the timeout argument to poll() -- you're guaranteed at least that value,
> >but you may get something much larger.
>         
> >I understand the rationale given for patch b0b7d0 to alsa-lib, but
> >limiting avail_min in this way removed a workaround for the muddled
> >snd_pcm_read/write() semantics. I suppose it is still possible, if
> >someone wants to color outside libasound -- the kernel still allows it.

> it is unlikely to set avail_min or minimum period size to a value less
> than the PCI brust size if your driver are using DMA  transfer

Raymond, you seem to have missed the part where I said that setting
avail_min to 1 is not going to magically change the way hardware works.
Of course it will not get you wakeup latencies lower than the size of
the DMA transfer; heck, it won't get you wake up latencies lower than a
period size, should read/write have to sleep!

However, setting it to 1 was useful in that it said to wake up as soon
as possible. Possible in this case means as soon as the next period has
elapsed, which may be quite a bit longer than 1 sample. It is quite like
the example I gave of poll() -- giving a timeout of 1ms to poll() on a
machine with HZ=100 used to mean that you get at least a 10ms timeout.
Even with NOHZ, HPET timers. and HZ=1000 today, you have no guarantee
that your process is at the head of the run queue. You may not even get
scheduled to run for several seconds on a busy system.
