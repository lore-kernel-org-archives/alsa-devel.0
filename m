From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 09/12] ASoC: dmaengine_pcm: support use of
 generic DMA helper
Date: Mon, 4 Mar 2013 16:37:28 +0800
Message-ID: <20130304083726.GA30198@S2101-09.ap.freescale.net>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-10-git-send-email-shawn.guo@linaro.org>
 <201302272102.40811.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 67B85264F53
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 09:37:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201302272102.40811.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Huang Shijie <b32955@freescale.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 27, 2013 at 09:02:40PM +0000, Arnd Bergmann wrote:
> On Wednesday 27 February 2013, Shawn Guo wrote:
> > With generic DMA device tree binding and helper function
> > dma_request_slave_channel() in place, dmaengine_pcm should support
> > that in requesting DMA channel for users that support generic DMA
> > device tree binding.
> > 
> > Instead of inventing a new API, it defines the parameters needed by
> > dma_request_slave_channel() into struct snd_dma_channel_params,
> > interprets filter_data into snd_dma_channel_params, and calls the
> > helper in case that dmaengine_pcm users pass in a NULL filter_fn.
> > 
> > Then, dmaengine_pcm users can call snd_dmaengine_pcm_open() with NULL
> > filter_fn and snd_dma_channel_params being filter_data to direct the
> > API to request DMA channel using generic DMA helper.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: alsa-devel@alsa-project.org
> 
> I would actually prefer having a new API in the soc-dmaengine-pcm
> module, like
> 
> static int dmaengine_pcm_request_slave_channel(struct dmaengine_pcm_runtime_data *prtd,
> 						struct device *dev, const char *id);
> 
> For sound drivers that are fully converted to using DT, it would be
> a more natural interface to use IMHO.

Just to be clear, if we choose to have a new API, it's not the above
one but something like 

int snd_dmaengine_generic_pcm_open(struct snd_pcm_substream *substream,
                                   struct device *dev, const char *id)

as snd_dmaengine_pcm_open() is the interface to soc-dmaengine-pcm
clients, not dmaengine_pcm_request_channel().

Shawn
