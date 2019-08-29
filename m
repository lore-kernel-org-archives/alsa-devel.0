From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v5 4/4] ASoC: codecs: add wsa881x amplifier
 support
Date: Thu, 29 Aug 2019 11:36:52 -0500
Message-ID: <33e04646-ac7e-3ba1-3e09-a4f27a1b250b@linux.intel.com>
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
 <20190829144442.6210-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829144442.6210-5-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, spapothi@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


> +static int wsa881x_ramp_pa_gain(struct snd_soc_component *comp,
> +				int min_gain, int max_gain, int udelay)
> +{
> +	int val;
> +
> +	for (val = min_gain; max_gain <= val; val--) {
> +		snd_soc_component_update_bits(comp, WSA881X_SPKR_DRV_GAIN,
> +					      0xF0, val << 4);
> +		/*
> +		 * 1ms delay is needed for every step change in gain as per
> +		 * HW requirement.
> +		 */
> +		usleep_range(udelay, udelay + 10);

nit-pick: it'd be nicer to have udelay explicitly set here instead of in 
the caller below for consistency with the comments.

> +			wsa881x_ramp_pa_gain(comp, min_gain, max_gain, 1000);

But apart from that I didn't see anything blatantly wrong, so

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
