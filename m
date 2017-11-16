From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 02/14] soundwire: Add SoundWire bus type
Date: Thu, 16 Nov 2017 16:05:17 +0000
Message-ID: <cb4fbc87-7857-5ab3-a2cd-413ee57c463e@linaro.org>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id ADE24266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 17:05:25 +0100 (CET)
Received: by mail-wr0-f195.google.com with SMTP id u97so23289769wrc.1
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 08:05:25 -0800 (PST)
In-Reply-To: <1510314556-13002-3-git-send-email-vinod.koul@intel.com>
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
> index 000000000000..9b3dca95a098
> --- /dev/null
> +++ b/drivers/soundwire/bus.h
> +
> +#ifndef __SDW_BUS_H
> +#define __SDW_BUS_H
> +
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/acpi.h>

Do you need all these headers as part of this patch?

> +#include <linux/soundwire/sdw.h>
> +
> +int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
> +
> +#endif /* __SDW_BUS_H */
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> new file mode 100644
> index 000000000000..3e97a8284871
> --- /dev/null
> +++ b/drivers/soundwire/bus_type.c
> @@ -0,0 +1,227 @@
...

> +static const struct sdw_device_id *
> +sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
Indentation looks Odd here,

> +{
> +	const struct sdw_device_id *id = drv->id_table;
> +
> +	while (id && id->mfg_id) {
> +		if (slave->id.mfg_id == id->mfg_id &&
> +		    slave->id.part_id == id->part_id)
> +			return id;
> +		id++;
> +	}
> +
> +	return NULL;
> +}
...
> +
> +static int sdw_drv_probe(struct device *dev)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
> +	const struct sdw_device_id *id;
> +	int ret;
...
> +	/*
> +	 * attach to power domain but don't turn on (last arg)
> +	 */
> +	ret = dev_pm_domain_attach(dev, false);
> +	if (ret) {

I think we discussed this in v1, but erring out here means that all the 
devices need to have pm domain  attached, which might not be true all 
the time.

> +		dev_err(dev, "Failed to attach PM domain: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = drv->probe(slave, id);
> +	if (ret) {
> +		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
> +		dev_pm_domain_detach(dev, false);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +
>
...

> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> +#ifndef __SOUNDWIRE_H
> +#define __SOUNDWIRE_H
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +
> +struct sdw_bus;
> +struct sdw_slave;
> +
> +#define SDW_MAX_DEVICES			11
> +
> +/**
> + * enum sdw_slave_status: Slave status
> + *
> + * @SDW_SLAVE_UNATTACHED: Slave is not attached with the bus.
> + * @SDW_SLAVE_ATTACHED: Slave is attached with bus.
> + * @SDW_SLAVE_ALERT: Some alert condition on the Slave
> + * @SDW_SLAVE_RESERVED: Reserved for future use
> + */
> +enum sdw_slave_status {
> +	SDW_SLAVE_UNATTACHED = 0,
> +	SDW_SLAVE_ATTACHED = 1,
> +	SDW_SLAVE_ALERT = 2,
> +	SDW_SLAVE_RESERVED = 3,
> +};
> +
> +/*
> + * SDW Slave Structures and APIs
> + */
> +
> +/**
> + * struct sdw_slave_id: Slave ID
> + *
Do we need an empty line Here?? same thing for all the kernel doc comments.

Also looking at examples in Documentation/doc-guide/kernel-doc.rst

struct should follow with  - instead of :
same for functions..
