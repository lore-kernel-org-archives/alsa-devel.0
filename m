From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2602: Fix ADC powerup sequencing
Date: Wed, 23 May 2018 11:53:52 -0500
Message-ID: <20180523165352.GA6187@rob-hp-laptop>
References: <20180517133009.26079-1-m.felsch@pengutronix.de>
 <CAL_JsqKhkVOYf+XEA3MYpK4JYfMrZTbHZtoXgaH=wCBRoU6cfQ@mail.gmail.com>
 <1526640409.3948.5.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f193.google.com (mail-yb0-f193.google.com
 [209.85.213.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 965C32672AF
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 18:53:57 +0200 (CEST)
Received: by mail-yb0-f193.google.com with SMTP id i13-v6so7865538ybl.4
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 09:53:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1526640409.3948.5.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <s.hauer@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Fri, May 18, 2018 at 12:46:49PM +0200, Philipp Zabel wrote:
> Hi Rob,
> =

> On Thu, 2018-05-17 at 11:14 -0500, Rob Herring wrote:
> > On Thu, May 17, 2018 at 8:30 AM, Marco Felsch <m.felsch@pengutronix.de>=
 wrote:
> > > From: Philipp Zabel <p.zabel@pengutronix.de>
> > > =

> > > According to the ssm2603 data sheet (control register sequencing), the
> > > digital core should be activated only after all necessary bits in the
> > > power register are enabled, and a delay determined by the decoupling
> > > capacitor on the VMID pin has passed. If the digital core is activated
> > > too early, or even before the ADC is powered up, audible artifacts
> > > appear at the beginning of the recorded signal.
> > > =

> > > The digital core is also needed for playback, so when recording starts
> > > it may already be enabled. This means we cannot get the power sequence
> > > correct when we want to be able to start recording after playback.
> > > =

> > > As a workaround put the MIC mute switch into the DAPM routes. This
> > > way we can keep the recording disabled until the MIC Bias has settled
> > > and thus get rid of audible artifacts.
> > > =

> > > The delay we have to wait depends on a board specific capacitor
> > > connected to the VMID pins, so make the delay configurable in the dev=
ice
> > > tree.
> > > =

> > > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  .../devicetree/bindings/sound/adi,ssm2602.txt |  7 +++++
> > >  sound/soc/codecs/ssm2602.c                    | 30 +++++++++++++++++=
--
> > >  2 files changed, 35 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt =
b/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
> > > index 3b3302fe399b..9334d48c0462 100644
> > > --- a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
> > > +++ b/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
> > > @@ -11,9 +11,16 @@ Required properties:
> > >    - reg : the I2C address of the device for I2C, the chip select
> > >            number for SPI.
> > > =

> > > +Optional properties:
> > > +
> > > +  - startup-delay-us : delay between powering on and activating the =
digital
> > > +                       core, determined by the decoupling capacitor =
C on the
> > > +                      VMID pin: delay [=B5s] =3D C [=B5F] * 25000 / =
3.5
> > > +
> > =

> > We already have similarly defined property. Please reuse that. See mmc
> > pwrseq binding.
> =

> Do you mean 'post-power-on-delay-ms' from 'mmc-pwseq-simple'?
> It is documented as:
> =

> - post-power-on-delay-ms : Delay in ms after powering the card and
> =A0=A0=A0=A0=A0=A0=A0=A0de-asserting the reset-gpios (if any)
> =

> The startup delay here is not after powering the whole IC or deasserting
> resets and before it can be used, but after powering up a specific part
> of the codec (the ADC) and before unmuting the MIC input to the digital
> core during start of decoding. With this in mind, do you still think the
> property should be called the same as the mmc full-chip poweron delay?
> If so, would it be acceptable to use post-power-on-delay-us to keep the
> microsecond resolution?

Okay, then I'd suggest something a bit more specific. Perhaps =

"pre-unmute-delay-us" and document in a common location.

Rob
