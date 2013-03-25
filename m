From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 13/14] ASoC: mxs: Embed the mxs_dma_data
 struct in the mxs_pcm_dma_params struct
Date: Mon, 25 Mar 2013 10:04:33 +0800
Message-ID: <20130325020431.GA30232@S2101-09.ap.freescale.net>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
 <1363957934-20059-14-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id A95232615DB
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 03:03:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1363957934-20059-14-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 22, 2013 at 02:12:13PM +0100, Lars-Peter Clausen wrote:
> Currently the mxs_dma_data struct, which gets passed to the dmaengine driver, is
> allocated in the pcm driver's open callback. The mxs_dma_data struct has exactly
> one field which is initialized from the the same field in the mxs_pcm_dma_params
> struct. The mxs_pcm_dma_params struct gets passed to the pcm driver from the dai
> driver. Instead of taking this indirection embed the mxs_dma_data struct
> directly in the mxs_pcm_dma_params struct. This allows us to simplify the pcm
> driver quite a bit, since we don't have to care about memory managing the
> mxs_dma_data struct anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Tested-by: Shawn Guo <shawn.guo@linaro.org>
