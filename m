From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [RFC PATCH 6/6] soundwire: qcom: add support for
 SoundWire controller
Date: Tue, 11 Jun 2019 11:29:54 +0100
Message-ID: <462620fc-ac91-6a36-46c7-7af0080f06cb@linaro.org>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
 <249f9647-94d0-41d7-3b95-64c36d90f8e8@linux.intel.com>
 <40ea774c-8aa8-295d-e91e-71423b03c88d@linaro.org>
 <7269521a-ac89-3856-c18c-ffaaf64c0806@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7269521a-ac89-3856-c18c-ffaaf64c0806@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, vkoul@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org



On 10/06/2019 15:12, Pierre-Louis Bossart wrote:
>>>> +
>>>> +    if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>>>> +        ctrl->fifo_status = 0;
>>>> +        ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>>>> +                          msecs_to_jiffies(TIMEOUT_MS));
>>>
>>> This is odd. The SoundWire spec does not handle writes to a single 
>>> device or broadcast writes differently. I don't see a clear reason 
>>> why you would only timeout for a broadcast write.
>>>
>>
>> There is danger of blocking here without timeout.
> 
> Right, and it's fine to add a timeout. The question is why add a timeout 
> *only* for a broadcast operation? It should be added for every 
> transaction IMO, unless you have a reason not to do so.
> 

I did try this before, the issue is when we read/write registers from 
interrupt handler, these can be deadlocked as we will be interrupt 
handler waiting for another completion interrupt, which will never 
happen unless we return from the first interrupt.

thanks,
srini

>>>
