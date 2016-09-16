From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/5] ASoC: codecs: Add msm8916-wcd analog codec
Date: Fri, 16 Sep 2016 10:41:51 -0500
Message-ID: <20160916154151.GA13492@rob-hp-laptop>
References: <1473339896-9409-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473339896-9409-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473339896-9409-2-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, tiwai@suse.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 08, 2016 at 02:04:52PM +0100, Srinivas Kandagatla wrote:
> msm8916-wcd codec is found in Qualcomm msm8916 and apq8016 processors.
> This codec IP is split in to two parts (Digital & Analog).
> Analog part is integrated in to PMIC PM8916 and the digital part is
> integrated into Application processor. Data transfer between Analog and
> Digital Die is done via a internal bus called PDM.
> 
> This patch adds support to Analog part of the Codec which is integrated
> into PMIC PM8916.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  83 ++
>  sound/soc/codecs/Kconfig                           |   4 +
>  sound/soc/codecs/Makefile                          |   3 +-
>  sound/soc/codecs/msm8916-wcd-analog.c              | 888 +++++++++++++++++++++
>  4 files changed, 977 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
>  create mode 100644 sound/soc/codecs/msm8916-wcd-analog.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
> new file mode 100644
> index 0000000..f426c06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
> @@ -0,0 +1,83 @@
> +msm8916 analog audio CODEC
> +
> +Bindings for codec Analog IP which is integrated in pmic pm8916,
> +
> +## Bindings for codec core on pmic:
> +
> +Required properties
> + - compatible = "qcom,msm8916-wcd-analog-codec";
> + - reg: represents the slave base address provided to the peripheral.
> + - interrupt-parent : The parent interrupt controller.
> + - interrupts: List of interrupts in given SPMI peripheral.
> + - interrupt-names: Names specified to above list of interrupts in same
> +		    order. List of supported interrupt names are:
> +  "cdc_spk_cnp_int" - Speaker click and pop interrupt.
> +  "cdc_spk_clip_int" - Speaker clip interrupt.
> +  "cdc_spk_ocp_int" - Speaker over current protect interrupt.
> +  "mbhc_ins_rem_det1" - jack insert removal detect interrupt 1.
> +  "mbhc_but_rel_det" - button release interrupt.
> +  "mbhc_but_press_det" - button press event
> +  "mbhc_ins_rem_det" - jack insert removal detect interrupt.
> +  "mbhc_switch_int"	- multi button headset interrupt.
> +  "cdc_ear_ocp_int" - Earphone over current protect interrupt.
> +  "cdc_hphr_ocp_int" - Headphone R over current protect interrupt.
> +  "cdc_hphl_ocp_det" - Headphone L over current protect interrupt.
> +  "cdc_ear_cnp_int" - earphone cnp interrupt.
> +  "cdc_hphr_cnp_int" - hphr click and pop interrupt.
> +  "cdc_hphl_cnp_int" - hphl click and pop interrupt.
> +
> + - clocks: Handle to mclk.
> + - clock-names: should be "mclk".
> + - VDD-CDC-IO-supply: phandle to VDD_CDC_IO regulator device tree node.
> + - VDD-CDC-TX-RX-CX-supply: phandle to VDD_CDC_TX/RX/CX regulator device tree node.
> + - VDD-MICBIAS-supply: phandle of VDD_MICBIAS supply's regulator device tree node.

Lowercase please.

> +
> +Optional Properties:
> +- qcom,micbias1-ext-cap: present if micbias1 has external capacitor connected.
> +- qcom,micbias2-ext-cap: present if micbias2 has external capacitor connected.

Explicitly state these are bool.

> +
> +Example:
> +
> +spmi_bus {
> +	...
> +	msm8916_wcd_codec@f000{

audio-codec@...

> +		compatible = "qcom,msm8916-wcd-analog-codec";
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
> +		interrupt-names = "cdc_spk_cnp_int",
> +				  "cdc_spk_clip_int",
> +				  "cdc_spk_ocp_int",
> +				  "mbhc_ins_rem_det1",
> +				  "mbhc_but_rel_det",
> +				  "mbhc_but_press_det",
> +				  "mbhc_ins_rem_det",
> +				  "mbhc_switch_int",
> +				  "cdc_ear_ocp_int",
> +				  "cdc_hphr_ocp_int",
> +				  "cdc_hphl_ocp_det",
> +				  "cdc_ear_cnp_int",
> +				  "cdc_hphr_cnp_int",
> +				  "cdc_hphl_cnp_int";
> +	               VDD-CDC-IO-supply = <&pm8916_l5>;
> +	               VDD-CDC-TX-RX-CX-supply = <&pm8916_l5>;
> +	               VDD-MICBIAS-supply = <&pm8916_l13>;
> +	               #sound-dai-cells = <1>;
> +	};
> +};
