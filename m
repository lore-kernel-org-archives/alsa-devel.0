From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 38/40] soundwire: cadence_master: make
 clock stop exit configurable on init
Date: Fri, 26 Jul 2019 18:02:59 +0200
Message-ID: <20190726160258.GN16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-39-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-39-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 06:40:30PM -0500, Pierre-Louis Bossart wrote:
> The use of clock stop is not a requirement, the IP can e.g. be
> completely power gated and not detect any wakes while in s2idle/deep
> sleep.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 15 ++++++++-------
>  drivers/soundwire/cadence_master.h |  2 +-
>  drivers/soundwire/intel.c          |  2 +-
>  3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 53278aa2436f..4ab6f70d7705 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -1010,7 +1010,7 @@ static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
>   * sdw_cdns_init() - Cadence initialization
>   * @cdns: Cadence instance
>   */
> -int sdw_cdns_init(struct sdw_cdns *cdns)
> +int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit)
>  {
>  	struct sdw_bus *bus = &cdns->bus;
>  	struct sdw_master_prop *prop = &bus->prop;
> @@ -1018,12 +1018,13 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  	int divider;
>  	int ret;
>  
> -	/* Exit clock stop */
> -	ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
> -			     CDNS_MCP_CONTROL_CLK_STOP_CLR);
> -	if (ret < 0) {
> -		dev_err(cdns->dev, "Couldn't exit from clock stop\n");
> -		return ret;
> +	if (clock_stop_exit) {
> +		ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
> +				     CDNS_MCP_CONTROL_CLK_STOP_CLR);
> +		if (ret < 0) {
> +			dev_err(cdns->dev, "Couldn't exit from clock stop\n");
> +			return ret;
> +		}
>  	}
>  
>  	/* Set clock divider */
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index 1a0ba36dd78f..091b771b570d 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -158,7 +158,7 @@ extern struct sdw_master_ops sdw_cdns_master_ops;
>  irqreturn_t sdw_cdns_irq(int irq, void *dev_id);
>  irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
>  
> -int sdw_cdns_init(struct sdw_cdns *cdns);
> +int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit);
>  int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>  		      struct sdw_cdns_stream_config config);
>  int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 1192d5775484..db7bf2912767 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1043,7 +1043,7 @@ static int intel_init(struct sdw_intel *sdw)
>  	intel_link_power_up(sdw);
>  	intel_shim_init(sdw);
>  
> -	return sdw_cdns_init(&sdw->cdns);
> +	return sdw_cdns_init(&sdw->cdns, false);

This is the only caller of this function so far, so, it looks like
the second argument ATM is always "false." I assume you foresee other
uses with "true" in the future, otherwise maybe just fix it to false
in the function?

Thanks
Guennadi

>  }
>  
>  /*
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
