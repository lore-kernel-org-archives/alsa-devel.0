From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Issues and/or possible bugs in alsa
Date: Fri, 10 Apr 2015 21:18:37 +0800
Message-ID: <CAN8cciZ4VK-NHOvrMpkx=pFHExMn-vf-jN1hL-31buMNt9v9SQ@mail.gmail.com>
References: <CACui-2k8j3ZWtmvwiE3V5apuQ0g-dn=wN-h4miExDYLLR4diWA@mail.gmail.com>
 <54ED8466.7020102@gmail.com>
 <CAN8cciYnyLahS2gQ0g0vSaNj+xo=Tz9_FQ9L-WazOb1t5no_kA@mail.gmail.com>
 <54F1C10B.2050008@gmail.com> <s5hmw3ygjcx.wl-tiwai@suse.de>
 <CACui-2k_6R7SG2_o0SO+oLMNz-Lo7zpY6tuvOOYJ1eq7N056hg@mail.gmail.com>
 <CAN8ccia6_ZSdAtL3w4s4B0RYLnOXZK-LddpQi4LCjdHZrtJqfA@mail.gmail.com>
 <CACui-2ngDGDf3R-Jp0mxrYKrJQuWCS6msk-A3LdTk0n2LZCqTQ@mail.gmail.com>
 <CACui-2kLt+x6RieNZ05bFbs5veu7zy3m50MfurPCpPtBAwY07Q@mail.gmail.com>
 <CACui-2n2MTnA9DWzGdprfJ=bY+OjYMkBtFe7YQQnTf5BBtyk=Q@mail.gmail.com>
 <CAN8cciYc6ggpnOZydy4Mm_TsXo4c8SAN_cyutJ1FFeuiqxCEnw@mail.gmail.com>
 <CACui-2ndKUv=JPdDqQ9isctMhthEBL1hD_UJRy6GaONmfjkvTA@mail.gmail.com>
 <CAN8ccibNsvV5_TG3XCDOdTjkPSEd9aC1QjV1rrjz4NnidhbrDA@mail.gmail.com>
 <CACui-2kobAiBJB0=dd8_jhEGMkHzq1Rjd4cLM0Aus3CRyc9QgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AB6026060A
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 15:18:39 +0200 (CEST)
Received: by obbfy7 with SMTP id fy7so13717922obb.2
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 06:18:38 -0700 (PDT)
In-Reply-To: <CACui-2kobAiBJB0=dd8_jhEGMkHzq1Rjd4cLM0Aus3CRyc9QgA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yomi Ogunwumi <abyomi0@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Okay, I added those lines to a clone of tiwai's repo.
> Output of alsa-info.sh :
https://gist.github.com/Yomi0/f4059fe45d960f141b33#file-rpatch
>

Try hdajacksensetest -a when you plugged and unplugged HP and mic

Did headphone playback volume change to minimum when you plug and unplug ?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/sound/pci/hda/patch_realtek.c?qt=grep&q=toshiba

Seem no specifc hack used by other toshiba

Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 0 [0%] [-65.25dB] [off]
  Front Right: Playback 0 [0%] [-65.25dB] [off]

control.14 {
iface CARD
name 'Mic Jack'
value true
comment {
access read
type BOOLEAN
count 1
}
}

control.16 {
iface CARD
name 'Headphone Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
