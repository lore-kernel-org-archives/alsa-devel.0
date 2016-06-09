From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/4] ASoC: sunxi: Add Allwinner A10 Digital
	Audio driver
Date: Thu, 9 Jun 2016 23:06:21 +0200
Message-ID: <20160609210621.GJ5242@lukather>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-3-maxime.ripard@free-electrons.com>
 <CAEKpxBmLb27WYqB5SMhKqTw2cTznNEZVJdxEFKkwCY03JsdyVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5309692295088582965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A5D726070C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 23:06:22 +0200 (CEST)
In-Reply-To: <CAEKpxBmLb27WYqB5SMhKqTw2cTznNEZVJdxEFKkwCY03JsdyVg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Code Kipper <codekipper@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, gianfranco@moddevices.com, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Andrea Venturi <ennesimamail.av@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============5309692295088582965==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SCOJXUq1iwCn05li"
Content-Disposition: inline


--SCOJXUq1iwCn05li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Thu, Jun 02, 2016 at 10:03:21AM +0200, Code Kipper wrote:
> snip
> > +
> > +       /* Always favor the highest oversampling rate */
> > +       for (i =3D (ARRAY_SIZE(sun4i_i2s_oversample_rates) - 1); i >=3D=
 0; i--) {
> > +               unsigned int oversample_rate =3D sun4i_i2s_oversample_r=
ates[i];
> > +
> > +               bclk_div =3D sun4i_i2s_get_bclk_div(i2s, oversample_rat=
e,
> > +                                                 word_size);
> > +               mclk_div =3D sun4i_i2s_get_mclk_div(i2s, oversample_rat=
e,
> > +                                                 clk_rate,
> > +                                                 rate);
> > +
> > +               if ((bclk_div >=3D 0) && (mclk_div >=3D 0))
> > +                       break;
> > +       }
> > +
> > +       if (bclk_div < 0 && mclk_div < 0)
>
> this wouldn't work if one of the divs returns a valid value and I saw
> this when working with this driver. Use if ((bclk_div < 0) ||
> (mclk_div < 0)). Rest of the code looks code and I will have a go at
> testing with it ASAP,

Ack, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--SCOJXUq1iwCn05li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWdpNAAoJEBx+YmzsjxAg0U4P/Rz/GEvQj0piEhhhTjubc/us
TFkXVvz3cwHExjBCZPFGDq9OISj6NHmGXJbWiqNLocy6b2tu/nRLkINtklof8nNF
KEIOt/AHg3Uyj6PCWJ+INcYRGgbMy2Rm8zkUPLw9Kp0Pvqg+F7eMksZWrYXAzPjw
+wRpET87FG3/j7vQ/VuY6egdDkYBJ4uG6DyzMig3FmNHbFuc0Zb05Tml4SPh4sQf
YMgXTqOVB9ODvUIKYGq5KUaeINjOi1EVmQdh3akaH6LkUY8QjDG5XnjmFrL+VuSi
QwqxNXFsPXfdjIrwDpnL51WC0yddaZBGj/bDPuAHHFMudAFqRi7HmpZeS7dMFL6q
0PmupJ0C2NkBv7bkc7gkwMMpQztSQD0v5OqZ22Bi3asGoIqrEO8srUQ2fkU2/uIA
ZpkFcc8zyooXh0X6mWFE8jts59V3dqUyFOTqI3z6tSNQwaMHUG01f+VATeIFhb05
I0HhxTLzOjKvqMIDjKEcpnYXkXWVWogrKDt54oYhmkUDQ5vXiNgm0OBKGJAzkHRw
62aZbfgVMpP4kUUIkF8SSFER4mcSxRidW9ZxmPdnPgMh4Z1oBpQIey/r5Kl1UYhK
6uInpEbJjWDo+9CnAxWTo0FqIo9wsYNfu84Wxh9tWdmj+ZghiQN1hUlh/JxmqxUH
REgQOznvXLX9N+xf9rrU
=fqBm
-----END PGP SIGNATURE-----

--SCOJXUq1iwCn05li--

--===============5309692295088582965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5309692295088582965==--
