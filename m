From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v9 3/4] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Fri, 9 Jan 2015 11:48:12 +0000
Message-ID: <20150109114812.GI12302@n2100.arm.linux.org.uk>
References: <cover.1420628786.git.moinejf@free.fr>
 <23b36acc1f769418a06f3e929eba288b5911da12.1420628786.git.moinejf@free.fr>
 <54AD4C77.5000401@arm.com>
 <20150107154138.GL12302@n2100.arm.linux.org.uk>
 <20150107190241.27ebac8b@armhf>
 <54AFAC4C.7010209@ti.com>
 <20150109111935.GF12302@n2100.arm.linux.org.uk>
 <20150109124531.493bece4@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150109124531.493bece4@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 09, 2015 at 12:45:31PM +0100, Jean-Francois Moine wrote:
> On Fri, 9 Jan 2015 11:19:35 +0000
> Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> 
> > Would it be more sensible to make SND_SOC_TDA998X depend on
> > DRM_I2C_NXP_TDA998X instead, maybe with a 'default y' - which is a
> > kinder way to have SND_SOC_TDA998X be enabled.  If SND_SOC_TDA998X
> > doesn't have a prompt, then it'll automatically enable itself too
> > this way when all its dependencies are satisfied.
> 
> You are right, I will set back the way I had in the version 3:
> 
> > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > index b33b45d..747e387 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -352,6 +352,12 @@ config SND_SOC_STAC9766
> >  config SND_SOC_TAS5086
> >  	tristate
> >  
> > +config SND_SOC_TDA998X
> > +	tristate
> > +	default y if DRM_I2C_NXP_TDA998X=y
> > +	default m if DRM_I2C_NXP_TDA998X=m
> > +

An easier way to write this is:

	config SND_SOC_TDA998X
		def_tristate y
		depends on DRM_I2C_NXP_TDA998X

That's because internally, Kconfig knows how to do ternary operations.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
