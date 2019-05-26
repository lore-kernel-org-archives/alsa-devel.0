From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H6
 compatible
Date: Sun, 26 May 2019 20:22:20 +0200
Message-ID: <20190526182220.hgajlcyssujjkmiu@flea>
References: <20190525162323.20216-1-peron.clem@gmail.com>
 <20190525162323.20216-2-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4244692239526704850=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190525162323.20216-2-peron.clem@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4244692239526704850==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="psc5odxto6fmnb22"
Content-Disposition: inline


--psc5odxto6fmnb22
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2019 at 06:23:17PM +0200, Cl=E9ment P=E9ron wrote:
> Allwinner H6 has a SPDIF controller with an increase of the fifo
> size and a sligher difference in memory mapping compare to H3/A64.
>
> This make it not compatible with the previous generation.
>
> Introduce a specific bindings for H6 SoC.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.tx=
t b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> index 0c64a209c2e9..c0fbb50a4df9 100644
> --- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> +++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> @@ -7,10 +7,11 @@ For now only playback is supported.
>
>  Required properties:
>
> -  - compatible		: should be one of the following:
> +  - compatible		: Should be one of the following:
>      - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
>      - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
>      - "allwinner,sun8i-h3-spdif": for the Allwinner H3 SoC
> +    - "allwinner,sun50i-h6-spdif": for the allwinner H6 SoC

This won't apply anymore on top of next, we've moved to a YAML
schemas.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--psc5odxto6fmnb22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOrZXAAKCRDj7w1vZxhR
xehgAQDOcuI0MFI4WlSZ6gB352Ad8vsUL9N1MElpyvk09ZwjRQEAt9hBwX5dJWpV
oqCVDFu0/sZMMNzIZydtd7mLfyUf8AU=
=Vygo
-----END PGP SIGNATURE-----

--psc5odxto6fmnb22--


--===============4244692239526704850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4244692239526704850==--
