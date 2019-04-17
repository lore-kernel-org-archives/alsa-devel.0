From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: sound: Convert Allwinner SPDIF binding
 to YAML
Date: Wed, 17 Apr 2019 11:04:22 -0500
Message-ID: <CAL_Jsq+3rJqFjz-n3b3OUXRewpEh2-uFFDExnhEvPH0-t-gFJQ@mail.gmail.com>
References: <4060ec46117ccf3cd643b8f1b9759ed44d38c5e7.1555330005.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqLuMObaNzrRMGDi-m=0B8AA7CYqJkrvD_K3cTmH7rdE4Q@mail.gmail.com>
 <20190417064338.wuzjkixbg7noolwx@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190417064338.wuzjkixbg7noolwx@flea>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 17, 2019 at 1:43 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Rob,
>
> On Tue, Apr 16, 2019 at 04:36:18PM -0500, Rob Herring wrote:
> > On Mon, Apr 15, 2019 at 7:07 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > The Allwinner SoCs feature an SPDIF controller across multiple SoC
> > > generations.
> > >
> > > However, earlier generations were a bit simpler than the subsequent ones,
> > > and for example would always have RX and TX capabilities, and no reset
> > > lines.
> > >
> > > In order to express this, let's create two YAML schemas instead of the free
> > > form text we had before.
> >
> > The only difference is 'reset' is required in one? Perhaps better to
> > just not make 'reset' required til we figure out how to handle a
> > conditional like this. Seems like we discussed this and I probably
> > said to split things?
>
> We indeed discussed this, and this was one of the solutions to support
> this. I wanted to get the discussion started as of how exactly we want
> to support this kind of construct.
>
> I looked it up a bit, and it looks like json schema 7 introduces
> conditionals that would allow us to deal with this nicely.
>
> https://json-schema.org/understanding-json-schema/reference/conditionals.html
>
> Is that something we can switch to while we have not a lot of schemas,
> or would that require some significant work?

We need check if the json-schema library supports this yet. I think it
should as there was an issue for it which is closed now.

We'll then need to update the meta-schema and maybe the schema fixups
to handle this case. We should have a test case in the library too.
Test cases are important given that if you get schemas wrong, the
result is silence.

Rob
