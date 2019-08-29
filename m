From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: soundwire: add slave bindings
Date: Thu, 29 Aug 2019 10:42:37 -0500
Message-ID: <CAL_JsqLwbz5eiBEw8PmXsJrxzXffNc7rRON-wQ0KviVW8JVv5A@mail.gmail.com>
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org> <20190829144442.6210-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829144442.6210-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>, spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 29, 2019 at 9:45 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> This patch adds bindings for Soundwire Slave devices that includes how
> SoundWire enumeration address and Link ID are used to represented in
> SoundWire slave device tree nodes.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../soundwire/soundwire-controller.yaml       | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>
> diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> new file mode 100644
> index 000000000000..449b6130ce63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0

(GPL-2.0-only OR BSD-2-Clause) for new bindings.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoundWire Controller Generic Binding
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description: |
> +  SoundWire busses can be described with a node for the SoundWire controller
> +  device and a set of child nodes for each SoundWire slave on the bus.
> +
> +properties:
> +  $nodename:
> +    pattern: "^soundwire(@.*)?$"
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^.*@[0-9a-f],[0-9a-f]$":
> +    type: object
> +
> +    properties:
> +      compatible:
> +        pattern: "^sdw[0-9a-f]{1}[0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
> +        description: Is the textual representation of SoundWire Enumeration
> +          address. compatible string should contain SoundWire Version ID,
> +          Manufacturer ID, Part ID and Class ID in order and shall be in
> +          lower-case hexadecimal with leading zeroes.
> +          Valid sizes of these fields are
> +          Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
> +          and '0x2' represents SoundWire 1.1 and so on.
> +          MFD is 4 nibbles
> +          PID is 4 nibbles
> +          CID is 2 nibbles
> +          More Information on detail of encoding of these fields can be
> +          found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
> +
> +      reg:
> +        maxItems: 1
> +        description:
> +          Link ID followed by Instance ID of SoundWire Device Address.
> +
> +    additionalProperties: false

I'm pretty sure you'll want nodes with other properties. If not, then
why are they in DT? So drop this.

Both the controller and child nodes need to list required properties.

> +
> +examples:
> +  - |
> +    soundwire@c2d0000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x0c2d0000 0x2000>;
> +
> +        speaker@0,1 {
> +            compatible = "sdw10217201000";
> +            reg = <0 1>;
> +        };
> +
> +        speaker@0,2 {
> +            compatible = "sdw10217201000";
> +            reg = <0 2>;
> +        };
> +    };
> +
> +...
> --
> 2.21.0
>
