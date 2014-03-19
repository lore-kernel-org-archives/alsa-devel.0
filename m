From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/13] ASoC: Add helper function to cast
 component back to CODEC
Date: Wed, 19 Mar 2014 13:08:47 +0000
Message-ID: <20140319130847.GH11706@sirena.org.uk>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5105798156329543132=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C91E32650CC
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 14:09:05 +0100 (CET)
In-Reply-To: <1395129736-11938-8-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============5105798156329543132==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r86TydpP7geXPb57"
Content-Disposition: inline


--r86TydpP7geXPb57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2014 at 09:02:10AM +0100, Lars-Peter Clausen wrote:
> Add a helper function to cast back from a component struct to the CODEC s=
truct
> it is embedded in. This is useful in situations where we know that a cert=
ain
> component is a CODEC and want to get access to some CODEC specific proper=
ties.

Applied, thanks. =20

--r86TydpP7geXPb57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKZbcAAoJELSic+t+oim9BRgP/io9qr/6bYguownxVwETPne6
8jq0FiJr4BJ9HL+BUdgpZTfCdLZEfniuITAIKt2svUJPpuIbUcuFCOxqqzrqp1wn
zcB4M/67C5dw7O4mfNvalzdOJ7S1TXMGJ6U/1q9/aKyA9ZA1aHZTJDVC7LPzQ+Js
5lJJ7+bYln7KW7PX0CahgmkoAFo7GCFHnjTQhOR9MXypSRWUWLH+TSVWEpjJm8Sp
XwujYf9BNgxnWBQ8e3Yn1DyU2yZBWG+A/e/soN0ZmEEA0+VSzWkUWNVFKs/ma79C
AjlY8yRqpUymVATxFJIPNEmZAMEtd/XjRIsMgSF4b+ISs76SkqeJBa4bKHnjcOu3
bmTmEqL96lCM8UK8tT6S+qvVK3rOosNv5nBD2ZyNb+wS4V1u7E/ia60F4EbjJoq1
KoeKBXMeoD2vS2ncLq+pN64gamYAl7gHHIIxksWVwaNSmCp6tdwKDdxhRtjBrU0w
Tmm+rh9rUUn6/ddqyGceXicIoUzdhC2a9qQoLbqAUw1a0osbswBWvRuD1yk0/BeX
mbHn95yMfaaOiudmBwVk/pHf9grhvjskPljxQWJRZx4dKX3z2A9hnfcai5fXownk
zvgmtJBbrWJM9g/9vPwOtDJ3YjQ2OARz9NUE/L9cVympspRB2EukKH8sgY2krRmY
zisppLQwLTgR1oSFwPGz
=a4rq
-----END PGP SIGNATURE-----

--r86TydpP7geXPb57--

--===============5105798156329543132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5105798156329543132==--
