From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adav80x: mark expected switch
	fall-through
Date: Thu, 9 Aug 2018 10:30:02 +0100
Message-ID: <20180809093002.GB6132@sirena.org.uk>
References: <20180808191933.GA27767@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4683847987023498872=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 52CB82677A8
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2018 11:30:06 +0200 (CEST)
In-Reply-To: <20180808191933.GA27767@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============4683847987023498872==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 08, 2018 at 02:19:33PM -0500, Gustavo A. R. Silva wrote:

> @@ -648,6 +648,7 @@ static int adav80x_set_pll(struct snd_soc_component *component, int pll_id,
>  			pll_ctrl1 |= ADAV80X_PLL_CTRL1_PLLDIV;
>  			break;
>  		}
> +		/* fall through */
>  	default:
>  		return -EINVAL;
>  	}

Are you *positive* this is a deliberate fall through?

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltsCZoACgkQJNaLcl1U
h9C9NAf+NiXGG9NS4z0R9rZFEvMmWRi3tYsX6bswoVYZbhBDgLOYe01p6zCXU3ux
LojkPzgFito3pK90mPFD7vabdeN1qdppD9RaIDkpuc1wEzM1brtq5SJulUbFlnhh
qh2FtJUr78urfSEWlCyX3e96QzKLrbm2fubjhtUwMHy8NM29ZAGl0EfIomGbaIeO
ZdxXEOLhV2uvO2CzuPBHJpNXsl7lfEWwWE7nOjqt/NUIt9SHJwUV5iKTajE0emOy
QgJY0Fx6Ylobr693u5VyQ/14Ol/6DlJ24c9/qKZoDbfghGzG1ato/e8TI6nF6Kh9
OzdBYHOTC7kOLiw//5PW+Z0axlwJgw==
=lL8b
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--

--===============4683847987023498872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4683847987023498872==--
