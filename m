From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCHv2 2/2] ASoC: simple-card: Fix bug of wrong decrement DT
 node's refcount
Date: Mon, 1 Sep 2014 08:54:25 +0200
Message-ID: <20140901085425.6553dac5@armhf>
References: <1409535327-11449-1-git-send-email-Li.Xiubo@freescale.com>
	<1409535327-11449-3-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409535327-11449-3-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Sep 2014 09:35:27 +0800
Xiubo Li <Li.Xiubo@freescale.com> wrote:

> DAI links's cpu_of_node's and codec_of_node's refcounts shouldn't
> be decremented immediately at the end of the probe() fucntion.
> Because we will still use them before the audio card is removed.

Right, but your patch seems a bit complicated. See below.

>=20
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/generic/simple-card.c | 52 ++++++++++++++++++++++---------=
----------
>  1 file changed, 28 insertions(+), 24 deletions(-)
>=20
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simp=
le-card.c
> index 9e170fe..08c5d7d 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -307,6 +307,22 @@ dai_link_of_err:
>  	return ret;
>  }
> =20
> +static inline void
> +asoc_simple_card_unref(const struct snd_soc_dai_link *dai_link,
> +		       int num_links)
> +{
> +	struct device_node *np;
> +
> +	while (num_links--) {
> +		np =3D dai_link[num_links].cpu_of_node;
> +		if (np)
> +			of_node_put(np);
> +		np =3D dai_link[num_links].codec_of_node;
> +		if (np)
> +			of_node_put(np);
> +	}
> +}
> +
>  static int asoc_simple_card_parse_of(struct device_node *node,
>  				     struct simple_card_data *priv,
>  				     struct device *dev,
> @@ -355,6 +371,7 @@ static int asoc_simple_card_parse_of(struct devic=
e_node *node,
>  							   dai_props + i,
>  							   false);
>  			if (ret < 0) {
> +				asoc_simple_card_unref(dai_link, i + 1);
>  				of_node_put(np);
>  				return ret;
>  			}
> @@ -374,27 +391,6 @@ static int asoc_simple_card_parse_of(struct devi=
ce_node *node,
>  	return 0;
>  }
> =20
> -/* update the reference count of the devices nodes at end of probe *=
/
> -static int asoc_simple_card_unref(struct platform_device *pdev)
> -{
> -	struct snd_soc_card *card =3D platform_get_drvdata(pdev);
> -	struct snd_soc_dai_link *dai_link;
> -	struct device_node *np;
> -	int num_links;
> -
> -	for (num_links =3D 0, dai_link =3D card->dai_link;
> -	     num_links < card->num_links;
> -	     num_links++, dai_link++) {
> -		np =3D (struct device_node *) dai_link->cpu_of_node;
> -		if (np)
> -			of_node_put(np);
> -		np =3D (struct device_node *) dai_link->codec_of_node;
> -		if (np)
> -			of_node_put(np);
> -	}
> -	return 0;
> -}
> -
>  static int asoc_simple_card_probe(struct platform_device *pdev)
>  {
>  	struct simple_card_data *priv;
> @@ -441,7 +437,7 @@ static int asoc_simple_card_probe(struct platform=
_device *pdev)
>  		if (ret < 0) {
>  			if (ret !=3D -EPROBE_DEFER)
>  				dev_err(dev, "parse error %d\n", ret);
> -			goto err;
> +			return ret;
>  		}
> =20
>  	} else {
> @@ -483,11 +479,18 @@ static int asoc_simple_card_probe(struct platfo=
rm_device *pdev)
> =20
>  	ret =3D devm_snd_soc_register_card(&pdev->dev, &priv->snd_card);
> =20
> -err:
> -	asoc_simple_card_unref(pdev);
>  	return ret;
>  }

The main problem is there: don't unref the nodes is no error.
Why not simply:
=20
 	ret =3D devm_snd_soc_register_card(&pdev->dev, &priv->snd_card);
+	if (ret >=3D 0)
+		return ret;		/* success */
=20
 err:
	asoc_simple_card_unref(pdev);
 	return ret;
 }

? Then, the above stuff is not needed.

> +static int asoc_simple_card_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card =3D platform_get_drvdata(pdev);
> +
> +	asoc_simple_card_unref(card->dai_link, card->num_links);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id asoc_simple_of_match[] =3D {
>  	{ .compatible =3D "simple-audio-card", },
>  	{},
> @@ -501,6 +504,7 @@ static struct platform_driver asoc_simple_card =3D=
 {
>  		.of_match_table =3D asoc_simple_of_match,
>  	},
>  	.probe =3D asoc_simple_card_probe,
> +	.remove =3D asoc_simple_card_remove,
>  };
> =20
>  module_platform_driver(asoc_simple_card);

OK.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
