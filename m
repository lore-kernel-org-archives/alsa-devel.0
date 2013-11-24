From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Use SND_SOC_DAPM_INIT_REG_VAL in
 SND_SOC_DAPM_MUX
Date: Sun, 24 Nov 2013 13:55:31 +0000
Message-ID: <20131124135531.GY14725@sirena.org.uk>
References: <1385141358-21956-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sT0SRK93LqpGW452"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385141358-21956-1-git-send-email-swarren@wwwdotorg.org>
Sender: stable-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, ac100@lists.launchpad.net, Stephen Warren <swarren@nvidia.com>, stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--sT0SRK93LqpGW452
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2013 at 10:29:18AM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> SND_SOC_DAPM_MUX() doesn't currently initialize the .mask field. This
> results in the mux never affecting HW, since no bits are ever set or
> cleared. Fix SND_SOC_DAPM_MUX() to use SND_SOC_DAPM_INIT_REG_VAL() to

Applied, thanks.

--sT0SRK93LqpGW452
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSkgVQAAoJELSic+t+oim9HJAQAJbqWebgSS++XbX7cUEBpx8L
1SNtEEKq+uqJeK3c11gXTvczl0uzHpGzp8/d2crx1Nl56cVdtecKzV74Reg9l6bS
ssfH51qWbRS3Gyka9RicCk8xZkQ9sfDKPufMO9odj0iDiRyrICfCho6RLtbn7zJP
GcAOJdUxSFZKwbdCZdQ/yv1ASoYSHmk5lXd0DiXCmcTCoKjATXHgr8sKlE7uyXM0
YxrngVvKxfLG6EukrJrzTwTIzLATxlNHjwyQXg5wkwpYsbug6MnlpYu/peHKaqpO
MCObknja73V//O0vtKYwrPSzx7jlayO/ZOqYpkWpcimJK7XTlbINKYMt3XDbLaVy
ON/m1wg/anuPzY9LBEsKlFfVqeQGr/rgR63WiyyaPwsih0L9O074n8Xrr7pjuXpZ
D/5FAvwVhTJ7Cg219u+tWUPHdOivmMdhy2Nq6/HgEZmla9W1TNVTIX7LEQ/NPhz6
CtaO1d3VCI85uhOGPRVrUunra6U//8Du/KWsvKbbusXEwxO6iWAdh3KExG8DRvWU
frzm2Rgl0pf5ZPq7tFNWgmvdJ7WZFTN3VyXXBcuB65+1JYQCa6va1jNCv4Zi7EvE
XB+yIEDdaaqg7ZfpSWY1d64jky/4Jf89V69AIAjIFcJAgbbEQB0+ihQZGOfFdLzH
Dzsh+3ZT1wUHc9Nx31oM
=BiMh
-----END PGP SIGNATURE-----

--sT0SRK93LqpGW452--
