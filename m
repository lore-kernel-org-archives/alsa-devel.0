From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 23/25] ASoC: soc-component: move
 snd_soc_component_seq_notifier()
Date: Wed, 24 Jul 2019 10:35:35 +0100
Message-ID: <20190724093535.GW54126@ediswmail.ad.cirrus.com>
References: <8736iwurtc.wl-kuninori.morimoto.gx@renesas.com>
 <875znstd4h.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B1A1F800E8
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 11:35:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <875znstd4h.wl-kuninori.morimoto.gx@renesas.com>
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

On Wed, Jul 24, 2019 at 10:53:22AM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch moves snd_soc_component_seq_notifier() to soc-component.c
> It will be used at soc-dapm.c :: dapm_seq_run(),
> but no effect by this patch.
> 
> 	static void dapm_seq_run(...)
> 	{
> 		...
> =>		if (cur_dapm && cur_dapm->seq_notifier) {
> 			for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
> 				if (sort[i] == cur_sort)
> =>					cur_dapm->seq_notifier(cur_dapm,
> 							       i,
> 							       cur_subseq);
> 		}
> 		...
> 	}
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> +void snd_soc_component_seq_notifier(struct snd_soc_dapm_context *dapm,
> +				    enum snd_soc_dapm_type type, int subseq)
> +{
> +	struct snd_soc_component *component = dapm->component;
> +
> +	if (component->driver->seq_notifier)
> +		component->driver->seq_notifier(component, type, subseq);
> +}
> +
>  int snd_soc_component_enable_pin(struct snd_soc_component *component,
>  				 const char *pin)
>  {
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 573192d..84ded01 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
>  static int snd_soc_component_stream_event(struct snd_soc_dapm_context *dapm,
>  	int event)
>  {
> @@ -2736,8 +2728,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
>  	dapm->bias_level = SND_SOC_BIAS_OFF;
>  	dapm->idle_bias_off = !driver->idle_bias_on;
>  	dapm->suspend_bias_off = driver->suspend_bias_off;
> -	if (driver->seq_notifier)
> -		dapm->seq_notifier = snd_soc_component_seq_notifier;
> +	dapm->seq_notifier = snd_soc_component_seq_notifier;

If we are updating this to always set a seq_notifier would it be
worth removing the NULL checks in soc-dapm.c? At the moment I
guess it will end up checking twice, DAPM checks if dapm->seq_notifier
is NULL but it never will be, then the helper checks if
driver->seq_notifier is NULL.

Thanks,
Charles
