From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: set up user bits for
	S/PDIF mode
Date: Thu, 27 Mar 2014 10:16:35 +0200
Message-ID: <5333DE63.1010205@ti.com>
References: <1395846273-26025-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 646EE26524F
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 09:16:40 +0100 (CET)
In-Reply-To: <1395846273-26025-1-git-send-email-zonque@gmail.com>
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

On 03/26/2014 05:04 PM, Daniel Mack wrote:
> In DIT (S/PDIF) mode, program the transmitted user bits to reflect the
> configured sample rate, along with some other details.
> =

> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c | 55 +++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
> index 712a7cd..ec0463a 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_device.h>
>  =

> +#include <sound/asoundef.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -566,8 +567,11 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *=
mcasp, int stream)
>  }
>  =

>  /* S/PDIF */
> -static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp)
> +static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
> +			      unsigned int rate)
>  {
> +	u32 val =3D 0;
> +
>  	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
>  	   and LSB first */
>  	mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, TXROT(6) | TXSSZ(15));
> @@ -589,6 +593,53 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *=
mcasp)
>  	/* Enable the DIT */
>  	mcasp_set_bits(mcasp, DAVINCI_MCASP_TXDITCTL_REG, DITEN);
>  =

> +	/* Set S/PDIF channel status bits */
> +	mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRA_REG + 0,
> +		      IEC958_AES0_CON_NOT_COPYRIGHT);

I think it would be safer to set the channel status bits like:
u32 val =3D 0;
u8 *bytes =3D (u8*) &val;

byte[0] |=3D IEC958_AES0_CON_NOT_COPYRIGHT;
byte[1] |=3D IEC958_AES1_CON_PCM_CODER;

> +	mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRB_REG + 0,
> +		      IEC958_AES0_CON_NOT_COPYRIGHT);
> +
> +	mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRA_REG + 1,
> +		      IEC958_AES1_CON_PCM_CODER);
> +	mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRB_REG + 1,
> +		      IEC958_AES1_CON_PCM_CODER);
> +
> +	switch (rate) {
> +	case 22050:
> +		val |=3D IEC958_AES3_CON_FS_22050;

		val8[3] |=3D IEC958_AES3_CON_FS_22050;

> +		break;
> +	case 24000:
> +		val |=3D IEC958_AES3_CON_FS_24000;

		val8[3] |=3D IEC958_AES3_CON_FS_24000;

> +		break;
> +	case 32000:
> +		val |=3D IEC958_AES3_CON_FS_32000;
> +		break;
> +	case 44100:
> +		val |=3D IEC958_AES3_CON_FS_44100;
> +		break;
> +	case 48000:
> +		val |=3D IEC958_AES3_CON_FS_48000;
> +		break;
> +	case 88200:
> +		val |=3D IEC958_AES3_CON_FS_88200;
> +		break;
> +	case 96000:
> +		val |=3D IEC958_AES3_CON_FS_96000;
> +		break;
> +	case 176400:
> +		val |=3D IEC958_AES3_CON_FS_176400;
> +		break;
> +	case 192000:
> +		val |=3D IEC958_AES3_CON_FS_192000;
> +		break;
> +	default:
> +		printk(KERN_WARNING "unsupported sampling rate: %d\n", rate);
> +		return -EINVAL;
> +	}
> +
> +	mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRA_REG + 3, val);
> +	mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRB_REG + 3, val);

mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRA_REG, val);
mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRB_REG, val);

Since these registers are 32 bits and the mcasp_set_reg() uses __raw_writel=
()
at the end.
Also in this way you write only once to the registers.

> +
>  	return 0;
>  }
>  =

> @@ -621,7 +672,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_sub=
stream *substream,
>  		fifo_level =3D mcasp->rxnumevt * active_serializers;
>  =

>  	if (mcasp->op_mode =3D=3D DAVINCI_MCASP_DIT_MODE)
> -		ret =3D mcasp_dit_hw_param(mcasp);
> +		ret =3D mcasp_dit_hw_param(mcasp, params_rate(params));
>  	else
>  		ret =3D mcasp_i2s_hw_param(mcasp, substream->stream);
>  =

> =



-- =

P=E9ter
