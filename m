From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: new ac97 bus and codec clock
Date: Tue, 19 Jun 2018 16:02:04 +0100
Message-ID: <20180619150204.GF11230@sirena.org.uk>
References: <87lgbdqixh.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2862301511289185152=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 468E82675D5
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 17:02:05 +0200 (CEST)
In-Reply-To: <87lgbdqixh.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2862301511289185152==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Content-Disposition: inline


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 17, 2018 at 10:03:54PM +0200, Robert Jarzmik wrote:

> The new ac97 is working well in a platform data build. But in the device =
tree
> case, there is an issue, triggered by our review in [1].

> The main issue is the lack of one clock.

> The device hierarchy is :
>  - platform device sound@40500000 (the AC97 controller)
>    \-> ac97 device sound@40500000:0 (the discovered ac97 IP for a wm9713)

> Now the issue is here :
>  - sound/ac97/bus.c:419, function ac97_get_enable_clk()
>  - the clk_get() fails

> The sound@40500000:0 device was automatically created by the AC97 bus cod=
e, but
> I don't see any way to provide this device the "ac97_clk" ... How do you =
think
> this is supposed to work, and how can my devicetree description provide t=
his
> clock ?

This sounds like a DT question - how do you hook things up using DT to a
device that will be enumerated from the hardware?  I'm not sure what
best practice is here, adding Rob and Frank.

> [1] Discussion reference
> https://groups.google.com/forum/#!msg/linux.kernel/6_zIXK_maA4/RMYsmLlRMg=
AJ
> Look for "You probably mean the BITCLK clock."
>=20
> [2] Device tree extract
> ac97: sound@40500000 {
>       	compatible =3D "marvell,pxa270-ac97";
> 	reg =3D < 0x40500000 0x1000 >;
> 	interrupts =3D <14>;
> 	reset-gpios =3D <&gpio 95 GPIO_ACTIVE_HIGH>;
> 	#sound-dai-cells =3D <1>;
> 	pinctrl-names =3D "default";
> 	pinctrl-0 =3D < &pinctrl_ac97_default >;
> 	clocks =3D <&clks CLK_AC97>, <&clks CLK_AC97CONF>;
> 	clock-names =3D "AC97CLK", "AC97CONFCLK";
> };

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlspGusACgkQJNaLcl1U
h9C59gf8COPh/tEBnZO4h8fONYqlOsxCOx0d7y84FWrQgRQ4kTIcurzQA408M1hM
gu52Su4GO5ANRvSBc7hXSSJKEgmMW4F+akWqXXGPLu6I68NlWtsVgQKFUj+7FAgc
KadNQ655ctIw1RvpRP2iJNvt1qhcKbuo0zAkoOYkPWooMp6nWDz1+b251XWqsi35
/SbjEgHJKmu6m7oXsDfXaF79g6yco/yKg3I2RFeiU8Lw6FP3NUvba9Olc+VkdSeP
K+AJml9MCKaWyeSe3MKoTtYNv816LDFFeGy7OCaEE55IiOgLynmlGh+APIp3RbvM
0JuGgDHtbkCY1LEyFxGB1XWfHoTkyg==
=muli
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--

--===============2862301511289185152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2862301511289185152==--
