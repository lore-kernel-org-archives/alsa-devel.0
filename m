From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 09/14] dt-bindings: sound: Add sun8i codec documentation
Date: Tue, 4 Oct 2016 18:19:50 +0200
Message-ID: <20161004161950.GP5228@lukather>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <a5b0bdc6b50dfcc2dc0145d00edd08fee3ce7764.1475571575.git.mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Bi+HF1AHjw0mn3zx"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a5b0bdc6b50dfcc2dc0145d00edd08fee3ce7764.1475571575.git.mylene.josserand@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: vinod.koul@intel.com, wens@csie.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lee.jones@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com, alexandre.belloni@free-electrons.com
List-Id: alsa-devel@alsa-project.org


--Bi+HF1AHjw0mn3zx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 04, 2016 at 11:46:22AM +0200, Myl=E8ne Josserand wrote:
> Add the documentation for dt-binding of the digital audio codec driver
> for sun8i SoC.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  .../devicetree/bindings/sound/sun8i-codec.txt      | 24 ++++++++++++++++=
++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec.t=
xt
>=20
> diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec.txt b/Do=
cumentation/devicetree/bindings/sound/sun8i-codec.txt
> new file mode 100644
> index 0000000..1808869
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sun8i-codec.txt
> @@ -0,0 +1,24 @@
> +* Allwinner A23/A33 Codec
> +
> +Required properties:
> +- compatible: must be either "allwinner,sun4i-a23-codec" or
> +  "allwinner,sun7i-a33-codec"

Copy and paste issue ? :)

One compatible by line is usually favored, since when you'll add new
compatibles, you don't have to modify the context.xs

> +- reg: must contain the registers location and length
> +- interrupts: must contain the codec interrupt
> +- clocks: a list of phandle + clock-specifer pairs, one for each entry
> +  in clock-names.
> +- clock-names: should contain followings:
> +   - "apb": the parent APB clock for this controller
> +   - "codec": the parent module clock

We're usually calling them "bus" and "mod".

> +
> +Example:
> +codec: codec@01c22e00 {
> +	#sound-dai-cells =3D <0>;
> +	compatible =3D "allwinner,sun8i-a33-codec";
> +	reg =3D <0x01c22e00 0x400>; /* SUNXI_AUDIO_PBASE + 0x200 */
> +	reg-names =3D "audio";

You don't define reg-names in your bindings, while your code relies on
it. It isn't really needed, since you have only one couple of base +
size, so it should just go away.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--Bi+HF1AHjw0mn3zx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX89amAAoJEBx+YmzsjxAgAvsP/0g2m6b5C2k2QAmN/LjCdE9v
p2o912Ypsefw2Cx4Bi1hvgMFq5+6mRNZIH7qoypMSCO3FL5mAtRWcFz9d0Ej4KMp
SnRxfCtfa68t54V677eDTGp0gEhS0iCiehxgz5hkNJnw5r6FXpUM0HzTq8fbPiI6
vUhwOF+wGKqVYfpwEL9lA7tDixtspnDAJlbTQEH7EXkeR03HKPD2DB9eG1LfHYMl
M+cNv17eBlG3xuMl58jvrhJr2ndk/rpEgieoBPagJr6lU3WFLRCQovL8hiJjHbyl
alISLNzhKWdq34xfSw8Jw8UB5ViFtbYUDPTkM5PAwU2Qud29KbRir1vXFCL1KpeW
kOcDrRK0UjWYn7tKHJz4/Tx9mYFYlCNvl+okOL6OgkfdhFXCJXM5srGHjaUi2BR6
5pwbHB3OTc5VD7LGk1av0+OCN0TUxYuC+lS+ppXmqqjtIRh5pKo+fSrTgFoBe47Q
Zd+pHYdoHrvPflcx6A2LI3eqQKH8Xajcq3RClkZV06x0+hO3IjDEG+TBd/yA1MS+
sn6hBjfXN4H8Wrnz2qTNng5vzH7TO0D5fUpz1GP1Y93lnQ2Xg10486vMcC4AsLUh
AwJe1qzqe+bTSDYfFW0FkQWpqSAEMMUKcJ6yMUb2JxW+nhundREUTRvgp++SDTte
1SvrCsYrmBwzi/cCNo6L
=PCFx
-----END PGP SIGNATURE-----

--Bi+HF1AHjw0mn3zx--
