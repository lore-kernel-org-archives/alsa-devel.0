From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH 1/4] ASoC: wm8960: codec mclk should be
 enabled early to avoid jack detect error
Date: Thu, 11 Jun 2015 17:20:28 +0100
Message-ID: <20150611162028.GT14071@sirena.org.uk>
References: <cover.1434020423.git.zidan.wang@freescale.com>
 <880838f666b591f5ffb0de1e39df5e3734846246.1434020423.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FUBn+A0X9P+7IcSo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <880838f666b591f5ffb0de1e39df5e3734846246.1434020423.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--FUBn+A0X9P+7IcSo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2015 at 07:14:33PM +0800, Zidan Wang wrote:
> It will playback from speaker in the first 2 seconds, then switch to
> headphone. Steps to reproduce this issue:
> 1. plug out headphone and playback a wav.
> 2. stop playback and wait for at least 5 seconds, then
>    plug in headphone and playback a wav.

I'd really like to understand the logic behind this in more detail -
what is the actual problem here and how does this fix it?  You're moving
the clock management from the bias level setting to the stream startup
and teardown which doesn't seem directly related, if anything it seems
like it'd be making things worse since it reduces the proportion of the
time where the clock is enabled.  My guess is that the jack detection
needs MCLK enabling.

--FUBn+A0X9P+7IcSo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVebVLAAoJECTWi3JdVIfQ6m4IAIOitDwmP8F89tw67K0w0UUz
MqaH5ikjzzvKVxyWJChsurfknxfEZ2gbEMhQNqA6Kc4fvSYUvdmXYSCaEXFegTkb
nxR/yr2xJEerCSXo6LMPjWS/vt9IbvxHI/USaibo1x3GMG0HemzEnq6V0gMa/HXq
/W1jKVPBDcv+Gax1e5gW3KNmeSCJ0kzXP/naYWlmrD3im8E00FvCEdnb03wqV0qd
s//hTbci+g+8GcBq3xTx9ATsXb8XhYIZIVurJ/cT1qvpjaAA2fI+uKi+vBJL9QYB
xgIFGN11Zoz8UADSjG5XhQ+bhPbbtGNh8POEP446EXfGbBZMD2r4/atD/xTbk+w=
=wfoJ
-----END PGP SIGNATURE-----

--FUBn+A0X9P+7IcSo--
