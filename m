From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/6] ASoC: dwc: Ensure FIFOs are flushed to prevent
 channel swap
Date: Fri, 12 Dec 2014 18:12:44 +0000
Message-ID: <20141212181244.GQ11764@sirena.org.uk>
References: <cover.1418372910.git.Andrew.Jackson@arm.com>
 <a3b4a11dfe1688eea07471c6cfa27676cc9a58a8.1418372910.git.Andrew.Jackson@arm.com>
 <548AB75E.9030302@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DgyySQcJ59QCrNUU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <548AB75E.9030302@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Andrew Jackson <andrew.jackson@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--DgyySQcJ59QCrNUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 12, 2014 at 10:37:34AM +0100, Lars-Peter Clausen wrote:

> This should probably go into the prepare callback. prepare is for example
> also called when recovering from a underrun/overrun. Whereas hwparams is
> only called during initial setup of the stream.

Indeed, that's a better place.

--DgyySQcJ59QCrNUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUizAbAAoJECTWi3JdVIfQhV8H/i1tVDyivMVCJ2KEiemPRPh3
mx5oDLjdRbUVHCrPEyKS+Aur+mWJ7Jn0SVMKbkoajlRPzCp+ZvYsS7BNg7v3IV8E
ODg0WHetvCNnz/+O4ZDdgSSf9mGjRxv8vzKXsfqzSEuT0P5xRCUQ6tvO9OaWRHns
s/Lsdu3TBGkGF61qSsnuj97CJxgdGGuoWYjoJ5PLiQxKlVnzgiS5/UX0Az9mI2hA
DH0kjlVumQVFcmnTlm2S1iwfppPWHqKNFtxMN1miQRBSaOhyc4CCan5Fyeh88Slx
eY60zbLVE0FbUDpD/4pSHeHrG2MWgwUarz5JngUfokfa7HVLpH6DqxLc1UjXHA8=
=mSP6
-----END PGP SIGNATURE-----

--DgyySQcJ59QCrNUU--
