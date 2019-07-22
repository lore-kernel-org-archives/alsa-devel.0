From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 10/10] ASoC: fsl_sai: Add support for imx7ulp/imx8mq
Date: Mon, 22 Jul 2019 15:04:07 +0200
Message-ID: <1563800647.2311.13.camel@pengutronix.de>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
         <20190722124833.28757-11-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722124833.28757-11-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>, broonie@kernel.org
Cc: festevam@gmail.com, perex@perex.cz, tiwai@suse.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

Am Montag, den 22.07.2019, 15:48 +0300 schrieb Daniel Baluta:
> SAI module on imx7ulp/imx8m features 2 new registers (VERID and PARAM)
> at the beginning of register address space.
> 
> On imx7ulp FIFOs can held up to 16 x 32 bit samples.
> On imx8mq FIFOs can held up to 128 x 32 bit samples.
> 
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index f2441b84877e..b05837465b5a 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1065,10 +1065,24 @@ static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
> >  	.reg_offset = 0,
>  };
>  
> +static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
> > +	.use_imx_pcm = true,
> > +	.fifo_depth = 16,
> > +	.reg_offset = 8,
> +};
> +
> +static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
> > +	.use_imx_pcm = true,
> > +	.fifo_depth = 128,
> > +	.reg_offset = 8,
> +};
> +
>  static const struct of_device_id fsl_sai_ids[] = {
> >  	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
> >  	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
> >  	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
> > +	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
> > +	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
> > 
Those two new compatibles need to be documented in the DT bindings.

Regards,
Lucas
