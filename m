From: Danny Smith <danny.smith@axis.com>
Subject: Re: [PATCH] ASoC: sigmadsp: safeload should be used
	from 4 bytes
Date: Wed, 22 Aug 2018 09:53:48 +0200
Message-ID: <b480bfae-8a3b-a619-f7c4-1aede7969dda@axis.com>
References: <20180822061131.13191-1-robertr@axis.com>
 <ef680c4a-3b28-e28c-0164-085330ec2dee@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BEB926766C
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 09:53:49 +0200 (CEST)
In-Reply-To: <ef680c4a-3b28-e28c-0164-085330ec2dee@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>, Robert Rosengren <robertr@axis.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 08/22/2018 08:34 AM, Lars-Peter Clausen wrote:
> On 08/22/2018 08:11 AM, Robert Rosengren wrote:
>> From: Danny Smith <dannys@axis.com>
>>
>> Fixed range in safeload conditional to allow safeload to be used from
>> 4 bytes.
> Hi,
>
> Thanks for the patch. The reason why 4 bytes is excluded is that up to 4
> bytes can be updated atomically with a single register write. But I could
> see that if the firmware reads the same parameter multiple times during the
> same run you could get inconsistent results.
>
> Can you explain a bit more why you need this?
>
> If we want to allow safeload for 4 byte parameters the same reasoning
> applies for parameters with less than 4 bytes as well and so the check
> should be removed completely.
>
> - Lars
Hi,

Thanks for the feedback. It is correct that up to 4 bytes can be updated 
atomically but does that also guarantee that the data is safeloaded, 
i.e. updated when the parameter is not in use? Maybe updating up to 4 
byte parameters without safeload does not cause audio glitches?

Regards,
Danny
>> Signed-off-by: Danny Smith <dannys@axis.com>
>> ---
>>   sound/soc/codecs/sigmadsp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
>> index d53680ac78e4..d63d58350cd8 100644
>> --- a/sound/soc/codecs/sigmadsp.c
>> +++ b/sound/soc/codecs/sigmadsp.c
>> @@ -117,7 +117,7 @@ static int sigmadsp_ctrl_write(struct sigmadsp *sigmadsp,
>>   	struct sigmadsp_control *ctrl, void *data)
>>   {
>>   	/* safeload loads up to 20 bytes in a atomic operation */
>> -	if (ctrl->num_bytes > 4 && ctrl->num_bytes <= 20 && sigmadsp->ops &&
>> +	if (ctrl->num_bytes >= 4 && ctrl->num_bytes <= 20 && sigmadsp->ops &&
>>   	    sigmadsp->ops->safeload)
>>   		return sigmadsp->ops->safeload(sigmadsp, ctrl->addr, data,
>>   			ctrl->num_bytes);
>>
