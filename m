From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 26/40] soundwire: cadence_master: fix
 divider setting in clock register
Date: Fri, 26 Jul 2019 13:19:51 +0800
Message-ID: <f38a5e3a-c797-ae53-f0d4-31ac46ec360b@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 7/26/2019 7:40 AM, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@linux.intel.com>
>
> The existing code uses an OR operation which would mix the original
> divider setting with the new one, resulting in an invalid
> configuration that can make codecs hang.
>
> Add the mask definition and use cdns_updatel to update divider
>
> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   drivers/soundwire/cadence_master.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 10ebcef2e84e..18c6ac026e85 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -57,6 +57,7 @@
>   #define CDNS_MCP_SSP_CTRL1			0x28
>   #define CDNS_MCP_CLK_CTRL0			0x30
>   #define CDNS_MCP_CLK_CTRL1			0x38
> +#define CDNS_MCP_CLK_MCLKD_MASK		GENMASK(7, 0)
>   
>   #define CDNS_MCP_STAT				0x40
>   
> @@ -988,9 +989,11 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>   	/* Set clock divider */
>   	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
>   	val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);


Do we still need to read cdns_readl(cdns, CDNS_MCP_CLK_CTRL0)

after this change?


> -	val |= divider;
> -	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
> -	cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
> +
> +	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL0,
> +		     CDNS_MCP_CLK_MCLKD_MASK, divider);
> +	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL1,
> +		     CDNS_MCP_CLK_MCLKD_MASK, divider);
>   
>   	pr_err("plb: mclk %d max_freq %d divider %d register %x\n",
>   	       prop->mclk_freq,
> @@ -1064,8 +1067,7 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>   		mcp_clkctrl_off = CDNS_MCP_CLK_CTRL0;
>   
>   	mcp_clkctrl = cdns_readl(cdns, mcp_clkctrl_off);


Same here.


> -	mcp_clkctrl |= divider;
> -	cdns_writel(cdns, mcp_clkctrl_off, mcp_clkctrl);
> +	cdns_updatel(cdns, mcp_clkctrl_off, CDNS_MCP_CLK_MCLKD_MASK, divider);
>   
>   	pr_err("plb: mclk * 2 %d curr_dr_freq %d divider %d register %x\n",
>   	       prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR,
