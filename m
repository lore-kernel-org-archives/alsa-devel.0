From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [Patch V7 02/10] ASoC: qcom: Document LPASS CPU bindings
Date: Thu, 5 Mar 2015 12:52:30 -0600
Message-ID: <7E5AFC65-1705-4BDC-B57F-0444E83A8987@codeaurora.org>
References: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org> <1425428519-12224-3-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1425428519-12224-3-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


On Mar 3, 2015, at 6:21 PM, Kenneth Westfield <kwestfie@codeaurora.org> wrote:

> From: Kenneth Westfield <kwestfie@codeaurora.org>
> 
> Add documentation to the sound directory of the
> device-tree bindings for the QTi LPASS CPU DAI
> device.
> 
> Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
> ---
> .../devicetree/bindings/sound/qcom,lpass-cpu.txt   | 49 ++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
> new file mode 100644
> index 0000000000000000000000000000000000000000..e7c6e9321863f022ebf0d51b75d7bb83c10b9062
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
> @@ -0,0 +1,49 @@
> +* Qualcomm Technologies LPASS CPU DAI
> +
> +This node models the Qualcomm Technologies Low-Power Audio SubSystem (LPASS).
> +
> +Required properties:
> +
> +- compatible		: "qcom,lpass-cpu"
> +- clocks		: Must contain an entry for each entry in clock-names.
> +- clock-names		: A list which must include the following entries:
> +				* "ahbix-clk"
> +				* "mi2s-osr-clk"
> +				* "mi2s-bit-clk"
> +- interrupts		: Must contain an entry for each entry in
> +			  interrupt-names.
> +- interrupt-names	: A list which must include the following entries:
> +				* "lpass-irq-lpaif"
> +- pinctrl-N		: One property must exist for each entry in
> +			  pinctrl-names.  See ../pinctrl/pinctrl-bindings.txt
> +			  for details of the property values.
> +- pinctrl-names		: Must contain a "default" entry.
> +- reg			: Must contain an address for each entry in reg-names.
> +- reg-names		: A list which must include the following entries:
> +				* "lpass-lpaif"
> +
> +Required subnodes:
> +
> +- qcom,adsp		: Audio DSP sub-node
> +

What is the intent of this subnode?

> +Optional Audio DSP subnode properties:
> +
> +- status		: "disabled" indicates the adsp is not available.
> +
> +Example:
> +
> +lpass@28100000 {
> +	compatible = "qcom,lpass-cpu";
> +	clocks = <&lcc AHBIX_CLK>, <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
> +	clock-names = "ahbix-clk", "mi2s-osr-clk", "mi2s-bit-clk";
> +	interrupts = <0 85 1>;
> +	interrupt-names = "lpass-irq-lpaif";
> +	pinctrl-names = "default", "idle";
> +	pinctrl-0 = <&mi2s_default>;
> +	pinctrl-1 = <&mi2s_idle>;
> +	reg = <0x28100000 0x10000>;
> +	reg-names = "lpass-lpaif";
> +	qcom,adsp {
> +		status = "disabled";
> +	};
> +};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
