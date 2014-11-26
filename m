From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH] ASoC: wm8960: LRCM operation should after
 software reset
Date: Wed, 26 Nov 2014 16:36:01 +0000
Message-ID: <20141126163601.GH7712@sirena.org.uk>
References: <1416999740-21805-1-git-send-email-b50113@freescale.com>
 <5475BA76.8080809@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iMgEUbSC7F9Xm20w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5475BA76.8080809@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Zidan Wang <b50113@freescale.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--iMgEUbSC7F9Xm20w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 12:33:10PM +0100, Lars-Peter Clausen wrote:
> On 11/26/2014 12:02 PM, Zidan Wang wrote:
> >When shared_lrclk is set, LRCM will be enabled. But the following software
> >reset in wm8960_probe will reset it to the default state. So LRCM operation
> >should after software reset.

> It's probably a better idea to move the reset (together with the other
> register updates) to the I2C driver probe.

Yes, this is not a good fix.

--iMgEUbSC7F9Xm20w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdgFwAAoJECTWi3JdVIfQlIoH/A7i3L4kRDUMymQ7qDR9Bsib
dDTpun+T1aT5YCnJ1LcpeEPv8f6lihDRN08AB9Arz9asnnnQd9Y8DwulMbPNtbOU
fz0w7rWitorqLBLzhBju388DFYxfUiAfO7hySVBzUbbOF54MfzjHOrpV3ylgG7Td
Y0WTjAkTMoBa2tMjUgy6gVTC5q+6RNuYzO7m+LFCfkZZ0i/jitk9/ljD7IZoR/QZ
e/iOA4mt/Ygh3Oh0w9dAac9P0ACnvBuplh60DxLVGUBTfqjewG8rf1RrBmO3aY3B
v/vLIzMDV3QOp35KFOv1An/x83Rkr6koGW0NtfkVVIa/eIVloOc4pnZ6viB6jEs=
=pGhp
-----END PGP SIGNATURE-----

--iMgEUbSC7F9Xm20w--
