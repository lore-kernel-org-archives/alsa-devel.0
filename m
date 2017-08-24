From: Tom Rini <trini@konsulko.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 11:54:37 -0400
Message-ID: <20170824155437.GF17193@bill-the-cat>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <1503498573.25945.69.camel@linux.intel.com>
 <20170823173912.GN17193@bill-the-cat>
 <20170824000525.GY17193@bill-the-cat>
 <s5hk21tjb02.wl-tiwai@suse.de>
 <s5hinhdjav6.wl-tiwai@suse.de>
 <20170824144152.GC17193@bill-the-cat>
 <s5h60ddj7l8.wl-tiwai@suse.de>
 <20170824155235.2nrqjiwlo3afk4ei@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bMDD5T6Tp9Yu3dvb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170824155235.2nrqjiwlo3afk4ei@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--bMDD5T6Tp9Yu3dvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 04:52:35PM +0100, Mark Brown wrote:
> On Thu, Aug 24, 2017 at 05:42:11PM +0200, Takashi Iwai wrote:
>=20
> > OK, so the fix for 4.13 would be either to cherry-pick this commit, or
> > just to re-add "RT5677CE:00" to i2c_id temporarily as a quick band-aid
> > fix (and remove again in 4.14).
>=20
> > The former is cleaner, but it's bigger, while the latter is a safer
> > oneliner at the late RC stage.
>=20
> > I leave the decision to Mark.
>=20
> I'm happier with the oneline change TBH, like you say it's pretty late
> in the release cycle.  Can you just apply the patch directly and send it
> to Linus with my ack or should I put together a pull request?

FWIW, I'd be happy to give the change a quick spin and Tested-by it.

--=20
Tom

--bMDD5T6Tp9Yu3dvb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZnva9AAoJEIf59jXTHXZS1EYP/j3UdZPvL6EQ7nXEIaEJqq3k
JIukXIUo1TBQDs9LqkPR801XxVCtKUbh/SSu6GwdLx/R3taSNjlHnvTyN7EpUaP6
vzqcj4AW0tTREjKL+K+GORhhQ4rNH49PsckE3akGuwBlLJgU00UV2w96iNbbG2vA
3ZKV2trLG1sKJ6kiXvHZi4jM49ZpH1xUamumWjR/bQyTYBLVMD+yIWCuF6hT/xCJ
VsZnAsAUESwmsAOpUPiEbZNBUdUgtVP+pQbjvEmZZr/Jvw2nGGTCzM2zHLlx29YD
F+1dFZ2r1C1J+VNv/fmuBKUvFLtIkntWJYo2G34K9KJqAHA7mrVnwv+Sp1dtcnsz
zCSfjUrBixYm9u5kUUTtjUUeJ3w7TpdMgAe9Oium5VBJ5RJnJbapjVpvbs8K5g2l
R1EEOhSFb2suMg92aVqW9liOZrdlTEC1HapAPsTBGh/4h//KxQTVu2vNtVz1EoNe
GbEPRJTdPh4629cXnRe0wPbxfR4crgeOpfsLVONEzmQRN5RQO5FPL8PaPsjFePvc
zx1jFF/Pc33NMDc2Lwz5dTks+143JdMdMTQjUu6TPJZDgTTw0MrZFOTUtQU5VfBP
cuEpVM+WkIMouf6xrN0BJ5GP0tKMFFWNlQRPrbqcRhQYVgri+kDRBP+jiYsT6jhk
eKPxjWNo+V1woSsAyReb
=jktH
-----END PGP SIGNATURE-----

--bMDD5T6Tp9Yu3dvb--
