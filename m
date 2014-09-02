From: "Peter S. Housel" <housel@acm.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: place codec into
 reset state initially
Date: Tue, 02 Sep 2014 13:25:53 -0700
Message-ID: <540627D1.2070108@acm.org>
References: <1407190401-3712-1-git-send-email-housel@acm.org>
 <avb91o01X1j0zgo01vbBxr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmfepo101.cox.net (fed1rmfepo101.cox.net [68.230.241.143])
 by alsa0.perex.cz (Postfix) with ESMTP id A98C9265510
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 22:25:58 +0200 (CEST)
Received: from fed1rmimpo109 ([68.230.241.158]) by fed1rmfepo101.cox.net
 (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
 id <20140902202557.ZFQB29651.fed1rmfepo101.cox.net@fed1rmimpo109>
 for <alsa-devel@alsa-project.org>; Tue, 2 Sep 2014 16:25:57 -0400
In-Reply-To: <avb91o01X1j0zgo01vbBxr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Ping...

Thanks,
-Peter-

On 08/05/2014 12:34 AM, Jyri Sarha wrote:
> On 08/05/2014 01:13 AM, Peter S. Housel wrote:
>> Previously the driver would only place the TLV320AIC31XX into reset
>> using the gpio reset line when at least one of the power supply
>> regulators was disabled, so that if these supplies were always enabled
>> no reset would ever occur. This change resets the codec state at probe
>> time so that the initial register cache values are correct.
>>
>> Signed-off-by: Peter S. Housel <housel@acm.org>
>> ---
>>   sound/soc/codecs/tlv320aic31xx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/codecs/tlv320aic31xx.c 
>> b/sound/soc/codecs/tlv320aic31xx.c
>> index 0f64c78..89a4daf 100644
>> --- a/sound/soc/codecs/tlv320aic31xx.c
>> +++ b/sound/soc/codecs/tlv320aic31xx.c
>> @@ -1194,7 +1194,7 @@ static int aic31xx_device_init(struct 
>> aic31xx_priv *aic31xx)
>>       if (aic31xx->pdata.gpio_reset) {
>>           ret = devm_gpio_request_one(aic31xx->dev,
>>                           aic31xx->pdata.gpio_reset,
>> -                        GPIOF_OUT_INIT_HIGH,
>> +                        GPIOF_OUT_INIT_LOW,
>>                           "aic31xx-reset-pin");
>>           if (ret < 0) {
>>               dev_err(aic31xx->dev, "not able to acquire gpio\n");
>>
>
> Oops, aic3111 and friends indeed have an active low reset line. The 
> line was not behind a gpio on my board.
>
> Acked-by: Jyri Sarha <jsarha@ti.com>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
