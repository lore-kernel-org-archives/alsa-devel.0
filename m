From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: mcasp: don't override bclk divider
 if it was provided by the machine
Date: Wed, 16 Jul 2014 15:13:29 +0300
Message-ID: <53C66C69.3080301@ti.com>
References: <1405512281-8188-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 82A802654DD
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 14:13:32 +0200 (CEST)
In-Reply-To: <1405512281-8188-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/16/2014 03:04 PM, Daniel Mack wrote:
> If a machine driver provides an BCLK divider to the McASP driver, skip the
> automatic calculation.
> =

> This fixes machines on which the physical sample transport always works
> in 32 bits, even though not all of them are actually used.
> snd_soc_params_to_bclk() will fail to address such cases properly.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
> index 0518f27..dbeb4fd 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -64,6 +64,7 @@ struct davinci_mcasp {
>  	u8	num_serializer;
>  	u8	*serial_dir;
>  	u8	version;
> +	u8	bclk_div;
>  	u16	bclk_lrclk_ratio;
>  	int	streams;
>  =

> @@ -420,6 +421,7 @@ static int davinci_mcasp_set_clkdiv(struct snd_soc_da=
i *dai, int div_id, int div
>  			       ACLKXDIV(div - 1), ACLKXDIV_MASK);
>  		mcasp_mod_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG,
>  			       ACLKRDIV(div - 1), ACLKRDIV_MASK);
> +		mcasp->bclk_div =3D div;
>  		break;
>  =

>  	case 2:		/* BCLK/LRCLK ratio */
> @@ -722,8 +724,11 @@ static int davinci_mcasp_hw_params(struct snd_pcm_su=
bstream *substream,
>  	int period_size =3D params_period_size(params);
>  	int ret;
>  =

> -	/* If mcasp is BCLK master we need to set BCLK divider */
> -	if (mcasp->bclk_master) {
> +	/*
> +	 * If mcasp is BCLK master, and a BCLK divider was not provided by
> +	 * the machine driver, we need to calculate the ratio.
> +	 */
> +	if (mcasp->bclk_master && mcasp->bclk_div =3D=3D 0) {
>  		unsigned int bclk_freq =3D snd_soc_params_to_bclk(params);
>  		if (mcasp->sysclk_freq % bclk_freq !=3D 0) {
>  			dev_err(mcasp->dev, "Can't produce required BCLK\n");
> =



-- =

P=E9ter
