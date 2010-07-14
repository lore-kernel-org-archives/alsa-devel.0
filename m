From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Wed, 14 Jul 2010 20:23:21 +0800
Message-ID: <AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
	<1279071115.29042.0.camel@localhost.localdomain>
	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>
	<1279074303.29042.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 76D06243E3
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 14:23:23 +0200 (CEST)
Received: by vws9 with SMTP id 9so7158820vws.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2010 05:23:21 -0700 (PDT)
In-Reply-To: <1279074303.29042.3.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/14 Chris <cpollock@embarqmail.com>

> On Wed, 2010-07-14 at 10:09 +0800, Raymond Yau wrote:
> >
> >
>
> >
> >         > You need to provide a full pulseaudio log and a test case
> >         which can
> >         > reproduce your problem
> >         >
> >         > open a new terminal
> >         >
> >         > pulseaudio -k ; pulseaudio -vvvvv
> >
> >         Where should I post this Raymond?
> >
> >
> >
> > AFAIK , this mailing list has a limit of the message size
> >
> >
> > BTW ,
> >
> > did the program abort when you run alsa-time-test  and pipe the output
> > to "tail -n 500"
> >
> >
> >
> > http://thread.gmane.org/gmane.linux.alsa.devel/60371/focus=60520
> >
> > Beware that the program generate a log of output
>
> Raymond, I've ran bzip2 on the output of pulseaudio -k ; pulseaudio
> -vvvvv and it went from 129k to 9k. Should I fwd to you or post on the
> list?
>
> --
>

  appl_ptr is also behind the hw_ptr in 0.9.21-0.1mdv2010.0

https://qa.mandriva.com/show_bug.cgi?id=56473#c15

Apr 12 15:21:43 localhost pulseaudio[13701]: alsa-util.c: appl_ptr :

28465776
Apr 12 15:21:43 localhost pulseaudio[13701]: alsa-util.c:   hw_ptr       :
28555040

and also appl_ptr is also behind the hw_ptr for snd_via82xx

https://qa.mandriva.com/show_bug.cgi?id=56473#c0


Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   appl_ptr     :
767919576
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   hw_ptr       :
767990616
