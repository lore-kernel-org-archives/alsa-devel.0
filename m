From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Thu, 29 Jul 2010 21:38:33 +0800
Message-ID: <AANLkTi=Dwh9djHxapWrZZR4kEY4xRvtzViw14fHYMVaY@mail.gmail.com>
References: <4C22670D.8010104@epost.diwic.se> <s5h6319dj90.wl%tiwai@suse.de>
	<4C2487EA.3090605@epost.diwic.se> <s5hzky6bgy2.wl%tiwai@suse.de>
	<s5heifcsvom.wl%tiwai@suse.de>
	<AANLkTimnfft0c_V9bTK-g8hX2ljc_IJoMliMEwcQTz5g@mail.gmail.com>
	<s5hiq4or5cz.wl%tiwai@suse.de> <4C376182.5050807@epost.diwic.se>
	<AANLkTi=u2fbu-uu9vgEdp60bouAq=iHehMBzPWXAGjdE@mail.gmail.com>
	<4C51385E.7080102@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 943131039B7
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 15:38:34 +0200 (CEST)
Received: by vws20 with SMTP id 20so336583vws.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2010 06:38:33 -0700 (PDT)
In-Reply-To: <4C51385E.7080102@canonical.com>
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

2010/7/29 David Henningsson <david.henningsson@canonical.com>

> 2010-07-29 09:11, Raymond Yau skrev:
> > 2010/7/10 David Henningsson <launchpad.web@epost.diwic.se>
> >>> The biggest drawback by this change is that whether the sound goes
> >>> well or not isn't reported any more to the application layer.
> >>> It's an unfortunate design, but it's life with PA.
> >>
> >> The question is - is there an application that detects the underrun
> >> condition and actually acts on that condition? If so, this could be a
> >> regression for that app. For other apps it's an improvement, for the
> >> reasons originally stated.
> >>
> >>
> > This patch by Lennart Poettering should answer your question
> >
> >
> http://git.alsa-project.org/?p=alsa-plugins.git;a=commit;h=660e0f16145167a966e9b8387e9a8e08274a8f7c
>
> Okay, so we've broken XMMS, at least the 2007 version of it?
>
> The better solution to this problem would be to add a write_pointer to
> the xrun callback (and PA's native protocol), so we can detect whether
> the underrun is obsolete or not and act accordingly.
>
>
when using xmms  libao plugin in mandriva 2010 , xmms freeze at the end of
the playback
