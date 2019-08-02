From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 17/40] soundwire: bus: use runtime_pm_get_sync/pm
 when enabled
Date: Fri, 2 Aug 2019 22:28:16 +0530
Message-ID: <20190802165816.GU12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> Not all platforms support runtime_pm for now, let's use runtime_pm
> only when enabled.

We discussed this with Ulf sometime back and it was a consensus the core
should handle it, but that may take a while.

So that led me to explore what others do notably ASoC, based on this I
feel we should not check the error code. We handle the non streaming
case here but streaming is handled in ASoC which doesnt check the return

Pierre, can you verify the below patch and let me know if that is fine
for Intel platforms

--- >8 ---

From: Vinod Koul <vkoul@kernel.org>
Date: Fri, 2 Aug 2019 22:15:11 +0530
Subject: [PATCH] soundwire: dont check return of pm_runtime_get_sync()

Soundwire core checks pm_runtime_get_sync() return. But in case the
driver has not enabled runtime pm we get an error.

To fix this, dont check the return. We handle the non streaming case in
framework but streaming case has similar handling in ASoC so make it
same across use cases

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/bus.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index fe745830a261..9cdf7e9e0852 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -326,9 +326,7 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
-		return ret;
+	pm_runtime_get_sync(slave->bus->dev);
 
 	ret = sdw_transfer(slave->bus, &msg);
 	pm_runtime_put(slave->bus->dev);
@@ -354,9 +352,7 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
-		return ret;
+	pm_runtime_get_sync(slave->bus->dev);
 
 	ret = sdw_transfer(slave->bus, &msg);
 	pm_runtime_put(slave->bus->dev);
-- 
2.20.1



> 
> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 5ad4109dc72f..0a45dc5713df 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -332,12 +332,16 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = pm_runtime_get_sync(slave->bus->dev);
> -	if (ret < 0)
> -		return ret;
> +	if (pm_runtime_enabled(slave->bus->dev)) {
> +		ret = pm_runtime_get_sync(slave->bus->dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	ret = sdw_transfer(slave->bus, &msg);
> -	pm_runtime_put(slave->bus->dev);
> +
> +	if (pm_runtime_enabled(slave->bus->dev))
> +		pm_runtime_put(slave->bus->dev);
>  
>  	return ret;
>  }
> @@ -359,13 +363,16 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>  			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
>  	if (ret < 0)
>  		return ret;
> -
> -	ret = pm_runtime_get_sync(slave->bus->dev);
> -	if (ret < 0)
> -		return ret;
> +	if (pm_runtime_enabled(slave->bus->dev)) {
> +		ret = pm_runtime_get_sync(slave->bus->dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	ret = sdw_transfer(slave->bus, &msg);
> -	pm_runtime_put(slave->bus->dev);
> +
> +	if (pm_runtime_enabled(slave->bus->dev))
> +		pm_runtime_put(slave->bus->dev);
>  
>  	return ret;
>  }
> -- 
> 2.20.1

-- 
~Vinod
