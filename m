From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: kirkwood: clk: probe defer when clock not
	yet ready
Date: Sat, 21 Sep 2013 11:51:52 +0100
Message-ID: <20130921105151.GK12758@n2100.arm.linux.org.uk>
References: <20130921120006.47b00fe7@armhf> <20130921104734.GJ12758@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130921104734.GJ12758-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 21, 2013 at 11:47:34AM +0100, Russell King - ARM Linux wrote:
> Another comment.  This is broken - it will never fall through if a
> 'dev' is given, because of_clk_get_by_name() will always return an
> -EPROBE_DEFER error pointer in that case.
> 
> So this approach is unworkable.

And another comment:

This whole approach is broken - while Mark is correct that we should
find a way to return -EPROBE_DEFER if a clock is specified, the solution
here does not allow that - it will return -EPROBE_DEFER whenever the
clock is not found _or_ is not specified.

This has the effect of making the external clock *non*optional for the
kirkwood-i2s driver, which is also completely broken.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
