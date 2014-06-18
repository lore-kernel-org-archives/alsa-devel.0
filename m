From: "S. Fricke" <silvio.fricke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 2/8] ASoC: core: Generic ac97 link reset functions
Date: Wed, 18 Jun 2014 20:42:34 +0200
Message-ID: <20140618184234.GA27312@sfrouter>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376924761-4054-3-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


Hi Markus,

I'm fighting with your ac97 pinctrl configuration per dts. 

> [...]
> +ssi {
> +	...
> +
> +	pinctrl-names = "default", "ac97-running", "ac97-reset", "ac97-warm-reset";
> +	pinctrl-0 = <&ac97link_running>;
> +	pinctrl-1 = <&ac97link_running>;
> +	pinctrl-2 = <&ac97link_reset>;
> +	pinctrl-3 = <&ac97link_warm_reset>;
> +	ac97-gpios = <&gpio3 20 0 &gpio3 22 0 &gpio3 28 0>;

I see here the gpios for sync, sdata and reset. On my board I have two sdata
lines (sdata-in and sdata-out) which line should I specify here for this setting?

Thanks for a short answer and
Cheers, Silvio


-- 
-- S. Fricke ---------------------------------------- silvio-lOxvEG+uzzjk1uMJSBkQmQ@public.gmane.org --
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
