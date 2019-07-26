From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 09/40] soundwire: cadence_master: fix
 usage of CONFIG_UPDATE
Date: Fri, 26 Jul 2019 10:11:53 +0800
Message-ID: <3aa182a9-4b8e-96dd-e8f8-f2f5a90401cb@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 7/26/2019 7:40 AM, Pierre-Louis Bossart wrote:
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
>   drivers/soundwire/cadence_master.c | 29 +++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 9f611a1fff0a..eb46cf651d62 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -224,6 +224,22 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
>   	return -EAGAIN;
>   }
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
>   /*
>    * debugfs
>    */
> @@ -758,15 +774,9 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
>    */
>   int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>   {
> -	int ret;
> -
>   	_cdns_enable_interrupt(cdns);
> -	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
> -			     CDNS_MCP_CONFIG_UPDATE_BIT);
> -	if (ret < 0)
> -		dev_err(cdns->dev, "Config update timedout\n");
>   
> -	return ret;
Should we add cdns_update_config() here?
> +	return 0;
>   }
>   EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
>   
> @@ -943,7 +953,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>   
>   	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
>   
> -	return 0;
> +	/* commit changes */
> +	ret = cdns_update_config(cdns);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL(sdw_cdns_init);
>   
