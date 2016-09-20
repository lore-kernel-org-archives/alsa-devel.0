From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: fsl_asrc: use flat regmap cache
Date: Mon, 19 Sep 2016 23:50:05 -0700
Message-ID: <20160920065004.GA5118@Asurada-CZ80>
References: <20160919193029.8119-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
 [209.85.220.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 883FE2665C1
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 08:50:16 +0200 (CEST)
Received: by mail-pa0-f66.google.com with SMTP id oz2so483070pac.0
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 23:50:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160919193029.8119-1-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 19, 2016 at 09:30:25PM +0200, Marek Vasut wrote:
> Same as commit ce492b3b8f99cf9d2f807ec22d8805c996a09503
> Subject: drm/fsl-dcu: use flat regmap cache
> 
> Using flat regmap cache instead of RB-tree to avoid the following
> lockdep warning on driver load:
> WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:2871 lockdep_trace_alloc+0x104/0x128
> DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
> 
> The RB-tree regmap cache needs to allocate new space on first
> writes. However, allocations in an atomic context (e.g. when a
> spinlock is held) are not allowed. The function regmap_write
> calls map->lock, which acquires a spinlock in the fast_io case.
> Since the driver uses MMIO, the regmap bus of type regmap_mmio
> is being used which has fast_io set to true.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>

Tested on i.MX6 Solo X SDB. For the whole series,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
Nicolin

> Cc: Timur Tabi <timur@tabi.org>
> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index b7157ce..1d82f68 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -726,7 +726,7 @@ static const struct regmap_config fsl_asrc_regmap_config = {
>  	.readable_reg = fsl_asrc_readable_reg,
>  	.volatile_reg = fsl_asrc_volatile_reg,
>  	.writeable_reg = fsl_asrc_writeable_reg,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_FLAT,
>  };
>  
>  /**
> -- 
> 2.9.3
> 
