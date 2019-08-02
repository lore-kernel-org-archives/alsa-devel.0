From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 25/40] soundwire: intel: use BIOS information to set
 clock dividers
Date: Fri, 2 Aug 2019 12:29:41 -0500
Message-ID: <9b7fcffd-7f61-79c2-3130-71bc58be408e@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-26-pierre-louis.bossart@linux.intel.com>
 <20190802171711.GA12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802171711.GA12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 8/2/19 12:17 PM, Vinod Koul wrote:
> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
>> The BIOS provides an Intel-specific property, let's use it to avoid
>> hard-coded clock dividers.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 26 ++++++++++++++++++++++----
>>   drivers/soundwire/intel.c          | 26 ++++++++++++++++++++++++++
>>   include/linux/soundwire/sdw.h      |  2 ++
> 
> ah, intel patch touching bunch of things!

not really, it's more removing Intel-specific configs in the Cadence parts.

> 
>>   3 files changed, 50 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index d84344e29f71..10ebcef2e84e 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -173,8 +173,6 @@
>>   #define CDNS_PDI_CONFIG_PORT			GENMASK(4, 0)
>>   
>>   /* Driver defaults */
>> -
>> -#define CDNS_DEFAULT_CLK_DIVIDER		0
>>   #define CDNS_DEFAULT_SSP_INTERVAL		0x18
>>   #define CDNS_TX_TIMEOUT				2000
>>   
>> @@ -973,7 +971,10 @@ static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
>>    */
>>   int sdw_cdns_init(struct sdw_cdns *cdns)
>>   {
>> +	struct sdw_bus *bus = &cdns->bus;
>> +	struct sdw_master_prop *prop = &bus->prop;
>>   	u32 val;
>> +	int divider;
>>   	int ret;
>>   
>>   	/* Exit clock stop */
>> @@ -985,9 +986,17 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>>   	}
>>   
>>   	/* Set clock divider */
>> +	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
>>   	val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);
>> -	val |= CDNS_DEFAULT_CLK_DIVIDER;
>> +	val |= divider;
>>   	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
>> +	cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
>> +
>> +	pr_err("plb: mclk %d max_freq %d divider %d register %x\n",
>> +	       prop->mclk_freq,
>> +	       prop->max_clk_freq,
>> +	       divider,
>> +	       val);
> 
> I guess you forgot to remove this!

yes, fixed already

> 
>>   
>>   	/* Set the default frame shape */
>>   	val = cdns_set_default_frame_shape(prop->default_row,
>> @@ -1035,6 +1044,7 @@ EXPORT_SYMBOL(sdw_cdns_init);
>>   
>>   int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>>   {
>> +	struct sdw_master_prop *prop = &bus->prop;
>>   	struct sdw_cdns *cdns = bus_to_cdns(bus);
>>   	int mcp_clkctrl_off, mcp_clkctrl;
>>   	int divider;
>> @@ -1044,7 +1054,9 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>>   		return -EINVAL;
>>   	}
>>   
>> -	divider	= (params->max_dr_freq / params->curr_dr_freq) - 1;
>> +	divider	= prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR /
>> +		params->curr_dr_freq;
>> +	divider--; /* divider is 1/(N+1) */
>>   
>>   	if (params->next_bank)
>>   		mcp_clkctrl_off = CDNS_MCP_CLK_CTRL1;
>> @@ -1055,6 +1067,12 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>>   	mcp_clkctrl |= divider;
>>   	cdns_writel(cdns, mcp_clkctrl_off, mcp_clkctrl);
>>   
>> +	pr_err("plb: mclk * 2 %d curr_dr_freq %d divider %d register %x\n",
>> +	       prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR,
>> +	       params->curr_dr_freq,
>> +	       divider,
>> +	       mcp_clkctrl);
> 
> here too!

yep

> 
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL(cdns_bus_conf);
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index c718c9c67a37..796ac2bc8cea 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -917,11 +917,37 @@ static int intel_register_dai(struct sdw_intel *sdw)
>>   					  dais, num_dai);
>>   }
>>   
>> +static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>> +{
>> +	struct sdw_master_prop *prop = &bus->prop;
>> +	struct fwnode_handle *link;
>> +	char name[32];
>> +	int nval, i;
>> +
>> +	/* Find master handle */
>> +	snprintf(name, sizeof(name),
>> +		 "mipi-sdw-link-%d-subproperties", bus->link_id);
>> +
>> +	link = device_get_named_child_node(bus->dev, name);
>> +	if (!link) {
>> +		dev_err(bus->dev, "Master node %s not found\n", name);
>> +		return -EIO;
>> +	}
>> +
>> +	fwnode_property_read_u32(link,
>> +				 "intel-sdw-ip-clock",
>> +				 &prop->mclk_freq);
>> +	return 0;
>> +}
>> +
>>   static int intel_prop_read(struct sdw_bus *bus)
>>   {
>>   	/* Initialize with default handler to read all DisCo properties */
>>   	sdw_master_read_prop(bus);
>>   
>> +	/* read Intel-specific properties */
>> +	sdw_master_read_intel_prop(bus);
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
>> index 31d1e8acf25b..b6acc436ac80 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -379,6 +379,7 @@ struct sdw_slave_prop {
>>    * @dynamic_frame: Dynamic frame shape supported
>>    * @err_threshold: Number of times that software may retry sending a single
>>    * command
>> + * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
>>    */
>>   struct sdw_master_prop {
>>   	u32 revision;
>> @@ -393,6 +394,7 @@ struct sdw_master_prop {
>>   	u32 default_col;
>>   	bool dynamic_frame;
>>   	u32 err_threshold;
>> +	u32 mclk_freq;
> 
> Other than debug artifacts this looks sane, but can you split up the
> cadence and intel parts into different patches please

ok, i'll split in 3. prototype, intel, cadence.
