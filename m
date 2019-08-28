From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: sound: Convert Allwinner A33 codec to a
 schema
Date: Wed, 28 Aug 2019 14:52:46 +0200
Message-ID: <20190828125246.zy7ucra7dkiw4ia7@flea>
References: <20190827142547.14577-1-mripard@kernel.org>
 <20190827142547.14577-3-mripard@kernel.org>
 <CAGb2v67tEgtD9PEus0TaPQg9969L_7dn2c4GFZSioR1AtxBpmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5540322501219056388=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v67tEgtD9PEus0TaPQg9969L_7dn2c4GFZSioR1AtxBpmQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============5540322501219056388==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="asta7q4d6eqzmvrk"
Content-Disposition: inline


--asta7q4d6eqzmvrk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 27, 2019 at 10:29:33PM +0800, Chen-Yu Tsai wrote:
> On Tue, Aug 27, 2019 at 10:25 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > From: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > The Allwinner A33 SoC have an embedded audio codec that is supported in Linux,
> > with a matching Device Tree binding.
> >
> > Now that we have the DT validation in place, let's convert the device tree
> > bindings for that controller over to a YAML schemas.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  .../sound/allwinner,sun8i-a33-codec.yaml      | 57 +++++++++++++++++
> >  .../bindings/sound/sun8i-a33-codec.txt        | 63 -------------------
> >  2 files changed, 57 insertions(+), 63 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> > new file mode 100644
> > index 000000000000..5e7cc05bbff1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/allwinner,sun8i-a33-codec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner A33 Codec Device Tree Bindings
> > +
> > +maintainers:
> > +  - Chen-Yu Tsai <wens@csie.org>
> > +  - Maxime Ripard <maxime.ripard@bootlin.com>
> > +
> > +properties:
> > +  "#sound-dai-cells":
> > +    const: 0
> > +
> > +  compatible:
> > +    const: allwinner,sun8i-a33-codec
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Bus Clock
> > +      - description: Module Clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bus
> > +      - const: mod
> > +
> > +required:
> > +  - "#sound-dai-cells"
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    audio-codec@1c22e00 {
> > +      #sound-dai-cells = <0>;
> > +      compatible = "allwinner,sun8i-a33-codec";
> > +      reg = <0x01c22e00 0x400>;
> > +      interrupts = <0 29 4>;
> > +      clocks = <&ccu 47>, <&ccu 92>;
> > +      clock-names = "bus", "mod";
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
> > deleted file mode 100644
> > index 7ecf6bd60d27..000000000000
> > --- a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
> > +++ /dev/null
> > @@ -1,63 +0,0 @@
> > -Allwinner SUN8I audio codec
> > -------------------------------------
> > -
> > -On Sun8i-A33 SoCs, the audio is separated in different parts:
> > -         - A DAI driver. It uses the "sun4i-i2s" driver which is
> > -         documented here:
> > -         Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
> > -         - An analog part of the codec which is handled as PRCM registers.
> > -         See Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
> > -         - An digital part of the codec which is documented in this current
> > -         binding documentation.
> > -         - And finally, an audio card which links all the above components.
> > -         The simple-audio card will be used.
> > -         See Documentation/devicetree/bindings/sound/simple-card.txt
> > -
> > -This bindings documentation exposes Sun8i codec (digital part).
> > -
> > -Required properties:
> > -- compatible: must be "allwinner,sun8i-a33-codec"
> > -- reg: must contain the registers location and length
> > -- interrupts: must contain the codec interrupt
> > -- clocks: a list of phandle + clock-specifer pairs, one for each entry
> > -  in clock-names.
> > -- clock-names: should contain followings:
> > -   - "bus": the parent APB clock for this controller
> > -   - "mod": the parent module clock
> > -
> > -Here is an example to add a sound card and the codec binding on sun8i SoCs that
> > -are similar to A33 using simple-card:
> > -
> > -       sound {
> > -               compatible = "simple-audio-card";
> > -               simple-audio-card,name = "sun8i-a33-audio";
> > -               simple-audio-card,format = "i2s";
> > -               simple-audio-card,frame-master = <&link_codec>;
> > -               simple-audio-card,bitclock-master = <&link_codec>;
> > -               simple-audio-card,mclk-fs = <512>;
> > -               simple-audio-card,aux-devs = <&codec_analog>;
> > -               simple-audio-card,routing =
> > -                               "Left DAC", "Digital Left DAC",
> > -                               "Right DAC", "Digital Right DAC";
>
> At some point we should start listing the endpoints available for routing?

Yeah, we should do that. I'm not sure how easy it would be using the
schemas though.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--asta7q4d6eqzmvrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWZ5HgAKCRDj7w1vZxhR
xXkPAP45zvC7zUeQS2lM/nuzMIyZuUlKZcv+ZSPsCmK5nymqtQD/Zgsn1N/j/WrL
6VwTMy3hqtsI1G18kLcl6eq/vQdYsAw=
=pJOp
-----END PGP SIGNATURE-----

--asta7q4d6eqzmvrk--


--===============5540322501219056388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5540322501219056388==--
