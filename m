From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/4] soundwire: core: add device tree support for slave
 devices
Date: Fri, 9 Aug 2019 09:24:54 +0100
Message-ID: <5deac3ae-87b3-c9ce-72ac-bf605db35231@linaro.org>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
 <20190809050700.GJ12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809050700.GJ12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/08/2019 06:07, Vinod Koul wrote:
> On 08-08-19, 15:45, Srinivas Kandagatla wrote:
>> This patch adds support to parsing device tree based
>> SoundWire slave devices.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/bus.c   |  2 ++
>>   drivers/soundwire/bus.h   |  1 +
>>   drivers/soundwire/slave.c | 47 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index fe745830a261..324c54dc52fb 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -77,6 +77,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>>   	 */
>>   	if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
>>   		ret = sdw_acpi_find_slaves(bus);
>> +	else if (IS_ENABLED(CONFIG_OF) && bus->dev->of_node)
>> +		ret = sdw_of_find_slaves(bus);
>>   	else
>>   		ret = -ENOTSUPP; /* No ACPI/DT so error out */
>>   
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 3048ca153f22..ee46befedbd1 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -15,6 +15,7 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>   }
>>   #endif
>>   
>> +int sdw_of_find_slaves(struct sdw_bus *bus);
>>   void sdw_extract_slave_id(struct sdw_bus *bus,
>>   			  u64 addr, struct sdw_slave_id *id);
>>   
>> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
>> index f39a5815e25d..8ab76f5d5a56 100644
>> --- a/drivers/soundwire/slave.c
>> +++ b/drivers/soundwire/slave.c
>> @@ -2,6 +2,7 @@
>>   // Copyright(c) 2015-17 Intel Corporation.
>>   
>>   #include <linux/acpi.h>
>> +#include <linux/of.h>
>>   #include <linux/soundwire/sdw.h>
>>   #include <linux/soundwire/sdw_type.h>
>>   #include "bus.h"
>> @@ -35,6 +36,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
>>   
>>   	slave->dev.release = sdw_slave_release;
>>   	slave->dev.bus = &sdw_bus_type;
>> +	slave->dev.of_node = of_node_get(to_of_node(fwnode));
>>   	slave->bus = bus;
>>   	slave->status = SDW_SLAVE_UNATTACHED;
>>   	slave->dev_num = 0;
>> @@ -112,3 +114,48 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>   }
>>   
>>   #endif
>> +
>> +/*
>> + * sdw_of_find_slaves() - Find Slave devices in master device tree node
>> + * @bus: SDW bus instance
>> + *
>> + * Scans Master DT node for SDW child Slave devices and registers it.
>> + */
>> +int sdw_of_find_slaves(struct sdw_bus *bus)
>> +{
>> +	struct device *dev = bus->dev;
>> +	struct device_node *node;
>> +
>> +	for_each_child_of_node(bus->dev->of_node, node) {
>> +		struct sdw_slave_id id;
>> +		const char *compat = NULL;
>> +		int unique_id, ret;
>> +		int ver, mfg_id, part_id, class_id;
>> +
>> +		compat = of_get_property(node, "compatible", NULL);
>> +		if (!compat)
>> +			continue;
> 
> Why not use of_find_compatible_node() that will return the node which is
> sdw* and we dont need to checks on that..

Am not sure if wild characters are really supported in this api.
Also AFIU, it would not very optimal to use this api and it would 
complicate the code without much gain.


> 
>> +
>> +		ret = sscanf(compat, "sdw%x,%x,%x,%x",
>> +			     &ver, &mfg_id, &part_id, &class_id);
>> +		if (ret != 4) {
>> +			dev_err(dev, "Manf ID & Product code not found %s\n",
>> +				compat);
>> +			continue;
>> +		}
>> +
>> +		ret = of_property_read_u32(node, "sdw-instance-id", &unique_id);
>> +		if (ret) {
>> +			dev_err(dev, "Instance id not found:%d\n", ret);
>> +			continue;
>> +		}
>> +
>> +		id.sdw_version = ver - 0xF;
>> +		id.unique_id = unique_id;
>> +		id.mfg_id = mfg_id;
>> +		id.part_id = part_id;
>> +		id.class_id = class_id;
> 
> empty line here please
yep, will add that.

thanks,
srini
> 
>> +		sdw_slave_add(bus, &id, of_fwnode_handle(node));
>> +	}
> 
> and here as well
> 
>> +	return 0;
>> +}
>> -- 
>> 2.21.0
> 
