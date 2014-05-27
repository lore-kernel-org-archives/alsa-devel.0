From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: Add ADAU1X61 and ADAU1X81 CODECs
	common code
Date: Tue, 27 May 2014 20:55:53 +0100
Message-ID: <20140527195553.GG12304@sirena.org.uk>
References: <1401180801-21260-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6894953671193936807=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 916752655C2
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 21:56:09 +0200 (CEST)
In-Reply-To: <1401180801-21260-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6894953671193936807==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jERkFme8PHY03Jz7"
Content-Disposition: inline


--jERkFme8PHY03Jz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2014 at 10:53:17AM +0200, Lars-Peter Clausen wrote:
> The ADAU1X61 and ADAU1X81 are very similar in the digital domain, but are quite
> different in the analog domain. This patch adds support for the common parts of
> the ADAU1X61 and ADAU1X81 CODECs.

Applied all, thanks.  We really ought to be able to get simple card to
be able to set up the PLLs for the cards but that's a separate issue.

As ever please try to keep the lines on your commit messages a little
shorter.

--jERkFme8PHY03Jz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJThO3GAAoJELSic+t+oim9eM0P9Aq55rQlwaGdI/sW65XGMbtH
mzsGuwmAPBWkyYSbmJJInbBu1JfUFxR8GHV/1lKiAtYE5rxPj02iSO+9mbgzlQKQ
m8ZwnscL3Qowi/9xRNE8/Y6IpCsJXvSiVv6X3r6zrrGTR/rppd4l9woysigHllQ4
pM2cncK61gnwIziQBCf0lSY22VW+spqEowLOMKIscPrOg6rRRqOglyIsKRSJjJuU
T1QCPiDlDaweRyARQcSXAJ4gkhAe9wzpW0eEAjIXz00bIoq6hkODIxW3+MVvj03l
g89yCj+fi//W5Fw8n93fiX8YR4BKyLuH5SLTsNVTpjF0bjAos8Z7Spud20GY/VEU
+yoziVes6FeQYyCefVoj2CVA/YBOa/zA5OxDGOs9tNOba7bY3ASLOsCrX5xADaXX
Rw9FqHZEdJJ4h5Qd1SZQzS+LVjU2n4tJz0of6bh996qH0ps3Tc/M79bCRoEAl4u6
9K1Ime5uNDqSq1dkDKVxMFFzCra/wZyqYz0k0uvMrnfpw6migwBGCutO20kL87tC
UMrCVX2rqZA0lug8toAjjD3HM5X2B6eXrA7Mfd8c2NHzxR612Qa3TfUKWYPrbOgW
rkZVHCERM0/pWPjaAVwJKnEyoRISwsKH+wBPnQnVY+J+wNURSmZlXjnLNO6KoSfP
ZXMeGcoi0h1FI8SEaRk=
=B0bD
-----END PGP SIGNATURE-----

--jERkFme8PHY03Jz7--

--===============6894953671193936807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6894953671193936807==--
