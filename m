From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 06/12] mfd: add DT bindings for MedaiTek audio subsystem
Date: Fri, 5 Jan 2018 09:45:48 -0600
Message-ID: <20180105154548.gn5pj4ztefnr656q@rob-hp-laptop>
References: <cover.1514881870.git.ryder.lee@mediatek.com>
 <9ae24121a9cea18046428afd1d92c1b8601c0e05.1514881870.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9ae24121a9cea18046428afd1d92c1b8601c0e05.1514881870.git.ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 02, 2018 at 07:47:31PM +0800, Ryder Lee wrote:
> This patch adds documentation of the DT bindings for the MediaTek
> audio subsystem wrapper.
> 
> Signed-off-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/mfd/mtk-audsys.txt         | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mtk-audsys.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mtk-audsys.txt b/Documentation/devicetree/bindings/mfd/mtk-audsys.txt
> new file mode 100644
> index 0000000..7739580
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mtk-audsys.txt
> @@ -0,0 +1,109 @@
> +MediaTek Audio Subsystem Wrapper
> +
> +Required properties:
> +- compatible: Should be "mediatek,mt2701-audsys-core".
> +- reg: Should contain the device's region location and size.

The example shows 2 regions. What are they?

> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Should contain "infra_aud", "top_a1sys", "top_a2sys".
> +
> +Required subnodes are described in:
> +- ../sound/mt2701-afe-pcm.txt.
> +- ../arm/mediatek/mediatek,audsys.txt.
> +
> +Example:
> +
> +	audio-subsystm@11220000 {
> +		compatible = "mediatek,mt2701-audsys-core";
> +		reg = <0 0x11220000 0 0x2000>,
> +		      <0 0x112a0000 0 0x20000>;
> +		clocks = <&infracfg CLK_INFRA_AUDIO>,
> +			 <&topckgen CLK_TOP_AUD_48K_TIMING>,
> +			 <&topckgen CLK_TOP_AUD_44K_TIMING>;
> +		clock-names = "infra_aud", "top_a1sys", "top_a2sys";
> +
> +		audsys: clock {
> +			compatible = "mediatek,mt2701-audsys";
> +			#clock-cells = <1>;

There's no need for a node here. Just put #clock-cells in the parent.

> +		};
> +
> +		afe: audio {
> +			compatible = "mediatek,mt2701-audio";

No registers associated with this?

Looks to me like you are creating nodes just to instantiate drivers. 
Describe h/w blocks. DT is not the only way to instantiate drivers.

> +			interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> +				      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names	= "afe", "asys";
> +			power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +
> +			clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> +				 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
> +				 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
> +				 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
> +				 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
> +				 <&audsys CLK_AUD_I2SO1>,
> +				 <&audsys CLK_AUD_I2SO2>,
> +				 <&audsys CLK_AUD_I2SO3>,
> +				 <&audsys CLK_AUD_I2SO4>,
> +				 <&audsys CLK_AUD_I2SIN1>,
> +				 <&audsys CLK_AUD_I2SIN2>,
> +				 <&audsys CLK_AUD_I2SIN3>,
> +				 <&audsys CLK_AUD_I2SIN4>,
> +				 <&audsys CLK_AUD_ASRCO1>,
> +				 <&audsys CLK_AUD_ASRCO2>,
> +				 <&audsys CLK_AUD_ASRCO3>,
> +				 <&audsys CLK_AUD_ASRCO4>,
> +				 <&audsys CLK_AUD_AFE>,
> +				 <&audsys CLK_AUD_AFE_CONN>,
> +				 <&audsys CLK_AUD_A1SYS>,
> +				 <&audsys CLK_AUD_A2SYS>,
> +				 <&audsys CLK_AUD_AFE_MRGIF>;
> +
> +			clock-names = "top_audio_mux1_sel",
> +				      "top_audio_mux2_sel",
> +				      "i2s0_src_sel",
> +				      "i2s1_src_sel",
> +				      "i2s2_src_sel",
> +				      "i2s3_src_sel",
> +				      "i2s0_src_div",
> +				      "i2s1_src_div",
> +				      "i2s2_src_div",
> +				      "i2s3_src_div",
> +				      "i2s0_mclk_en",
> +				      "i2s1_mclk_en",
> +				      "i2s2_mclk_en",
> +				      "i2s3_mclk_en",
> +				      "i2so0_hop_ck",
> +				      "i2so1_hop_ck",
> +				      "i2so2_hop_ck",
> +				      "i2so3_hop_ck",
> +				      "i2si0_hop_ck",
> +				      "i2si1_hop_ck",
> +				      "i2si2_hop_ck",
> +				      "i2si3_hop_ck",
> +				      "asrc0_out_ck",
> +				      "asrc1_out_ck",
> +				      "asrc2_out_ck",
> +				      "asrc3_out_ck",
> +				      "audio_afe_pd",
> +				      "audio_afe_conn_pd",
> +				      "audio_a1sys_pd",
> +				      "audio_a2sys_pd",
> +				      "audio_mrgif_pd";
> +
> +			assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> +					  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> +					  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
> +					  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
> +						 <&topckgen CLK_TOP_AUD2PLL_90M>;
> +			assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
> +		};
> +	};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
