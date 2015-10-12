From: Pavel Machek <pavel@ucw.cz>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Mon, 12 Oct 2015 22:11:38 +0200
Message-ID: <20151012201137.GA7317@amd>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd>
 <20151012154715.GF4238@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151012154715.GF4238@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

On Mon 2015-10-12 16:47:15, Mark Brown wrote:
> On Mon, Oct 12, 2015 at 11:00:45AM +0200, Pavel Machek wrote:
> 
> > Does this look like a step in right direction?
> 
> >  static const struct regulator_desc arizona_ldo1_hc = {
> > -	.name = "LDO1",
> 
> No, you definitely shouldn't be doing this - the regulator names should
> reflect the names the device has in the datasheet to aid people in going
> from software to the hardware and back again.  They shouldn't be
> dynamically generated at runtime.  If you need to namespace by
device

They already are, see wm831x-ldo.c .

> provide an interface which explicitly namespaces by device rather than
> hacking it into another interface, the usual thing is to use the struct
> device as the context.

I'll need some more help here. I need to use it from ALSA, so I don't
think I can influence that interface easily.

What is currently in tree _does not work_, as there are two arizona
chips, and two "LDO1" regulators. (Doable) suggestions how to fix that
are welcome.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
