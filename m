From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5639 CODEC driver
Date: Wed, 26 Mar 2014 10:48:43 +0000
Message-ID: <20140326104843.GG2269@sirena.org.uk>
References: <1395627397-6580-1-git-send-email-oder_chiou@realtek.com>
 <20140325133017.GY2269@sirena.org.uk>
 <5331A1D6.2070109@wwwdotorg.org>
 <20140325165738.GZ2269@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D126943580E4@RTITMBSV03.realtek.com.tw>
 <53327DBF.6080402@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2104836858809054020=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 900D3265130
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 11:48:55 +0100 (CET)
In-Reply-To: <53327DBF.6080402@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2104836858809054020==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZOBTspFzEMOlPevk"
Content-Disposition: inline


--ZOBTspFzEMOlPevk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2014 at 09:11:59AM +0200, Jarkko Nikula wrote:

> FWIW, we are using RT5640 upstream driver on Intel reference designs that
> have RT5642 so if those DSP features are going to be supported some day I
> propose to have them implemented in a same driver.

Can we at the very least add the device IDs to the driver so we minimise
the chances of boards shipping with the wrong IDs?

> sound/soc/codecs/tlv320aic3x.c comes to my mind how to implement support for
> different codec variants in the same driver.

Yeah, like I say the wm8994 and Arizona drivers are another example -
wm8958 in the wm8994 driver might be particularly useful as it's the
addition of a DSP to a simpler device with not much other change.

--ZOBTspFzEMOlPevk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMrCIAAoJELSic+t+oim9yj8P/0RsKdnYBROtBM231wGCpSZd
kCixxAk579rVuynamvRh3sU1NOgwspTW52t49L6+Vv0k3RunQ7TqJu+pWMJ8k6Nh
ipP7YF9OKYfAOxt1ZEj9KyPZYDneKPAzo2fjYPcN7T6xV/0ijxz/cI+oiEc4QxLx
Wj05LDsl4p4RdYCncyiANB3KqZll6vmtQEW5giQ47VEpE+o/91xo7ClcqA+YWpYI
g0kH9RUR64OIUVWJ6J4ylLdCDiu0bqTmXG2JMiHeOhcAkewBYvN2SDeh2Y19wUqc
zxA5IypuyiM5QqeZTBgS1I6Fu+6bqlkGF+BoCy9eB26D7H4A3hiHfxPAcJ1scIYp
enuRLruSlx7p5s3s5CKzCkJvwC+Qem9UFdyDTTZoZVz3K8417OjwCfHGBdAms+1b
BuGzLfShwJ05VuX/knti4bSmFsQfgXR9f3OLBSs4+OAf15I7fm1j2LUF4568KU4K
WzBBWM/HNbcHOJXTAUCNhLglvqUJ61NG+Obz1AehUiPJnHJ3/MQ9HdL0kJkECdDs
fgl4AprNKilIgTmORcqkftwETxxIyS6aS1YHTERxV/i5BmTqg/6xwGRGlgrOhasp
TLr44v25bzp3HzGwqSoF3Jq4xzPiXLWJFswbfCgivsTE+qAmBwhUO8aWr2liURTE
IvL62nDKI5/yBLRIm2kE
=HQxt
-----END PGP SIGNATURE-----

--ZOBTspFzEMOlPevk--

--===============2104836858809054020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2104836858809054020==--
