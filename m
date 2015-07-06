From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] arm64: dts: mt8173: Add afe device node
Date: Mon, 6 Jul 2015 21:00:28 +0800
Message-ID: <CAGS+omCtfCUQEczX+OCLa7jfOnxE=jFq8os0m2LCi87ELMTK9g@mail.gmail.com>
References: <1436165530-41963-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
 [209.85.160.170])
 by alsa0.perex.cz (Postfix) with ESMTP id A02842605C7
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 15:00:48 +0200 (CEST)
Received: by ykfs198 with SMTP id s198so42200872ykf.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2015 06:00:47 -0700 (PDT)
In-Reply-To: <1436165530-41963-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 6, 2015 at 2:52 PM, Koro Chen <koro.chen@mediatek.com> wrote:

> This adds afe (audio front end) device node to the MT8173 dtsi file.
>
> This patch is based on Matthias's tree:
> https://github.com/mbgg/linux-mediatek
> branch: v4.2-next/arm64
>
> Signed-off-by: Koro Chen <koro.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 32
> ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 0696f8f..f8afab4 100644
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
> +               afe: mt8173-afe-pcm@11220000  {
>

I believe this should be something generic, like:

  afe: audio-controller@11220000

Thanks!
-Dan


> +                       compatible = "mediatek,mt8173-afe-pcm";
> +                       reg = <0 0x11220000 0 0x1000>;
> +                       interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_FALLING>;
> +                       power-domains = <&scpsys
> MT8173_POWER_DOMAIN_AUDIO>;
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
>
