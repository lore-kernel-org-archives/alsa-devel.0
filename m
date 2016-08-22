From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: ASoC: sun4i-codec: playback stall and I/O error with DAPM paths
 all disabled
Date: Mon, 22 Aug 2016 11:18:15 +0200
Message-ID: <20160822091815.GE7104@lukather>
References: <CAGb2v66X2BhEM4X+zQHUFB-wpHuBQ4xc8ztfYFuKADnY0b-gaQ@mail.gmail.com>
 <20160815114211.GI9347@sirena.org.uk>
 <CAGb2v66diZMuxddK9jM5-RbOZGOF5EK_jgxxkWV-ad6WHCNd9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v66diZMuxddK9jM5-RbOZGOF5EK_jgxxkWV-ad6WHCNd9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wens Tsai <wens213@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Code Kipper <codekipper@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 12:45:39PM +0800, wens Tsai wrote:
> On Mon, Aug 15, 2016 at 7:42 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Aug 15, 2016 at 05:43:55PM +0800, wens Tsai wrote:
> >
> >> What is unexpected is any attempt to play anything under this state ma=
kes
> >> the playback software (in my case mpg321) stall, and later report an I=
/O
> >> error. My guess is that the DAC is still disabled by DAPM, so it doesn=
't
> >> send any DRQs, and thus the DMA engine is not consuming any data from
> >> userspace.
> >
> > This is normal for ASoC - like you say it'll be becasue the hardware
> > isn't powered up.
> >
> >> I think we should just enable the digital bits of the DAC/ADC all the
> >> time. Or maybe transfer and then discard data if the DAC is off. Not
> >> sure if this is doable though. I expect playback software to work, and
> >> not block, regardless of the hardware status.
> >
> > Powering things up all the time will have a major effect on battery life
> > for systems that care about that.  The expectation is that systems with
> > this sort of hardware won't normally be offering end users direct
> > control of the routing, it'll be something that's handled during system
> > integration.
>=20
> Ok. So I guess one solution would be to move the mute controls out of
> DAPM, and maybe change some other mux like paths into actual muxes, so
> there's at least one usable path at all times.

I'm not sure that's even a requirement. IIRC, but Mark might correct
me, you just need to expose whatever the reset state is.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXusNXAAoJEBx+YmzsjxAgO+cQAIEF2CtLlh0bjFzQfnivEbLE
gHchdPJARnvMgo3/tmuwz39qvTcwQdCmTAXrvwIsXJr63WV3nRAMOkVvxEF9IjYM
65u7x9gbHKvb0FBorfhfv1NeNv1OpyzWYiXda9/xwqZeNoHvu+BwYPHfdfYwOtsi
+arc7bJOT7GSAb+MNX0AHM34u1iDorrxPwm4pHRBtejLZR9Jo0c1j/zDMVNPhblx
pyf0gqCShD2gCcrB8bM2v95xmkb9jXmuplQ50Z5osVVxainQ1ZfuhYT+TWIq+6I7
s6PWa6TBSegj5ceDGYRKN1QBTGLRR1zM0rSb2mXKiO8kMJ8RXTlLIiGlKkAoy5UU
LzmOdZNaEZUP5/YU//ziJ8e0Mjt/NETxSsVW5N9PkHjVtLRYwBqvJbt3v9xnGFSj
rBwpHUIsHlWzmicgwmhBNU8KvNmcH61phKzq3wJ4Rt/uENNtuetIZro1eYH3m9tL
nbZ1jQdbrN/9rt+ZBJTQa+Zo+jrN53zBa75D944/KZLOwSLfjlhJB/9WG2JUvHcm
qnJKQdzdsPLoHDqD/oDwArDlFGSgb84PawK1PrQqDJTHVaWWF7FnGfk2vFPFNM8l
6JEd699bsKdxpau4Pkz1GYUNbMSsN3oi1IzJTPiQheoKkBQEErCtzucfoWTu7tuI
CPzSe3Imbp1IgK4w4wNm
=kkQU
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
