From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Clear the xPM bit when
 using xFP
Date: Sun, 8 Apr 2018 17:07:42 -0700
Message-ID: <20180409000741.GA50921@Asurada-CZ80>
References: <20180407130221.24770-1-marex@denx.de>
 <20180408011454.GA2997@Asurada-CZ80>
 <32ecf3e6-2241-682a-4f24-940fbab998b7@denx.de>
 <20180408040127.GA14245@Asurada-CZ80>
 <4029cd13-0de6-609f-d8cc-923553cd0d0f@denx.de>
 <20180408192713.GA1932@Asurada>
 <d3cc98b4-8bcb-752a-1ff0-c113d4213198@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f49.google.com (mail-pl0-f49.google.com
 [209.85.160.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 377C72673C7
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 02:07:47 +0200 (CEST)
Received: by mail-pl0-f49.google.com with SMTP id 91-v6so4061049pld.3
 for <alsa-devel@alsa-project.org>; Sun, 08 Apr 2018 17:07:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d3cc98b4-8bcb-752a-1ff0-c113d4213198@denx.de>
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

On Sun, Apr 08, 2018 at 09:33:52PM +0200, Marek Vasut wrote:

> >>>> Try feeding it the following values, The codec I use is PCM1808.
> >>>
> >>>> [1] fsl_esai_set_dai_sysclk[227] clk_id=0 freq=24576000 dir=1
> >>>> [2] fsl_esai_divisor_cal[131] tx=0 ratio=2 usefp=0 fp=0
> >>>> [3] fsl_esai_set_bclk[322] tx=0 freq=3072000
> >>>> [4] fsl_esai_divisor_cal[131] tx=0 ratio=8 usefp=1 fp=8
> >>
> >> Sorry for confusing you, clk_id in [1] should be 3 .
> > 
> > No worries, it doesn't change the program flow. But it makes
> > sense now as the input is 48MHz.
> 
> Except with this configuration , the audio doesn't work without this
> patch. I'm happy to receive any feedback on why or what is the problem.

I sent a patch to you and in the maillist for review. Would
you please test it and sent a Tested-by to the patch? Thanks

> >> [...]
> >>>> Also, I think there is another bug in the fsl_esai_divisor_cal() now
> >>>> that I look at it.
> >>>
> >>>> If usefp = 0, then maxfp = 1 , then savesub = 0 and
> >>>
> >>> I see. This actually would happen when PSR=0. And the ratio in
> >>> this case is <= 256 (which could be satisfied by PM only). Btw,
> >>> is this the reason why you got a "dirty" PM?
> >>>
> >>> Anyway, this part is a bug. Would you like to fix it?
> >>
> >> Clearly I'm getting a bit lost on this convoluted clock calculation.
> >> What is the code trying so elaborately to come up with, ideal
> >> configuration for each of the clock ?
> > 
> > It just tires to get the closet ratio to set three divisors
> > correspondingly. Your case should be simpler but the program
> > didn't cover. It's a design flaw. I will figure out the best
> > fix and send it soon -- will put you in Reported-by and Cc.
> 
> OK. I wonder though, don't we have code to calculate dividers in the clk
> framework already? Why is it reinvented in here ?

Well, I wrote the code four years ago, based on a much older
downstream kernel; the code also got upstream that time too.
Even NXP's latest code doesn't seemly have some diff at this
part. I guess no one had reported this bug to them or to me
until you did yesterday...
