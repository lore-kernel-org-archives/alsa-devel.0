From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake: "Stoping" ->
 "Stopping"
Date: Tue, 3 Apr 2018 10:50:24 +0200
Message-ID: <051e667b-6a62-1c9c-344f-c1aed341fe8d@microchip.com>
References: <20180330154420.6903-1-colin.king@canonical.com>
 <20180331085420.GE14180@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180331085420.GE14180@piout.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Colin King <colin.king@canonical.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 31/03/2018 at 10:54, Alexandre Belloni wrote:
> On 30/03/2018 at 16:44:20 +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Trivial fix to spelling mistake in pr_debug message text
>>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   sound/soc/atmel/atmel_ssc_dai.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
>> index a1e2c5682dcd..1c7af0ca98ec 100644
>> --- a/sound/soc/atmel/atmel_ssc_dai.c
>> +++ b/sound/soc/atmel/atmel_ssc_dai.c
>> @@ -820,7 +820,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>>   		if (ret < 0) {
>>   			printk(KERN_WARNING
>>   					"atmel_ssc_dai: request_irq failure\n");
>> -			pr_debug("Atmel_ssc_dai: Stoping clock\n");
>> +			pr_debug("Atmel_ssc_dai: Stopping clock\n");
>>   			clk_disable(ssc_p->ssc->clk);
>>   			return ret;
>>   		}
>> -- 
>> 2.15.1
>>
> 


-- 
Nicolas Ferre
