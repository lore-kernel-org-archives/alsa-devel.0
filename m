From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] regulator: core: Add devres versions of notifier
 registration
Date: Thu, 5 Mar 2015 16:58:39 +0000
Message-ID: <20150305165839.GR21293@sirena.org.uk>
References: <1425569962-14285-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PWK6D6Fg0OM3dZe4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425569962-14285-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, info@crazy-audio.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--PWK6D6Fg0OM3dZe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2015 at 03:39:20PM +0000, Charles Keepax wrote:
> From: Charles Keepax <ckeepax@gmail.com>
>=20
> Add devm_regulator_register_notifier, this adds the resource against the
> device for the consumer supply we are registering the notifier for. There
> seem to be few use-cases where this wouldn't be the users intention and
> this ensures the notifiers will always be removed at the correct time.

Applied all, thanks.

> I have based this series of your ASoC tree Mark, because the
> wm8804 patches have dependencies there. But just let me know
> if you would rather I send the regulator patch against your
> regulator tree.

You should send against the relevant tree for the subsystem usually, but
in this case they're the same as there's no relevant regulator changes.

--PWK6D6Fg0OM3dZe4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+Is+AAoJECTWi3JdVIfQQMQIAIbsmvdtJDLBbOYGxKvKlVng
4AX5dbBEnHuiJnEGZUVTinwY1/fK8dARo0lQDbnneAgMQvyrP4V38vCr64rAK3As
InvcEQzK2AS8MrzY1nXliU490xFYvFPYZCf6bcu0BqBt3nkiFNnoJr8sdOFCc2Sx
YX2Yh5DDBgAkbr6ryrkqoT0Vn81H+4IxYiZ1033LPdbZJjb3aFfRReXAjmxwxuZi
fZqNPKciWllECCgwVmSZN3hwk2GQktdpSIwTFUqM8T0V9on1F+sdPn0tEZyXd5cT
V2E+w9UI3XteVYff1+PudnltKuz95600BjrFxiKtemBsIcLVrcGWN1/S5Q+6HCw=
=sXOs
-----END PGP SIGNATURE-----

--PWK6D6Fg0OM3dZe4--
