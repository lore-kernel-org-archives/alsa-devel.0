From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH] ASoC: simple-card: fix one bug to writing
 to the platform data
Date: Fri, 10 Jan 2014 08:17:29 +0100
Message-ID: <20140110081729.035ce46f@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: broonie@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Xiubo Li wrote:

> It's a bug that writing to the platform data directly, for it should
> be constant. So just copy it before writing.
>=20
> Signed-off-by: Xiubo Li <Li.Xiubo at freescale.com>
> ---
>  sound/soc/generic/simple-card.c | 40 +++++++++++++++++++++----------=
---------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>=20
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simp=
le-card.c
> index 406e4ea..5b65324 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
	[snip]
> @@ -204,36 +205,37 @@ static int asoc_simple_card_probe(struct platfo=
rm_device *pdev)
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct device_node *of_cpu, *of_codec, *of_platform;
>  	struct device *dev =3D &pdev->dev;
> +	int ret;
> =20
>  	cinfo		=3D NULL;
>  	of_cpu		=3D NULL;
>  	of_codec	=3D NULL;
>  	of_platform	=3D NULL;
> +
> +	cinfo =3D devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
> +	if (!cinfo)
> +		return -ENOMEM;
> +
>  	if (np && of_device_is_available(np)) {
> -		cinfo =3D devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
> -		if (cinfo) {
> -			int ret;
> -			cinfo->snd_card.dev =3D &pdev->dev;
> -			ret =3D asoc_simple_card_parse_of(np, cinfo, dev,
> -							&of_cpu,
> -							&of_codec,
> -							&of_platform);
> -			if (ret < 0) {
> -				if (ret !=3D -EPROBE_DEFER)
> -					dev_err(dev, "parse error %d\n", ret);
> -				return ret;
> -			}
> -		} else {
> -			return -ENOMEM;
> +		cinfo->snd_card.dev =3D dev;
> +
> +		ret =3D asoc_simple_card_parse_of(np, cinfo, dev,
> +						&of_cpu,
> +						&of_codec,
> +						&of_platform);
> +		if (ret < 0) {
> +			if (ret !=3D -EPROBE_DEFER)
> +				dev_err(dev, "parse error %d\n", ret);
> +			return ret;
>  		}
>  	} else {
> -		cinfo =3D pdev->dev.platform_data;
> -		if (!cinfo) {
> +		if (!pdev->dev.platform_data) {
>  			dev_err(dev, "no info for asoc-simple-card\n");
>  			return -EINVAL;
>  		}
> =20
> -		cinfo->snd_card.dev =3D &pdev->dev;
> +		memcpy(cinfo, pdev->dev.platform_data, sizeof(cinfo));
> +		cinfo->snd_card.dev =3D dev;
>  	}
> =20
>  	if (!cinfo->name	||

If the original cinfo is not used anymore, the use of its structure to
handle the card information is not a good idea:

- almost all cinfo information are in the struct snd_soc_card,

- this cinfo structure cannot be extended to handle many DAI links,

- it contains simple-card information which are of no use for the
  platform caller.

So, I'd rather have seen:

- the removal of 'snd_link' and 'snd_card' from the platform interface
  (struct asoc_simple_card_info),

- the definition of a local struct simple_card_data containing the
  struct snd_soc_card and a pointer to an array of fmt/sysclk values
  (one per DAI link).

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
