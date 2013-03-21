From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
Date: Thu, 21 Mar 2013 10:39:01 +0800
Message-ID: <20130321023858.GD6281@S2101-09.ap.freescale.net>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id D2574265E16
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 03:42:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Sebastien Guiriec <s-guiriec@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 15, 2013 at 11:36:39AM +0800, Shawn Guo wrote:
> The series adds a snd_dmaengine_generic_pcm_open() for users that
> adopt generic DMA binding and helplers.
> 
> Vinod,
> 
Ping?

Shawn

> AS per the request from Mark, I add the first patch to mark name
> parameter of dmaengine helpers as const, so that clients can mark
> const on their side.
> 
> We need to have these two patches on a topic branch, as I've heard
> a few people converting their ASoC driver needing the patches.  Can
> you ack the first patch, so that Mark can maintain them in a branch
> for anyone who needs it to pull?
> 
> Shawn Guo (2):
>   dmaengine: add const for name parameter
>   ASoC: dmaengine_pcm: add snd_dmaengine_generic_pcm_open()
> 
>  drivers/dma/dmaengine.c       |    2 +-
>  drivers/dma/of-dma.c          |    6 +++---
>  include/linux/dmaengine.h     |    7 ++++---
>  include/linux/of_dma.h        |    2 +-
>  include/sound/dmaengine_pcm.h |    2 ++
>  sound/soc/soc-dmaengine-pcm.c |   39 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 50 insertions(+), 8 deletions(-)
> 
> -- 
> 1.7.9.5
> 
> 
