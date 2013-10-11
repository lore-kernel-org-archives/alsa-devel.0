From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Fast Track Ultra 8r...
Date: Fri, 11 Oct 2013 06:52:54 +0200
Message-ID: <CAFz=ag7HWDmpwOhXmm2cgazyE8omDECMmhF47ncVY6XvXWRcQA@mail.gmail.com>
References: <CAAsyid1UrqG=7zEL2QMz=q4NEKb6A3n8Wp5E4b3LPkr_GF3Q3g@mail.gmail.com>
 <CAFz=ag5aCshs6WJAksartBXfkUpocYEw5WknT=AStP0aFPo35g@mail.gmail.com>
 <CAAsyid35weXqn1amGKz2vEYDYBP6tHqTq1yBsWEUtCpx6iWF3A@mail.gmail.com>
 <CAFz=ag6SdfRTK_FNwWcwtUy2TPmq=nQNH8KEqMfSbbmZOi9PWw@mail.gmail.com>
 <CAAsyid18JgtFpG1pxSz6wkcZ=u7Ojej4B3ywqDWJJ7P1ijQonQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f42.google.com (mail-qe0-f42.google.com
 [209.85.128.42])
 by alsa0.perex.cz (Postfix) with ESMTP id E44DB2619F9
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 06:52:55 +0200 (CEST)
Received: by mail-qe0-f42.google.com with SMTP id gc15so2951641qeb.29
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 21:52:54 -0700 (PDT)
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
To: =?ISO-8859-1?Q?Petri_J=E4rvisalo?= <petri.jarvisalo@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am 10.10.2013 23:55 schrieb "Petri J=E4rvisalo" <petri.jarvisalo@gmail.com>:
>
> So,
>
> the only option left for me is to ask if some kind person would patch and
change the default settings, i think it would serve the majority of users
and ease the usability :)

Actually there are two more options:

1. Do it yourself! I really mean it: I had never done anything kernel
related before, I didn't know how all this was working. I dived into the
code because I needed the device to be working and seemingly there wasn't
anyone else who wanted to work on the mixer :-)
2. As mentioned in my first reply, I would consider implementing a 'all
muted' default if we found a consensus on it. I couldn't promise to do it
soon though because of too much work with much higher priority. Grant,
Aurelien, what do you think? It's probably at least better than the current
situation.
