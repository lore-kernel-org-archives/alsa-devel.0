From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v3 4/5] ASoC: tda998x: adjust the audio hw
 parameters from EDID
Date: Wed, 5 Feb 2014 14:08:08 +0000
Message-ID: <20140205140808.GI22609@sirena.org.uk>
References: <cover.1391274627.git.moinejf@free.fr>
 <1b15025671d9099863a3091346536e45891e4a26.1391274628.git.moinejf@free.fr>
 <20140204180625.GM22609@sirena.org.uk>
 <20140205101134.4591e5c3@armhf>
 <52F2021A.9020804@metafoo.de>
 <20140205111814.GF22609@sirena.org.uk>
 <52F23D1D.7040804@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b4TJccIV73PFtYC8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52F23D1D.7040804@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@gmail.com>, linux-arm-kernel@lists.infradead.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--b4TJccIV73PFtYC8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2014 at 02:31:09PM +0100, Lars-Peter Clausen wrote:
> On 02/05/2014 12:18 PM, Mark Brown wrote:

> >...as previously requested.  I know there was some discusion of broader
> >moves to factor this stuff out but it'd still be good to keep it
> >separated out even prior to a final non-EDID based solution so it's
> >easier to refactor.

> I think it will always be EDID (or ELD) based. As I understood it
> the re-factoring Takashi was talking about is related to how this
> data is passed from the graphics driver to the audio driver. The way

Right, the data of course has to come from there originally, it's about
how we pass the data and updates to it around.

--b4TJccIV73PFtYC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8kXFAAoJELSic+t+oim9uRcP/2e8T6RAq45tOdi2i6+1yBp2
xkLMeOYCBtNC2pihKA0bI+R33F8OdrnjQabMEjlGdjVgGo9DwCuVhESt7dujpBL8
wR+FS71WLLxUdJmURqvSR03hM0txEdOliojZBViue8ZKlXAwNswc4Bt1v8vrH9PQ
RBxi+l2GaQnoNXkAFVPnUpgSAf2EV661Oh5Srt0+Nh8gfNfiY542uMobdaOQqSka
zlDlggVFuVjxR+XPt5GBg6t00Ns5izgXt4tmuRcm047TOy/ukeChZNb3qunQbR3x
03r4ZDbgcK2dELR7Tb2rCgqBM4y8KBC+DWzTEG1bRSk9fOjfwG42fh2s/Kc3tBZJ
5bnkwDYFhL6uJln7AHffOBLyW0oU1HWmPvy8bPHb0NCsyTAH77mU6HX54khlvj4/
N7oWXdMGpBFOecILZZ7sz3YnykCntxiZyDfhZb7DH8FCWqfFrRFp5DD2osG0DAUX
pSEke5BuXUDU+KW89XnOp6fJTXGzsMGThfSLYS4ctQl4zO/uGVTkj0gO7XiLAKMp
HKxw2V5BuFuVJEUhFhDTCP3ozWtHkdThBN+zM8VYmP31mj8QZ+Mkq4UMPdj45Wu8
0x2ZNEq/nQj3xMHxsQih2F41qXsEfeImu24Vzaid0o29fkrWlhvEVzzIN9fHD0wD
tLCmehA6bt2YCzxfNUcW
=jekc
-----END PGP SIGNATURE-----

--b4TJccIV73PFtYC8--
