From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Codec: wm8962: balance pm_runtime_enable
Date: Wed, 30 Sep 2015 19:11:38 +0100
Message-ID: <20150930181138.GP15635@sirena.org.uk>
References: <1443588853-8778-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NT59pYSnj1ZLVgEN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443588853-8778-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--NT59pYSnj1ZLVgEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2015 at 01:54:13PM +0900, Jiada Wang wrote:
> pm_runtime_enable is called in probe to enable runtime PM
> for wm8962 codec, but pm_runtime_disable isn't called in remove
> callback, nor is called in error path if probe fails after runtime
> PM is enabled, this causes unbalanced pm_runtime_enable.

Applied, but please use subject lines matching the normal style for the
subsystem.

--NT59pYSnj1ZLVgEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDCXaAAoJECTWi3JdVIfQD6kH/jocNQ5sY6RKWVa2DBYivPlS
8XyvXLImBEi5GZ4qRfQROxM9NlDrwZCZeDKJeHQ+wnFpkwUqhYsl7Qdwz/H+yqvI
Ewvh/ks6xpFiiOvtIp1kKnAU5T9bSvomGc2Mjd1LaWFlCGIvjzJPXj2jBOM1lTPJ
vx4DR43edZ+ZS7XhSS0W9UU26gmPObXCETr5VwGl61cw4zqsge/CunHWyqLtjuWz
ucCOU37wyEHF8NNc89bjsQ6JwUMOWNO4S7viilFF/n6VJVa0bYgv9C6HYZAgjRW7
+swDGVfkHB+nhToz9wz9PK17+pRTTut8V6E+jaldmI0XpvmbUZuNJsf+rmKzBNk=
=ozLp
-----END PGP SIGNATURE-----

--NT59pYSnj1ZLVgEN--
