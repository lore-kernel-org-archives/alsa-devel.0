From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/4] soundwire: core: add device tree support for slave
 devices
Date: Thu, 8 Aug 2019 10:00:40 -0500
Message-ID: <42ca4170-0fa0-6951-f568-89a05c095d5a@linux.intel.com>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org, broonie@kernel.org
Cc: bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


> @@ -35,6 +36,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
>   
>   	slave->dev.release = sdw_slave_release;
>   	slave->dev.bus = &sdw_bus_type;
> +	slave->dev.of_node = of_node_get(to_of_node(fwnode));

shouldn't this protected by
#if IS_ENABLED(CONFIG_OF) ?

>   	slave->bus = bus;
>   	slave->status = SDW_SLAVE_UNATTACHED;
>   	slave->dev_num = 0;
> @@ -112,3 +114,48 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>   }
>   
>   #endif
> +
> +/*
> + * sdw_of_find_slaves() - Find Slave devices in master device tree node
> + * @bus: SDW bus instance
> + *
> + * Scans Master DT node for SDW child Slave devices and registers it.
> + */
> +int sdw_of_find_slaves(struct sdw_bus *bus)
> +{
> +	struct device *dev = bus->dev;
> +	struct device_node *node;
> +
> +	for_each_child_of_node(bus->dev->of_node, node) {
> +		struct sdw_slave_id id;
> +		const char *compat = NULL;
> +		int unique_id, ret;
> +		int ver, mfg_id, part_id, class_id;
> +
> +		compat = of_get_property(node, "compatible", NULL);
> +		if (!compat)
> +			continue;
> +
> +		ret = sscanf(compat, "sdw%x,%x,%x,%x",
> +			     &ver, &mfg_id, &part_id, &class_id);
> +		if (ret != 4) {
> +			dev_err(dev, "Manf ID & Product code not found %s\n",
> +				compat);
> +			continue;
> +		}
> +
> +		ret = of_property_read_u32(node, "sdw-instance-id", &unique_id);
> +		if (ret) {
> +			dev_err(dev, "Instance id not found:%d\n", ret);
> +			continue;

I am confused here.
If you have two identical devices on the same link, isn't this property 
required and that should be a real error instead of a continue?

> +		}
> +
> +		id.sdw_version = ver - 0xF;

maybe a comment in the code would help to make the encoding 
self-explanatory, as you did in the DT bindings

   Version number '0x10' represents SoundWire 1.0
   Version number '0x11' represents SoundWire 1.1

> +		id.unique_id = unique_id;
> +		id.mfg_id = mfg_id;
> +		id.part_id = part_id;
> +		id.class_id = class_id;
> +		sdw_slave_add(bus, &id, of_fwnode_handle(node));
> +	}
> +	return 0;
> +}
> 
