From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 09/40] soundwire: cadence_master: fix usage of
 CONFIG_UPDATE
Date: Fri, 2 Aug 2019 17:33:19 +0530
Message-ID: <20190802120319.GL12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:

>  int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>  {
> -	int ret;
> -
>  	_cdns_enable_interrupt(cdns);
> -	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
> -			     CDNS_MCP_CONFIG_UPDATE_BIT);
> -	if (ret < 0)
> -		dev_err(cdns->dev, "Config update timedout\n");

I was expecting cdns_update_config() to be invoked here??

>  
> -	return ret;
> +	return 0;

It would be better if we return a value here a not success always

> @@ -943,7 +953,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  
>  	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
>  
> -	return 0;
> +	/* commit changes */
> +	ret = cdns_update_config(cdns);
> +
> +	return ret;

return cdns_update_config()

-- 
~Vinod
