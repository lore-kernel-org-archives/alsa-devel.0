From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [RFT v2 2/3] ASoC: samsung: Add missing prepare
 for iis clock of s3c24xx
Date: Fri, 28 Jul 2017 11:35:48 +0530
Message-ID: <05bf6cbe-e803-0304-ed6f-7db70d9f334b@gmail.com>
References: <20170727171338.13300-1-krzk@kernel.org>
 <20170727171338.13300-3-krzk@kernel.org>
 <36fcdba7-309b-68b0-f3e4-f2de89526af7@gmail.com>
 <20170728054440.GA2650@kozik-book>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
 [209.85.161.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B954E26761A
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 08:06:38 +0200 (CEST)
Received: by mail-yw0-f194.google.com with SMTP id l82so8273126ywc.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 23:06:38 -0700 (PDT)
In-Reply-To: <20170728054440.GA2650@kozik-book>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org



On Friday 28 July 2017 11:14 AM, Krzysztof Kozlowski wrote:
> On Fri, Jul 28, 2017 at 10:11:48AM +0530, Arvind Yadav wrote:
>> Hi,
>>
>>
>> On Thursday 27 July 2017 10:43 PM, Krzysztof Kozlowski wrote:
>>> The s3c_i2sv2_probe() only enabled iis clock.  Missing prepare isn't
>>> probably fatal, because for SoC clocks this is usually no-op, but for
>>> correctness this clock should be prepared.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Arvind Yadav<arvind.yadav.cs@gmail.com 
<mailto:arvind.yadav.cs@gmail.com>>
>>>
>>> ---
>>>
>>> Changes since v1:
>>> 1. New patch
>>> ---
>>>   sound/soc/samsung/s3c-i2s-v2.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
>>> index 9b28046eea8e..3894bda06ebb 100644
>>> --- a/sound/soc/samsung/s3c-i2s-v2.c
>>> +++ b/sound/soc/samsung/s3c-i2s-v2.c
>>> @@ -637,7 +637,7 @@ int s3c_i2sv2_probe(struct snd_soc_dai *dai,
>>>   		return -ENOENT;
>>>   	}
>>> -	clk_enable(i2s->iis_pclk);
>>> +	clk_prepare_enable(i2s->iis_pclk);
>> Please, handle are return value of clk_prepare_enble.
> Which is a different issue, different bug. We can fix it but it should
> be not mixed with this fix here.
>
> Best regards,
> Krzysztof
>
