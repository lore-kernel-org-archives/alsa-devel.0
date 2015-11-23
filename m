From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/5] ASoC: Intel: Use acpi_dev_present
Date: Mon, 23 Nov 2015 23:37:14 +0100
Message-ID: <2021675.v2py4IEzgb@vostro.rjw.lan>
References: <cover.1448282995.git.lukas@wunner.de> <b7bd5f48fd254fb743b99d5c3e63f95ea8dfd8a7.1448282995.git.lukas@wunner.de> <20151123144836.GJ1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4873364.aXPVcA1JXl"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20151123144836.GJ1929@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org, devel@acpica.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--nextPart4873364.aXPVcA1JXl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, November 23, 2015 02:48:36 PM Mark Brown wrote:
> On Mon, Nov 23, 2015 at 03:34:55PM +0100, Lukas Wunner wrote:
> > Use shiny new acpi_dev_present and remove all the boilerplate to search
> > for a particular ACPI device. No functional change.
> 
> This will collide with some other work done on the Intel code in -next I
> expect, probably best to merge this via ASoC (so pulling a shared branch
> for the new API) or just wait till 4.5 to do the conversion.

If patch [1/5] is done the way it is, then it needs to go to upstream ACPICA
first and from there to Linux, so I guess no worries for now. :-)

Thanks,
Rafael

--nextPart4873364.aXPVcA1JXl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJWU5UfAAoJEILEb/54YlRxfA8P+wRcG7MPs3/pD8q7xOYahK2N
F74TMOCN6Qct2WhCUI0UPZbF8OTvnRuR+UnaVpARcnURzeeX7AGa9n6XcK20aHsJ
Ra9NWVoz6+yL6OZZZnTWvHhhvgdPIgFFTxfvNTpEOLzZ1Z8DSWEb5wCeeGmrGCt5
YX+iVRaWgHCOuCyi2pbbOH+e6bid2OR/ozHAxPikysaF33NP06EEt2ownn20/Wf5
Nn54KqxK+1qHwo5qMmkvP+pSnmhI+h42OsAUS/qFum8KsQ+20e5bHtkS6f0vJCj1
tsr4m0nxpZ1T/xbjBZ32MYNVhutAcPV0E5jNgSVVO+q/3vbGyCS/ghhDCoFh3hJA
LFDKl1PXXU/l949sF36Bn6N7paPuUyGSZc+IqOw9dRiQ+9EenSipzfp7pKU5ROMs
Fhk3oDtHPFbShNq6mbS11wpnySgbZa+/8LBl03gYCnICEl5yhdCOtklPGupcO7IK
ZDpRxnldau9gzHwj70Gl00OXnECaIB3AEeXgHkUENF4JjzAtZ04z7W5vEwwvW3Xa
FzGgQzYza1G6oUfXR53wikUK9vOd4dB1IZD8ysrAh6vRuY7AK8HzlurvfyhT07kv
MeC1PPSVoGfHGUek2ZqbnHu0HLYFNswWRTiwWSPzt/lSpZIUN+YiuheehhfF3dRI
QxlUvtR29YqukP4KUbq8
=VqmI
-----END PGP SIGNATURE-----

--nextPart4873364.aXPVcA1JXl--

