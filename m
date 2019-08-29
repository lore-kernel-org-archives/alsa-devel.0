From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 3/4] dt-bindings: ASoC: Add WSA881x bindings
Date: Thu, 29 Aug 2019 10:46:30 -0500
Message-ID: <CAL_JsqLOHA+r9UCTwyvj+_BzWSrsVDZw5vp-1XhYYvQxncx0sw@mail.gmail.com>
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org> <20190829144442.6210-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829144442.6210-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>, spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 29, 2019 at 9:45 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
> Amplifier. This Amplifier also has a simple thermal sensor for
> over temperature and speaker protection.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wsa881x.yaml          | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
> new file mode 100644
> index 000000000000..7a486c024732
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license please.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,wsa881x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  WSA8810 is a class-D smart speaker amplifier and WSA8815
> +  is a high-output power class-D smart speaker amplifier.
> +  Their primary operating mode uses a SoundWire digital audio
> +  interface. This binding is for SoundWire interface.
> +
> +properties:
> +  compatible:
> +    const: "sdw10217201000"

No need for quotes.

> +
> +  reg:
> +    maxItems: 1
> +

> +  powerdown-gpios:
> +    description: GPIO spec for Powerdown/Shutdown line to use
> +    maxItems: 1
> +
> +  '#thermal-sensor-cells':
> +    const: 0

Either of these required?

Here you can put 'additionalProperties: false'

> +
> +examples:
> +  - |
> +    speaker@0,1 {

This should be under a soundwire bus node.

> +        compatible = "sdw10217201000";
> +        reg = <0 1>;
> +        powerdown-gpios = <&wcdpinctrl 2 0>;
> +        #thermal-sensor-cells = <0>;
> +    };
> +
> +...
> --
> 2.21.0
>
