From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 03/14] soundwire: Add Master registration
Date: Thu, 9 Nov 2017 21:14:16 +0000
Message-ID: <a44f40ab-bd8b-f778-6819-73ae151c97ab@linaro.org>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508382211-3154-4-git-send-email-vinod.koul@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org



On 19/10/17 04:03, Vinod Koul wrote:

> +/**
> + * sdw_add_bus_master: add a bus Master instance
> + *
> + * @bus: bus instance
> + *
> + * Initializes the bus instance, read properties and create child
> + * devices.
> + */

Some of the exported functions are missing kerneldocs.
Is it something you plan to add in next version of the patcheset?

> +int sdw_add_bus_master(struct sdw_bus *bus)
> +{
> +	int ret;
> +
> +	if (!bus->dev) {
> +		pr_err("SoundWire bus has no device");
> +		return -ENODEV;
> +	}
> +
> +	mutex_init(&bus->bus_lock);
> +	INIT_LIST_HEAD(&bus->slaves);
> +
> +	/*
> +	 * SDW is an enumerable bus, but devices can be powered off. So,
> +	 * they won't be able to report as present.
> +	 *
> +	 * Create Slave devices based on Slaves described in
> +	 * the respective firmware (ACPI/DT)
> +	 */
> +
> +	if (IS_ENABLED(CONFIG_ACPI) && bus->dev && ACPI_HANDLE(bus->dev))
> +		ret = sdw_acpi_find_slaves(bus);
> +	else if (IS_ENABLED(CONFIG_OF) && bus->dev && bus->dev->of_node)
> +		ret = sdw_of_find_slaves(bus);
> +	else
bus->dev is already checked in the start of the function, do we need to 
check once again ?

> +		ret = -ENOTSUPP; /* No ACPI/DT so error out */
> +
> +	if (ret) {
> +		dev_err(bus->dev, "Finding slaves failed:%d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(sdw_add_bus_master);
