From: Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH RFC] ARM: dts: bcm283x: Fix probing of
	bcm2835-i2s
Date: Tue, 21 Nov 2017 20:58:51 +0100
Message-ID: <20171121195851.x5vv3qrlfx2t2xb2@camel2.lan>
References: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
 <20171120131815.2oaa7mvksi2h5bip@camel2.lan>
 <1656114989.298026.1511209469286@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
 by alsa0.perex.cz (Postfix) with ESMTP id 20967266F52
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 20:58:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1656114989.298026.1511209469286@email.1und1.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Florian Fainelli <f.fainelli@gmail.com>, Mark Brown <broonie@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, kernel@martin.sperl.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

On Mon, Nov 20, 2017 at 09:24:29PM +0100, Stefan Wahren wrote:
> > Matthias Reichl <hias@horus.com> hat am 20. November 2017 um 14:18 geschrieben:
> > 
> > While testing with a simple card DT overlay I noticed another
> > issue: the i2s node is missing the #sound-dai-cells property
> > and simple card refuses to load because of that:
> > 
> > [    0.956912] OF: /sound/simple-audio-card,cpu: could not get #sound-dai-cells for /soc/i2s@7e203000
> 
> This should be a separate patch. Could you please send a proper one after this has been applied?

Sure, will do that.

> > As bcm2835-i2s has only a single DAI I think that property should
> > be set to 0:
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
> > index 7bb0362828ec..7349f22bed1b 100644
> > --- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
> > +++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
> > @@ -7,6 +7,7 @@ Required properties:
> >  - dmas: List of DMA controller phandle and DMA request line ordered pairs.
> >  - dma-names: Identifier string for each DMA request line in the dmas property.
> >    These strings correspond 1:1 with the ordered pairs in dmas.
> > +- #sound-dai-cells: Must be set to 0.
> 
> I'm not sure about the property description, but i think there should be a reference to the simple card binding.

Description of #sound-dai-cells in the other binding docs is equally
minimal - but I think I'll reword it to "Must be equal to 0" to
match it the majority of other docs.

> > With this additional change I could successfully test the following
> > overlay with a PCM5102 codec attached to a RPi B+:
> > 
> > /dts-v1/;
> > /plugin/;
> > 
> > / {
> >     compatible = "brcm,bcm2835";
> > 
> >     fragment@0 {
> >         target = <&i2s>;
> >         __overlay__ {
> >             status = "okay";
> >         };
> >     };
> > 
> >     fragment@1 {
> >         target-path = "/";
> >         __overlay__ {
> >             spdif_codec: spdif-transmitter {
> >                 #address-cells = <0>;
> >                 #size-cells = <0>;
> >                 #sound-dai-cells = <0>;
> >                 compatible = "linux,spdif-dit";
> >             };
> > 
> >             sound {
> >                 compatible = "simple-audio-card";
> >                 simple-audio-card,name = "simple";
> >                 simple-audio-card,format = "i2s";
> >                 simple-audio-card,bitclock-master = <&dailink_master>;
> >                 simple-audio-card,frame-master = <&dailink_master>;
> > 
> >                 dailink_master: simple-audio-card,cpu {
> >                         sound-dai = <&i2s>;
> >                 };
> > 
> >                 simple-audio-card,codec {
> >                         sound-dai = <&spdif_codec>;
> >                 };
> >             };
> >         };
> >     };
> > };
> > 
> > BTW: this overlay will work without any hardware attached, you
> > just need to enable SND_SIMPLE_CARD and SND_SOC_SPDIF (which
> > serves as a generic codec) in your config.
> 
> Do you think it should be included in bcm2835_defconfig?

I think we can keep defconfig as it is. Most of the time one has
to enable the "real" codec drivers anyways and when you're already
changing the config you can enable the simple or audio graph card
driver, too.

so long,

Hias
