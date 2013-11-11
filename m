From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] dt: binding: sound cs42l52 driver
Date: Mon, 11 Nov 2013 10:16:22 +0000
Message-ID: <20131111101621.GB21201@e106331-lin.cambridge.arm.com>
References: <1383855737-8499-1-git-send-email-brian.austin@cirrus.com>
 <1383855737-8499-2-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1383855737-8499-2-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 07, 2013 at 08:22:17PM +0000, Brian Austin wrote:
> Add Device Tree Binding for the CS42L52 Codec
> 
> Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/cs42l52.txt          | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cs42l52.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/cs42l52.txt b/Documentation/devicetree/bindings/sound/cs42l52.txt
> new file mode 100644
> index 0000000..7540198
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cs42l52.txt
> @@ -0,0 +1,34 @@
> +CS42L52 audio CODEC
> +
> +Required properties:
> +
> +  - compatible : "cirrus,cs42l52"
> +
> +  - reg : the I2C address of the device for I2C
> +
> +Optional properties:
> +
> +  - reset_gpio : a GPIO spec for the reset pin.

Nit: device tree convention is to use '-' rather than '_'. So this
should be reset-gpio rather than reset_gpio.

s/_/-/ for the later property names too.

s/GPIO spec/phandle + gpio-specifier/

> +  - chgfreq    : Charge Pump Frequency values 0x00-0x0F

In general, longer but more easily understood names are preferred (e.g.
"clock-frequency"). This could be "charge-pump-frequency".

When you say "values 0x00-0x0F" you mean the value is in that range?
Inclusive?

Due to punctuation, upon first reading I read this as being an array of
values.  It would be nice to have some clarification to prevent others
maknig the smae mistake.

> +  - mica_sel   : MIC A single ended input select MIC1/MIC2
> +  - micb_sel   : MIC B single ended input select MIC1/MIC2

Is this a boolean? What values are expected?

Could you elaborate on what this describes?

> +  - mica_cfg   : MIC A single-ended or differential select
> +  - micb_cfg   : MIC A single-ended or differential select

Could you elaborate on what these describe, what values are expected,
etc?

> +  - micbias_lvl: Set the output voltage level on the MICBIAS Pin
> +		 0x00 = 0.5 x VA
> +		 0x01 = 0.6 x VA
> +		 0x02 = 0.7 x VA
> +		 0x03 = 0.8 x VA
> +		 0x04 = 0.83 x VA
> +		 0x05 = 0.91 x VA

Is this not something we'd want to change at runtime instead? Why does
this need to be in the dt?

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
