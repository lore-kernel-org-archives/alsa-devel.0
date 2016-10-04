From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 06/14] ASoC: Add sun8i digital audio codec
Date: Tue, 4 Oct 2016 18:15:49 +0200
Message-ID: <20161004161549.GO5228@lukather>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i13qRg9tmWEwo36p"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: vinod.koul@intel.com, wens@csie.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lee.jones@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com, alexandre.belloni@free-electrons.com
List-Id: alsa-devel@alsa-project.org


--i13qRg9tmWEwo36p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> +static const struct of_device_id sun8i_codec_of_match[] =3D {
> +	{ .compatible =3D "allwinner,sun8i-a33-codec" },
> +	{ .compatible =3D "allwinner,sun8i-a23-codec" },

I thought that the A23 and A33 had different codecs? In that case, it
wouldn't be a good assumption to make


> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_codec_of_match);
> +
> +static struct platform_driver sun8i_codec_driver =3D {
> +	.driver =3D {
> +		.name =3D "sun8i-codec",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D sun8i_codec_of_match,
> +	},
> +	.probe =3D sun8i_codec_probe,
> +	.remove =3D sun8i_codec_remove,
> +};
> +module_platform_driver(sun8i_codec_driver);
> +
> +MODULE_DESCRIPTION("Allwinner A33 (sun8i) codec driver");
> +MODULE_AUTHOR("huanxin<huanxin@reuuimllatech.com>");

Those obfuscated email adresses are not really helpful :)

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--i13qRg9tmWEwo36p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX89W1AAoJEBx+YmzsjxAgYs0P/3yLT9JFd/95GjY91ERJXpJW
+TmIcYJl4KHCHktAu0ldpvWWpGlO9PqOSylW7hVz8eUsHY85gS6gKImDSMNROGQj
n5ZXTGM4dYE2NGDC6Kn2gry3K3ZoIOTNxLk/hIX05ifcR8+leVlTv/xR/BbJBzmZ
cq7KbeWlIKXyx+XLv0tF+eHOfLqh5jyZ1DZRnUByoo4ndAxluqRSZP7iDQRaB+d6
ieZ63UiHnDxzQJs7nHRmzZ8IxxHq/gIrRDG1mIYZnF+a4QqLhN9FVMY3xH/85eNr
UBU2DyY2sQNmRzwPntc9WVRzqGgU/pskCVuTHNOA7rgEX++vrOWyqB5PnRdhZ38M
PidQSP1GSRTRTtvU+2PMEnhEjlKtmbvNarAyWtng1EY5fmqh1Mha8s9TO9oUGnP0
uqfufigLmkqRxojQGY0Z0IaKu069+Z4K2eWZZW11qkPlgH1HupyxCjwQ7VlhmFEN
F8Mw/j8beN8zQm+yqCgYR21xpqQSLUMCyC5qr9TZDqy3jZI0YSoBmaT7OJ9Gggwh
7k5l1Q9iWI8YYqnC5mhP82H+BcyO6cTed/3NIJrnTAiXdfM028lcAkWvZX9UCOsi
q9Md7Ad+UjHNIQenNgMLjqPhWBqyd08VydnsUUr6lSpM/knP5rOiJAV4uOtW2222
BFZOUG4cXnTFsxtzEL0O
=modN
-----END PGP SIGNATURE-----

--i13qRg9tmWEwo36p--
