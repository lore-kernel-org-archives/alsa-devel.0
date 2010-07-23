From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Fri, 23 Jul 2010 19:51:04 +0800
Message-ID: <AANLkTikEBSvGFdRPSq+YxRWHfxMWx_5LBxAALAUaMicQ@mail.gmail.com>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTildhplqQxzk7mBMc5IW_3bwAVDDrRe5UDpJXIS6@mail.gmail.com>
	<4C3DD271.6040003@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8286F1039C5
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 13:51:06 +0200 (CEST)
Received: by vws20 with SMTP id 20so128223vws.38
	for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2010 04:51:04 -0700 (PDT)
In-Reply-To: <4C3DD271.6040003@epost.diwic.se>
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

2010/7/14 David Henningsson <launchpad.web@epost.diwic.se>

> 2010-07-14 13:13, Raymond Yau skrev:
>
> > localhost pulseaudio[24553]: alsa-util.c:   appl_ptr     : 735801008
> > localhost pulseaudio[24553]: alsa-util.c:   hw_ptr       : 735846184
> >
> > This is underrun as you can see appl_ptr is behing hw_ptr
>
> Ehm, isn't that a ring buffer? I e, there is nothing wrong with appl_ptr
> being less than hw_ptr.
>
> > However PA server had disabled the underrun detection.
>
> Please clarify. If you're talking about my patch (disable underruns in
> alsa-plugins) here, it has nothing to do with this situation (PA
> complaining about its back-end).
>
> The situation above probably isn't even an underrun.
>


The other possible reason may be PA did not handle clock drifting properly

how did PA calculate the sleeping time using 44100 or 1445100000/32768 ? ,

ens1371 's clock is running faster than the system clock

localhost pulseaudio[24553]: alsa-util.c:   rate         : 44100
localhost pulseaudio[24553]: alsa-util.c:   exact rate   : 44101
(1445100000/32768)
