From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: rt5659: Add mclk controls
Date: Thu, 28 Jul 2016 11:14:20 -0700
Message-ID: <20160728181419.GA4742@Asurada-Nvidia>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160728155732.GG11806-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 28, 2016 at 04:57:32PM +0100, Mark Brown wrote:
> > The codec driver should control the mclk. So this patch adds this support.
> 
> > +	/* Check if MCLK provided */
> > +	rt5659->mclk = devm_clk_get(&i2c->dev, "mclk");
> > +	if (IS_ERR(rt5659->mclk)) {
> > +		if (PTR_ERR(rt5659->mclk) == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +		/* Otherwise mark the mclk pointer to NULL */
> > +		rt5659->mclk = NULL;
> > +	}
> 
> This device seems to be used on x86 systems so we'll need to ensure that
> they register clocks for this.  They really should set this up using
> quirks keyed off DMI information or similar so it's hidden from other
> systems.

Hmm..the change defines this mclk as a optional property so I'm
not sure how it would affect x86 systems. (Would love to refine
it to make it impactless.) Since it's literally hidden, any way
that I can manually ensure it? Or just wait for an ack from x86
developers?

Thanks
Nicolin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
