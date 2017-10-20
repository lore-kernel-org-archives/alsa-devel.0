From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 03/14] soundwire: Add Master registration
Date: Fri, 20 Oct 2017 12:47:26 +0200
Message-ID: <20171020104726.GD3210@kroah.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508382211-3154-4-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 19, 2017 at 08:33:19AM +0530, Vinod Koul wrote:
> +void sdw_extract_slave_id(struct sdw_bus *bus,
> +			unsigned long long addr, struct sdw_slave_id *id)
> +{
> +	dev_dbg(bus->dev, "SDW Slave Addr: %llx", addr);
> +
> +	/*
> +	 * Spec definition
> +	 *   Register		Bit	Contents
> +	 *   DevId_0 [7:4]	47:44	sdw_version
> +	 *   DevId_0 [3:0]	43:40	unique_id
> +	 *   DevId_1		39:32	mfg_id [15:8]
> +	 *   DevId_2		31:24	mfg_id [7:0]
> +	 *   DevId_3		23:16	part_id [15:8]
> +	 *   DevId_4		15:08	part_id [7:0]
> +	 *   DevId_5		07:00	class_id
> +	 */
> +	id->sdw_version = (addr >> 44) & GENMASK(3, 0);
> +	id->unique_id = (addr >> 40) & GENMASK(3, 0);
> +	id->mfg_id = (addr >> 24) & GENMASK(15, 0);
> +	id->part_id = (addr >> 8) & GENMASK(15, 0);
> +	id->class_id = addr & GENMASK(7, 0);
> +
> +	dev_info(bus->dev,
> +		"SDW Slave class_id %x, part_id %x, mfg_id %x, unique_id %x, version %x",
> +				id->class_id, id->part_id, id->mfg_id,
> +				id->unique_id, id->sdw_version);
> +

Why are you so noisy?  Shouldn't this be dev_dbg()?


> +static void sdw_slave_release(struct device *dev)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +
> +	kfree(slave);
> +}

Ah, finally a release function, nice.  But that's all you need to do for
it?

thanks,

greg k-h
