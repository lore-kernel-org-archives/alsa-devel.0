From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RESEND RFC PATCH 2/3] ASoC: mediatek: Add AFE connection control
Date: Mon, 20 Apr 2015 06:50:17 +0200
Message-ID: <20150420045017.GI6325@pengutronix.de>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-3-git-send-email-koro.chen@mediatek.com>
 <20150418173740.GF26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150418173740.GF26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 18, 2015 at 06:37:40PM +0100, Mark Brown wrote:
> On Fri, Apr 10, 2015 at 04:14:08PM +0800, Koro Chen wrote:
> 
> > +/*
> > + * The MTK AFE unit has a audio interconnect with MTK_AFE_INTERCONN_NUM_INPUT
> > + * inputs and MTK_AFE_INTERCONN_NUM_OUTPUT outputs. Below table holds the
> > + * register/bits to set to connect an input with an output.
> > + */
> > +static const struct mtk_afe_connection
> > +	connections[MTK_AFE_INTERCONN_NUM_INPUT][MTK_AFE_INTERCONN_NUM_OUTPUT] = {
> > +	[0][0] =   { .creg = 0x020, .cshift =  0, .sreg = 0x020, .sshift = 10},
> > +	[0][1] =   { .creg = 0x020, .cshift = 16, .sreg = 0x020, .sshift = 26},
> 
> What are the constraints on using this - is it one input to one output
> only or can we do mixing or duplication?  The register interface
> definitely does look like something asking for runtime configuration.
> 
> It'd also be nice to have less magic numbers in the table, at least for
> the indexes (which I guess correspond to some of the defines in the
> headers)?

With defines the above two lines would become something like:

#define AFE_CONN0		0x20

#define CONN0_I00_O00_S		0
...
#define CONN0_I00_O00_R		10
...
#define CONN0_I00_O01_s		16
...
#define CONN0_I00_O01_S		26

[0][0] = { .creg = AFE_CONN0, .cshift = CONN0_I00_O00_S, .sreg = AFE_CONN0, .sshift = CONN0_I00_O00_R },
[0][1] = { .creg = AFE_CONN0, .cshift = CONN0_I00_O01_S, .sreg = AFE_CONN0, .sshift = CONN0_I00_O01_S },

For the registers we could use defines, but I think using defines for
the shifts doesn't add much value given they are only used once.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
