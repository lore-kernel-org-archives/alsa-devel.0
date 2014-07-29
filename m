From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [RFC PATCH] ASoC: fsl-ssi: Add support for CBM_CFS
	16/24 bit
Date: Tue, 29 Jul 2014 08:18:14 +0200
Message-ID: <20140729061814.GD13842@pengutronix.de>
References: <1406551598-14740-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7428130998034002601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 9E55A265206
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 08:18:19 +0200 (CEST)
In-Reply-To: <1406551598-14740-1-git-send-email-michael@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7428130998034002601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 28, 2014 at 02:46:38PM +0200, Michael Trimarchi wrote:
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

A commit description what you are doing in this patch and how your setup
looks like would be good.

> ---
>  sound/soc/fsl/fsl_ssi.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 9bfef55..743e50d 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -724,10 +724,19 @@ static int fsl_ssi_hw_params(struct snd_pcm_substre=
am *substream,
>  		regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_WL_MASK,
>  				wl);
> =20
> -	if (!fsl_ssi_is_ac97(ssi_private))
> +	if (!fsl_ssi_is_ac97(ssi_private)) {
> +		u8 i2smode;
> +
> +		if (ssi_private->i2s_mode =3D=3D (CCSR_SSI_SCR_I2S_MODE_NORMAL |
> +		    CCSR_SSI_SCR_NET) && sample_size >=3D 24)

This condition seems a bit fragile using the i2s_mode variable.

I don't know about this bitclock master mode, why is this condition
necessary, what is the difference with sample_size >=3D 24?

Regards,

Markus

> +			i2smode =3D CCSR_SSI_SCR_I2S_MODE_MASTER;
> +		else
> +			i2smode =3D ssi_private->i2s_mode;
> +
>  		regmap_update_bits(regs, CCSR_SSI_SCR,
>  				CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
> -				channels =3D=3D 1 ? 0 : ssi_private->i2s_mode);
> +				channels =3D=3D 1 ? 0 : i2smode);
> +	}
> =20
>  	return 0;
>  }
> @@ -789,6 +798,15 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_priva=
te *ssi_private,
>  					CCSR_SSI_SxCCR_DC_MASK,
>  					CCSR_SSI_SxCCR_DC(2));
>  			break;
> +		case SND_SOC_DAIFMT_CBM_CFS:
> +			ssi_private->i2s_mode |=3D CCSR_SSI_SCR_I2S_MODE_NORMAL;
> +			regmap_update_bits(regs, CCSR_SSI_STCCR,
> +					CCSR_SSI_SxCCR_DC_MASK,
> +					CCSR_SSI_SxCCR_DC(2));
> +			regmap_update_bits(regs, CCSR_SSI_SRCCR,
> +					CCSR_SSI_SxCCR_DC_MASK,
> +					CCSR_SSI_SxCCR_DC(2));
> +			break;
>  		case SND_SOC_DAIFMT_CBM_CFM:
>  			ssi_private->i2s_mode |=3D CCSR_SSI_SCR_I2S_MODE_SLAVE;
>  			break;
> @@ -853,6 +871,11 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_priva=
te *ssi_private,
>  	case SND_SOC_DAIFMT_CBM_CFM:
>  		scr &=3D ~CCSR_SSI_SCR_SYS_CLK_EN;
>  		break;
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +		strcr &=3D ~CCSR_SSI_STCR_TXDIR;
> +		strcr |=3D CCSR_SSI_STCR_TFDIR;
> +		scr &=3D ~CCSR_SSI_SCR_SYS_CLK_EN;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> --=20
> 1.8.1.2
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT1zymAAoJEEpcgKtcEGQQypUP/3F0EOv4BK8imjG53qc+QAPe
+RDKZAyVuT8GH/FWmQ/aBEkdZ9Uk4+3KRUORlBrpDBPHm4ivbZz+Ej1xmxOGsLEP
erytAFYyS8V2IhoknPPcC2+zUHyWmULEvxhwPN+Xai0fdv3YYNF4PLPaUdZaaWtJ
hv2cdnolIl5KMXr+gRktBy7XGi/k7J1PippO8ENAfzKWd5jgP4GXdPBe83ebeb1B
Rpb7qq79ZrniE3WDQLExwvxZs1TsUk5kVW8ZG6P9nCTPTABOeEEXkvXItn/X21f7
fsFWpNuoZota0Y7rYe2wCputs2A5cUnr0GcBgFxGEqH0o4f7ndnBd5O9EhIDtIg5
NGwnHLewAswDuLxfEH0emIYgXXQc2P8LINykfkTaalWr75vUtLm2Eaqkviw1twcI
cwlBeO/snq3ID36uHjMMKYS0hkEB1EsyzrhjT75dUhknMBOUQM/FUek7ppgyd3wg
K1y7KhU0DydmOnyU1JxM6REThwoxRsdl3/TaFrOgp2VT3EgkyPq+rx8wbqtRAOTj
tzv3JkIO2dFhaSqTIbU4EF5VWrUJL5nsqKBs4LW6vHkNVm+AOzokE9uIUjLczE3K
TcXTWuz6McMVjlTxh/tNX+/zvmQ2ZYr67qZozJcmrVs5kf9EwOf5ygoLf6xI4pNZ
9TF3wIzybbzUSYi1fTf3
=Dv+K
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--

--===============7428130998034002601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7428130998034002601==--
