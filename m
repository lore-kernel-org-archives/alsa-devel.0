From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/3 v2] ASoC: fsl_sai: Update is_slave_mode with correct
 value
Date: Sun, 21 Apr 2019 18:08:47 -0700
Message-ID: <20190422010846.GA8364@Asurada>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-2-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190421193853.10188-2-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 21, 2019 at 07:39:08PM +0000, Daniel Baluta wrote:
> is_slave_mode defaults to false because sai structure
> that contains it is kzalloc'ed.
> 
> Anyhow, if we decide to set the following configuration
> SAI slave -> SAI master, is_slave_mode will remain set on true
> although SAI being master it should be set to false.
> 
> Fix this by updating is_slave_mode for each call of
> fsl_sai_set_dai_fmt.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index b563004fb89f..d9df98975cf8 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -268,12 +268,14 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
>  	case SND_SOC_DAIFMT_CBS_CFS:
>  		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
>  		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
> +		sai->is_slave_mode = false;
>  		break;
>  	case SND_SOC_DAIFMT_CBM_CFM:
>  		sai->is_slave_mode = true;
>  		break;
>  	case SND_SOC_DAIFMT_CBS_CFM:
>  		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
> +		sai->is_slave_mode = false;
>  		break;
>  	case SND_SOC_DAIFMT_CBM_CFS:
>  		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
> -- 
> 2.17.1
> 
