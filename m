From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 36/40] soundwire: intel: disable
 interrupts on suspend
Date: Fri, 26 Jul 2019 17:55:20 +0200
Message-ID: <20190726155520.GL16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-37-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-37-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 06:40:28PM -0500, Pierre-Louis Bossart wrote:
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 42 +++++++++++++++++-------------
>  drivers/soundwire/cadence_master.h |  2 +-
>  drivers/soundwire/intel.c          |  6 +++--
>  3 files changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index f486fe15fb46..fa7230b0f200 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -814,33 +814,39 @@ EXPORT_SYMBOL(sdw_cdns_exit_reset);
>   * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
>   * @cdns: Cadence instance
>   */
> -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
> +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
>  {
>  	u32 mask;
>  
> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
> -		    CDNS_MCP_SLAVE_INTMASK0_MASK);
> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
> -		    CDNS_MCP_SLAVE_INTMASK1_MASK);
> +	if (state) {
> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
> +			    CDNS_MCP_SLAVE_INTMASK0_MASK);
> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
> +			    CDNS_MCP_SLAVE_INTMASK1_MASK);
>  
> -	/* enable detection of slave state changes */
> -	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
> -		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
> +		/* enable detection of slave state changes */
> +		mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
> +			CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
>  
> -	/* enable detection of bus issues */
> -	mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
> -		CDNS_MCP_INT_PARITY;
> +		/* enable detection of bus issues */
> +		mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
> +			CDNS_MCP_INT_PARITY;
>  
> -	/* no detection of port interrupts for now */
> +		/* no detection of port interrupts for now */
>  
> -	/* enable detection of RX fifo level */
> -	mask |= CDNS_MCP_INT_RX_WL;
> +		/* enable detection of RX fifo level */
> +		mask |= CDNS_MCP_INT_RX_WL;
>  
> -	/* now enable all of the above */
> -	mask |= CDNS_MCP_INT_IRQ;
> +		/* now enable all of the above */
> +		mask |= CDNS_MCP_INT_IRQ;
>  
> -	if (interrupt_mask) /* parameter override */
> -		mask = interrupt_mask;
> +		if (interrupt_mask) /* parameter override */
> +			mask = interrupt_mask;
> +	} else {
> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, 0);
> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, 0);
> +		mask = 0;
> +	}

Looks like this should be two functions? Especially since "state" is always a constant
when it is called. If there is still a lot of common code below, maybe make it a helper
function.

Thanks
Guennadi

>  
>  	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
>  
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index 2b551f9226f3..1a0ba36dd78f 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -162,7 +162,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns);
>  int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>  		      struct sdw_cdns_stream_config config);
>  int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
> -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
> +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
>  
>  void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
>  
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 9ebe38e4d979..1192d5775484 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1110,7 +1110,7 @@ static int intel_probe(struct platform_device *pdev)
>  		goto err_init;
>  	}
>  
> -	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
> +	ret = sdw_cdns_enable_interrupt(&sdw->cdns, true);
>  
>  	ret = sdw_cdns_exit_reset(&sdw->cdns);
>  
> @@ -1169,6 +1169,8 @@ static int intel_suspend(struct device *dev)
>  		return 0;
>  	}
>  
> +	sdw_cdns_enable_interrupt(&sdw->cdns, false);
> +
>  	ret = intel_link_power_down(sdw);
>  	if (ret) {
>  		dev_err(dev, "Link power down failed: %d", ret);
> @@ -1199,7 +1201,7 @@ static int intel_resume(struct device *dev)
>  		return ret;
>  	}
>  
> -	sdw_cdns_enable_interrupt(&sdw->cdns);
> +	sdw_cdns_enable_interrupt(&sdw->cdns, true);
>  
>  	ret = sdw_cdns_exit_reset(&sdw->cdns);
>  
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
