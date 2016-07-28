From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5659: Add mclk controls
Date: Thu, 28 Jul 2016 13:51:08 -0700
Message-ID: <20160728205107.GA6804@Asurada-Nvidia>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <579A6DCC.6060401@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <579A6DCC.6060401-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 28, 2016 at 10:40:44PM +0200, Lars-Peter Clausen wrote:
> > +	/* Check if MCLK provided */
> > +	rt5659->mclk = devm_clk_get(&i2c->dev, "mclk");
> > +	if (IS_ERR(rt5659->mclk)) {
> > +		if (PTR_ERR(rt5659->mclk) == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> 
> The correct thing to do here is to check if != -ENOENT and then return
> the error code. Otherwise you silently ignore errors if a clock was
> specified, but there was an error requesting it.

Oh..Thanks for the input. Will refine it in v2.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
