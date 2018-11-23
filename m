From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v9 8/8] arm64: dts: allwinner: a64: enable
	sound on Pinebook
Date: Thu, 22 Nov 2018 20:15:02 -0800
Message-ID: <4447541.czlqnMh8c9@anarsoul-thinkpad>
References: <20181122102325.29495-1-wens@csie.org>
 <20181122102325.29495-9-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1B9267865
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 05:15:04 +0100 (CET)
Received: by mail-pg1-f193.google.com with SMTP id w6so2505247pgl.6
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 20:15:04 -0800 (PST)
In-Reply-To: <20181122102325.29495-9-wens@csie.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thursday, November 22, 2018 2:23:25 AM PST Chen-Yu Tsai wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> The Pinebook has a headphone jack tied to the HP headphone output of
> the SoC, and internal speakers connected to the LINEOUT of the SoC,
> through a standalone amplifier.
> 
> This commit enables I2S, digital and analog parts of audio codec on
> Pinebook, along with a device node for the external amplifier.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> [wens@csie.org: dropped headphone_amp; added headphone amp regulator supply;
> fixed speaker_amp node name and sound-name-prefix name]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts index
> ec537c529726..b6d0b926a2ff 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -74,6 +74,32 @@
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>  	};
> +
> +	speaker_amp: audio-amplifier {
> +		compatible = "simple-audio-amplifier";
> +		/*
> +		 * TODO This is actually a fixed regulator controlled by
> +		 * the GPIO line on the PMIC. This should be corrected
> +		 * once GPIO support is added for this PMIC.
> +		 */
> +		VCC-supply = <&reg_ldo_io0>;
> +		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> +		sound-name-prefix = "Speaker Amp";
> +	};
> +
> +};
> +
> +&codec {
> +	hpvcc-supply = <&reg_eldo1>;

It should be a property of codec_analog, not codec

> +	status = "okay";
> +};
> +
> +&codec_analog {
> +	status = "okay";
> +};
> +
> +&dai {
> +	status = "okay";
>  };
> 
>  &ehci0 {
> @@ -277,6 +303,29 @@
>  	vcc-hdmi-supply = <&reg_dldo1>;
>  };
> 
> +&sound {
> +	status = "okay";
> +	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
> +	simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
> +				    "Microphone", "Internal Microphone Right",
> +				    "Headphone", "Headphone Jack",
> +				    "Speaker", "Internal Speaker";
> +	simple-audio-card,routing =
> +			"Left DAC", "AIF1 Slot 0 Left",
> +			"Right DAC", "AIF1 Slot 0 Right",
> +			"Speaker Amp INL", "LINEOUT",
> +			"Speaker Amp INR", "LINEOUT",
> +			"Internal Speaker", "Speaker Amp OUTL",
> +			"Internal Speaker", "Speaker Amp OUTR",
> +			"Headphone Jack", "HP",
> +			"AIF1 Slot 0 Left ADC", "Left ADC",
> +			"AIF1 Slot 0 Right ADC", "Right ADC",
> +			"Internal Microphone Left", "MBIAS",
> +			"MIC1", "Internal Microphone Left",
> +			"Internal Microphone Right", "HBIAS",
> +			"MIC2", "Internal Microphone Right";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pb_pins>;
