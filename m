From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: rt5645: Prevent the pop sound of
 the headphone while rebooting or shutdowning
Date: Tue, 25 Aug 2015 18:57:26 +0100
Message-ID: <20150825175726.GJ12878@sirena.org.uk>
References: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4767802374703385097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7ADF265152
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 19:57:40 +0200 (CEST)
In-Reply-To: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4767802374703385097==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oplxJGu+Ee5xywIT"
Content-Disposition: inline


--oplxJGu+Ee5xywIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2015 at 08:32:55PM +0800, Oder Chiou wrote:
> Add i2c shutdown function to prevent the pop sound of the headphone while
> the system is rebooting or shutdowning

> +	regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3, 0x0020, 0x0020);
> +	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2, 0x1000, 0x1000);
> +	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, 0x0004, 0x0000);

Yay, magic numbers!  What is the issue this is fixing?  The core is
supposed to power everything down to _BIAS_OFF before exiting, are we
missing something here?

--oplxJGu+Ee5xywIT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3KyFAAoJECTWi3JdVIfQjJYH/ReSAM6WLUOdBFZvQWLbz8iu
rzpzaiAPdzFnTMMWDTih8IqrNFT/hx5aLnRGYRLl8J971UJGOoUWoXt92VYikBmL
PHbSt1lsc3bT5auXRRhrPIr3NZ0EXWXLhVyu3z3RwKmR+yjORV3U9lXWa2FIfiVZ
6Hq+o0uuD9fjmsQ3shdhrQnBXcGE+ubAPF6SSiGuCEn7WwlSn98nMH+DqCZnuvIW
Qs/SCOAoK7UV0pgOfJvdHOd4nwWISiFcNhK8s5+80jVAezch++hsMDSi3kgHA+Ru
nmOB0xK2+oB9UUuLXJG2vqNwgjiozwulmyKlzxiBbxA8IZELPwWNQKW9VXHDDNs=
=GLqi
-----END PGP SIGNATURE-----

--oplxJGu+Ee5xywIT--

--===============4767802374703385097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4767802374703385097==--
