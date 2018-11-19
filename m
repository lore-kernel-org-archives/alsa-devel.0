From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: add bindings for AK4118 transceiver
Date: Mon, 19 Nov 2018 11:55:44 +0100
Message-ID: <CAJiuCceJTd-h2WDZHtkpeO=-Zqcc2Kf-AY8KV8LrY9NM-BP+jg@mail.gmail.com>
References: <20181114121642.1404-1-peron.clem@gmail.com> <20181114121642.1404-2-peron.clem@gmail.com>
 <20181117155140.GA11554@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181117155140.GA11554@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Rob,

On Sat, 17 Nov 2018 at 16:51, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 14, 2018 at 01:16:42PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Document the bindings for AK4118 S/PDIF transceiver
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  .../devicetree/bindings/sound/ak4118.txt      | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/ak4118.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/ak4118.txt b/Docum=
entation/devicetree/bindings/sound/ak4118.txt
> > new file mode 100644
> > index 000000000000..6e11a2f7404c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/ak4118.txt
> > @@ -0,0 +1,22 @@
> > +AK4118 S/PDIF transceiver
> > +
> > +This device supports I2C mode.
> > +
> > +Required properties:
> > +
> > +- compatible : "asahi-kasei,ak4118"
> > +- reg : The I2C address of the device for I2C
> > +- reset-gpios: A GPIO specifier for the reset pin
> > +- irq-gpios: A GPIO specifier for the IRQ pin
>
> This should use 'interrupts' instead.
Yes, this will also simplify the driver.

>
> > +
> > +Example:
> > +
> > +&i2c {
> > +     ak4118: ak4118@13 {
>
> spdif@13 ? Node names should be based on the class of device, but
> there's not really one defined for this.

Ok I will use spdif.

Thanks for the comments,
Clement

>
> > +             #sound-dai-cells =3D <0>;
> > +             compatible =3D "asahi-kasei,ak4118";
> > +             reg =3D <0x13>;
> > +             reset-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW>
> > +             irq-gpios =3D <&gpio 1 GPIO_ACTIVE_HIGH>;
> > +     };
> > +};
> > --
> > 2.19.1
> >
