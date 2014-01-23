From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH Resend 2/8] ASoC: simple-card: fix
 __asoc_simple_card_dai_init
Date: Thu, 23 Jan 2014 08:11:51 +0100
Message-ID: <20140123081151.35837d3b@armhf>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
	<1390453370-29194-3-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390453370-29194-3-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 23 Jan 2014 13:02:44 +0800
Xiubo Li <Li.Xiubo@freescale.com> wrote:

> If the CPU/CODEC DAI set_sysclk() is not support, the -ENOTSUPP will =
returnd.
> Here do the check like set_fmt().
>=20
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>=20
>=20
>=20
> The VF610 Tower and VF610 LS1 platforms' ESAI and SPDIF will depend o=
n this
> patch too.
>=20
>=20
>=20
>=20
>  sound/soc/generic/simple-card.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simp=
le-card.c
> index 6443c87..3b8c9a2 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -31,16 +31,21 @@ static int __asoc_simple_card_dai_init(struct snd=
_soc_dai *dai,
> =20
>  	daifmt |=3D set->fmt;
> =20
> -	if (daifmt)
> +	if (daifmt) {
>  		ret =3D snd_soc_dai_set_fmt(dai, daifmt);
> -
> -	if (ret =3D=3D -ENOTSUPP) {
> -		dev_dbg(dai->dev, "ASoC: set_fmt is not supported\n");
> -		ret =3D 0;
> +		if (ret && ret !=3D -ENOTSUPP) {
> +			dev_err(dai->dev, "simple-card: set_fmt error\n");
> +			return ret;
> +		}
>  	}
> =20
> -	if (!ret && set->sysclk)
> +	if (set->sysclk) {
>  		ret =3D snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);
> +		if (ret && ret !=3D -ENOTSUPP) {
> +			dev_err(dai->dev, "simple-card: set_sysclk error\n");
> +			return ret;
> +		}
> +	}
> =20
>  	return ret;

Sorry: you must return 0 here

>  }

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
