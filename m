From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 02/11] IIO: Add DT bindings for sigma delta adc
 modulator
Date: Fri, 24 Mar 2017 09:21:32 -0500
Message-ID: <20170324142131.cm72er2cc2kggxco@rob-hp-laptop>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-3-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489759704-30217-3-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 17, 2017 at 03:08:15PM +0100, Arnaud Pouliquen wrote:
> Add documentation of device tree bindings to support
> sigma delta modulator in IIO framework.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
> ---
> V2 -> V3 :
> 	-Rename to suppress "simple"
>         - add "ads1201" compatibility
>  
>  .../devicetree/bindings/iio/adc/sigma-delta-modulator.txt   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> new file mode 100644
> index 0000000..27f04a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> @@ -0,0 +1,13 @@
> +Device-Tree bindings for sigma delta modulator
> +
> +Required properties:
> +- compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
> +	as a generic SD modulator if modulator not specified in compatible list.
> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
> +
> +Example node:
> +
> +	ads1202: simple_sd_adc@0 {

adc@...

With that,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> +		compatible = "sd-modulator";
> +		#io-channel-cells = <1>;
> +	};
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
