From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 35/40] soundwire: intel: export helper
 to exit reset
Date: Fri, 26 Jul 2019 17:52:14 +0200
Message-ID: <20190726155213.GK16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-36-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-36-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 06:40:27PM -0500, Pierre-Louis Bossart wrote:
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 9 +++++++--
>  drivers/soundwire/cadence_master.h | 1 +
>  drivers/soundwire/intel.c          | 4 ++++
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 4a189e487830..f486fe15fb46 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -780,7 +780,11 @@ EXPORT_SYMBOL(sdw_cdns_thread);
>   * init routines
>   */
>  
> -static int do_reset(struct sdw_cdns *cdns)
> +/**
> + * sdw_cdns_exit_reset() - Program reset parameters and start bus operations
> + * @cdns: Cadence instance
> + */
> +int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
>  {
>  	int ret;
>  
> @@ -804,6 +808,7 @@ static int do_reset(struct sdw_cdns *cdns)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(sdw_cdns_exit_reset);
>  
>  /**
>   * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
> @@ -839,7 +844,7 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>  
>  	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
>  
> -	return do_reset(cdns);
> +	return 0;
>  }
>  EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
>  
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index de97bc22acb7..2b551f9226f3 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -161,6 +161,7 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
>  int sdw_cdns_init(struct sdw_cdns *cdns);
>  int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>  		      struct sdw_cdns_stream_config config);
> +int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
>  int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
>  
>  void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index a976480d6f36..9ebe38e4d979 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1112,6 +1112,8 @@ static int intel_probe(struct platform_device *pdev)
>  
>  	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
>  
> +	ret = sdw_cdns_exit_reset(&sdw->cdns);

This isn't something, that this patch changes, but if the return value above is
ignored, maybe no need to assign it at all?

Thanks
Guennadi

> +
>  	/* Register DAIs */
>  	ret = intel_register_dai(sdw);
>  	if (ret) {
> @@ -1199,6 +1201,8 @@ static int intel_resume(struct device *dev)
>  
>  	sdw_cdns_enable_interrupt(&sdw->cdns);
>  
> +	ret = sdw_cdns_exit_reset(&sdw->cdns);
> +
>  	return ret;
>  }
>  
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
