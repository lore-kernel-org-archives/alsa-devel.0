From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v4 3/3] ASoC: fsl: add imx-es8328 machine
	driver
Date: Thu, 19 Jun 2014 15:27:37 +0100
Message-ID: <20140619142737.GD3412@opensource.wolfsonmicro.com>
References: <1403063242-20840-1-git-send-email-xobs@kosagi.com> <1403063242-20840-4-git-send-email-xobs@kosagi.com> <20140618100233.GE5099@sirena.org.uk> <53A1687C.9010705@kosagi.com> <20140618103111.GH5099@sirena.org.uk> <53A23E1B.3070008@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53A23E1B.3070008-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 19, 2014 at 09:34:19AM +0800, Sean Cross wrote:
> On 06/18/14 18:31, Mark Brown wrote:
> > On Wed, Jun 18, 2014 at 06:22:52PM +0800, Sean Cross wrote:
> >> On 06/18/14 18:02, Mark Brown wrote:
> >>> No, this is broken.  The CODEC should request its own supplies which
> >>> need to correspond to the supplies the physical device has and failing
> >>> to get the supplies should be a fatal error unless the device works
> >>> without power (in which case why bother enablin them at all?).
> >> Not all codecs have power supplies.  Most don't, in fact, it's just this
> > The manufactuers of those that don't are being awfully quiet about what
> > sounds like a rather impressive feature...
> >
> >> Additionally, since the regulator is external to the codec (as it
> >> physically cuts 3.3V from the power supply), it doesn't make sense to
> >> put it in the codec driver.
> > I'm not sure you've quite understood what the regulator API is there
> > for.
> I'm having trouble understanding where the separating line is between
> machine drivers and codec drivers.  A random sampling of codec drivers
> doesn't yield any drivers grabbing their own power switches.  Is that an
> oversight?  Should every codec driver include at least one regulator to
> describe its power source?
> 
> If you like, I can move the regulator from the machine driver to the
> codec driver, and make it non-optional.  But we've done designs in the
> past where it just hangs off the 3.3V rail where it's non-switchable,
> and the concept of describing a regulator seemed overkill.
> 
> 
> Sean
> 

I think for your power switch you should be able to use the
existing gpio regulator binding, so you shouldn't need to
actually write any code.

Take for example wm2200.c, this registers two supplies for the
CODEC through DAPM:

SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20, 0),
SND_SOC_DAPM_REGULATOR_SUPPLY("AVDD", 20, 0),

These are then hooked up to whatever parts of the CODEC require
power from them. CPVDD powers the charge pumps so is only hooked
up to those, AVDD is the main analogue power for the chip so is
needed whenever the CODEC is up, for such supplies one approach
is to just to hook them up to all the CODEC inputs and outputs,
which is what we do here.

You mention that your power gate might only exist on some
hardware. This hardware differences are what device tree is there
to describe. So lets say your CODEC has a main power supply called
AVDD as in my example above:

codec_pwr: regulator@0 {
	compatble = "regulator-fixed";

	... fixed regulator stuff ...
};

codec_pwr_switch: regulator@0 {
	compatible = "regulator-gpio";

	... regulator gpio stuff ...
};

/* Board with switch */
codec: es8328@11 {
       compatible = "es8328";
       reg = <0x11>;
	AVDD-supply = <&codec_pwr_switch>;
};

/* Board without switch */
codec: es8328@11 {
       compatible = "es8328";
       reg = <0x11>;
	AVDD-supply = <&codec_pwr>;
};

Thanks,
Charles

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
