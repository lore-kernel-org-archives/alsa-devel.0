From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: sta350: Use
 devm_gpiod_get_optional at appropriate place
Date: Tue, 12 May 2015 18:52:49 +0100
Message-ID: <20150512175249.GK3066@sirena.org.uk>
References: <1431184113.5393.1.camel@ingics.com>
 <1431184172.5393.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8095064795611573134=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A33265888
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 19:53:02 +0200 (CEST)
In-Reply-To: <1431184172.5393.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Johannes Stezenbach <js@sig21.net>, Sven Brandau <info@brandau.biz>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8095064795611573134==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aziWXe2aaRGlkyg3"
Content-Disposition: inline


--aziWXe2aaRGlkyg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 09, 2015 at 11:09:32PM +0800, Axel Lin wrote:
> devm_gpiod_get_optional is equivalent to devm_gpiod_get(), except that
> when no GPIO was assigned to the requested function it will return NULL.
> This is convenient for drivers that need to handle optional GPIOs.

Applied, thanks.

--aziWXe2aaRGlkyg3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUj3xAAoJECTWi3JdVIfQmyIH/0qIxtBSLGx6ugeQEv/NbpxF
BKCf1a6gs691wu7wyCsofF4/aenzO0tNQdRNMLg0xtmdX3jKfiQ+67k8Zj2EGoNd
pbNk4AawmUgHcQHeaBkZ2TLIGITyLPWReHpIFKBvl9RFSXQek9xZJPk1o9MQzHdZ
yl7iPWwsRZnf0P7GRBBEWEC7KWe+6l8sRdvxzV2ie12YhE+OZUb11MFsobGlPZrY
SZRUvZ0YN2pwwDfAEnTq5zFnIqsIun3A+/RuJXktBPBx6f422j1mrzE58gyDYArD
d0wqyDwb+VusIv2LHKGdtgXOf0lmdUaFwqdw3c8CdBC9qvJj/ZreQlYUWebV334=
=nuOe
-----END PGP SIGNATURE-----

--aziWXe2aaRGlkyg3--

--===============8095064795611573134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8095064795611573134==--
