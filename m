From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 07/40] soundwire: intel: fix channel number reported
 by hardware
Date: Fri, 2 Aug 2019 17:27:19 +0530
Message-ID: <20190802115719.GJ12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-8-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
> PDI2 reports an invalid count, force the correct hardware-supported
> value
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 497879dd9c0d..51990b192dc0 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -401,6 +401,15 @@ intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
>  
>  	if (pcm) {
>  		count = intel_readw(shim, SDW_SHIM_PCMSYCHC(link_id, pdi_num));
> +
> +		/*
> +		 * TODO: pdi number 2 reports channel count as 1 even though
> +		 * it supports 8 channel. Performing hardcoding for pdi
> +		 * number 2.
> +		 */
> +		if (pdi_num == 2)
> +			count = 7;

Is that true for all Intel controllers or some generations. Would it not
be better to put this under some flag which is set on platform basis?

> +
>  	} else {
>  		count = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
>  		count = ((count & SDW_SHIM_PDMSCAP_CPSS) >>
> -- 
> 2.20.1

-- 
~Vinod
