From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH v4] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Mon, 29 Dec 2014 16:05:14 +0000
Message-ID: <20141229160514.GQ17800@sirena.org.uk>
References: <1418103916-31295-1-git-send-email-b50113@freescale.com>
 <20141222181045.GH17800@sirena.org.uk>
 <BN3PR0301MB125132692CD535B9AC1795A98D510@BN3PR0301MB1251.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3DRm6T3aFkHkz+Qz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BN3PR0301MB125132692CD535B9AC1795A98D510@BN3PR0301MB1251.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <B50113@freescale.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "lars@metafoo.de" <lars@metafoo.de>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--3DRm6T3aFkHkz+Qz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2014 at 10:59:08AM +0000, Zidan Wang wrote:
> Hi Mark,

Don't top post and please fix your mailer to word wrap within paragraphs
and avoid corrupting the mail it's quoting.

> You are right. When PM is disabled, the codec will not work. But there ar=
e also some codecs enable mclk in PM, such as wm8962, cs42xx8.
> And some codecs enable codec mclk in i2c probe(), startup() and set_bias_=
level(). It makes me confused.=09
> Can you tell me what's the general idiom to enable mclk. Thanks.

Like I said in the mail to which you replied:

> > This isn't going to work if PM is disabled (which is still a valid conf=
iguration).  The general idiom for this is that the driver should start up =
with everything powered up then let runtime idle turn things off if they're=
 not required.  That way if runtime PM is disabled then the system will sti=
ll work as everything will just stay powered on all the time.

--3DRm6T3aFkHkz+Qz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoXu5AAoJECTWi3JdVIfQmXQH/j4WXFEcK4saPVHywEGNKHY5
pf3ld9S/yb8SdgNtKRuyMcYkHLZvf8sID4QmrijyLVDCFA78VtnXSrOO2KTvCK62
eSusKQbT6JRV0JDcgQim1GsUuaGu9aBor6GbddnYmL5OcRiL2Ym3xrg0JQWwidvb
h5Ph4OQhxURnJzt0Thcl9R/qiOm+3MR/oCndpsz2/ccpCvMiOjgckkp1hxOcSNjY
GeWeMrw0hLhjU1OpXsj3DY/dP1F4tv56JZ3pEnA06DquLUUmbDpE6E+Bq/JF5ff4
TDOiES0kloOQzqRCJilOMEcv73Yl7snHZGpFt9UAgqxWtUoHaeR9Gz+mKncU+Ww=
=8kiq
-----END PGP SIGNATURE-----

--3DRm6T3aFkHkz+Qz--
