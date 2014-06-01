From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aci3x: Fix custom
 snd_soc_dapm_put_volsw_aic3x() function
Date: Sun, 1 Jun 2014 11:43:23 +0100
Message-ID: <20140601104323.GW5099@sirena.org.uk>
References: <1401457661-2994-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8402086281259796741=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B882261A49
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 12:43:43 +0200 (CEST)
In-Reply-To: <1401457661-2994-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8402086281259796741==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4nn+A2p41ba1mxGd"
Content-Disposition: inline


--4nn+A2p41ba1mxGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 30, 2014 at 04:47:41PM +0300, Peter Ujfalusi wrote:
> For some unknown reason the parameters for snd_soc_test_bits() were in wrong
> order:

Applied, thanks.

--4nn+A2p41ba1mxGd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTiwPIAAoJELSic+t+oim9QXMP/3rwxr1Owq/KITCRNgQJHNNX
qlGv04Qv+9fYTY/KDAYGfo2eW3W+OEWaRZxxKhOJE3Jbf6P1gdgwQbErKkOU8XM3
1df+JvQ3L6CAhiWuOscLvfmV7bVivYmdnN3v936L6OAC5/P+1I5wUyrPPgh5vYFd
SEMSgJvPHojowfSYFcpNlCLm12pk0/s1IH+7M5SPezzqvsuL20gIAPMsr6WDzIHr
kNBWFqzkBnAvCPue071XgXTWAKjmWYmXIC1nsL/A/juW0bUH5Gity+L0S5dsdBfB
RJhLcVPXfWQdFqr/iPH/NZbgY/hV4uGx2NW0QSFmhd9IrHTnd1ZzYuj5nW2txAt9
xqjuwdSR992Lj6PpgwwOCqc7mAQZQOkLGbKQZfY93sYLB+nmPVCAzVZLouLmtC5c
7CuuwB3nbGPAKCKIQKj15c/sposHmQBMU4iLtXQ4c98OX/bfXbp5eu69KCB2zEWc
DGYLakWuouWvuu0JRU/9vUe8kaAJwqtnhoMXQUbN+yifJpXZoygEdbj26hJxwQwG
odGdrAHTFgcTHEb+Lvg3hmguzazHrLxY9lYHeyCKAvNuvHHoFaCWSS1yh5BgjN3X
+QDJvO+0IlEY7MxoNL5Jz0X92lKaHkLDbBn0ONyJ5aHxHn6UTaGlM8Zx6A8ozpjf
XN5psSZQIBKrFOoXcIrF
=rs3L
-----END PGP SIGNATURE-----

--4nn+A2p41ba1mxGd--

--===============8402086281259796741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8402086281259796741==--
