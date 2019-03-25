From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: simple-card-utils: remove set but not used
 variable ''
Date: Mon, 25 Mar 2019 15:58:04 +0800
Message-ID: <ae41e273-1c0e-c178-cc94-7f0330b7559f@huawei.com>
References: <20190323020838.107533-1-yuehaibing@huawei.com>
 <6a0c2306-088f-cdbc-0730-60b899611c6f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6a0c2306-088f-cdbc-0730-60b899611c6f@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukesh Ojha <mojha@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2019/3/25 15:42, Mukesh Ojha wrote:
> 
> On 3/23/2019 7:38 AM, YueHaibing wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_parse_clk':
>> sound/soc/generic/simple-card-utils.c:164:18: warning:
>>   parameter 'dai_name' set but not used [-Wunused-but-set-parameter]
>>
>> It's not used since commit 0580dde59438 ("ASoC: simple-card-utils: add
> 
> 
> I am not able to find this commit
> 
> 0580dde59438

It's now in linux-next tree.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0580dde59438686d60762b6da9229ebec693b94f

> 
> 
>> asoc_simple_debug_info()"), so can be removed.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   sound/soc/generic/simple-card-utils.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
>> index 4ed68348f939..db1458a19985 100644
>> --- a/sound/soc/generic/simple-card-utils.c
>> +++ b/sound/soc/generic/simple-card-utils.c
>> @@ -173,10 +173,8 @@ int asoc_simple_parse_clk(struct device *dev,
>>        * see
>>        *    soc-core.c :: snd_soc_init_multicodec()
>>        */
>> -    if (dlc) {
>> +    if (dlc)
>>           dai_of_node    = dlc->of_node;
>> -        dai_name    = dlc->dai_name;
> 
> I don't see any function like `asoc_simple_parse_clk`
> 
> but instead this `asoc_simple_card_parse_clk` and there the variable is used.
> 
> Can you double check latest code base ?
> 
> Thanks,
> Mukesh
> 
> 
>> -    }
>>         /*
>>        * Parse dai->sysclk come from "clocks = <&xxx>"
>>
>>
>>
>>
>>
> 
> .
> 
