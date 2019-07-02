From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 2/5] soundwire: core: add device tree support for
 slave devices
Date: Tue, 2 Jul 2019 09:22:08 +0100
Message-ID: <c2b74c2c-0491-fdd1-3967-b3332645d8df@linaro.org>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
 <20190611104043.22181-3-srinivas.kandagatla@linaro.org>
 <20190701061745.GK2911@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190701061745.GK2911@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, bgoswami@quicinc.com
List-Id: alsa-devel@alsa-project.org

Thanks for review,

On 01/07/2019 07:17, Vinod Koul wrote:
> On 11-06-19, 11:40, Srinivas Kandagatla wrote:
>> This patch adds support to parsing device tree based
>> SoundWire slave devices.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/bus.c   |  2 +-
>>   drivers/soundwire/bus.h   |  1 +
>>   drivers/soundwire/slave.c | 54 ++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 55 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index fe745830a261..20f26cf4ba74 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -78,7 +78,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>>   	if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
>>   		ret = sdw_acpi_find_slaves(bus);
>>   	else
>> -		ret = -ENOTSUPP; /* No ACPI/DT so error out */
>> +		ret = sdw_of_find_slaves(bus);
>>   
>>   	if (ret) {
>>   		dev_err(bus->dev, "Finding slaves failed:%d\n", ret);
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
>> index f39a5815e25d..6e7f5cfeb854 100644
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
>> @@ -28,13 +29,14 @@ static int sdw_slave_add(struct sdw_bus *bus,
>>   	slave->dev.parent = bus->dev;
>>   	slave->dev.fwnode = fwnode;
>>   
>> -	/* name shall be sdw:link:mfg:part:class:unique */
>> +	/* name shall be sdw:link:mfg:part:class */
> 
> nope we are not changing dev_set_name below so this comment should not
> be modified

Am not sure why this change was here, I will remove this!
> 
>>   	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
>>   		     bus->link_id, id->mfg_id, id->part_id,
>>   		     id->class_id, id->unique_id);
>>   
>>   	slave->dev.release = sdw_slave_release;
>>   	slave->dev.bus = &sdw_bus_type;
>> +	slave->dev.of_node = of_node_get(to_of_node(fwnode));
>>   	slave->bus = bus;
>>   	slave->status = SDW_SLAVE_UNATTACHED;
>>   	slave->dev_num = 0;
>> @@ -112,3 +114,53 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>   }
>>   
>>   #endif
>> +
>> +#if IS_ENABLED(CONFIG_OF)
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
>> +	if (!bus->dev->of_node)
>> +		return 0;
> 
> this should be error, otherwise next condition of checking slaves wont
> be triggered..
> 
I agree! will fix this in next version.
