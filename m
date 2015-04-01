From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: fsi: mark several data
	structures as const
Date: Wed, 1 Apr 2015 09:31:38 +0100
Message-ID: <20150401083138.GC2869@sirena.org.uk>
References: <1427813339-23817-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1427813339-23817-3-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4923253254810613141=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A5DCF260504
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 10:31:42 +0200 (CEST)
In-Reply-To: <1427813339-23817-3-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Fabian Frederick <fabf@skynet.be>, kernel@pengutronix.de, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4923253254810613141==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RFEIu7IXk7DkrcNw"
Content-Disposition: inline


--RFEIu7IXk7DkrcNw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2015 at 04:48:57PM +0200, Uwe Kleine-K=F6nig wrote:
> A driver's platform_device_id and device data should and can be const.

Applied, thanks.

--RFEIu7IXk7DkrcNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVG6zpAAoJECTWi3JdVIfQx1UH/R55BNqXdt7poNaH8xGrK5X/
E6eKDCx50uzRHqObnEk+o0eKB7JFqKyU+eGqb+wv9RLB/uePOg2VXy84CIhk0wHV
orGqNPQftY6jicLt9JvO/ppi4Y0IRojSHDakXYS5rgEhg9rprUJcwZSqwUt2hbHK
9JCv4AzZfGQyj4jU55TeWySF8UOuA/Ak2Py1dfIOtotKNVxzU4YbfgUZcHYWA9XC
w4jsWWJ5f0GCwf8RVpBRmCi4GWSUhNIaCwhGdaExn+2Ou+0qUf/0yrVCmob0T82o
REkwYLJE/5lvor2v0nXv+S88h0ua81dOMcuEbOfbaCDQ0de98RgnJRf+S6wv5bo=
=GovP
-----END PGP SIGNATURE-----

--RFEIu7IXk7DkrcNw--

--===============4923253254810613141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4923253254810613141==--
