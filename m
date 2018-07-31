From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 01/10] ASoC: dt-bindings: add dt
 bindings for wcd9335 audio codec
Date: Tue, 31 Jul 2018 14:43:15 -0600
Message-ID: <20180731204315.GA5265@rob-hp-laptop>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 by alsa0.perex.cz (Postfix) with ESMTP id DC800267763
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 22:43:18 +0200 (CEST)
Received: by mail-io0-f196.google.com with SMTP id i18-v6so14194640ioj.13
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 13:43:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, broonie@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 27, 2018 at 01:17:57PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for wcd9335 audio codec which can support both SLIMbus
> and I2S/I2C interface.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,wcd9335.txt     | 123 +++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> new file mode 100644
> index 000000000000..1d8d49e30af7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> @@ -0,0 +1,123 @@
> +QCOM WCD9335 Codec
> +
> +Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
> +Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
> +the MSM8996, MSM8976, and MSM8956 chipsets. It has in-built
> +Soundwire controller, interrupt mux. It supports both I2S/I2C and
> +SLIMbus audio interfaces.
> +
> +Required properties with SLIMbus Interface:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: For SLIMbus interface it should be "slimMID,PID",
> +		    textual representation of Manufacturer ID, Product Code,
> +		    shall be in lower case hexadecimal with leading zeroes
> +		    suppressed.  Refer to slimbus/bus.txt for details.
> +		    Should be:
> +		    "slim217,1a0" for MSM8996 and APQ8096 SoCs with SLIMbus.
> +
> +- reg
> +	Usage: required
> +	Value type: <u32 u32>
> +	Definition: Should be ('Device index', 'Instance ID')
> +
> +- interrupts
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Interrupts via WCD INTR1 and INTR2 pins
> +
> +- interrupt-names:
> +	Usage: required
> +	Value type: <String array>
> +	Definition: Interrupt names of WCD INTR1 and INTR2
> +	Should be: "intr1", "intr2"
> +
> +- reset-gpio:

reset-gpios

> +	Usage: required
> +	Value type: <String Array>
> +	Definition: Reset gpio line
> +
> +- qcom,ifd:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: SLIM interface device

Wouldn't this be the parent?

> +
> +- clocks:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: See clock-bindings.txt section "consumers". List of
> +                three clock specifiers for mclk, mclk2 and slimbus clock.
> +
> +- clock-names:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
> +
> +- vdd-buck-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the 1.8V buck supply
> +
> +- vdd-buck-sido-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the 1.8V SIDO buck supply
> +
> +- vdd-rx-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the 1.8V rx supply
> +
> +- vdd-tx-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the 1.8V tx supply
> +
> +- vdd-vbat-supply:
> +	Usage: Optional
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the vbat supply
> +
> +- vdd-micbias-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the micbias supply
> +
> +- vdd-io-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the 1.8V io supply
> +
> +- interrupt-controller:
> +	Usage: required
> +	Definition: Indicating that this is a interrupt controller
> +
> +- #interrupt-cells:
> +	Usage: required
> +	Value type: <int>
> +	Definition: should be 1
> +
> +#sound-dai-cells
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be 1
> +
> +codec@1{

audio-codec@1

> +	compatible = "slim217,1a0";
> +	reg  = <1 0>;
> +	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "intr2"
> +	reset-gpio = <&msmgpio 64 0>;
> +	qcom,ifd  = <&wc9335_ifd>;
> +	clock-names = "mclk", "native";
> +	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
> +		 <&rpmcc RPM_SMD_BB_CLK1>;
> +	vdd-buck-supply = <&pm8994_s4>;
> +	vdd-rx-supply = <&pm8994_s4>;
> +	vdd-buck-sido-supply = <&pm8994_s4>;
> +	vdd-tx-supply = <&pm8994_s4>;
> +	vdd-io-supply = <&pm8994_s4>;
> +	#sound-dai-cells = <1>;
> +}
> -- 
> 2.16.2
> 
