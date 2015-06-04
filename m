From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 08/23] ASoC: tas2552: Rename mclk
 parameter to pll_clkin to match with the datasheet
Date: Thu, 4 Jun 2015 17:51:11 +0100
Message-ID: <20150604165111.GL14071@sirena.org.uk>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
 <1433423075-14142-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0643079808716805046=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ECC7626661C
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 18:51:18 +0200 (CEST)
In-Reply-To: <1433423075-14142-9-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org


--===============0643079808716805046==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RFt7YL+UU4NXVfbH"
Content-Disposition: inline


--RFt7YL+UU4NXVfbH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 04:04:20PM +0300, Peter Ujfalusi wrote:
> MCLK is one of the possible source for the pll_clkin frequency. Make this
> clear by renaming the variable.

Applied all up to here, thanks (not looked at the rest yet and it's
about the end of the day today).

--RFt7YL+UU4NXVfbH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcIH/AAoJECTWi3JdVIfQoPMH/iApvQIqhzsV/imaG4hiCut5
vMEH/PsCa+jSeRhrdaZh3R0P+DlwJ5Zez7OBVX3okuRwmWfEAJias/+4PM2ZfCw3
Ixiq4Oe1Dbh3PswA6eSP0ZRLtwe7pcBoBkph9bFNb+xRDoP60YgNgR/V/XTxi+eI
Pbu6h+QgngCEA6cbOV1sSQahYxB7M+Q1+PArE81bsV9AukEaKI+CXWo13Nnqa0LT
2+O5N7h2mIryYgHsuHfURNGlvc+I6eoRTXJM22ojESkgstex9eh4CijQfZQshQWg
Fbwa4q4pHNjVo+EGaZk+xz2sPqs0wU/SjFLP06v2lfX9JqfFxY8tgXFuCa5nTrg=
=s5jb
-----END PGP SIGNATURE-----

--RFt7YL+UU4NXVfbH--

--===============0643079808716805046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0643079808716805046==--
