From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] alsa-lib:Make snd_atomic_write_* truly
 atomic
Date: Tue, 17 May 2016 14:11:43 +0200
Message-ID: <alpine.DEB.2.02.1605171053010.31333@lnxricardw1.se.axis.com>
References: <570E2279.7060809@axis.com> <s5hwpo14o0n.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605121446220.31333@lnxricardw1.se.axis.com>
 <s5h37pnctrf.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605121556390.31333@lnxricardw1.se.axis.com>
 <s5hmvnvbafu.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605131426000.31333@lnxricardw1.se.axis.com>
 <s5hposq9lsi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id A1FCA2665FF
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 14:11:50 +0200 (CEST)
In-Reply-To: <s5hposq9lsi.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: =?ISO-8859-15?Q?Arvid_Nihlg=E5rd_Lindell?= <arvidnl@axis.com>, Andreas x Larsson <andrelan@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Fri, 13 May 2016, Takashi Iwai wrote:

> > > Yeah, that's why I stated the primary question.  The atomic operation
> > > there is mostly cosmetic, not really helpful.  In the whole other
> > > operation, we don't guarantee the thread safety at all.  So,
> > > implementing the atomic op only in a very small part of the whole code
> > > appears like a superfluous optimization to me.
> > =

> > The question is, if we decide to remove this atomic stuff, how do we =

> > verify that it actually causes no problems, on all architectures, etc?
> =

> It's not what one can show in 100%, as you know.  And, it's the reason
> why the code is still left over years...

We have come up upon this problem in conjunction with GStreamer. It =

appears that GStreamer uses one thread for the streaming and a separate =

one for the device management (open/close) on the same device handle, =

which triggers the problem. So it appears that GStreamer falsly is =

assuming some form of thread safety here.

The atomic stuff is so specific to a couple of files, it seems as if it =

was added for a specific purpose, such as this particular case. In the =

other hand, looking at the git history of include/iatomic.h, it's gone =

through a number of cleanups over the years, lately mostly to remove =

originally buggy code, and what is remaining I guess like you say is just =

what nobody dared remove.

On the other hand, as the code stands, I can't really understand how it =

enforces atomicity. The read and write memory barriers just guarantee =

ordering, but there's nothing to stop a context switch from occurring in =

the middle of a ++ operation. wmb() and rmb() might influence timing =

though so that code at least might behave differently with those =

operations in place.

> IMO, we just need to make a clear statement about the thread safety of
> alsa-lib.  For a single threaded op, it can't give any regression, of
> course.

Just removing the memory barriers should have absolutely no effect in the =

single threaded case I would have thought, especially since there are no =

I/O or other hardware related things (such as DMA descriptors) being poked =

at.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
