From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 02/14] ASoC: sun4i-codec: Expand quirks to handle
 register offsets and card creation
Date: Thu, 3 Nov 2016 18:34:13 +0100
Message-ID: <20161103173413.xoljqlfpqlfaeiyj@lukather>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-3-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qm7lw7z5vypghuao"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161103075556.29018-3-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: alsa-devel@alsa-project.org


--qm7lw7z5vypghuao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2016 at 03:55:44PM +0800, Chen-Yu Tsai wrote:
> The A31 has a similar codec to the A10/A20. The PCM parts are very
> similar, with just different register offsets. The analog paths are
> very different. There are more inputs and outputs.
>=20
> The A31s, A23, and H3 have a similar PCM interface, again with register
> offsets slightly rearranged. The analog path controls, while very
> similar between them and the A31, have been moved a separate bus which
> is accessed through a message box like interface in the PRCM address
> range. This would be handled by a separate auxiliary device tied in
> through the device tree in its supporting create_card function.
>=20
> The quirks structure is expanded to include different register offsets
> and separate callbacks for creating the ASoC card. The regmap_config,
> quirks, and of_device_match tables have been moved to facilitate this.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--qm7lw7z5vypghuao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYG3UQAAoJEBx+YmzsjxAgBjwQALYlQkBpWC8FXbTIggAhKEvu
kO5daufDHU/5SFgLgN+1OoOWxCdhbUCU1VyzMFtO3PkrsxRprlyghOyQUjOTG0jZ
li9mpM6fHIfGNpO0TdozGFqOn8EH7r8fkc8Axcyc16iYI+CdlS2tN/cpaTHSC8uj
zfeiJXXJe2ACcQaXDCK5LikF1GnHIOV+dC3ibGpodBs/bNTMSozl9ZZlXSK1EEIw
ooUtQZngYbfejGNiJz36vUHGDmfIDqzKAA/WOgfDYB4uIR/MS9clVdKUg9b8GUkI
aYGLcF8VnG3ltFmNbzw3SZiv2tbSaDo2W8P2ORLeuoOQxI19FeYCH9iSxsPCCTGe
iJle7mNALVt2b5sV0iDjuBX1sMNFcZa9pNjdtUKyqXb3jSIuqX8AW3ZPuLgOWV1+
/vAb3x36r8ouaaJGrnjweeMZk9VaZVSn+DaXVFdhyhE/a1pgL6qsdUql+DM/d1nm
P9zhDNPunnZVEcWPA23YXen/Qd4dAlUBABpXZuCEVP+7tLvgYeVtnDUbW3cSlz92
LlmxJtUEmGradJtUFr0MgQrQfqEpeP4/YP5Y9vz2G1gbFu3NE1Ogw3xb88WBoSoT
TUTbMS7wi1mPgqbr8q3IM429o0JlzzLfICoCowYhkVI3f+VQLYLtkgpQ6zU6mAt8
7j+iHQ/gGiGCPOCEq+fP
=iFgP
-----END PGP SIGNATURE-----

--qm7lw7z5vypghuao--
