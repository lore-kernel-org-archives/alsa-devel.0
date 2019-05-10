From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: sound: sun4i-spdif: Document that
 the RX channel can be missing
Date: Fri, 10 May 2019 12:26:28 +0200
Message-ID: <20190510102628.u344cqe7sftuamfg@flea>
References: <dc84c7e9ce272109052f553a5e050bfe1a09e9d6.1557252411.git-series.maxime.ripard@bootlin.com>
 <d9afb19c32f8b9b2c40c8d4c0c3df74bff0ccf35.1557252411.git-series.maxime.ripard@bootlin.com>
 <CAL_Jsq+iLmzti5TX-TUU3PN4taC66UMqHMk-aKTjZKt1kVRtMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+iLmzti5TX-TUU3PN4taC66UMqHMk-aKTjZKt1kVRtMQ@mail.gmail.com>
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

Hi Rob,

On Wed, May 08, 2019 at 02:35:10PM -0500, Rob Herring wrote:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: allwinner,sun8i-h3-spdif
> > +
> > +    then:
> > +      properties:
> > +        dmas:
> > +          maxItems: 1
>
> In this and below, these should get added automatically by
> fixup_schema. If not present, we set minItems/maxItems to the size of
> the items list. It look like you added support for that, so left over
> from before you addressed that for if/then/else?

Sorry, I should have brought that up in the pull request.

It seems that it's still necessary when using allOf, otherwise the
schema won't match

Maybe there's something more to fix when using allOf?

> > +          items:
> > +            - description: RX DMA Channel
>
> s/RX/TX/
>
> > +
> > +        dma-names:
> > +          maxItems: 1
> > +          items:
> > +            - const: tx
> > +
> > +    else:
> > +      properties:
> > +        dmas:
> > +          minItems: 2
> > +          maxItems: 2
> > +          items:
> > +            - description: RX DMA Channel
> > +            - description: TX DMA Channel
> > +
> > +        dma-names:
> > +          minItems: 2
> > +          maxItems: 2
> > +          items:
> > +            - const: rx
> > +            - const: tx
>
> I'm really on the fence whether it's worth it to add all this just add
> the restrictions based on the compatible. I guess with copy-n-paste
> this would be a common error.

Converting most of the bindings to the schemas has shown that (at
least in our case), we've been pretty bad at keeping the documentation
up to date with that kind of information.

Adding that kind of construct at least has the benefit to actively
enforce that the documentation is complete.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
