From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: Multiple DA9055 chips
Date: Tue, 2 Jul 2013 16:37:34 +0530
Message-ID: <1372763254.2770.29.camel@matrix>
References: <20130701164833.GL27646@sirena.org.uk>
	 <1372757513.28415.2.camel@matrix> <20130702093130.GX27646@sirena.org.uk>
	 <1372759357.29900.3.camel@matrix>  <20130702103101.GH27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130702103101.GH27646@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: David Dajun Chen <david.chen@diasemi.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2013-07-02 at 11:31 +0100, Mark Brown wrote:
> On Tue, Jul 02, 2013 at 03:32:37PM +0530, Ashish Chavan wrote:
> 
> > > OK, in that case the CODEC driver is just plain broken then.  Did anyone
> > > actually test this stuff?  Please fix.
> 
> > Yes, I think so. Actually the CODEC driver was merged before PMIC ino
> > main line and was tested at that time. I will check with PMIC team if
> > they did test with CODEC.
> 
> > I guess the fix should be in PMIC, right?
> 
> Both drivers need to be changed.

OK. We will fix both of them.
Thanks for pointing this out.
