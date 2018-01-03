From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v2 15/15] arm64: dts: msm8996: db820c: Add sound
 card support
Date: Tue, 2 Jan 2018 16:22:29 -0800
Message-ID: <20180103002229.GV478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-16-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171214173402.19074-16-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> This patch adds hdmi sound card support to db820c via qdsp.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |  5 +++++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi        | 33 ++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index 9769053957af..b955769b100d 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -190,6 +190,11 @@
>  		};
>  	};
>  
> +	snd {
> +		compatible = "qcom,apq8096-sndcard";
> +		qcom,model = "DB820c";
> +		iommus = <&lpass_q6_smmu 1>;
> +	};
>  
>  	gpio_keys {
>  		compatible = "gpio-keys";
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index a144cec7bb71..25c43fb8ab49 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1262,6 +1262,7 @@
>  
>  				phys = <&hdmi_phy>;
>  				phy-names = "hdmi_phy";
> +				#sound-dai-cells = <0>;
>  
>  				ports {
>  					#address-cells = <1>;
> @@ -1297,6 +1298,33 @@
>  					      "ref_clk";
>  			};
>  		};
> +
> +	        lpass_q6_smmu: arm,smmu-lpass_q6@1600000 {

name this node "iommu"

> +			compatible = "qcom,msm8996-smmu-v2";
> +	                reg = <0x1600000 0x20000>;
> +	                #iommu-cells = <1>;
> +                        power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;

Indentation

> +
> +			#global-interrupts = <1>;
> +		        interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +		                <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>,
> +				 <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
> +			clock-names = "iface", "bus";
> +                        status = "okay";
> +		};
>  	};
>  
>  	adsp-pil {
> @@ -1325,6 +1353,11 @@
>  			qcom,ipc = <&apcs 16 8>;
>  			qcom,smd-edge = <1>;
>  			qcom,remote-pid = <2>;
> +
> +			apr {

"apr-audio-svc", as this is not the only apr channel on this edge.

> +				compatible = "qcom,apr-msm8996";
> +				qcom,smd-channels = "apr_audio_svc";
> +			};
>  		};

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
