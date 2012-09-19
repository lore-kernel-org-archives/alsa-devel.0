From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Wed, 19 Sep 2012 08:35:19 +0800
Message-ID: <CAN8cciZVWqzzN+vXvGqheUHxQmY_RrwF-ekV+O1Vd4FYn=1QeA@mail.gmail.com>
References: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciYZBU+LaaQFXrn9kPoFc=MdYahw0ucKNmAhrG=CT0+C5g@mail.gmail.com>
 <s5h392rhbyu.wl%tiwai@suse.de> <5056D395.4090603@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 41B22265112
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 02:35:21 +0200 (CEST)
Received: by qcse14 with SMTP id e14so366626qcs.38
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 17:35:20 -0700 (PDT)
In-Reply-To: <5056D395.4090603@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, 939161@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

>>> do you mean the commit does not fix the bug?
>>>
>>> ALSA: hda - add support for Uniwill ECS M31EI notebook
>>>
>>> This hardware requires same fixup for the node 0x0f like Asus A6Rp.
>>> More information: https://bugzilla.redhat.com/show_bug.cgi?id=785417
>>>
>>>
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=416846d2b31fc740ed9d5a5ec116964fb43c4o358
>
>
> The PCI SSIDs are different, so I don't think that commit will affect the
bug I was trying to fix.
>

How many audio jacks do this m31ei have as
JrZabott specified model=3stack(3 jacks) which use cd pin , no auto Mic
since this input source also does not support jack detect.

Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000063: IN Balanced Trigger ImpSense
  Pin Default 0x99331121: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Black
    DefAssociation = 0x2, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:

The master playback switch is at audio mixer node 0x16

Simple mixer control 'Master',0
  Capabilities: pswitch penum
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]

There is no  headphone playback volume/switch so why do pulseaudio remove
the analog output path ?

ports:
analog-output-headphones: Headphones (priority 9000, available: no)
properties:

active port: <analog-output-headphones>

There are mini itx chassis which does not have front audio panel, will
pulseaudio remove the analog output path ?

Default PCM:
    rates [0x140]: 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1

Refer to the block diagram of alc861 datasheet, it seem every audio output
and pin complex has a mute switch

And you already mentioned there is no speaker pin

>
>>> the real cases are those desktop which does not use hda front audio
panel ,
>>> they just loss the auto mute since there is no jack detect circuit but
they
>>> can still hear sound from the headphone at anytime
>
>
> If there is an AC'97 front panel connected, the BIOS should set
NO_PRESENCE in the misc bit.

Do you mean the driver should a read/write kcontrol so that user can change
the state by qashctl ?
