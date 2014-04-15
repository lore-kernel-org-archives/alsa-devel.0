From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: alc5623: Fix regmap endianness
Date: Tue, 15 Apr 2014 14:21:50 +0100
Message-ID: <20140415132150.GE12304@sirena.org.uk>
References: <1397565425-1746-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2923110544238588118=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 61A512650D4
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 15:22:05 +0200 (CEST)
In-Reply-To: <1397565425-1746-1-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>
List-Id: alsa-devel@alsa-project.org


--===============2923110544238588118==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rZRBnaF0gvoyXYbn"
Content-Disposition: inline


--rZRBnaF0gvoyXYbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 02:37:05PM +0200, Andrew Lunn wrote:
> Commit 0cd257bf9b9b0cbb4fa1a5c988a232506997867c, "ASoC: alc5623:
> Convert to direct regmap API usage" broke probing of the codec,
> because of wrong endinness of the ID and codec version read from the
> device. Fix this by removing the existing flipping of the endiannes,
> and extracting the codec type byte from the word from the regmap.

Applied, thanks.

--rZRBnaF0gvoyXYbn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTTJrAAoJELSic+t+oim9jb4P/jxyKfQwaKfwUvpt7Dq20p5R
iErCrmrPQYg42Id7NxJmOfDp3MzC560aPgWkcHr1iWOxWO8p45qZKnqSuCvXIRYE
WIIFgL4UboYweEjHz/fFsRuzoe7LfiPKoxTMuFa/bFlNNA5yxiu0h5BdB/60KkK/
bc7tG/pCnGyIvfqdBRFx/Mq4GcFbS3q578r9q1EMLvDvaWxbFnYhtWwARiP5DMac
AyJrqmThVKu1hAvd+F+CWG2kYfX471wljHqXz08EiG+NGJo+slWD++0NWnPD46N3
gDtAy1gz/T8auDqbljGwo6RisC4ZHbWKqOQSbl6KlcLL5d77V4CJ2mqUmWUxQCh0
HkklfQTT8UvuExuLZMxjSMF9NdJ5hWZWgrsTVpvsD+B8x2Q3xGVbkMXM98g0epD8
IKwc+oAbfIy5vfGLI5qJ+Kyge9MShUEcNLutsMaF5Yjg07xTe7XWCyoGYDOq6Rus
51lDq5FhdMwVObo44oSUPMHgnHUUspI2GuwXiqXES5ZWiy2D1vaLmCU/KlOwV+Jc
CXJQoau7ekrstO8976wO/qxifd3joTNp2B2P6IrqBpycYgyatad8mQ6poshFlZaL
VYjvzwxcZkp/6ZPCnaeBhzDCzar084NkQOEr9DK857Hmn0Y0EC5kzN00SgYFGV/8
dzHzWP3JZB2cXpq8QnSO
=zzsB
-----END PGP SIGNATURE-----

--rZRBnaF0gvoyXYbn--

--===============2923110544238588118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2923110544238588118==--
