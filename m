From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: sound: Add DT bindings for Broadcom
 Cygnus audio
Date: Mon, 9 Nov 2015 10:32:30 -0600
Message-ID: <20151109163230.GA10001@rob-hp-laptop>
References: <1446862965-18667-1-git-send-email-ssimran@broadcom.com>
 <1446862965-18667-2-git-send-email-ssimran@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446862965-18667-2-git-send-email-ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simran Rai <ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arun Parameswaran <arunp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 06, 2015 at 06:22:43PM -0800, Simran Rai wrote:
> Add bindings for audio driver in Broadcom Cygnus.
> 
> Signed-off-by: Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Simran Rai <ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>


> ---
>  .../bindings/sound/brcm,cygnus-audio.txt           |   54 ++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
> new file mode 100644
> index 0000000..3c06001
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
> @@ -0,0 +1,54 @@
> +BROADCOM Cygnus Audio I2S/TDM/SPDIF controller
> +
> +Required properties:
> +	- compatible : "brcm,cygnus-audio"
> +	- #address-cells: 32bit valued, 1 cell.
> +	- #size-cells:  32bit valued, 0 cell.
> +	- reg : Should contain audio registers location and length
> +	- reg-names: names of the registers listed in "reg" property
> +		Valid names are "aud" and "i2s_in". "aud" contains a
> +		set of DMA, I2S_OUT and SPDIF registers. "i2s_in" contains
> +		a set of I2S_IN registers.
> +	- clocks: PLL and leaf clocks used by audio ports
> +	- clock-names: names of 3 leaf clocks used by audio ports
> +		Valid names are "ch0_audio", "ch1_audio", "ch2_audio"
> +	- interrupts: audio DMA interrupt number
> +
> +SSP Subnode properties:
> +- reg: The index of ssp port interface to use
> +	Valid value are 0, 1, 2, or 3 (for spdif)
> +
> +
> +Example:
> +	cygnus_audio: audio@180ae000 {
> +		compatible = "brcm,cygnus-audio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x180ae000 0xafd>, <0x180aec00 0x1f8>;
> +		reg-names = "aud", "i2s_in";
> +		clocks = <&audiopll BCM_CYGNUS_AUDIOPLL_CH0>,
> +				<&audiopll BCM_CYGNUS_AUDIOPLL_CH1>,
> +				<&audiopll BCM_CYGNUS_AUDIOPLL_CH2>;
> +		clock-names = "ch0_audio", "ch1_audio", "ch2_audio";
> +		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		ssp0: ssp_port@0 {
> +			reg = <0>;
> +			status = "okay";
> +		};
> +
> +		ssp1: ssp_port@1 {
> +			reg = <1>;
> +			status = "disabled";
> +		};
> +
> +		ssp2: ssp_port@2 {
> +			reg = <2>;
> +			status = "disabled";
> +		};
> +
> +		spdif: spdif_port@3 {
> +			reg = <3>;
> +			status = "disabled";
> +		};
> +	};
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
