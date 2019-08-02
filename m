From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 15/40] soundwire: cadence_master: handle multiple
 status reports per Slave
Date: Fri, 2 Aug 2019 10:29:26 -0500
Message-ID: <c4d31804-48af-30e3-4b4f-4b03dac6addd@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-16-pierre-louis.bossart@linux.intel.com>
 <20190802122003.GQ12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802122003.GQ12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/2/19 7:20 AM, Vinod Koul wrote:
> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
>> When a Slave reports multiple status in the sticky bits, find the
>> latest configuration from the mirror of the PING frame status and
>> update the status directly.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 34 ++++++++++++++++++++++++------
>>   1 file changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 889fa2cd49ae..25d5c7267c15 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -643,13 +643,35 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
>>   
>>   		/* first check if Slave reported multiple status */
>>   		if (set_status > 1) {
>> +			u32 val;
>> +
>>   			dev_warn_ratelimited(cdns->dev,
>> -					     "Slave reported multiple Status: %d\n",
>> -					     mask);
>> -			/*
>> -			 * TODO: we need to reread the status here by
>> -			 * issuing a PING cmd
>> -			 */
>> +					     "Slave %d reported multiple Status: %d\n",
>> +					     i, mask);
>> +
>> +			/* re-check latest status extracted from PING commands */
>> +			val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
>> +			val >>= (i * 2);
>> +
>> +			switch (val & 0x3) {
>> +			case 0:
> 
> why not case CDNS_MCP_SLAVE_INTSTAT_NPRESENT:

ok

> 
>> +				status[i] = SDW_SLAVE_UNATTACHED;
>> +				break;
>> +			case 1:
>> +				status[i] = SDW_SLAVE_ATTACHED;
>> +				break;
>> +			case 2:
>> +				status[i] = SDW_SLAVE_ALERT;
>> +				break;
>> +			default:
>> +				status[i] = SDW_SLAVE_RESERVED;
>> +				break;
>> +			}
> 
> we have same logic in the code block preceding this, maybe good idea to
> write a helper and use for both

Yes, I am thinking about this. There are multiple cases where we want to 
re-check the status and clear some bits, so helpers would be good.

> 
> Also IIRC we can have multiple status set right?

Yes, the status bits are sticky and mirror all values reported in PING 
frames. I am still working on how to clear those bits, there are cases 
where we clear bits and end-up never hearing from that device ever 
again. classic edge/level issue I suppose.
