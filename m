From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RESEND PATCH v4 1/4] dt-bindings: soundwire: add
 slave bindings
Date: Fri, 23 Aug 2019 10:41:33 -0500
Message-ID: <7da8aa89-2119-21d1-0e29-8894a8d40bf0@linux.intel.com>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, spapothi@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 8/22/19 6:37 PM, Srinivas Kandagatla wrote:
> This patch adds bindings for Soundwire Slave devices that includes how
> SoundWire enumeration address and Link ID are used to represented in
> SoundWire slave device tree nodes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   .../soundwire/soundwire-controller.yaml       | 75 +++++++++++++++++++
>   1 file changed, 75 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> new file mode 100644
> index 000000000000..91aa6c6d6266
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoundWire Controller Generic Binding
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  SoundWire busses can be described with a node for the SoundWire controller
> +  device and a set of child nodes for each SoundWire slave on the bus.
> +
> +properties:
> +  $nodename:
> +    pattern: "^soundwire(@.*|-[0-9a-f])*$"
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +
> +    properties:
> +      compatible:
> +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"

So is this a 64-bit value, as in the MIPI spec, or is this part of the 
_ADR description?
I also don't get why the first item in in base10?


> +      description:
> +	  Is the textual representation of SoundWire Enumeration
> +	  address. compatible string should contain SoundWire Version ID,
> +	  Manufacturer ID, Part ID and Class ID in order and shall be in
> +	  lower-case hexadecimal with leading zeroes.
> +	  Valid sizes of these fields are
> +	  Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
> +	  and '0x2' represents SoundWire 1.1 and so on.
> +	  MFD is 4 nibbles
> +	  PID is 4 nibbles
> +	  CID is 2 nibbles
> +	  More Information on detail of encoding of these fields can be
> +	  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
> +
> +      reg:
> +        maxItems: 1
> +        description:
> +          Instance ID and Link ID of SoundWire Device Address.
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +examples:
> +  - |
> +    soundwire@c2d0000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        compatible = "qcom,soundwire-v1.5.0";
> +        reg = <0x0c2d0000 0x2000>;
> +
> +        speaker@1 {
> +            compatible = "sdw10217201000";
> +            reg = <1 0>;
> +        };
> +
> +        speaker@2 {
> +            compatible = "sdw10217201000";
> +            reg = <2 0>;
> +        };
> +    };
> +
> +...
> 
