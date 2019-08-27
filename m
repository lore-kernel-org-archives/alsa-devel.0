From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] Revert "ASoC: sun4i-i2s: Remove duplicated quirks
 structure"
Date: Tue, 27 Aug 2019 11:43:52 +0100
Message-ID: <20190827104352.GY23391@sirena.co.uk>
References: <20190827093206.17919-1-mripard@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="15k5Fuw+yLfT1d9X"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190827093206.17919-1-mripard@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, codekipper@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--15k5Fuw+yLfT1d9X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 11:32:05AM +0200, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> This reverts commit 3e9acd7ac6933cdc20c441bbf9a38ed9e42e1490.
>=20
> It turns out that while one I2S controller is described in the A83t
> datasheet, the driver supports another, undocumented, one that has been
> inherited from the older SoCs, while the documented one uses the new
> design.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--15k5Fuw+yLfT1d9X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lCWUACgkQJNaLcl1U
h9BE5wf/e1I8LfUK6KLnXqxYzxIjCX6f4JtBiqFI99GurXQD/tNK1q7Ldszv3Cwc
diESenhKUbt+tMgtus6JWeI71/T2BN6A1fewE6n5rhLl/tny4kmlcIlBsZIPV2z6
WFmdU15AGyRSRBIRkQwGYBxA5ViTMQqeWKXtCenIkxypv06TsBqQr047rvlgFdEf
anti8BIGziPLJtyCkpU/iCV151N9K5priltDgw0FKN0nogcyUAUWXcaAjbQi0kQe
FYtUKi/Rl3XQKqGkL4h4Z80VTlXbq60QH1npUmR8Y0WpecEci92PJ3iOmqciwfe9
sbKc1Q/++txkY4XUgNv+RDvt9Q4/zg==
=bQV/
-----END PGP SIGNATURE-----

--15k5Fuw+yLfT1d9X--
