From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/8] ASoC: dt-bindings: add rockchip tranceiver bindings
Date: Thu, 8 Oct 2015 11:50:56 -0500
Message-ID: <CAL_JsqL_ox3TtjAL552X8-D21n47_hBCpeSkUcNdZu6+wj2h3A@mail.gmail.com>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk> <1444311079-2892-2-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444311079-2892-2-git-send-email-sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 8, 2015 at 8:31 AM, Sjoerd Simons
<sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> wrote:
> Add devicetree bindings for the spdif tranceiver found on
> found on rk3066, rk3188 and rk3288 SoCs
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>
> ---
>
> Changes in v4:
> - Require rockchip,grf on RK3288 as the 8 channel solution has to be
>   selected on that SoC
> - Make the compatibility string one of a known list rather then
>   requiring a precise list of options.
> - Change the clock names to hclk and mclk instead of spdif_hclk and
>   spdif_mclk to better match the implementation and data sheets.
>
> Changes in v3: None
> Changes in v2: None
>
>  .../devicetree/bindings/sound/rockchip-spdif.txt   | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
> new file mode 100644
> index 0000000..33dd82c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
> @@ -0,0 +1,44 @@
> +* Rockchip SPDIF transceiver
> +
> +The S/PDIF audio block is a stereo transceiver that allows the
> +processor to receive and transmit digital audio via an coaxial cable or
> +a fibre cable.
> +
> +Required properties:
> +
> +- compatible: should be one of the following:
> +   - "rockchip,rk3288-spdif", "rockchip,rk3188-spdif" or
> +     "rockchip,rk3066-spdif"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: should contain the SPDIF interrupt.

> +- #address-cells: should be 1.
> +- #size-cells: should be 0.

Why do you need these? Are you going to have sub nodes?

> +- dmas: DMA specifiers for tx dma. See the DMA client binding,
> +  Documentation/devicetree/bindings/dma/dma.txt
> +- dma-names: should be "tx"
> +- clocks: a list of phandle + clock-specifier pairs, one for each entry
> +  in clock-names.
> +- clock-names: should contain following:
> +   - "hclk": clock for SPDIF controller
> +   - "mclk" : clock for SPDIF bus
> +
> +Required properties on RK3288:
> +  - rockchip,grf: the phandle of the syscon node for the general register
> +                   file (GRF)
> +
> +Example for the rk3188 SPDIF controller:
> +
> +spdif: spdif@0x1011e000 {
> +       compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
> +       reg = <0x1011e000 0x2000>;
> +       interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       dmas = <&dmac1_s 8>;
> +       dma-names = "tx";
> +       clock-names = "hclk", "mclk";
> +       clocks = <&cru HCLK_SPDIF>, <&cru SCLK_SPDIF>;
> +       status = "disabled";
> +       #sound-dai-cells = <0>;
> +};
> --
> 2.6.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
