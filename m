From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: Add initial support for multiple
 CPU DAIs
Date: Fri, 9 Mar 2018 14:50:43 +0000
Message-ID: <20180309145043.lmdw5r3x7rhplk6x@localhost.localdomain>
References: <1520334030-8018-1-git-send-email-shreyas.nc@intel.com>
 <1520334030-8018-2-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E9FF32670F9
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 15:50:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1520334030-8018-2-git-send-email-shreyas.nc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, kuninori.morimoto.gx@renesas.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 06, 2018 at 04:30:28PM +0530, Shreyas NC wrote:
> For usecases where a stream consists of multiple BE CPU DAIs,
> DAI Link should support the same.
> 
> This patch adds initial support for multiple CPU DAIs in ASoC for
> card instantiation, suspend and resume functions.
> 
> This support is added only for BE DAI Links. Support for FE and
> Codec-Codec Links is not added.
> 
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> ---
> @@ -679,13 +687,17 @@ int snd_soc_suspend(struct device *dev)
>  		card->suspend_pre(card);
>  
>  	list_for_each_entry(rtd, &card->rtd_list, list) {
> -		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +		struct snd_soc_dai *cpu_dai;
>  
>  		if (rtd->dai_link->ignore_suspend)
>  			continue;
>  
> -		if (cpu_dai->driver->suspend && !cpu_dai->driver->bus_control)
> -			cpu_dai->driver->suspend(cpu_dai);
> +		for (i = 0; i < rtd->num_cpu_dai; i++) {
> +			cpu_dai = rtd->cpu_dais[i];
> +			if (cpu_dai->driver->suspend &&
> +					!cpu_dai->driver->bus_control)
> +				cpu_dai->driver->suspend(cpu_dai);
> +		}
>  	}
>  
>  	/* close any waiting streams */
> @@ -793,13 +805,18 @@ static void soc_resume_deferred(struct work_struct *work)

Is there not another call to cpu_dai->driver->suspend at the
bottom of snd_soc_suspend you need to handle?

> @@ -1680,9 +1760,11 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>  	/* set default power off timeout */
>  	rtd->pmdown_time = pmdown_time;
>  
> -	ret = soc_probe_dai(cpu_dai, order);
> -	if (ret)
> -		return ret;
> +	for (i = 0; i < rtd->num_cpu_dai; i++) {
> +		ret = soc_probe_dai(rtd->cpu_dais[i], order);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/* probe the CODEC DAI */
>  	for (i = 0; i < rtd->num_codecs; i++) {
> @@ -1718,9 +1800,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>  		soc_dpcm_debugfs_add(rtd);
>  #endif
>  
> -	if (cpu_dai->driver->compress_new) {
> +	if (rtd->cpu_dais[0]->driver->compress_new) {
>  		/*create compress_device"*/
> -		ret = cpu_dai->driver->compress_new(rtd, rtd->num);
> +		ret = rtd->cpu_dais[0]->driver->compress_new(rtd, rtd->num);
>  		if (ret < 0) {
>  			dev_err(card->dev, "ASoC: can't create compress %s\n",
>  					 dai_link->stream_name);

Is it worth throwing an error or printing a warning to say that
we don't support multiple DAIs on the compressed framework? Not
sure if here is were we should do that though.

> @@ -1736,7 +1818,8 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
>  				       dai_link->stream_name, ret);
>  				return ret;
>  			}
> -			ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
> +			ret = soc_link_dai_pcm_new(rtd->cpu_dais,
> +					rtd->num_cpu_dai, rtd);
>  			if (ret < 0)
>  				return ret;
>  			ret = soc_link_dai_pcm_new(rtd->codec_dais,
> @@ -2361,10 +2444,11 @@ int snd_soc_poweroff(struct device *dev)

Do we need to update the handling in snd_soc_runtime_set_dai_fmt?
Seems like we skipped over that.

Thanks,
Charles
