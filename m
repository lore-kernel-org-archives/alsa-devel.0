From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 19/40] soundwire: bus: improve dynamic debug comments
 for enumeration
Date: Fri, 2 Aug 2019 22:30:41 +0530
Message-ID: <20190802170041.GW12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-20-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-20-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> update comments to provide better understanding of enumeration flows.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index bca378806d00..2354675ef104 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -483,7 +483,8 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
>  
>  	ret = sdw_write(slave, SDW_SCP_DEVNUMBER, dev_num);
>  	if (ret < 0) {
> -		dev_err(&slave->dev, "Program device_num failed: %d\n", ret);
> +		dev_err(&slave->dev, "Program device_num %d failed: %d\n",
> +			dev_num, ret);
>  		return ret;
>  	}
>  
> @@ -540,6 +541,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>  	do {
>  		ret = sdw_transfer(bus, &msg);
>  		if (ret == -ENODATA) { /* end of device id reads */
> +			dev_dbg(bus->dev, "No more devices to enumerate\n");
>  			ret = 0;
>  			break;
>  		}
> @@ -982,6 +984,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
>  	int i, ret = 0;
>  
>  	if (status[0] == SDW_SLAVE_ATTACHED) {
> +		dev_err(bus->dev, "Slave attached, programming device number\n");

This should be debug level

-- 
~Vinod
