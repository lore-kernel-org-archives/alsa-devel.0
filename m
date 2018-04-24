From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add
 apq8096 machine bindings
Date: Tue, 24 Apr 2018 11:25:17 -0500
Message-ID: <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 90E232675CD
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 18:25:19 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id p62-v6so18224836oie.10
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 09:25:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 18, 2018 at 04:31:55PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add devicetree bindings documentation file for Qualcomm apq8096 sound card.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,apq8096.txt     | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> new file mode 100644
> index 000000000000..37e23d926b95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> @@ -0,0 +1,76 @@
> +* Qualcomm Technologies APQ8096 ASoC sound card driver
> +
> +This binding describes the APQ8096 sound card, which uses qdsp for audio.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,apq8096-sndcard"
> +
> +- qcom,audio-routing:
> +	Usage: Optional
> +	Value type: <stringlist>
> +	Definition:  A list of the connections between audio components.
> +		  Each entry is a pair of strings, the first being the
> +		  connection's sink, the second being the connection's
> +		  source. Valid names could be power supplies, MicBias
> +		  of codec and the jacks on the board:

Please list out valid values here.

> +
> += dailinks
> +Each subnode of sndcard represents either a dailink, and subnodes of each
> +dailinks would be cpu/codec/platform dais.
> +
> +- link-name:

Not a standard property, but I guess that sneaked in with the 8016 
binding...

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
> +	Usage: Optional
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

phandle with args.

> +	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
> +
> +Example:
> +
> +audio {
> +	compatible = "qcom,apq8096-sndcard";
> +	qcom,model = "DB820c";
> +
> +	mm1-dai-link {
> +		link-name = "MultiMedia1";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +		};
> +	};
> +
> +	hdmi-dai-link {
> +		link-name = "HDMI Playback";
> +		cpu {
> +			sound-dai = <&q6afe HDMI_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6adm>;
> +		};
> +
> +		codec {
> +			sound-dai = <&hdmi 0>;
> +		};
> +	};
> +};
> -- 
> 2.16.2
> 
