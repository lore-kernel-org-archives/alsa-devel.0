From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Remove unneeded init of static variable
Date: Mon, 27 Feb 2017 10:42:33 -0800
Message-ID: <20170227184233.GA22071@Asurada-Nvidia>
References: <20170225104726.15936-1-alin.grig93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170225104726.15936-1-alin.grig93@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alin Grigorean <alin.grig93@gmail.com>
Cc: timur@tabi.org, Xiubo.Lee@gmail.com, perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 25, 2017 at 12:47:26PM +0200, Alin Grigorean wrote:
> This was reported by checkpatch.pl
> 
> Signed-off-by: Alin Grigorean <alin.grig93@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-pcm-fiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
> index dac6688540dc..92410f7ca1fa 100644
> --- a/sound/soc/fsl/imx-pcm-fiq.c
> +++ b/sound/soc/fsl/imx-pcm-fiq.c
> @@ -282,7 +282,7 @@ static int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  	return 0;
>  }
>  
> -static int ssi_irq = 0;
> +static int ssi_irq;
>  
>  static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
>  {
> -- 
> 2.11.1
> 
