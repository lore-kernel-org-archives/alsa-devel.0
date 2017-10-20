From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 20 Oct 2017 12:45:28 +0200
Message-ID: <20171020104528.GC3210@kroah.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 19, 2017 at 08:33:18AM +0530, Vinod Koul wrote:
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> new file mode 100644
> index 000000000000..a14d1de80afa
> --- /dev/null
> +++ b/drivers/soundwire/bus_type.c
> @@ -0,0 +1,229 @@
> +/*
> + *  This file is provided under a dual BSD/GPLv2 license.  When using or
> + *  redistributing this file, you may do so under either license.
> + *
> + *  GPL LICENSE SUMMARY
> + *
> + *  Copyright(c) 2015-17 Intel Corporation.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of version 2 of the GNU General Public License as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  BSD LICENSE
> + *
> + *  Copyright(c) 2015-17 Intel Corporation.
> + *
> + *  Redistribution and use in source and binary forms, with or without
> + *  modification, are permitted provided that the following conditions
> + *  are met:
> + *
> + *    * Redistributions of source code must retain the above copyright
> + *      notice, this list of conditions and the following disclaimer.
> + *    * Redistributions in binary form must reproduce the above copyright
> + *      notice, this list of conditions and the following disclaimer in
> + *      the documentation and/or other materials provided with the
> + *      distribution.
> + *    * Neither the name of Intel Corporation nor the names of its
> + *      contributors may be used to endorse or promote products derived
> + *      from this software without specific prior written permission.
> + *
> + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Are you _sure_ that code that interacts with the driver core can have a
dual-license here?  Have you explained to lawyers what you are doing
here (wrapping gpl-only symbols with non-gpl-only exports)?

And why dual license something that will only ever work on Linux?

And finally, put a real SPDX header up there so that people don't have
to parse that horrid amount of text to try to determine exactly what
that license is.


> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/soundwire/sdw.h>
> +#include "bus.h"
> +
> +/**
> + * sdw_get_device_id: find the matching SoundWire device id
> + *
> + * @slave: SoundWire Slave device
> + * @drv: SoundWire Slave Driver
> + *
> + * The match is done by comparing the mfg_id and part_id from the
> + * struct sdw_device_id. class_id is unused, as it is a placeholder
> + * in MIPI Spec.
> + */
> +static const struct sdw_device_id *
> +sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
> +{
> +	const struct sdw_device_id *id = drv->id_table;
> +
> +	while (id && id->mfg_id) {
> +		if (slave->id.mfg_id == id->mfg_id &&
> +				slave->id.part_id == id->part_id) {
> +			return id;
> +		}
> +		id++;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_driver *drv = drv_to_sdw_driver(ddrv);
> +
> +	return !!sdw_get_device_id(slave, drv);
> +}
> +
> +int sdw_slave_modalias(struct sdw_slave *slave, char *buf, size_t size)
> +{
> +	/* modalias is sdw:m<mfg_id>p<part_id> */
> +
> +	return snprintf(buf, size, "sdw:m%04Xp%04X\n",
> +			slave->id.mfg_id, slave->id.part_id);
> +}
> +
> +static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	char modalias[32];
> +
> +	sdw_slave_modalias(slave, modalias, sizeof(modalias));
> +
> +	if (add_uevent_var(env, "MODALIAS=%s", modalias))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +struct bus_type sdw_bus_type = {
> +	.name = "soundwire",
> +	.match = sdw_bus_match,
> +	.uevent = sdw_uevent,
> +};
> +EXPORT_SYMBOL(sdw_bus_type);

EXPORT_SYMBOL_GPL()?

No release callback?  Who frees the device?

> +
> +static int sdw_drv_probe(struct device *dev)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
> +	const struct sdw_device_id *id;
> +	int ret;
> +
> +	id = sdw_get_device_id(slave, drv);
> +	if (!id)
> +		return -ENODEV;
> +
> +	/*
> +	 * attach to power domain but don't turn on (last arg)
> +	 */
> +	ret = dev_pm_domain_attach(dev, false);
> +	if (ret) {
> +		dev_err(dev, "Failed to attach PM domain: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = drv->probe(slave, id);
> +	if (ret) {
> +		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sdw_drv_remove(struct device *dev)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
> +
> +	if (drv->remove)
> +		drv->remove(slave);

No catching the error value?

> +
> +	dev_pm_domain_detach(dev, false);
> +
> +	return 0;
> +}
> +
> +static void sdw_drv_shutdown(struct device *dev)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
> +
> +	if (drv->shutdown)
> +		drv->shutdown(slave);
> +}
> +
> +/**
> + * __sdw_register_driver - register a SoundWire Slave driver
> + *
> + * @drv: driver to register
> + * @owner: owning module/driver
> + *
> + * Return: zero on success, else a negative error code.
> + */
> +int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
> +{
> +	drv->driver.bus = &sdw_bus_type;
> +
> +	if (!drv->probe) {
> +		pr_err("driver %s didn't provide SDW probe routine\n",
> +							drv->name);
> +		return -EINVAL;
> +	}
> +
> +	drv->driver.owner = owner;
> +	drv->driver.probe = sdw_drv_probe;
> +
> +	if (drv->remove)
> +		drv->driver.remove = sdw_drv_remove;
> +
> +	if (drv->shutdown)
> +		drv->driver.shutdown = sdw_drv_shutdown;
> +
> +	return driver_register(&drv->driver);
> +}
> +EXPORT_SYMBOL(__sdw_register_driver);
> +
> +/*
> + * sdw_unregister_driver: unregisters the SoundWire Slave driver
> + *
> + * @drv: driver to unregister
> + */
> +void sdw_unregister_driver(struct sdw_driver *drv)
> +{
> +	driver_unregister(&drv->driver);
> +}
> +EXPORT_SYMBOL(sdw_unregister_driver);

EXPORT_SYMBOL_GPL()?  Same for all the exports here (I have to ask,
especially given what you are wrapping...)

thanks,

greg k-h
