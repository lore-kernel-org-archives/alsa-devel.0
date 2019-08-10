From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] soundwire: add debugfs support
Date: Sat, 10 Aug 2019 09:01:39 +0200
Message-ID: <20190810070139.GA6896@kroah.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
 <20190809224341.15726-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809224341.15726-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 09, 2019 at 05:43:39PM -0500, Pierre-Louis Bossart wrote:
> Add base debugfs mechanism for SoundWire bus by creating soundwire
> root and master-N and slave-x hierarchy.
> 
> Also add SDW Slave SCP, DP0 and DP-N register debug file.
> 
> Registers not implemented will print as "XX"
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/Makefile    |   5 ++
>  drivers/soundwire/bus.c       |   6 ++
>  drivers/soundwire/bus.h       |  24 ++++++
>  drivers/soundwire/bus_type.c  |   3 +
>  drivers/soundwire/debugfs.c   | 151 ++++++++++++++++++++++++++++++++++
>  drivers/soundwire/slave.c     |   1 +
>  include/linux/soundwire/sdw.h |   4 +
>  7 files changed, 194 insertions(+)
>  create mode 100644 drivers/soundwire/debugfs.c
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index fd99a831b92a..05d4cb9ef7d6 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -5,6 +5,11 @@
>  
>  #Bus Objs
>  soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> +
> +ifdef CONFIG_DEBUG_FS
> +soundwire-bus-objs += debugfs.o
> +endif
> +
>  obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
>  
>  #Cadence Objs
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 49f64b2115b9..89d5f1537d9b 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -49,6 +49,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>  		}
>  	}
>  
> +	bus->debugfs = sdw_bus_debugfs_init(bus);
> +

It's "nicer" to just put that assignment into sdw_bus_debugfs_init().

That way you just call the function, no need to return anything.

>  	/*
>  	 * Device numbers in SoundWire are 0 through 15. Enumeration device
>  	 * number (0), Broadcast device number (15), Group numbers (12 and
> @@ -109,6 +111,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	struct sdw_bus *bus = slave->bus;
>  
> +	sdw_slave_debugfs_exit(slave->debugfs);

Same here, just pass in slave:
	sdw_slave_debugfs_exit(slave);
and have that function remove the debugfs entry in the structure.  That
way, if you are really paranoid about size, you could even drop the
debugfs structure member from non-debugfs builds without any changes to
bus.c or other non-debugfs files.

thanks,

greg k-h
