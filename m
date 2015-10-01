From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH 1/2] dmaengine: OF DMAEngine API based on
 CONFIG_DMA_OF instead of CONFIG_OF
Date: Thu, 1 Oct 2015 07:40:48 +0530
Message-ID: <20151001021048.GD11757@localhost>
References: <87wpwpurzk.wl%kuninori.morimoto.gx@renesas.com>
 <20150821082636.GK13546@localhost>
 <87d1yglvcy.wl%kuninori.morimoto.gx@renesas.com>
 <87bne0lvbe.wl%kuninori.morimoto.gx@renesas.com>
 <20150824091838.GH13546@localhost>
 <87si786xc6.wl%kuninori.morimoto.gx@renesas.com>
 <87zj0ulm4z.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zj0ulm4z.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 10, 2015 at 08:26:11AM +0000, Kuninori Morimoto wrote:
> Hi Vinod
> 
> > > > 5fa422c ("dmaengine: move drivers/of/dma.c -> drivers/dma/of-dma.c")
> > > > moved OF base DMAEngine code to of-dma.c, then it based on CONFIG_DMA_OF.
> > > > But, OF base DMAEngine API on of_dma.h still based on CONFIG_OF now.
> > > > So, current kernel can't find OF base DMAEngine API if .config has CONFIG_OF,
> > > > but not have CONFIG_DMA_OF. This patch tidyup it.
> > > 
> > > I did a quick build with arm config, but didn't see any failures. But still
> > > am worried about random config and other builds may find.
> > > 
> > > So I think it would be safer to merge this patch after merge window so that
> > > we have ample time to fix any issue
> 
> Which branch can I find this patch ?

Sorry I missed to do this after merge window. Applied now

-- 
~Vinod
