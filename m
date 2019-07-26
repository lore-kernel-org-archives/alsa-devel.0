From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RFC PATCH 31/40] soundwire: intel: move shutdown() callback and
 don't export symbol
Date: Fri, 26 Jul 2019 12:38:10 +0200
Message-ID: <39318aab-b1b4-2cce-c408-792a5cc343dd@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
> +void intel_shutdown(struct snd_pcm_substream *substream,
> +		    struct snd_soc_dai *dai)
> +{
> +	struct sdw_cdns_dma_data *dma;
> +
> +	dma = snd_soc_dai_get_dma_data(dai, substream);
> +	if (!dma)
> +		return;
> +
> +	snd_soc_dai_set_dma_data(dai, substream, NULL);
> +	kfree(dma);
> +}

Correct me if I'm wrong, but do we really need to _get_dma_ here?
_set_dma_ seems bulletproof, same for kfree.
