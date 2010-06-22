From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Tue, 22 Jun 2010 23:29:08 +0800
Message-ID: <AANLkTilwbCSM7rPLUlAKtTUv1UepbHzvyZTh4CsElOJm@mail.gmail.com>
References: <htls4d$phr$1@dough.gmane.org> <4BFE7840.4070004@ladisch.de>
	<htm0et$eb4$1@dough.gmane.org> <htm9mn$n1c$1@dough.gmane.org>
	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>
	<huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
	<20100613135349.GB5818@tango.0pointer.de>
	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>
	<hv4pfi$gqr$3@dough.gmane.org>
	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>
	<hv4vs6$a6q$1@dough.gmane.org>
	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>
	<AANLkTimxTM73el7iCE6nwUJMPFpYa0dY2R9SYxa3_j6N@mail.gmail.com>
	<hv5dkf$tv8$1@dough.gmane.org>
	<AANLkTim5rmjxS6YV7j3QEXSW-EyUv2rsT3k2ZzOz-o9o@mail.gmail.com>
	<hvput5$a6o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6DBC7245AA
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 17:52:05 +0200 (CEST)
Received: by vws12 with SMTP id 12so50656vws.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2010 08:52:04 -0700 (PDT)
In-Reply-To: <hvput5$a6o$1@dough.gmane.org>
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

2010/6/22 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 22/06/10 03:31 did gyre and gimble:
> > 2010/6/14 Colin Guthrie <gmane@colin.guthr.ie>
> >> I've made this change on my system and while previously my UI had no
> >> "Base Volume" displayed (because all my "h/w" (I include softvol in
> >> that) controls had their dB value >0.
> >>
> >
> > as your card has no h/w gain,  > 0dB , but the gain in softvol plugin is
> a
> > software gain (i.e. in the red region in PA "s volume scale
> >
> > how can base_volume display in gnome volume control (unamplified) ?
> >
> > BTW ,  -46.5dB to 0dB of softvol plugin is software atten ( not h/w atten
> )
>
> As I said above, anything that comes from alsa is considered h/w
> amplification for the purposes of PA's volume scale. It's not practical
> to differentiate them


Software gain is different from hardware gain.

Clipping due to software gain +12dB cannot compensated by -12dB by hardware
atten


.
>
> Does any card actually configure softvol, by default, to provide any
> gain, > 0dB for outputs? If so, then this is IMO a bad idea.
>


-51dB to 0dB is also software atten of softvol plugin

if PA did not want to differeniate hardware/software gain/atten
Just  set this softvol PCM to 0dB and use PA 's own software gain/atten or
don't use front device for HDA
