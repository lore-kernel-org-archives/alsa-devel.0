From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ASoC: cs35l35: Add device tree documentation for
 CS35L35
Date: Mon, 19 Dec 2016 12:10:11 -0600
Message-ID: <20161219181011.mgpaoflzjysy3ydd@rob-hp-laptop>
References: <1481646404-19012-1-git-send-email-li.xu@cirrus.com>
 <7900b605-6715-4c95-ac44-381b0f7bc95d@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7900b605-6715-4c95-ac44-381b0f7bc95d-XU/xxMRwCJnfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 13, 2016 at 10:26:44AM -0600, Li Xu wrote:
> Add device tree documentation for Cirrus Logic CS35L35
> speaker amplifier
> 
> Signed-off-by: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/cs35l35.txt          | 172 +++++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cs35l35.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/cs35l35.txt b/Documentation/devicetree/bindings/sound/cs35l35.txt
> new file mode 100644
> index 0000000..8b13f67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cs35l35.txt
> @@ -0,0 +1,172 @@
> +CS35L35 Speaker Amplifier
> +
> +Required properties:
> +
> +  - compatible : "cirrus,cs35l35"
> +
> +  - reg : the I2C address of the device for I2C
> +
> +  - VA-supply, VP-supply : power supplies for the device,
> +    as covered in
> +    Documentation/devicetree/bindings/regulator/regulator.txt.
> +
> +  - interrupt-parent : Specifies the phandle of the interrupt controller to
> +    which the IRQs from CS35L35 are delivered to.
> +  - interrupts : IRQ line info CS35L35.
> +    (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +    for further information relating to interrupt properties)
> +
> +Optional properties:
> +  - cirrus,reset-gpios : Active low GPIO used to reset the amplifier

You can drop cirrus here. reset-gpios is pretty standard.

> +
> +  - cirrus,stereo-config : Boolean to determine if there are 2 AMPs for a
> +  Stereo configuration

The example shows this as a node. I prefer a property.

> +  - cirrus,audio-channel : Set Location of Audio Signal on Serial Port
> +  0 = Data Packet received on Left I2S Channel
> +  1 = Data Packet received on Right I2S Channel
> +
> +  - cirrus,advisory-channel : Set Location of Advisory Signal on Serial Port
> +  0 = Data Packet received on Left I2S Channel
> +  1 = Data Packet received on Right I2S Channel
> +
> +  - cirrus,shared-boost : Boolean to enable ClassH tracking of Advisory Signal
> +  if 2 Devices share Boost BST_CTL
> +
> +  - cirrus,sp-drv-strength : Value for setting the Serial Port drive strength
> +  Table 3-10 of the datasheet lists drive-strength specifications
> +  0 = 1x (Default)
> +  1 = .5x
> +
> +  - cirrus,bst-pdn-fet-on : Boolean to determine if the Boost PDN control
> +  powers down with a rectification FET On or Off. If VSPK is supplied
> +  externally then FET is off.
> +
> +  - cirrus,boost-ctl-millivolt : Boost Converter control word. Step Size of 100mV
> +  0x00 = (Default) VP
> +  0x01 = 2600mV
> +  0x41 = 9000mV
> +
> +  - cirrus,boost-ipk-milliamp : Boost-converter peak current limit.
> +  Configures the peak current by monitoring the current through the boost FET.
> +  Step size: 112mA
> +  0x00 = 1680mA
> +  0x19 = 4480mA

Either make the values be actual mV or mA (actually, uV and uA are the 
standard, see property-units.txt) or drop the unit suffix.

> +
> +  - cirrus,amp-gain-zc : Boolean to determine if to use Amplifier gain-change
> +  zero-cross
> +
> +Optional H/G Algorithm sub-node:
> +
> +  The cs35l35 node can have a single "cirrus,classh-internal-algo" sub-node
> +  that will disable automatic control of the internal H/G Algorithm.
> +
> +  It is strongly recommended that the Datasheet be referenced when adjusting
> +  or using these Class H Algorithm controls over the internal Algorithm.
> +  Serious damage can occur to the Device and surrounding components.
> +
> +  - cirrus,classh-internal-algo : Sub-node for the Internal Class H Algorithm
> +  See Section 4.3 Internal Class H Algorithm in the Datasheet.
> +  If not used, the device manages the ClassH Algorithm internally.
> +
> +Optional properties for the "cirrus,classh-internal-algo" Sub-node
> +
> +  Section 7.29 Class H Control
> +  - cirrus,classh-bst-overide : Boolean
> +  - cirrus,classh-bst-max-limit
> +  - cirrus,classh-mem-depth
> +
> +  Section 7.30 Class H Headroom Control
> +  - cirrus,classh-headroom
> +
> +  Section 7.31 Class H Release Rate
> +  - cirrus,classh-release-rate
> +
> +  Section 7.32 Class H Weak FET Drive Control
> +  - cirrus,classh-wk-fet-disable
> +  - cirrus,classh-wk-fet-delay
> +  - cirrus,classh-wk-fet-thld
> +
> +  Section 7.34 Class H VP Control
> +  - cirrus,classh-vpch-auto
> +  - cirrus,classh-vpch-rate
> +  - cirrus,classh-vpch-man
> +
> +Optional Monitor Signal Format sub-node:
> +
> +  The cs35l35 node can have a single "cirrus,monitor-signal-format" sub-node
> +  for adjusting the Depth, Location and Frame of the Monitoring Signals
> +  for Algorithms.
> +
> +  See Sections 4.8.2 through 4.8.4 Serial-Port Control in the Datasheet
> +
> +  -cirrus,monitor-signal-format : Sub-node for the Monitor Signaling Formating
> +  on the I2S Port. Each of the 3 8 bit values in the array contain the settings
> +  for depth, location, and frame.
> +
> +  If not used, the defaults for the 6 monitor signals is used.
> +
> +  Sections 7.44 - 7.53 lists values for the depth, location, and frame
> +  for each monitoring signal.
> +
> +  - cirrus,imon : 3 8 bit values to set the depth, location, and frame
> +  of the IMON monitor signal.
> +
> +  - cirrus,vmon : 3 8 bit values to set the depth, location, and frame
> +  of the VMON monitor signal.
> +
> +  - cirrus,vpmon : 3 8 bit values to set the depth, location, and frame
> +  of the VPMON monitor signal.
> +
> +  - cirrus,vbstmon : 3 8 bit values to set the depth, location, and frame
> +  of the VBSTMON monitor signal
> +
> +  - cirrus,vpbrstat : 3 8 bit values to set the depth, location, and frame
> +  of the VPBRSTAT monitor signal
> +
> +  - cirrus,zerofill : 3 8 bit values to set the depth, location, and frame\

stray \

> +  of the ZEROFILL packet in the monitor signal
> +
> +Example:
> +
> +cs35l35: audio-codec@20 {
> +	compatible = "cirrus,cs35l35";
> +	reg = <0x20>;
> +	VA-supply = <&dummy_vreg>;
> +	VP-supply = <&dummy_vreg>;
> +	reset-gpios = <&axi_gpio 54 1>;
> +	interrupt-parent = <&gpio8>;
> +	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +	cirrus,boost-ctl = <0x41>;
> +
> +	cirrus,stereo-config {
> +		cirrus,audio-channel = <0x00>;
> +		cirrus,advisory-channel = <0x01>;
> +		cirrus,shared-boost;
> +	};
> +
> +	cirrus,classh-internal-algo {
> +		cirrus,classh-bst-overide;
> +		cirrus,classh-bst-max-limit = <0x01>;
> +		cirrus,classh-mem-depth = <0x01>;
> +		cirrus,classh-release-rate = <0x08>;
> +		cirrus,classh-headroom-millivolt = <0x0B>;
> +		cirrus,classh-wk-fet-disable = <0x01>;
> +		cirrus,classh-wk-fet-delay = <0x04>;
> +		cirrus,classh-wk-fet-thld = <0x01>;
> +		cirrus,classh-vpch-auto = <0x01>;
> +		cirrus,classh-vpch-rate = <0x02>;
> +		cirrus,classh-vpch-man = <0x05>;
> +	};
> +
> +	/* Depth, Location, Frame */
> +	cirrus,monitor-signal-format {
> +		cirrus,imon = /bits/ 8 <0x03 0x00 0x01>;
> +		cirrus,vmon = /bits/ 8 <0x03 0x00 0x00>;
> +		cirrus,vpmon = /bits/ 8 <0x03 0x04 0x00>;
> +		cirrus,vbstmon = /bits/ 8 <0x03 0x04 0x01>;
> +		cirrus,vpbrstat = /bits/ 8 <0x00 0x04 0x00>;
> +		cirrus,zerofill = /bits/ 8 <0x00 0x00 0x00>;
> +	};
> +
> +};
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
