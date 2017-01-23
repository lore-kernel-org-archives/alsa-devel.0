From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: mxs-saif: add mclk enable/disable ops
Date: Mon, 23 Jan 2017 19:07:01 +0000
Message-ID: <20170123190701.hva43ac4ceo6xxla@sirena.org.uk>
References: <20161222164926.19621-1-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qhyg5xsg6yr6ozrr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161222164926.19621-1-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, =?iso-8859-1?Q?J=F6rg?= Krause <joerg.krause@embedded.rocks>
List-Id: alsa-devel@alsa-project.org


--qhyg5xsg6yr6ozrr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 22, 2016 at 04:49:26PM +0000, Mans Rullgard wrote:

>  int mxs_saif_put_mclk(unsigned int saif_id)
>  {
> -	struct mxs_saif *saif =3D mxs_saif[saif_id];
> -	u32 stat;
> +	struct clk *clk;
> =20
> -	if (!saif)
> -		return -EINVAL;
> +	clk =3D clk_get(NULL, "mxs_saif_mclk");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);

So, this *is* an in place refactoring but it's only half done in that
we don't have any followup patches that move the clk_get() to device
probe where it should be.

> +static void mxs_saif_mclk_disable(struct clk_hw *hw)
> +{
> +	struct mxs_saif *saif =3D to_mxs_saif(hw);
> +
> +	if (!saif->ongoing)
> +		__raw_writel(BM_SAIF_CTRL_RUN,
> +			     saif->base + SAIF_CTRL + MXS_CLR_ADDR);
> +
> +	saif->mclk_in_use =3D 0;
> +}

We silently ignore disables if the clock is in use?  That seems error
prone.  I'd expect us to at least warn in that case.

> +static unsigned long mxs_saif_mclk_recalc_rate(struct clk_hw *hw,
> +					       unsigned long parent_rate)
> +{
> +	return clk_divider_ops.recalc_rate(hw, parent_rate);
> +}

Can't we just assign these ops directly?  Having to write wrapper
functions like this looks like we're doing something wrong here.

--qhyg5xsg6yr6ozrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliGVFQACgkQJNaLcl1U
h9ABbwf/cyxSrrbAksx1jRM2tm3RuxmaOiFVoxkvGQvPlciCpkiy0bv8ShgPPNJP
KOJSB0uuTGtr/yvzVY/h1VBqCFDDXISHxoUfR7xtilj7MZRWV/Nl2QkLhoWL7WyT
SwSj6eYIT8enqiEtMGibXfoQdowhM7/qmufqS/1xVufT+w7N6G9qoPUrjV6agWLf
SgMj9Oz9tl0xjjxUjcumLfmBFZaKjoeGnv1Tb5k78TuGPPR0bC6WvowkBy7GO+WX
7v20yfZEIoxhhbgIze50n+ELoLVWA0bNR7qSn04TOg5oGWVuvEunigQnODHNbz+N
xoYeMAnMuedP/8IEuNkSa0ah0gO/pg==
=EfBm
-----END PGP SIGNATURE-----

--qhyg5xsg6yr6ozrr--
