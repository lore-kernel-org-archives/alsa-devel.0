From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 02/15] ASoC: sun4i-i2s: Add set_tdm_slot functionality
Date: Wed, 14 Aug 2019 10:30:11 +0100
Message-ID: <20190814093011.GD4640@sirena.co.uk>
References: <20190814060854.26345-1-codekipper@gmail.com>
 <20190814060854.26345-3-codekipper@gmail.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBJNJZ7VAKGQE5BO6OUY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190814060854.26345-3-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Wed, Aug 14, 2019 at 08:08:41AM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Codecs without a control connection such as i2s based HDMI audio and
> the Pine64 DAC require a different amount of bit clocks per frame than

This isn't a universal property of CODECs without a control, and it's
something that CODECs with control can require too.

>  	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
> -				      params_width(params));
> +				      i2s->tdm_slots ?
> +				      i2s->slot_width : params_width(params));

Please write normal conditional statements unless there's a strong
reason to do otherwise, it makes things more legible.

> +static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
> +				      unsigned int tx_mask,
> +				      unsigned int rx_mask,
> +				      int slots, int width)
> +{
> +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +
> +	i2s->tdm_slots = slots;
> +
> +	i2s->slot_width = width;
> +
> +	return 0;
> +}

No validation of the parameters here?
--/3yNEOqWowh/8j+e--
