From: Sebastien Jan <sjan@baylibre.com>
Subject: Re: [PATCH] mfd: arizona: Add DT binding for irq_gpio
	property
Date: Tue, 3 Nov 2015 14:47:01 +0100
Message-ID: <5638BAD5.7050005@baylibre.com>
References: <1446549612-18221-1-git-send-email-sjan@baylibre.com>
 <20151103132952.GF3503@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 36C6D2606D6
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 14:47:05 +0100 (CET)
Received: by wicfx6 with SMTP id fx6so69700082wic.1
 for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2015 05:47:04 -0800 (PST)
In-Reply-To: <20151103132952.GF3503@x1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 03/11/2015 14:29, Lee Jones wrote:
> On Tue, 03 Nov 2015, Sebastien Jan wrote:
>
>> Signed-off-by: Sebastien Jan <sjan@baylibre.com>
>> ---
>>   drivers/mfd/arizona-core.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
>> index 44cfdbb..23a0f93 100644
>> --- a/drivers/mfd/arizona-core.c
>> +++ b/drivers/mfd/arizona-core.c
>> @@ -814,6 +814,11 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
>>   		count++;
>>   	}
>>   
>> +	arizona->pdata.irq_gpio = of_get_named_gpio(arizona->dev->of_node,
>> +							"wlf,irq_gpio", 0);
>> +	if (arizona->pdata.irq_gpio < 0)
>> +		arizona->pdata.irq_gpio = 0;
> This is wrong on a number of levels.
>
> Firstly, all properties must be documented.  Secondly, underscores
> aren't allowed in DT.  Thirdly, this is a generic binding -- no need
> for the vendor prefix.  And lastly, GPIO bindings already have a
> format -- it should be simply 'irq-gpios'.
Thanks Lee, I'll post a v2 with these changes (and updated bindings 
document).
