From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] arm64: dts: mt8173: Add afe device node
Date: Thu, 9 Jul 2015 18:45:49 +0800
Message-ID: <CAGS+omBqO6Zcw9KuN6p9YDvRD=UfmOnokUPeRo-iv6ruTBChwg@mail.gmail.com>
References: <1436412725-55129-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436412725-55129-1-git-send-email-koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 9, 2015 at 11:32 AM, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> This adds afe (audio front end) device node to the MT8173 dtsi file.
>
> Signed-off-by: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

I believe this patch depends on the fix in:
https://patchwork.kernel.org/patch/6752521/

If so, I think it would have been better to upload them together and
mention the dependency in the cover letter.
However, now that they are both on the list, we just need to ensure
they are merged together.

-Dan


> ---
> This patch is based on Matthias's tree:
> https://github.com/mbgg/linux-mediatek
> branch: v4.2-next/arm64
>
> Changes since v1:
> - change node name to afe: audio-controller@11220000
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 0696f8f..ce9255a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/clock/mt8173-clk.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/mt8173-power.h>
>  #include <dt-bindings/reset-controller/mt8173-resets.h>
>  #include "mt8173-pinfunc.h"
>
> @@ -393,6 +394,37 @@
>                         #size-cells = <0>;
>                         status = "disabled";
>                 };
> +
> +               afe: audio-controller@11220000  {
> +                       compatible = "mediatek,mt8173-afe-pcm";
> +                       reg = <0 0x11220000 0 0x1000>;
> +                       interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_FALLING>;
> +                       power-domains = <&scpsys MT8173_POWER_DOMAIN_AUDIO>;
> +                       clocks = <&infracfg CLK_INFRA_AUDIO>,
> +                                <&topckgen CLK_TOP_AUDIO_SEL>,
> +                                <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
> +                                <&topckgen CLK_TOP_APLL1_DIV0>,
> +                                <&topckgen CLK_TOP_APLL2_DIV0>,
> +                                <&topckgen CLK_TOP_I2S0_M_SEL>,
> +                                <&topckgen CLK_TOP_I2S1_M_SEL>,
> +                                <&topckgen CLK_TOP_I2S2_M_SEL>,
> +                                <&topckgen CLK_TOP_I2S3_M_SEL>,
> +                                <&topckgen CLK_TOP_I2S3_B_SEL>;
> +                       clock-names = "infra_sys_audio_clk",
> +                                     "top_pdn_audio",
> +                                     "top_pdn_aud_intbus",
> +                                     "bck0",
> +                                     "bck1",
> +                                     "i2s0_m",
> +                                     "i2s1_m",
> +                                     "i2s2_m",
> +                                     "i2s3_m",
> +                                     "i2s3_b";
> +                       assigned-clocks = <&topckgen CLK_TOP_AUD_1_SEL>,
> +                                         <&topckgen CLK_TOP_AUD_2_SEL>;
> +                       assigned-clock-parents = <&topckgen CLK_TOP_APLL1>,
> +                                                <&topckgen CLK_TOP_APLL2>;
> +               };
>         };
>  };
>
> --
> 1.8.1.1.dirty
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
