From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [RFC PATCH 2/2] ASoC: samsung: Print a one-time message if the
 snow driver's probe defers
Date: Wed, 19 Oct 2016 15:16:30 -0300
Message-ID: <77594681-a147-3fbe-25f4-a455d605a509@osg.samsung.com>
References: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
 <1476897666-13974-3-git-send-email-javier@osg.samsung.com>
 <20161019181205.GA10034@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161019181205.GA10034@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hello Krzysztof,

Thanks a lot for your feedback.

On 10/19/2016 03:12 PM, Krzysztof Kozlowski wrote:
> On Wed, Oct 19, 2016 at 02:21:06PM -0300, Javier Martinez Canillas wrote:
>> If the snd_soc_register_card() fails due a missing resource and the probe
>> has to be deferred, the driver prints an error message.
>>
>> But since many probe retries can happen before a resource is available,
>> the printed messages can spam the kernel log buffer and slow the boot.
>>
>> The information is useful to know that a dependency was not meet and a
>> defer happened, but isn't necessary to print it on each probe deferral.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
>>
>>  sound/soc/samsung/snow.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
>> index d8ac907bbb0d..068bfb78a668 100644
>> --- a/sound/soc/samsung/snow.c
>> +++ b/sound/soc/samsung/snow.c
>> @@ -103,7 +103,13 @@ static int snow_probe(struct platform_device *pdev)
>>  
>>  	ret = devm_snd_soc_register_card(&pdev->dev, card);
>>  	if (ret) {
>> -		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
>> +		if (ret == -EPROBE_DEFER)
>> +			dev_err_once(&pdev->dev,
>> +				     "snd_soc_register_card deferred (%d)\n",
>> +				     ret);
> 
> dev_warn_once? I understand you didn't want to change the logic behind
> this but this is not really an error condition. Probe deferral happens
> and one should not be worried seeing it once in 'dmesg -l err'.
>

Exactly, I even thought about doing that change (or even dev_dbg_once) but
I didn't want to change the current logic.
 
> Another point is now we would miss different error condition - infinite
> (or very long) probe deferral. I am not sure how useful it might be but
> theoretically seeing many deferrals is a sign of something to fix.
>

Yes, not sure how we can have both though. Maybe dev_{err,warn}_ratelimit
is a good trade off?
 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
