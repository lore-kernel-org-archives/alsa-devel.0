From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 3/4] ASoC: tda998x: add DT documentation
Date: Mon, 27 Jan 2014 20:45:34 +0000
Message-ID: <20140127204534.GB15937@n2100.arm.linux.org.uk>
References: <cover.1390813480.git.moinejf@free.fr> <22fafd7e11771ffc25c84ff609d18039f07b7295.1390813481.git.moinejf@free.fr> <20140127204302.GY11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140127204302.GY11841-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 27, 2014 at 08:43:02PM +0000, Mark Brown wrote:
> On Mon, Jan 27, 2014 at 09:34:49AM +0100, Jean-Francois Moine wrote:
> 
> > +	- compatible: must be "nxp,tda998x-codec".
> > +	- audio-ports: one or two values.
> > +		The first value defines the I2S input port.
> > +		The second one, if present, defines the S/PDIF input port.
> 
> I take it these are port numbers on the device and it's not possible to
> do something like having multiple I2S ports?

You can feed it with multiple synchronised I2S streams for the additional
channels.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
