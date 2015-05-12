From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: rockchip: add rockchip machine driver for
 rt5650/rt5645
Date: Tue, 12 May 2015 20:30:14 +0100
Message-ID: <20150512193014.GB3066@sirena.org.uk>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-4-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="obAtV4On+KRLREo5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431422797-31903-4-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <acgzxing@gmail.com>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, zhengxing <zhengxing@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--obAtV4On+KRLREo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 05:26:36PM +0800, Xing Zheng wrote:
> From: zhengxing <zhengxing@rock-chips.com>
>=20
> The driver is used for rockchip board using a rt5650/rt5645.
> Test on RK3288 with rt5650.

Similar comments to the Maxim driver plus...

> +/* Jack detect via rt5645 driver. */
> +extern int rt5645_set_jack_detect(struct snd_soc_codec *codec,
> +				  struct snd_soc_jack *hp_jack,
> +				  struct snd_soc_jack *mic_jack,
> +				  struct snd_soc_jack *btn_jack);
> +
> +/* For compatible. */
> +int __weak rt5645_set_jack_detect(struct snd_soc_codec *codec,
> +				  struct snd_soc_jack *hp_jack,
> +				  struct snd_soc_jack *mic_jack,
> +				  struct snd_soc_jack *btn_jack)
> +{
> +	dev_warn(codec->dev, "Jack detect dummy, have no implement it?\n");
> +
> +	return 0;
> +}

Don't do this - if the functionality isn't there in the CODEC driver get
it implemented before you use it.  Make sure you're using the API the
CODEC actually ends up exporting.

> +	/* Enable Headset and 4 Buttons Jack detection */
> +	ret =3D snd_soc_card_jack_new(card, "Headphone Jack",
> +				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,

> +	ret =3D snd_soc_card_jack_new(card, "Mic Jack",
> +
> +	ret =3D snd_soc_card_jack_new(card, "Button Jack",

No, don't do this - as discussed in another Chromebook review (I'm
guessing this is a Chromebook) the jacks should represent the physical
jacks in the system.  It's possible you have separate headphone and
microphone jacks but I really expect microphone and button to be on the
same socket.

--obAtV4On+KRLREo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUlTFAAoJECTWi3JdVIfQqjMH/2qpizPIinUrfeomSUdOeM4W
lrG2OaGezU+DCa/DbeJMdBnFZ+tid5c1rh6abd5bnRIYWTZrkWXYYOkMQpAEC8GJ
1B2BFTpZEObLKIgg4qAkzuu/v4X6ScdxPHY/SFlsnIEUyaAvDbj3peycQJ838Vxz
lwtRgkhc7TMTjOqI/lxMkdTNF5t6DMRY0ZXC/ZGjG2sO6shomdPEuUMnXFvcaQNv
8+iDNyfo4mdW5Rhkk6eWFf60p/phVC8R1aB6X4Rcbeao23kYi8zcsD1zFmKqrkyR
e9z4mTG+mQpH7AjCC/cRlyD3ttZOjneDe9DNBxXRa1Z0BlFerOG8Z7eYW9IGUgo=
=6AbP
-----END PGP SIGNATURE-----

--obAtV4On+KRLREo5--
