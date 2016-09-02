From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix spelling mistake "Transmition" ->
 "Transmission"
Date: Fri, 2 Sep 2016 10:21:43 -0700
Message-ID: <20160902172142.GA3180@Asurada-Nvidia>
References: <20160902140723.26593-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160902140723.26593-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2016 at 03:07:23PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistakes in dev_dbg messages
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_esai.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 26a90e1..e927955 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -77,19 +77,19 @@ static irqreturn_t esai_isr(int irq, void *devid)
>  	regmap_read(esai_priv->regmap, REG_ESAI_ESR, &esr);
>  
>  	if (esr & ESAI_ESR_TINIT_MASK)
> -		dev_dbg(&pdev->dev, "isr: Transmition Initialized\n");
> +		dev_dbg(&pdev->dev, "isr: Transmission Initialized\n");
>  
>  	if (esr & ESAI_ESR_RFF_MASK)
>  		dev_warn(&pdev->dev, "isr: Receiving overrun\n");
>  
>  	if (esr & ESAI_ESR_TFE_MASK)
> -		dev_warn(&pdev->dev, "isr: Transmition underrun\n");
> +		dev_warn(&pdev->dev, "isr: Transmission underrun\n");
>  
>  	if (esr & ESAI_ESR_TLS_MASK)
>  		dev_dbg(&pdev->dev, "isr: Just transmitted the last slot\n");
>  
>  	if (esr & ESAI_ESR_TDE_MASK)
> -		dev_dbg(&pdev->dev, "isr: Transmition data exception\n");
> +		dev_dbg(&pdev->dev, "isr: Transmission data exception\n");
>  
>  	if (esr & ESAI_ESR_TED_MASK)
>  		dev_dbg(&pdev->dev, "isr: Transmitting even slots\n");
> -- 
> 2.9.3
> 
