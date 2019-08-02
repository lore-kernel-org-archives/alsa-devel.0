From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 05/40] soundwire: intel: move interrupt enable after
 interrupt handler registration
Date: Fri, 2 Aug 2019 17:23:59 +0530
Message-ID: <20190802115359.GH12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-6-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
> Not sure why the existing code would enable interrupts without the
> ability to deal with them.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index aeadc341c0a3..68832e613b1e 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -981,8 +981,6 @@ static int intel_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_init;
>  
> -	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
> -
>  	/* Read the PDI config and initialize cadence PDI */
>  	intel_pdi_init(sdw, &config);
>  	ret = sdw_cdns_pdi_init(&sdw->cdns, config);
> @@ -1000,6 +998,8 @@ static int intel_probe(struct platform_device *pdev)
>  		goto err_init;
>  	}
>  
> +	ret = sdw_cdns_enable_interrupt(&sdw->cdns);

we should also handle the return

-- 
~Vinod
