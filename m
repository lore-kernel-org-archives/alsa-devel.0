From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: Intel: do cast earlier in sst_cdev_tstamp()
Date: Thu, 9 Apr 2015 11:00:54 +0100
Message-ID: <20150409100054.GQ6023@sirena.org.uk>
References: <20150409090239.GA17605@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KAj9AL6usbKsxRUD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150409090239.GA17605@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jie Yang <yang.jie@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--KAj9AL6usbKsxRUD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 12:02:39PM +0300, Dan Carpenter wrote:

> My static checker complains about these because it looks like the
> multiply can overflow and then we cast to a larger data type.  I don't
> think this is a problem, but it's also harmless to do the cast earlier
> so let's silence the static checker warning.

Applied, thanks.

--KAj9AL6usbKsxRUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJk3VAAoJECTWi3JdVIfQ0uIH/RXFJFHg+/YLdbQnm2Raf32J
Fz1A7mMfiXBY2lkurdXR4by0+K8844zrzWYTqlPgzAqZn2/IIL5wUlaLVLKX+4kt
s/DbcDGCMX40/1bKom3Pil2V7Ug3vdS95wZX99A5zwsm1nw0T0jMDnIximYrcaTA
boglIHGN0yZ0Uuje3ACJXJTc2lkuPjmzn2OBn+b0cXeCWq+Ddou8Egpi07xYqx0U
gxaI5X1N/0YjHNluvEShN4pFA+AbFpSOPaGE3dqTB237/O3mZsq3slYohJ/BcAeJ
Bvrt8uSSpSFRumuJrz8oYfLCg6eXDrKCA//sO9bOWqdnkNr7NV/5oblk4l+p1uo=
=5scd
-----END PGP SIGNATURE-----

--KAj9AL6usbKsxRUD--
