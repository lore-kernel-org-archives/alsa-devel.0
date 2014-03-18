From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
Date: Tue, 18 Mar 2014 12:44:54 +0000
Message-ID: <20140318124454.GX11706@sirena.org.uk>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3168629279634444290=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB05726072A
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 13:45:05 +0100 (CET)
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3168629279634444290==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="37S+gaNFgaAMSwRw"
Content-Disposition: inline


--37S+gaNFgaAMSwRw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 15, 2014 at 01:44:08PM +0100, Markus Pargmann wrote:

> This new version of the cleanup is mainly a reordering of the patches. It moves
> the regmap patch to the end of the series so none of the other patches depend
> on it. This also fixes a bug I introduced in "Remove fsl_ssi_setup" which also
> removed the switching between network and normal mode depending on the number
> of channels. I reversed this code removal. Another new patch was added "Fix
> i2s_mode variable setup" which fixes the i2s_mode assignment in set_dai_fmt().

I'd really like to see some review/testin from other users on this
series.

--37S+gaNFgaAMSwRw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKD/DAAoJELSic+t+oim9780P/2NLcNZ2EovjQXZ7QqMFGNt7
IWqtLQs5nCUm8rQI6eBC5DsUwN7b0wz9WZTNc5pRMM8acmfrNDsIWzFbKIUPXkrp
NOQmpO2VBziVwtGiFFfM4vqULU4F2GY+sC7C7apGqcymoowuxtHb2/x50Bfdhv+J
f7rzZxq9W3RGmwErLeOvN7OhjHWNPZ/eAtzP1Q8KBWWhK/1p+8pg6zAWNAopalLk
x1OrM7ksAmjoWgj0hm4tYxxW/be+RExhLqn3ntxNuMgXlY9raAA4eI/SXqkr0r+z
TjdAO6/+QfPIzJIB456JRB0CWMm1f9huWoPLW6tcDwhPbFIsXwReRw9QZl5W3CzF
iYtIAfFLKdWGftr/kfYGW8fOV8rz276U7el/TR90KYRyoR64/G+xyB7sx1ygd/Jh
5p5gt0ccN/LOKGIsmwuFuNmfpvtjReCz7WoyZqQ+ut4eZ7FtuhHNmaI3Vd1ZLkQ0
uX2mWnDY7DEzK1rDmXojJeKCPu4Ub777nIolRyB46TR1tAe47GJ2IhhSCE8ynX7b
TkcG+YEgOogSB40cZFn1dVq5xXei4hFRSugmV9fWHBro0/SkHV0dguhw6i/Ng8AJ
O1jqb3L2lU7Yd4h0qTrYTQHqB6U6ChCGIjYi9xy9kLjy9AmC50a+9pavpkM75rgf
fvKJE+/2ZI6ZNdv86xNw
=yXof
-----END PGP SIGNATURE-----

--37S+gaNFgaAMSwRw--

--===============3168629279634444290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3168629279634444290==--
