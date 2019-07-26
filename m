From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 24/40] soundwire: cadence_master: use
 BIOS defaults for frame shape
Date: Fri, 26 Jul 2019 09:22:21 -0500
Message-ID: <3d1f1667-f165-024f-8a93-bb15500cd7ad@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
 <7dbe6483-673f-f415-9ebc-700c090d9520@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7dbe6483-673f-f415-9ebc-700c090d9520@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 5:20 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> +static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
>> +{
>> +    u32 val;
>> +    int c;
>> +    int r;
>> +
>> +    r = sdw_find_row_index(n_rows);
>> +    c = sdw_find_col_index(n_cols);
>> +
>> +    val = (r << 3) | c;
>> +
>> +    return val;
>> +}
>> +
>>   /**
>>    * sdw_cdns_init() - Cadence initialization
>>    * @cdns: Cadence instance
>> @@ -977,7 +990,9 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>>       cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
>>       /* Set the default frame shape */
>> -    cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, 
>> CDNS_DEFAULT_FRAME_SHAPE);
>> +    val = cdns_set_default_frame_shape(prop->default_row,
>> +                       prop->default_col);
>> +    cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, val);
>>       /* Set SSP interval to default value */
>>       cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
>>
> 
> Suggestion:
> declare "generic" _get_frame_frame(rows, cols) instead and let it do the 
> bitwise operations for you. Pretty sure this won't be the only place in 
> code where reg value for frame_shape needs to be prepared.
> 
> Said function could be as simple as:
> return (row << 3) | cols;
> +inline flag
> 
> i.e. could be even a macro..
> 
> Otherwise modify _set_default_frame_shape to simply:
> return (r << 3) | c
> 
> without involving additional local val variable (I don't really see the 
> point for any locals there though).

what this function does is take the standard-defined offsets for row and 
column and stores them in a Cadence-defined register. I think we can 
probably use a macro to remove the magic '3' value, but there are limits 
to what we can simplify. I should probably add comments so that people 
figure it out.
