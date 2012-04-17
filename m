From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for CS42L52 Codec
Date: Tue, 17 Apr 2012 17:32:42 +0100
Message-ID: <20120417163241.GQ6652@opensource.wolfsonmicro.com>
References: <1334609938-11671-1-git-send-email-brian.austin@cirrus.com>
	<20120417111359.GB6652@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1204171040350.16471@heelrod.ad.cirrus.com>
	<20120417160703.GO6652@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1204171123200.16471@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4663013870285369563=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A8CD104359
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 18:32:45 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1204171123200.16471@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: mbizon@freebox.fr, alsa-devel@alsa-project.org, lrg@ti.com, joe@nucleusys.com
List-Id: alsa-devel@alsa-project.org


--===============4663013870285369563==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SvyA5ywaG/v2A5dH"
Content-Disposition: inline


--SvyA5ywaG/v2A5dH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2012 at 11:25:42AM -0500, Brian Austin wrote:

> I can move the Codec Power bit into PREPARE.  As for the Charge
> Pump, since it is only required for ADC, I can move it into an event
> for the ADC DAPM Widget.  Make sense?

I'd suggest making the charge pump a _SUPPLY widget instead - that'll be
less code - but yes.

--SvyA5ywaG/v2A5dH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjZr/AAoJEBus8iNuMP3d1d4P/1eWrGF151J62M6TMEU6kB7a
pqdNh8sG5GnbLmjmlnoIlYS9grYbOolDcELN8kLxHTRkKvHDx3I8hr/rU1o55zD7
iqPjLHs5K6OisplgNXK9tDf71Gm11bqyLyCwSuerUPrUTY0IOTtC2hWTiqOADAhS
z+jU1BBzltYTHORBOPgcX44cfZUmTm1T7kPbDVB0BzyBdJOANdSbUS6uGjRJoC2H
dIr4kfpdyCZX+XW1kkH2aPFeRvQiSqMcgRXA+QngMzhj4L+gqDR9clrf+AL2y+LN
Gnr6zWeG4L4JySIsrwVjKcVLNf1A+/SKQOSxOmb9vOUS2s52flDlAKMc0CEeUraP
y6kvIInXuuVlVow2XcM5RzsqxGeKlNvRTPI0iTrFe7YBPnu3enBMPD22h7dSZ5ZD
wcTmDlfrAIH3UXlIOFc5Pw8lq72tHGSNycgwG0xjRK/sPSRjU8t14PF8I8z41o2o
qkUcyMrJDJWJJWXePgq5aa7vxNN4bamuwJnU3sQnbPjR9DqWZD/enQg0LYSs7OBt
4DzrbLW3Y/acDS9auzgJDSIsLZa7ov340mVKuS5XR0/s9g0py+js5q7f0WGwmyqE
gn0Tpy1Mp63HaxDX6GxE2aVzyq5ampXawSCmYQnLHS+E15wPTA3ZCWYTxdc0O6kY
LhGo74CN8XnEvc/V30VP
=ZTvn
-----END PGP SIGNATURE-----

--SvyA5ywaG/v2A5dH--

--===============4663013870285369563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4663013870285369563==--
