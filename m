From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/11] ASoC: samsung: s3c2412: Handle
 return value of clk_prepare_enable.
Date: Wed, 26 Jul 2017 12:28:17 +0100
Message-ID: <20170726112817.sdcfz25nhiitkhd2@sirena.org.uk>
References: <84c0014d4dbd466f52c45d8efbd2c1080d8174fb.1501047400.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2704544379645531960=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B28F92673F1
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 13:29:01 +0200 (CEST)
In-Reply-To: <84c0014d4dbd466f52c45d8efbd2c1080d8174fb.1501047400.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, krzk@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============2704544379645531960==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ixcskedgoiumihx5"
Content-Disposition: inline


--ixcskedgoiumihx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 11:15:25AM +0530, Arvind Yadav wrote:

> --- a/sound/soc/samsung/s3c2412-i2s.c
> +++ b/sound/soc/samsung/s3c2412-i2s.c
> @@ -65,13 +65,16 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>  	s3c2412_i2s.iis_cclk =3D devm_clk_get(dai->dev, "i2sclk");
>  	if (IS_ERR(s3c2412_i2s.iis_cclk)) {
>  		pr_err("failed to get i2sclk clock\n");
> -		return PTR_ERR(s3c2412_i2s.iis_cclk);
> +		ret =3D PTR_ERR(s3c2412_i2s.iis_cclk);
> +		goto err;
>  	}
> =20

Why are we making this unrelated change?  None of the error handling we
jump to is relevant if this fails...

>  	/* Set MPLL as the source for IIS CLK */
> =20
>  	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
> -	clk_prepare_enable(s3c2412_i2s.iis_cclk);
> +	ret =3D clk_prepare_enable(s3c2412_i2s.iis_cclk);
> +	if (ret)
> +		goto err;
> =20
>  	s3c2412_i2s.iis_cclk =3D s3c2412_i2s.iis_pclk;
> =20
> @@ -80,6 +83,11 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>  			      S3C_GPIO_PULL_NONE);
> =20
>  	return 0;
> +
> +err:
> +	clk_disable(s3c2412_i2s.iis_pclk);

This will disable the clock if we failed to enable it which is clearly
not correct.  It's also matching a clk_prepare_enable() with a
clk_disable() which is going to leave an unbalanced prepare.

--ixcskedgoiumihx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4fNAACgkQJNaLcl1U
h9DkhQf/bachrzLQ5WsOE6lusQ2jBuikcm4zuO6h5bQps7WwKWqUYDy9WgUEalJS
JnGMmf50ejPQN4DWvem4AgubLD1e6ZsiXvp9vPn6zRiLpNqNdFYzZHg5VPBtq4/G
lkMZTF87M+tE0pQkLkqddnzAyOti3pZJsaSpE9SCjc/GfJqSfZl/c/6G3E6fT/2N
JkrLYA0vh6fjpeib5m6WiHW/n9GsDJViL61i7kRXCTwThIbNcYrLACrBYgCAp6KB
nNLAf9H9Bo8J2oMcTKrAG0LY8NZPyPiKNFxu7PXOAG9l+aI+Acc3onvHGsrDMd9G
NWmKvm7KlVlubG7o6UQ4GnpmFg+mkw==
=belb
-----END PGP SIGNATURE-----

--ixcskedgoiumihx5--

--===============2704544379645531960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2704544379645531960==--
