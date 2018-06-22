From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v6 3/3] ASoC: Add multiple CPU DAI support
	in DAPM
Date: Thu, 21 Jun 2018 21:55:54 -0500
Message-ID: <49d55d2e-5773-7279-f699-7509a290288f@linux.intel.com>
References: <1529492057-32627-1-git-send-email-shreyas.nc@intel.com>
 <1529492057-32627-4-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 475962673F2
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 04:55:56 +0200 (CEST)
In-Reply-To: <1529492057-32627-4-git-send-email-shreyas.nc@intel.com>
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
To: Shreyas NC <shreyas.nc@intel.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, ckeepax@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org



On 06/20/2018 05:54 AM, Shreyas NC wrote:
> DAPM handles DAIs during soc_dapm_stream_event() and during addition
> and creation of DAI widgets i.e., dapm_add_valid_dai_widget() and
> dapm_connect_dai_link_widgets().
can you split this patch in two, one where you add 
dapm_add_valid_dai_widget() and the second one where you add the 
multi-cpu stuff? the current diff format is really hard to read with the 
two changes lumped together.

> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> +
> +		for (j = 0; j < rtd->num_cpu_dai; j++) {
> +			cpu_dai = rtd->cpu_dais[j];
> +
> +			dapm_add_valid_dai_widget(card, rtd,
> +						codec_dai, cpu_dai);

I didn't click on this earlier, but what makes you think all codec_dais 
are connected to all cpu_dais?
That doesn't seem quite right.
For the multi-codec case, all the codec_dais hang from a single cpu_dai. 
it's a stretch for me to have a full M:N connectivity. And that's 
clearly not the case for SoundWire stream in the multi-link case.
Can't we use the dai_link information here to only connect cpu_ and 
codec_dais that are related?

>   		}
>   	}
>   }
> @@ -4211,7 +4230,9 @@ static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
>   {
>   	int i;
>   
> -	soc_dapm_dai_stream_event(rtd->cpu_dai, stream, event);
> +	for (i = 0; i < rtd->num_cpu_dai; i++)
> +		soc_dapm_dai_stream_event(rtd->cpu_dais[i], stream, event);
> +
>   	for (i = 0; i < rtd->num_codecs; i++)
>   		soc_dapm_dai_stream_event(rtd->codec_dais[i], stream, event);
>   
