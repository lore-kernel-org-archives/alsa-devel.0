From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: add support for the Freescale /
 iVeia P1022 RDK reference board
Date: Tue, 18 Sep 2012 23:12:10 -0400
Message-ID: <20120919031209.GS8832@opensource.wolfsonmicro.com>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
 <1347657278-25295-5-git-send-email-timur@freescale.com>
 <20120919023259.GB8832@opensource.wolfsonmicro.com>
 <6AE080B68D46FC4BA2D2769E68D765B70805EFB4@039-SN2MPN1-023.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9BF2F26514D
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 05:12:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B70805EFB4@039-SN2MPN1-023.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 19, 2012 at 02:47:48AM +0000, Tabi Timur-B04825 wrote:
> Mark Brown wrote:
> > On Fri, Sep 14, 2012 at 04:14:38PM -0500, Timur Tabi wrote:

> >>   sound/soc/fsl/Kconfig     |   14 ++
> >>   sound/soc/fsl/Makefile    |    4 +
> >>   sound/soc/fsl/p1022_rdk.c |  455 +++++++++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 473 insertions(+), 0 deletions(-)
> >>   create mode 100644 sound/soc/fsl/p1022_rdk.c

> > This adds a new device tree binding so it should be documented.

> It does?  Where?  It uses the same binding as p1022_ds.c.

It's adding a new machine driver, that generally means a new binding.
If it's really an identical binding then it ought to at least add a new
compatible property to the existing binding (and extend the set of
supported CODECs for that binding).

Personally given the thing with the interface formats and the fact that
it's not sharing code with the other bindings for implementation of the
binding I'd be inclined to just document it as a new binding and use it
as the model going forwards, leaving the older bindings as legacy.

> >> +	/* Tell the WM8960 to set SYSCLK equal to MCLK input (bypass PLL) */
> >> +	ret = snd_soc_dai_set_clkdiv(rtd->codec_dai, WM8960_SYSCLKDIV,
> >> +		WM8960_SYSCLK_MCLK | WM8960_SYSCLK_DIV_1);
> >> +	if (ret < 0) {
> >> +		dev_err(dev, "could not set codec driver clock source\n");
> >> +		return ret;
> >> +	}

> > ...we don't appear to use the PLL output anyway so why not just leave it
> > off?  As this is fixed it's better style to do the setup in late_init()
> > or the init function for the DAI link.

> I just copied this code from iVeia BSP.  I'm not really sure what it does.

You should just be able to drop the call to set_pll(), I expect you'll
find that all it does is consume extra power.

> > Also we should log the return codes when we log failures.

> You mean like this:

> if (ret < 0) {
> 	dev_err(dev, "could not set codec driver clock source (ret=%i)\n", ret);
> 	return ret;
> }

Yes.

> I almost never do this, and there are plenty of cases in my existing code 
> where I don't.  Is this a new policy?

It's not new, it's always been good practice - if something fails we
should do as much as possible to tell the user why.

> >> +	if (strcasecmp(sprop, "i2s-slave") == 0) {
> >> +		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
> >> +			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM;
> >> +		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
> >> +		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;

> > Why would this be something that individual systems would want to
> > change, and if it is something it's useful to vary why not at runtime?
> > I suspect the best thing here is just to pick a format and use it, if
> > there is a reason to vary this it's probably a higher level thing.

> This is the same code as my other two machine drivers that I've been using 
> for years.  It's part of the SSI binding.  Do you want me to change the 
> binding and drop the properties?

Well, the existing bindings are out there so can't really be changed but
we should do something better going forwards.

> I understand what you're saying, and you're probably right that it's not 
> really a configuration option.  But it's a change in the binding, so I 
> can't just drop it here.  I have to fix the other two machine drivers.

Like I said above it looks awfully like a new binding to me.
