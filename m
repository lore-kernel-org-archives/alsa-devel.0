From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v8 7/7] arm64: dts: allwinner: a64: enable
	sound on Pinebook
Date: Wed, 21 Nov 2018 13:54:52 +0800
Message-ID: <CAGb2v65_3j7s_avuZgbKnXHnvms7fdKYWjnkMGEqw9T4_ee=oQ@mail.gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
 <20181121051752.18387-8-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D73AB267936
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 06:55:07 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id d39so3856048edb.12
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 21:55:07 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51])
 by smtp.gmail.com with ESMTPSA id t22-v6sm7838376ejl.58.2018.11.20.21.55.06
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Nov 2018 21:55:06 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id t3so4303161wrr.3
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 21:55:06 -0800 (PST)
In-Reply-To: <20181121051752.18387-8-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 21, 2018 at 1:19 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> This commit enables I2S, digital and analog parts of audiocodec on
> Pinebook
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index 77fac84797e9..cecfa7ea90b2 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -53,6 +53,12 @@
>                 };
>         };
>
> +       headphone_amp: headphone_amp {
> +               compatible = "simple-audio-amplifier";
> +               VCC-supply = <&reg_eldo1>;
> +               sound-name-prefix = "HP";
> +       };
> +

This is part of the analog side of the codec. Representing it as a
standalone amp is inaccurate. Here's what I have to add it to the codec:

DT binding patch:
https://github.com/wens/linux/commit/ca6360b9788b8495daff658280845683ff401441

Driver patch:
https://github.com/wens/linux/commit/17a91e45d62d370bb2350753be6db86eaf824a5e

DT fixup:
https://github.com/wens/linux/commit/df7c2b26d1a66790237ca25e8cc135c237cd8236

As mentioned on IRC, I will pick up this series incorporating some extra
changes.

Thanks
ChenYu

>         reg_vcc3v3: vcc3v3 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vcc3v3";
> @@ -64,6 +70,26 @@
>                 compatible = "mmc-pwrseq-simple";
>                 reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>         };
> +
> +       speaker_amp: speaker_amp {
> +               compatible = "simple-audio-amplifier";
> +               VCC-supply = <&reg_ldo_io0>;
> +               enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> +               sound-name-prefix = "SPEAKER";
> +       };
> +
> +};
> +
> +&codec {
> +       status = "okay";
> +};
> +
> +&codec_analog {
> +       status = "okay";
> +};
> +
> +&dai {
> +       status = "okay";
>  };
>
>  &ehci0 {
> @@ -267,6 +293,33 @@
>         vcc-hdmi-supply = <&reg_dldo1>;
>  };
>
> +&sound {
> +       status = "okay";
> +       simple-audio-card,aux-devs = <&codec_analog>, <&headphone_amp>,
> +                                    <&speaker_amp>;
> +       simple-audio-card,widgets = "Microphone", "Internal Microphone Left",
> +                                   "Microphone", "Internal Microphone Right",
> +                                   "Headphone", "Headphone Jack",
> +                                   "Speaker", "Internal Speaker";
> +       simple-audio-card,routing =
> +                       "Left DAC", "AIF1 Slot 0 Left",
> +                       "Right DAC", "AIF1 Slot 0 Right",
> +                       "SPEAKER INL", "LINEOUT",
> +                       "SPEAKER INR", "LINEOUT",
> +                       "Internal Speaker", "SPEAKER OUTL",
> +                       "Internal Speaker", "SPEAKER OUTR",
> +                       "HP INL", "HP",
> +                       "HP INR", "HP",
> +                       "Headphone Jack", "HP OUTL",
> +                       "Headphone Jack", "HP OUTR",
> +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> +                       "Internal Microphone Left", "MBIAS",
> +                       "MIC1", "Internal Microphone Left",
> +                       "Internal Microphone Right", "HBIAS",
> +                       "MIC2", "Internal Microphone Right";
> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pb_pins>;
> --
> 2.19.1
>
