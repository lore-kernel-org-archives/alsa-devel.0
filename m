From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
Date: Mon, 22 Apr 2019 11:31:41 +0530
Message-ID: <20190422060141.GW28103@vkoul-mobl>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
 <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 19-04-19, 14:46, Pierre-Louis Bossart wrote:
> The mechanism should be
> 
> config CODEC_XYX_SDW
>        depends on SOUNDWIRE
>        select REGMAP_SOUNDWIRE
> 
> config REGMAP_SOUNDWIRE
>        select SOUNDWIRE_BUS
> 
> SOUNDWIRE_BUS can be independently selected by the SOC driver. The SOC
> driver should not know or care about REGMAP_SOUNDWIRE.

lgtm, Mark can I have ypu ack so that I can carry the series thru
soundwire tree

Thanks

> Fixes: 7c22ce6e2184 ('03fc8746f7915b5a391d8227f7e1')
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/base/regmap/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index 6ad5ef48b61e..c12e3f1fb110 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -44,7 +44,7 @@ config REGMAP_IRQ
>  
>  config REGMAP_SOUNDWIRE
>  	tristate
> -	depends on SOUNDWIRE_BUS
> +	select SOUNDWIRE_BUS
>  
>  config REGMAP_SCCB
>  	tristate
> -- 
> 2.17.1

-- 
~Vinod
