From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: add TA5720 digital amplifier DT
 bindings
Date: Mon, 21 Mar 2016 07:45:55 -0500
Message-ID: <20160321124555.GA12693@rob-hp-laptop>
References: <1458343678-4086-1-git-send-email-dannenberg@ti.com>
 <1458343678-4086-2-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458343678-4086-2-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2016 at 06:27:57PM -0500, Andreas Dannenberg wrote:
> The Texas Instruments TAS5720L/M device is a high-efficiency mono
> Class-D audio power amplifier optimized for high transient power
> capability to use the dynamic power headroom of small loudspeakers.
> Its digital time division multiplexed (TDM) interface enables up to
> 16 devices to share the same bus.
> 
> Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/tas5720.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas5720.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/tas5720.txt b/Documentation/devicetree/bindings/sound/tas5720.txt
> new file mode 100644
> index 0000000..3775a3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas5720.txt
> @@ -0,0 +1,37 @@
> +Texas Instruments TAS5720 Mono Audio amplifier
> +
> +The TAS5720 serial control bus communicates through the I2C protocol only.
> +
> +Required properties:
> +
> +- compatible : "ti,tas5720"
> +- reg : I2C slave address
> +
> +Optional properties:
> +
> +- dvdd-supply : phandle to a 3.3-V supply for the digital circuitry
> +- pvdd-supply : phandle to a supply used for the Class-D amp and the analog
> +- interrupts-extended : reference to a GPIO pin connected to the TAS5720
> +                        FAULTZ pin for error reporting purposes

There's no point in having interrupts-extended here with a single 
interrupt. It is fine to use, but really that's outside the scope of 
this binding. So I'd just document "interrupts" here as that is what 
most docs do, and that implies interrupts-extended could be used.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
