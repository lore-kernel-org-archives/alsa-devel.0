From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: cs35l34: Add device tree bindings file for
 cs35l34
Date: Fri, 23 Sep 2016 12:34:03 -0500
Message-ID: <20160923173403.GA24394@rob-hp-laptop>
References: <1474062521-16911-1-git-send-email-Paul.Handrigan@cirrus.com>
 <c61a1616-e5c3-4443-9f98-8cadc7fd44ea@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c61a1616-e5c3-4443-9f98-8cadc7fd44ea-XU/xxMRwCJnfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2016 at 04:48:41PM -0500, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org wrote:
> From: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> 
> Add device tree bindings file for the cs35l34 8V boosted
> class D amplifier.
> 
> Signed-off-by: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/cs35l34.txt          | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cs35l34.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/cs35l34.txt b/Documentation/devicetree/bindings/sound/cs35l34.txt
> new file mode 100644
> index 0000000..df62e77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cs35l34.txt
> @@ -0,0 +1,64 @@
> +CS35L34 Speaker Amplifier
> +
> +Required properties:
> +
> +  - compatible : "cirrus,cs35l34"
> +
> +  - reg : the I2C address of the device for I2C.
> +
> +  - VA-supply, VP-supply : power supplies for the device,
> +    as covered in
> +    Documentation/devicetree/bindings/regulator/regulator.txt.
> +
> +  - cirrus,boost-vtge : Boost Voltage Value.  Configures the boost converter's
> +    output voltage in mV. The range is from VP to 8V with increments of 100mV.

Needs a unit suffix and -microvolt is preferred.

> +
> +  - cirrus,boost-ind: Inductor value for boost converter. The value is in nH
> +    and they can be values of 1000nH, 1100nH, 1200nH, 1500nH, and 2200nH.

Please add this unit to property-units.txt and use the suffix here.

> +
> +Optional properties:
> +
> +  - reset-gpios: GPIO used to reset the amplifier.
> +
> +  - interrupt-parent : Specifies the phandle of the interrupt controller to
> +    which the IRQs from CS35L34 are delivered to.
> +  - interrupts : IRQ line info CS35L34.
> +    (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +    for further information relating to interrupt properties)
> +
> +  - cirrus,boost-peak : Boost converter peak current limit in mA. The range
> +    starts at 1200mA and goes to a maximum of 3840mA with increments of 80mA.
> +    The default value is 2480mA.

unit suffix.

> +
> +  - cirrus,i2s-sdinloc : ADSP SDIN I2S channel location. Indicates whether the
> +    received mono data is in the left or right portion of the I2S frame
> +    according to the AD0 pin or directly via this configuration.
> +    0x0 (Default) = Selected by AD0 input (if AD0 = LOW, use left channel),
> +    0x2 = Left,
> +    0x1 = Selected by the inversion of the AD0 input (if AD0 = LOW, use right
> +    channel),
> +    0x3 = Right.
> +
> +  - cirrus,gain-zc-disable: Boolean property. If set, the gain change will take
> +    effect without waiting for a zero cross.
> +
> +  - cirrus,tdm_rising_edge: Boolean property. If set, data is on the rising edge of
> +    SCLK. Otherwise, data is on the falling edge of SCLK.

Use '-', not '_'.

> +
> +
> +Example:
> +
> +cs35l34: cs35l34@40 {
> +	compatible = "cirrus,cs35l34";
> +	reg = <0x40>;
> +
> +	interrupt-parent = <&gpio8>;
> +	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +
> +	reset-gpios = <&gpio 10 0>;
> +
> +	cirrus,boost-vtge = <8000>; /* 8V */
> +	cirrus,boost-ind = <1000>; /* 1uH */
> +	cirrus,boost-peak = <3000>; /* 3A */
> +};
> +
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
