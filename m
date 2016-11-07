From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [linux-sunxi] [PATCH v5 4/7] ASoC: sunxi: Add sun8i I2S driver
Date: Mon, 7 Nov 2016 21:05:05 +0100
Message-ID: <20161107200505.g76zz7adtfy4ltku@lukather>
References: <cover.1477142934.git.moinejf@free.fr>
 <bee315efb909c1ee8b5fe7d3aeb9a33d713cb562.1477142934.git.moinejf@free.fr>
 <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
 <20161106190248.48b59e166bcd9d6f0ebb4d04@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0842595860=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20161106190248.48b59e166bcd9d6f0ebb4d04@free.fr>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0842595860==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mqrdtho4x2pm45f"
Content-Disposition: inline


--5mqrdtho4x2pm45f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 06, 2016 at 07:02:48PM +0100, Jean-Francois Moine wrote:
> On Sun, 23 Oct 2016 09:33:16 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>=20
> > On Fri, Oct 21, 2016 at 4:36 PM, Jean-Francois Moine <moinejf@free.fr> =
wrote:
> > > This patch adds I2S support to sun8i SoCs as the A83T and H3.
> > >
> > > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > > ---
> > > Note: This driver is closed to the sun4i-i2s except that:
> > > - it handles the H3
> >=20
> > If it's close to sun4i-i2s, you should probably rework that one to supp=
ort
> > the newer SoCs.
>=20
> I started to add the H3 into the sun4i-i2s, but I am blocked with
> regmap.
> Many H3 registers are common with the A10, but some of them have more
> or less fields, the fields may be at different offsets. And, finally,
> some registers are completely different.
> This would not raise any problem, except with regmap which is really
> painful.

That's weird, because regmap's regmap_field should make that much
easier.

> As I may understood, regmap is used to simplify suspend/resume, but, is
> it useful to save the I2S register on suspend?
> Practically, I am streaming some tune on my device. I suspend it for
> any reason. The next morning, I resume it. Are you sure I want to
> continue to hear the end of the tune?
>=20
> I better think that streaming should be simply stopped on suspend.

You're mistaken. The code in there is for *runtime* suspend, ie when
the device is no longer used, so that case shouldn't even happen at
all.

(And real suspend isn't supported anyway)

> Then, there is no need to save the playing registers, and, here I am,
> there is no need to use regmap.
>=20
> May I go this way?

No, please don't. regmap is also providing very useful features, such
as access to all the registers through debugfs, or tracing. What
exactly feels painful to you?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5mqrdtho4x2pm45f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYIN5sAAoJEBx+YmzsjxAgZDAQAIalAWDwR9jey/epeDiTOb3A
vin599o3eGK+6CqAHSSrDoXujKCHerEVu9tsa1XnkPNXcAW4TdZJxswRxmcv/2W5
4XT2EQqWRVBtJGSiQ1gaXcVIIGi9W3lu/YNs6DbuICxZcqSWLHOFvTYHiRV6Xr1r
tL3xUb+nIGvnltUzb3o3PprbOH6yAPYN7AISuRqGp2TXj5eWFC8hH/lFjiT5wYSo
7b3+82xXI9+ep7QYpnOzdpujNgPkLbdwZms7FFtNaJ/CIXqn7/RY5qkNy2ucXb98
xSwYyGKq/K+xbc27qQJH7HzsC+dHIEdj6o4h29ZpevN7O6u5orrZAgFp8pKpkNAq
YkzY5EvCbJJH0J0Z1jzQm2wNtuJlq4o55o4v3Q/dTOS1t10VRDlB1fWzAQGhdPLN
ctbr/JYIOLzUUYm2fJ82T7ZfvGqCYqReYKvFUx4yZbUgJ1HdsSYGQ80FUWwdpl0A
H71CWgMK5HxdALMc9eh/uDbBFyg+vet8khV6xdjjVo9JxcmBPebwLghBHAzlnnY5
agRrtdibo8zdtNsoSM/C9NOBpKmPHJ39Ocv6OngwQU6yKNq8gv+EY6PNKyRfaKaa
DuqzfD9FXGV1jBkrAI0pclvAOQ75OWbmkT9DkvEIImTvFfpE2lhVSPUqeKMUXhCK
TrTpUoaCQUjE64cSA58v
=X+8k
-----END PGP SIGNATURE-----

--5mqrdtho4x2pm45f--

--===============0842595860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0842595860==--
