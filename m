From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] alsa-lib:Make snd_atomic_write_* truly
 atomic
Date: Thu, 12 May 2016 14:51:07 +0200
Message-ID: <alpine.DEB.2.02.1605121446220.31333@lnxricardw1.se.axis.com>
References: <570E2279.7060809@axis.com> <s5hwpo14o0n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id EE96C26707A
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 14:51:14 +0200 (CEST)
In-Reply-To: <s5hwpo14o0n.wl-tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Andreas x Larsson <andrelan@axis.com>
List-Id: alsa-devel@alsa-project.org


On Wed, 13 Apr 2016, Takashi Iwai wrote:

> On Wed, 13 Apr 2016 12:42:01 +0200,
> Andreas x Larsson wrote:
> > =

> > Under some usecases a race condition appears inside
> > the snd_atomic_write_* functions. The 'begin' and 'end'
> > variables are updated with the ++ operator which is not
> > atomic but needs to be. This can be achieved with the
> > gcc atomic_* built-ins. Combined with __ATOMIC_SEQ_CST
> > as the memory model, memory barriers are introduced so
> > those can also be removed from the code.
> > =

> > Signed-off-by: Andreas x Larsson <andrelan@axis.com>
> > Signed-off-by: Arvid Nihlg=E5rd Lindell <arvidnl@axis.com>
> =

> Isn't this dependent on gcc version?

Do you mean that the problem is dependent on gcc version, or the solution? =

If the problem only occurs with certain gcc versions, but the _atomic_* =

functions are the proper solution in all cases, then I would think that is =

the way to go.

> And, if we use the gcc atomic operation, the whole macros should be =

> rewritten in another way -- or consider to drop the whole. It's only =

> partly used in pcm_rate.c and pcm_plugin.c in anyway.

Do you mean that the inline functions should be replaced with
#define macros, or that they should be omitted entirely and the resulting =

code be integrated into the relevant places in the .c files?

/Ricard

> =

> > ---
> >   alsa-lib/include/iatomic.h | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > =

> > diff --git a/alsa-lib/include/iatomic.h b/alsa-lib/include/iatomic.h
> > index acdd3e2..7fafe20 100644
> > --- a/alsa-lib/include/iatomic.h
> > +++ b/alsa-lib/include/iatomic.h
> > @@ -140,14 +140,12 @@ static __inline__ void =

> > snd_atomic_write_init(snd_atomic_write_t *w)
> > =

> >   static __inline__ void snd_atomic_write_begin(snd_atomic_write_t *w)
> >   {
> > -   w->begin++;
> > -   wmb();
> > +   __atomic_add_fetch(&w->begin, 1,__ATOMIC_SEQ_CST);
> >   }
> > =

> >   static __inline__ void snd_atomic_write_end(snd_atomic_write_t *w)
> >   {
> > -   wmb();
> > -   w->end++;
> > +   __atomic_add_fetch(&w->end, 1, __ATOMIC_SEQ_CST);
> >   }
> > =

> >   static __inline__ void snd_atomic_read_init(snd_atomic_read_t *r, =

> > snd_atomic_write_t *w)
> > -- =

> > 2.1.4
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =


-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
