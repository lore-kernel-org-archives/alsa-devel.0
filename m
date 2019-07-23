From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1] soundwire: mipi_disco: Switch to use
 fwnode_property_count_uXX()
Date: Tue, 23 Jul 2019 15:09:25 -0500
Message-ID: <4fb9a23c-3875-33d6-95fd-af384e8b5360@linux.intel.com>
References: <20190723194218.69168-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7721EF800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 22:09:28 +0200 (CEST)
In-Reply-To: <20190723194218.69168-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 7/23/19 2:42 PM, Andy Shevchenko wrote:
> Use use fwnode_property_count_uXX() directly, that makes code neater.

Yes indeed, thanks!

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/soundwire/mipi_disco.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
> index 79fee1b21ab6..844e6b22974f 100644
> --- a/drivers/soundwire/mipi_disco.c
> +++ b/drivers/soundwire/mipi_disco.c
> @@ -60,8 +60,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
>   				 "mipi-sdw-max-clock-frequency",
>   				 &prop->max_clk_freq);
>   
> -	nval = fwnode_property_read_u32_array(link,
> -			"mipi-sdw-clock-frequencies-supported", NULL, 0);
> +	nval = fwnode_property_count_u32(link, "mipi-sdw-clock-frequencies-supported");
>   	if (nval > 0) {
>   		prop->num_clk_freq = nval;
>   		prop->clk_freq = devm_kcalloc(bus->dev, prop->num_clk_freq,
> @@ -87,8 +86,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
>   		}
>   	}
>   
> -	nval = fwnode_property_read_u32_array(link,
> -			"mipi-sdw-supported-clock-gears", NULL, 0);
> +	nval = fwnode_property_count_u32(link, "mipi-sdw-supported-clock-gears");
>   	if (nval > 0) {
>   		prop->num_clk_gears = nval;
>   		prop->clk_gears = devm_kcalloc(bus->dev, prop->num_clk_gears,
> @@ -134,8 +132,7 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
>   	fwnode_property_read_u32(port, "mipi-sdw-port-min-wordlength",
>   				 &dp0->min_word);
>   
> -	nval = fwnode_property_read_u32_array(port,
> -			"mipi-sdw-port-wordlength-configs", NULL, 0);
> +	nval = fwnode_property_count_u32(port, "mipi-sdw-port-wordlength-configs");
>   	if (nval > 0) {
>   
>   		dp0->num_words = nval;
> @@ -193,8 +190,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
>   		fwnode_property_read_u32(node, "mipi-sdw-port-min-wordlength",
>   					 &dpn[i].min_word);
>   
> -		nval = fwnode_property_read_u32_array(node,
> -				"mipi-sdw-port-wordlength-configs", NULL, 0);
> +		nval = fwnode_property_count_u32(node, "mipi-sdw-port-wordlength-configs");
>   		if (nval > 0) {
>   			dpn[i].num_words = nval;
>   			dpn[i].words = devm_kcalloc(&slave->dev,
> @@ -233,8 +229,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
>   		fwnode_property_read_u32(node, "mipi-sdw-max-channel-number",
>   					 &dpn[i].max_ch);
>   
> -		nval = fwnode_property_read_u32_array(node,
> -				"mipi-sdw-channel-number-list", NULL, 0);
> +		nval = fwnode_property_count_u32(node, "mipi-sdw-channel-number-list");
>   		if (nval > 0) {
>   			dpn[i].num_ch = nval;
>   			dpn[i].ch = devm_kcalloc(&slave->dev, dpn[i].num_ch,
> @@ -248,8 +243,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
>   					dpn[i].ch, dpn[i].num_ch);
>   		}
>   
> -		nval = fwnode_property_read_u32_array(node,
> -				"mipi-sdw-channel-combination-list", NULL, 0);
> +		nval = fwnode_property_count_u32(node, "mipi-sdw-channel-combination-list");
>   		if (nval > 0) {
>   			dpn[i].num_ch_combinations = nval;
>   			dpn[i].ch_combinations = devm_kcalloc(&slave->dev,
> 
