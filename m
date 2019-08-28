From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: misc: atmel-ssc: LRCLK from TF/RF pin option
Date: Wed, 28 Aug 2019 13:34:20 -0500
Message-ID: <CAL_Jsq+tD1U2znUTdHxZDCJnfYa9fUeU4YMDAMMFXDka8vJ7jg@mail.gmail.com>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl> <9b85d5a7c7e788e9ed87d020323ad9292e3aeab7.1566677788.git.mirq-linux@rere.qmqm.pl>
 <20190827223716.GA31605@bogus> <20190828130252.GD20202@qmqm.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190828130252.GD20202@qmqm.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Chas Williams <3chas3@gmail.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 28, 2019 at 8:03 AM Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.=
qmqm.pl> wrote:
>
> On Tue, Aug 27, 2019 at 05:37:16PM -0500, Rob Herring wrote:
> > On Sat, Aug 24, 2019 at 10:26:55PM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
> > > Add single-pin LRCLK source options for Atmel SSC module.
> > >
> > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > >
> > > ---
> > >   v2: split from implementation patch
> > >
> > > ---
> > >  Documentation/devicetree/bindings/misc/atmel-ssc.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/D=
ocumentation/devicetree/bindings/misc/atmel-ssc.txt
> > > index f9fb412642fe..c98e96dbec3a 100644
> > > --- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> > > +++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> > > @@ -24,6 +24,11 @@ Optional properties:
> > >         this parameter to choose where the clock from.
> > >       - By default the clock is from TK pin, if the clock from RK pin=
, this
> > >         property is needed.
> > > +  - atmel,lrclk-from-tf-pin: bool property.
> > > +  - atmel,lrclk-from-rf-pin: bool property.
> > > +     - SSC in slave mode gets LRCLK from RF for receive and TF for t=
ransmit
> > > +       data direction. This property makes both use single TF (or RF=
) pin
> > > +       as LRCLK. At most one can be present.
> >
> > A single property taking 1 of possible 2 values would prevent the error
> > of more than 1 property present.
>
> It still would need a validation check in the code, though: you
> could put wrong value then.  It seems more consistent with the
> existing parameters to have two bool properties.

It was validation using schema that I was thinking about. Expressing a
possible set of values for a property is easier than inter-property
constraints.

But if you really prefer as-is:

Reviewed-by: Rob Herring <robh@kernel.org>
