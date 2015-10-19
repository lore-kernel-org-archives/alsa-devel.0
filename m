From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH V2 03/10] ASoC: img: Add binding document
 for I2S output controller
Date: Mon, 19 Oct 2015 18:56:58 +0100
Message-ID: <20151019175658.GI32054@sirena.org.uk>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-4-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aFi3jz1oiPowsTUB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444653637-14711-4-git-send-email-Damien.Horsley@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: alsa-devel@alsa-project.org, James Hartley <James.Hartley@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--aFi3jz1oiPowsTUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2015 at 01:40:30PM +0100, Damien Horsley wrote:

> +Optional Properties:

> +  - interrupts : Contains the I2S out interrupts. Depending on
> +	the configuration, there may be no interrupts, one interrupt,
> +	or an interrupt per I2S channel

If there is an interrupt per channel how should they be described in DT?

--aFi3jz1oiPowsTUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJS7pAAoJECTWi3JdVIfQhBUH/jKSdQkb0h3yjw9KNfDpqQk0
UpcloU+9G8cjD3WyUx6bpSOpRSIXm9L2YsHzKq3kh3KT6Gw9S4VnOGl/2MfLTnDe
WkbPXNvLKpJ+Ro+i4fwkdgH4K93G+FyZaVL4Q4nLIgTYokqslhraxJwKBiu+ycep
3EoHT2sQ60yWqqa0gB20aIMo54U6MjxpKzE+HW8xONFNRIJsSK2WV+WRywr5jHFZ
EIcf0bb9fRCYyZfLzgxaEq/3CNd+bsOQiEHgypd153HaU9drEpYNURpi0nHO8aBZ
gccpFUJxVxjI2ACvZc5WHggYw8F4Yk2aVx3We7WVdPhQ6zycYw8pv2zZTa0mLaU=
=DiTp
-----END PGP SIGNATURE-----

--aFi3jz1oiPowsTUB--
