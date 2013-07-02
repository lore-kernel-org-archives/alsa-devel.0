From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: Multiple DA9055 chips
Date: Tue, 2 Jul 2013 15:32:37 +0530
Message-ID: <1372759357.29900.3.camel@matrix>
References: <20130701164833.GL27646@sirena.org.uk>
	 <1372757513.28415.2.camel@matrix>  <20130702093130.GX27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130702093130.GX27646@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: David Dajun Chen <david.chen@diasemi.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2013-07-02 at 10:31 +0100, Mark Brown wrote:
> On Tue, Jul 02, 2013 at 03:01:53PM +0530, Ashish Chavan wrote:
> > On Mon, 2013-07-01 at 17:48 +0100, Mark Brown wrote:
> > > It seems we have two drivers in mainline for da9055 on I2C.  We've got
> > > one in sound/soc/codecs/da9055.c and one in drivers/mfd/da9055-i2c.c,
> > > both registering themselves identically.  What's going on here?  Is this
> > > a combined CODEC and PMIC, has someone decided to release two chips with
> > > the same name or is one of the drivers misnamed?
> 
> > Yes, this is a combined CODEC and PMIC.
> 
> OK, in that case the CODEC driver is just plain broken then.  Did anyone
> actually test this stuff?  Please fix.

Yes, I think so. Actually the CODEC driver was merged before PMIC ino
main line and was tested at that time. I will check with PMIC team if
they did test with CODEC.

I guess the fix should be in PMIC, right?
