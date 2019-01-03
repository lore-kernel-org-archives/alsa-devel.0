From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] In function rt274_i2c_probe(),
 if the regmap_read fails. The variable "val" could leave
 uninitialized but used in if statement.
Date: Thu, 3 Jan 2019 13:10:33 +0000
Message-ID: <20190103131033.GU1846@sirena.org.uk>
References: <20190103023839.15314-1-yzhai003@ucr.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1286111326436689312=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 404F6267BBA
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 14:10:46 +0100 (CET)
In-Reply-To: <20190103023839.15314-1-yzhai003@ucr.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yizhuo <yzhai003@ucr.edu>
Cc: csong@cs.ucr.edu, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, zhiyunq@cs.ucr.edu, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1286111326436689312==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1YSLKY9nNiKnepPi"
Content-Disposition: inline


--1YSLKY9nNiKnepPi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 06:38:39PM -0800, Yizhuo wrote:

>  	int ret;
> -	unsigned int val;
> +	unsigned int val =3D ~0;
> =20

This just shuts warnings up which may mask further problem, it is better
to just leave it and fix the users.

> -	regmap_read(rt274->regmap,
> +	ret =3D regmap_read(rt274->regmap,
>  		RT274_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &val);
> -	if (val !=3D RT274_VENDOR_ID) {
> +	if (ret || val !=3D RT274_VENDOR_ID) {
>  		dev_err(&i2c->dev,
>  			"Device with ID register %#x is not rt274\n", val);
>  		return -ENODEV;

If the read returned an error we should pass back the error code we got
=66rom it, not mask it with another error code.  This is especially true
here where the error message would be very misleading if there's a
problem with I/O.

--1YSLKY9nNiKnepPi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwuCcgACgkQJNaLcl1U
h9ATcQf/eBbwaS5qgEtEK51OPB3FNB6vrxxUk5HGFZqdFxZQVgcz3XNeMEDhcccS
cKGpg1ksiEpLIog6GK6KmLkHrfiA8aWoHhkuDGxMnogfySqU9qA3V8LbQoBGAh56
x3tnhky9Iuyj+Wcj0WKw00dsBlDxrorF3z9297WkFsopR3J7Sd7OHZjQFYopthin
mhAuUkwTfP1QQDANxH3AciBZwA8CJQQ+XqB/ORavzZqWfi8znP9NnN+fdOuHzqWK
qbzU2aLsWFiGzfOxFUjyJTWSr0UlgKTE8YpORTWNsSQhYTchJLnwAqStlaFW00VA
Dczuw8DOS8aDFgHNENAmUUhiSv0KpQ==
=D6U7
-----END PGP SIGNATURE-----

--1YSLKY9nNiKnepPi--

--===============1286111326436689312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1286111326436689312==--
