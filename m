From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/2] dt-bindings: sound: sun6i-spdif: Document that the
 RX channel can be missing
Date: Wed, 17 Apr 2019 20:24:41 +0200
Message-ID: <20190417182441.gluqwwoziybabmz5@flea>
References: <4060ec46117ccf3cd643b8f1b9759ed44d38c5e7.1555330005.git-series.maxime.ripard@bootlin.com>
 <e671a8289b7176b1eacb79edf443575f940f4a22.1555330005.git-series.maxime.ripard@bootlin.com>
 <CAL_Jsq+nv4fOBEVswtXFVvC_Va4suWa9F9H=E4Vt1xw6K7z-Ng@mail.gmail.com>
 <20190416071916.y5cdqhdlljcasbsn@flea>
 <CAL_JsqK6oyfdAPuivH7Z6tf1iqArbcbguRinOA3Xu0Lf=GOiGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0824315503129564653=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqK6oyfdAPuivH7Z6tf1iqArbcbguRinOA3Xu0Lf=GOiGQ@mail.gmail.com>
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


--===============0824315503129564653==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sxwgxl2i3bech6el"
Content-Disposition: inline


--sxwgxl2i3bech6el
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2019 at 04:50:35PM -0500, Rob Herring wrote:
> On Tue, Apr 16, 2019 at 2:19 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On Mon, Apr 15, 2019 at 08:36:28PM -0500, Rob Herring wrote:
> > > On Mon, Apr 15, 2019 at 7:07 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > Not all controllers using the A31 SPDIF binding actually have some RX
> > > > capabilities, and therefore on some controllers we don't have the option to
> > > > set an RX DMA channel.
> > > >
> > > > This was already done in the DTSI, but the binding itself was never
> > > > updated.
> > > >
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml | 16 +++++++++++++---
> > > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml
> > > > index 7329d9fcf34c..800f794fafe0 100644
> > > > --- a/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml
> > > > +++ b/Documentation/devicetree/bindings/sound/allwinner,sun6i-a31-spdif.yaml
> > > > @@ -44,14 +44,24 @@ properties:
> > > >        - const: spdif
> > > >
> > > >    dmas:
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > >      items:
> > > >        - description: RX DMA Channel
> > > >        - description: TX DMA Channel
> > > > +    description:
> > > > +      Some controllers cannot receive but can only transmit data. In
> > > > +      such a case, the RX DMA channel is to be omitted.
> > >
> > > Really, the schema is saying rx is optional, but it doesn't really
> > > matter here as the schema for each item is just 'description'.
> >
> > What should I do here then?
> >
> > Remove the global description and leave only the one under items?
>
> I think the opposite. Just drop 'items' and leave 'description'.
>
> > Also, it won't necessarily match the dma-names (since rx might be
> > there or not), does it matter or is it obvious enough that we don't
> > care?
> >
> > > >    dma-names:
> > > > -    items:
> > > > -      - const: rx
> > > > -      - const: tx
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > > +    enum:
> > > > +      - rx
> > > > +      - tx
> > > > +    description:
> > > > +      Some controllers cannot receive but can only transmit data. In
> > > > +      such a case, the RX name is to be omitted.
> > >
> > > Here it matters though. This would allow just 'tx', '"tx", "tx"', or
> > > either order.
> > >
> > > You need something like this:
> > >
> > > oneOf:
> > >   -  items:
> > >        - const: rx
> > >        - const: tx
> > >   - const: tx
> >
> > Ok.
> >
> > > Ideally, we'd always put the required entry first and avoid this
> > > problem. Not always possible if the first entry gets removed in later
> > > h/w.
> >
> > One of the question I was wondering myself when I wrote those schemas
> > is how are we supposed to deal with lists that need to have a
> > particular set of values, but without any particular order?
>
> 'items' can be a list or dictionary. When it's a dictionary, the
> schema for 'items' is applied to each item. For example:
>
> items:
>   enum: [ rx, tx ]
>   uniqueItems: true
>
> 'uniqueItems' prevents the case of 'rx, rx' or 'tx, tx'.

Oh, so that's how you use uniqueItems. I've been struggling with it to
cover the ALSA routing options that will have non-unique strings, but
string-array didn't let me. I'll test that.

> > rx and tx here is a good example of that. We need both (let's leave
> > the "missing RX" case aside for a minute), but since we reference them
> > by name, '"rx", "tx"' is strictly equivalent to '"tx", "rx"'. Yet,
> > items cares about the order, so the latter would fail to validate with
> > that schemas.
>
> Even when we reference things by name, the order should be defined
> still. Using names allows for skipping entries.
>
> If you have a mixture, I'd prefer to see dts files cleaned-up.

That works for me, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sxwgxl2i3bech6el
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLdvaQAKCRDj7w1vZxhR
xUVaAP9XMxL6SQXibEOcVv6XQ+IhCns/yrvqojpTxrNq91j1aQD8C/Vt6NaZ96rN
s5jZ8AqnLHxf6a3Iu4d87LvMkAq27wg=
=Gt+T
-----END PGP SIGNATURE-----

--sxwgxl2i3bech6el--


--===============0824315503129564653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0824315503129564653==--
