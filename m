From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Tue, 8 Jun 2010 12:01:52 +0800
Message-ID: <AANLkTil4q611GLiV-k1vO2Svepg_kioyUypp2rWNslxR@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
	<hp744t$5b5$1@dough.gmane.org>
	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>
	<hqbv5m$cmf$1@dough.gmane.org>
	<g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>
	<hqmbmm$hsj$1@dough.gmane.org>
	<i2r4f3252891004211816ldfedff21nfe61537043c9b22f@mail.gmail.com>
	<htls4d$phr$1@dough.gmane.org> <4BFE7840.4070004@ladisch.de>
	<htm0et$eb4$1@dough.gmane.org> <htm9mn$n1c$1@dough.gmane.org>
	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>
	<huicj9$t30$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 08B8A1037FC
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 06:08:29 +0200 (CEST)
Received: by pxi3 with SMTP id 3so1671410pxi.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2010 21:08:28 -0700 (PDT)
In-Reply-To: <huicj9$t30$1@dough.gmane.org>
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

2010/6/7 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 06/06/10 01:12 did gyre and gimble:
> > 2010/5/28 Colin Guthrie <gmane@colin.guthr.ie>
> >
> >> 'Twas brillig, and Colin Guthrie at 27/05/10 15:43 did gyre and gimble:
> >>> PA should play nice with the softvol plugin so I don't think this is
> the
> >>> bit that is at fault.
> >>>
> >>> I strongly suspect that the reason has already been correctly
> identified
> >>> a while ago, which is that this card considers -48dB silent where as PA
> >>> assumes this level is -200dB. I believe it was Raymond who pointed out
> >>> the -48dB level in the HDA spec before on this list.
> >>>
> >>
> >
> > if  floating point 0.0 is -inf dB , and 1.0 is 0dB ,
> >
> > 0.5 is -6dB , 0.25 is -12 dB , 0.125 is -24dB and 0.0625 is -48dB
>
> This is just a pure mapping from dB->linear, but as this linear mapping
> is generally not "natural" there are several different approaches to
> presenting this to users. In PA, a cubic mapping is used on top of this
> basic conversion, to map to the percentage scale (0.0 to 1.0 if you like).
>
> So I'm not sure what point you're making by providing these numbers. Can
> you explain?
>
> > how can PA master volume control at 10~15% equivalent to HDA 's -48dB ?
>
> Not sure what you mean here, but I suspect it's the cubic mapping that
> is confusing you.
>

>> FWIW, I've got the same/similar h/w with a cutoff at 14% in PA as you
have.

According to your email , you mention than your hardware has a cutoff at 14%
in PA

the mixer application programmer  can select any kind of scaling in the
slider

do you mean 14% in pavucontrol or Master volume control of "pulse" device ?

but pavucontrol did not provide any dB value at any point
