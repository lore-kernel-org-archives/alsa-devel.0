From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: soundwire: add slave bindings
Date: Thu, 8 Aug 2019 10:58:49 -0500
Message-ID: <d346b2af-f285-4c53-b706-46a129ab7951@linux.intel.com>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org, broonie@kernel.org
Cc: bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


> +++ b/Documentation/devicetree/bindings/soundwire/slave.txt
> @@ -0,0 +1,46 @@
> +SoundWire slave device bindings.
> +
> +SoundWire is a 2-pin multi-drop interface with data and clock line.
> +It facilitates development of low cost, efficient, high performance systems.
> +
> +SoundWire slave devices:
> +Every SoundWire controller node can contain zero or more child nodes
> +representing slave devices on the bus. Every SoundWire slave device is
> +uniquely determined by the enumeration address containing 5 fields:
> +SoundWire Version, Instance ID, Manufacturer ID, Part ID and Class ID
> +for a device. Addition to below required properties, child nodes can
> +have device specific bindings.

In case the controller supports multiple links, what's the encoding then?
in the MIPI DisCo spec there is a linkId field in the _ADR encoding that 
helps identify which link the Slave device is connected to

> +
> +Required property for SoundWire child node if it is present:
> +- compatible:	 "sdwVER,MFD,PID,CID". The textual representation of
> +		  SoundWire Enumeration address comprising SoundWire
> +		  Version, Manufacturer ID, Part ID and Class ID,
> +		  shall be in lower-case hexadecimal with leading
> +		  zeroes suppressed.
> +		  Version number '0x10' represents SoundWire 1.0
> +		  Version number '0x11' represents SoundWire 1.1
> +		  ex: "sdw10,0217,2010,0"
> +
> +- sdw-instance-id: Should be ('Instance ID') from SoundWire
> +		  Enumeration Address. Instance ID is for the cases
> +		  where multiple Devices of the same type or Class
> +		  are attached to the bus.

so it is actually required if you have a single Slave device? Or is it 
only required when you have more than 1 device of the same type?

FWIW in the MIPI DisCo spec we kept the instanceID as part of the _ADR, 
so it's implicitly mandatory (and ignored by the bus if there is only 
one device of the same time)

> +
> +SoundWire example for Qualcomm's SoundWire controller:
> +
> +soundwire@c2d0000 {
> +	compatible = "qcom,soundwire-v1.5.0"
> +	reg = <0x0c2d0000 0x2000>;
> +
> +	spkr_left:wsa8810-left{
> +		compatible = "sdw10,0217,2010,0";
> +		sdw-instance-id = <1>;
> +		...
> +	};
> +
> +	spkr_right:wsa8810-right{
> +		compatible = "sdw10,0217,2010,0";
> +		sdw-instance-id = <2>;

Isn't the MIPI encoding reported in the Dev_ID0..5 registers 0-based?

> +		...
> +	};
> +};
> 

And now that I think of it, wouldn't it be simpler for everyone if we 
aligned on that MIPI DisCo public spec? e.g. you'd have one property 
with a 64-bit number that follows the MIPI spec. No special encoding 
necessary for device tree cases, your DT blob would use this:

soundwire@c2d0000 {
	compatible = "qcom,soundwire-v1.5.0"
	reg = <0x0c2d0000 0x2000>;

	spkr_left:wsa8810-left{
		compatible = "sdw0000100217201000"
	}

	spkr_right:wsa8810-right{
		compatible = "sdw0000100217201100"
	}
}

We could use parentheses if it makes people happier, but the information 
from the MIPI DisCo spec can be used as is, and provide a means for spec 
changes via reserved bits.
