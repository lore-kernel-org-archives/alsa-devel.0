From: Pavel Machek <pavel@ucw.cz>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Mon, 16 Nov 2015 08:45:34 +0100
Message-ID: <20151116074534.GA5606@amd>
References: <20151012201137.GA7317@amd>
 <20151013115355.GC14956@sirena.org.uk>
 <20151113215812.GA19020@amd>
 <20151113225355.GU12392@sirena.org.uk>
 <20151114074400.GA7898@amd>
 <20151114123931.GW12392@sirena.org.uk>
 <20151114175915.GA20429@amd>
 <20151114184940.GY12392@sirena.org.uk>
 <20151114211633.GE20429@amd>
 <20151115001402.GZ12392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151115001402.GZ12392@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

> > > > Well, mfd_core.c seems to call regulator_bulk_register_supply_alias()
> > > > with device that does not have dev_name initialized.
> 
> > > OK, that'll be the problem then - we're not mapping the supply into the
> > > individual child device but rather system wide, probably because that
> > > mapping is being done too early, before we've actually created the
> > > device.
> 
> > Take a look at mfd_add_device(). Yes, we do
> > regulator_bulk_register_supply_alias() before doing
> > platform_device_add().
> 
> Looking at this I suspect we need to re-add the code for matching
> regulators on the actual struct device and do that since this is going
> to be very error prone.

Well, I guess I can test the patches :-).

> > > So if you look at this just templates out some boilerplate regulator API
> > > client code which calls regulator_get() like any other client and then
> > > hooks that regulator into the audio power management.
> 
> > Ok, so SND_SOC_DAPM_REGULATOR_SUPPLY() does not work, because I have
> > two regulators, right? Is there similar macro I can use?
> 
> No?  What would make you say that?

Well.. the fact that in my setup regulators are global (by mistake as
you say?) and it still picks them up without warning?

Plus, I'd expect to see some kind of "struct device" argument to
SND_SOC_DAPM_REGULATOR_SUPPLY(). I'm selecting supply name, but I'm
not selecting on which device...

> Every single sound driver gets this right, none of them assume the name
> is global.  What makes you say that they assume names are global?

Ok, so you are saying that if I fix mfd initialization, sound will
automagically switch from global regulators to device-specific
regulators and things will start working?

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
