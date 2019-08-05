From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 24/40] soundwire: cadence_master: use BIOS defaults
 for frame shape
Date: Mon, 5 Aug 2019 15:31:07 +0530
Message-ID: <20190805100107.GE22437@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 06:40:16PM -0500, Pierre-Louis Bossart wrote:
> Remove hard-coding and use BIOS values. If they are wrong use default
> 48x2 frame shape.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 442f78c00f09..d84344e29f71 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -175,7 +175,6 @@
>  /* Driver defaults */
>  
>  #define CDNS_DEFAULT_CLK_DIVIDER		0
> -#define CDNS_DEFAULT_FRAME_SHAPE		0x30
>  #define CDNS_DEFAULT_SSP_INTERVAL		0x18
>  #define CDNS_TX_TIMEOUT				2000
>  
> @@ -954,6 +953,20 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>  }
>  EXPORT_SYMBOL(sdw_cdns_pdi_init);
>  
> +static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
> +{
> +	u32 val;
> +	int c;
> +	int r;
> +
> +	r = sdw_find_row_index(n_rows);
> +	c = sdw_find_col_index(n_cols);
> +

Now i get why you need above functions to be exported, please ignore my
previous comment.

> +	val = (r << 3) | c;
> +
> +	return val;
> +}
> +
>  /**
>   * sdw_cdns_init() - Cadence initialization
>   * @cdns: Cadence instance
> @@ -977,7 +990,9 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
>  
>  	/* Set the default frame shape */
> -	cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, CDNS_DEFAULT_FRAME_SHAPE);
> +	val = cdns_set_default_frame_shape(prop->default_row,
> +					   prop->default_col);
> +	cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, val);
>  
>  	/* Set SSP interval to default value */
>  	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
> -- 
> 2.20.1
> 

-- 
