From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/4] soundwire: core: add device tree support for slave
 devices
Date: Fri, 9 Aug 2019 09:24:45 +0100
Message-ID: <ff9144ce-a4d1-a3fd-ab49-256367413b11@linaro.org>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
 <42ca4170-0fa0-6951-f568-89a05c095d5a@linux.intel.com>
 <564f5fa4-59ec-b4e5-a7a5-29dee99039b3@linaro.org>
 <20190809054602.GK12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809054602.GK12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/08/2019 06:46, Vinod Koul wrote:
>>>> +int sdw_of_find_slaves(struct sdw_bus *bus)
>>>> +{
>>>> +    struct device *dev = bus->dev;
>>>> +    struct device_node *node;
>>>> +
>>>> +    for_each_child_of_node(bus->dev->of_node, node) {
>>>> +        struct sdw_slave_id id;
>>>> +        const char *compat = NULL;
>>>> +        int unique_id, ret;
>>>> +        int ver, mfg_id, part_id, class_id;
>>>> +
>>>> +        compat = of_get_property(node, "compatible", NULL);
>>>> +        if (!compat)
>>>> +            continue;
>>>> +
>>>> +        ret = sscanf(compat, "sdw%x,%x,%x,%x",
>>>> +                 &ver, &mfg_id, &part_id, &class_id);
>>>> +        if (ret != 4) {
>>>> +            dev_err(dev, "Manf ID & Product code not found %s\n",
>>>> +                compat);
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        ret = of_property_read_u32(node, "sdw-instance-id", &unique_id);
>>>> +        if (ret) {
>>>> +            dev_err(dev, "Instance id not found:%d\n", ret);
>>>> +            continue;
>>> I am confused here.
>>> If you have two identical devices on the same link, isn't this property
>>> required and that should be a real error instead of a continue?
>> Yes, I agree it will be mandatory in such cases.
>>
>> Am okay either way, I dont mind changing it to returning EINVAL in all the
>> cases.
> Do we want to abort? We are in loop scanning for devices so makes sense
> if we do not do that and continue to check next one..

That was my inital plan.
Pierre suggested a better compatible to include instance ID and LinkID 
so this check would be part of the check one before this line.

--srini
