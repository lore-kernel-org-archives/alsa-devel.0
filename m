From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] ASoC: rsnd: add missing src/dst_addr_width
	for DMAEngine
Date: Tue, 22 Jul 2014 15:15:27 +0200
Message-ID: <1821348.E9ac8e01qX@avalon>
References: <87sim0ece5.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [95.142.166.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 04FBE2654E9
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 15:15:14 +0200 (CEST)
In-Reply-To: <87sim0ece5.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

Thank you for the patch.

On Wednesday 16 July 2014 23:18:44 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Renesas new DMAEngine driver requests src/dst_addr_width
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> >> Laurent
> 
> Could you please check and give your Ack to this patch?
> 
>  sound/soc/sh/rcar/core.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
> index 907d480..c48d999 100644
> --- a/sound/soc/sh/rcar/core.c
> +++ b/sound/soc/sh/rcar/core.c
> @@ -338,6 +338,8 @@ int rsnd_dma_init(struct rsnd_priv *priv, struct
> rsnd_dma *dma, cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
>  	cfg.src_addr	= rsnd_gen_dma_addr(priv, mod_from, is_play, 1);
>  	cfg.dst_addr	= rsnd_gen_dma_addr(priv, mod_to,   is_play, 0);
> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> 
>  	dev_dbg(dev, "dma : %s %pad -> %pad\n",
>  		dma_name, &cfg.src_addr, &cfg.dst_addr);

-- 
Regards,

Laurent Pinchart
