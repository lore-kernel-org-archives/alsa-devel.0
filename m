From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v4 06/22] soundwire: bus: remove useless parentheses
Date: Thu, 2 May 2019 11:02:20 +0530
Message-ID: <20190502053220.GC3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-7-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> and make the code more readable

Well patch subject and log are not meant to be read as a continuous
statement, It would nice to have a proper lines for this

> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index efdcefc62e1a..423dc6d17999 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -415,10 +415,10 @@ static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
>  static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
>  {
>  
> -	if ((slave->id.unique_id != id.unique_id) ||
> -	    (slave->id.mfg_id != id.mfg_id) ||
> -	    (slave->id.part_id != id.part_id) ||
> -	    (slave->id.class_id != id.class_id))
> +	if (slave->id.unique_id != id.unique_id ||
> +	    slave->id.mfg_id != id.mfg_id ||
> +	    slave->id.part_id != id.part_id ||
> +	    slave->id.class_id != id.class_id)
>  		return -ENODEV;
>  
>  	return 0;
> @@ -896,8 +896,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  		}
>  
>  		/* Update the Slave driver */
> -		if (slave_notify && (slave->ops) &&
> -					(slave->ops->interrupt_callback)) {
> +		if (slave_notify && slave->ops &&
> +		    slave->ops->interrupt_callback) {
>  			slave_intr.control_port = clear;
>  			memcpy(slave_intr.port, &port_status,
>  			       sizeof(slave_intr.port));
> @@ -955,7 +955,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  static int sdw_update_slave_status(struct sdw_slave *slave,
>  				   enum sdw_slave_status status)
>  {
> -	if ((slave->ops) && (slave->ops->update_status))
> +	if (slave->ops && slave->ops->update_status)
>  		return slave->ops->update_status(slave, status);
>  
>  	return 0;
> -- 
> 2.17.1

-- 
~Vinod
