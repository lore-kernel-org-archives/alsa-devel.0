From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: Fast Track Ultra 8r...
Date: Fri, 11 Oct 2013 10:26:43 +1100
Message-ID: <CACckToX5rsEKJ2wadR5TepdjkfoOqNV8W9AyBwnhu3rCJ2p9zQ@mail.gmail.com>
References: <CAAsyid1UrqG=7zEL2QMz=q4NEKb6A3n8Wp5E4b3LPkr_GF3Q3g@mail.gmail.com>
 <CAFz=ag5aCshs6WJAksartBXfkUpocYEw5WknT=AStP0aFPo35g@mail.gmail.com>
 <CAAsyid35weXqn1amGKz2vEYDYBP6tHqTq1yBsWEUtCpx6iWF3A@mail.gmail.com>
 <CAFz=ag6SdfRTK_FNwWcwtUy2TPmq=nQNH8KEqMfSbbmZOi9PWw@mail.gmail.com>
 <CAAsyid18JgtFpG1pxSz6wkcZ=u7Ojej4B3ywqDWJJ7P1ijQonQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 492F52655D9
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 01:26:45 +0200 (CEST)
Received: by mail-pd0-f170.google.com with SMTP id x10so3365408pdj.1
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 16:26:44 -0700 (PDT)
In-Reply-To: <CAAsyid18JgtFpG1pxSz6wkcZ=u7Ojej4B3ywqDWJJ7P1ijQonQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

I agree with petri but I'm already on the record as saying my preference
would be

softreturns -> outputs everything else muted no effects.

Petri the scripts are probably something I wrote (if it's a couple of
nested for loops of shell)

The bigger problem imho is that snd-usb-audio doesn't preserve alsa volumes
and I still don't understand the reasoning for this.


On Fri, Oct 11, 2013 at 8:55 AM, Petri J=E4rvisalo
<petri.jarvisalo@gmail.com>wrote:

> 2013/10/10 Felix Homann <linuxaudio@showlabor.de>
>
> >
> > Am 10.10.2013 19:41 schrieb "Petri J=E4rvisalo" <petri.jarvisalo@gmail.=
com
> >:
> >
> > >
> > > When plugging in the device at other OS, the internal routing for
> inputs
> > is disabled and software routes straight 1 =3D 1 to 8 =3D 8, like this,=
 and
> > there is no effects applied.
> >
> > Those defaults are the worst I can think of for *my* use case. That's w=
hy
> > I haven't implemented them. I do fully appreciate that those would be
> sane
> > defaults for many people. I wouldn't mind anyone implementing them in
> Alsa.
> > It's just, well, I won't ;-)
> >
> > When I started working on the FTU mixer support I didn't think about the
> > defaults at all. The default we have right now are the ones you get
> without
> > explicitly specifying any.
> >
> > But in fact, now I completely fell in love with these insane defaults:
> > They give me an instant alert that I haven't restored my personal 'righ=
t'
> > settings! That's of extreme value for my purposes as I use the device
> > mainly on live occasions and the 'wrong' settings certainly cannot go
> > unnoticed in the soundcheck.
> >
> > So again, anybody interested is invited to implement new defaults for t=
he
> > FTU. I won' t object any choice, how could I? But I won't do it myself
> > since I'm personally very happy with the current state.
> >
> > Regards,
> > Felix
> >
>
> So,
>
> the only option left for me is to ask if some kind person would patch and
> change the default settings, i think it would serve the majority of users
> and ease the usability :)
>
> Thanks,
> Petri
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
