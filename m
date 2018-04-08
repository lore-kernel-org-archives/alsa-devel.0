From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ASoC: fsl_esai: Clear the xPM bit when
 using xFP
Date: Sun, 8 Apr 2018 04:16:39 +0200
Message-ID: <32ecf3e6-2241-682a-4f24-940fbab998b7@denx.de>
References: <20180407130221.24770-1-marex@denx.de>
 <20180408011454.GA2997@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B932266FD1
 for <alsa-devel@alsa-project.org>; Sun,  8 Apr 2018 04:17:13 +0200 (CEST)
In-Reply-To: <20180408011454.GA2997@Asurada-CZ80>
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

On 04/08/2018 03:14 AM, Nicolin Chen wrote:
> On Sat, Apr 07, 2018 at 03:02:21PM +0200, Marek Vasut wrote:
>> When setting xFP directly, set the xPM predivider to 1, otherwise
>> it could remain set to previously set incorrect value and interfere
>> with the correct clocking.
> 
> This doesn't sound right to me.

OK

> Could you please provide a failed
> instance? It's been a while since I wrote the code. But I can tell
> that PM is supposed to be called by set_sysclk() only, while FP is
> used for bclk. If you clear PM when setting FP, the output of HCK
> could be messed.

Try feeding it the following values, The codec I use is PCM1808.

fsl_esai_set_dai_sysclk[227] clk_id=0 freq=24576000 dir=1
fsl_esai_divisor_cal[131] tx=0 ratio=2 usefp=0 fp=0
fsl_esai_set_bclk[322] tx=0 freq=3072000
fsl_esai_divisor_cal[131] tx=0 ratio=8 usefp=1 fp=8

Also, I think there is another bug in the fsl_esai_divisor_cal() now
that I look at it. If usefp = 0, then maxfp = 1 , then savesub = 0 and
then in the loop sub is never < savesub , although the loop will
terminate on savesub == 0 immediately with pm = 999 and the driver will
fail.

> Thanks
> Nicolin
> 
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> ---
>>  sound/soc/fsl/fsl_esai.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
>> index 40a700493f4c..9f69823b50d7 100644
>> --- a/sound/soc/fsl/fsl_esai.c
>> +++ b/sound/soc/fsl/fsl_esai.c
>> @@ -128,8 +128,11 @@ static int fsl_esai_divisor_cal(struct snd_soc_dai *dai, bool tx, u32 ratio,
>>  
>>  	maxfp = usefp ? 16 : 1;
>>  
>> -	if (usefp && fp)
>> +	if (usefp && fp) {
>> +		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCCR(tx),
>> +				   ESAI_xCCR_xPM_MASK, 0);
>>  		goto out_fp;
>> +	}
>>  
>>  	if (ratio > 2 * 8 * 256 * maxfp || ratio < 2) {
>>  		dev_err(dai->dev, "the ratio is out of range (2 ~ %d)\n",
>> -- 
>> 2.16.2
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Best regards,
Marek Vasut
