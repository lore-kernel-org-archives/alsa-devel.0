From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] soundwire: fix style issues
Date: Thu, 04 Apr 2019 12:28:28 -0700
Message-ID: <98050a8abfdd9ec015d4de846b276cf046115e3f.camel@perches.com>
References: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
         <20190404182204.31262-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404182204.31262-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2019-04-04 at 13:22 -0500, Pierre-Louis Bossart wrote:
> Visual inspections confirmed by checkpatch.pl --strict expose a number
> of style issues, specifically parameter alignment is inconsistent as
> if different contributors used different styles. Before we restart
> support for SoundWire with Sound Open Firmware on Intel platforms,
> let's clean all this.
> 
> Fix Kconfig help, spelling, SPDX format, alignment, spurious
> parentheses, bool comparisons to true/false, macro argument
> protection.
> 
> No new functionality added.

[]

> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
[]
> @@ -458,13 +458,13 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
>  		mutex_unlock(&slave->bus->bus_lock);
>  		if (dev_num < 0) {
>  			dev_err(slave->bus->dev, "Get dev_num failed: %d",
> -								dev_num);
> +				dev_num);

You could also add the missing terminating '\n' to these formats like:

 			dev_err(slave->bus->dev, "Get dev_num failed: %d\n",

>  			return dev_num;
>  		}
>  	} else {
>  		dev_info(slave->bus->dev,
> -				"Slave already registered dev_num:%d",
> -				slave->dev_num);
> +			 "Slave already registered dev_num:%d",
> +			 slave->dev_num);

etc...
