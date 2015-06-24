From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: gtm601: Fix modalias
Date: Wed, 24 Jun 2015 11:23:38 +0100
Message-ID: <20150624102338.GF14071@sirena.org.uk>
References: <1435114524.2082.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5599830662807097081=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C16D260536
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 12:23:55 +0200 (CEST)
In-Reply-To: <1435114524.2082.1.camel@ingics.com>
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
Cc: Marek Belisko <marek@goldelico.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5599830662807097081==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rEeQd2vQToB/m911"
Content-Disposition: inline


--rEeQd2vQToB/m911
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2015 at 10:55:24AM +0800, Axel Lin wrote:
> The MODULE_ALIAS needs to match the driver name to make module auto-loading
> work. Also move MODULE_ALIAS close to other MODULE_* macro.

Applied, thanks.

--rEeQd2vQToB/m911
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVioUpAAoJECTWi3JdVIfQKacH/A+dFW/Az/8Jkl/OM5jPpU8j
CQjV7bfcdtYnJ/sH+08mRfStsETUOkp/7TzETDgCn4C8L+uY4o98v8rSRqEPrKYr
ByFc3uUdbm6X1b7upSa+xi0h0RajhjoQfgsuth6VSQ60OesP9KpvKzbnZJw8trEG
n+SwiZ5yc7mLqR9Jmel/1b25JuPiHsO0KXD0fqxGXQxcdinFh9Se+GHhAINn24wx
MmjUz8+XguqsiWrMY+qTiymNcB8dTG0XoQ3konjX/USDsuQuOxdZ53p6mQoJEBWs
tZvfcefufjk6v3oMYXzKlnnt0RX/Ds6a6z0HIOyP7axbJOWPKRgSioRG3IVd6fs=
=Aebx
-----END PGP SIGNATURE-----

--rEeQd2vQToB/m911--

--===============5599830662807097081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5599830662807097081==--
