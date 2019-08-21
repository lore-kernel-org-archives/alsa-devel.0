From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
Date: Wed, 21 Aug 2019 16:44:36 -0500
Message-ID: <20190821214436.GA13936@bogus>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: vkoul@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 09, 2019 at 02:34:04PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for Soundwire Slave devices that includes how
> SoundWire enumeration address and Link ID are used to represented in
> SoundWire slave device tree nodes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soundwire/slave.txt   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt

Can you convert this to DT schema given it is a common binding.

What does the host controller look like? You need to define the node 
hierarchy. Bus controller schemas should then include the bus schema. 
See spi-controller.yaml.

> 
> diff --git a/Documentation/devicetree/bindings/soundwire/slave.txt b/Documentation/devicetree/bindings/soundwire/slave.txt
> new file mode 100644
> index 000000000000..201f65d2fafa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/slave.txt
> @@ -0,0 +1,51 @@
> +SoundWire slave device bindings.
> +
> +SoundWire is a 2-pin multi-drop interface with data and clock line.
> +It facilitates development of low cost, efficient, high performance systems.
> +
> +SoundWire slave devices:
> +Every SoundWire controller node can contain zero or more child nodes
> +representing slave devices on the bus. Every SoundWire slave device is
> +uniquely determined by the enumeration address containing 5 fields:
> +SoundWire Version, Instance ID, Manufacturer ID, Part ID
> +and Class ID for a device. Addition to below required properties,
> +child nodes can have device specific bindings.
> +
> +Required properties:
> +- compatible:	 "sdw<LinkID><VersionID><InstanceID><MFD><PID><CID>".
> +		  Is the textual representation of SoundWire Enumeration
> +		  address along with Link ID. compatible string should contain
> +		  SoundWire Link ID, SoundWire Version ID, Instance ID,
> +		  Manufacturer ID, Part ID and Class ID in order
> +		  represented as above and shall be in lower-case hexadecimal
> +		  with leading zeroes. Vaild sizes of these fields are
> +		  LinkID is 1 nibble,
> +		  Version ID is 1 nibble
> +		  Instance ID in 1 nibble
> +		  MFD in 4 nibbles
> +		  PID in 4 nibbles
> +		  CID is 2 nibbles
> +
> +		  Version number '0x1' represents SoundWire 1.0
> +		  Version number '0x2' represents SoundWire 1.1

This can all be a regex.

> +		  ex: "sdw0110217201000" represents 0 LinkID,
> +		  SoundWire 1.0 version slave with Instance ID 1.
> +		  More Information on detail of encoding of these fields can be
> +		  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
> +
> +SoundWire example for Qualcomm's SoundWire controller:
> +
> +soundwire@c2d0000 {
> +	compatible = "qcom,soundwire-v1.5.0"
> +	reg = <0x0c2d0000 0x2000>;
> +
> +	spkr_left:wsa8810-left{
> +		compatible = "sdw0110217201000";
> +		...
> +	};
> +
> +	spkr_right:wsa8810-right{
> +		compatible = "sdw0120217201000";

The normal way to distinguish instances is with 'reg'. So I think you 
need 'reg' with Instance ID moved there at least. Just guessing, but 
perhaps Link ID, too? And for 2 different classes of device is that 
enough? 

Rob
