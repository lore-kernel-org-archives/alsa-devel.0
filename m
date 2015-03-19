From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: acpi_probe: fix error return
	path
Date: Thu, 19 Mar 2015 00:57:03 +0000
Message-ID: <20150319005703.GM2869@sirena.org.uk>
References: <1426694498-10811-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5363198935051554617=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C361526051B
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 01:57:08 +0100 (CET)
In-Reply-To: <1426694498-10811-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org


--===============5363198935051554617==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F7w+4yMapWozG0Ib"
Content-Disposition: inline


--F7w+4yMapWozG0Ib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 09:31:38PM +0530, Vinod Koul wrote:
> Fix the sst_acpi_probe memory allocation error path by setting right error
> code and initiating the cleanup insteadof just returning

Applied, thanks.

--F7w+4yMapWozG0Ib
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCh7eAAoJECTWi3JdVIfQK+AH/0vzAB3Sa68RiYgnXaUu9//P
1y1JYMMihaJplIXlxIC3eh1zMKkga95ht+aC6tXFMGuMDwiLBDt4Q9Wb0T+Qq8pb
m4Jyn9CR+FE8bkKD/SOxsMSAh8B/vZfSQmyMFrpH0RnA6xYZmPlVfTRR0z5KIX24
O7spkJW+jEqRc3nLVD8uot1G/YCm+uUEw8vDSe2B4FPObLOsQ2b6ymUCVe9RjbZt
rN0a6JADt+4JekIjOmZ33TY+B9i0P2YAKPiQ4YoInTZTJGKSOs5RljL2/mreL1Du
5Iusf9awKzbz7QjqWYuqb41iU+tTJ8k5tWn2R2rQrU7tueP0YLxaH7vX4S3ocws=
=LSg9
-----END PGP SIGNATURE-----

--F7w+4yMapWozG0Ib--

--===============5363198935051554617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5363198935051554617==--
