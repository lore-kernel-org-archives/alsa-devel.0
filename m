From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6] ASoC: cs53l30: Add codec driver support for Cirrus
 CS53L30
Date: Wed, 25 May 2016 12:28:00 -0500
Message-ID: <20160525172800.GB3056@rob-hp-laptop>
References: <1464045237-4074-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464045237-4074-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: broonie@kernel.org, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, lgirdwood@gmail.com, Tim.Howe@cirrus.com, somduttar@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 23, 2016 at 04:13:57PM -0700, Nicolin Chen wrote:
> CS53L30 is a Quad-Channel ADC from Cirrus Logic with an I2S/TDM DAI.
> So this patch adds support for CS53L30 that supports 24-bit recording
> feature.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog:
> v5->v6
>  * Added clock controls
>  * Reconstructed bitfield macros and improved coding style
>  * Fixed some misuses of regmap_update_bits()
>  * Added TLV volume controls to replace enums for preamplifier
>  * Added micbias level in DT instead of exposing to user-space
>  * Simplified SDOUTx controls by removing cs53l30_asp_sdout_event()
>    (Still be able to use set_tristate() instead)
>  * Removed useless header files and sort the rest alphabetically
>  * Registered runtime pm functions to the driver
>  * Added regulator controls (VA and VP)
>  * Added writeable register function for regmap
>  * Merged two ASP dais
>  * Added TDM support
>  * Added a simple introduction in commit log
> 
>  .../devicetree/bindings/sound/cs53l30.txt          |   38 +
>  sound/soc/codecs/Kconfig                           |    6 +
>  sound/soc/codecs/Makefile                          |    2 +
>  sound/soc/codecs/cs53l30.c                         | 1097 ++++++++++++++++++++
>  sound/soc/codecs/cs53l30.h                         |  458 ++++++++
>  5 files changed, 1601 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cs53l30.txt
>  create mode 100644 sound/soc/codecs/cs53l30.c
>  create mode 100644 sound/soc/codecs/cs53l30.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/cs53l30.txt b/Documentation/devicetree/bindings/sound/cs53l30.txt
> new file mode 100644
> index 0000000..ace7ffe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cs53l30.txt
> @@ -0,0 +1,38 @@
> +CS53L30 audio CODEC
> +
> +Required properties:
> +
> +  - compatible : "cirrus,cs53l30"
> +
> +  - reg : the I2C address of the device
> +
> +  - VA-supply, VP-supply : power supplies for the device,
> +    as covered in Documentation/devicetree/bindings/regulator/regulator.txt.

Also, these are missing from the example yet are required. I'd argue 
they should be optional as you could have designs with no regulator 
control.

> +
> +Optional properties:
> +
> +  - reset-gpios : a GPIO spec for the reset pin.
> +
> +  - micbias-lvl : Set the output voltage level on the MICBIAS Pin.
> +		  0 = Hi-Z
> +		  1 = 1.80 V
> +		  2 = 2.75 V
> +
> +  - use-sdout2 : This is a boolean property. If present, it indicates
> +		 the hardware design connects both SDOUT1 and SDOUT2
> +		 pins to output data. Otherwise, it indicates that
> +		 only SDOUT1 is connected for data output.
> +		 * CS53l30 supports 4-channel data output in the same
> +		 * frame using two different ways:
> +		 * 1) Normal I2S mode on two data pins -- each SDOUT
> +		 *    carries 2-channel data in the same time.
> +		 * 2) TDM mode on one signle data pin -- SDOUT1 carries
> +		 *    4-channel data per frame.
> +
> +Example:
> +
> +codec: cs53l30@48 {
> +        compatible = "cirrus,cs53l30";
> +        reg = <0x48>;
> +        reset-gpios = <&gpio 54 0>;
> +};
