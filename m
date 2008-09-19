From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Fix at32-pcm build breakage with PM
	enabled
Date: Fri, 19 Sep 2008 19:20:38 +0100
Message-ID: <20080919182036.GA16316@sirena.org.uk>
References: <1221843045-18093-1-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C2CDC24645
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Sep 2008 20:20:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221843045-18093-1-git-send-email-haavard.skinnemoen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 19, 2008 at 06:50:45PM +0200, Haavard Skinnemoen wrote:
> s/PDC_PTCR/ATMEL_PDC_PTCR/
> 
> Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Please submit all ALSA patches to alsa-devel (added to the CC).

>  sound/soc/at32/at32-pcm.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/at32/at32-pcm.c b/sound/soc/at32/at32-pcm.c
> index 435f1da..c83584f 100644
> --- a/sound/soc/at32/at32-pcm.c
> +++ b/sound/soc/at32/at32-pcm.c
> @@ -434,7 +434,8 @@ static int at32_pcm_suspend(struct platform_device *pdev,
>  	params = prtd->params;
>  
>  	/* Disable the PDC and save the PDC registers */
> -	ssc_writex(params->ssc->regs, PDC_PTCR, params->mask->pdc_disable);
> +	ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
> +		   params->mask->pdc_disable);
>  
>  	prtd->pdc_xpr_save = ssc_readx(params->ssc->regs, params->pdc->xpr);
>  	prtd->pdc_xcr_save = ssc_readx(params->ssc->regs, params->pdc->xcr);
> @@ -464,7 +465,7 @@ static int at32_pcm_resume(struct platform_device *pdev,
>  	ssc_writex(params->ssc->regs, params->pdc->xnpr, prtd->pdc_xnpr_save);
>  	ssc_writex(params->ssc->regs, params->pdc->xncr, prtd->pdc_xncr_save);
>  
> -	ssc_writex(params->ssc->regs, PDC_PTCR, params->mask->pdc_enable);
> +	ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR, params->mask->pdc_enable);
>  	return 0;
>  }
>  #else /* CONFIG_PM */
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
