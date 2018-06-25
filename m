From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: qcom: dt-bindings: Add sdm845 machine
 bindings
Date: Mon, 25 Jun 2018 13:17:37 -0600
Message-ID: <20180625191737.GA13246@rob-hp-laptop>
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-2-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529578399-3633-2-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 21, 2018 at 04:23:18PM +0530, Rohit kumar wrote:
> Add devicetree bindings documentation file for SDM845 sound card.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,sdm845.txt      | 82 ++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> new file mode 100644
> index 0000000..68feb08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> @@ -0,0 +1,82 @@
> +* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
> +
> +This binding describes the SDM845 sound card, which uses qdsp for audio.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,sdm845-sndcard"
> +
> +- qcom,audio-routing:

Use just 'audio-routing'.

> +	Usage: Optional
> +	Value type: <stringlist>
> +	Definition:  A list of the connections between audio components.
> +		  Each entry is a pair of strings, the first being the
> +		  connection's sink, the second being the connection's
> +		  source. Valid names could be power supplies, MicBias
> +		  of codec and the jacks on the board.
> +
> +- cdc-vdd-supply:
> +	Usage: Optional
> +	Value type: <phandle>
> +	Definition: phandle of regulator supply required for codec vdd.

The codec supply should be in the codec node.

> +
> += dailinks
> +Each subnode of sndcard represents either a dailink, and subnodes of each
> +dailinks would be cpu/codec/platform dais.
> +
> +- link-name:
> +	Usage: required
> +	Value type: <string>
> +	Definition: User friendly name for dai link
> +
> += CPU, PLATFORM, CODEC dais subnodes
> +- cpu:
> +	Usage: required
> +	Value type: <subnode>
> +	Definition: cpu dai sub-node
> +
> +- codec:
> +	Usage: required
> +	Value type: <subnode>
> +	Definition: codec dai sub-node
> +
> +- platform:
> +	Usage: Optional
> +	Value type: <subnode>
> +	Definition: platform dai sub-node
> +
> +- sound-dai:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
> +
> +Example:
> +
> +audio {
> +	compatible = "qcom,sdm845-sndcard";
> +	qcom,model = "sdm845-snd-card";

Not documented. Just use 'model'.

> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pri_mi2s_active &pri_mi2s_ws_active>;
> +	pinctrl-1 = <&pri_mi2s_sleep &pri_mi2s_ws_sleep>;
> +
> +	cdc-vdd-supply = <&pm8998_l14>;
> +
> +	mm1-dai-link {
> +		link-name = "MultiMedia1";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +		};
> +	};
> +
> +	pri-mi2s-dai-link {
> +		link-name = "PRI MI2S Playback";
> +		cpu {
> +			sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +	};
> +};
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
