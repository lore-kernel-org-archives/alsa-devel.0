From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Wed, 9 Jun 2010 13:39:58 +0800
Message-ID: <AANLkTimP9WxU1Ho4TsM6u4tCTYpkDyBBrx6W-9z92V2E@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<AANLkTikWaBVuo-Vo8LIN6jS19cuPv4nDZbgYKzzZeLWg@mail.gmail.com>
	<201005211018.41802.vand2@gmx.de>
	<AANLkTikylA_oo6GBKuLHewVX9oMCNjQMeS90HThDR47K@mail.gmail.com>
	<4C0CB996.5010202@gmx.de>
	<AANLkTinTV_MnU-rBOrLc66YhGFbP9SJVZ2p5DFlcS16T@mail.gmail.com>
	<4C0DDE4D.9070201@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3AC7D24333
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 07:40:00 +0200 (CEST)
Received: by pvg13 with SMTP id 13so962718pvg.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2010 22:39:59 -0700 (PDT)
In-Reply-To: <4C0DDE4D.9070201@gmx.de>
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

2010/6/8 Sebastian H. <vand2@gmx.de>

>
> >>>>> I thinks Sebastian's question is whether he can use
> >>>>> snd_mixer_selem_set_playback_
> >>>>> dB() set any values in between the volume steps
> >>>>>
> >>>>> e.g. Master volume control of ac97 is 1.5 dB per step,
> >>>>>
> >>>>> when using snd_mixer_selem_set_playback_dB() to set -0.9dB , how can
> >> the
> >>>>> mixer application know what dB value has been set since the value is
> in
> >>>>> between -1.5dB and 0dB without snd_mixer_selem_get_playbackdB()
> >>>>
> >>>> Indeed I quite happy with what ALSA already provides (I'm just an
> >>>> interested
> >>>> amateur). My main problem is that there is no documentation for the
> >> Mixer
> >>>> API
> >>>> and how things are related to each other. Like CTL, HCTL, Mixer and
> >>>> SimpleMixer and of course volume and dB in the snd_mixer_selem_
> >> functions.
> >>>>
> >>>> The root issue is that I wondered if the mixer application should
> offer
> >> a
> >>>> separate text input for decibel values besides the text input for
> volume
> >>>> values. As pointed out this would not allow for finer grained volume
> >>>> control
> >>>> therefore for the moment I'll probably stick with a mere text label
> for
> >> dB.
> >>>>
> >>>>
> >>
> >>> The main difference between those volume controls using TLV_DB_SCALE
> and
> >>> TLV_DB_LINEAR is -6dB is at the middle of TLV_DB_LINEAR and
> TLV_DB_SCALE
> >> has
> >>> fixed dB value between any two steps.
> >>
> >> What's TLV_DB_SCALE and TLV_DB_LINEAR for?
> >> A grep in the alsa-lib sources did not return anything.
> >>
> >>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/332631
> >>>
> >>> if the user has both hda onboard sound and emu10k1, he may notice that
> >> there
> >>> is big difference if he set volume at percentage instead of dB
> >>
> >> Interesting, that's my setup. I have an onboard HDA Intel and a
> >> pci SBLive! Card and some el cheapo USB sound cards to experiment
> >> with. Thanks I'll give the volume listening test a try at some point.
> >>
> >
> >
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4883
> >
> > Pekka Lampila reported that when he set -40dB and only get back -9999999
> by
> > his program alsa_mixer_test.c
> >
> > I don't have emu10k1 so don't know whether this is a bug of alsa-lib or
> not
>
> I also get a big jump from -39.60dB to -99999.99 dB for some emu10k1
> sliders when I move them to the minimum although their advertised
> minimum is -40dB. This looks like a way to express log ( 0 ).
>

Do you ream snd_mixer_selem_get_Playback_dB_range() return 40dB but max_dB -
min_dB = 99999.99 dB ?
