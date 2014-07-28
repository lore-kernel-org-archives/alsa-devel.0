From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: pcm1792a: Add controls for
 output invert and rolloff switch
Date: Mon, 28 Jul 2014 17:50:14 +0100
Message-ID: <20140728165014.GB17528@sirena.org.uk>
References: <1406550409-13798-1-git-send-email-michael@amarulasolutions.com>
 <1406550409-13798-2-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4393273207374787377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5912026516E
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 18:50:24 +0200 (CEST)
In-Reply-To: <1406550409-13798-2-git-send-email-michael@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4393273207374787377==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNq+AlMPkIk0SE/N"
Content-Disposition: inline


--tNq+AlMPkIk0SE/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 28, 2014 at 02:26:49PM +0200, Michael Trimarchi wrote:
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Applied both, thanks.  One thing:

> +	SOC_SINGLE("DAC Invert output Switch", PCM1792A_MODE_CONTROL, 7, 1, 0),

Should have been Output - I've fixed this.

--tNq+AlMPkIk0SE/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1n9DAAoJELSic+t+oim9+hUP/jCTfyy3WTtzdOTitgJzWJlk
KxeIfS+KQZTOjOqkGH5MR1znGQbDPQHtNSP/MakL9KC23l+GiD8/WDnqhQ4ZTjBS
wZy2ccwr/9S/QbrBjea9DmQVZqhPz4ePNA2Qdpsj1dGnqtw+BE7f88Jt12Lvyeyr
tE/C+kWSWAO2jO2ptZbM7hNVCPECoPdcZHDaIXtrjAzlQJV/7IpGaw6CINt15kDV
/bdd8lNK7dvhmmiOVk7Zrp6eUBuIkz5xI0zCuM1TA3G179qJWmCpxwIiPAg+NQF8
IWMxsRZhqmCQemNBhRPPAKsl1hVo4XQ7kCLgnrUK2Tt8c9uHXTX8bUCCmx9Xv3pR
/oG+AutVazXAQMaBh76+NuUu3kUxhCJIPEik+0gy+2dHvhcJ8ZwOVEUw99qTI4gU
XtWrXjxhaNWGWfiBo3TvVyV5LM4Gkgc4VFy/MaxYr8t18EKV7Mk+qCrQ/AUC2PIl
LTI5YKppz7lXcgOYT5s2AAUezowejO4OsUNL8FupgKoGNwKjsBpOK5tlkEtMajfp
8JUoHl05PSlOSTD7fSfeFwgyKOfQfa95zOtv7aOwPs6/+/6E5hqDihOy0HxyVXaD
ahLTP2zZkbEdYh4zWHuluunFK/Dmaq7aroSc8RN7u/WK4m7PJjhO8xao3gNBvWou
onqqbcvyFEHn7AZp2zc9
=nVwo
-----END PGP SIGNATURE-----

--tNq+AlMPkIk0SE/N--

--===============4393273207374787377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4393273207374787377==--
