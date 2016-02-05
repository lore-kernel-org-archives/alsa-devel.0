From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: nau8825: reduce stanby power
	consumption
Date: Fri, 5 Feb 2016 18:48:05 +0000
Message-ID: <20160205184805.GB4455@sirena.org.uk>
References: <1452873193-20650-1-git-send-email-KCHSU0@nuvoton.com>
 <1454383094-6778-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9005592630167621795=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B098260698
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 19:48:13 +0100 (CET)
In-Reply-To: <1454383094-6778-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============9005592630167621795==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dfOvyYudzT1RPUKx"
Content-Disposition: inline


--dfOvyYudzT1RPUKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 02, 2016 at 11:18:14AM +0800, John Hsu wrote:
> There is side effect at last patch.
> The playback has no sound with MCLK if internal clock frequency decreases.
> Thus, we need to recover frequency setting when MCLK case.

This doesn't apply against current code, please check and resend.

--dfOvyYudzT1RPUKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWtO5lAAoJECTWi3JdVIfQZWIH/ivn6NAwCTTY3RX3ZZ2EZEUM
y/bIerOFi2WeakD8ET+nzBsFM9Th5ih2viFxVBXRFryGuC31I/50bHZPEI8oHNRr
NJgDFPX2cxaDJA0chdsTJyHgdxcWS0BLcnXXhdIiocrpe3ZAE3B5r1Ypa8JPN5JL
umkX3IXrnXUHmGbMrby95b5l6PThwKOWRumQYDjDaE5L9KxFwCVlIA+y+lk9mGla
PUvOzPf4hoq3HqW0ARNQbJ5krnpgFMzncUSfMgj5Iv0mzdSOtyH9oMN3lN/BYIPd
SCgp/XeB0Tqa1NWXssla2J+rk0mgBWjwsxM8+ERLErI67SbsyTkL5jQyrzzCi+g=
=1osP
-----END PGP SIGNATURE-----

--dfOvyYudzT1RPUKx--

--===============9005592630167621795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9005592630167621795==--
