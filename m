From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix DAI hardware signal
	inversions
Date: Thu, 17 Sep 2015 10:59:27 -0700
Message-ID: <20150917175927.GB2544@Asurada-CZ80>
References: <1442504814-16965-1-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B96C3261A80
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 19:59:30 +0200 (CEST)
Received: by padhy16 with SMTP id hy16so25793202pad.1
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 10:59:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442504814-16965-1-git-send-email-benoit@wsystem.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit@wsystem.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2015 at 05:46:54PM +0200, Beno=EEt Th=E9baudeau wrote:
> SND_SOC_DAIFMT_{IB|NB}_{IF|NF} are defined as inverting or not BCLK or
> FRM relatively to what is standard for the specified DAI hardware audio
> format. Consequently, the absolute polarities of these signals cannot be
> derived only from these settings as this driver did. The format has to
> be taken into account too.
> =

> This fixes inverted left/right channels in I=B2S mode.
> =

> Signed-off-by: Beno=EEt Th=E9baudeau <benoit@wsystem.com>

Looks like the same configurations of fsl_ssi, so it should be fine:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-ssi.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> =

> diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
> index 48b2d24..b95132e 100644
> --- a/sound/soc/fsl/imx-ssi.c
> +++ b/sound/soc/fsl/imx-ssi.c
> @@ -95,7 +95,8 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_=
dai, unsigned int fmt)
>  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:
>  		/* data on rising edge of bclk, frame low 1clk before data */
> -		strcr |=3D SSI_STCR_TFSI | SSI_STCR_TEFS | SSI_STCR_TXBIT0;
> +		strcr |=3D SSI_STCR_TXBIT0 | SSI_STCR_TSCKP | SSI_STCR_TFSI |
> +			SSI_STCR_TEFS;
>  		scr |=3D SSI_SCR_NET;
>  		if (ssi->flags & IMX_SSI_USE_I2S_SLAVE) {
>  			scr &=3D ~SSI_I2S_MODE_MASK;
> @@ -104,33 +105,31 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *=
cpu_dai, unsigned int fmt)
>  		break;
>  	case SND_SOC_DAIFMT_LEFT_J:
>  		/* data on rising edge of bclk, frame high with data */
> -		strcr |=3D SSI_STCR_TXBIT0;
> +		strcr |=3D SSI_STCR_TXBIT0 | SSI_STCR_TSCKP;
>  		break;
>  	case SND_SOC_DAIFMT_DSP_B:
>  		/* data on rising edge of bclk, frame high with data */
> -		strcr |=3D SSI_STCR_TFSL | SSI_STCR_TXBIT0;
> +		strcr |=3D SSI_STCR_TXBIT0 | SSI_STCR_TSCKP | SSI_STCR_TFSL;
>  		break;
>  	case SND_SOC_DAIFMT_DSP_A:
>  		/* data on rising edge of bclk, frame high 1clk before data */
> -		strcr |=3D SSI_STCR_TFSL | SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
> +		strcr |=3D SSI_STCR_TXBIT0 | SSI_STCR_TSCKP | SSI_STCR_TFSL |
> +			SSI_STCR_TEFS;
>  		break;
>  	}
>  =

>  	/* DAI clock inversion */
>  	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
>  	case SND_SOC_DAIFMT_IB_IF:
> -		strcr |=3D SSI_STCR_TFSI;
> -		strcr &=3D ~SSI_STCR_TSCKP;
> +		strcr ^=3D SSI_STCR_TSCKP | SSI_STCR_TFSI;
>  		break;
>  	case SND_SOC_DAIFMT_IB_NF:
> -		strcr &=3D ~(SSI_STCR_TSCKP | SSI_STCR_TFSI);
> +		strcr ^=3D SSI_STCR_TSCKP;
>  		break;
>  	case SND_SOC_DAIFMT_NB_IF:
> -		strcr |=3D SSI_STCR_TFSI | SSI_STCR_TSCKP;
> +		strcr ^=3D SSI_STCR_TFSI;
>  		break;
>  	case SND_SOC_DAIFMT_NB_NF:
> -		strcr &=3D ~SSI_STCR_TFSI;
> -		strcr |=3D SSI_STCR_TSCKP;
>  		break;
>  	}
>  =

> -- =

> 2.1.4
> =
