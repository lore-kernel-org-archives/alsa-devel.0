From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [RFC v2 1/3] ASoC: msm8916: Add codec Device Tree bindings.
Date: Mon, 30 May 2016 16:01:23 -0700
Message-ID: <20160530230123.GA4004@kwestfie-linux.qualcomm.com>
References: <1464356746-29610-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1464356746-29610-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464356746-29610-2-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 27, 2016 at 02:45:44PM +0100, Srinivas Kandagatla wrote:
> This patch adds DT bindings required for msm8916 codec which is
> integrated in msm8916 and apq8016 SOCs.
> 
> Codec IP is divided into two parts, first analog which is integrated
> in pmic pm8916 and secondly digital part which is integrated into
> application processor. Codec register controls are also split across
> pmic an lpass. Analog part is controlled via spmi bus to pmic, registers
> on the Application processor are memory mapped.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,msm8916-wcd.txt | 101 +++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
> new file mode 100644
> index 0000000..4e3826d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
> @@ -0,0 +1,101 @@
> +msm8916 audio CODEC aka Tombak audio CODEC

Please remove all mentions of "Tombak" from the patch submissions.

> +
> +Codec IP is divided into two parts, first analog which is integrated in pmic pm8916
> +and secondly digital part which is integrated into application processor. Codec register
> +controls are also split across pmic an lpass. Analog part is controlled via spmi bus to pmic.
> +
> +## Bindings for codec core on pmic:
> +
> +Required properties

Need to document the clocks and clock-names properties as well.

> + - compatible = "qcom,msm8916-wcd-codec";
> + - reg: represents the slave base address provided to the peripheral.
> + - interrupt-parent : The parent interrupt controller.
> + - interrupts: List of interrupts in given SPMI peripheral.
> + - interrupt-names: Names specified to above list of interrupts in same
> +		    order. List of supported interrupt names are:
> +  "spk_cnp_int" - Speaker click and pop interrupt
> +  "spk_clip_int" - Speaker clip interrupt
> +  "spk_ocp_int" - Speaker over current protect interrupt.
> +  "ins_rem_det1" - jack insert removal detect interrupt 1.
> +  "but_rel_det" - button release interrupt
> +  "but_press_det" - button press event
> +  "ins_rem_det" - jack insert removal detect interrup
> +  "mbhc_int"	- multi button headset interrupt.
> +  "ear_ocp_int" - Earphone over current protect interrupt.
> +  "hphr_ocp_int" - Headphone R over current protect interrupt.
> +  "hphl_ocp_det" - Headphone L over current protect interrupt
> +  "ear_cnp_int" - earphone cnp interrupt.
> +  "hphr_cnp_int" - hphr click and pop interrupt.
> +  "hphl_cnp_int" - hphl click and pop interrupt
> +
> + - vddio-supply: phandle to VDD_CDC_IO regulator device tree node.
> + - vdd-tx-rx-supply: phandle to VDD_CDC_TX/RX/CX regulator device tree node.
> + - vdd-micbias-supply: phandle of VDD_MICBIAS supply's regulator device tree
> +			    node.
> +- qcom,lpass-codec-core: phandle to syscon node of lpass code core.
> +
> +Optional Properties:
> +- qcom,micbias1-ext-cap: present if micbias1 has external capacitor connected.
> +- qcom,micbias2-ext-cap: present if micbias2 has external capacitor connected.
> +
> +## Bindings codec core on lpass:
> +
> +Required properties
> + - compatible: should be "qcom,msm8916-lpass-codec" followed by "syscon".

IMO, the driver names are somewhat confusing.  Perhaps,
qcom,msm8916-pmic-codec - for the codec blocks in the PMIC
qcom,msm8916-soc-codec - for the codec blocks in the SoC

> + - reg: represents the lpass codec core register map.
> +
> +Example:
> +
> +spmi_bus {
> +	...
> +	msm8916_wcd_codec@f000{
> +		compatible = "qcom,msm8916-wcd-codec";
> +		reg = <0xf000 0x200>;
> +		reg-names = "pmic-codec-core";
> +		clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
> +		clock-names = "mclk";
> +		interrupt-parent = <&spmi_bus>;
> +		interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
> +			     <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
> +			     <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
> +			     <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
> +			     <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
> +			     <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
> +			     <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
> +			     <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
> +			     <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
> +			     <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
> +			     <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
> +			     <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
> +			     <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
> +			     <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
> +		interrupt-names = "spk_cnp_int",
> +				  "spk_clip_int",
> +				  "spk_ocp_int",
> +				  "ins_rem_det1",
> +				  "but_rel_det",
> +				  "but_press_det",
> +				  "ins_rem_det",
> +				  "mbhc_int",
> +				  "ear_ocp_int",
> +				  "hphr_ocp_int",
> +				  "hphl_ocp_det",
> +				  "ear_cnp_int",
> +				  "hphr_cnp_int",
> +				  "hphl_cnp_int";
> +		vddio-supply = <&pm8916_l5>;
> +		vdd-tx-rx-supply = <&pm8916_l5>;
> +		vdd-micbias-supply = <&pm8916_l13>;
> +		qcom,lpass-codec-core = <&lpass_codec_core>;

Is there a reason the PMIC codec holds a phandle reference to the SoC
codec node?  Rather than having the SoC codec hold a ref to the PMIC
codec?

> +		#sound-dai-cells = <1>;
> +	};
> +};
> +
> +soc {
> +	...
> +	lpass_codec_core: lpass-codec{
> +		compatible = "qcom,msm8916-lpass-codec", "syscon";
> +		reg = <0x0771c000 0x400>;
> +	};
> +
> +};
> -- 
> 2.8.2
> 

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
