From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 08/40] soundwire: intel: remove BIOS work-arounds
Date: Fri, 2 Aug 2019 17:28:38 +0530
Message-ID: <20190802115838.GK12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-9-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-9-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> the values passed by all existing BIOS are fine, let's use them as is.
> The existing code must have been needed only on early prototypes.

Thanks for this, I am applying this.

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 51990b192dc0..c718c9c67a37 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -922,17 +922,6 @@ static int intel_prop_read(struct sdw_bus *bus)
>  	/* Initialize with default handler to read all DisCo properties */
>  	sdw_master_read_prop(bus);
>  
> -	/* BIOS is not giving some values correctly. So, lets override them */
> -	bus->prop.num_clk_freq = 1;
> -	bus->prop.clk_freq = devm_kcalloc(bus->dev, bus->prop.num_clk_freq,
> -					  sizeof(*bus->prop.clk_freq),
> -					  GFP_KERNEL);
> -	if (!bus->prop.clk_freq)
> -		return -ENOMEM;
> -
> -	bus->prop.clk_freq[0] = bus->prop.max_clk_freq;
> -	bus->prop.err_threshold = 5;
> -
>  	return 0;
>  }
>  
> -- 
> 2.20.1

-- 
~Vinod
