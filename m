From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Sat, 29 May 2010 11:54:27 +0800
Message-ID: <AANLkTilAwpOpYll92uUEqbEdCRtvv0a7So5LVxgUFReV@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
	<201005210951.36495.peter.ujfalusi@nokia.com>
	<4BF658C6.4030404@ladisch.de>
	<AANLkTikXWtp87B0Gq_B-vQZXZlBl_MEBqbuHt6N5cTbi@mail.gmail.com>
	<4BFB8C89.3010207@ladisch.de>
	<AANLkTimNj_7k_l7nKLk87towdjtN5j0CSdmws02gpg8v@mail.gmail.com>
	<AANLkTim4sq_jBHYvxnLk2Pw5bdUDEMJahHPBJGIXH8ds@mail.gmail.com>
	<htls8t$phr$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C17632446A
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 05:54:28 +0200 (CEST)
Received: by pxi3 with SMTP id 3so871805pxi.38
	for <alsa-devel@alsa-project.org>; Fri, 28 May 2010 20:54:27 -0700 (PDT)
In-Reply-To: <htls8t$phr$2@dough.gmane.org>
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

2010/5/27 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 26/05/10 00:24 did gyre and gimble:
> > only one of the PA developer complain about his HDA codec has incorrect
> dB
> > range but not willing to provide alsa-info.sh
>
> I presume you mean me :) I had a hunt through the many mails you sent on
> the previous thread and found such a request I'd obviously missed the
> first time round. Sorry about that. Not unwilling, just unaware.
>
> I've attached the output to a reply in the other thread.
>
> > There is a patch which may affect the dB scale
> >
> >
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=7c7767ebe2fa847c91a0dd5551ca422aba359473;hp=29fdbec2dcb1ce364812778271056aa9516ff3ed
>
> Interesting. I wonder if this ties in time wise of when I noticed this
> working..... If I find time to play, I'll maybe try reverting this to
> see if it helps.
>
> Col
>
> --
>

seem not related to your problem

But anyone know why expose -96dB large volume scale can result in  in too
large scale in percentage representation. ?

since 96dB is the theortical dynamic range of CD audio
