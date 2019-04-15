From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: cdns: Fix compilation error on
 arm64
Date: Mon, 15 Apr 2019 07:41:33 -0500
Message-ID: <8ba31402-b507-5060-76be-89a7ddaf7dca@linux.intel.com>
References: <20190404081221.341-1-jank@cadence.com>
 <20190414094408.GF28103@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190414094408.GF28103@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Jan Kotas <jank@cadence.com>
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index cb6a331f4..0b5bcc209 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/device.h>
>>   #include <linux/interrupt.h>
>> +#include <linux/io.h>
> 
> Why not add asm/io.h which is the header that actually defines
> readl/writel?

The vast majority of kernel code uses linux/io.h.
We use linux/io.h for SOF as well.

> 
>>   #include <linux/module.h>
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/soundwire/sdw_registers.h>
>> -- 
>> 2.15.0
> 
