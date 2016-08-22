From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: sun4i-codec: playback stall and I/O error with DAPM paths
 all disabled
Date: Mon, 22 Aug 2016 11:41:06 +0100
Message-ID: <20160822104106.GK22076@sirena.org.uk>
References: <CAGb2v66X2BhEM4X+zQHUFB-wpHuBQ4xc8ztfYFuKADnY0b-gaQ@mail.gmail.com>
 <20160815114211.GI9347@sirena.org.uk>
 <CAGb2v66diZMuxddK9jM5-RbOZGOF5EK_jgxxkWV-ad6WHCNd9Q@mail.gmail.com>
 <20160822091815.GE7104@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160822091815.GE7104@lukather>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: wens Tsai <wens213@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Code Kipper <codekipper@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2016 at 11:18:15AM +0200, Maxime Ripard wrote:
> On Tue, Aug 16, 2016 at 12:45:39PM +0800, wens Tsai wrote:

> > Ok. So I guess one solution would be to move the mute controls out of
> > DAPM, and maybe change some other mux like paths into actual muxes, so
> > there's at least one usable path at all times.

> I'm not sure that's even a requirement. IIRC, but Mark might correct
> me, you just need to expose whatever the reset state is.

Yes, this results in some inconvenience but avoids problems caused by
configuration changes for one board affecting another adversely - if we
just go with the hardware defaults it's something fixed externally.

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXutbBAAoJECTWi3JdVIfQTccH/2i2yUXBTsic/vpbnYL1AFgC
lvgy4mUem73k7ioOsl/ieh2oCYO+uTn/m/N1OO/qRIBPIeLg14TdNNafTPOPcCBH
HiqSPoI9oe3PmyHrwi2VQoo6PDtrl/aJaXg8cUVzUeerG5a2UFuCLdvmIha0SGQs
Q0B9vcpkSvWqxGlA8e43xwgEGEcd0imlVe3wSjkTuUQlj2DYm799Hd7q7PjZyWGA
FdVLodqxS4s+J8QiCh/kcYNxaiL/XyUwROad5nVPoZxa4JPz6/0I/Y56n4olfRmE
D1Ij5RrIgBs7w5rfnZTl6jEpgR7cDcW5kuu+GAUm73JSLrwQSpHJ8PVOEYRXm80=
=2+KC
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--
