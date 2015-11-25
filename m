From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Add dmi_system_id "Google
	Terra"
Date: Wed, 25 Nov 2015 12:01:39 +0000
Message-ID: <20151125120139.GP1929@sirena.org.uk>
References: <1448333729-11065-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8477873058069956616=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 447E4260699
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 13:01:47 +0100 (CET)
In-Reply-To: <1448333729-11065-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Luke_Yin@asus.com, lgirdwood@gmail.com, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8477873058069956616==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o41d8xLWOaLD8vYh"
Content-Disposition: inline


--o41d8xLWOaLD8vYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2015 at 10:55:29AM +0800, Bard Liao wrote:

> +	{
> +		.ident = "Google Terra",
> +		.callback = strago_quirk_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Terra"),
> +		},
> +	},

It might make more sense to just have a single entry for all these
Google platforms and extend this table rather than adding a complete new
entry for every platform - they're all the same and it'd make the table
smaller.

--o41d8xLWOaLD8vYh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVaMjAAoJECTWi3JdVIfQV1IIAIBBIU91qFp2VPcCheTIJGBc
U+Y0pvStB17UIl9KBZlWTU70TJXujjz1YjtAAEig0WtVhb1mISGDQ0fE+23Xm8Ns
0z0jSk/dx+C3yVDBFSNGyItX10XSVqWK1gmsF/kMA79zFGnOXl6paY7SOGHAwWs4
6wFd6jIfuDi/qbueIp+h/IA1+h++sU61OM+wtp3P8pKVYZfUB+lvu9Bm5yXy6dcq
uVHZY5n6c9Cratg4gQbigLa5mgOtWy15qfyOc5TXCw+SHE/4oorD4WbkEI2iRYRM
J5q5hbUr9a5Og8vvwaa3xpiH8lXidTi8b3IZMQkphh2vyP24OGapOyKbh04zipQ=
=IdDI
-----END PGP SIGNATURE-----

--o41d8xLWOaLD8vYh--

--===============8477873058069956616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8477873058069956616==--
