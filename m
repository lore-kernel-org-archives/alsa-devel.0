From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 08/14] soundwire: Add Slave status handling helpers
Date: Thu, 16 Nov 2017 16:05:29 +0000
Message-ID: <06a1bcfc-eeca-b3ec-1d74-e6ac9cadce53@linaro.org>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510314556-13002-9-git-send-email-vinod.koul@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


Minor Comment!

On 10/11/17 11:49, Vinod Koul wrote:
> From: Sanyog Kale <sanyog.r.kale@intel.com>
> 
> SoundWire Slaves report status to bus. Add helpers to handle
> the status changes.
> 
> Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---

> +static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
> +{
> +
> +	if ((slave->id.unique_id != id.unique_id) ||
> +	    (slave->id.mfg_id != id.mfg_id) ||
> +	    (slave->id.part_id != id.part_id) ||
> +	    (slave->id.class_id != id.class_id))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +/* called with bus_lock held */
> +static int sdw_get_device_num(struct sdw_slave *slave)
> +{
If we use ida we would not need this function.

> +	int bit;
> +
> +	bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
> +	if (bit == SDW_MAX_DEVICES) {
> +		bit = -ENODEV;
> +		goto err;
> +	}
> +
> +	/*
> +	 * Do not update dev_num in Slave data structure here,
> +	 * Update once program dev_num is successful
> +	 */
> +	set_bit(bit, slave->bus->assigned);
> +
> +err:
> +	return bit;
> +}
> +
> +static int sdw_assign_device_num(struct sdw_slave *slave)
> +{
> +	int ret, dev_num;
> +
> +	/* check first if device number is assigned, if so reuse that */
> +	if (!slave->dev_num) {
> +		mutex_lock(&slave->bus->bus_lock);
> +		dev_num = sdw_get_device_num(slave);
> +		mutex_unlock(&slave->bus->bus_lock);
> +		if (dev_num < 0) {
> +			dev_err(slave->bus->dev, "Get dev_num failed: %d",
> +								dev_num);
> +			return dev_num;
> +		}
> +	} else {
> +		dev_info(slave->bus->dev,
> +				"Slave already registered dev_num:%d",
> +				slave->dev_num);
> +
> +		/* Clear the slave->dev_num to transfer message on device 0 */
> +		dev_num = slave->dev_num;
> +		slave->dev_num = 0;
> +
> +	}
> +
> +	ret = sdw_write(slave, SDW_SCP_DEVNUMBER, dev_num);
> +	if (ret < 0) {
> +		dev_err(&slave->dev, "Program device_num failed: %d", ret);
> +		return ret;
> +	}
> +
> +	/* After xfer of msg, restore dev_num */
> +	slave->dev_num = dev_num;
> +
> +	return 0;
> +}
> +
>   void sdw_extract_slave_id(struct sdw_bus *bus,
>   			u64 addr, struct sdw_slave_id *id)
>   {
> @@ -447,3 +534,129 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
>   				id->unique_id, id->sdw_version);
>   
>   }
> +
>
