From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
Date: Mon, 1 Feb 2016 21:10:17 +0000
Message-ID: <20160201211017.GG4455@sirena.org.uk>
References: <569D3800.2040801@maciej.szmigiero.name>
 <CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>
 <56AF4A9F.4060401@maciej.szmigiero.name>
 <CAOMZO5DK86JCs_KivZ5MMFKsiP6aVpopG-zgXPE-+_GWjQNuMw@mail.gmail.com>
 <56AF4ED0.7030801@maciej.szmigiero.name>
 <56AF8E9E.5000100@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56AF8E9E.5000100@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabio Estevam <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 05:58:06PM +0100, Maciej S. Szmigiero wrote:

> Looks like a possible solution would be to change
> regmap_raw_read() to do read using _regmap_read in
> case the cache is bypassed and there is no ->read
> callback defined for regmap implementation.

No, that's completely broken.  We can't do a raw read from a regmap that
doesn't offer raw access and we shouldn't pretend to do so.  If the
caller is capable of substituting a register by register read the caller
should take responsibility for that.

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWr8m4AAoJECTWi3JdVIfQ7Z4H/Reu/R+eh43RZfjK7y+WNdlV
IkRkqAp3l86gX/zwpxxzqmWz5fjf8gG0vdENxSXUfAzylLPoLw162KD/+oW9UeD2
4tJBNzitCISauuAnZmH81llShMCV6qfhgPaZPJmygzHDwaXYGJDS0LZNejUNYK+3
/sBx+BPbIoPOewBZg1w5Mpu/rxxaiWhFGwOD2ntBUrmCgwpv6SthkV+c2CcdHT7d
78q8RwAi9lEbetsASwOFGa1J6ZSUKBA8vWHEjsggroboR+Lni6Zvl+Nq3DHnge6w
ExlQ95cwLh8eZ5lwOcrI7xoZiZrV/IjquyOSl3mddq3gFOoeLMQFuuCoGcG1CY4=
=8Tfw
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
