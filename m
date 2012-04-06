From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2] ASoC: tegra: set a sensible initial
	clock rate
Date: Fri, 6 Apr 2012 18:26:16 +0100
Message-ID: <20120406172615.GK19424@opensource.wolfsonmicro.com>
References: <1333732696-10015-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1905481125774629132=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3940B104524
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 19:26:18 +0200 (CEST)
In-Reply-To: <1333732696-10015-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1905481125774629132==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TC23+W66xmFESAX"
Content-Disposition: inline


--6TC23+W66xmFESAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2012 at 11:18:16AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Initialize the audio clock tree appropriately for some reasonable rate.
> This makes sure the PLLs etc. are actually programmed to something
> reasonable when the audio driver is loaded.

Applied, thanks.

--6TC23+W66xmFESAX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfycDAAoJEBus8iNuMP3duAUQAJacSjpzxfW16Tlye0VROJLX
NNsAxWIRe7I09vTEbE2HlM8fD2LTlJIeKCdtBhyGvPoEO4eFfURVWMT35n7HTHPM
UDy4rm1V7wlpMGyiH8lYo0wPH86SKoE8PtzyNBcvodF0kr+Q/IN9tQAR+01sU4iH
+0KB1q6caRmPqt5/lSt9BkK+TcrBkhz2Z/lmAsSfBDUzmICV6kDwagcZDWcWFg1Q
lWDSNAqewdhVJhSghmoJnTn+je45wlc1lCcwtGbh7uxp8jz0rv3XRLMtxFv5JTRR
AlhShCs41Iex8d/a756iatPtiNLWJWSXGK9llx2M8osWzlWrYV6oErxAuDEKaccn
eUJO3rkzVSP2E5x0XicK15DI9+QAVHCrLsxQEyKuvwtgQivqT/X9dtNnbiSyE6jx
GwO+hhbOQVY/3WqRRXTMZVMODWHF5Kx9vveQ57ETBzqZW7YYAr4xDbyWfGHz0tvZ
nfwa7UZNQ9v4babtSLreGe1PNAiOMZ3kOef1KwCeGIMV3F3uW+VwHNlRLMeHHe6z
HjLRSW2Zfjpehz28LIw/jETt8RULeZs77LdZr5ckCl7gEl71w6vKta8Q8RRQGafM
RS3/LtJE1ul/IuBYR2QYxIU/AAtHX31LwIisYgdUUqXbeUxrCVIkwD5AamlHTmez
1ADS6KYiSVa1kwXyoEEr
=iB+K
-----END PGP SIGNATURE-----

--6TC23+W66xmFESAX--

--===============1905481125774629132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1905481125774629132==--
