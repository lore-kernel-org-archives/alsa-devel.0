From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 10/25] ASoC: soc-component: add
 snd_soc_component_ioctrl()
Date: Wed, 24 Jul 2019 10:23:22 +0100
Message-ID: <20190724092322.GU54126@ediswmail.ad.cirrus.com>
References: <8736iwurtc.wl-kuninori.morimoto.gx@renesas.com>
 <87o91ktd6m.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79741F800E8
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 11:23:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87o91ktd6m.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 24, 2019 at 10:52:05AM +0900, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current ALSA SoC is directly using component->driver->ops->xxx,
> thus, it is deep nested, and makes code difficult to read,
> and is not good for encapsulation.
> This patch adds new snd_soc_component_ioctrl() and use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 7ab68de..064d16c 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1116,6 +1116,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>  		component = rtdcom->component;
>  
>  		offset = snd_soc_component_pointer(component, substream);
> +

This whitespace change belongs in the previous patch.

>  		/* FIXME: use 1st pointer */
>  		if (offset > 0)
>  			break;
> @@ -2455,16 +2456,15 @@ static int soc_pcm_ioctl(struct snd_pcm_substream *substream,
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_component *component;
>  	struct snd_soc_rtdcom_list *rtdcom;
> +	int ret;
>  
>  	for_each_rtdcom(rtd, rtdcom) {
>  		component = rtdcom->component;
>  
> -		if (!component->driver->ops ||
> -		    !component->driver->ops->ioctl)
> -			continue;
> -
> +		ret = snd_soc_component_ioctl(component, substream, cmd, arg);
>  		/* FIXME: use 1st ioctl */
> -		return component->driver->ops->ioctl(substream, cmd, arg);
> +		if (ret != -ENOTSUPP)
> +			return ret;

This feels a little forced, and also changes behaviour if any
ioctl callbacks already report -ENOTSUPP.

I wonder if for some/all of these functions it might be worth
abstracting them at a higher level so the whole for_each_rtdcom
loop moves into the helper function similar to what I did with
compress stuff, for example in these patches:

1e57b82891ad ("ASoC: compress: Add helper functions for component open/free")
4ef0ecb80e34 ("ASoC: compress: Add helper functions for component trigger/set_params")

Thanks,
Charles
