From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Sat, 25 Sep 2010 09:25:48 +0800
Message-ID: <AANLkTimM9L=_Day945Y0XQZotLN7-HrXZbiWuO5dCO65@mail.gmail.com>
References: <4C595A52.7030401@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B0D101039BF
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Sep 2010 03:25:49 +0200 (CEST)
Received: by eye27 with SMTP id 27so904527eye.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2010 18:25:49 -0700 (PDT)
In-Reply-To: <4C595A52.7030401@gmx.de>
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

2010/8/4 Sebastian H. <vand2@gmx.de>

> Hello everyone
>
> I've been working on Alsamixer-Qt4 lately and compiled
> the changes into a new release version 0.4.0.
> Most importantly the cards list can be refreshed now
> and the style got a little overhaul, too.
> A more detailed changelog can be found at the xwmw.org page.
>
> The new version 0.4.0 is available at the known places.
> http://xwmw.org/alsamixer-qt4/
> http://sourceforge.net/projects/alsamixer-qt4/files/
>
> Any comments are welcome.
>
> Cheers,
> Sebastian
>

How about those inactive controls ? snd_mixer_selem_is_active()

e.g. for those motherboard with 3 audio jacks at the rear panel,  the pink
and blue jacks are retasked as output pins after turn the "Smart 5.1" switch
on , the controls of "Mic" and "Line-in" , "ceter/lfe" and "rear"  are
active/inactive
