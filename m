From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 34/40] soundwire: intel: ignore disabled links for
 suspend/resume
Date: Fri, 2 Aug 2019 23:00:47 +0530
Message-ID: <20190802173047.GD12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-35-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-35-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:

Please add explanation why..

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 1477c35f616f..a976480d6f36 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1161,6 +1161,12 @@ static int intel_suspend(struct device *dev)
>  
>  	sdw = dev_get_drvdata(dev);
>  
> +	if (sdw->cdns.bus.prop.hw_disabled) {
> +		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
> +			sdw->cdns.bus.link_id);
> +		return 0;
> +	}
> +
>  	ret = intel_link_power_down(sdw);
>  	if (ret) {
>  		dev_err(dev, "Link power down failed: %d", ret);
> @@ -1179,6 +1185,12 @@ static int intel_resume(struct device *dev)
>  
>  	sdw = dev_get_drvdata(dev);
>  
> +	if (sdw->cdns.bus.prop.hw_disabled) {
> +		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
> +			sdw->cdns.bus.link_id);
> +		return 0;
> +	}
> +
>  	ret = intel_init(sdw);
>  	if (ret) {
>  		dev_err(dev, "%s failed: %d", __func__, ret);
> -- 
> 2.20.1

-- 
~Vinod
