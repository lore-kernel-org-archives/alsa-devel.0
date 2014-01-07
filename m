From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: mxs: Remove
	SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag
Date: Tue, 7 Jan 2014 19:36:18 +0800
Message-ID: <20140107113616.GF12346@S2101-09.ap.freescale.net>
References: <1389025162-5601-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 04F29261723
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 12:35:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1389025162-5601-1-git-send-email-lars@metafoo.de>
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
Cc: Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 06, 2014 at 05:19:22PM +0100, Lars-Peter Clausen wrote:
> Since commit 7b11304 ("dma: mxs-dma: Report correct residue for cyclic DMA")
> the mxs dmaengine driver has support for residue reporting. So there is no need
> to specify the SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag anymore. This allows a
> finer grained resolution for the PCM pointer as well as avoids the race
> condition that can occur with the period counting that is used when the
> dmaengine driver does not support residue reporting.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> I don't have the hardware, so only compiled tested. But I assume that residue
> reporting was added to the driver for exactly this.
> ---

Tested-by: Shawn Guo <shawn.guo@linaro.org>
