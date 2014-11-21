From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip: i2s: Add dependency to I2S device driver
Date: Fri, 21 Nov 2014 18:58:56 +0000
Message-ID: <20141121185856.GJ3815@sirena.org.uk>
References: <1416594913-30187-1-git-send-email-rupran@einserver.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3/wSlNRiBFY7h6fz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416594913-30187-1-git-send-email-rupran@einserver.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Ruprecht <rupran@einserver.de>
Cc: Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--3/wSlNRiBFY7h6fz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2014 at 07:35:13PM +0100, Andreas Ruprecht wrote:
> Currently, CONFIG_SND_SOC_ROCKCHIP_I2S could also be selected
> without having CONFIG_SND_SOC_ROCKCHIP enabled.
>=20
> As this makes no sense (and breaks the build, when the option
> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM - which would be selected by
> CONFIG_SND_SOC_ROCKCHIP - is not enabled), a Kconfig dependency
> is added to CONFIG_SND_SOC_ROCKCHIP_I2S. This will make the item
> visible only if CONFIG_SND_SOC_ROCKCHIP is enabled.

This doesn't seem like an obvious fix - why is the fix not to put the
select on the I2S driver (which is the thing that actually depends on
the dmaengine stuff)? =20

--3/wSlNRiBFY7h6fz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4twAAoJECTWi3JdVIfQrQYH/11BKDB5c4u0DcCrYsBIZO4S
9T9+RSlxKXw+31lHTA5VAcZMdcWM09wscUrp6et0diNWxowxRQwnB2wIYbX8pJmG
pvaCEM/JFyqX3RRoMu2bE6eqrIMBnvOSzv2oc38w69tsJt9Xt2lYb7CU0pP+Lpsr
kS/c5gfRAYq6XIqvojsQ1Ub0IqIacIsnz1m2Sx1OyWOpHSGXD2hLKa6GUQdxGKml
9YeLMHxioWz62fHl4NhYZSLv4DRDh1YwKsKzM93b3FSwXiqZnv+1rI+fEJryLtg/
YTcAQkLMtv9Qk1WHy0v2Y5pwruhi4RUKjM7iIpIVs8qUzzQvyH0bJURUe98+NHY=
=zAV7
-----END PGP SIGNATURE-----

--3/wSlNRiBFY7h6fz--
