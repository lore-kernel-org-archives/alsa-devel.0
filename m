From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixertest
Date: Tue, 5 Oct 2010 09:50:09 +0800
Message-ID: <AANLkTikFPuevqTe7M=gVRfqhfB66-9Y473tNjohyJCdi@mail.gmail.com>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru> <i7qltg$bph$1@dough.gmane.org>
	<AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>
	<4CA306CB.1090305@canonical.com>
	<AANLkTi=h+ZKXNdhmC1BtTbBaGF6_V+uD2ZO7sx4WMJMW@mail.gmail.com>
	<4CA9877F.7060009@canonical.com> <4CA9C22A.2010104@ladisch.de>
	<4CA9C7BE.7020804@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 27D371038F2
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 03:50:10 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2378268ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Oct 2010 18:50:09 -0700 (PDT)
In-Reply-To: <4CA9C7BE.7020804@canonical.com>
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

2010/10/4 David Henningsson <david.henningsson@canonical.com>

> On 2010-10-04 14:01, Clemens Ladisch wrote:
> > David Henningsson wrote:
> >> On 2010-10-02 04:11, Raymond Yau wrote:
> >>> It seem that the program keep complain about those controls without dB
> scale
> >>> (e.g. AC97 3D Control - depth and rear depth , .) with the emulated
> intel8x0
> >>> driver  and no volume control with the emulated sb16 in virtualbox
> >>
> >> It's a righteous warning if you ask me - all volume controls should
> >> provide dB information,
> >
> > But "3D Depth" and some other controls are not volume controls and are
> > not measured in dB.
> >
> >> or we don't know what they actually do.
> >
> > Where "we" = "generic software like PA".  Non-standard controls can be
> > controlled only by hardware-specific tools or by the user.
>
> Exactly, this is a test tool that checks whether the mixer control names
> and dB information live up to PulseAudio's expectations. That's the
> tool's purpose.
>
> Given some thought, perhaps the application warning should be removed.
> It might be that it should only require dB information for the controls
> it actually wants to test (i e Master, PCM etc)...what do you think?
>
> --
> David Henningsson, Canonical Ltd.
> http://launchpad.net/~diwic <http://launchpad.net/%7Ediwic>
>

But some drivers (e.g. ISA drivers ) does not provide dB info for "Master"
and "Capture" volume control

There are different model of sound cards using snd-sb16 driver

SB16 support joint duplex , only 16 bit playback and 8 bit capture instead
of 16bits playback and capture

your runtest.sh use "-q" option and I had spend some time to discover the
overrun occur during arecord with sb16 inside virtualbox
