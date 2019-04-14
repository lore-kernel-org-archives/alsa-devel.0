From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 2/5] soundwire: fix style issues
Date: Sun, 14 Apr 2019 15:28:39 +0530
Message-ID: <20190414095839.GG28103@vkoul-mobl>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 10-04-19, 22:16, Pierre-Louis Bossart wrote:
> Visual inspections confirmed by checkpatch.pl --strict expose a number
> of style issues, specifically parameter alignment is inconsistent as
> if different contributors used different styles. Before we restart
> support for SoundWire with Sound Open Firmware on Intel platforms,
> let's clean all this.
> 
> Fix Kconfig help, spelling, SPDX format, alignment, spurious
> parentheses, bool comparisons to true/false, macro argument
> protection.

Thanks for the cleanup Pierre :)

> 
> No new functionality added.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/Kconfig          |   2 +-
>  drivers/soundwire/bus.c            |  87 ++++++++--------
>  drivers/soundwire/bus.h            |  16 +--
>  drivers/soundwire/bus_type.c       |   4 +-
>  drivers/soundwire/cadence_master.c |  87 ++++++++--------
>  drivers/soundwire/cadence_master.h |  22 ++--
>  drivers/soundwire/intel.c          |  87 ++++++++--------
>  drivers/soundwire/intel.h          |   4 +-
>  drivers/soundwire/intel_init.c     |  12 +--
>  drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
>  drivers/soundwire/slave.c          |  10 +-
>  drivers/soundwire/stream.c         | 161 +++++++++++++++--------------

I would prefer this to be a patch per module. It doesnt help to have a
single patch for all the files!

It would be great to have cleanup done per logical group, for example
typos in a patch, aligns in another etc...

>  12 files changed, 313 insertions(+), 295 deletions(-)
> 
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index 19c8efb9a5ee..84876a74874f 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -4,7 +4,7 @@
>  
>  menuconfig SOUNDWIRE
>  	bool "SoundWire support"
> -	---help---
> +	help

Not sure if this is a style issue, kernel seems to have 2990 instances
of this!

>  	if (msg->page)
>  		sdw_reset_page(bus, msg->dev_num);
> @@ -243,7 +244,7 @@ int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
>   * Caller needs to hold the msg_lock lock while calling this
>   */
>  int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
> -				struct sdw_defer *defer)
> +		       struct sdw_defer *defer)

this does not seem aligned to me!

>  int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
> -		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)
> +		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)

this one too

> @@ -458,13 +458,13 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
>  		mutex_unlock(&slave->bus->bus_lock);
>  		if (dev_num < 0) {
>  			dev_err(slave->bus->dev, "Get dev_num failed: %d",
> -								dev_num);
> +				dev_num);

It might read better if we move the log to second line along with
dev_num...

>  int sdw_configure_dpn_intr(struct sdw_slave *slave,
> -			int port, bool enable, int mask)
> +			   int port, bool enable, int mask)

not aligned

>  void sdw_extract_slave_id(struct sdw_bus *bus,
> -			u64 addr, struct sdw_slave_id *id);
> +			  u64 addr, struct sdw_slave_id *id);
>  

Not aligned
 
>  enum sdw_command_response
>  cdns_xfer_msg_defer(struct sdw_bus *bus,
> -		struct sdw_msg *msg, struct sdw_defer *defer)
> +		    struct sdw_msg *msg, struct sdw_defer *defer)

this one too..

>  static int cdns_port_params(struct sdw_bus *bus,
> -		struct sdw_port_params *p_params, unsigned int bank)
> +			    struct sdw_port_params *p_params, unsigned int bank)

here as well.. (and giving up on rest)

-- 
~Vinod
