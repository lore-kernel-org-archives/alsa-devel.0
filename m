From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: OF DMAEngine API based on
 CONFIG_DMA_OF instead of CONFIG_OF
Date: Mon, 24 Aug 2015 14:48:38 +0530
Message-ID: <20150824091838.GH13546@localhost>
References: <87wpwpurzk.wl%kuninori.morimoto.gx@renesas.com>
 <20150821082636.GK13546@localhost>
 <87d1yglvcy.wl%kuninori.morimoto.gx@renesas.com>
 <87bne0lvbe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FE9826063A
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 11:16:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87bne0lvbe.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, \@localhost
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 21, 2015 at 11:48:37AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> 5fa422c ("dmaengine: move drivers/of/dma.c -> drivers/dma/of-dma.c")
> moved OF base DMAEngine code to of-dma.c, then it based on CONFIG_DMA_OF.
> But, OF base DMAEngine API on of_dma.h still based on CONFIG_OF now.
> So, current kernel can't find OF base DMAEngine API if .config has CONFIG_OF,
> but not have CONFIG_DMA_OF. This patch tidyup it.

I did a quick build with arm config, but didn't see any failures. But still
am worried about random config and other builds may find.

So I think it would be safer to merge this patch after merge window so that
we have ample time to fix any issue

-- 
~Vinod

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/linux/of_dma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
> index 98ba752..36112cd 100644
> --- a/include/linux/of_dma.h
> +++ b/include/linux/of_dma.h
> @@ -34,7 +34,7 @@ struct of_dma_filter_info {
>  	dma_filter_fn	filter_fn;
>  };
>  
> -#ifdef CONFIG_OF
> +#ifdef CONFIG_DMA_OF
>  extern int of_dma_controller_register(struct device_node *np,
>  		struct dma_chan *(*of_dma_xlate)
>  		(struct of_phandle_args *, struct of_dma *),
> -- 
> 1.9.1
> 
