From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2.6.38.4 broke my audio
Date: Tue, 26 Apr 2011 21:06:31 +0800
Message-ID: <BANLkTinwFL3NQq4GxsUhxeRyRtwpPPtU=A@mail.gmail.com>
References: <20110424113037.11af0b04@omega.digital-domain.net>
	<20110425000126.GA18681@suse.de> <s5htydmhed2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2A14324492
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 15:06:32 +0200 (CEST)
Received: by fxm5 with SMTP id 5so458657fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2011 06:06:31 -0700 (PDT)
In-Reply-To: <s5htydmhed2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/25 Takashi Iwai <tiwai@suse.de>

> At Sun, 24 Apr 2011 17:01:26 -0700,
> Greg KH wrote:
> >
> > On Sun, Apr 24, 2011 at 11:30:37AM +0100, Andrew Clayton wrote:
> > > Hi guys.
> > >
> > > Just upgraded to .4 from .3 and found my audio was _really_ quiet. All
> > > the mixers looked sane.
> > >
> > > A quick check of the changelog and a revert of:
> > >
> > > commit 58541cc27531727f7120683a7cb123ee3ada4bd4
> > > Author: Takashi Iwai <tiwai@suse.de>
> > > Date:   Mon Mar 28 12:05:31 2011 +0200
> > >
> > >     ALSA: hda - Fix pin-config of Gigabyte mobo
> > >
> > >     commit c6b358748e19ce7e230b0926ac42696bc485a562 upstream.
> > >
> > >     Use pin-fix instead of the static quirk for Gigabyte mobos
> 1458:a002.
> > >
> > >     Bugzilla: https://bugzilla.novell.com/show_bug.cgi?id=677256
> > >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > >     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > >
> > > made it normal again.
> >
> > Takashi, do you have a fix for this, or should I revert this from the
> > .38 stable tree?  It looks like we now have 2 reports of this problem.
>
> If we need to revert, I'll do it in the upstream first, as it must hit
> to 2.6.39, too.
>
> But let me check this breakage first.  I'll take a look at it more
> deeply tomorrow.
>
>
It seem this patch also affect gigabyte ma78lmt-us2h motherboard with 6
audio jacks

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5346


M61PME-S2, G41M-ES2L and GA-880GM-D2H are motherboard with 3 audio jacks at
rear panel

motherboard with 3 audio jack should try model=3stack-6ch or 3stack-6ch-dig
to create a "channel mode" to retask blue and pink jack as outputs

For alc8xx  may need to extend channel mode from "2, 6" to "2,6,8"  to
support 8 channel with HP at front panel as "side speaker out" and the three
audio jacks are rear panel
