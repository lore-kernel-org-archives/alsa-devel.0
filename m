From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Fast Track Ultra 8r...
Date: Thu, 10 Oct 2013 20:22:41 +0200
Message-ID: <CAFz=ag6SdfRTK_FNwWcwtUy2TPmq=nQNH8KEqMfSbbmZOi9PWw@mail.gmail.com>
References: <CAAsyid1UrqG=7zEL2QMz=q4NEKb6A3n8Wp5E4b3LPkr_GF3Q3g@mail.gmail.com>
 <CAFz=ag5aCshs6WJAksartBXfkUpocYEw5WknT=AStP0aFPo35g@mail.gmail.com>
 <CAAsyid35weXqn1amGKz2vEYDYBP6tHqTq1yBsWEUtCpx6iWF3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f48.google.com (mail-qe0-f48.google.com
 [209.85.128.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 11AA726171D
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 20:22:42 +0200 (CEST)
Received: by mail-qe0-f48.google.com with SMTP id d4so2257480qej.21
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 11:22:42 -0700 (PDT)
In-Reply-To: <CAAsyid35weXqn1amGKz2vEYDYBP6tHqTq1yBsWEUtCpx6iWF3A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Petri_J=E4rvisalo?= <petri.jarvisalo@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 10.10.2013 19:41 schrieb "Petri J=E4rvisalo" <petri.jarvisalo@gmail.com>:
>
> When plugging in the device at other OS, the internal routing for inputs
is disabled and software routes straight 1 =3D 1 to 8 =3D 8, like this, and
there is no effects applied.

Those defaults are the worst I can think of for *my* use case. That's why I
haven't implemented them. I do fully appreciate that those would be sane
defaults for many people. I wouldn't mind anyone implementing them in Alsa.
It's just, well, I won't ;-)

When I started working on the FTU mixer support I didn't think about the
defaults at all. The default we have right now are the ones you get without
explicitly specifying any.

But in fact, now I completely fell in love with these insane defaults: They
give me an instant alert that I haven't restored my personal 'right'
settings! That's of extreme value for my purposes as I use the device
mainly on live occasions and the 'wrong' settings certainly cannot go
unnoticed in the soundcheck.

So again, anybody interested is invited to implement new defaults for the
FTU. I won' t object any choice, how could I? But I won't do it myself
since I'm personally very happy with the current state.

Regards,
Felix
