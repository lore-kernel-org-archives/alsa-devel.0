From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 24/40] soundwire: cadence_master: use BIOS defaults
 for frame shape
Date: Fri, 2 Aug 2019 22:40:14 +0530
Message-ID: <20190802171014.GZ12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> Remove hard-coding and use BIOS values. If they are wrong use default

BIOS :) this is cadence, am sure this can be used outside BIOS :D

It would be better to say firmware (ACPI/DT)

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

This can be in single line!

> +
> +	r = sdw_find_row_index(n_rows);
> +	c = sdw_find_col_index(n_cols);
> +
> +	val = (r << 3) | c;

Magic 3?

-- 
~Vinod
