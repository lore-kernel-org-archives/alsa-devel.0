From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 05/13] soundwire: Add helpers for ports
 operations
Date: Mon, 23 Apr 2018 08:27:46 -0500
Message-ID: <8b7c2b73-0bd5-c7b2-10b2-1e1c2098ebd5@linux.intel.com>
References: <1524049146-8725-1-git-send-email-vinod.koul@intel.com>
 <1524049146-8725-6-git-send-email-vinod.koul@intel.com>
 <50695e9e-c9a2-9636-d982-64f8c570cc06@linux.intel.com>
 <20180421155331.GL6014@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E9173266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 15:27:50 +0200 (CEST)
In-Reply-To: <20180421155331.GL6014@localhost>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 4/21/18 10:53 AM, Vinod Koul wrote:
> On Sat, Apr 21, 2018 at 06:47:24AM -0700, Pierre-Louis Bossart wrote:
>>
>>> +static int sdw_enable_disable_slave_ports(struct sdw_bus *bus,
>>> +				struct sdw_slave_runtime *s_rt,
>>> +				struct sdw_port_runtime *p_rt, bool en)
>>> +{
>>> +	struct sdw_transport_params *t_params = &p_rt->transport_params;
>>> +	u32 addr;
>>> +	int ret;
>>> +
>>> +	if (bus->params.next_bank)
>>> +		addr = SDW_DPN_CHANNELEN_B1(p_rt->num);
>>> +	else
>>> +		addr = SDW_DPN_CHANNELEN_B0(p_rt->num);
>>> +
>>> +	/*
>>> +	 * Since bus doesn't support sharing a port across two streams,
>>> +	 * it is safe to reset this register
>>> +	 */
>>> +	if (en)
>>> +		ret = sdw_update(s_rt->slave, addr, 0xFF, p_rt->ch_mask);
>>> +	else
>>> +		ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
>>> +
>>> +	if (ret < 0)
>>> +		dev_err(&s_rt->slave->dev,
>>> +			"Slave chn_en reg write failed:%d port:%d",
>>> +			ret, t_params->port_num);
>>> +
>>> +	return ret;
>>> +}
>>
>> Add a clarification that this routine only sets the enable/disable bits in
>> the relevant bank, the actual enable/disable is done with a bank switch.
> 
> Isn't that something spec tells the reader? this is a SDW concept that we
> program bank and then switch to have the effect, so why would i add comment
> for that?

To make sure people understand your code and follow the recommendation 
from the spec. It's legal to write directly in enable bits but it's not 
recommended at all. A standard spec is always interpreted in different 
ways, adding a comment helps.
