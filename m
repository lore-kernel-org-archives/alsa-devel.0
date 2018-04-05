From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 08/13] ASoC: Add SoundWire stream
	programming interface
Date: Thu, 5 Apr 2018 18:42:53 -0500
Message-ID: <7fc98a33-6e48-604e-73b7-308a798f5d66@linux.intel.com>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B9383267299
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 01:42:56 +0200 (CEST)
In-Reply-To: <1522946904-2089-9-git-send-email-vinod.koul@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On 4/5/18 11:48 AM, Vinod Koul wrote:
> From: Shreyas NC <shreyas.nc@intel.com>
> 
> SoundWire stream needs to be propagated to all the DAIs(cpu, codec).
> So, add a snd_soc_dai_set_sdw_stream() API for the same.
> 
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>   include/sound/soc-dai.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 58acd00cae19..405c4c304f87 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -168,6 +168,8 @@ struct snd_soc_dai_ops {
>   		unsigned int rx_num, unsigned int *rx_slot);
>   	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
>   
> +	int (*set_sdw_stream)(struct snd_soc_dai *dai,
> +			void *stream, int direction);
>   	/*
>   	 * DAI digital mute - optional.
>   	 * Called by soc-core to minimise any pops.
> @@ -359,4 +361,23 @@ static inline void *snd_soc_dai_get_drvdata(struct snd_soc_dai *dai)
>   	return dev_get_drvdata(dai->dev);
>   }
>   
> +/**
> + * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
> + * @dai: DAI
> + * @stream: STREAM
> + * @direction: Stream direction(Playback/Capture)
> + * SoundWire subsystem doesn't have a notion of direction and we reuse
> + * the ASoC stream direction to configure sink/source ports.

Playback == source, Capture == sink?
what is the mapping convention?

> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
> +				void *stream, int direction)
> +{
> +	if (dai->driver->ops->set_sdw_stream)
> +		return dai->driver->ops->set_sdw_stream(dai, stream, direction);
> +	else
> +		return -ENOTSUPP;
> +}
> +
>   #endif
> 
