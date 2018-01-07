From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl_ssi: Fix build error
Date: Sun, 7 Jan 2018 09:55:03 -0800
Message-ID: <20180107175503.GA5148@Asurada>
References: <1515344750-6159-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 93B22266FE0
 for <alsa-devel@alsa-project.org>; Sun,  7 Jan 2018 18:55:11 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id f14so1459416pga.10
 for <alsa-devel@alsa-project.org>; Sun, 07 Jan 2018 09:55:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1515344750-6159-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 07, 2018 at 09:05:50AM -0800, Guenter Roeck wrote:
> powerpc:mpc85xx_defconfig fails to build with the following errors.
> 
> sound/soc/fsl/fsl_dma.c: In function 'fsl_soc_dma_probe':
> sound/soc/fsl/fsl_dma.c:916:34: error: 'CCSR_SSI_STX0' undeclared
> sound/soc/fsl/fsl_dma.c:917:34: error: 'CCSR_SSI_SRX0' undeclared
> 
> Fixes: a818aa5f967b ("ASoC: fsl_ssi: Rename registers and fields macros")
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Cc: Timur Tabi <timur@tabi.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I would suggest to merge this patch into the offending patch to preserve
> bisectability.
> 
>  sound/soc/fsl/fsl_dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
> index 0c11f434a374..8c2981b70f64 100644
> --- a/sound/soc/fsl/fsl_dma.c
> +++ b/sound/soc/fsl/fsl_dma.c
> @@ -913,8 +913,8 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
>  	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
>  
>  	/* Store the SSI-specific information that we need */
> -	dma->ssi_stx_phys = res.start + CCSR_SSI_STX0;
> -	dma->ssi_srx_phys = res.start + CCSR_SSI_SRX0;
> +	dma->ssi_stx_phys = res.start + REG_SSI_STX0;
> +	dma->ssi_srx_phys = res.start + REG_SSI_SRX0;
>  
>  	iprop = of_get_property(ssi_np, "fsl,fifo-depth", NULL);
>  	if (iprop)
> -- 
> 2.7.4
> 
