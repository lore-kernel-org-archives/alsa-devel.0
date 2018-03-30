From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 08/13] ASoC: Add SoundWire stream
	programming interface
Date: Fri, 30 Mar 2018 12:05:00 +0900
Message-ID: <355ca9b5-d6c4-9423-8cf6-a1c73fbdc695@sakamocchi.jp>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
 <1522229918-4748-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id CC0892671B9
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 05:05:03 +0200 (CEST)
In-Reply-To: <1522229918-4748-9-git-send-email-vinod.koul@intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 28 2018 18:38, Vinod Koul wrote:
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index c0edac80df34..690e56a35237 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2882,6 +2882,26 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
>   EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
>   
>   /**
> + * snd_soc_dai_set_sdw_stream() - Configures a DAI for SDW stream operation
> + * @dai: DAI
> + * @stream: STREAM
> + * @direction: Stream direction(Playback/Capture)
> + * SoundWire subsystem doesn't have a notion of direction and we reuse
> + * the ASoC stream direction to configure sink/source ports.
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
> +				void *stream, int direction)
> +{
> +	if (dai->driver->ops->set_sdw_stream)
> +		return dai->driver->ops->set_sdw_stream(dai, stream, direction);
> +	else
> +		return -ENOTSUPP;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_dai_set_sdw_stream);

It's better for this kind of code to be incline function in any header. 
In general, new symbols increase maintenance cost of binary of 
kernel-related stuffs. It's preferable to avoid the addition if 
possible, IMO.


Regards

Takashi Sakamoto
