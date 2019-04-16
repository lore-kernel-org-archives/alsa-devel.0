From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/2] dt-bindings: sound: sun6i-spdif: Document that the
 RX channel can be missing
Date: Tue, 16 Apr 2019 09:19:16 +0200
Message-ID: <20190416071916.y5cdqhdlljcasbsn@flea>
References: <4060ec46117ccf3cd643b8f1b9759ed44d38c5e7.1555330005.git-series.maxime.ripard@bootlin.com>
 <e671a8289b7176b1eacb79edf443575f940f4a22.1555330005.git-series.maxime.ripard@bootlin.com>
 <CAL_Jsq+nv4fOBEVswtXFVvC_Va4suWa9F9H=E4Vt1xw6K7z-Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1877212161623617478=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_Jsq+nv4fOBEVswtXFVvC_Va4suWa9F9H=E4Vt1xw6K7z-Ng@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1877212161623617478==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="66vwobinpu2khg3v"
Content-Disposition: inline


--66vwobinpu2khg3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rob,

On Mon, Apr 15, 2019 at 08:36:28PM -0500, Rob Herring wrote:
> On Mon, Apr 15, 2019 at 7:07 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Not all controllers using the A31 SPDIF binding actually have some RX
> > capabilities, and therefore on some controllers we don't have the option to
> > set an RX DMA channel.
> >
> > This was already done in the DTSI, but the binding itself was never
> > updated.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml
> > index 7329d9fcf34c..800f794fafe0 100644
> > --- a/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml
> > +++ b/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml
> > @@ -44,14 +44,24 @@ properties:
> >        - const: spdif
> >
> >    dmas:
> > +    minItems: 1
> > +    maxItems: 2
> >      items:
> >        - description: RX DMA Channel
> >        - description: TX DMA Channel
> > +    description:
> > +      Some controllers cannot receive but can only transmit data. In
> > +      such a case, the RX DMA channel is to be omitted.
>
> Really, the schema is saying rx is optional, but it doesn't really
> matter here as the schema for each item is just 'description'.

What should I do here then?

Remove the global description and leave only the one under items?

Also, it won't necessarily match the dma-names (since rx might be
there or not), does it matter or is it obvious enough that we don't
care?

> >    dma-names:
> > -    items:
> > -      - const: rx
> > -      - const: tx
> > +    minItems: 1
> > +    maxItems: 2
> > +    enum:
> > +      - rx
> > +      - tx
> > +    description:
> > +      Some controllers cannot receive but can only transmit data. In
> > +      such a case, the RX name is to be omitted.
>
> Here it matters though. This would allow just 'tx', '"tx", "tx"', or
> either order.
>
> You need something like this:
>
> oneOf:
>   -  items:
>        - const: rx
>        - const: tx
>   - const: tx

Ok.

> Ideally, we'd always put the required entry first and avoid this
> problem. Not always possible if the first entry gets removed in later
> h/w.

One of the question I was wondering myself when I wrote those schemas
is how are we supposed to deal with lists that need to have a
particular set of values, but without any particular order?

rx and tx here is a good example of that. We need both (let's leave
the "missing RX" case aside for a minute), but since we reference them
by name, '"rx", "tx"' is strictly equivalent to '"tx", "rx"'. Yet,
items cares about the order, so the latter would fail to validate with
that schemas.

Should we do something like:

oneOf:
  - items:
    - const: rx
    - const: tx
  - items:
    - const: tx
    - const: rx

or is there a smarter way?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--66vwobinpu2khg3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLWB9AAKCRDj7w1vZxhR
xffyAP9UZfK9BvgAeeXbHg8xnYpoPU/Ngje1hn9CDL7Qnt9mHAD5Ae9wb0NzuR+p
+IR8YcXo4JXNTn6ySKzuAJ4IB+IyfAo=
=kFjx
-----END PGP SIGNATURE-----

--66vwobinpu2khg3v--


--===============1877212161623617478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1877212161623617478==--
