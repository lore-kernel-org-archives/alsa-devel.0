From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 1/2] ASoC: add es8328 codec driver
Date: Tue, 17 Jun 2014 17:00:13 +0100
Message-ID: <20140617160013.GD8930@leverpostej>
References: <1402997571-1255-1-git-send-email-xobs@kosagi.com>
 <1402997571-1255-2-git-send-email-xobs@kosagi.com>
 <20140617104639.GD26741@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140617104639.GD26741-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org" <bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 17, 2014 at 11:46:39AM +0100, Charles Keepax wrote:
> On Tue, Jun 17, 2014 at 05:32:50PM +0800, Sean Cross wrote:
> > Add a codec driver for the Everest ES8328.  It supports two separate audio
> > outputs and two separate audio inputs.
> > 
> > Signed-off-by: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/sound/es8328.txt |  18 +
> >  sound/soc/codecs/Kconfig                           |  13 +
> >  sound/soc/codecs/Makefile                          |   6 +
> >  sound/soc/codecs/es8328-i2c.c                      |  55 ++
> >  sound/soc/codecs/es8328-spi.c                      |  44 ++
> >  sound/soc/codecs/es8328.c                          | 625 +++++++++++++++++++++
> >  sound/soc/codecs/es8328.h                          | 313 +++++++++++
> >  7 files changed, 1074 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/es8328.txt
> >  create mode 100644 sound/soc/codecs/es8328-i2c.c
> >  create mode 100644 sound/soc/codecs/es8328-spi.c
> >  create mode 100644 sound/soc/codecs/es8328.c
> >  create mode 100644 sound/soc/codecs/es8328.h
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/es8328.txt b/Documentation/devicetree/bindings/sound/es8328.txt
> > new file mode 100644
> > index 0000000..488bc32
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/es8328.txt
> > @@ -0,0 +1,18 @@
> > +Everest ES8328 audio CODEC
> > +
> > +This device supports both I2C and SPI (configured with pin strapping
> > +on the board).
> > +
> > +Required properties:
> > +
> > +  - compatible : "es8328"
> 
> I suspect the vendor prefix will be mandatory.

Yes.

There doesn't seem to be a prefix for Everest in vendor-prefixes.txt,
Sean could you please add one as part of this series?

Cheers,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
