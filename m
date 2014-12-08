From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH v3] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Mon, 8 Dec 2014 11:14:45 +0000
Message-ID: <20141208111445.GT11764@sirena.org.uk>
References: <1417696879-15402-1-git-send-email-b50113@freescale.com>
 <20141205170156.GB14516@opensource.wolfsonmicro.com>
 <20141205173932.GN11764@sirena.org.uk>
 <BN3PR0301MB12511B448B1C0B9E8F0BB6C48D640@BN3PR0301MB1251.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wiiWofWi8Et/oezL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BN3PR0301MB12511B448B1C0B9E8F0BB6C48D640@BN3PR0301MB1251.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <B50113@freescale.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "lars@metafoo.de" <lars@metafoo.de>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--wiiWofWi8Et/oezL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2014 at 09:49:51AM +0000, Zidan Wang wrote:
> So I should move mclk to wm8960_priv.=20
> And doing wm8960_priv->mclk =3D devm_clk_get(&i2c->dev, "codec_mclk") in =
wm8960_i2c_probe.

Yes, please.

--wiiWofWi8Et/oezL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhYgkAAoJECTWi3JdVIfQg/YIAIagOEIeJKVoDG4UjRSEsmN7
vGCXi3c/1CGzE0LwDAsScFBEEboeBeWjtgbu18H3IkBLvBpeU2GDM1l0dmWcrScI
sNeKLp3Q8zPd79dfgKAbNQm3YiwSARLviax8RN4xRBgxJuby97jnmMDONftJHQhn
kz72pLs67jQfTJzXOgItp0OwPuapBcA7KAR5jRVcyDlAbnVcirBXPeY//6hFv5tO
CDvlIcqQwdy5f0r+SALuuk2axgzV5ylqh6B9FSMs+TRPVIBLrJXFQ+BwGfOTnVP5
5/R02QefR3dhLh6ujObJi+cNMXHCumH8YzaLy88x1RzagZoL0bYxCLa0Vm4tGLU=
=T7OE
-----END PGP SIGNATURE-----

--wiiWofWi8Et/oezL--
