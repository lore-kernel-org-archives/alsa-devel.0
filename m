From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Sat, 20 Mar 2010 15:58:03 +0800
Message-ID: <4f3252891003200058t2dd77c8an581382eb298a2ccf@mail.gmail.com>
References: <4B7A5268.5050704@ladisch.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<ad2655cb1002170355n7d2df930ha6cf036b6e00218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DA7610380C
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 08:58:06 +0100 (CET)
Received: by pwj7 with SMTP id 7so2584983pwj.38
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 00:58:04 -0700 (PDT)
In-Reply-To: <ad2655cb1002170355n7d2df930ha6cf036b6e00218@mail.gmail.com>
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

2010/2/17 James Courtier-Dutton <james.dutton@gmail.com>

> On 16 February 2010 23:56, Lennart Poettering <mznyfn@0pointer.de> wrote:
> >
> > The reason I was asking how Jaroslav chose the 0dB position for his
> > measurements was purely because I wanted to do my own measurements for
> > that Aureon card. The dbmeasure tool I wrote for stuff like that puts
> > 0dB at max amplification, however Jaroslav didn't, so I was wondering
> > how he chose 0dB then.
> >
> > Lennart
> >
>
> I think the digital side is clear. So I will not go into that.
>

The problem is at the digital side , The range between -inf dB and -48dB /
-96dB software atten is lost during the conversion of the floating format
format to S16_LE or S32_LE ( native format supported by hardware driver )

i.e. the bottom part of the pulseaudio volume control cannot be used
