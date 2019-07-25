From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 01/40] soundwire: add debugfs support
Date: Fri, 26 Jul 2019 00:15:55 +0200
Message-ID: <20190725221554.GA16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

A couple of nitpicks:

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

[snip]

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

static?

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

Same for all the above. You could also declare them inline, but I really hope
the compiler will be smart enough to do that itself.

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
> +// Copyright(c) 2017-19 Intel Corporation.
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
> +
> +struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus)
> +{
> +	struct dentry *d;

I would remove the above

> +	char name[16];
> +
> +	if (!sdw_debugfs_root)
> +		return NULL;
> +
> +	/* create the debugfs master-N */
> +	snprintf(name, sizeof(name), "master-%d", bus->link_id);
> +	d = debugfs_create_dir(name, sdw_debugfs_root);
> +
> +	return d;

And just do

+	return debugfs_create_dir(name, sdw_debugfs_root);

> +}
> +
> +void sdw_bus_debugfs_exit(struct dentry *d)
> +{
> +	debugfs_remove_recursive(d);
> +}
> +
> +#define RD_BUF (3 * PAGE_SIZE)
> +
> +static ssize_t sdw_sprintf(struct sdw_slave *slave,
> +			   char *buf, size_t pos, unsigned int reg)
> +{
> +	int value;
> +
> +	value = sdw_read(slave, reg);

I personally would join the two lines above, but that's just a personal
preference.

> +
> +	if (value < 0)
> +		return scnprintf(buf + pos, RD_BUF - pos, "%3x\tXX\n", reg);
> +	else

I think it's advised to not use an else in such cases.

Thanks
Guennadi

> +		return scnprintf(buf + pos, RD_BUF - pos,
> +				"%3x\t%2x\n", reg, value);
> +}
> +
> +static ssize_t sdw_slave_reg_read(struct file *file, char __user *user_buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	struct sdw_slave *slave = file->private_data;
> +	unsigned int reg;
> +	char *buf;
> +	ssize_t ret;
> +	int i, j;
> +
> +	buf = kzalloc(RD_BUF, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP0\n");
> +
> +	for (i = 0; i < 6; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +	ret += sdw_sprintf(slave, buf, ret, SDW_DP0_CHANNELEN);
> +	for (i = SDW_DP0_SAMPLECTRL1; i <= SDW_DP0_LANECTRL; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +	ret += sdw_sprintf(slave, buf, ret,
> +			SDW_DP0_CHANNELEN + SDW_BANK1_OFFSET);
> +	for (i = SDW_DP0_SAMPLECTRL1 + SDW_BANK1_OFFSET;
> +			i <= SDW_DP0_LANECTRL + SDW_BANK1_OFFSET; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
> +	for (i = SDW_SCP_INT1; i <= SDW_SCP_BANKDELAY; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +	for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
> +		ret += sdw_sprintf(slave, buf, ret, i);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B0);
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B0);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_FRAMECTRL_B1);
> +	ret += sdw_sprintf(slave, buf, ret, SDW_SCP_NEXTFRAME_B1);
> +
> +	for (i = 1; i < 14; i++) {
> +		ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP%d\n", i);
> +		reg = SDW_DPN_INT(i);
> +		for (j = 0; j < 6; j++)
> +			ret += sdw_sprintf(slave, buf, ret, reg + j);
> +
> +		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +		reg = SDW_DPN_CHANNELEN_B0(i);
> +		for (j = 0; j < 9; j++)
> +			ret += sdw_sprintf(slave, buf, ret, reg + j);
> +
> +		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +		reg = SDW_DPN_CHANNELEN_B1(i);
> +		for (j = 0; j < 9; j++)
> +			ret += sdw_sprintf(slave, buf, ret, reg + j);
> +	}
> +
> +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations sdw_slave_reg_fops = {
> +	.open = simple_open,
> +	.read = sdw_slave_reg_read,
> +	.llseek = default_llseek,
> +};
> +
> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave)
> +{
> +	struct dentry *master;
> +	struct dentry *d;
> +	char name[32];
> +
> +	master = slave->bus->debugfs;
> +
> +	/* create the debugfs slave-name */
> +	snprintf(name, sizeof(name), "%s", dev_name(&slave->dev));
> +	d = debugfs_create_dir(name, master);
> +
> +	debugfs_create_file("registers", 0400, d, slave, &sdw_slave_reg_fops);
> +
> +	return d;
> +}
> +
> +void sdw_slave_debugfs_exit(struct dentry *d)
> +{
> +	debugfs_remove_recursive(d);
> +}
> +
> +void sdw_debugfs_init(void)
> +{
> +	sdw_debugfs_root = debugfs_create_dir("soundwire", NULL);
> +}
> +
> +void sdw_debugfs_exit(void)
> +{
> +	debugfs_remove_recursive(sdw_debugfs_root);
> +}
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index f39a5815e25d..34d8bb995f45 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -56,6 +56,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  		mutex_unlock(&bus->bus_lock);
>  		put_device(&slave->dev);
>  	}
> +	slave->debugfs = sdw_slave_debugfs_init(slave);
>  
>  	return ret;
>  }
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 3b231472464a..a49028e9d666 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -544,6 +544,7 @@ struct sdw_slave_ops {
>   * @bus: Bus handle
>   * @ops: Slave callback ops
>   * @prop: Slave properties
> + * @debugfs: Slave debugfs
>   * @node: node for bus list
>   * @port_ready: Port ready completion flag for each Slave port
>   * @dev_num: Device Number assigned by Bus
> @@ -555,6 +556,7 @@ struct sdw_slave {
>  	struct sdw_bus *bus;
>  	const struct sdw_slave_ops *ops;
>  	struct sdw_slave_prop prop;
> +	struct dentry *debugfs;
>  	struct list_head node;
>  	struct completion *port_ready;
>  	u16 dev_num;
> @@ -731,6 +733,7 @@ struct sdw_master_ops {
>   * @m_rt_list: List of Master instance of all stream(s) running on Bus. This
>   * is used to compute and program bus bandwidth, clock, frame shape,
>   * transport and port parameters
> + * @debugfs: Bus debugfs
>   * @defer_msg: Defer message
>   * @clk_stop_timeout: Clock stop timeout computed
>   * @bank_switch_timeout: Bank switch timeout computed
> @@ -750,6 +753,7 @@ struct sdw_bus {
>  	struct sdw_bus_params params;
>  	struct sdw_master_prop prop;
>  	struct list_head m_rt_list;
> +	struct dentry *debugfs;
>  	struct sdw_defer defer_msg;
>  	unsigned int clk_stop_timeout;
>  	u32 bank_switch_timeout;
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
