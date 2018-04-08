From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Clear the xPM bit when
 using xFP
Date: Sat, 7 Apr 2018 21:01:28 -0700
Message-ID: <20180408040127.GA14245@Asurada-CZ80>
References: <20180407130221.24770-1-marex@denx.de>
 <20180408011454.GA2997@Asurada-CZ80>
 <32ecf3e6-2241-682a-4f24-940fbab998b7@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f177.google.com (mail-pf0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id F1069267070
 for <alsa-devel@alsa-project.org>; Sun,  8 Apr 2018 06:01:35 +0200 (CEST)
Received: by mail-pf0-f177.google.com with SMTP id p15so3555355pff.11
 for <alsa-devel@alsa-project.org>; Sat, 07 Apr 2018 21:01:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32ecf3e6-2241-682a-4f24-940fbab998b7@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Gustavo A . R . Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 08, 2018 at 04:16:39AM +0200, Marek Vasut wrote:

> > Could you please provide a failed
> > instance? It's been a while since I wrote the code. But I can tell
> > that PM is supposed to be called by set_sysclk() only, while FP is
> > used for bclk. If you clear PM when setting FP, the output of HCK
> > could be messed.
> 
> Try feeding it the following values, The codec I use is PCM1808.

> [1] fsl_esai_set_dai_sysclk[227] clk_id=0 freq=24576000 dir=1
> [2] fsl_esai_divisor_cal[131] tx=0 ratio=2 usefp=0 fp=0
> [3] fsl_esai_set_bclk[322] tx=0 freq=3072000
> [4] fsl_esai_divisor_cal[131] tx=0 ratio=8 usefp=1 fp=8

So [1] tries to output HCKT (using FSYS) and to set its freq
at 24MHz. If [2] is correct, you'd have HCKT outputting 24MHz.

Let's put this in the graph:
FSYS (48MHz) --> PSR & PM (input_rate / 2) --> HCKT (24MHz)

[3] tries to output SCKT (bit clock) at 3MHz. So you got fp=8
and usefp=1. The combination of usefp=1 and fp=8 should bypass
PSR/PM settings because both should be correctly configured:

HCKT (24MHz) --> FP (input_rate / 8) --> SCKT (3MHz)

If you set PM=0 at [4], the HCKT at [2] would be changed. So
your change shouldn't be a good fix. Meanwhile, I don't see
any problem of the driver at the FP/PM part. I think you can
help me figure it out as it might because of something else.
You may dump the PSR, PM here to check if HCKT is 24MHz.

> Also, I think there is another bug in the fsl_esai_divisor_cal() now
> that I look at it.

> If usefp = 0, then maxfp = 1 , then savesub = 0 and

I see. This actually would happen when PSR=0. And the ratio in
this case is <= 256 (which could be satisfied by PM only). Btw,
is this the reason why you got a "dirty" PM?

Anyway, this part is a bug. Would you like to fix it?

Thanks
Nicolin
