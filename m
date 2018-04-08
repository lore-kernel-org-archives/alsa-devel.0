From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ASoC: fsl_esai: Clear the xPM bit when
 using xFP
Date: Sun, 8 Apr 2018 13:00:07 +0200
Message-ID: <4029cd13-0de6-609f-d8cc-923553cd0d0f@denx.de>
References: <20180407130221.24770-1-marex@denx.de>
 <20180408011454.GA2997@Asurada-CZ80>
 <32ecf3e6-2241-682a-4f24-940fbab998b7@denx.de>
 <20180408040127.GA14245@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id B4BB8267235
 for <alsa-devel@alsa-project.org>; Sun,  8 Apr 2018 18:42:11 +0200 (CEST)
In-Reply-To: <20180408040127.GA14245@Asurada-CZ80>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Gustavo A . R . Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

On 04/08/2018 06:01 AM, Nicolin Chen wrote:
> On Sun, Apr 08, 2018 at 04:16:39AM +0200, Marek Vasut wrote:
> 
>>> Could you please provide a failed
>>> instance? It's been a while since I wrote the code. But I can tell
>>> that PM is supposed to be called by set_sysclk() only, while FP is
>>> used for bclk. If you clear PM when setting FP, the output of HCK
>>> could be messed.
>>
>> Try feeding it the following values, The codec I use is PCM1808.
> 
>> [1] fsl_esai_set_dai_sysclk[227] clk_id=0 freq=24576000 dir=1
>> [2] fsl_esai_divisor_cal[131] tx=0 ratio=2 usefp=0 fp=0
>> [3] fsl_esai_set_bclk[322] tx=0 freq=3072000
>> [4] fsl_esai_divisor_cal[131] tx=0 ratio=8 usefp=1 fp=8

Sorry for confusing you, clk_id in [1] should be 3 .
[...]
>> Also, I think there is another bug in the fsl_esai_divisor_cal() now
>> that I look at it.
> 
>> If usefp = 0, then maxfp = 1 , then savesub = 0 and
> 
> I see. This actually would happen when PSR=0. And the ratio in
> this case is <= 256 (which could be satisfied by PM only). Btw,
> is this the reason why you got a "dirty" PM?
> 
> Anyway, this part is a bug. Would you like to fix it?

Clearly I'm getting a bit lost on this convoluted clock calculation.
What is the code trying so elaborately to come up with, ideal
configuration for each of the clock ?

-- 
Best regards,
Marek Vasut
