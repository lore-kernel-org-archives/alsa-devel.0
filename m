From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Thu, 10 Sep 2009 16:47:14 +0800
Message-ID: <4f3252890909100147y3712b3c6h3fa7425645b6f8f1@mail.gmail.com>
References: <s5hbplmssrg.wl%tiwai@suse.de>
	<a080dbc80909080046p73207442ld8f6577ebbf37ba9@mail.gmail.com>
	<s5hws49rf58.wl%tiwai@suse.de> <s5hpra01is7.wl%tiwai@suse.de>
	<a080dbc80909090529w3e958f27g38d8238836e415e2@mail.gmail.com>
	<s5hk5081ekp.wl%tiwai@suse.de>
	<20090909140735.GC14530@tango.0pointer.de>
	<s5h63bs19yc.wl%tiwai@suse.de>
	<20090909142717.GE14530@tango.0pointer.de>
	<s5hy6ooyyir.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f174.google.com (mail-px0-f174.google.com
	[209.85.216.174])
	by alsa0.perex.cz (Postfix) with ESMTP id D91BB24579
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Sep 2009 10:47:15 +0200 (CEST)
Received: by pxi4 with SMTP id 4so589794pxi.23
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2009 01:47:14 -0700 (PDT)
In-Reply-To: <s5hy6ooyyir.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is "one period per buffer" really work ?

There are quite a few drivers which has "periods_min = 1"  (e.g. emu10k1,
intel8x0, .....

however aplay did not like this

"Can't use period equal to buffer size (%lu == %lu)")"




2009/9/9 Takashi Iwai <tiwai@suse.de>

> At Wed, 9 Sep 2009 16:27:17 +0200,
> Lennart Poettering wrote:
> >
> > On Wed, 09.09.09 16:14, Takashi Iwai (tiwai@suse.de) wrote:
> >
> > > > > > I can confirm now that Audacious does indeed play correctly where
> it
> > > > > > didn't before. However, using mplayer with the "-ao openal"
> switch
> > > > > > still doesn't play correctly - in fact, it sounds the same as
> before -
> > > > > > so it looks like OpenAL is actually doing things slightly
> differently
> > > > > > than I thought. :/
> > > > >
> > > > > Yes, likely.  The app like openal is usually more sensible
> regarding
> > > > > latency, so "safe API" described there wasn't appropriate at all.
> > > >
> > > > Hmm, so are you suggesting I should change that little text about the
> > > > safe API subset I wrote?
> > >
> > > Maybe a bit more addition would be helpful.  The realtime apps do
> > > care the latency.  So, obviously it's not the target of your
> > > description.
> >
> > What I wrote is actually this:
> >
> >     "Do not touch buffering/period metrics unless you have specific
> >     latency needs. Develop defensively, handling correctly the case
> >     when the backend cannot fulfill your buffering metrics requests. Be
> >     aware that the buffering metrics of the playback buffer only
> >     indirectly influence the overall latency in many cases. i.e. setting
> >     the buffer size to a fixed value might actually result in practical
> >     latencies that are much higher."
> >
> > i.e. it already says "... unless you have specific latency needs". The
> > point of this is that RT apps should of course set the buffer size,
> > however stuff like media players where the latency does not matter at
> > all should not request artificially low latencies and thus decrease
> > battery time needlessly.
>
> Well, basically this belongs to the implementation detail.
> Unless you have a solid RT kernel, the latency can't be guaranteed.
> The old good way to achieve the smooth playback is to use the large
> buffer with the small periods.  Then you have a better chance to be
> woken up before buffer underruns.  That's how the ALSA default setup
> is done, even with the latest version.
>
> Of course, in this scenario, the battery life wasn't taken into
> account.  If you care the battery life, too, the simplest solution is
> to have two periods in the largest buffer size.  But, this doesn't fit
> with every programming model, too (imagine an old app that don't do
> multi-threading :)
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
