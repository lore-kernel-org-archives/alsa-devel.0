From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 1/2] ASoC: dmaengine-pcm: Add support for querying DMA
 capabilities
Date: Mon, 15 Jul 2013 22:27:21 +0530
Message-ID: <20130715165721.GV16653@intel.com>
References: <1373906531-6938-1-git-send-email-lars@metafoo.de>
 <20130715172643.GZ11538@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130715172643.GZ11538@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 06:26:43PM +0100, Mark Brown wrote:
> On Mon, Jul 15, 2013 at 06:42:10PM +0200, Lars-Peter Clausen wrote:
>=20
> > +	hw.period_bytes_min =3D 16;
> > +	hw.period_bytes_max =3D dma_caps.max_sg_len;
>=20
> We can't read the minimum period size from dmaengine? Seems like
> something might have a restriction other than 16 bytes here.
max would be how many list items the engine supports so queried therotical =
min
would be 1 byte, not sure how 16 bytes is assumed above but my guess is tha=
t if
engine is able to push min burst lengths which would be 1 and give you
interrupt. But seriously, that would not be practical. So this should be a
realistic limit which system can cope with.

~Vinod

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJR5CnxAAoJEHwUBw8lI4NHZAcP/iQpHY9iOiISuLMZGIeSwLvW
eL+kP7VznOyOJCXXyhi45pFcdjC9USRAy+ZBSW+oEmMxUdM0pBHPm61Iz0lA1xNM
H6CwJ9Rk8G4ETH4dnXWDzy30qwASzB+i0RAfXvYvb0ds2Ajgm74of3Q+u8ICAWmU
pt68t2w8fMlYnh5V7Ntpqbv9Dc6ThEyao5Qo6EOqUm8hxi9Qu+JmeZHS9PmLL9Cj
o2QdDuHl9Q/bOwAvsYp8HUfcggQsRMY6iO7iwvH3pWVun3pB8Wpww+vbc86swOE1
NJadAJTXtuVfY3IkneqmJf9Dt1GvtNK/vOSYX2v7M6uu1IBQjRHsBAlNMbpxXLS5
qxdER2g6UIa/pH70tu9D3432TEUzl15Sqoe5rKuEiduKuVIF1SfMH9ZglQ7QTx3N
NsrrzdZczwE2qyNZXCFZeLjypZ2uoQcMXM/yvTYm/Ch+9lWaWynsKcO3OPqPhbyz
BO19rWlFdVU6pvoUCqsd9KMayT0mPzWocLgz50fXIybJncIyeXs922wobANAZkof
Dabya0mfZUMR+0r0rh/kSaBVFByMBqAZrTPQ3L6C29ZzyTn7Y8TdBawMw+nUf5pz
VG779UdORJUAbGdjeFHop45vnYeab+VVDXi1pw+bYX6dAiR6+16xR1HOx+CA3vmR
YLKA2HoqN1ncANNxc8ME
=nejS
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
