From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 6/6] soundwire: qcom: add support for
 SoundWire controller
Date: Mon, 10 Jun 2019 09:12:39 -0500
Message-ID: <7269521a-ac89-3856-c18c-ffaaf64c0806@linux.intel.com>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
 <249f9647-94d0-41d7-3b95-64c36d90f8e8@linux.intel.com>
 <40ea774c-8aa8-295d-e91e-71423b03c88d@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <40ea774c-8aa8-295d-e91e-71423b03c88d@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org, vkoul@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org


>>> +#define SWRM_COMP_HW_VERSION                    0x00
>>
>> Can we please use SDW_ or QCOM_SDW_ as prefix?
>>
> 
> SWRM prefix is as per the data sheet register names, If it help am happy 
> to add QCOM_ prefix it.

That'd be fine. As long as there is no duplication and two 
terms/prefixes used for the same thing I am happy.

>>> +
>>> +    val = SWRM_REG_VAL_PACK(cmd_data, dev_addr, cmd_id, reg_addr);
>>> +    ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
>>> +    if (ret < 0) {
>>> +        dev_err(ctrl->dev, "%s: reg 0x%x write failed, err:%d\n",
>>> +            __func__, val, ret);
>>> +        goto err;
>>> +    }
>>> +
>>> +    if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>>> +        ctrl->fifo_status = 0;
>>> +        ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>>> +                          msecs_to_jiffies(TIMEOUT_MS));
>>
>> This is odd. The SoundWire spec does not handle writes to a single 
>> device or broadcast writes differently. I don't see a clear reason why 
>> you would only timeout for a broadcast write.
>>
> 
> There is danger of blocking here without timeout.

Right, and it's fine to add a timeout. The question is why add a timeout 
*only* for a broadcast operation? It should be added for every 
transaction IMO, unless you have a reason not to do so.

>>
>>> +
>>> +    /* Mask soundwire interrupts */
>>> +    ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR,
>>> +                    SWRM_INTERRUPT_STATUS_RMSK);
>>> +
>>> +    /* Configure No pings */
>>> +    val = ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR);
>>
>> If there is any sort of PREQ signaling for Slave-initiated interrupts, 
>> disabling PINGs is likely a non-conformant implementation since the 
>> master is required to issue a PING command within 32 frames. That's 
>> also the only way to know if a device is attached, so additional 
>> comments are likely required.
> This is the value of Maximum number of consiecutive read/write commands 
> without ping command in between. I will try to collect more details and 
> add some comments here.

Right, so it's probably the comment that's too strict. It's not no pings 
it's no pings during a sequence of up to N read/writes.
