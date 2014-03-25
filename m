From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 12/12] ASoC: Remove name_prefix unset
 during DAI link init hack
Date: Tue, 25 Mar 2014 12:53:30 +0000
Message-ID: <20140325125330.GT2269@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-13-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8112902109330107899=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9299E26260F
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 13:53:56 +0100 (CET)
In-Reply-To: <1394634460-15889-13-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============8112902109330107899==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iiZKCn1f/U0ES2iY"
Content-Disposition: inline


--iiZKCn1f/U0ES2iY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:40PM +0100, Lars-Peter Clausen wrote:
> Before we had card level support for DAPM and controls machine drivers would
> register their controls and DAPM elements with the CODEC. This required us to
> temporarily unset the name_prefix of a CODEC during the rtd init callback to

Applied, thanks.

--iiZKCn1f/U0ES2iY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMXxGAAoJELSic+t+oim9t8IP/R6JlZrBivoNRKPrb5BRDTcS
HLclsiKM5Zu9HIZUzz4TdQKK+05h11jftOMjL4PqdTKbWAkdjDWIdNhnWCnr8m6d
KnSkrT+0HGEC4YWplY8FTju1OprfrA2j1aXHYcrLKyRblqT91hAn8liRvMXPQuhc
ZjJGUx1tSj9NEsGhkzEgNrw1OQXmXdXeYIqM5W9vxIpX8eHah52Lfl3AWa1RkGjw
o7sTVF5dRIZhCy+67IxUhEe6Cy0q/0QqUH1U39JaObnMPHOTrEd1sjnpevFe6eRK
taQEGpNVu+HFsnuu6y2FRDmvBUFIwIhlkosUnYEGMM5Wa7wACi6dCLBi5RiHRcsG
eMrRHivgjGP6//JTDrgMxEHmnSjvjCzQRVkSVBWNDq8Gk4QiLp3x/hPxVBaDwHFY
qOKY1pVGMk4con4+jzbOLITB0TBuatN+imLn0/92p9x4q7cefqxU+lUm7Rv2tUXZ
tzo5CQNMYcBilmSbuDO2vuQ3MIUUbJxc4f55IILeYuiOt50ku+i1Kmz/SPAtBvG/
dm3t3OREOENStgkbuCcs6Oe2dsmWATd0/N8dJZgdXZGbfTMDR/g13+mwW7W4bA3F
N569T8cvMRqqwo20kg23aoDYo9+gPZeqqWpKiVocKkbWlPeOHABLPxpqaW4rE4vP
n1Gu2zCmjSH4zTxpQqzh
=3noi
-----END PGP SIGNATURE-----

--iiZKCn1f/U0ES2iY--

--===============8112902109330107899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8112902109330107899==--
