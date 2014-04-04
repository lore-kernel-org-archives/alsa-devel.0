From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: cs42xx8: Check return value of
 regmap_read and report correct chipid value
Date: Fri, 4 Apr 2014 11:11:45 +0100
Message-ID: <20140404101145.GP14763@sirena.org.uk>
References: <1396580675.9690.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6510334525005236886=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B39A2265795
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 12:12:03 +0200 (CEST)
In-Reply-To: <1396580675.9690.0.camel@phoenix>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============6510334525005236886==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8HHeiRpSfOSMcPVo"
Content-Disposition: inline


--8HHeiRpSfOSMcPVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2014 at 11:04:35AM +0800, Axel Lin wrote:
> Fix checking return value of regmap_read().
> Also fix reporting the chip_id value. CS42XX8_CHIPID_CHIP_ID_MASK is 0xF0,
> so the chip_id value is (val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4).

Applied, thanks.

--8HHeiRpSfOSMcPVo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPoVeAAoJELSic+t+oim9cF4P/jMZ9YmMchIjDIFmBo2PI6gk
YHINquHyrDjphpcIA+yc9/YSNYBsoed0wJ2arrhXZ0z8h1cpIsH2HG/F16cV/2G6
AbEqDwkPNQqHKWltAV7GHgisqNwVB++xI1nBDt70aFKEE7Lf0YF8YHR5CKNdpTl+
TJDvJ1f6ZAUfSPkp9iWAHt1+RjPZkcJ9pWC7CLvKijYTTyC6XxH8XARScTxPwdg4
9aNih6Mi7DgDYLDwXXy5J0Er/2LU5sQuQ9p1gSfm/DxGly9ECBd1RSS3ba92FqHz
ADguD+qTI0FehektlkvzCXH9Rdy74vE1TeAWjjZxEte3iZCwwnUzN+p6I4nVnxld
PgtudHGEdqH7648rNYMrGg/y2E2/7Nf1bQYrzP/hAY4xNBOBE+FtxGhgwS6CGNxs
sUzZvp6IwINzEkFvehHY27AJ/BBuLZULb+vr6lA68UGeenc5yUjmnLLzqQyH712G
J+DAY5oRl1wC9434Tt+Cd2hwZKwV5LDOInahFcs8ps94l3kWUW4asQ80dcjhtZ5F
CZdlZFIZhkicvb4YtBCnEWJDpi504AL9BsCLBTubGefBVjYnu3NmIgbNp9tYpLoa
yBt04ifLkrPOVR5VmIQtOaXAGNP9ohtDbD9ixF2iizAkeVeR7AyBPQeb1Mh+4s8C
D72DpmeIePfyB1gAaDlR
=MV+G
-----END PGP SIGNATURE-----

--8HHeiRpSfOSMcPVo--

--===============6510334525005236886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6510334525005236886==--
