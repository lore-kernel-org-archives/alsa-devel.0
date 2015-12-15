From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] ASoC: Atmel: ClassD: unregister codec when error occurs
Date: Tue, 15 Dec 2015 10:11:27 +0100
Message-ID: <566FD93F.60901@atmel.com>
References: <1449803257-27255-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449803257-27255-1-git-send-email-songjun.wu@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@atmel.com>, broonie@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Le 11/12/2015 04:07, Songjun Wu a =E9crit :
> Add code to unregister codec in probe function,
> when the error occurs after the codec is registered.
>=20
> Signed-off-by: Songjun Wu <songjun.wu@atmel.com>

Seems okay:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks,


> ---
>=20
>  sound/soc/atmel/atmel-classd.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-c=
lassd.c
> index dca6141..6107de9 100644
> --- a/sound/soc/atmel/atmel-classd.c
> +++ b/sound/soc/atmel/atmel-classd.c
> @@ -640,8 +640,10 @@ static int atmel_classd_probe(struct platform_de=
vice *pdev)
> =20
>  	/* register sound card */
>  	card =3D devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
> -	if (!card)
> -		return -ENOMEM;
> +	if (!card) {
> +		ret =3D -ENOMEM;
> +		goto unregister_codec;
> +	}
> =20
>  	snd_soc_card_set_drvdata(card, dd);
>  	platform_set_drvdata(pdev, card);
> @@ -649,16 +651,20 @@ static int atmel_classd_probe(struct platform_d=
evice *pdev)
>  	ret =3D atmel_classd_asoc_card_init(dev, card);
>  	if (ret) {
>  		dev_err(dev, "failed to init sound card\n");
> -		return ret;
> +		goto unregister_codec;
>  	}
> =20
>  	ret =3D devm_snd_soc_register_card(dev, card);
>  	if (ret) {
>  		dev_err(dev, "failed to register sound card: %d\n", ret);
> -		return ret;
> +		goto unregister_codec;
>  	}
> =20
>  	return 0;
> +
> +unregister_codec:
> +	snd_soc_unregister_codec(dev);
> +	return ret;
>  }
> =20
>  static int atmel_classd_remove(struct platform_device *pdev)
>=20


--=20
Nicolas Ferre
