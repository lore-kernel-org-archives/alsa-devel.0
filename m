From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Add ESAI CPU DAI driver
Date: Fri, 10 Jan 2014 23:48:25 +0800
Message-ID: <20140110154824.GA17609@MrMyself>
References: <1389265078-16256-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140109184453.GP12858@sirena.org.uk>
 <20140110023252.GA16467@MrMyself>
 <20140110023537.GB16467@MrMyself>
 <20140110120439.GG29039@sirena.org.uk>
 <20140110130338.GA17392@MrMyself>
 <20140110132642.GM29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140110132642.GM29039@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: timur@tabi.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, shawn.guo@linaro.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 10, 2014 at 01:26:42PM +0000, Mark Brown wrote:
> On Fri, Jan 10, 2014 at 09:03:39PM +0800, Nicolin Chen wrote:
> > On Fri, Jan 10, 2014 at 12:04:39PM +0000, Mark Brown wrote:
> 
> > > This is about what I'd expect but then surely the next step is for the
> > > driver to choose a defualt BCLK ratio - that's how most drivers work,
> > > they try to generate the exact rate that is needed to clock the data.
> 
> > Does that mean I should call set_bclk() once in the startup() when !active
> > to set a default bit clock rate to suit a common sample rate like 44100Hz?
> > I'm a bit confused if so. Because the driver would call set_bclk() any way
> > in the hw_params().
> 
> Right, any choice here needs to be deferred to hw_params() as you say.
> 
> > But your suggestion just reminds me of the slave mode in SSI driver as
> > default mode. And I should patch ESAI to slave mode for default as well,
> > shouldn't I?
> 
> master/slave selection is kind of orthogonal here - the two bits of
> information that are normally needed are the MCLK to use (and its rate)
> and the sample rate/format (which give you the BCLK that is needed).
> Normally it's then possible to caculate a divider which generates BCLK
> from MCLK.  Overriding is normally only needed if there are additional
> constraints on BCLK due to something like limitations in one of the
> devices or sample rates for the opposite direction if the BCLK is shared
> but LRCLK isn't.

I think I start to understand the point here: If a user only needs to playback
the default case - 44.1KHz for example, the driver can just configure all the
dividers once at the beginning, not every time, so that we can save further
register overriding operation or even complicated clock selection and divisor
calculation, which obviously makes the procedure clean and reduces the system
loading even if it might be just in a slight level.

Is this the reason, or maybe one of the reasons, to the defaults providing?

Thank you,
Nicolin Chen
