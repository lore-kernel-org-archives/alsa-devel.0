From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: open sound device from asound.conf
Date: Fri, 23 Jul 2010 19:30:59 +0800
Message-ID: <AANLkTikyPU61JgTsoDhhh3wwmq1Z3JqDxj5jurV9=Bm8@mail.gmail.com>
References: <201007231112.24764.p.lukac@emtest.sk> <4C49603D.4090807@gmx.de>
	<201007231143.21344.p.lukac@emtest.sk> <4C496B19.8020707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id DFD8B24502
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 13:31:00 +0200 (CEST)
Received: by vws20 with SMTP id 20so105640vws.38
	for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2010 04:30:59 -0700 (PDT)
In-Reply-To: <4C496B19.8020707@gmx.de>
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

2010/7/23 Sebastian H. <vand2@gmx.de>

> >>> I want open sound device from /etc/asound.conf with API
> >>> snd_pcm_open() but unsuccessfull. As name i'm used:
> >>
> >> Did you try to open "default", "output" or "dsp0" since these are the
> >> names of your pcm defines?
> >
> > thanks for reply...
> > Yes it works..(device is open) but i don't want open device with "hard
> coded"
> > name because this name can be changed..I want to use iterations
>
> I'm just a user but I guess you would have to parse the pcm subsection
> of the Alsa configuration tree with the snd_config_* functions.
>
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___config.html
>
> Sebastian
>
>
Use namehint , but your asoundrc must have correct syntax since the parser
is unable to know any spelling mistake

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4298

/usr/share/alsa/alsa.conf

# show all name hints also for definitions without hint {} section
defaults.namehint.showall off <---- on
# show just basic name hints
defaults.namehint.basic on
# show extended name hints
defaults.namehint.extended off <---- on
