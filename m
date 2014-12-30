From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH v4] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Tue, 30 Dec 2014 16:53:59 +0000
Message-ID: <20141230165359.GN17800@sirena.org.uk>
References: <1418103916-31295-1-git-send-email-b50113@freescale.com>
 <20141222181045.GH17800@sirena.org.uk>
 <BN3PR0301MB125132692CD535B9AC1795A98D510@BN3PR0301MB1251.namprd03.prod.outlook.com>
 <20141229160514.GQ17800@sirena.org.uk>
 <20141230022917.GA17807@b50113>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5NVDATmc8A1f9nDP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141230022917.GA17807@b50113>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <b50113@freescale.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "lars@metafoo.de" <lars@metafoo.de>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--5NVDATmc8A1f9nDP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 30, 2014 at 10:29:18AM +0800, Zidan Wang wrote:

> I want put mclk enable to set_bias_level. Do you thinks it make sense?

That should work as well, yes.

--5NVDATmc8A1f9nDP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUotimAAoJECTWi3JdVIfQyrMH/1CcjT3TC/aD8X7CGYLuCOXs
Lg0TaPhdh9ll2D7vvq0OnoKgsCTeDJBm9Og2Njp/fGiHaM+9ZPfwLC7F+SwVhuJw
8Osi70kBQdIYS3iqWsFgFNxTRLOnVsc9tVFBMS8d9xZ2LQylCFOrJ2t8NhZydeC6
MWj+Hkk5SP9MH8N1fRUGUGjZdWxPIy2foFKSgTkMBx/CMmYCdbijU+EeUye8cYl1
423JSe1PvqhVJa0BaX39USCFoU7iU1mn5Ec1mvSVH0L6WqSzNTEi9zYotlbIS6Ai
NHvgkd+5SEIr/GbGzBTVYUs0RiYlOCIEAiG7HWulZ3JozmOvar7SulL9b3QPQMk=
=Ubhv
-----END PGP SIGNATURE-----

--5NVDATmc8A1f9nDP--
