From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: Convert Allwinner SPDIF binding
 to YAML
Date: Wed, 17 Apr 2019 08:43:38 +0200
Message-ID: <20190417064338.wuzjkixbg7noolwx@flea>
References: <4060ec46117ccf3cd643b8f1b9759ed44d38c5e7.1555330005.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqLuMObaNzrRMGDi-m=0B8AA7CYqJkrvD_K3cTmH7rdE4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4551636563125464164=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqLuMObaNzrRMGDi-m=0B8AA7CYqJkrvD_K3cTmH7rdE4Q@mail.gmail.com>
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


--===============4551636563125464164==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t6senhmj6w2pwdjy"
Content-Disposition: inline


--t6senhmj6w2pwdjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rob,

On Tue, Apr 16, 2019 at 04:36:18PM -0500, Rob Herring wrote:
> On Mon, Apr 15, 2019 at 7:07 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > The Allwinner SoCs feature an SPDIF controller across multiple SoC
> > generations.
> >
> > However, earlier generations were a bit simpler than the subsequent ones,
> > and for example would always have RX and TX capabilities, and no reset
> > lines.
> >
> > In order to express this, let's create two YAML schemas instead of the free
> > form text we had before.
>
> The only difference is 'reset' is required in one? Perhaps better to
> just not make 'reset' required til we figure out how to handle a
> conditional like this. Seems like we discussed this and I probably
> said to split things?

We indeed discussed this, and this was one of the solutions to support
this. I wanted to get the discussion started as of how exactly we want
to support this kind of construct.

I looked it up a bit, and it looks like json schema 7 introduces
conditionals that would allow us to deal with this nicely.

https://json-schema.org/understanding-json-schema/reference/conditionals.html

Is that something we can switch to while we have not a lot of schemas,
or would that require some significant work?

> I guess it's a judgement call depending on how different things are.
>
> Possibly, we could handle this case like this:
>
> allOf:
>   - $ref: allwinner,sun4i-a10-spdif.yaml
>
> properties:
>   resets:
>     maxItems: 1
>
> required:
>   - resets
>
>
> Plus we'd need the 'allwinner,sun6i-a31-spdif' and other compatibles
> in both files. Note that you can't use 'additionalProperties: false'
> in either file in this case.
>
> I don't really love this solution though.

Yeah, I'm not a big fan of it either.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--t6senhmj6w2pwdjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLbLGgAKCRDj7w1vZxhR
xRGAAP0U23WPhLTRpZ+eW+5Wzh7YCHPRMtHNG1jIeLxH0gqA/AEA1MyB95x5ranG
LwOVx9QR2/eNwj5DqTrEMGZrQCLJGgA=
=Zr3Z
-----END PGP SIGNATURE-----

--t6senhmj6w2pwdjy--


--===============4551636563125464164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4551636563125464164==--
