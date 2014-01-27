From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/6] ASoC: tlv320aic32x4: Fix MICPGA
 input configuration
Date: Mon, 27 Jan 2014 18:14:09 +0000
Message-ID: <20140127181409.GC11841@sirena.org.uk>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
 <1390824190-18376-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8412490551619476690=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57443261AA4
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 19:14:15 +0100 (CET)
In-Reply-To: <1390824190-18376-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============8412490551619476690==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 01:03:06PM +0100, Markus Pargmann wrote:
> Currently the Negative Terminal Input Routing Configuration is only set
> when there is a special routing configuration. If we don't use one of
> the inputs IN1 or IN2 as negative terminal input, the PGA and recording
> does not work.

Applied, thanks.

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5qHuAAoJELSic+t+oim9yp0P/0Q1SIgkcOHyWMaEYkpDm6ct
KyMo8TvrQAg75yE/o4TAfJbAgDEoS66iABTHtrRgLNXxH4EPsEq0aPs5IEPjJMBY
jNKzxGBkPJmX0eUPAz6IhyCwHD2Cc0enityZO5myTWRWYEExpG91PvnKO7T3/XFq
WWzMCmeiNXXwjGhDlMu7dWvqMnnWSn+x/iLWQSLR8WdfjOt5R9gqmIfTANm+dLAO
jYXw/RuhtYivWLI0bRTNwlBxu3EekvLSuYelphWcYnAAdg0lYxIWOvY048gNvfJl
WfVNWhXfHR7EiiCLobKbmKta/IodW2pwWqioUhOTX02wzm1reZfftfzOz79BMi5j
Ix6g7kyLvP3Q5Skxb/IuKNndTXZdDujs+wtJzaOa5AZLLgurEuKl/EtT3YwtoF8I
aCam3ERkhEPB40bRHLqWE37skDa0/7/FK6kGIrwCSQ7nLIW6/Eohe31Gbh3oGQ1P
K5Ue39lKDrbfjJP5tGZqaKl5siDQzsDu5TX25Lx+CV7X9SH7BaKf04p1+H5Qi8ti
OwmIXUjym4bkEVPHCvPgYWrXmIv1nYYZdrRA8i97K9HvNzkBvAOx6sFxUb8/0Kcp
+5YTbPRpSVziRTMoJVz6jS+h5fhAf8ejv51gdmh8Xy78K0mlCZ3RffIdBnIj1kg7
LYkWLUSMIaUZodQwbxg3
=5cFe
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--

--===============8412490551619476690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8412490551619476690==--
