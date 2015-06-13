From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Sat, 13 Jun 2015 10:43:03 +0800
Message-ID: <CAN8cciYF6zRef6-B4CROJqDTTD6Ohxn75-A+R9cu7CxO1PWaRg@mail.gmail.com>
References: <5576B419.5010505@canonical.com> <s5h1thlqeus.wl-tiwai@suse.de>
 <5576E994.2080300@canonical.com> <5577BAEE.50506@canonical.com>
 <s5h1thjoo14.wl-tiwai@suse.de> <s5hoakmjn6i.wl-tiwai@suse.de>
 <557A7718.5070100@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 48722260563
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 04:43:05 +0200 (CEST)
Received: by obbsn1 with SMTP id sn1so33466929obb.1
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 19:43:04 -0700 (PDT)
In-Reply-To: <557A7718.5070100@canonical.com>
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
Cc: hwang4 <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Oh, this is an interesting trade-off.
>
> In the PulseAudio desktop scenario, we automute the speaker, and
PulseAudio remembers the individual headphone and speaker volumes. So in
this case, there is no benefit from having individual headphone and speaker
volume at the ALSA level.
>
> However if a user wants to turn off automute, then there is a need for
being able to adjust headphone and speaker volume individually.
>
> But it's not just a question of volume control for 2.1. Being able to
send a different stream to the subwoofer could be useful too, especially if
the hardware filter is bad or non-existing.
>
>

It is not just low pass filter with subwoofer

Pulseaudio seem also perform high pass filter at the same time

http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=f3ebf6b667b155f5fe6526bd70881c79e07d7874

92hd91  have high pass filter for internal speakers

2.20.BTL Amplifier High-Pass Filter

For mobile applications, speakers are often incapable of reproducing low
frequency audio and unable to handle the maximum output power of the BTL
amplifier. A high-pass filter is implemented in the BTL output path to
reduce the amount of low frequency energy reaching speakers attached to the
BTL amplifier. This can prevent speaker failure.

2.20.1.Filter Description

The high-pass filter is derived from the common biquadratic filter and
provides a 12dB/octave roll-off. The filter may be programmed for a -3dB
response at: 100Hz, 200Hz, 300Hz, 400Hz, 500Hz, 750Hz, 1KHz, or 2KHz. The
high pass filter is enabled by default with a cut-off frequency of 300Hz.
The filter may be bypassed using the associated verb (processing state
verb).
