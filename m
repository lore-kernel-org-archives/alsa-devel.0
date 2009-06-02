From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Subject: Re: ASoC: TWL4030 driver support multi channel playback
Date: Tue, 2 Jun 2009 11:03:59 +0530
Message-ID: <ef0d8a250906012233n477a3afdtf8eb7a71f5e8378e@mail.gmail.com>
References: <ef0d8a250906010720n144bb53bl4c6cc3e79e0f8db9@mail.gmail.com>
	<200906020816.41806.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 4509A243EF
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 07:34:00 +0200 (CEST)
Received: by qyk1 with SMTP id 1so10923746qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 01 Jun 2009 22:33:59 -0700 (PDT)
In-Reply-To: <200906020816.41806.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

Thanks for your quick reply,
I have an issue, probably the last one.

2009/6/2 Peter Ujfalusi <peter.ujfalusi@nokia.com>

> Hello,


>
> On Monday 01 June 2009 17:20:01 ext Naveen Krishna Ch wrote:
> > Hi Peter,
> >
> > I am using linux 2.6.28 kernel,
> >
> > there is a requirement to support multi (4) channel play back .
> >
> > I guess TWL4030 ASoC driver now has full fledged support for both the
> > DAC1(TX1) and  DAC2(TX2) paths in option 1 of codec operation.
>
> Yes it does. It has support for TX1L/R, TX2L/R, RX1L/R and RX2L/R (four
> channel playback and recording)
>
> >
> > I am looking forward to back port the ASoC stuff drivers from 2.6.30 rc7
> > to 2.6.28.
> >
> > Is there any better way of meeting the requirement with out back porting
> > the stuff
>
> Well, I think this is not going to be an easy ride. It is not that hard,
> but
> takes some time. I could think of two approaches to get the twl4030 codec
> work
> backported (plus one):
> 1. Backport the the whole ASoC changes to 2.6.28
> 2. Backport the twl4030 codec driver with minimal amount of ASoC changes

I tried this last night,  i was able to boot the board...
Except the following thing

Advanced Linux Sound Architecture Driver Version 1.0.18rc3.
No device for DAI twl4030
No device for DAI twl4030 Voice
No device for DAI omap-mcbsp-dai-0
No device for DAI omap-mcbsp-dai-1
No device for DAI omap-mcbsp-dai-2
No device for DAI omap-mcbsp-dai-3
No device for DAI omap-mcbsp-dai-4
omap3apple SoC init
ALSA device list:
  No soundcards found.

I tried to fix this, it seems like a dev structure is missing during the
codec registration.
Can u help me find where i went wrong..

>
> 3. Convince whoever you need to convince that you need to move to 2.6.30 =
;)

There is some powermanagment issue which restricting us to move forward to
2.6.30

>
>
> 1. Since ASoC has been dramatically changed since 2.6.28 this is not going
> to
> be easy, but you will have the current ASoC features and it will be easier
> to
> follow upstream.
> 2. Pick the changes to the twl4030 codec one-by-one apply it, compile the
> result, if it breaks, take the needed patches to fix the errors. Fair amu=
nt
> of
> work, but you will end up a working twl4030 codec, but you need to backpo=
rt
> the new patches from upstream every time..
> 3. This only exist in the ideal world.
>
> In overall, I think your best bet is 1) You can take the 2) if you really
> know
> what you are doing...


>
> >
> > Suggestions please.
> >
> > Sorry for the english,,
> > --
> > Cheers
> > (: Naveen Krishna Ch :)
>
> --
> P=E9ter
>



-- =

Cheers
(: Naveen Krishna Ch :)
