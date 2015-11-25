From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] ASoC: da7218: Add bindings documentation for
 DA7218 audio codec
Date: Wed, 25 Nov 2015 14:06:38 -0600
Message-ID: <20151125200638.GI30473@rob-hp-laptop>
References: <cover.1448461029.git.Adam.Thomson.Opensource@diasemi.com>
 <6803c3c07d01b4803892bca8e88958037ea38cbc.1448461029.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6803c3c07d01b4803892bca8e88958037ea38cbc.1448461029.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2015 at 02:24:33PM +0000, Adam Thomson wrote:
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  Documentation/devicetree/bindings/sound/da7218.txt | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/da7218.txt

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/sound/da7218.txt b/Documentation/devicetree/bindings/sound/da7218.txt
> new file mode 100644
> index 0000000..5ca5a70
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
> +- dlg,dmic1-clkrate-hz : DMic1 clock frequency (Hz).
> +	[<1500000>, <3000000>]
> +- dlg,dmic2-data-sel : DMic2 channel select based on clock edge.
> +	["lrise_rfall", "lfall_rrise"]
> +- dlg,dmic2-samplephase : When to sample audio from DMic2.
> +	["on_clkedge", "between_clkedge"]
> +- dlg,dmic2-clkrate-hz : DMic2 clock frequency (Hz).
> +	[<1500000>, <3000000>]
> +- dlg,hp-diff-single-supply : Boolean flag, use single supply for HP
> +			      (DA7217 only)
> +
> +======
> +
> +Optional Child node - 'da7218_hpldet' (DA7218 only):
> +
> +Optional properties:
> +- dlg,jack-rate-us : Time between jack detect measurements (us)
> +	[<5>, <10>, <20>, <40>, <80>, <160>, <320>, <640>]
> +- dlg,jack-debounce : Number of debounce measurements taken for jack detect
> +	[<0>, <2>, <3>, <4>]
> +- dlg,jack-threshold-pct : Threshold level for jack detection (% of VDD)
> +	[<84>, <88>, <92>, <96>]
> +- dlg,comp-inv : Boolean flag, invert comparator output
> +- dlg,hyst : Boolean flag, enable hysteresis
> +- dlg,discharge : Boolean flag, auto discharge of Mic Bias on jack removal
> +
> +======
> +
> +Example:
> +
> +	codec: da7218@1a {
> +		compatible = "dlg,da7218";
> +		reg = <0x1a>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> +		wakeup-source;
> +
> +		VDD-supply = <&reg_audio>;
> +		VDDMIC-supply = <&reg_audio>;
> +		VDDIO-supply = <&reg_audio>;
> +
> +		clocks = <&clks 201>;
> +		clock-names = "mclk";
> +
> +		dlg,micbias1-lvl-millivolt = <2600>;
> +		dlg,micbias2-lvl-millivolt = <2600>;
> +		dlg,mic1-amp-in-sel = "diff";
> +		dlg,mic2-amp-in-sel = "diff";
> +
> +		dlg,dmic1-data-sel = "lrise_rfall";
> +		dlg,dmic1-samplephase = "on_clkedge";
> +		dlg,dmic1-clkrate-hz = <3000000>;
> +		dlg,dmic2-data-sel = "lrise_rfall";
> +		dlg,dmic2-samplephase = "on_clkedge";
> +		dlg,dmic2-clkrate-hz = <3000000>;
> +
> +		da7218_hpldet {
> +			dlg,jack-rate-us = <40>;
> +			dlg,jack-debounce = <2>;
> +			dlg,jack-threshold-pct = <84>;
> +			dlg,hyst;
> +		};
> +	};
> --
> 1.9.3
> 
