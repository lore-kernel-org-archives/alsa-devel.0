From: Pavel Machek <pavel@ucw.cz>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Fri, 13 Nov 2015 22:58:12 +0100
Message-ID: <20151113215812.GA19020@amd>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd>
 <20151012154715.GF4238@sirena.org.uk>
 <20151012201137.GA7317@amd>
 <20151013115355.GC14956@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151013115355.GC14956@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue 2015-10-13 12:53:55, Mark Brown wrote:
> On Mon, Oct 12, 2015 at 10:11:38PM +0200, Pavel Machek wrote:
> > On Mon 2015-10-12 16:47:15, Mark Brown wrote:
> > > On Mon, Oct 12, 2015 at 11:00:45AM +0200, Pavel Machek wrote:
> 
> > > >  static const struct regulator_desc arizona_ldo1_hc = {
> > > > -	.name = "LDO1",
> 
> > > No, you definitely shouldn't be doing this - the regulator names should
> > > reflect the names the device has in the datasheet to aid people in going
> > > from software to the hardware and back again.  They shouldn't be
> > > dynamically generated at runtime.  If you need to namespace by
> > device
> 
> > They already are, see wm831x-ldo.c .
> 
> No, that's a different case where we actually have a repeatable IP we
> can enumerate multiple instances of on a single piece of silicon which
> has multiple variants available.  This is a single device with a single
> regulator on it.

Ok. But I'd still like to get it working.

Now... I got up-to v4.2 kernel, and it seems that it has support for
multiple sources with same name (but on different chips):

[    1.125485] Adding alias for supply MICVDD,(null) -> MICVDD,spi32766.1
[    1.285470] Adding alias for supply MICVDD,(null) -> MICVDD,spi32766.2

...but it does not look like I can use those aliases from the ALSA side:

[    2.734198] wm5102-codec.1 supply MICVDD,spi32766.1 not found, using dummy regulator
[    3.170912] wm5102-codec.2 supply MICVDD,spi32766.2 not found, using dummy regulator

I tried to do this:

SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD,spi32766.1", 0, SND_SOC_DAPM_REGULATOR_BYPASS),

Any idea what I did wrong, or what needs to be fixed?

> > > provide an interface which explicitly namespaces by device rather than
> > > hacking it into another interface, the usual thing is to use the struct
> > > device as the context.
> 
> > I'll need some more help here. I need to use it from ALSA, so I don't
> > think I can influence that interface easily.
> 
> Sorry?  If this is going into the userspace ABI there's something
> seriously wrong...

It is exposed to the ALSA. If ALSA exposes it to userspace, I'm not sure. 

> > What is currently in tree _does not work_, as there are two arizona
> > chips, and two "LDO1" regulators. (Doable) suggestions how to fix that
> > are welcome.
> 
> To repeat what I said above, provide an interface which namespaces by
> device (as we normally do when we need to distinguish between multiple
> instances of the same device).  Given that everything is part of the
> same device it's very easy to discover which device so it's clearly no
> problem when mapping the supplies.

I'm afraid I don't know how to do this. See above.

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
