From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 3/3] i2c: change the id to let the i2c-gpio work
Date: Fri, 12 Oct 2012 09:53:21 +0800
Message-ID: <50777811.8020808@atmel.com>
References: <1349923097-14115-1-git-send-email-voice.shen@atmel.com> <1349923097-14115-4-git-send-email-voice.shen@atmel.com> <20121011071140.GA11726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <20121011071140.GA11726@opensource.wolfsonmicro.com>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, jm.lin@atmel.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 10/11/2012 15:11, Mark Brown wrote:
> On Thu, Oct 11, 2012 at 10:38:17AM +0800, Bo Shen wrote:
>
>>   static struct platform_device at91sam9260_twi_device = {
>>   	.name			= "i2c-gpio",
>> -	.id			= -1,
>> +	.id			= 0,
>>   	.dev.platform_data	= &pdata,
>>   };
>
> Why would this have any effect on the operation of the i2c-gpio driver?
> This suggests i2c-gpio is buggy.

This cause i2c devices can not register to the i2c bus which the device 
want.

I will send this patch to i2c maintainer.

Thanks

BR,
Bo Shen

