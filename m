From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 45/54 v2] ASoC: switch over to use
 snd_soc_register_component() on sh4 hac
Date: Thu, 21 Mar 2013 11:01:34 -0600
Message-ID: <514B3CEE.9060609@wwwdotorg.org>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
 <87a9pxca4i.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D7FEE265F8C
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 18:01:37 +0100 (CET)
In-Reply-To: <87a9pxca4i.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2013 04:36 AM, Kuninori Morimoto wrote:

>  static int hac_soc_platform_probe(struct platform_device *pdev)
>  {
> -	return snd_soc_register_dais(&pdev->dev, sh4_hac_dai,
> -			ARRAY_SIZE(sh4_hac_dai));
> +	return snd_soc_register_component(&pdev->dev, &sh4_hac_component,
> +					  sh4_hac_dai, ARRAY_SIZE(sh4_hac_dai));
>  }

Again, ARRAY_SIZE(sh4_hac_dai) == 1 or 2 based on #ifdef
CONFIG_CPU_SUBTYPE_SH7760, so the names might change due to falling back
to snd_soc_register_dai() instead of snd_soc_register_dais().
