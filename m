From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] [v2] sound/soc/fsl/fsl_dma.c: add missing
	of_node_put
Date: Mon, 22 Aug 2011 21:05:38 +0100
Message-ID: <4E52B692.2030601@ti.com>
References: <1314022961-27513-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C34E24585
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 22:05:48 +0200 (CEST)
In-Reply-To: <1314022961-27513-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "julia@diku.dk" <julia@diku.dk>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On 22/08/11 15:22, Timur Tabi wrote:
> of_parse_phandle increments the reference count of np, so this should be
> decremented before trying the next possibility.
> 
> Since we don't actually use np, we can decrement the reference count
> immediately.
> 
> Reported-by: Julia Lawall <julia@diku.dk>
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Liam Girdwood <lrg@ti.com>

> ---
>  sound/soc/fsl/fsl_dma.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
> index 6680c0b..b300f4b 100644
> --- a/sound/soc/fsl/fsl_dma.c
> +++ b/sound/soc/fsl/fsl_dma.c
> @@ -877,10 +877,12 @@ static struct device_node *find_ssi_node(struct device_node *dma_channel_np)
>  		 * assume that device_node pointers are a valid comparison.
>  		 */
>  		np = of_parse_phandle(ssi_np, "fsl,playback-dma", 0);
> +		of_node_put(np);
>  		if (np == dma_channel_np)
>  			return ssi_np;
>  
>  		np = of_parse_phandle(ssi_np, "fsl,capture-dma", 0);
> +		of_node_put(np);
>  		if (np == dma_channel_np)
>  			return ssi_np;
>  	}
