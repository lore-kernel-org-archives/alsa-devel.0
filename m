From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: ASoC: rockchip: Add
 rockchip,codec-names property
Date: Thu, 10 Aug 2017 15:56:07 +0100
Message-ID: <20170810145607.g663oq7cfxjmaxtf@sirena.org.uk>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
 <1502340898-28403-4-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="faaqy76szqpegs3z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502340898-28403-4-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de, briannorris@chromium.org, dianders@chromium.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--faaqy76szqpegs3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2017 at 12:54:58PM +0800, Jeffy Chen wrote:
> Add a new rockchip,codec-names property, so that the driver can parse
> the codecs by name.

Why?  You're already referencing the CODECs by phandle and these names
are not part of any ABI...

--faaqy76szqpegs3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmMdAYACgkQJNaLcl1U
h9Dnagf/aZxJVOsaZqXldjTeBwE/IwMytJ3nEKJxSv3g+L2gRYxj7WpiiZ2egki6
YsLbpcydyyTOqdYEFNUdUPeBmoZ/lXvQ6Jt4v5+9apktmUIR81NBCpVnvynityMy
bs6bbovTiUOJ0OXBL5VjGGmr0K7r8IlFuB6kbeO18WnVNUWHlJIsghn4c5vE01k0
J36cd8WdfPzz+OS7kmtndxn5479d1xgT0K1ySFhCBOKxkA2O7L4UWsThBp3P865V
6FUIBqTOdzTKA/twcMKTlxMlIYyLm1ZBDVrE4v/k4wPQIHZMcD8SzSuc2HzCLMhC
drgYizLNsOzMoEACWe/vGjuTTD446w==
=yAX5
-----END PGP SIGNATURE-----

--faaqy76szqpegs3z--
