From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: DMA screams on MSP
Date: Tue, 4 Feb 2014 21:01:48 +0100
Message-ID: <CACRpkdaT+r4aCZ-4WsxThVW0zfKemL=0Gu2_6+paQS=Cf1Nh7g@mail.gmail.com>
References: <CACRpkdYkvExwY_w+PkoJdmTSysmc_LbUHG52=Qr_56AMgSyFSg@mail.gmail.com>
 <20140204133603.GF13529@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 by alsa0.perex.cz (Postfix) with ESMTP id A26A1261A8B
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 21:01:49 +0100 (CET)
Received: by mail-ob0-f177.google.com with SMTP id wp18so10087943obc.36
 for <alsa-devel@alsa-project.org>; Tue, 04 Feb 2014 12:01:48 -0800 (PST)
In-Reply-To: <20140204133603.GF13529@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 4, 2014 at 2:36 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> I get this in my bootlog nowadays (v3.14-rc1):
>>
>> [    2.713897] dma dma0chan29: [d40_validate_conf] Invalid device type
>> (14) physical channel exeeds available physical channels
>
> <snip>
>
>> (I patched dma40 to state the exact cause instead of just
>> "invalid device type".)
>>
>> Like something (I guess ALSA SoC?) is trying real hard to get physical
>> channel 14, but I can't seem to figure out what is going on.
>>
>> I will try to see if this also appears on the Snowball but I guess
>> so?
>>
>> Any hints appreciated...
>
> It looks like you're attempting to initialise MSP2 (HDMI). Why are you
> doing that? Can you `git grep msp2` and provide me with the output
> please?

This is just plain mainline, there is nothing special about my
git tree...

Yeah it appears I went in and marked msp2 "okay" in
commit 70b41abc151f9 so that is causing it, I'll make a
quick fix to get rid of that.

But no matter whether it gets activated or not: should it not just
work anyway? This message seems to suggest the DMA
channel assignment is invalid.

Yours,
Linus Walleij
