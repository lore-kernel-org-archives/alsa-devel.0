From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Front speakers doesn't work in multichannel output,
	regression in ALC888
Date: Sun, 17 May 2015 09:49:09 +0800
Message-ID: <CAN8ccibBFmq8qBE-817u703r7tLffLkFURBHJK_z4bDoXbM-QA@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
 <4324603.tPLEjaP5mH@luklap.workgroup>
 <CAN8cciYbGexGm8GS3nJgBkfTphy6H-eV-dkwno6TYV0FiMfOhQ@mail.gmail.com>
 <4678913.FpDgrA5u1d@luklap.workgroup>
 <CAN8cciZdSoQpLQe2Cum1gozsJ48J-B9gbECFYDsHgx6=R4pLYg@mail.gmail.com>
 <CAN8cciZS8MhXWy5anxMSgtLdDYHQtURXJ2iEoL0YMpb41EifHg@mail.gmail.com>
 <d3bbb31411796d9f835396d30dcaa309@mail.onse.fi>
 <CAN8ccibM+PoboaTXoHqg=dCbe-3+ijQZ6xL_Q1J=H9ovZ8gzkQ@mail.gmail.com>
 <5554529A.4040202@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id E08B526048C
 for <alsa-devel@alsa-project.org>; Sun, 17 May 2015 03:49:10 +0200 (CEST)
Received: by oiko83 with SMTP id o83so107442606oik.1
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2015 18:49:09 -0700 (PDT)
In-Reply-To: <5554529A.4040202@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: tiwai@suse.de, lukasz.wojnilowicz@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Vincent Petry <PVince81@yahoo.fr>, Juan Jesus Garcia de Soria <skandalfo@gmail.com>
List-Id: alsa-devel@alsa-project.org

> >>>> I started MS Windows and without externals speakers plugged in I
> >>>
> >>> could test
> >>>  > 5.1 configuration and it seemed that sound was coming from
> >>> different directions.
> >>>
> >>>  >
> >>>  > What I managed to determine:
> >>>  > I've got 3 stacks:
> >>>  > 1 ST: Headphone, Line-out (FL and FR), SPDIF
> >>>  > 2 ST: Microphone, Line-out (CLFE)
> >>>  > 3 ST: Line-in, Line-out (RL and RR)
> >>>  >
> >>>  > I've got 5 responsive output pins
> >>>  > PIN 0x14: Internal FL FR
> >>>  > PIN 0x15: External FL FR
> >>>  > PIN 0x17: Internal LFE
> >>>  > PIN 0x18: External CLFE
> >>>  > PIN 0x1a: External RL RR
> >>>  >
> >>>  > How can we make it work with these information?

speaker-test -Dhw:0,0 -c4 -t wav

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=7cef4cf1c5e9d81554137f52b96a5ab7f6241cdd

You need to notify user of other acer aspire which use quirk
ALC888_ACER_ASPIRE_4930G if you want to remove node 0x16

> >>>
> >>>
> >
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/Channel-Mapping-API.txt
> >>> [1]
> >>>
> >>> seem chnmap type _FIXED , _VAR and _PAIRED does not fit when LFE and
> >>> FC can be swapped for internal speaker and external speaker
> >>
> >>
> >> Right, you can't do it with a single map of one of those types.
> >
> >
http://git.alsa-project.org/?p=alsa-utils.git&a=search&h=HEAD&st=commit&s=chmap
> >
> > do chmap of internal speakers need {FL FR RL RR LFE NA} ?
>
> From above it looks like there are 3 internal speakers, so I guess e.g.
> {FL FR LFE NA} might be in order (or just {FL FR LFE} if 3-channel
> playback is supported).

This is different from 2.1 internal speakers when yours also support
external 5.1

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=f37bc7a88d374448a1f4bba9267d308606d78bf2

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=8e38395360844806041ea69ab9690f5f174bc40c

>
> >
http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=7b14c00b56784f69ecc954a2de36e0a058fc8849;hp=000bf230cfb3b0abe88d27701dd77982675126ec
> >
> > this example seem not working
> >
> > speaker-test -c2 -t wav -Dplug:front -mFR,FL
>
> You are getting an error?

Unable to set channel map

> If so, that is expected if the underlying device does not support the
> wanted channel map.
>

Seem only those idt codecs which wcaps support R/L swap but hda-intel use
snd_pcm_std_chmap

Are there any other sound card support swap front right and front left ?
