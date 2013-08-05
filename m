From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 00/13] Adding SPDIF support to
	kirkwood-i2s
Date: Mon, 5 Aug 2013 17:59:57 +0100
Message-ID: <20130805165957.GT9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <20130805140729.GC9858@sirena.org.uk>
 <51FFBF03.1000507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5513839390597428276=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EF87F26508F
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 19:00:03 +0200 (CEST)
In-Reply-To: <51FFBF03.1000507@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5513839390597428276==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/pvhSYML5Ks7+ZI"
Content-Disposition: inline


--W/pvhSYML5Ks7+ZI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2013 at 05:04:35PM +0200, Sebastian Hesselbarth wrote:

> I cannot follow you on the clocking arrangements. The binding
> proposal was for audio controller <-> CODEC connections. For clocks
> there are common properties ("clocks", "clock-names", "clock-frequency")
> to pass them to drivers - for "sound cards" in general there are not.

The clocking arrangements are an example of why the boards can get
interesting enough to describe for themselves.

> So, having a look at the node in question:

> sound {
>   compatible =3D "nvidia,tegra-audio-rt5640-beaver",
>                "nvidia,tegra-audio-rt5640";
>   nvidia,model =3D "NVIDIA Tegra Beaver";
>=20
>   nvidia,audio-routing =3D "Headphones", "HPOR",
>                          "Headphones", "HPOL";
>=20
>   nvidia,i2s-controller =3D <&tegra_i2s1>;
>   nvidia,audio-codec =3D <&rt5640>;
>=20
>   nvidia,hp-det-gpios =3D <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
>=20
>   clocks =3D <&tegra_car TEGRA30_CLK_PLL_A>,
>            <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
>            <&tegra_car TEGRA30_CLK_EXTERN1>;
>   clock-names =3D "pll_a", "pll_a_out0", "mclk";
> };
>=20
> all those "nvidia," prefixed properties are not nvidia-specific at all.

This is all because you have to add a prefix for DT.

> Also, all those "nvidia," properties would have fit very well into the
> i2s controller node

No, almost none of them have any place there.  For example, the audio
routing contains only connections to the CODEC so the I2S controller
isn't in play, the headphone detection is connected to the AP but isn't
connected to the I2S port.

>                     - there may be more complex SoCs requiring an extra
> "sound card" node, Tegra is not.

This is nothing to do with the SoC and all to do with the rest of the
board - Tegra systems will frequently have these issues since Tegra is
frequently deployed in smartphones which tend to push the limits on
these things.

The smartphone use case will typically have a separate digital clock
domain for the baseband, there will usually also be a bluetooth SCO link
slaved to one of the other digital domains.  Start drilling down into
the details and you'll usually find a bit more complexity and usually a
bunch of device specific constraints too.

> Even those foo-gpios properties can be generalized and moved to ASoC;
> have a look at MMC drivers using one common "cd-gpios" property for
> very different drivers. What is so special with Tegra and this gpio
> that it needs a vendor-specific property?

This is mostly just a function of the DT convention requiring a vendor
prefix be shoved on everything.

> I was asking for generalizing those exact properties to generic ones
> and them move support for them to the ASoC/ALSA framework. With all
> that DT binding re-review coming up, I doubt that the tegra binding
> will be accepted again anyway.

Sure it would.

> >> i2s1: audio-controller@b0000 {
> >> 	compatible =3D "marvell,dove-i2s";
> >> 	reg =3D <0xb0000 0x2345>;
> >> 	audio-codecs =3D <&spdif 0>;
> >> };

> > No, things are glued together using the machine driver - again, look at
> > how all the other systems work.  The wiring on the board can get
> > interesting enough to need a binding of its own, for very simple
> > bindings that should just be pointing to a generic driver.

> I learned to never match "device nodes" with "drivers" as there
> is simply no relation between them.

That's clearly a thinko for device node.

> So, back to my original node proposal, can you tell me what is so
> different, except that I am not using "marvell,audio-codec(s)" but
> "audio-codecs"; and hook the one available codec output by using
> phandle/args instead of a new compatible string?

=46rom my point of view I'd rather not be shoving vendor prefixes on all
the properties, this is coming from DT convention requiring vendor
prefixes on bindings.

--W/pvhSYML5Ks7+ZI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/9oKAAoJELSic+t+oim953IP/jvDzqw0Ax7Tf0mF0hYVouDB
lBThNTBOoDuC5/V6n8k2y2YZYZ+52621IjdUdDBZxWcT3ZxU9yykZUWv1fxlRUri
dVtoFZpssAL3yyA1fGVtsZ6hgOp90IOaZljxrlK6kj1j29JQuJC/0Hx5Gi+0TPSp
8Jg4rlr39hPxaUAwExb6fN9AaO8uObokK+ul0Dq+3TJ0QPbiJx0JNkVUeP5boWkd
/IVwkAnH+Pqo0affdD30wuANhdifwbbzleXy/4C+ZSH38k+BThxxSpptWK7nq2LR
iorn0sLp2zA9ly5J7P2rhfGl1mpF9N9GyJ3TEW5qJqUNE5EwiQ8kQq+eqE5DNUA1
R8bea0LJvAwSz5tablTDuR4BdCVlKvajK/z7jGIu/930tTrnP686q8YCtZcphqdp
SdoMZp1XGe8k6DcZ9RY+LyBdSyVVb07oxfRdEfrX8/i9/ka7ikZEaVOujeVKxrM+
V/bWGI5Up51NggHtBb5YgSAjZd7sM3NT5hfrRxPJ6dZ4pphYfMsA+YlKZo8Br3y0
rQ48V+6MK1vAZnIEzJnZLGquoHvyaXXoz8B64H02F0QbCd6qGTs/ui8jhruSSTk6
mDRC58/qBclQqV2yn7yNJInuISbfF43sleY23aXkQDws7lZ8KamW5F5B0WnObzO3
b1nEKzGfMXHUszMjykOs
=aMVh
-----END PGP SIGNATURE-----

--W/pvhSYML5Ks7+ZI--

--===============5513839390597428276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5513839390597428276==--
