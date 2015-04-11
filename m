From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Issues and/or possible bugs in alsa
Date: Sat, 11 Apr 2015 15:07:03 +0800
Message-ID: <CAN8ccibAhwFmLLSq=KEu_oRzdgGzO+LRG+C=7ETTFXmM7qnfXQ@mail.gmail.com>
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
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 031D72610A7
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 09:07:05 +0200 (CEST)
Received: by qkhg7 with SMTP id g7so66620044qkh.2
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 00:07:04 -0700 (PDT)
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
To: Yomi Ogunwumi <abyomi0@gmail.com>, Kailang Yang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Okay, I added those lines to a clone of tiwai's repo.
> Output of alsa-info.sh :
https://gist.github.com/Yomi0/f4059fe45d960f141b33#file-rpatch
>
>

If the problem still exist but the jack state are correct after you run
hdajacksensetest

You need to specify spec->primary_hp=0 for those alc269vb which force the
driver to assign dac 0x02 to speaker first and dac 0x03 to headphone since
it was hardcoded in this patch

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=531d8791accf1464bc6854ff69d08dd866189d17
