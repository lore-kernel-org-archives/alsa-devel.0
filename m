From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Add ESAI CPU DAI driver
Date: Fri, 10 Jan 2014 21:03:39 +0800
Message-ID: <20140110130338.GA17392@MrMyself>
References: <1389265078-16256-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140109184453.GP12858@sirena.org.uk>
 <20140110023252.GA16467@MrMyself>
 <20140110023537.GB16467@MrMyself>
 <20140110120439.GG29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140110120439.GG29039@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: timur@tabi.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, shawn.guo@linaro.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

I just received the 'applied' mail. But still want to confirm this topic to
see how to refine the driver in the step ahead.

On Fri, Jan 10, 2014 at 12:04:39PM +0000, Mark Brown wrote:
> On Fri, Jan 10, 2014 at 10:35:39AM +0800, Nicolin Chen wrote:
> 
> > Resent this because of losing attached file.
> 
> I don't think your previous mail got sent at all, or at least it must've
> been caught by spam filters here...
> 
> > On Fri, Jan 10, 2014 at 10:32:52AM +0800, Nicolin Chen wrote:
> > > On Thu, Jan 09, 2014 at 06:44:53PM +0000, Mark Brown wrote:
> 
> > > > Why does the machine driver have to do this by hand, being able to
> > > > override is fine but having sensible defaults is easier?  Or does it
> > > > actually do that and the comment just needs updating?
> 
> > > The divider part of ESAI is pretty complicated due to caring about three
> > > configure bits - ETO, ETI, HCKD. (I've attached a diagram to this mail.)
> > > So setting sysclk() alone is not enough to take care all the configurations.
> > > That's why I designed these two interfaces at the first place. And it should
> > > be hard to find a default situation.
> 
> Why is the machine driver going to be able to come up with a sensible
> configuration then?  It's OK to support overriding the configuration
> where needed, my concern is about providing a default.
> 
> > > But there is one approach to omit this calling for machine driver is to do
> > > the set_bclk_ratio() at this CPU DAI driver. And this might be a good idea
> > > because we can then separate the settings between PLAYBACK and CAPTURE, even
> > > though we might then need to check the Master or Slave state to apply the
> > > settings accordingly.
> 
> This is about what I'd expect but then surely the next step is for the
> driver to choose a defualt BCLK ratio - that's how most drivers work,
> they try to generate the exact rate that is needed to clock the data.

Does that mean I should call set_bclk() once in the startup() when !active
to set a default bit clock rate to suit a common sample rate like 44100Hz?
I'm a bit confused if so. Because the driver would call set_bclk() any way
in the hw_params().

But your suggestion just reminds me of the slave mode in SSI driver as
default mode. And I should patch ESAI to slave mode for default as well,
shouldn't I?

> Are the bit clock shared between playback and capture?
Only shared in synchronous mode and totally individual in asynchronous mode.
Each of them can have their own HCK(MCLK) from different sources and derive
their own SCK(BCLK).

Thank you,
Nicolin


