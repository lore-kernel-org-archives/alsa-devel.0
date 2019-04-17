From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: Convert Allwinner SPDIF binding
 to YAML
Date: Wed, 17 Apr 2019 20:22:29 +0200
Message-ID: <20190417182229.ih4c76zlktoz43no@flea>
References: <4060ec46117ccf3cd643b8f1b9759ed44d38c5e7.1555330005.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqLuMObaNzrRMGDi-m=0B8AA7CYqJkrvD_K3cTmH7rdE4Q@mail.gmail.com>
 <20190417064338.wuzjkixbg7noolwx@flea>
 <CAL_Jsq+3rJqFjz-n3b3OUXRewpEh2-uFFDExnhEvPH0-t-gFJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1240814916174229661=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_Jsq+3rJqFjz-n3b3OUXRewpEh2-uFFDExnhEvPH0-t-gFJQ@mail.gmail.com>
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


--===============1240814916174229661==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tefkikc4bxoaaatp"
Content-Disposition: inline


--tefkikc4bxoaaatp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Apr 17, 2019 at 11:04:22AM -0500, Rob Herring wrote:
> On Wed, Apr 17, 2019 at 1:43 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > On Tue, Apr 16, 2019 at 04:36:18PM -0500, Rob Herring wrote:
> > > On Mon, Apr 15, 2019 at 7:07 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > The Allwinner SoCs feature an SPDIF controller across multiple SoC
> > > > generations.
> > > >
> > > > However, earlier generations were a bit simpler than the subsequent ones,
> > > > and for example would always have RX and TX capabilities, and no reset
> > > > lines.
> > > >
> > > > In order to express this, let's create two YAML schemas instead of the free
> > > > form text we had before.
> > >
> > > The only difference is 'reset' is required in one? Perhaps better to
> > > just not make 'reset' required til we figure out how to handle a
> > > conditional like this. Seems like we discussed this and I probably
> > > said to split things?
> >
> > We indeed discussed this, and this was one of the solutions to support
> > this. I wanted to get the discussion started as of how exactly we want
> > to support this kind of construct.
> >
> > I looked it up a bit, and it looks like json schema 7 introduces
> > conditionals that would allow us to deal with this nicely.
> >
> > https://json-schema.org/understanding-json-schema/reference/conditionals.html
> >
> > Is that something we can switch to while we have not a lot of schemas,
> > or would that require some significant work?
>
> We need check if the json-schema library supports this yet. I think it
> should as there was an issue for it which is closed now.

Apparently, it's supported since 3.0.0, that got released on the 24th
of february.

I mass converted the yaml-bindings code to use the draft 7, and the
tests are passing (and a dtbs_check run seems legit too). So that went
smoothly...

> We'll then need to update the meta-schema and maybe the schema fixups
> to handle this case.

... except that after adding if, then and else to the meta-schemas, a
schema using that construct doesn't do anything (well, anything more
than what it is doing without if / then / else).

Apart from the fact that it doesn't work as expected (yet), the syntax
is pretty elegant, so I guess we should go for that.

> We should have a test case in the library too.
> Test cases are important given that if you get schemas wrong, the
> result is silence.

ACK

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tefkikc4bxoaaatp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLdu5QAKCRDj7w1vZxhR
xYlgAP97IqVF5fO1aPEzM1HFWtt8n6MTmx0022LTZi37wna52AEA1qrL1/YURm5l
mRRl+31fa94EWSCcqxm7arPTopF0Iwk=
=gP91
-----END PGP SIGNATURE-----

--tefkikc4bxoaaatp--


--===============1240814916174229661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1240814916174229661==--
