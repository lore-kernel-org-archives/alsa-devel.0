From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Issues and/or possible bugs in alsa
Date: Sat, 11 Apr 2015 10:44:05 +0800
Message-ID: <CAN8cciZy7g=nO6GfzEwzs+CGhYNTGXgQ-rhnb09BRpZBNVMc1Q@mail.gmail.com>
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
 <CAN8cciZ4VK-NHOvrMpkx=pFHExMn-vf-jN1hL-31buMNt9v9SQ@mail.gmail.com>
 <CACui-2nXLr__yMy0-wW2F72wxJ-nkeBVmmSGn_Yj_hMOyJGKeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 18B44260708
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 04:44:07 +0200 (CEST)
Received: by qkx62 with SMTP id 62so57860387qkx.0
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 19:44:06 -0700 (PDT)
In-Reply-To: <CACui-2nXLr__yMy0-wW2F72wxJ-nkeBVmmSGn_Yj_hMOyJGKeA@mail.gmail.com>
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
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Nothing changes when I plug in or unplug my headphones. The output of
hdajacksensetest stays the same.
> However, in alsamixer, the level of Internal Mic Boost goes from 20 to
zero, and Mic Boost goes to 20.

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=531d8791accf1464bc6854ff69d08dd866189d17

May be HP  need to connect to DAC at node 0x03 for alc269vb
