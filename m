From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC] ARM: dts: bcm283x: Fix probing of
	bcm2835-i2s
Date: Mon, 20 Nov 2017 21:24:29 +0100 (CET)
Message-ID: <1656114989.298026.1511209469286@email.1und1.de>
References: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
 <20171120131815.2oaa7mvksi2h5bip@camel2.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id CFEB2267065
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 21:24:39 +0100 (CET)
In-Reply-To: <20171120131815.2oaa7mvksi2h5bip@camel2.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Florian Fainelli <f.fainelli@gmail.com>, Mark Brown <broonie@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, kernel@martin.sperl.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Hias,

> Matthias Reichl <hias@horus.com> hat am 20. November 2017 um 14:18 geschrieben:
> 
> 
> Hi Stefan!
> 
> On Sun, Nov 19, 2017 at 06:00:27PM +0100, Stefan Wahren wrote:
> ...
> 
> Thanks a lot for fixing the DT and binding docs, the register range
> and clock changes look fine to me.

after writing the patch i noticed that Martin Sperl wrote a very similiar patch back last year.

> 
> While testing with a simple card DT overlay I noticed another
> issue: the i2s node is missing the #sound-dai-cells property
> and simple card refuses to load because of that:
> 
> [    0.956912] OF: /sound/simple-audio-card,cpu: could not get #sound-dai-cells for /soc/i2s@7e203000

This should be a separate patch. Could you please send a proper one after this has been applied?

> 
> As bcm2835-i2s has only a single DAI I think that property should
> be set to 0:
> 
> diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
> index 7bb0362828ec..7349f22bed1b 100644
> --- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
> @@ -7,6 +7,7 @@ Required properties:
>  - dmas: List of DMA controller phandle and DMA request line ordered pairs.
>  - dma-names: Identifier string for each DMA request line in the dmas property.
>    These strings correspond 1:1 with the ordered pairs in dmas.
> +- #sound-dai-cells: Must be set to 0.

I'm not sure about the property description, but i think there should be a reference to the simple card binding.

>  
>    One of the DMA channels will be responsible for transmission (should be
>    named "tx") and one for reception (should be named "rx").
> @@ -21,4 +22,5 @@ bcm2835_i2s: i2s@7e203000 {
>  	dmas = <&dma 2>,
>  	       <&dma 3>;
>  	dma-names = "tx", "rx";
> +	#sound-dai-cells = <0>;
>  };
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index e08203c1d74a..bbe890d4dbb5 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -402,6 +402,7 @@
>  			dmas = <&dma 2>,
>  			       <&dma 3>;
>  			dma-names = "tx", "rx";
> +			#sound-dai-cells = <0>;
>  			status = "disabled";
>  		};
> 
> With this additional change I could successfully test the following
> overlay with a PCM5102 codec attached to a RPi B+:
> 
> /dts-v1/;
> /plugin/;
> 
> / {
>     compatible = "brcm,bcm2835";
> 
>     fragment@0 {
>         target = <&i2s>;
>         __overlay__ {
>             status = "okay";
>         };
>     };
> 
>     fragment@1 {
>         target-path = "/";
>         __overlay__ {
>             spdif_codec: spdif-transmitter {
>                 #address-cells = <0>;
>                 #size-cells = <0>;
>                 #sound-dai-cells = <0>;
>                 compatible = "linux,spdif-dit";
>             };
> 
>             sound {
>                 compatible = "simple-audio-card";
>                 simple-audio-card,name = "simple";
>                 simple-audio-card,format = "i2s";
>                 simple-audio-card,bitclock-master = <&dailink_master>;
>                 simple-audio-card,frame-master = <&dailink_master>;
> 
>                 dailink_master: simple-audio-card,cpu {
>                         sound-dai = <&i2s>;
>                 };
> 
>                 simple-audio-card,codec {
>                         sound-dai = <&spdif_codec>;
>                 };
>             };
>         };
>     };
> };
> 
> BTW: this overlay will work without any hardware attached, you
> just need to enable SND_SIMPLE_CARD and SND_SOC_SPDIF (which
> serves as a generic codec) in your config.

Do you think it should be included in bcm2835_defconfig?

> 
> so long,
> 
> Hias
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
