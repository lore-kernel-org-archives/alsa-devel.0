From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC v1 1/9] ASoC: msm8x176: Add Device Tree bindings.
Date: Tue, 16 Feb 2016 18:58:11 +0000
Message-ID: <20160216185811.GD8022@leverpostej>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1455643950-1657-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455643950-1657-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 16, 2016 at 05:32:30PM +0000, Srinivas Kandagatla wrote:
> This patch adds DT bindings required for msm8x16 codec which is
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
>  .../devicetree/bindings/sound/qcom,msm8x16-wcd.txt | 91 ++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8x16-wcd.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8x16-wcd.txt b/Documentation/devicetree/bindings/sound/qcom,msm8x16-wcd.txt
> new file mode 100644
> index 0000000..42d3f66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,msm8x16-wcd.txt
> @@ -0,0 +1,91 @@
> +msm8x16 audio CODEC aka Tombak audio CODEC
> +
> +Codec IP is divided into two parts, first analog which is integrated in pmic pm8916
> +and secondly digital part which is integrated into application processor. Codec register
> +controls are also split across pmic an lpass. Analog part is controlled via spmi bus to pmic.
> +
> +## Bindings for codec core on pmic:
> +
> +Required properties
> + - compatible = "qcom,msm8x16-wcd-codec";

Wildcard bindings are frowned upon generally.

Have separate comaptible strings, perhaps with one as a fallback for the
other.

> + - reg: represents the slave base address provided to the peripheral.
> + - interrupt-parent : The parent interrupt controller.
> + - interrupts: List of interrupts in given SPMI peripheral.
> + - interrupt-names: Names specified to above list of interrupts in same
> +		    order

You must explicitly describe the set of interrupt-names for the binding.

> + - vddio-supply: phandle to VDD_CDC_IO regulator device tree node.
> + - vdd-tx-rx-supply: phandle to VDD_CDC_TX/RX/CX regulator device tree node.
> + - vdda-cp-supply: phandle of VDD_CP charge pump supply's regulator device tree node.
> + - vdda-hph-supply: phandle of VDD_HPH supply's regulator device tree node.
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
> + - compatible: should be "syscon" follwed by "qcom,msm8x16-lpass-codec"

This should be the other way around. "syscon" should be the fallback as
it is the least specific. Likewise for the example.

Again, wildcard bindings are generally frowned upon.

Mark.
