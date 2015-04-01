From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rcar: mark device data as constant
Date: Wed, 1 Apr 2015 10:28:35 +0100
Message-ID: <20150401092835.GD2869@sirena.org.uk>
References: <20150331183509.GN17728@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4551705920871235078=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66773260434
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 11:28:43 +0200 (CEST)
In-Reply-To: <20150331183509.GN17728@pengutronix.de>
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


--===============4551705920871235078==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Riir/E7CkIHPALLv"
Content-Disposition: inline


--Riir/E7CkIHPALLv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2015 at 08:35:09PM +0200, Uwe Kleine-K=F6nig wrote:
> A driver's device data should and can be const. This is a follow-up on
> commit 33187fb4a203 (ASoC: rsnd: constify of_device_id array) which
> marked the of_device_id as const.

Applied, thanks.  Please CC maintainers on patches and try to avoid
CCing people who aren't really relevant - the latter helps cut down on
mail volume.

--Riir/E7CkIHPALLv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVG7pCAAoJECTWi3JdVIfQJ/kH+gP1PTxCuPw1MU1VSHsND4lf
v6RK69Xcq/CDKOHW+E4nsd4NPe207mJk7Xk0ZHa/ipEJd4CXaTOC0Xmm33lpn4kw
ZmGgziPW3AhAbd6iOFPQqDaR19kbhY4QbV1xymK2JTCknkEALQT63PduvURlSley
IuwgbVPdega5j2rF4QhMkegqwvllBDdoJ0wp6bVkjhXSEWA3A3Qfu5LA+ym8OzQo
3AhjDCtc7kaQjKShDzhj7OG7H+SOb0oJTPkqi3s96a+Cqw9d3HEKWFB293lMT2wy
CyGzpsuiIZKWUYYBLFQS1c9zk/tlGfJHCDB72i4mV2mQYS0CiQ828OZr9BObSqo=
=QRHM
-----END PGP SIGNATURE-----

--Riir/E7CkIHPALLv--

--===============4551705920871235078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4551705920871235078==--
