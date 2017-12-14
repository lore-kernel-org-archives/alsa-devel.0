From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: sun8i: Add ADC routing
Date: Thu, 14 Dec 2017 11:08:51 +0800
Message-ID: <CAGb2v67L71my8RKjnt=-b_UY3G0eC3VqkPeExrU0ZApRo_S9PQ@mail.gmail.com>
References: <20171213123408.10422-1-mylene.josserand@free-electrons.com> <20171213123408.10422-3-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171213123408.10422-3-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 8:34 PM, Mylène Josserand
<mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Add the ADC route between the analog and the digital parts
> of sun8i A33. Configure the MIC1 to use MBIAS and MIC2 to use HBIAS.
>
> Signed-off-by: Mylène Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun8i-a33.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index 22660919bd08..1841eecd5993 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -191,7 +191,15 @@
>                 simple-audio-card,aux-devs = <&codec_analog>;
>                 simple-audio-card,routing =
>                         "Left DAC", "AIF1 Slot 0 Left",
> -                       "Right DAC", "AIF1 Slot 0 Right";
> +                       "Right DAC", "AIF1 Slot 0 Right",
> +                       "AIF1 Slot 0 Left ADC", "Left ADC",
> +                       "AIF1 Slot 0 Right ADC", "Right ADC",
> +                       "Left ADC", "ADC",
> +                       "Right ADC", "ADC",



> +                       "Mic",  "MBIAS",
> +                       "Headset Mic", "HBIAS",
> +                       "MIC1", "Mic",
> +                       "MIC2", "Headset Mic";

These entries are board level routing. They should be done in the
board dts files. Unfortunately device tree does not provide a way
to "append" entries to properties, which means one has to copy all
the preceding entries as well.

Also, you are not adding the "Mic" and "Headset Mic" widgets. A33
uses simple-card, which means these connection/board level widgets
must be added using simple-audio-card,widgets.

ChenYu

>                 status = "disabled";
>
>                 simple-audio-card,cpu {
> --
> 2.11.0
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
