From: Mark Brown <broonie@kernel.org>
Subject: Re: [linux-sunxi] [PATCH 1/3] ASoC: sun4i-i2s: Add set_tdm_slot
 functionality
Date: Mon, 29 Jan 2018 12:31:04 +0000
Message-ID: <20180129123104.GB10969@sirena.org.uk>
References: <20180124141101.12867-1-codekipper@gmail.com>
 <20180124141101.12867-2-codekipper@gmail.com>
 <CAGb2v67eYFP1cnJ8iY9-Y-50kSbuY_Wip51q0veqx9z0_Prenw@mail.gmail.com>
 <CAEKpxBn6FNLCN22Bax1RiTdZbsHOqq6Ls5k2JYz6QJt4_77ffA@mail.gmail.com>
 <20180129113248.GA10969@sirena.org.uk>
 <CAEKpxBnHEW+uN0yJOCaBODY2p_uxOcu7+ofsRuutrwvbJ9KeCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEKpxBnHEW+uN0yJOCaBODY2p_uxOcu7+ofsRuutrwvbJ9KeCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Code Kipper <codekipper@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
List-Id: alsa-devel@alsa-project.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 29, 2018 at 01:28:51PM +0100, Code Kipper wrote:
> On 29 January 2018 at 12:32, Mark Brown <broonie@kernel.org> wrote:

> > You're looking for set_bclk_ratio() I think.

> I'm looking for a mechanism to be able to override the bclk width
> (usually it's based on param_width) from the device tree. The tdm slot
> functionality looked just what I needed.

The simple and graph cards have support for bclk ratio configuration as
well.

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpvFAgACgkQJNaLcl1U
h9CBeQf+PsfOTOgSkK0ztBBTlNHp5P36BP9yi9Dze2ZhSy3yi5OpGo8CGJdv8zaD
rqcuhqdeY0MSHdHrnFpEeylNmktucnTS0azmf5MPY6g0mTb68yQHjebw9LQlqIyd
OhEMESu4sWValeX+Kzy8uDMOZiH1URsU5tP+muzTjXR9uLOiaOM1kyFIvpXEJ0Jl
7w7G/+96j2tzX5enNhXL5jcds6e2EdrnS4ua7bPob4Ph6Q3dDwq9I2nBn3AlQZQR
s8sOq2SxwA2CEqEfKYuQtuRGiW8qnJcP5a8mPlDLuH2xhFNRWPrh4GDmS2zOxpyG
O0Q3gIXAQGsQ7MoYP/GH2DuYA8Azqw==
=Aw/T
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
