From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [RFC PATCH 6/6] soundwire: qcom: add support for
 SoundWire controller
Date: Sat, 15 Jun 2019 14:24:25 +0100
Message-ID: <d3ccd866-7bc5-9635-4bb4-6b0765f89835@linaro.org>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
 <249f9647-94d0-41d7-3b95-64c36d90f8e8@linux.intel.com>
 <40ea774c-8aa8-295d-e91e-71423b03c88d@linaro.org>
 <7269521a-ac89-3856-c18c-ffaaf64c0806@linux.intel.com>
 <462620fc-ac91-6a36-46c7-7af0080f06cb@linaro.org>
 <0e836692-2297-4cb7-d681-76692db78a56@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0e836692-2297-4cb7-d681-76692db78a56@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, vkoul@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 11/06/2019 13:21, Pierre-Louis Bossart wrote:
> 
> 
> On 6/11/19 5:29 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 10/06/2019 15:12, Pierre-Louis Bossart wrote:
>>>>>> +
>>>>>> +    if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>>>>>> +        ctrl->fifo_status = 0;
>>>>>> +        ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>>>>>> +                          msecs_to_jiffies(TIMEOUT_MS));
>>>>>
>>>>> This is odd. The SoundWire spec does not handle writes to a single 
>>>>> device or broadcast writes differently. I don't see a clear reason 
>>>>> why you would only timeout for a broadcast write.
>>>>>
>>>>
>>>> There is danger of blocking here without timeout.
>>>
>>> Right, and it's fine to add a timeout. The question is why add a 
>>> timeout *only* for a broadcast operation? It should be added for 
>>> every transaction IMO, unless you have a reason not to do so.
>>>
>>
>> I did try this before, the issue is when we read/write registers from 
>> interrupt handler, these can be deadlocked as we will be interrupt 
>> handler waiting for another completion interrupt, which will never 
>> happen unless we return from the first interrupt.
> 
> I don't quite get the issue. With the Intel hardware we only deal with 
> Master registers (some of which mirror the bus state) in the handler and 
> will only modify Slave registers in the thread. All changes to Slave 
> registers will be subject to a timeout as well as a check for no 
> response or NAK. Not sure what is specific about your solution that 
> requires a different handling of commands depending on which device 
> number is used. It could very well be that you've uncovered a flaw in 
> the bus design but I still don't see how it would be Qualcomm-specific?

Sorry It took bit more time for digging up the issue which I faced 
previously to answer this query. This is now fixed and v2 patchset has 
same handling for all the slave registers read/writes with no special 
casing.

Thanks,
srini
