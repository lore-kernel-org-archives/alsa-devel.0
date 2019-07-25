From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [RFC PATCH 09/40] soundwire: cadence_master: fix
 usage of CONFIG_UPDATE
Date: Fri, 26 Jul 2019 00:23:02 +0200
Message-ID: <20190725222302.GB16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01ACFF800E8
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2019 08:54:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 06:40:01PM -0500, Pierre-Louis Bossart wrote:
> Per the hardware documentation, all changes to MCP_CONFIG,
> MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL need to be validated with a
> self-clearing write to MCP_CONFIG_UPDATE.
> 
> For some reason, the existing code only does this write to
> CONFIG_UPDATE when enabling interrupts. Add a helper and do the update
> when the CONFIG is changed.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 9f611a1fff0a..eb46cf651d62 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -224,6 +224,22 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
>  	return -EAGAIN;
>  }
>  
> +/*
> + * all changes to the MCP_CONFIG, MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL
> + * need to be confirmed with a write to MCP_CONFIG_UPDATE
> + */
> +static int cdns_update_config(struct sdw_cdns *cdns)
> +{
> +	int ret;
> +
> +	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
> +			     CDNS_MCP_CONFIG_UPDATE_BIT);
> +	if (ret < 0)
> +		dev_err(cdns->dev, "Config update timedout\n");
> +
> +	return ret;
> +}
> +
>  /*
>   * debugfs
>   */
> @@ -758,15 +774,9 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
>   */
>  int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>  {
> -	int ret;
> -
>  	_cdns_enable_interrupt(cdns);
> -	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
> -			     CDNS_MCP_CONFIG_UPDATE_BIT);
> -	if (ret < 0)
> -		dev_err(cdns->dev, "Config update timedout\n");
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
>  
> @@ -943,7 +953,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  
>  	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
>  
> -	return 0;
> +	/* commit changes */
> +	ret = cdns_update_config(cdns);
> +
> +	return ret;

+	return cdns_update_config(cdns);

Thanks
Guennadi

>  }
>  EXPORT_SYMBOL(sdw_cdns_init);
>  
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
