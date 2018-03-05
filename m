From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add tda7419 audio processor binding
Date: Mon, 5 Mar 2018 16:29:54 -0600
Message-ID: <20180305222954.chitmlvsklszods7@rob-hp-laptop>
References: <20180227225128.17815-1-mporter@konsulko.com>
 <20180227225128.17815-2-mporter@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180227225128.17815-2-mporter@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@konsulko.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 27, 2018 at 05:51:27PM -0500, Matt Porter wrote:
> DeviceTree binding for the tda7419 audio processor.
> 
> Signed-off-by: Matt Porter <mporter@konsulko.com>
> ---
>  Documentation/devicetree/bindings/sound/tda7419.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/tda7419.txt b/Documentation/devicetree/bindings/sound/tda7419.txt
> new file mode 100644
> index 000000000000..919318315600
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tda7419.txt
> @@ -0,0 +1,15 @@
> +TDA7419 audio processor
> +
> +This device supports I2C only.
> +
> +Required properties:
> +
> +- compatible : "st,tda7419"
> +- reg : the I2C address of the device.

For completeness:

st,mute-gpios for MUTE pin?

vdd-supply?

> +
> +Example:
> +
> +ap: tda7419@44 {
> +	compatible = "st,tda7419";
> +	reg = <0x44>;
> +};
> -- 
> 2.11.0
> 
