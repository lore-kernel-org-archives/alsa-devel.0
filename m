From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: ASoC: tlv320aic26: Add device tree
 binding
Date: Sun, 31 Mar 2019 01:41:21 -0500
Message-ID: <20190331010229.GA10206@bogus>
References: <20190321221549.13765-1-jcormier@criticallink.com>
 <20190321221549.13765-3-jcormier@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190321221549.13765-3-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cormier, Jonathan" <jcormier@criticallink.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 21, 2019 at 06:15:44PM -0400, Cormier, Jonathan wrote:
> Add support for the TI tlv320aic26 sound codec
> 
> Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
> ---
>  .../devicetree/bindings/sound/tlv320aic26.txt | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic26.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320aic26.txt b/Documentation/devicetree/bindings/sound/tlv320aic26.txt
> new file mode 100644
> index 000000000000..93aa0f76ec0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tlv320aic26.txt
> @@ -0,0 +1,65 @@
> +Texas Instruments - tlv320aic26 Codec module
> +
> +The tlv320aic26 serial control bus communicates through I2C protocols
> +
> +Required properties:
> +
> +- compatible - "string" - One of:
> +    "ti,tlv320aic26" - TLV320AIC26
> +- reg - <int> -  SPI chip select
> +
> +CODEC input pins:
> +  * MICIN
> +  * AUX
> +
> +CODEC output pins:
> +  * HPL
> +  * HPR
> +
> +The pins can be used in referring sound node's audio-routing property.
> +
> +Example:
> +
> +tlv320aic26: tlv320aic26@0 {

audio-codec@0

> +	compatible = "ti,tlv320aic26";
> +	reg = <0>;
> +};
> +
> +&spi0 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&spi0_pins>;
> +	pinctrl-1 = <&spi0_sleep_pins>;
> +
> +	status = "okay";

Don't show status in examples.

> +	ti,pindir-d0-out-d1-in = <1>;
> +
> +	tlv320aic26: tlv320aic26@1 {

This split is convention, but outside the scope of binding docs, so 
please just show the complete node.

> +		compatible = "ti,tlv320aic26";
> +		reg = <0x1>;
> +		status = "okay";
> +
> +		spi-max-frequency = <2000000>;
> +		spi-cpha;
> +	};
> +};
> +
> +sound {
> +	compatible = "simple-audio-card";
> +	simple-audio-card,name = "AM335x_SND";
> +	simple-audio-card,format = "dsp_b";
> +	/* SND_SOC_DAIFMT_CBM_CFM */
> +	simple-audio-card,bitclock-master = <&tlv320aic26_codec>;
> +	simple-audio-card,frame-master = <&tlv320aic26_codec>;
> +	/* SND_SOC_DAIFMT_IB_NF */
> +	simple-audio-card,bitclock-inversion;
> +
> +	simple-audio-card,cpu {
> +		sound-dai = <&mcasp1>;
> +		system-clock-frequency = <24576000>;
> +	};
> +
> +	tlv320aic26_codec: simple-audio-card,codec {
> +		sound-dai = <&tlv320aic26>;
> +		system-clock-frequency = <24576000>;
> +	};
> +};
> -- 
> 2.21.0
> 
