From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5677: make ACPI property names match _DSD
Date: Wed, 3 Apr 2019 10:33:53 +0700
Message-ID: <20190403033353.GH2059@sirena.org.uk>
References: <20190401205519.34023-1-fletcherw@chromium.org>
 <20190401205519.34023-2-fletcherw@chromium.org>
 <20190402050637.GW2059@sirena.org.uk>
 <CAN-6NYYPL=W66vnnqbXK+LBFbuSnpqL8iv+h_x4G67PWFsMoKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HZmXSWY/1Xf1kK7R"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN-6NYYPL=W66vnnqbXK+LBFbuSnpqL8iv+h_x4G67PWFsMoKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fletcher Woodruff <fletcherw@chromium.org>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>
List-Id: alsa-devel@alsa-project.org


--HZmXSWY/1Xf1kK7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 09:52:56AM -0600, Fletcher Woodruff wrote:
> On Mon, Apr 1, 2019 at 11:06 PM Mark Brown <broonie@kernel.org> wrote:

> > It'd be fine to add your new DT style properties but this
> > might break existing systems.

> That said, I agree it would be safer to use the idiomatic ACPI names, and then
> fall back to the DT style names if the idiomatic names fail. Does that sound
> reasonable?

Yes.

--HZmXSWY/1Xf1kK7R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlykKaEACgkQJNaLcl1U
h9CBCQf+NRB3vvcQqq83OqlGvqNPTlklbaDb7Dxl/u7aRVTEtnk/CUYK919RICan
9lbW88q6uibWZ53742jjEvR78GOWm50ZLu1ht5lqrvCYa3E3ZPggpMaf5f+rk+DV
RcYUAHwDfinabYcuR8hfJ/ITngB9Xop9zl1VVXSovHlLIRnXoPGpUagKCtFamkSV
NpvXVkJ3NTyLLPOYH/aCVOC+/ZxuOPrKBD/NQe3wv3n2mZSFo6/o3sWp27tNsU9E
5MKTtD6JNs6tRVt5IvFPOR3XSztzRaDElhJSqRJgpXurrfzpsyIV4Uh6/FWLZIJe
q7AMrRMdi0i0xdQZb/hEwZ2XvrhhKQ==
=m8Q1
-----END PGP SIGNATURE-----

--HZmXSWY/1Xf1kK7R--
