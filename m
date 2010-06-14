From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 16:38:00 +0800
Message-ID: <AANLkTinsZ8RqxYpOrGBBOAFlyP86OdIvJK-Lle5BZv5G@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ED635103811
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 10:38:01 +0200 (CEST)
Received: by vws8 with SMTP id 8so420056vws.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 01:38:01 -0700 (PDT)
In-Reply-To: <hv4pfi$gqr$3@dough.gmane.org>
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

2010/6/14 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 14/06/10 01:25 did gyre and gimble:
> > if your sound card have ac97 codec ., you can use audacity to record the
> > output from hw:0,0 and you will see clipping occur when you set "PCM"
> volume
> > above 0dB
>
> So the standard response is "don't do that then" :)
>
> That's why the base volume is shown to the user via GUIs so that they
> can gauge the best point on the slider to use. Currently there is no
> indication with alsa sliders at which point the 0dB "sweet spot" lies.
>
> IMO this is a good improvement for usability.
>
> Col
>
>
This is bug in pulseaudio in dB calculation because it shift the ALSA 's dB
value to PA 's own dB value

I guess none of PA developers has AC97 sound card
