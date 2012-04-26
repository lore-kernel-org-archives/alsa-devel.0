From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Use devm_clk_get()
Date: Thu, 26 Apr 2012 10:25:07 +0100
Message-ID: <20120426092506.GB3207@opensource.wolfsonmicro.com>
References: <1335414802-4972-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7434877703411067019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA03510B9F5
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 11:25:09 +0200 (CEST)
In-Reply-To: <1335414802-4972-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7434877703411067019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2012 at 01:33:22AM -0300, Fabio Estevam wrote:
> Using devm_clk_get() can make the error handling path easier.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

This is fine but devm_clk_get() is only in Russell's tree so it'll need
to wait for after the merge window - can you please resend then?

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmRRsAAoJEBus8iNuMP3d52UP/RimHh8GAolqdKGGchnyy5tU
PiURsoAhmFRetWBJDRM8+5cVcmI5mR5Sz6vnilwyqqs7CId7iW0yNIj2x3Cr4qYw
R88vjUR+AWlf48bVQDSlxWf4651eVVCNVUi7sj+3KZI7j7XxIlfFgA7YumzkPJkf
05fDTz9DPwlfLWHfUAV4EvfCndjO5hQdEOvodTtWc9n34/gNlPj+gqafqZTpu2an
NvF8/QEjGaH6WcIYBSG/xDs74MMVTHpruewDccS+lpcA6wCddT+sRolMZyMyw4ks
pv9zKTxy03u25OFyrWnhxKDdBybZyFlrt0lJ6b+xnbs9l80MZdtkOynYftKIVlJ+
fGtOBsOC5nnoAMU34EkDrGtaItAzc77wfFq8IsRQDw1MozJ5EQ3bU4U0Xc1VxpsC
6J5RnKdfIdKVw/i5NrYGocFtbVzGnGi3KfJ9BuzfGZJO5g6SXPFkwi0JGnmDyRUD
g4ywhGggjiTlJFIp6ablCIi2w+4B4m48hKVa0AM0TwWeKOb0pm39smB/aWZRQY6S
p6kOTqeyce9u9s6dLLmJTnpJKRve0vQCMKuiLWsSyX6vQ3vnzM+ZI5W6XlDYl87m
V5pqTl6hCJyksTqYnGBQpRBji5YszKrS+78e1ZjIkitQdktMkOMkuZ83B3+yLExX
aDe1LwApqRGziqFTFOhD
=T9sy
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--

--===============7434877703411067019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7434877703411067019==--
