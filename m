From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-wm8962: Delete unneeded
 test before of_node_put
Date: Tue, 7 Oct 2014 19:17:10 +0100
Message-ID: <20141007181710.GX4609@sirena.org.uk>
References: <1412705605-13646-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3179222448613191027=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 714A12604D0
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:17:32 +0200 (CEST)
In-Reply-To: <1412705605-13646-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3179222448613191027==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMGrAD5L3cjpiKtl"
Content-Disposition: inline


--eMGrAD5L3cjpiKtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 03:13:24PM -0300, Fabio Estevam wrote:
> of_node_put() supports NULL as its argument, so the initial test is not
> necessary.

Applied both, thanks.

--eMGrAD5L3cjpiKtl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNC4lAAoJECTWi3JdVIfQOqsH/iJBzMLcMb4rcA635j3ynrSG
1SS5VaY9A59YZug2nU6WEkA7zCoM3JIVb0boFnAWoIQqXeC/WM64i1EesayEiUmD
xLmUn9uiiZZnfkFPxM6p8E6KN7MnElvOohD2OGt4JRbHAQvjZNoRVyDxw8fWU6N9
j9Y7yAkUzfwub6//nZQn+x+3SuyOEPBLODUMa3vUYf0bsiY7d+HsOTBh6rdvHGMB
V6+d7Ki2Y0S3WOnUEAulxRAXrPnfZEyQuc6tJeRwNMhsSpv+TPec4K8QGhUJdE9m
s0UIh3hk5H5KS6rgXCfqfr9DHuV5f6rpdXHUxHjP9B8/47G9J2J45sJfOQMNlzU=
=Xs+a
-----END PGP SIGNATURE-----

--eMGrAD5L3cjpiKtl--

--===============3179222448613191027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3179222448613191027==--
