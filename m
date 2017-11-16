From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 03/14] soundwire: Add Master registration
Date: Thu, 16 Nov 2017 16:05:22 +0000
Message-ID: <2ba56597-2178-6389-bc4d-153a17505981@linaro.org>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 2283026716A
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 17:05:26 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id l8so1204447wmg.4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 08:05:26 -0800 (PST)
In-Reply-To: <1510314556-13002-4-git-send-email-vinod.koul@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, Sudheer Papothi <spapothi@codeaurora.org>, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org



On 10/11/17 11:49, Vinod Koul wrote:
> A Master registers with SoundWire bus and scans the firmware provided
> for device description. In this patch we scan the ACPI namespaces and
> create the SoundWire Slave devices based on the ACPI description
> 
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>   drivers/soundwire/Makefile    |   2 +-
>   drivers/soundwire/bus.c       | 163 +++++++++++++++++++++++++++++++++++++++
>   drivers/soundwire/bus.h       |  20 +++++
>   drivers/soundwire/slave.c     | 172 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/soundwire/sdw.h |  11 +++
>   5 files changed, 367 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soundwire/bus.c
>   create mode 100644 drivers/soundwire/slave.c
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index d1281def7662..c875e434f8b3 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -3,5 +3,5 @@
>   #
>   
>   #Bus Objs
> -soundwire-bus-objs := bus_type.o
> +soundwire-bus-objs := bus_type.o bus.o slave.o

> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/pm_runtime.h>
Does this belong to this patch.

> +#include <linux/soundwire/sdw.h>
> +#include "bus.h"
> +
> +/**
> + * sdw_add_bus_master: add a bus Master instance
> + *
> + * @bus: bus instance
> + *
> + * Initializes the bus instance, read properties and create child
> + * devices.
> + */
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
> +	 * Enumeration device number and broadcast device number are
> +	 * not used for assignment so mask these and other higher bits
> +	 */
> +
> +	/* Set higher order bits */
> +	*bus->assigned = ~GENMASK(SDW_BROADCAST_DEV_NUM, SDW_ENUM_DEV_NUM);
Can't we use ida for this.
This would also cut down code added for allocating dev_num.

> +
> +	/* Set device number and broadcast device number */
> +	set_bit(SDW_ENUM_DEV_NUM, bus->assigned);
> +	set_bit(SDW_BROADCAST_DEV_NUM, bus->assigned);

> +	return 0;
> +}
> +EXPORT_SYMBOL(sdw_add_bus_master);
> +
> +static int sdw_delete_slave(struct device *dev, void *data)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_bus *bus = slave->bus;
> +
> +	mutex_lock(&bus->bus_lock);
> +
> +	if (slave->dev_num) /* clear dev_num if assigned */
> +		clear_bit(slave->dev_num, bus->assigned);
> +
> +	list_del_init(&slave->node);
> +	mutex_unlock(&bus->bus_lock);
> +
> +	device_unregister(dev);
> +	return 0;
> +}
> +
> +void sdw_delete_bus_master(struct sdw_bus *bus)
> +{
> +	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
> +}
> +EXPORT_SYMBOL(sdw_delete_bus_master);
No kerneldoc..??

> +
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> new file mode 100644
> index 000000000000..4bf2a6cf732c
> --- /dev/null
> +++ b/drivers/soundwire/slave.c

> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/soundwire/sdw.h>
> +#include "bus.h"
> +
> +}
> +
> +static int sdw_slave_add(struct sdw_bus *bus,
> +		struct sdw_slave_id *id, struct fwnode_handle *fwnode)
> +{
> +	struct sdw_slave *slave;
> +	int ret;
> +
> +	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
> +	if (!slave)
> +		return -ENOMEM;
> +
> +	/* Initialize data structure */
> +	memcpy(&slave->id, id, sizeof(*id));
> +	slave->dev.parent = bus->dev;
> +	slave->dev.fwnode = fwnode;
> +
> +	/* name shall be sdw:link:mfg:part:class:unique */
> +	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
> +			bus->link_id, id->mfg_id, id->part_id,
> +			id->class_id, id->unique_id);
> +
> +	slave->dev.release = sdw_slave_release;
> +	slave->dev.bus = &sdw_bus_type;
> +	slave->bus = bus;
> +	slave->status = SDW_SLAVE_UNATTACHED;
> +	slave->dev_num = 0;
> +
> +	mutex_lock(&bus->bus_lock);
> +	list_add_tail(&slave->node, &bus->slaves);
> +	mutex_unlock(&bus->bus_lock);
> +
> +	ret = device_register(&slave->dev);
> +	if (ret) {
> +		dev_err(bus->dev, "Failed to add slave: ret %d\n", ret);
> +
> +		/*
> +		 * On err, don't free but drop ref as this will be freed
> +		 * when release method is invoked.
> +		 */
> +		mutex_lock(&bus->bus_lock);
> +		list_del(&slave->node);
> +		mutex_unlock(&bus->bus_lock);
> +		put_device(&slave->dev);
> +		return ret;

remove this line and ..
> +	}
> +
> +	return 0;

	return ret;

> +
> 
> +#endif
> +
> +#if IS_ENABLED(CONFIG_OF)
> +int sdw_of_find_slaves(struct sdw_bus *bus)
> +{
> +	/* placeholder now, fill on OF support */
> +	return -ENOTSUPP;
> +}
> +#endif

We should probably remove this dummy function, and add this 
functionality later.
