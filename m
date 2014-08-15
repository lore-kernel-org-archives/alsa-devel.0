From: =?ISO-8859-1?Q?Jo=EBl_Kr=E4hemann?= <weedlight@gmail.com>
Subject: Re: Warning Big Yield
Date: Fri, 15 Aug 2014 20:48:45 +0200
Message-ID: <1408128525.4677.2.camel@debian>
References: <1408019626.6670.5.camel@debian> <53ECD987.5020608@ladisch.de>
 <53ED3F0C.70809@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 33F58265044
 for <alsa-devel@alsa-project.org>; Fri, 15 Aug 2014 20:48:53 +0200 (CEST)
Received: by mail-wg0-f50.google.com with SMTP id n12so2588363wgh.21
 for <alsa-devel@alsa-project.org>; Fri, 15 Aug 2014 11:48:52 -0700 (PDT)
In-Reply-To: <53ED3F0C.70809@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-08-15 at 08:58 +1000, Matt Flax wrote:
> On 15/08/14 01:45, Clemens Ladisch wrote:
> > Jo=EBl Kr=E4hemann wrote:
> >> I'd really like to know if there's a common way to do syncing
> >> applications. What frequencies are required to run a GUI?
> > GUIs should be event based; the term "frequency" is not applicable.
> >
> >> How does Xorg work
> > It's event based.
> =

> Yes, event based.
> For example, when using gtk ... if you want to update your GUI, you =

> probably want to use the gtk timer to regularly update at a rate which =

> suits your visual aesthetic.
> =

> You may already know this, but you can trigger a user function at =

> regular intervals :
> g_timeout_add
> https://developer.gnome.org/glib/2.37/glib-The-Main-Event-Loop.html
> =

> >> how can I prevent interfering with ALSA output?
> > By doing sound stuff in a separate thread with higher priority.
> You can do something similar to what Jack does to ensure higher =

> priority, check the file libjack/thread.c and look at the way they =

> increment the priority.
> =

> You may already know this, however in case not, you can get low =

> millisecond latency without dropping samples when using Linux ... i.e. =

> no interferance.
> That was last time I checked ... it is possible that this has improved =

> to a lower threshold since then !
> =

> Matt
> =

> >> Warning you may experience big yield.
> > ???
> >
> > Regards,
> > Clemens
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

I use 250 iterations of g_main_context_iteration() per second and
application uses 1000 iterations per second.

And Herz is definitely a frequency.

regards
Jo=EBl
