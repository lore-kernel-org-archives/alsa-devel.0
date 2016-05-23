From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC-PATCH 0/2] ASoC: simple_card: support for hw-params rules
Date: Mon, 23 May 2016 18:18:54 +0100
Message-ID: <20160523171854.GJ4976@leverpostej>
References: <1463747445-14167-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463747445-14167-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 20, 2016 at 12:30:43PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> 
> Simple_card does require under some circumstances the ability
> to configure certain hw_parameters based on clocks, bits, channels.
> 
> This patchset adds a generic way to configure these kind of things
> via the device tree easily. This patchset implements this
> for simple_card, but other drivers can just as easily make use of
> this.

I'm not familiar with the class of hardware here.

What exactly needs to be configured, under which situations?

How varied is this in practice?

Why does this make more sense than having individual drivers?

> For now we have the following matchers and actions:
> * matchers:
>   * match_sample_bits
>   * match_rate
>   * match_channels
> * actions:
>   * set_fixed_bclk_size
> 
> As a note: the available matching rules and action rules right now
> are hard-coded, but this could in principle get extended to be more
> dynamic via kallsyms_lookup_name that would lookup the requested
> symbol and assume it is a struct asoc_generic_hw_params_method,
> on which it could apply several sanity-checks before using
> the pointers for real.

I'm hoping that's a joke. ;)

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
