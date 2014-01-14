From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: codec doc,
 tlv320aic3x: Add tlv320aic32x4 as compatible
Date: Tue, 14 Jan 2014 12:14:26 +0000
Message-ID: <20140114121426.GB15567@sirena.org.uk>
References: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
 <1389448111-17064-3-git-send-email-mpa@pengutronix.de>
 <20140113123721.GV29039@sirena.org.uk>
 <20140113131828.GC12183@pengutronix.de>
 <20140113154457.GY29039@sirena.org.uk>
 <20140114085019.GD12183@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5604125756260761301=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F7F52616FF
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 13:14:34 +0100 (CET)
In-Reply-To: <20140114085019.GD12183@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============5604125756260761301==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 09:50:19AM +0100, Markus Pargmann wrote:
> On Mon, Jan 13, 2014 at 03:44:57PM +0000, Mark Brown wrote:

> > Or you could add the compatible string to the driver as I suggested...
> > I don't see any reason for the device not to have a compatible string?

> The codec is not working here at the moment, so I can't test if the
> aic3204 codec is really working with the aic3x driver.

Why would you add the compatible string to the aic3x driver, there is a
separate driver for this chip?

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1SofAAoJELSic+t+oim9JNoP/0gzU/d2CsqiEVuOqS2xuIVY
GP6ePPxXLt2RCweEgUZKW768aPyHHR+/bbPzS8gF+1ylMes9vLPKWq6Yn9jEUKU9
J8s+fLkiNUVnqWGb+NEN4aimb7xkKOa7d7fKNqc3DbOMU4NkPtl6KhGNurzR6W2E
PIpY1iZ5exbPt2QJRBT8kkOR8A10C2CKFkldTSzThWAgpH0z9+xnnbWgCEHJ9i3C
MijgMz/L23eFnkUN5aZ0DjRbcwGEXfYdJ7bKY1Y0YNmcqhM44TWEqLdDm6lla/ia
jPGp8F+VL+MHVFdrHrqf/GWj1SY2ovPBo5jCT8jAfCLQ0kGjNc6vzlH/qL2jbIbk
glyGQN5ESt/7QrlilUGvIPOlkr4ph7Oe4bTAE97CXqtyiNAmffJwGgBXtLOE7l4L
5xbf10kHoAIk5ugmN29QL59aGzXaMuWV9U77oQ3UBcowWlx9UUNxlMWOnSJe6yaH
SeCZs6c/GZ+f2aHnRDlXfx612Ya2w1MNFQdvi45ZtLk6nDfDfnBHPBuU17O/BFie
qEmV6F2+bRrKR2sz7Jm/V/igLOJojwkJEqwN9Z118OdcgJisQqm28nkIrekuJ8xd
h2WcYXzYIksB3I7+5xbXlTEqoSHfs9oy83eXiHS2SS1grBl78vTvTQx02nDCtXZ/
zRaoJ4DRz4ngoy3l8LQk
=voK2
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--

--===============5604125756260761301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5604125756260761301==--
