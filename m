From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: remove duplicated flag
 setting in fsl_ssi_setup_reg_vals()
Date: Mon, 20 Nov 2017 15:16:09 -0800
Message-ID: <20171120231608.GA14136@Asurada-Nvidia>
References: <9c78bea8-c264-0094-c2e9-950a9f7797e6@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9c78bea8-c264-0094-c2e9-950a9f7797e6@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 20, 2017 at 11:12:01PM +0100, Maciej S. Szmigiero wrote:
> We don't need to set CCSR_SSI_SIER_RFF0_EN / CCSR_SSI_SIER_TFE0_EN bits
> in reg->rx.sier / reg->tx.sier variables in a non-AC'97 mode considering we
> had just initialized these variables to these very values unconditionally a
> few lines earlier.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_ssi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index f2f51e06e22c..48bb850a34d9 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -597,9 +597,7 @@ static void fsl_ssi_setup_reg_vals(struct fsl_ssi_private *ssi_private)
>  
>  	if (!fsl_ssi_is_ac97(ssi_private)) {
>  		reg->rx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE;
> -		reg->rx.sier |= CCSR_SSI_SIER_RFF0_EN;
>  		reg->tx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE;
> -		reg->tx.sier |= CCSR_SSI_SIER_TFE0_EN;
>  	}
>  
>  	if (ssi_private->use_dma) {
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
