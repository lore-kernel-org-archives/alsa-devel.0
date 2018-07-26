From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] ASoC: PCM format type conversion fixes
Date: Thu, 26 Jul 2018 15:46:59 +0100
Message-ID: <20180726144659.GF2414@sirena.org.uk>
References: <20180725211722.18944-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7325235155764897626=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AA72E26739D
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 16:47:06 +0200 (CEST)
In-Reply-To: <20180725211722.18944-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7325235155764897626==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 11:17:16PM +0200, Takashi Iwai wrote:
> Hi,
>=20
> the PCM format is a fixed type with __bitwise, and it needs cast or
> other trick to deal with integer.  This is a series of such fixes for
> ASoC.

Nice!  Should I just apply all these (including the initial patch adding
the helper)?

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltZ3uIACgkQJNaLcl1U
h9BpbAf/XxMBvOv1Kw9myTCD69iiSi3gLxa9dWcs+2bCj7TUaRUkkEDXXY+cf8z+
lI3WjxOVLbZdzHTu0z/x5KixFdH5CuXG8GxtzrXYoJYQtH0eD2jCuk2vhUfTFP7U
ezNvl6ZMs2ZT1t3Q3jXg0Izt39usyc3P/WeB+VG8o7n99aNuUISp5xYHvPRETeGU
imPVsa4gA477JeWhzS3VPCkUOv4p6MgfOdtOCLlzItsyMHOc7wiW6KkL5qMnq0t4
d1KTDR0wBSDkZGVLcONBa86mZ33edSGwBMT3Cw43hFR9P/FS/IY/qzeBdJhNi7Ol
d/ltNXEOwlA8rP6ZDeNqz64rOZyqYg==
=oGaJ
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--

--===============7325235155764897626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7325235155764897626==--
