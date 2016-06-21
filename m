From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 2/2] ASoC: cs35l33: Add device tree bindings file for
 cs35l33
Date: Tue, 21 Jun 2016 14:21:37 -0500
Message-ID: <20160621192137.GA11832@rob-hp-laptop>
References: <1466441119-8488-1-git-send-email-Paul.Handrigan@cirrus.com>
 <1466441119-8488-2-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466441119-8488-2-git-send-email-Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2016 at 11:45:19AM -0500, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org wrote:
> From: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> 
> Add device tree bindings file for the cs35l33 8V boosted
> class D amplifier.
> 
> Signed-off-by: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/cs35l33.txt          | 118 +++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cs35l33.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/cs35l33.txt b/Documentation/devicetree/bindings/sound/cs35l33.txt
> new file mode 100644
> index 0000000..bea6de7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cs35l33.txt
> @@ -0,0 +1,118 @@
> +CS35L33 Speaker Amplifier
> +
> +Required properties:
> +
> +  - compatible : "cirrus,cs35l33"
> +
> +  - reg : the I2C address of the device for I2C
> +
> +  - VA-supply, VP-supply : power supplies for the device,
> +    as covered in
> +    Documentation/devicetree/bindings/regulator/regulator.txt.
> +
> +Optional properties:
> +
> +  - reset-gpios : gpio used to reset the amplifier
> +
> +  - interrupt-parent : Specifies the phandle of the interrupt controller to
> +    which the IRQs from CS35L33 are delivered to.
> + -  interrupts : IRQ line info CS35L33.
> +    (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +    for further information relating to interrupt properties)
> +
> +  - cirrus,boost-ctl : Booster voltage use to supply the amp. If the value is
> +    0, then VBST = VP. If greater than 0, the boost voltage will be 3300mV with
> +    a value of 1 and will increase at a step size of 100mV until a maximum of
> +    8000mV.
> +
> +  - cirrus,ramp-rate : On power up, it affects the time from when the power
> +    up sequence begins to the time the audio reaches a full-scale output.
> +    On power down, it affects the time from when the power-down sequence
> +    begins to when the amplifier disables the PWM outputs. If this property
> +    is not set then soft ramping will be disabled and ramp time would be
> +    20ms. If this property is set to 0,1,2,3 then ramp times would be 40ms,
> +    60ms,100ms,175ms respectively for 48KHz sample rate.
> +
> +  - cirrus,boost-ipk : The maximum current allowed for the boost converter.
> +    The range starts at 1850000uA and goes to a maximum of 3600000uA
> +    with a step size of 15625uA. The default is 2500000uA.
> +
> +  - cirrus,imon-adc-scale : Configures the scaling of data bits from the IMON
> +    ADC data word. This property can be set as a value of 0 for bits 15 down
> +    to 0, 6 for 21 down to 6, 7, for 22 down to 7, 8 for 23 down to 8.
> +
> +  - cirrus,hg-algo : Parameters for internal Class H/G algorithm that
> +    controls the amplifier supplies.

It is not clear that this is a node not a property, and everything 
below is part of the sub-node. The example is not the binding 
documentation. I should be able to write the example or validate the 
binding based on the documentation.

> +
> +  - cirrus,mem-depth : Memory depth for the Class H/G algorithm measured in
> +    LRCLK cycles. If this property is set to 0, 1, 2, or 3 then the memory
> +    depths will be 1, 4, 8, 16 LRCLK cycles.  The default is 16 LRCLK cycles.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
