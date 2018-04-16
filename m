From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 08/13] ASoC: Add SoundWire stream
 programming interface
Date: Mon, 16 Apr 2018 18:42:00 -0500
Message-ID: <5a3db5a1-e768-2d38-8aaa-36165d02d6b4@linux.intel.com>
References: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
 <1523892221-16169-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 5462F2673D4
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 01:42:03 +0200 (CEST)
In-Reply-To: <1523892221-16169-9-git-send-email-vinod.koul@intel.com>
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



On 04/16/2018 10:23 AM, Vinod Koul wrote:
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
> index 58acd00cae19..0997d4593f6d 100644
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
> + * the ASoC stream direction to configure source/sink ports.
same issue as in v2, what is the convention here? How do you map 
playback/capture to source/sink?

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
