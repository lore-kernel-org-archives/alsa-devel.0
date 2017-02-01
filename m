From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 5/8] ASoC: codecs: Add sun8i-a33 binding
	documentation
Date: Wed, 1 Feb 2017 11:30:54 -0600
Message-ID: <20170201173053.rjqwtxe4sjlttdwa@rob-hp-laptop>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-6-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f196.google.com (mail-ot0-f196.google.com
 [74.125.82.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 30BDC266E0D
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 18:30:55 +0100 (CET)
Received: by mail-ot0-f196.google.com with SMTP id 73so46093403otj.1
 for <alsa-devel@alsa-project.org>; Wed, 01 Feb 2017 09:30:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170131100552.27949-6-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, wens@csie.org, broonie@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 31, 2017 at 11:05:49AM +0100, Myl=E8ne Josserand wrote:
> Add the documentation for dt-binding of the digital audio codec driver
> and the audio card driver for Sun8i-a33 SoCs.
> =

> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  .../devicetree/bindings/sound/sun8i-a33-codec.txt  | 75 ++++++++++++++++=
++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-a33-cod=
ec.txt
> =

> diff --git a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt =
b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
> new file mode 100644
> index 000000000000..2425c74bce7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
> @@ -0,0 +1,75 @@
> +Allwinner SUN8I audio codec
> +------------------------------------
> +
> +On Sun8i-A33 SoCs, the audio is separated in different parts:
> +	  - A DAI driver. It uses the "sun4i-i2s" driver which is
> +	  documented here:
> +	  Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +	  - An analog part of the codec which is handled as PRCM registers.
> +	  See Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
> +	  - An digital part of the codec which is documented in this current
> +	  binding documentation.
> +	  - And finally, an audio card which links all the above components.
> +	  The simple-audio card will be used.
> +	  See Documentation/devicetree/bindings/sound/simple-card.txt
> +
> +This bindings documentation exposes Sun8i codec (digital part).
> +
> +Required properties:
> +- compatible: must be "allwinner,sun8i-a33-codec"
> +- reg: must contain the registers location and length
> +- interrupts: must contain the codec interrupt
> +- clocks: a list of phandle + clock-specifer pairs, one for each entry
> +  in clock-names.
> +- clock-names: should contain followings:
> +   - "bus": the parent APB clock for this controller
> +   - "mod": the parent module clock
> +
> +Example:
> +codec: codec@01c22e00 {

This is redundant with the full example below.

> +	#sound-dai-cells =3D <0>;
> +	compatible =3D "allwinner,sun8i-a33-codec";
> +	reg =3D <0x01c22e00 0x400>;
> +	interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +	clock-names =3D "bus", "mod";
> +	status =3D "disabled";
> +};
> +
> +Here is an example to add a sound card and the codec binding on sun8i So=
Cs that
> +are similar to A33 using simple-card:
> +
> +	sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "sun8i-a33-audio";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,frame-master =3D <&link_codec>;
> +		simple-audio-card,bitclock-master =3D <&link_codec>;
> +		simple-audio-card,mclk-fs =3D <512>;
> +		simple-audio-card,aux-devs =3D <&codec_analog>;
> +		simple-audio-card,routing =3D
> +				"Left DAC", "Digital Left DAC",
> +				"Right DAC", "Digital Right DAC";
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&dai>;
> +		};
> +
> +		link_codec: simple-audio-card,codec {
> +			sound-dai =3D <&codec>;
> +		};
> +
> +	soc@01c00000 {
> +		[...]
> +
> +		codec: codec@01c22e00 {

audio-codec@... and drop the leading 0.

> +			#sound-dai-cells =3D <0>;
> +			compatible =3D "allwinner,sun8i-a33-codec";
> +			reg =3D <0x01c22e00 0x400>;
> +			interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +			clock-names =3D "bus", "mod";
> +			status =3D "disabled";

Drop status from examples.

> +		};
> +	};
> +
> -- =

> 2.11.0
> =
