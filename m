From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 19/54 v2] ASoC: switch over to use
 snd_soc_register_component() on mpc5200 i2s
Date: Thu, 21 Mar 2013 10:53:27 -0600
Message-ID: <514B3B07.4030309@wwwdotorg.org>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
 <87boaddox7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id BCBF3265F8C
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 17:53:32 +0100 (CET)
In-Reply-To: <87boaddox7.wl%kuninori.morimoto.gx@renesas.com>
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

On 03/21/2013 04:31 AM, Kuninori Morimoto wrote:

> diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c

> @@ -163,7 +167,8 @@ static int psc_i2s_of_probe(struct platform_device *op)
>  	if (rc != 0)
>  		return rc;
>  
> -	rc = snd_soc_register_dais(&op->dev, psc_i2s_dai, ARRAY_SIZE(psc_i2s_dai));
> +	rc = snd_soc_register_component(&op->dev, &psc_i2s_component,
> +					psc_i2s_dai, ARRAY_SIZE(psc_i2s_dai));

ARRAY_SIZE(psc_i2s_dai)==1, so this switches from
snd_soc_register_dais() to snd_soc_register_dai(). Will that be a problem?
