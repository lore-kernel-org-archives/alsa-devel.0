From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 01/40] soundwire: add debugfs support
Date: Fri, 26 Jul 2019 16:04:11 +0200
Message-ID: <20190726140411.GA8767@kroah.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 06:39:53PM -0500, Pierre-Louis Bossart wrote:
> Add base debugfs mechanism for SoundWire bus by creating soundwire
> root and master-N and slave-x hierarchy.
> 
> Also add SDW Slave SCP, DP0 and DP-N register debug file.
> 
> Registers not implemented will print as "XX"
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. The main change
> is the use of scnprintf to avoid known issues with snprintf.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/Makefile    |   4 +-
>  drivers/soundwire/bus.c       |   6 ++
>  drivers/soundwire/bus.h       |  24 ++++++
>  drivers/soundwire/bus_type.c  |   3 +
>  drivers/soundwire/debugfs.c   | 156 ++++++++++++++++++++++++++++++++++
>  drivers/soundwire/slave.c     |   1 +
>  include/linux/soundwire/sdw.h |   4 +
>  7 files changed, 197 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soundwire/debugfs.c
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index fd99a831b92a..88990cac48a7 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -4,7 +4,9 @@
>  #
>  
>  #Bus Objs
> -soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> +soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o \
> +			debugfs.o
> +
>  obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
>  
>  #Cadence Objs
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index fe745830a261..5ad4109dc72f 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -49,6 +49,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>  		}
>  	}
>  
> +	bus->debugfs = sdw_bus_debugfs_init(bus);
> +
>  	/*
>  	 * Device numbers in SoundWire are 0 through 15. Enumeration device
>  	 * number (0), Broadcast device number (15), Group numbers (12 and
> @@ -109,6 +111,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	struct sdw_bus *bus = slave->bus;
>  
> +	sdw_slave_debugfs_exit(slave->debugfs);
> +
>  	mutex_lock(&bus->bus_lock);
>  
>  	if (slave->dev_num) /* clear dev_num if assigned */
> @@ -130,6 +134,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  void sdw_delete_bus_master(struct sdw_bus *bus)
>  {
>  	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
> +
> +	sdw_bus_debugfs_exit(bus->debugfs);
>  }
>  EXPORT_SYMBOL(sdw_delete_bus_master);
>  
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 3048ca153f22..06ac4adb0074 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -18,6 +18,30 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
>  void sdw_extract_slave_id(struct sdw_bus *bus,
>  			  u64 addr, struct sdw_slave_id *id);
>  
> +#ifdef CONFIG_DEBUG_FS
> +struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus);
> +void sdw_bus_debugfs_exit(struct dentry *d);
> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave);
> +void sdw_slave_debugfs_exit(struct dentry *d);
> +void sdw_debugfs_init(void);
> +void sdw_debugfs_exit(void);
> +#else
> +struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus)
> +{ return NULL; }
> +
> +void sdw_bus_debugfs_exit(struct dentry *d) {}
> +
> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave)
> +{ return NULL; }
> +
> +void sdw_slave_debugfs_exit(struct dentry *d) {}
> +
> +void sdw_debugfs_init(void) {}
> +
> +void sdw_debugfs_exit(void) {}
> +
> +#endif
> +
>  enum {
>  	SDW_MSG_FLAG_READ = 0,
>  	SDW_MSG_FLAG_WRITE,
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 2655602f0cfb..4a465f55039f 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -6,6 +6,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_type.h>
> +#include "bus.h"
>  
>  /**
>   * sdw_get_device_id - find the matching SoundWire device id
> @@ -177,11 +178,13 @@ EXPORT_SYMBOL_GPL(sdw_unregister_driver);
>  
>  static int __init sdw_bus_init(void)
>  {
> +	sdw_debugfs_init();
>  	return bus_register(&sdw_bus_type);
>  }
>  
>  static void __exit sdw_bus_exit(void)
>  {
> +	sdw_debugfs_exit();
>  	bus_unregister(&sdw_bus_type);
>  }
>  
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> new file mode 100644
> index 000000000000..8d86e100516e
> --- /dev/null
> +++ b/drivers/soundwire/debugfs.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)

No, for debugfs-specific code, that dual license makes no sense, right?
Don't cargo-cult SPDX identifiers please.

> +// Copyright(c) 2017-19 Intel Corporation.

Spell the year out fully unless you want lawyers knocking on your door :)

> +
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/slab.h>
> +#include <linux/soundwire/sdw.h>
> +#include <linux/soundwire/sdw_registers.h>
> +#include "bus.h"
> +
> +#ifdef CONFIG_DEBUG_FS
> +struct dentry *sdw_debugfs_root;
> +#endif

This whole file is not built if that option is not enabled, so why the
#ifdef?

thanks,

greg k-h
