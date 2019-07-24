From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 24/25] ASoC: soc-component: move
 snd_soc_component_stream_event()
Date: Wed, 24 Jul 2019 10:37:47 +0100
Message-ID: <20190724093747.GX54126@ediswmail.ad.cirrus.com>
References: <8736iwurtc.wl-kuninori.morimoto.gx@renesas.com>
 <874l3ctd42.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 460FDF800E8
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 11:37:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <874l3ctd42.wl-kuninori.morimoto.gx@renesas.com>
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

On Wed, Jul 24, 2019 at 10:53:37AM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch moves snd_soc_component_stream_event() to soc-component.c
> It will be used at soc-dapm.c :: dapm_power_widgets(),
> but no effect by this patch.
> 
> 	static int dapm_power_widgets(struct snd_soc_card *card, int event)
> 	{
> 		...
> 		list_for_each_entry(d, &card->dapm_list, list) {
> =>			if (d->stream_event)
> =>				d->stream_event(d, event);
> 		}
> 		...
> 	}
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
> index e4e8fc4..ab8e7cc 100644
> --- a/sound/soc/soc-component.c
> +++ b/sound/soc/soc-component.c
> @@ -61,6 +61,16 @@ void snd_soc_component_seq_notifier(struct snd_soc_dapm_context *dapm,
>  		component->driver->seq_notifier(component, type, subseq);
>  }
>  
> +int snd_soc_component_stream_event(struct snd_soc_dapm_context *dapm,
> +				   int event)
> +{
> +	struct snd_soc_component *component = dapm->component;
> +
> +	if (component->driver->stream_event)
> +		return component->driver->stream_event(component, event);
> +	return 0;

Minor nitpick but a blank line before the return would be more
normal and consistent with your other patches.

> @@ -2729,8 +2721,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
>  	dapm->idle_bias_off = !driver->idle_bias_on;
>  	dapm->suspend_bias_off = driver->suspend_bias_off;
>  	dapm->seq_notifier = snd_soc_component_seq_notifier;
> -	if (driver->stream_event)
> -		dapm->stream_event = snd_soc_component_stream_event;
> +	dapm->stream_event = snd_soc_component_stream_event;

Obviously same comment regarding the NULL checks in DAPM applies
here.

Thanks,
Charles
