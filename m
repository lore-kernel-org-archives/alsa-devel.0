From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 1/2] ASoC: rockchip: add support for pdm controller
Date: Sun, 18 Jun 2017 09:05:27 -0500
Message-ID: <20170618140527.fqaoc55qisd5n36b@rob-hp-laptop>
References: <1497338867-52684-1-git-send-email-sugar.zhang@rock-chips.com>
 <1497338867-52684-2-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497338867-52684-2-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: heiko@sntech.de, broonie@kernel.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 13, 2017 at 03:27:46PM +0800, Sugar Zhang wrote:
> The Pulse Density Modulation Interface Controller (PDMC) is
> a PDM interface controller and decoder that support PDM format.
> It integrates a clock generator driving the PDM microphone
> and embeds filters which decimate the incoming bit stream to
> obtain most common audio rates.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  .../devicetree/bindings/sound/rockchip,pdm.txt     |  39 ++
>  sound/soc/rockchip/Kconfig                         |   9 +
>  sound/soc/rockchip/Makefile                        |   2 +
>  sound/soc/rockchip/rockchip_pdm.c                  | 516 +++++++++++++++++++++
>  sound/soc/rockchip/rockchip_pdm.h                  |  83 ++++
>  5 files changed, 649 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,pdm.txt
>  create mode 100644 sound/soc/rockchip/rockchip_pdm.c
>  create mode 100644 sound/soc/rockchip/rockchip_pdm.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
> new file mode 100644
> index 0000000..921729d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
> @@ -0,0 +1,39 @@
> +* Rockchip PDM controller
> +
> +Required properties:
> +
> +- compatible: "rockchip,pdm"

Too generic. This should be SoC specific.

> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- dmas: DMA specifiers for rx dma. See the DMA client binding,
> +	Documentation/devicetree/bindings/dma/dma.txt
> +- dma-names: should include "rx".
> +- clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
> +- clock-names: should contain following:
> +   - "pdm_hclk": clock for PDM BUS
> +   - "pdm_clk" : clock for PDM controller
> +- pinctrl-names: Must contain a "default" entry.
> +- pinctrl-N: One property must exist for each entry in
> +	     pinctrl-names. See ../pinctrl/pinctrl-bindings.txt
> +	     for details of the property values.
> +
> +Example for rk3328 PDM controller:
> +
> +pdm: pdm@ff040000 {
> +	compatible = "rockchip,pdm";
> +	reg = <0x0 0xff040000 0x0 0x1000>;
> +	clocks = <&clk_pdm>, <&clk_gates28 0>;
> +	clock-names = "pdm_clk", "pdm_hclk";
> +	dmas = <&pdma 16>;
> +	#dma-cells = <1>;
> +	dma-names = "rx";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pdmm0_clk
> +		     &pdmm0_fsync
> +		     &pdmm0_sdi0
> +		     &pdmm0_sdi1
> +		     &pdmm0_sdi2
> +		     &pdmm0_sdi3>;
> +	pinctrl-1 = <&pdmm0_sleep>;
> +	status = "disabled";
> +};
