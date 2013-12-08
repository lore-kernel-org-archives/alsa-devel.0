From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] Issue with multiple hdmi
 codecs in radeonhd, hacked to work
Date: Sun, 8 Dec 2013 21:56:33 +0800
Message-ID: <CAN8cciaUWAxfPp0rNhBV=DCp2hSOJ-EPHeoQ-k25M91xYjmFiQ@mail.gmail.com>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>
 <CAN8ccia9KA4fyU06LE3+DMPcj9w62Z8P-BvjR3-aA2Q9TWcC-A@mail.gmail.com>
 <CAJ3TwYQOiV2DFbVHagJ+O+tSbcvmNUTrZng1C8Tgooz8SrdPgg@mail.gmail.com>
 <CAJ3TwYQSYtv6qdCiTi9MHBoEnxqitXbSVgxq-8R+z7E0LQyhpg@mail.gmail.com>
 <CAN8cciZ=UWO_RNwJqrBwbbbU1f_4Ydapk=2d67CtYhVRbO-c1w@mail.gmail.com>
 <CAJ3TwYTeR4fZSRGaMpUudL2t_dR0dkYYV1tP_aEAGnjUqN3iDg@mail.gmail.com>
 <CAN8cciZ8okPOUD1X3Vy3ofayQHfW6K3eojUwLkGc3o-xX0BFgg@mail.gmail.com>
 <CAJ3TwYQr3u-04zRduACx9g283tpyj2bmjDvgA+ok=15OGg5g9w@mail.gmail.com>
 <CAN8cciYEikGtPaET-qZECcyGTAqRQab6jEsGP-Zt=4U2ngLqbA@mail.gmail.com>
 <CAJ3TwYRheSya2Y7y-e82=-HPv5j26n7SR-L1GeC=CPfrOKHpbA@mail.gmail.com>
 <CAN8ccibrFmQa4rPcP6gqt7h1MpMQ310b8y2zcbN-h_rtN_6vvw@mail.gmail.com>
 <CAJ3TwYQ_1BTmPafS-_BJWWNp1VSXA5K_e0vVHMipGrkdOjGuwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AE5C261B0D
 for <alsa-devel@alsa-project.org>; Sun,  8 Dec 2013 14:56:34 +0100 (CET)
Received: by mail-ie0-f182.google.com with SMTP id as1so4470094iec.13
 for <alsa-devel@alsa-project.org>; Sun, 08 Dec 2013 05:56:33 -0800 (PST)
In-Reply-To: <CAJ3TwYQ_1BTmPafS-_BJWWNp1VSXA5K_e0vVHMipGrkdOjGuwA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Ettedgui <john.ettedgui@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Anssi Hannula <anssi.hannula@iki.fi>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, erutrot@gmail.com
List-Id: alsa-devel@alsa-project.org

> I just changed my RadeonHD 4670 for a 7870, and now when I type
> "aplay -l"  I get many HDMI codecs instead of just one like for the
>  previous

you have to specify CONFIG_SND_DYNAMIC_MINORS=y when building the driver


[    4.637413] ALSA hda_codec.c:4506 Too many HDMI devices
[    4.637414] ALSA hda_codec.c:4508 Consider building the kernel with
CONFIG_SND_DYNAMIC_MINORS=y
[    4.637644] ALSA control.c:352 control 0:0:0:HDMI/DP Jack:0 is already
present
[    4.639220] hda_codec: cannot build controls for #0 (error -16)



> can you post the system log if the graphic driver know hdmi, vga and two
>> mini display ports are connected or not ?
>>
>> I cannot see anything in dmesg related, so attaching Xorg log.
>
>> -
>>
>
    5.268590] [drm] Radeon Display Connectors
[    5.268592] [drm] Connector 0:
[    5.268593] [drm]   DP-1
[    5.268594] [drm]   HPD4
[    5.268595] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538
0x653c 0x653c
[    5.268596] [drm]   Encoders:
[    5.268597] [drm]     DFP1: INTERNAL_UNIPHY2
[    5.268598] [drm] Connector 1:
[    5.268599] [drm]   DP-2
[    5.268600] [drm]   HPD5
[    5.268601] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548
0x654c 0x654c
[    5.268602] [drm]   Encoders:
[    5.268603] [drm]     DFP2: INTERNAL_UNIPHY2
[    5.268603] [drm] Connector 2:
[    5.268604] [drm]   HDMI-A-1
[    5.268605] [drm]   HPD1
[    5.268606] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558
0x655c 0x655c
[    5.268607] [drm]   Encoders:
[    5.268608] [drm]     DFP3: INTERNAL_UNIPHY1
[    5.268609] [drm] Connector 3:
[    5.268610] [drm]   DVI-I-1
[    5.268610] [drm]   HPD6
[    5.268612] [drm]   DDC: 0x6580 0x6580 0x6584 0x6584 0x6588 0x6588
0x658c 0x658c
[    5.268612] [drm]   Encoders:
[    5.268613] [drm]     DFP4: INTERNAL_UNIPHY
[    5.268614] [drm]     CRT1: INTERNAL_KLDSCP_DAC1




[     7.613] (II) RADEON(0): Output DisplayPort-0 has no monitor section
[     7.626] (II) RADEON(0): Output DisplayPort-1 has no monitor section
[     7.693] (II) RADEON(0): Output HDMI-0 has no monitor section
[     7.713] (II) RADEON(0): Output DVI-0 has no monitor section
[     7.726] (II) RADEON(0): EDID for output DisplayPort-0
[     7.740] (II) RADEON(0): EDID for output DisplayPort-1
[     7.801] (II) RADEON(0): EDID for output HDMI-0
[     7.801] (II) RADEON(0): Manufacturer: DON  Model: 26  Serial#: 16843009
[     7.801] (II) RADEON(0): Year: 2011  Week: 0
[     7.801] (II) RADEON(0): EDID Version: 1.3


[     7.823] (II) RADEON(0): EDID for output DVI-0
[     7.823] (II) RADEON(0): Output DisplayPort-0 disconnected
[     7.823] (II) RADEON(0): Output DisplayPort-1 disconnected
[     7.823] (II) RADEON(0): Output HDMI-0 connected
[     7.823] (II) RADEON(0): Output DVI-0 disconnected

the graphic driver knew only HDMI-0 is connected and the others are not
connected
