From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 06/17] soundwire: cadence_master: use firmware defaults
 for frame shape
Date: Tue, 6 Aug 2019 17:27:28 +0200
Message-ID: <03b6091b-af41-ac54-43c7-196a3583a731@intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
 <20190806005522.22642-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806005522.22642-7-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org, Slawomir <slawomir.blauciak@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2019-08-06 02:55, Pierre-Louis Bossart wrote:
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 5d9729b4d634..89c55e4bb72c 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -48,6 +48,8 @@
>   #define CDNS_MCP_SSPSTAT			0xC
>   #define CDNS_MCP_FRAME_SHAPE			0x10
>   #define CDNS_MCP_FRAME_SHAPE_INIT		0x14
> +#define CDNS_MCP_FRAME_SHAPE_COL_MASK		GENMASK(2, 0)
> +#define CDNS_MCP_FRAME_SHAPE_ROW_OFFSET		3
>   
>   #define CDNS_MCP_CONFIG_UPDATE			0x18
>   #define CDNS_MCP_CONFIG_UPDATE_BIT		BIT(0)
> @@ -175,7 +177,6 @@
>   /* Driver defaults */
>   
>   #define CDNS_DEFAULT_CLK_DIVIDER		0
> -#define CDNS_DEFAULT_FRAME_SHAPE		0x30
>   #define CDNS_DEFAULT_SSP_INTERVAL		0x18
>   #define CDNS_TX_TIMEOUT				2000
>   
> @@ -901,6 +902,20 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>   }
>   EXPORT_SYMBOL(sdw_cdns_pdi_init);
>   
> +static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
> +{
> +	u32 val;
> +	int c;
> +	int r;
> +
> +	r = sdw_find_row_index(n_rows);
> +	c = sdw_find_col_index(n_cols) & CDNS_MCP_FRAME_SHAPE_COL_MASK;
> +
> +	val = (r << CDNS_MCP_FRAME_SHAPE_ROW_OFFSET) | c;
> +
> +	return val;
> +}
> +

Guess this have been said already, but this function could be simplified 
- unless you really want to keep explicit variable declaration. Both "c" 
and "r" declarations could be merged into single line while "val" is not 
needed at all.

One more thing - is AND bitwise op really needed for cols explicitly? We 
know all col values upfront - these are static and declared in global 
table nearby. Static declaration takes care of "initial range-check". Is 
another one necessary?

Moreover, this is a _get_ and certainly not a _set_ type of function. 
I'd even consider renaming it to: "cdns_get_frame_shape" as this is 
neither a _set_ nor an explicit initial frame shape setter.

It might be even helpful to split two usages:

#define sdw_frame_shape(col_idx, row_idx) \
	((row_idx << CDNS_MCP_FRAME_SHAPE_ROW_OFFSET) | col_idx)

u32 cdns_get_frame_shape(u16 rows, u16 cols)
{
	u16 c, r;

	r = sdw_find_row_index(rows);
	c = sdw_find_col_index(cols);

	return sdw_frame_shape(c, r);
}

The above may even be simplified into one-liner.
