From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Don't try to round-up for PM divisor
 calculation
Date: Thu, 5 Mar 2015 12:23:38 +0000
Message-ID: <20150305122338.GM21293@sirena.org.uk>
References: <1425531904-3770-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LG78JIahM5DeOoET"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425531904-3770-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: lgirdwood@gmail.com, timur@tabi.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--LG78JIahM5DeOoET
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2015 at 09:05:04PM -0800, Nicolin Chen wrote:
> According to i.MX6 Series Reference Manual, the formula to calculate
> the sys clock is

Applied, thanks.

--LG78JIahM5DeOoET
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+ErKAAoJECTWi3JdVIfQb2MH/2l6/eoNVtJN6skqHfypyrDc
bKAlhWBDGZayYBi7fH7xWLNXGKaLf8PHXqCHzB1qKojSx7HRizsPHY5d6kDB9Cp1
fWZSfeYrlZxQZHanss2FBfJB3MVQcOAGMT3finWFFivKK7WIqfSY78eEN3/O4/Eo
GK69RNthkUT1EXHOdJu8qEfn3pXB37Yyt0mACi35cHRDDOM28wDvZv6G+/hNWxHX
Rkn5Qh/lQ1et8Cw49NPeMSolfL1c7ZioXqq95C1S5JLTEkOic6h2V1YKZUA6lHbn
ZtaNZ44Ismg6iA9vd5KZbUH96oPwApArVQJ1gy1kyPwZaXkm3tfbpcd9zHX4+gA=
=4jJP
-----END PGP SIGNATURE-----

--LG78JIahM5DeOoET--
