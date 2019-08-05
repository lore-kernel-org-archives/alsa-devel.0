From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 27/40] soundwire: Add Intel resource
 management algorithm
Date: Mon, 5 Aug 2019 14:08:28 -0500
Message-ID: <89fe8170-c252-5bea-a565-631e5b682dbb@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-28-pierre-louis.bossart@linux.intel.com>
 <20190805165422.GB24889@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3C20F800F3
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 21:08:32 +0200 (CEST)
In-Reply-To: <20190805165422.GB24889@buildpc-HP-Z230>
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
To: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org


>> +static int sdw_select_row_col(struct sdw_bus *bus, int clk_freq)
>> +{
>> +	struct sdw_master_prop *prop = &bus->prop;
>> +	int frame_int, frame_freq;
>> +	int r, c;
>> +
>> +	for (c = 0; c < SDW_FRAME_COLS; c++) {
>> +		for (r = 0; r < SDW_FRAME_ROWS; r++) {
>> +			if (sdw_rows[r] != prop->default_row ||
>> +			    sdw_cols[c] != prop->default_col)
>> +				continue;
> 
> Are we only supporting default rows and cols?

for now yes. Note that the default is defined by firmware and e.g. 
different for ICL (50x4) and CML (125x2). The firmware itself also 
provides a single clock value so we'd need to override the DSDT or force 
the properties to be different to use multiple gears.

This will probably change at some point when we have multiple device per 
link. SoundWire 1.2 devices also provide a standard means to control the 
clock, otherwise with SoundWire 1.1 the clock management requires quite 
a bit of imp-def changes that we have not tested.

> 
>> +
>> +			frame_int = sdw_rows[r] * sdw_cols[c];
>> +			frame_freq = clk_freq / frame_int;
>> +
>> +			if ((clk_freq - (frame_freq * SDW_FRAME_CTRL_BITS)) <
>> +			    bus->params.bandwidth)
>> +				continue;
>> +
>> +			bus->params.row = sdw_rows[r];
>> +			bus->params.col = sdw_cols[c];
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> -- 
>> 2.20.1
>>
> 
