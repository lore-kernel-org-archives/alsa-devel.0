From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
Date: Wed, 6 Mar 2013 13:11:32 +0800
Message-ID: <20130306051131.GB1828@S2100-06.ap.freescale.net>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
 <201303060028.18625.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 by alsa0.perex.cz (Postfix) with ESMTP id A9212265311
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 05:41:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201303060028.18625.marex@denx.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Huang Shijie <b32955@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 06, 2013 at 12:28:18AM +0100, Marek Vasut wrote:
> Hi Shawn,
> 
> > With generic DMA device tree binding and helper function
> > dma_request_slave_channel() in place, dmaengine_pcm should support
> > that in requesting DMA channel for users that support generic DMA
> > device tree binding.
> > 
> > Add a new API snd_dmaengine_generic_pcm_open() as the variant of
> > snd_dmaengine_pcm_open().  It takes DMA client struct device pointer
> > and slave channel name as arguments and calls generic DMA helper
> > dma_request_slave_channel() to request DMA channel from dmaengine.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: alsa-devel@alsa-project.org
> > ---
> > Changes since v2:
> >  - Drop 'const' from argument 'name' to fix the warning below.
> > 
> [...]
> 
> v3 changelog missing ;-) What did you adjust here please?

The "Changes since v2" means v3 changelog.

Shawn
