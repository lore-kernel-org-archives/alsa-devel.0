From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Fri, 2 Apr 2010 06:52:04 +0800
Message-ID: <x2n4f3252891004011552zdc717255if563e5a4e5b29036@mail.gmail.com>
References: <hm5aba$p65$1@dough.gmane.org>
	<1267193154.29204.0.camel@localhost.localdomain>
	<4f3252891002271729p6eb66724v62ce97ea9a6eb577@mail.gmail.com>
	<hohr62$f78$1@dough.gmane.org>
	<4f3252891003280552y29015aeav7b68e9972371325b@mail.gmail.com>
	<hooi7i$fd4$1@dough.gmane.org>
	<4f3252891003281810r38e61306w83ebfe9ad2b8c69f@mail.gmail.com>
	<hopn7r$cul$1@dough.gmane.org>
	<z2i4f3252891004010705h8dfe2f71q20de60626a9b8941@mail.gmail.com>
	<hp34j2$fn6$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f178.google.com (mail-pz0-f178.google.com
	[209.85.222.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 527181038B4
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Apr 2010 00:52:37 +0200 (CEST)
Received: by pzk8 with SMTP id 8so136pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 01 Apr 2010 15:52:35 -0700 (PDT)
In-Reply-To: <hp34j2$fn6$1@dough.gmane.org>
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

2010/4/2 Angel Tsankov <fn42551@fmi.uni-sofia.bg>

> .
> >
> > As you can see the driver has 79 controls but only 48 controls saved in
> the
> > asound.state
> >
> > that is why "alsactl restore" become "alsactl init"
> >
> >
> > !!Amixer output
> > !!-------------
> >
> > !!-------Mixer controls for card 0 [YMF724F]
> >
> > Card hw:0 'YMF724F'/'Yamaha DS-1 (YMF724F) at 0xfb000000, irq 5'
> >   Mixer name    : 'SigmaTel STAC9700,83,84'
> >   Components    : 'AC97a:83847600'
> >   Controls      : 79
> >   Simple ctrls  : 31
>
> My question was why 'alsactl restore' restores the sound card and
> 'alsactl restore 1' just initializes the card.
>
> Angel Tsankov
>

you have to find out the value of doit

1443         /* check if we have additional controls in driver */
1444         /* in this case we should go through init procedure */
1445         if (!doit && maxnumid >= 0) {


http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=05f78cc6811110156c701fd9a2a5d15de8b4b1c7;hp=6232f1c96cde1fee247e95cd97235c48cc7b168d
