From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ASoC: da7218: Add bindings documentation for
 DA7218 audio codec
Date: Fri, 20 Nov 2015 09:53:51 -0600
Message-ID: <20151120155351.GA13917@rob-hp-laptop>
References: <cover.1447941395.git.Adam.Thomson.Opensource@diasemi.com>
 <add67c0ebac7a516d3cf515fea10a08b7cabadbc.1447941395.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <add67c0ebac7a516d3cf515fea10a08b7cabadbc.1447941395.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 19, 2015 at 01:59:34PM +0000, Adam Thomson wrote:
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/da7218.txt | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/da7218.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/da7218.txt b/Documentation/devicetree/bindings/sound/da7218.txt
> new file mode 100644
> index 0000000..18f8f09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/da7218.txt
> @@ -0,0 +1,104 @@
> +Dialog Semiconductor DA7218 Audio Codec bindings
> +
> +DA7218 is an audio codec with HP detect feature.
> +
> +======
> +
> +Required properties:
> +- compatible : Should be "dlg,da7217" or "dlg,da7218"
> +- reg: Specifies the I2C slave address
> +
> +- VDD-supply: VDD power supply for the device
> +- VDDMIC-supply: VDDMIC power supply for the device
> +- VDDIO-supply: VDDIO power supply for the device

These should be lower case (that is documented in ePAPR BTW :)).

> +  (See Documentation/devicetree/bindings/regulator/regulator.txt for further
> +   information relating to regulators)
> +
> +Optional properties:
> +- interrupt-parent: Specifies the phandle of the interrupt controller to which
> +  the IRQs from DA7218 are delivered to.
> +- interrupts: IRQ line info for DA7218 chip.
> +  (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
> +   further information relating to interrupt properties)
> +- interrupt-names : Name associated with interrupt line. Should be "wakeup" if
> +  interrupt is to be used to wake system, otherwise "irq" should be used.
> +- wakeup-source: Flag to indicate this device can wake system (suspend/resume).
> +
> +- clocks : phandle and clock specifier for codec MCLK.
> +- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
> +
> +- dlg,micbias1-lvl-millivolt : Voltage (mV) for Mic Bias 1
> +	[<1200>, <1600>, <1800>, <2000>, <2200>, <2400>, <2600>, <2800>, <3000>]
> +- dlg,micbias2-lvl-millivolt : Voltage (mV) for Mic Bias 2
> +	[<1200>, <1600>, <1800>, <2000>, <2200>, <2400>, <2600>, <2800>, <3000>]
> +- dlg,mic1-amp-in-sel : Mic1 input source type
> +	["diff", "se_p", "se_n"]
> +- dlg,mic2-amp-in-sel : Mic2 input source type
> +	["diff", "se_p", "se_n"]
> +- dlg,dmic1-data-sel : DMIC1 channel select based on clock edge.
> +	["lrise_rfall", "lfall_rrise"]
> +- dlg,dmic1-samplephase : When to sample audio from DMIC1.
> +	["on_clkedge", "between_clkedge"]
> +- dlg,dmic1-clkrate-hertz : DMic1 clock frequency (Hz).

-hz

Documenting the unit suffixes is on my todo list...

> +	[<1500000>, <3000000>]
> +- dlg,dmic2-data-sel : DMic2 channel select based on clock edge.
> +	["lrise_rfall", "lfall_rrise"]
> +- dlg,dmic2-samplephase : When to sample audio from DMic2.
> +	["on_clkedge", "between_clkedge"]
> +- dlg,dmic2-clkrate-hertz : DMic2 clock frequency (Hz).

-hz

> +	[<1500000>, <3000000>]
> +- dlg,hp-diff-single-supply : Boolean flag, use single supply for HP
> +			      (DA7217 only)
> +
> +======
> +
> +Optional Child node - 'da7218_hpldet' (DA7218 only):
> +
> +Optional properties:
> +- dlg,jack-rate-microsecond : Time between jack detect measurements (us)

-us

Completely consistent, isn't it. Why we did -microvolt I don't know.

Rob

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
