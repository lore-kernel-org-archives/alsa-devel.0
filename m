From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: da7218: Add bindings documentation for
 DA7218 audio codec
Date: Wed, 11 Nov 2015 14:19:46 -0600
Message-ID: <20151111201946.GA24618@rob-hp-laptop>
References: <cover.1447254553.git.Adam.Thomson.Opensource@diasemi.com>
 <760d212f18efec816701f2b3e9fc549ca86d31ee.1447254553.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <760d212f18efec816701f2b3e9fc549ca86d31ee.1447254553.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 11, 2015 at 03:40:22PM +0000, Adam Thomson wrote:
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/da7218.txt | 106 +++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/da7218.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/da7218.txt b/Documentation/devicetree/bindings/sound/da7218.txt
> new file mode 100644
> index 0000000..35a53dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/da7218.txt
> @@ -0,0 +1,106 @@
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
> +- dlg,micbias1-lvl : Voltage (mV) for Mic Bias 1
> +	[<1200>, <1600>, <1800>, <2000>, <2200>, <2400>, <2600>, <2800>, <3000>]
> +- dlg,micbias2-lvl : Voltage (mV) for Mic Bias 2
> +	[<1200>, <1600>, <1800>, <2000>, <2200>, <2400>, <2600>, <2800>, <3000>]

Units please (-microvolt).

> +- dlg,mic1-amp-in-sel : Mic1 input source type
> +	["diff", "se_p", "se_n"]
> +- dlg,mic2-amp-in-sel : Mic2 input source type
> +	["diff", "se_p", "se_n"]
> +- dlg,dmic1-data-sel : DMIC1 channel select based on clock edge.
> +	["lrise_rfall", "lfall_rrise"]
> +- dlg,dmic1-samplephase : When to sample audio from DMIC1.
> +	["on_clkedge", "between_clkedge"]
> +- dlg,dmic1-clkrate : DMic1 clock frequency (Hz).
> +	[<1500000>, <3000000>]
> +- dlg,dmic2-data-sel : DMic2 channel select based on clock edge.
> +	["lrise_rfall", "lfall_rrise"]
> +- dlg,dmic2-samplephase : When to sample audio from DMic2.
> +	["on_clkedge", "between_clkedge"]
> +- dlg,dmic2-clkrate : DMic2 clock frequency (Hz).
> +	[<1500000>, <3000000>]
> +- dlg,hp-diff-single-supply : Boolean flag, use single supply for HP
> +			      (DA7217 only)
> +
> +======
> +
> +Optional Child node - 'da7218_hpldet' (DA7218 only):
> +
> +Optional properties:
> +- dlg,jack-rate : Time between jack detect measurements (us)
> +	[<5>, <10>, <20>, <40>, <80>, <160>, <320>, <640>]

Units

Rob

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
