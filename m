From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 02/25] ASoC: soc-component: add
 snd_soc_component_get/put()
Date: Wed, 24 Jul 2019 10:25:38 +0100
Message-ID: <20190724092538.GV54126@ediswmail.ad.cirrus.com>
References: <8736iwurtc.wl-kuninori.morimoto.gx@renesas.com>
 <87zhl4td7r.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 241D6F800E8
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 11:25:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87zhl4td7r.wl-kuninori.morimoto.gx@renesas.com>
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

On Wed, Jul 24, 2019 at 10:51:23AM +0900, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> ALSA SoC is calling try_module_get()/module_put() based on
> component->driver->module_get_upon_open.
> To keep simple and readable code, we should create its function.
> This patch adds new snd_soc_component_get/put().
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
> index d2f94cf..57270c2 100644
> --- a/include/sound/soc-component.h
> +++ b/include/sound/soc-component.h
> @@ -279,6 +279,11 @@ void snd_soc_component_init_regmap(struct snd_soc_component *component,
>  void snd_soc_component_exit_regmap(struct snd_soc_component *component);
>  #endif
>  
> +int snd_soc_component_module_get(struct snd_soc_component *component,
> +				 int has_flags);
> +void snd_soc_component_module_put(struct snd_soc_component *component,
> +				  int has_flags);

The name has_flags feels a little vague here, is the intention to
support more flags in the future? Or would something like
require_get_upon_open or something be better?

Thanks,
Charles
