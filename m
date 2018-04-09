From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ASoC: fsl_esai: Clear the xPM bit when
 using xFP
Date: Mon, 9 Apr 2018 23:43:21 +0200
Message-ID: <850f989f-936b-c825-2237-f26b50982a91@denx.de>
References: <20180407130221.24770-1-marex@denx.de>
 <20180408011454.GA2997@Asurada-CZ80>
 <32ecf3e6-2241-682a-4f24-940fbab998b7@denx.de>
 <20180408040127.GA14245@Asurada-CZ80>
 <4029cd13-0de6-609f-d8cc-923553cd0d0f@denx.de>
 <20180408192713.GA1932@Asurada>
 <d3cc98b4-8bcb-752a-1ff0-c113d4213198@denx.de>
 <20180409000741.GA50921@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F00B266D8D
 for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2018 01:46:02 +0200 (CEST)
In-Reply-To: <20180409000741.GA50921@Asurada-CZ80>
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

On 04/09/2018 02:07 AM, Nicolin Chen wrote:
> On Sun, Apr 08, 2018 at 09:33:52PM +0200, Marek Vasut wrote:
> 
>>>>>> Try feeding it the following values, The codec I use is PCM1808.
>>>>>
>>>>>> [1] fsl_esai_set_dai_sysclk[227] clk_id=0 freq=24576000 dir=1
>>>>>> [2] fsl_esai_divisor_cal[131] tx=0 ratio=2 usefp=0 fp=0
>>>>>> [3] fsl_esai_set_bclk[322] tx=0 freq=3072000
>>>>>> [4] fsl_esai_divisor_cal[131] tx=0 ratio=8 usefp=1 fp=8
>>>>
>>>> Sorry for confusing you, clk_id in [1] should be 3 .
>>>
>>> No worries, it doesn't change the program flow. But it makes
>>> sense now as the input is 48MHz.
>>
>> Except with this configuration , the audio doesn't work without this
>> patch. I'm happy to receive any feedback on why or what is the problem.
> 
> I sent a patch to you and in the maillist for review. Would
> you please test it and sent a Tested-by to the patch? Thanks

Done, thanks for your help! :)

-- 
Best regards,
Marek Vasut
