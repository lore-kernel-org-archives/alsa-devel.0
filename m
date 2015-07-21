From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: ssm4567: Keep TDM_BCLKS in
	ssm4567_set_dai_fmt
Date: Tue, 21 Jul 2015 15:02:11 -0700
Message-ID: <CAOMFOmWtuoFYrtthLBuBZmbPBbaLUfgrg4EtPhbk-5ctuEd9rA@mail.gmail.com>
References: <1437515186-1961-1-git-send-email-benzh@chromium.org>
 <55AEBE7F.4010102@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f52.google.com (mail-vn0-f52.google.com
 [209.85.216.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 339292605EA
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 00:02:14 +0200 (CEST)
Received: by vnk197 with SMTP id 197so41290607vnk.3
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 15:02:11 -0700 (PDT)
In-Reply-To: <55AEBE7F.4010102@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Harsha Priya <harshapriya.n@intel.com>, Ben Zhang <benzh@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Anatol Pomozov <anatol@google.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Tue, Jul 21, 2015 at 2:49 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/21/2015 11:46 PM, Ben Zhang wrote:
>>
>> The regmap_write in ssm4567_set_dai_fmt accidentally clears the
>> TDM_BCLKS field which was set earlier by ssm4567_set_tdm_slot.
>>
>> This patch fixes it by using regmap_update_bits with proper mask.
>>
>> Signed-off-by: Ben Zhang <benzh@chromium.org>
>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Anatol Pomozov <anatol.pomozov@gmail.com>

>
> Thanks.
>
>> ---
>>   sound/soc/codecs/ssm4567.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
>> index 4662587..a757ab8 100644
>> --- a/sound/soc/codecs/ssm4567.c
>> +++ b/sound/soc/codecs/ssm4567.c
>> @@ -315,7 +315,13 @@ static int ssm4567_set_dai_fmt(struct snd_soc_dai
>> *dai, unsigned int fmt)
>>         if (invert_fclk)
>>                 ctrl1 |= SSM4567_SAI_CTRL_1_FSYNC;
>>
>> -       return regmap_write(ssm4567->regmap, SSM4567_REG_SAI_CTRL_1,
>> ctrl1);
>> +       return regmap_update_bits(ssm4567->regmap, SSM4567_REG_SAI_CTRL_1,
>> +                       SSM4567_SAI_CTRL_1_BCLK |
>> +                       SSM4567_SAI_CTRL_1_FSYNC |
>> +                       SSM4567_SAI_CTRL_1_LJ |
>> +                       SSM4567_SAI_CTRL_1_TDM |
>> +                       SSM4567_SAI_CTRL_1_PDM,
>> +                       ctrl1);
>>   }
>>
>>   static int ssm4567_set_power(struct ssm4567 *ssm4567, bool enable)
>>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
