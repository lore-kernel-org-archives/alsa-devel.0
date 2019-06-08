From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RFC PATCH 1/6] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Date: Sat, 8 Jun 2019 21:22:08 +0200
Message-ID: <13bfb632-f743-c416-2224-c7acb5b28604@intel.com>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607085643.932-2-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, vkoul@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2019-06-07 10:56, Srinivas Kandagatla wrote:
> On platforms which have smart speaker amplifiers connected via
> soundwire and modeled as aux devices in ASoC, in such usecases machine
> driver should be able to get sdw master stream from dai so that it can
> use the runtime stream to setup slave streams.
> 
> soundwire already as a set function, get function would provide more
> flexibility to above configurations.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   include/sound/soc-dai.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index f5d70041108f..9f90b936fd9a 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -177,6 +177,7 @@ struct snd_soc_dai_ops {
>   
>   	int (*set_sdw_stream)(struct snd_soc_dai *dai,
>   			void *stream, int direction);
> +	void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
>   	/*
>   	 * DAI digital mute - optional.
>   	 * Called by soc-core to minimise any pops.
> @@ -385,4 +386,13 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
>   		return -ENOTSUPP;
>   }
>   
> +static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai, int direction)

Exceeds character limit?

> +{
> +	if (dai->driver->ops->get_sdw_stream)
> +		return dai->driver->ops->get_sdw_stream(dai, direction);
> +	else
> +		return NULL;

set_ equivalent returns -ENOTSUPP instead.
ERR_PTR seems to make more sense here.

> +

Unnecessary newline.

> +}
> +
>   #endif
> 
