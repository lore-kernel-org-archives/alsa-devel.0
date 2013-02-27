From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/12] ASoC: dmaengine_pcm: support use of
	generic DMA helper
Date: Wed, 27 Feb 2013 21:02:40 +0000
Message-ID: <201302272102.40811.arnd@arndb.de>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-10-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 21A4C262606
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2013 22:02:53 +0100 (CET)
In-Reply-To: <1361978748-25281-10-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Huang Shijie <b32955@freescale.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 27 February 2013, Shawn Guo wrote:
> With generic DMA device tree binding and helper function
> dma_request_slave_channel() in place, dmaengine_pcm should support
> that in requesting DMA channel for users that support generic DMA
> device tree binding.
> 
> Instead of inventing a new API, it defines the parameters needed by
> dma_request_slave_channel() into struct snd_dma_channel_params,
> interprets filter_data into snd_dma_channel_params, and calls the
> helper in case that dmaengine_pcm users pass in a NULL filter_fn.
> 
> Then, dmaengine_pcm users can call snd_dmaengine_pcm_open() with NULL
> filter_fn and snd_dma_channel_params being filter_data to direct the
> API to request DMA channel using generic DMA helper.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: alsa-devel@alsa-project.org

I would actually prefer having a new API in the soc-dmaengine-pcm
module, like

static int dmaengine_pcm_request_slave_channel(struct dmaengine_pcm_runtime_data *prtd,
						struct device *dev, const char *id);

For sound drivers that are fully converted to using DT, it would be
a more natural interface to use IMHO.

Your patch looks technically correct though, so it's up to Mark to decide
what he prefers.

	Arnd
