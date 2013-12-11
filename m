From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dmaengine: fix deferred probe
	detection
Date: Wed, 11 Dec 2013 22:45:51 +0000
Message-ID: <20131211224551.GA11044@sirena.org.uk>
References: <1386786050-4846-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5382396991207185140=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 91C69260307
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 23:45:56 +0100 (CET)
In-Reply-To: <1386786050-4846-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5382396991207185140==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 11, 2013 at 11:20:50AM -0700, Stephen Warren wrote:
> Check the return value of dma_request_slave_channel_reason() to see if
> deferred probe happens, not the variable the return value will be
> assigned to later.

Applied, thanks.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqOscAAoJELSic+t+oim9ykgQAIQfwOLSXwMHDlQJ1TcezSOb
dq15Xzk4Akt0nLP3p4CofQsRBQ603aXRGNYHRh2axgolvl6y3Ic2yIcvUxGyUvtp
GNOQMqwoAF0N8aOQLxKQGElzqjPKA8QzYM8ApUNyjcMEWQQ5IyvOZ12OVHsxaAcN
TNm6prIM21fO7WI6NH6KkWsz0NPcsds9xsUrE+6iVXkjtpKIiJNajJzzCfiFIaKY
pdXtzqFAvEfZqJrli4KjgJ4/mSXfFTU26iNP4rbw30g2/y/gF6h/JA9ya6cq8jOT
9FYt2hqw6g+t6e+khnsWrdDaC5ChbFcfYCH19B7I1MTTJKLDrq7Je6SfXZkZzDWi
5S6GyxoJw3HBmCQVvdY/h0r7bDF43TywMU+9wbhLg/HZZFTtD0ZfQOXri+GVfJrt
HNvO/nj67ho5GGIL8UpSamVJC9krIpb9pzfr+dVYQmBt3VL074dwzG9cPGAY7Osh
Q/wk13pIA/PDzotXnK1O5lBQN3DAVZWQWar1GX2fV1X3tROyri/A7d9OUUh99v4W
8XFwyNCWjoDVjRiNgYBg4zCxt/Av5ZqTMajDee+PJOt4w9MDdGagF8Y0xqUBzGy3
1QVjWyb9we8NzccEQCw8KOelL9aiBqyYB7a2jTD1km9E9o5OMuXed+Ilbf0lUnia
gXXHw4IABilJ43mOhaOh
=8zIL
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

--===============5382396991207185140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5382396991207185140==--
